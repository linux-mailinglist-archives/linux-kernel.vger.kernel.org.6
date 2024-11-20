Return-Path: <linux-kernel+bounces-416333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB749D4368
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0264B24080
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4251BD03C;
	Wed, 20 Nov 2024 21:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rxi2KsHE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A5B2F2A;
	Wed, 20 Nov 2024 21:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732137106; cv=none; b=NaYhhYTBPmB+Mo/gM6fNSPX56yYHj01dbo3fUcjnxUvoZ/QoVfZo1OXPSOP3eMr8CmG2wykE4qSJuYu+FQcshgU2xRomSi7f9l5z/8omCfP7ifHyy8Qgj/8zyBDgUetaRLiU1xxAbB6cvhd2EPsIfd/VCHpA5c77sB5WhgLaDhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732137106; c=relaxed/simple;
	bh=7pJRmxO1u8eEwmWRZNdtpzdq6sNIRikpSIH+jMvvHgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0+blPp9sbyZjwf/YziPUg4RY+xbX65XtVAqfExLCB23B7Q1fF0cbgmGvvtgqSp2svlTZokbBpPSf/G1fOSj4RmzAM9Kfka6000nkSsI2z1jG9ZF3E4DET1wbj8txR0Gq/jPqf2qnbKKBT3p1UbEAQGzCFTZrkDzLN/LO1DEYnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Rxi2KsHE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 588B940E0261;
	Wed, 20 Nov 2024 21:11:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yuChkarT5bQV; Wed, 20 Nov 2024 21:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732137094; bh=QTtEZY+TKAT6hZ5bNVYUAcmAo2gvA6ITkuZ6lVDgMc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rxi2KsHEBwQ67H77XgaYMkX0Rk7ooFyc0zvI7lb/0pR8H4Rj/nkb3PlwZxyzwZ7IP
	 IUrsjxyexINEhOKsmj1jHPtGEpJuBkbi24JX7S1B2QmgRDyf6rFlTbCq/yA+0L4vpI
	 iSxwj/Rak/91zP3qoxkuP5wZt1iQX/kYf6R7sbtMiTT+Dfu6wo9vLUII4bjCHqZbRB
	 Vuf72hNaKvRVwwNAs4G7zizDclP0LIq10ZSSyWNh5tP4WbIlbkdn/VpP3mWvz9UVPG
	 p0hUdjED9SlcvO7ZcOhXEJOP0lJ+mApo+FiL0+XCbwiZHz70knEVHgjuRUki+lnzWr
	 NgbBKMmGnHtE8l7yC21bhPIVuRL0VVFlOJKlEybMTrq43QVzA9naw8cwiwsIzCwN1W
	 Z/J43tMyNNYyVfgwxq8ROM4XogmrtomP8+xPdK+ZNQRRxmNMuy9KBM1GPhdUvW+rNz
	 DNGwxIfSRnvi+Izq+GMxnlIb5iRDtVQXinZgcqLxRVhLFWzIYWpgBVUvuyBanADYl7
	 BjilPAckrK+paC23vpanMKBudYrjOdtjU2sUO2dx9qaXcwpOiSeXQoyJfeurxV/z4v
	 JbatAmsXmOeylZmteOHskfHQ67YnZdC+rxBVi+7ssdPsIUgZ/heBXR4iuCOXT30+uM
	 OlRc12vGGWbeI39naX385H1k=
Received: from zn.tnic (p200300ea9736a1e2329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a1e2:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E9F5D40E021C;
	Wed, 20 Nov 2024 21:11:28 +0000 (UTC)
Date: Wed, 20 Nov 2024 22:11:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, linux-doc@vger.kernel.org,
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: Merge x86-specific boot options doc
 into kernel-parameters.txt
Message-ID: <20241120211122.GDZz5QeheUP5thy_Zi@fat_crate.local>
References: <20241120163033.12829-1-bp@kernel.org>
 <0d4f2978-22f4-4e8d-a6b8-e6b90888dc25@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d4f2978-22f4-4e8d-a6b8-e6b90888dc25@intel.com>

On Wed, Nov 20, 2024 at 12:49:10PM -0800, Sohil Mehta wrote:
> Instead of double tabs and <option>: <description>, would this be more
> readable if the options and their descriptions are separated?

Have you seen the rest of this file?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

