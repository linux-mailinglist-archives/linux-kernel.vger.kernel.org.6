Return-Path: <linux-kernel+bounces-309322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB59668D9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049E0B20CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C22C1BC068;
	Fri, 30 Aug 2024 18:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OysKoZ1J"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BC1531C5;
	Fri, 30 Aug 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725042238; cv=none; b=ejpTfXc20ty+WGtfZI3EcfXJGhFtNzORNwrZZQDVni2lDK5cBxnvd1Zkrk58u+X6zVYg3bUeliUWBzezg56u8RvYm8jHzMwW4frtZt3BeSetmL+XJWiOz3M5si+C+IzgSoFK4NQ1lyEQ+YXbwSSspWTnFkcXYtciTpUeNHEjZ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725042238; c=relaxed/simple;
	bh=fKMKmdIdvmv98smX+LI6ZUFHFWqjKkATbTDIJrPvllA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfaLIE8FqGdw9CEY9BtcZV/Mq70LJiBGTVHjRHcWZdpdaLHlTfL6ctpgDAVSHHbgUZw6JQdIcZp0n8jDTdGA8Cy2GIxsGZnUpRxyrSFAXdoenEiDW3d6cZqcSs7Mudzn1FMmOzFWnColeuU1IcDjKJoUA0wBSBmzCsMg7+XIaD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OysKoZ1J; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hh4itEyLDnEMzZxAwF6jQr2sg6SqyVA/UmRTj4Gm508=; b=OysKoZ1J6RJLGm/5sQNsgBNmAi
	cWsUb0ASJzvLxJVJ1pTqh+H5c4mewYkOHgpNMpGWLyU418tHS9D1CuevL9L8IT2VgJ1QBqtxYHACl
	POm9m7uEsiB9DTix716yXedCWUxSAEJ0PnWM6qnir2OIfvwaHQdesUw8FZsWn69i+nV4nzKB5fRGc
	Qhwa3O7MJ2zxTOnbTPLX6AYe8R1yhcdnKbAPucmn+k0ieduQOzs37ihHRL8ZLzIHJX8ON269yjz7A
	54lChbOTh932aSKts8QAE3/aQ0ZtgV2JDSyl5sXG89hmgzjgpFD33DWCx7hKnujMRoENk2byfWMMB
	rdTFK+cQ==;
Received: from [177.76.152.96] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sk6Ho-007FYO-3c; Fri, 30 Aug 2024 20:23:51 +0200
Message-ID: <ffe4b1ac-926e-7f99-900b-707384f09462@igalia.com>
Date: Fri, 30 Aug 2024 15:23:45 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Documentation: Improve crash_kexec_post_notifiers
 description
Content-Language: en-US
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org
Cc: bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20240830140401.458542-1-gpiccoli@igalia.com>
 <87ed66q6d5.fsf@oracle.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <87ed66q6d5.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2024 14:15, Stephen Brennan wrote:
> [...]
> 
> This is definitely clearer and an improvement! But I didn't (and still
> don't) love the phrase "users who doubt kdump will succeed" because I
> think that implies user error or silly beliefs.
> 
> What if these two sentences read something like:
> 
> In configurations where kdump may not be reliable, running the panic
> notifiers can allow collecting more data on dmesg, like stack traces
> from other CPUS or extra data dumped by panic_print.
> 
>> Notice that some code
>> +			enables this option unconditionally, like Hyper-V,
>> +			PowerPC (fadump) and AMD SEV.
> 
> Yes, great addition.
> 
> With or without my suggestions it's an improvement, so:
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> 

Thanks Stephen, I agree - your wording sounds better.
I've incorporated that in the just sent V2.
Cheers,


Guilherme


P.S. I'll be OOO some days, so expect a bit of delay in case there are
more reviews/interactions.

