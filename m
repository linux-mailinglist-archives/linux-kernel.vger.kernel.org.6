Return-Path: <linux-kernel+bounces-257234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E08393771F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D061F2131B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510088624A;
	Fri, 19 Jul 2024 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mQJI0s4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="twhcLmvx"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579F1E502;
	Fri, 19 Jul 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388548; cv=none; b=omDB9g2+6BCEJyoqQ9RDca9FKrl/DGjGJ5El9fPw06dYnw52NapDyvtEjMpAon/PTNGxHIbfF2YBWzjVlKCNeuV5uuW8niXfvFzbYBKvqta9dUIOdbkL7YtcJM2q0TX/5gxK+nYWPFDO4Pe2uod/e9fZ8fzcTh/ecDhFcyvTyec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388548; c=relaxed/simple;
	bh=6e1McigiHvEvVwK5EbMhAGua/tT5rtZuppTZZmZ/LpY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Au6e9+7hh+gTn5SPFqX6x/nbmUuPZQv/WVKezTVhQZD/oec82pd/nNodITPTpfrZGA3vMwR3Baz0o8npUvc3UdHQc1bEpts9a4d9zJ8wygKlPYJKnsUupkgvNj3lzUbshhMV19oUBWmicONu/kohfoiwxbigdGf8ifH/3CImezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mQJI0s4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=twhcLmvx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B43EA11406A6;
	Fri, 19 Jul 2024 07:29:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 19 Jul 2024 07:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721388545; x=1721474945; bh=r/mNmunF4X
	YM9lHwpvMhWNpNNiXBr+47HI8/H3udo78=; b=mQJI0s4DF6X7kQCMYF6YJh5swB
	hVCn49Q2d1G0mKvHpSRSmbKe4wrMVixnooQqY8TF3WP0z0owTaitdmK5dAql08eu
	0X3vtrZOD9wCDK4AXyKJlGVvD8U/SLMSXbjKKoYoA9NNB8E61mIFrd6297ssmpoQ
	KuHjaDQig370CLzoXRP/eGT9TzvAxQkGnnUmUBc6+Y8FJTrf9RGnCs9D0C9dS3yS
	C/wCpRQW7KhOa6ioyBFr+NpS4ZmULn8457pCSk1rRAuGMlfFOwXfiDxoCHHiBnZW
	iPWecw1M4VYJUwRT7ke3p4ofvt+wYQDIvaw1f9krS2abS957LOYsLcEpKVtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721388545; x=1721474945; bh=r/mNmunF4XYM9lHwpvMhWNpNNiXB
	r+47HI8/H3udo78=; b=twhcLmvxiHKHfwtb934chH1dIsNbM6vYklhw7jqkMRaE
	BwX7uIDZjuCuRFCTCh82iCwJo4TunLcHP5NF0Ia8ynz+kWzLmaiQiEHZGCCQ2bF4
	LAbiqGbIAhOwXnwIrtfrLO+l3XjKd+O7L2VNoXgnGZi9qc2PhRp65fibiK75CXTL
	1MjcxJjTlZ959hcmsnCQAL1sf0RiMHYUQx+tDL6DXWODoiH8v2dsqKfnCc4LLeFV
	wCq860a5cndjxBM//OY9/kgo+NN3zDIVDKSamQAyOZOreDH94BNSCKkO3YLpzqNe
	bldCNOlSUY/y6xF/AIBC7pR5P7LKHVUaxa2ePBLBig==
X-ME-Sender: <xms:AU6aZlW7OVI2E-tQJVVJAZI-8pvcMkyo7K6yO5c3XiuGc5aqbMQlyQ>
    <xme:AU6aZlk9NZH4nWl5MCV9wNRKxWVzP3ykbIWFbuv4h57IOC3e-WvR23Isg5ErsKUnz
    W6ZhJaGrFSqd8sFGSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrhedugdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeelffehffevveekgefffeffvdeigfffgefhhfduveetveefgfetudejfeeugffg
    jeenucffohhmrghinheplhhinhhugidrohhrghdruhhknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AU6aZhZtNVyb4bF4ywf82oUI7tencC7h--TxGXSSW1i28hwysgvfCQ>
    <xmx:AU6aZoWi7CuRnLoP_DYq-Y29bdRKh0zziDuNrKsLJSpOCLVzGyuSug>
    <xmx:AU6aZvl0pLIBXs36EwH3YGMh34LRx1DIzIZv4XGd-WvOAC_YU3aZew>
    <xmx:AU6aZlcgkBXiY3tcNwHbmbbmnEFenU0wz4yDhB-aOTkIjQ-cUfECxw>
    <xmx:AU6aZoAwrpOKHxWcu98sE8o1f3WxzA5TYsOBKooLYWRCtdDo31j76C6e>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5F153B6008D; Fri, 19 Jul 2024 07:29:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05cacd03-686a-4ede-b485-7f4781f69b99@app.fastmail.com>
In-Reply-To: <3808c973-1315-420c-900d-122a73a34f9e@quicinc.com>
References: 
 <20240622-md-arm-arch-arm-probes-kprobes-v1-1-0832bd6e45db@quicinc.com>
 <3808c973-1315-420c-900d-122a73a34f9e@quicinc.com>
Date: Fri, 19 Jul 2024 13:28:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Russell King" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] arm: kprobes: add missing MODULE_DESCRIPTION() macro
Content-Type: text/plain

On Tue, Jul 9, 2024, at 21:53, Jeff Johnson wrote:
> On 6/22/2024 9:34 PM, Jeff Johnson wrote:
>> With ARCH=arm, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/arm/probes/kprobes/test-kprobes.o
>> 
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>> 
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  arch/arm/probes/kprobes/test-core.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
>> index 171c7076b89f..6e9041a76b8b 100644
>> --- a/arch/arm/probes/kprobes/test-core.c
>> +++ b/arch/arm/probes/kprobes/test-core.c
>> @@ -1664,6 +1664,7 @@ static void __exit kprobe_test_exit(void)
>>  
>>  module_init(run_all_tests)
>>  module_exit(kprobe_test_exit)
>> +MODULE_DESCRIPTION("ARM kprobes test module");
>>  MODULE_LICENSE("GPL");
>>  
>>  #else /* !MODULE */
>> 
>> ---
>> base-commit: 563a50672d8a86ec4b114a4a2f44d6e7ff855f5b
>> change-id: 20240622-md-arm-arch-arm-probes-kprobes-34037098a2c3
>
> I don't see this in linux-next yet so following up to see if anything else is
> needed to get this merged.

Hi Jeff,

The arm tree uses a separate submission system for reviewed
patches to get into the tree, see

https://www.arm.linux.org.uk/developer/patches/info.php
https://www.arm.linux.org.uk/developer/patches/section.php?section=0

I looked at this file as well during build testing
and ended up combining the change with a cleanup,
If you like, I can send my version instead, see below.

      Arnd

diff --git a/arch/arm/probes/kprobes/test-core.c b/arch/arm/probes/kprobes/test-core.c
index 171c7076b89f..0c6639509eff 100644
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -1650,24 +1650,16 @@ static int __init run_all_tests(void)
 
 	return ret;
 }
-
+late_initcall(run_all_tests);
 
 /*
  * Module setup
  */
 
-#ifdef MODULE
-
 static void __exit kprobe_test_exit(void)
 {
 }
-
-module_init(run_all_tests)
 module_exit(kprobe_test_exit)
-MODULE_LICENSE("GPL");
 
-#else /* !MODULE */
-
-late_initcall(run_all_tests);
-
-#endif
+MODULE_DESCRIPTION("Test code for ARM kprobes");
+MODULE_LICENSE("GPL");

