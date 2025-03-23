Return-Path: <linux-kernel+bounces-572925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 544F3A6D074
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E31167E38
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B26190057;
	Sun, 23 Mar 2025 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fJ17TW4j"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD318DF8D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752409; cv=none; b=sJi1UVTX01tHj4D53MFD+B+3BVTBiLVhQAQDCUH4b3HKtXpS5uv2ENrCjkT6g+HKzCZXNkfVeMoSe+YJijVLFpBMpX4uhz7eu/BhBkLzLh5L1Ow1JFCSC5HmaqV49r/zvox2uHIYXYntF2U2s/3+eKMkSI3Q9uyx2Oai4OivTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752409; c=relaxed/simple;
	bh=NhtR3jMg1DbZqelavBB/HYow+zmxwmTBPkjAKQ/3sFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOhCAKQEai2PKH3IjdiVSy651STpmywYgmmx9ugJeChOTuyxrtw17vuMh9SO1vOTTF17aQGMIJphA9r96B4L0++rL7DXJtRMtzKu1nQblzebJKS1iKEJaS9iYtvtx+dd7QMVC5Fb/qEwNv0W3yoc4vhBpCuUsjNr+MbOPaIdzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fJ17TW4j; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Jjn/M8FT5O2BGiA0QtJ0YYHxqDVcoYX2QEUhSAy9no4=; b=fJ17TW4jCedqhGvuEdAmU9fG2B
	QdX6oBpj2oCqfJ+1Pqa4QK6w9a++CaMnRQTTgaR9854kilDLtOGUNwSvXF2a2pmfqPrdgsSlAED6+
	5+oNfU27PvLUG9dJVGz7ZtUt099rWEH5PiR70hTFXYfJrmxwEswUp14oCwv6zWcz6RB1EGhGPgFEz
	UsMTdLiPqZyRhFt3NzLKycx7y6c7S9HrQdi8NAYjmGSNuUZeWI/Bsp1nAbodiAw4JYkiRgWwgH+47
	gblE1pqEp5jkwKuYty2nDaVS2ReC3Kv1vMi8ksg/JTB+7GFni3Dp5yZ3gCVHWveInCh0KZ7IeMxnf
	uDmZFPow==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1twPVW-005MY4-2b; Sun, 23 Mar 2025 18:53:10 +0100
Message-ID: <c9ce2eb1-bf90-3ce4-0adf-3f4e43f4a5bd@igalia.com>
Date: Sun, 23 Mar 2025 14:53:05 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
 bp@alien8.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 dave.hansen@linux.intel.com, kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
 <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com> <87iko213qo.ffs@tglx>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87iko213qo.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks Thomas for your comprehensive response, quite enriching.
Some comments inline:


On 21/03/2025 18:19, Thomas Gleixner wrote:
> [...]
> The proposed implementation is just an ad hoc band aid as well. Why?
> 
>   1) It has zero relation to the actual failure detection code paths.
> 
>   2) It covers only a small part of the problem space. On all modern
>      systems, which have TSC_ADJUST the clocksource watchdog is disabled
>      and just asynchronously invoking TSC unstable is a hack which only
>      tests the unstable logic.

But what about AMD systems? Even the modern ones apparently lack
TSC_ADJUST - or is it changing recently?

Checking TSC code, it is full of checks "if Intel" as well, like in
native calibration. Our issue is present on AMD and my impression is
that, in this respect, these systems are way more unstable (from TSC
perspective) than the ones having TSC_ADJUST.


> 
> So I rather want to see a more complete solution, which
> 
>   1) lets the clocksource watchdog logic fail the test
> 
>   2) lets the TSC sync (including TSC_ADJUST) logic on CPU hotplug fail
> 
>   3) tweaks the TSC_ADJUST register and validates that the detection and
>      mitigation logic on systems w/o clocksource watchdog works
>      correctly.
> 
> Ideally that's a kunit test for CI integration plus a debugfs interface
> for developers, which comes with a related selftest.
> 

This is a great suggestion. I'll try to come up with something in next
weeks (as time allows), I agree this area indeed seems to lack good/easy
testing.
Cheers,


Guilherme

