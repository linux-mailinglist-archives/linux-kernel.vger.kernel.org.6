Return-Path: <linux-kernel+bounces-386006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA79C9B3E01
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 23:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B701F22EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4723B1E3DEE;
	Mon, 28 Oct 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LdUkDwb3"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21401E0B62
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730155715; cv=none; b=SPa3ePIPsA+wLOT+XAyKDie104p5cNsk3T5AufzmnpzSEzM7kc0o5YGSwNrEwlOOCMaJNgt8muqG7PnzHZ1s/z6s/lHTuGZvwIcTLo46BJGE5qlYR7iEpAc9yGYSOQws5zNEy4iL4sOgex3/cN0+jSqi8/TmVucD/z2Z8v8MGe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730155715; c=relaxed/simple;
	bh=pmlG57dgokv8C/W9ZqCyP/IDa+L22xXuqAQ89gdBPLI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mMnFwEYv1OZOtMeJkmQT2bo9VTpIuEbHFTbCFz84HjzRbHC5Ubxh8hCwTNHbzba+VpoFkzzUdT39jg10wtbm4oLEuQ7G8c2e6JeIUguT8Um1PMgWEIpsjl7sqKagyyKy6odQWeO0fZkIH9r5TE4dz/mEteClSNc0lWrE7Nu+S3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LdUkDwb3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730155692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDtLDtjXgNW64zonKXdumRRA5gIQqyPzaPz1kD7YML4=;
	b=LdUkDwb3jCcD5zD5qJ5BnIaCOu8ZApxzik+BoBs7O1cn2eQinsgfB/i8DIBPHVd/ZjpHqi
	tr2MAj8HmjVVqdN54d5uxXIAhFn+ST6wkzynbxCkErLhb028JUaJ7Yr4vYAG4j1old9uhH
	f3YJLmQ3WzATDD7ckIeTSg+VC+ivDuA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [RESEND PATCH] x86/sgx: Use vmalloc_array() instead of vmalloc()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <cd663aa6-28a1-4c03-9258-511285316c0f@intel.com>
Date: Mon, 28 Oct 2024 23:47:58 +0100
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 linux-sgx@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <393CAEF9-A79E-4399-B0F2-FA3BCAD46290@linux.dev>
References: <20241026113248.129659-1-thorsten.blum@linux.dev>
 <cd663aa6-28a1-4c03-9258-511285316c0f@intel.com>
To: "Huang, Kai" <kai.huang@intel.com>
X-Migadu-Flow: FLOW_OUT

On 28. Oct 2024, at 23:29, Huang, Kai wrote:
> On 27/10/2024 12:32 am, Thorsten Blum wrote:
>> Use vmalloc_array() instead of vmalloc() to calculate the number of
>> bytes to allocate.
>=20
> This says nothing about _why_.  Is it because we want to take =
advantage of the multiplication overflow check inside the =
vmalloc_array()?
>=20
> I don't know whether it is implied we should always use =
vmalloc_array() for array allocation like this, i.e., when we see =
vmalloc() is used for array allocation in the kernel we can just write a =
patch to replace it with vmalloc_array() and send to upstream.

It's discouraged to use open-coded arithmetic in allocator arguments:

=
https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-=
arithmetic-in-allocator-arguments

Happy to add this, but I assumed it's obvious.

