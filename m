Return-Path: <linux-kernel+bounces-245201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2346392AF89
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0791F22678
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280001304A3;
	Tue,  9 Jul 2024 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="k9p8pifM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IxK2FCUs"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B4512F375
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 05:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503893; cv=none; b=uAocoGGCKJ1NgbCwihztdG8Rpcz87ZxN2lwp9qVfppm7iKoUMz7BvgVzUqIV28hIFgs6rot9J1cnk33bppuakm7YUGjtdIy4YRERD41+edKokysPtZmgUTWiiUWUU3KXr6tIEzWRV2XVqnIdmujNwp+QTZPF6m63xKBgcO2xgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503893; c=relaxed/simple;
	bh=6kbcFmvB4vT4HOqvjhXKZwm9yQK9Wy1SXszIn/juJvA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ShDVuyvx7+tug5mgSynQ6lGZws6Tf3Hcx1YyoGjDp6+yJFgppOxq0MpU1eA8cwl+zWeU903DLlgC2ZqqriTWVR+4NNiTijcFw9zpppin50jf4REyBPdtGwQL9bD/CoTi16m7Qg316uI5B3p4LtvhtwDvt1NbQY8P5cZI+SMhecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=k9p8pifM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IxK2FCUs; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4F1F41141F45;
	Tue,  9 Jul 2024 01:44:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 09 Jul 2024 01:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720503890; x=1720590290; bh=EQg+heZbs2
	EC/+pnCCFYU3qmOYvuWSX7hGE78f/KJ+U=; b=k9p8pifMnsy9TRykfAmacOI1JJ
	5L1z4Z3Q3PGCysLJRtSjO0ImV11WmaMekkc0byRibOTxkX1qW3F4t0/smPC5zwI5
	rCuP/aNytAd/Ls4TS48vBokAjLZnCge6gqR5CEFeLzAeI4Jmyf37H7BJqkMo3JTF
	7jjTJnlRdYGER7PF1E1KZZEJuC+KvvOnHrmiOlF4FjyvsInt2kYYpe1SOdWBAGc4
	JBdfyRKIoCPq7TnsLLRMnN/L/h5XMFYukyAbztQ8Q9S2WicUfkzA3D/dC5QaBJ4y
	uoUhvgknW6imHEN7OJlZ20ASQ+ESh468HXCW2DLWJme1E31FAJp4EaGBcacA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720503890; x=1720590290; bh=EQg+heZbs2EC/+pnCCFYU3qmOYvu
	WSX7hGE78f/KJ+U=; b=IxK2FCUsv3okkVDB69gIdNGachdklt9gETgx58SBJj10
	oLaLSr2ryLTU2wFBn0dGtrnXHpE6Mwj91UX8zfhFQ3TAv44PjE6C27clCGBlhUBk
	M38dJ0Msz37kDJAD6nlNojkSz/5mggk8FcjgH4DLIAioiRBp6k3aVfjii5zfr/yS
	GMtV65B150fcEzK1dAF5pENrBzP9Xsa59GtfcUni5J3ue6OxLyjpwBRtK0y6OF8W
	MCN1/51uld3dW4Xig75Owsjcb9LeptPWfdIvUyjvv3VwgFyKecIYr2jEyjdSVE2B
	KVccPsUR7A8mMPY3nQszIVyggf0Ql+/03PmSr/f+vg==
X-ME-Sender: <xms:Uc6MZkcmPvGdaV1tKK-h9hWrswjbcNr8l9zV--dsnI7BPN2Pq5AAZA>
    <xme:Uc6MZmMyRLEqQSMkjBRoZXWwxW-XOF2A5la-Ql6oLEhhpBTY0P6-jlhoMa1EahO7D
    5Qmu1CB9ZAb5yC_h5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeegteeihfejvdfhfeffhfdvvddvfffgtedvteeigfehhfehudffleejueduvdel
    gfenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Uc6MZli-8gPvFepooNBluxa6xExXDcrxHtii-K4bD9FX4cVN8NKSuQ>
    <xmx:Uc6MZp-HYdOQymONY2UFA_jcGWWAO19d7KwCuDNBam53IAHld3aYDg>
    <xmx:Uc6MZgtdN8UGUM0oizJWz6n9MZcFubvEk9v9TeOIpUN-RZhcaIYwEg>
    <xmx:Uc6MZgEcNYcDZjVud32ciNUKyfZ1Y0dnUCYLRq7NKK-NEl1S2qQMIg>
    <xmx:Us6MZsKgCvtMvK8TI7h1arObqxvvaBq6UC17dpeRhJeFxkh8UX9oejM7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 03F4AB6008F; Tue,  9 Jul 2024 01:44:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c9b23ee3-6790-404d-80a3-4ca196327546@app.fastmail.com>
In-Reply-To: <837cd2e4-d231-411a-8af4-64b950c4066a@quicinc.com>
References: <87y16bbvgb.fsf@kernel.org>
 <917565ee-732a-4df0-a717-a71fbb34fd79@quicinc.com>
 <837cd2e4-d231-411a-8af4-64b950c4066a@quicinc.com>
Date: Tue, 09 Jul 2024 07:44:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Kalle Valo" <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, ath12k@lists.infradead.org
Subject: Re: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
Content-Type: text/plain

On Tue, Jul 9, 2024, at 05:55, Jeff Johnson wrote:
> On 7/8/2024 6:57 PM, Jeff Johnson wrote:
>> We tend to enable a lot of debug config options, so I'm wondering if one of
>> them is contributing to the issue? Guess I'll turn off a bunch of those
>> options and try again.
>
> OK, with a bunch of debug turned off my image boots.
>
> Now to find the culprit.
>
> Current diff between original config and working config:

Nice! I've tried the reverse now, turning on the options
you have turned off on top of my defconfig. This version
still works for me, booting with a plain
'qemu-system-x86_64 -kernel arch/x86_64/boot/bzImage'
and building with my arm64-to-x86 cross compiler.

I have turned off most drivers here to get faster builds,
but it's enough to get console output.
See https://pastebin.com/p2GFjAc3 for the full .config

     Arnd

19a20
> CONFIG_CONSTRUCTORS=y
290a292
> CONFIG_GENERIC_CSUM=y
298a301
> CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
394a398
> # CONFIG_ARCH_MEMORY_PROBE is not set
441c445
< CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
---
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
537a542
> # CONFIG_ACPI_HOTPLUG_MEMORY is not set
748d752
< CONFIG_HAVE_RELIABLE_STACKTRACE=y
903a908,909
> CONFIG_NUMA_KEEP_MEMINFO=y
> CONFIG_MEMORY_ISOLATION=y
906c912,916
< # CONFIG_MEMORY_HOTPLUG is not set
---
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
> CONFIG_MEMORY_HOTPLUG=y
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> # CONFIG_MEMORY_HOTREMOVE is not set
> CONFIG_MHP_MEMMAP_ON_MEMORY=y
914a925
> CONFIG_CONTIG_ALLOC=y
1238a1250,1251
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
1242a1256
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
1264a1279,1280
> # CONFIG_JOYSTICK_XPAD is not set
> # CONFIG_JOYSTICK_PXRC is not set
1269a1286,1290
> # CONFIG_TABLET_USB_ACECAD is not set
> # CONFIG_TABLET_USB_AIPTEK is not set
> # CONFIG_TABLET_USB_HANWANG is not set
> # CONFIG_TABLET_USB_KBTAB is not set
> # CONFIG_TABLET_USB_PEGASUS is not set
1313a1335
> # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
1336a1359,1360
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
1337a1362,1364
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
1922c1949,1970
< # CONFIG_USB_SUPPORT is not set
---
> CONFIG_USB_SUPPORT=y
> # CONFIG_USB_ULPI_BUS is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> # CONFIG_USB is not set
> 
> #
> # USB dual-mode controller drivers
> #
> 
> #
> # USB port drivers
> #
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
2243a2292
> # CONFIG_USB_LGM_PHY is not set
2829a2879
> CONFIG_STACKDEPOT_ALWAYS_INIT=y
2873a2924,2925
> CONFIG_ARCH_WANT_FRAME_POINTERS=y
> CONFIG_FRAME_POINTER=y
2874a2927
> # CONFIG_STACK_VALIDATION is not set
2896d2948
< # CONFIG_KCSAN is not set
2922c2974,2977
< # CONFIG_DEBUG_KMEMLEAK is not set
---
> CONFIG_DEBUG_KMEMLEAK=y
> CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE=16000
> # CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
> CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y
2924c2979,2986
< # CONFIG_DEBUG_OBJECTS is not set
---
> CONFIG_DEBUG_OBJECTS=y
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> # CONFIG_DEBUG_OBJECTS_FREE is not set
> CONFIG_DEBUG_OBJECTS_TIMERS=y
> CONFIG_DEBUG_OBJECTS_WORK=y
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=y
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
2927c2989
< # CONFIG_SCHED_STACK_END_CHECK is not set
---
> CONFIG_SCHED_STACK_END_CHECK=y
2933a2996
> # CONFIG_MEMORY_NOTIFIER_ERROR_INJECT is not set
2943c3006,3014
< # CONFIG_KASAN is not set
---
> CONFIG_KASAN=y
> CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> CONFIG_KASAN_GENERIC=y
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=y
> CONFIG_KASAN_STACK=y
> CONFIG_KASAN_VMALLOC=y
> # CONFIG_KASAN_MODULE_TEST is not set
> # CONFIG_KASAN_EXTRA_INFO is not set
2945c3016,3020
< # CONFIG_KFENCE is not set
---
> CONFIG_KFENCE=y
> CONFIG_KFENCE_SAMPLE_INTERVAL=0
> CONFIG_KFENCE_NUM_OBJECTS=255
> # CONFIG_KFENCE_DEFERRABLE is not set
> CONFIG_KFENCE_STRESS_TEST_FAULTS=0
2957c3032,3034
< # CONFIG_SOFTLOCKUP_DETECTOR is not set
---
> CONFIG_LOCKUP_DETECTOR=y
> CONFIG_SOFTLOCKUP_DETECTOR=y
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
2959c3036,3041
< # CONFIG_HARDLOCKUP_DETECTOR is not set
---
> CONFIG_HARDLOCKUP_DETECTOR=y
> # CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
> CONFIG_HARDLOCKUP_DETECTOR_PERF=y
> # CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
> # CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
> CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=y
2961c3043,3046
< # CONFIG_DETECT_HUNG_TASK is not set
---
> # CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
> CONFIG_DETECT_HUNG_TASK=y
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
2970c3055
< # CONFIG_SCHED_DEBUG is not set
---
> CONFIG_SCHED_DEBUG=y
2982c3067,3068
< # CONFIG_PROVE_LOCKING is not set
---
> CONFIG_PROVE_LOCKING=y
> # CONFIG_PROVE_RAW_LOCK_NESTING is not set
2984,2989c3070,3082
< # CONFIG_DEBUG_RT_MUTEXES is not set
< # CONFIG_DEBUG_SPINLOCK is not set
< # CONFIG_DEBUG_MUTEXES is not set
< # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
< # CONFIG_DEBUG_RWSEMS is not set
< # CONFIG_DEBUG_LOCK_ALLOC is not set
---
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
> CONFIG_DEBUG_RWSEMS=y
> CONFIG_DEBUG_LOCK_ALLOC=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
2997a3091,3092
> CONFIG_TRACE_IRQFLAGS=y
> CONFIG_TRACE_IRQFLAGS_NMI=y
3002a3098
> # CONFIG_DEBUG_KOBJECT_RELEASE is not set
3016a3113
> CONFIG_PROVE_RCU=y
3051a3149
> CONFIG_PREEMPTIRQ_TRACEPOINTS=y
3104,3105c3202,3203
< CONFIG_IO_DELAY_0X80=y
< # CONFIG_IO_DELAY_0XED is not set
---
> # CONFIG_IO_DELAY_0X80 is not set
> CONFIG_IO_DELAY_0XED=y
3113,3114c3211,3212
< CONFIG_UNWINDER_ORC=y
< # CONFIG_UNWINDER_FRAME_POINTER is not set
---
> # CONFIG_UNWINDER_ORC is not set
> CONFIG_UNWINDER_FRAME_POINTER=y
3121c3219,3220
< # CONFIG_NOTIFIER_ERROR_INJECTION is not set
---
> CONFIG_NOTIFIER_ERROR_INJECTION=m
> CONFIG_PM_NOTIFIER_ERROR_INJECT=m

