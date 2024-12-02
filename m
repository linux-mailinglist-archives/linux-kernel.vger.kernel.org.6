Return-Path: <linux-kernel+bounces-426804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 849E49DF89A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB021B2123A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52E17BD3;
	Mon,  2 Dec 2024 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b="QT3hI5kK"
Received: from cmx-torrgo001.bell.net (mta-tor-001.bell.net [209.71.212.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074541FC3;
	Mon,  2 Dec 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.71.212.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733104084; cv=none; b=PL0c35NjFlQiOrDn916RJ9WxPW14r2wAY2QnyyOI1zaKXdCuJHGUyUzZTNVNKXxLtkgSOFnTJzOsa0HLv+ymFfcMMt9ZcWkgnN70ZbxMFN9a65StAuvc9eJibYBEmdBIPnnZpuzJdRD/560xwtAitU4ieK0md+4QQCjpxd9kKTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733104084; c=relaxed/simple;
	bh=UKHHYzjIu6EepSzBRjubZ+tIy9GSs52DHZ8GB2wY60Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YoBhtiayG3Txl5ZHk8DYD07z4SdboWccVwfWUMPqkwIg8rVhD48Eymzcg0V+aMZ+qmDBvOgw6iHfYBvre+W7yuOY+ux8pzGvwXU7YIOaq9BwdcKu3alrWgp7yVO7POG/NAuubTSWMB3bb6Y6ul5XhAjfTzW0DmHWvQFcxQ80sZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net; spf=pass smtp.mailfrom=bell.net; dkim=pass (2048-bit key) header.d=bell.net header.i=@bell.net header.b=QT3hI5kK; arc=none smtp.client-ip=209.71.212.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bell.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bell.net; s=selector1; t=1733104082; 
        bh=mr5oJsCg5wa/wcA+TbDl/1v8CMV/BXUGTGNKsUE8LQ4=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:In-Reply-To:Content-Type;
        b=QT3hI5kKNyetbun8QDF1ktNPWG8Mwqd8mF8O8oUKIxsoSgtmOdfyg5mGIK1rpDC76fF8vmo2X/xlrKAsBI1knqF8ucDUCXvGELdWSdaLaIxAKi5Y+DWMXjNdbMpJA6CWhc5So6koyOc7/bOIydxdF66dPov8PPPOi/2x8cltC/KLTVwm5k3XqNX/9/dpyqiPKpCUZ8NpdqfWiPVM4+yyoW+aigRqiiT3b4Ja8KeOaYXFpZhJH7wE71lhV6YwRUVl1cXeiRgOibJ9flZzdGlaw2i59NO2VKYDuVi0t/Xftz3bs3XfWcm16Dpi8CpsbFWwqomWa89Qqnzkm/Qp0mMiXw==
X-RG-SOPHOS: Clean
X-RG-VADE-SC: 0
X-RG-VADE: Clean
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 674075B801894CB3
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdefkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceugffnnfdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhohhhnucffrghvihguucetnhhglhhinhcuoegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffffduieetteeiiedvveehheefkeeugeeigeelteeuffdvgfdtveeuleeftedunecukfhppedugedvrdduvdeirdduvdelrdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddvrdeglegnpdhinhgvthepudegvddruddviedruddvledriedpmhgrihhlfhhrohhmpegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegurghvvgdrrghnghhlihhnsegsvghllhdrnhgvthdprhgtphhtthhopeguvghllhgvrhesghhmgidruggvpdhrtghpthhtohepuggvlhhlvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnmhgrghejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgrrhhishgtsehvghgvrhdrkhgvrhhn
	vghlrdhorhhgpdhrtghpthhtohepmhgrthhorhhopghmrghilhhinhhglhhishhtpghkvghrnhgvlhesmhgrthhorhhordhtkhdprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrgh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.2.49] (142.126.129.6) by cmx-torrgo001.bell.net (authenticated as dave.anglin@bell.net)
        id 674075B801894CB3; Sun, 1 Dec 2024 20:47:50 -0500
Message-ID: <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
Date: Sun, 1 Dec 2024 20:47:50 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
To: matoro <matoro_mailinglist_kernel@matoro.tk>,
 Linux Parisc <linux-parisc@vger.kernel.org>, deller@kernel.org,
 Deller <deller@gmx.de>, linmag7@gmail.com, Sam James <sam@gentoo.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
Content-Language: en-US
From: John David Anglin <dave.anglin@bell.net>
Autocrypt: addr=dave.anglin@bell.net; keydata=
 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
 T70V9SSrl2hiw38vRzsl
In-Reply-To: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I haven't seen any file system corruption on rp3440 with several weeks of running with clock events.  I just
started running 6.12.1 today though.

I have the following timer config:

# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

There was some concern about this change on systems where the CPU timers aren't synchronized.  what
systems do you see this on?

Dave

On 2024-12-01 7:26 p.m., matoro wrote:
> Hi Helge, when booting 6.12 here myself and another user (CC'd) both observed our ext4 filesystems to be immediately corrupted in the same 
> manner.
>
> Every file that is read or written will have its access/modify times set to 2446-05-10 18:38:55.0000, which is the maximum ext4 timestamp.  
> The 32-bit userspace doesn't seem to be able to handle this at all, as every further stat() call will error with "Value too large for defined 
> data type".  Unfortunately, simply rolling back to kernel 6.11 is insufficient to recover, as the filesystem corruption is persistent, and the 
> errors come from userspace attempting to read the modified files.  I was able to recover with a command like:  find / -newermt 2446-01-01 -o 
> -newerct 2446-01-01 -o -newerat 2446-01-01 | xargs touch -h
>
> Luckily, lindholm was able to bisect and identified as the culprit commit:  b5ff52be891347f8847872c49d7a5c2fa29400a7 ("parisc: Convert to 
> generic clockevents").  Some other comments from the discussion:
>
> 17:20:37 <awilfox> would be curious if keeping that patch + CONFIG_SMP=n fixes it
> 17:20:44 <awilfox> this doesn't look necessarily correct on MP machines
> 17:23:56 <awilfox> time_keeper_id is now unused; the old code specifically marked the clocksource as unstable on MP machines despite having 
> per_cpu before
> 17:24:11 <awilfox> and now it seems to imply CLOCK_EVT_FEAT_PERCPU is enough to work around it
> 17:24:13 <awilfox> maybe it isn't
>
> Thanks!


-- 
John David Anglin  dave.anglin@bell.net


