Return-Path: <linux-kernel+bounces-426920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509789DFA0E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA8281BBA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF021D6DDA;
	Mon,  2 Dec 2024 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b="m+c6nVX4"
Received: from matoro.tk (matoro.tk [104.188.251.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46CE1D5CF9;
	Mon,  2 Dec 2024 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.188.251.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115342; cv=none; b=VqGsJaeVe1OOLuu9nY2u4CDYeBy/7INMoXKtvnMPHmxxI2fnMadsWUaXpdGfAsBsFLIwtnaI+bAsOcU7ahNXwDnUhR0GSiX9tJW9kMdHaod59WK4Ruckq8fNjazYA752Avzjk8SHdbPLmKV2uyKYYURxwSOjn7sSDsUIXpaVE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115342; c=relaxed/simple;
	bh=zPcXBBW8c+KQ0U+3drAZctmojlTnoxK6RX0o3bY3E3o=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=caG3wmjY6xofrD+hFk3JgTROFazNZBxX0CO+hg5QoyuSNSDTDtVDDKDEC8cidHr2jh+yYZ5qTLegkO9KISBkpvpqDyNGg3GkRS00sW/yGr5shAiiXEd3Zxof/FbiqAzzZ7PSl+HPyzjBmuCQxg8908S3F/O3hi0Os3je4QH4J7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk; spf=pass smtp.mailfrom=matoro.tk; dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b=m+c6nVX4; arc=none smtp.client-ip=104.188.251.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matoro.tk
DKIM-Signature: a=rsa-sha256; bh=/JshKyUPq3mOf+snPX4NT7ZNngHLlkIdkeTc+mS3z7k=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20241120; t=1733115330; v=1; x=1733547330;
 b=m+c6nVX4ZA1uzWFCzyhLYwwfw3amfDifJeY4jjB+0TAY26VK0EcR6ee+P7mMmAs4W5bJDe9M
 Jj7pd9PsmR2RidppeOUo3BL05qLDAI7tTuDna3wXOTJL/TJeVQryE+98ZGeahoBM/jJskz7+XXN
 3qQuPdwNl4l2CFzWcCBbaCaoUEqezGxPue9ggHg2/joqJZt9pJeekKWt7bdXFvno6Ej+F1v0fap
 wJ1Et4rnkEO/shG/3U4fXGogTWfCdTmPdQwHb7cVDfkZynWqoxmfeYljoCWaAQDyDppPC0SmxHb
 b7q4nKTdq/XIkNZV1dir9/vwzkSyWJ7kTKf/URd9JBHEUkOFQ2t8X6Wfg3Y8Dbnhkrk+cVMwuuF
 f2heq4w6DFoQEvBeD9wp3qpN0CxQz/hE8NMjNhGMqq5X01ou1wbxNWo0JgGTF/XEC/L5zCRow6Y
 1I4lxej43DnAcw0RRdJDzzZIpOC33AKDkeP1/10jXT37GTieDSDjc6sOOsCnfea4yLGRqH92si0
 Yj+bZCgC0HgwS+H5hwfnaeNkk1yYXEd7h1EyS0gxpmZeqY7CrmU5yw71vT73BTMjHGKfg6rGWNi
 Bi5W7L+Xm1MtXfrP/1PIAdJhNUizDsOHno+O578T4CITZLxhfkj2sImfVsSUR57Xg2+eZqbU7rV
 vqq8V1Ovtvw=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id e2fca5e6; Sun, 01 Dec
 2024 23:55:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 01 Dec 2024 23:55:29 -0500
From: matoro <matoro_mailinglist_kernel@matoro.tk>
To: John David Anglin <dave.anglin@bell.net>
Cc: Linux Parisc <linux-parisc@vger.kernel.org>, deller@kernel.org, Deller
 <deller@gmx.de>, linmag7@gmail.com, Sam James <sam@gentoo.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
In-Reply-To: <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
 <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
Message-ID: <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hmm, this is my config, also on an rp3440:

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

lindholm can confirm on their hardware/config.  Maybe you can try that and 
see if you can reproduce?  I will try your config as well.

On 2024-12-01 20:47, John David Anglin wrote:
> I haven't seen any file system corruption on rp3440 with several weeks of 
> running with clock events.  I just
> started running 6.12.1 today though.
> 
> I have the following timer config:
> 
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> There was some concern about this change on systems where the CPU timers 
> aren't synchronized.  what
> systems do you see this on?
> 
> Dave
> 
> On 2024-12-01 7:26 p.m., matoro wrote:
>> Hi Helge, when booting 6.12 here myself and another user (CC'd) both 
>> observed our ext4 filesystems to be immediately corrupted in the same 
>> manner.
>> 
>> Every file that is read or written will have its access/modify times set to 
>> 2446-05-10 18:38:55.0000, which is the maximum ext4 timestamp.  The 32-bit 
>> userspace doesn't seem to be able to handle this at all, as every further 
>> stat() call will error with "Value too large for defined data type".  
>> Unfortunately, simply rolling back to kernel 6.11 is insufficient to 
>> recover, as the filesystem corruption is persistent, and the errors come 
>> from userspace attempting to read the modified files.  I was able to 
>> recover with a command like:  find / -newermt 2446-01-01 -o -newerct 
>> 2446-01-01 -o -newerat 2446-01-01 | xargs touch -h
>> 
>> Luckily, lindholm was able to bisect and identified as the culprit commit:  
>> b5ff52be891347f8847872c49d7a5c2fa29400a7 ("parisc: Convert to generic 
>> clockevents").  Some other comments from the discussion:
>> 
>> 17:20:37 <awilfox> would be curious if keeping that patch + CONFIG_SMP=n 
>> fixes it
>> 17:20:44 <awilfox> this doesn't look necessarily correct on MP machines
>> 17:23:56 <awilfox> time_keeper_id is now unused; the old code specifically 
>> marked the clocksource as unstable on MP machines despite having per_cpu 
>> before
>> 17:24:11 <awilfox> and now it seems to imply CLOCK_EVT_FEAT_PERCPU is 
>> enough to work around it
>> 17:24:13 <awilfox> maybe it isn't
>> 
>> Thanks!

