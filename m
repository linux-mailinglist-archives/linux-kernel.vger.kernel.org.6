Return-Path: <linux-kernel+bounces-571863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E371FA6C353
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB207A7E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CBD22FAD3;
	Fri, 21 Mar 2025 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EnpUc2Zs"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B71D54D1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585200; cv=none; b=ssDNNO0Q4ly7VmF6fQJ9e2vZQG4ZPoJyRW6eEyrGTXSdgGBN9CH50qTxa0xb12Zt4S6KukGH10gpe4exQzAZvwzFhSwLAuTKF4995fqz0sOd6PidWf+JLvmLTQECntexHBd/eNs55TbPkwaluw+ze0ugx8vOnotwCM12DcXjxRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585200; c=relaxed/simple;
	bh=AQtYWPDk3CvetOCve84lRX1JyISvGuScVWZopI4wmHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObePSgcodT+I+0C0uaLf4QHP0K+2TMil0A/0iozncyDvN2m2cokpb1rjAMG3Lzp/9g++ehmWQyb2G1Tl6pTThypBEARWgeHbOLtJ7NpHCt7tPNdlXsoVprgoHJMPmpEsleabvsRL/C5Hm00g+rHQQrj3TrBhf6Os9bLqbUi5YWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EnpUc2Zs; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ab1IJiuoaxZZ4FCqfzKsBQm/LWCmymrYyy6tsJjejUs=; b=EnpUc2Zs6BuIHSQkGRH37rWZYv
	b/1HYd0MoyJrfYJeU5KaGhWu8cstzBX4fmB3Z/Embh/1n0xTlOjO197BNdi6MiI8OI66UNbTF3erk
	KH1AXCziGIMzJrv5jdD6PYIHRsw2czsaE8GJZgCFTiv7cCAc5tjVy9JgmjxnCvGSIjWTHUPI3mhkm
	3BrPGjp6LiwCUqValx7mC0dDpVSwlqCb3V6kfj6UgBXosIR91yJv7fHIjoVvvA4yE7Y+CBDZEX2kc
	uaNRGfG6Xt2PQOKJTj6jP7GMNnxKmEUCFzK7IY74xM9/i0TzZrbkxWQdaoLCB9jjpg7kTHChqhGyO
	BdKz9VDg==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tvi0O-004MRc-6A; Fri, 21 Mar 2025 20:26:08 +0100
Message-ID: <b43e2353-41ff-f2de-881c-c9a3348552b7@igalia.com>
Date: Fri, 21 Mar 2025 16:26:02 -0300
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
To: "H. Peter Anvin" <hpa@zytor.com>, bp@alien8.de
Cc: tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, dave.hansen@linux.intel.com, kernel@gpiccoli.net,
 kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <1238b1d0-275c-9117-a2e3-5e7684404980@igalia.com>
 <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <EA2BAF2F-3F8E-4F81-B71C-7B97677216C9@zytor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/03/2025 15:42, H. Peter Anvin wrote:
> On March 17, 2025 7:35:45 AM PDT, "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
>> On 26/02/2025 10:27, Guilherme G. Piccoli wrote:
>>> Right now, we can force the TSC to be marked as unstable through
>>> boot parameter. There are debug / test cases though in which would
>>> be preferable to simulate the clocksource watchdog behavior, i.e.,
>>> marking TSC as unstable during the system run. Some paths might
>>> change, for example: the tracing clock is auto switched to global
>>> if TSC is marked as unstable on boot, but it could remain local if
>>> TSC gets marked as unstable after tracing initialization.
>>>
>>> Hence, the proposal here is to have a simple debugfs file that
>>> gets TSC marked as unstable when written.
>>>
>>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>> Guilherme
> 
> To be honest I don't think this belongs in debugfs; rather it belongs in sysfs.
> 
> Debugfs should not be necessarily in serious production systems – it is way too large of an attack surface, which is a very good reason why it is its own filesystem – but if this is a real issue on hardware then it may be needed.
> 
>    -hpa

Thanks! I agree, but as per Boris comment, he suggested to drop this
one, right?


In other words, we have 2 options in my understanding:

(a) Drop it;

(b) Re-implement using sysfs entry instead of debugfs;


What do you all think?
Thanks again,


Guilherme

