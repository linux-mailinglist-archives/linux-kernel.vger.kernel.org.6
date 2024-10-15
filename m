Return-Path: <linux-kernel+bounces-365508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337EB99E36F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED04F2841D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940E91E378C;
	Tue, 15 Oct 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFh2DOm1"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8902A1E2841
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728986899; cv=none; b=Z0Cpfysi2tnk5f5s06WOHBtfnR/7m7boT+cFABDIWge45HN4kxJVUd1x6TY7Hhpfdy7/reBvC0U7vU4gjGl+8w0jlCkFIHr5/r477t9H7PlXDq/p+W3vrXnplysSGcvdtq/coRmXv2Qtm/uhNTuhkVjIje22cXXzKbFd9h/QHes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728986899; c=relaxed/simple;
	bh=8MvRA1R5gHTrY03aorsLgPFcXBTDxX4sVfrhHvZT1Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXL7yhFKah09XNH9mNyIqUYAH46E621Zze8Icw9IZfx5TM9GJzkfITD2mq3Fh7FT1i8MDydNMcnE7YehrYF5X749E8sFSZcNRNiAI9OqgQwpdY6oiQPQNPaI9yURNRcFyGm2c//e0Aw42afvHPnRRgB9+O2y6QhyphXxCce+Fs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFh2DOm1; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8354599fd8aso203998439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 03:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728986896; x=1729591696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpvgnMomw0Uq56+eW9heIDg2o6H/iBcUs4/VOkLS8oc=;
        b=mFh2DOm1gR83SaEt0vN3521vVl1cAS7IS8fvkHMyW8AaAkgyrS+53kjb5P2fZUEPwy
         i4JRBriyiaNgS+6HcOMwFOzMWnRTl4/g/tsZHmkfsFAhBhXUNUGIVFf+gtWXlR8j6wiZ
         co4j/2ivMSORjdhUYTdXFl8QrKT/o4F8mPz6/sd+N3hE6MDHIbYgvkXL0Jvkbp5N05mC
         ciHdpPc5oDz2Dq33z+ayEihMGvQmTNGDqdI2V3DwqZFG+WYwqhYz0LpJu51NOeOmqaP+
         Xs9h5Ur7YnYUukaKLaH/J6fh9nT/DNKhlODrniL9fWKBmTVwkClxDi4cFjaYQ5eBFJXS
         eeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728986896; x=1729591696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpvgnMomw0Uq56+eW9heIDg2o6H/iBcUs4/VOkLS8oc=;
        b=Ib3b91oDVT7UdRIbsTqPh81w9mmMF7hOrYYdzYQ8pNpUePUr61eEJOm+QWHsGljQTw
         tnRejP3HPVJAJOiq62h+cJwwRJGMrlImbcaGX3kghbiE9ngSC35YFE72g+grDqvur1kK
         lFi3YNO0LMH2qiSQZ92adfNq7ISseEF3E4TstFP2QG/8ixZT13Wg79qzdPL2TaKcBUtA
         u8VDrIAon1DNgT73v7F/CGht53Yk1qC3zBrDeCYjt8G/hiZi0no6LAWeMR9vA72sKF5E
         rATbsvQLRHvt4Er18ExClE8mEi4VKeczXoKrNi31niZfanoH9K0UJGOAgHjQniZ6HDQv
         tz7A==
X-Forwarded-Encrypted: i=1; AJvYcCWl9fK3MGmK91U6/rQs4MPazvJhx12AyUBOylHrAQu427QQ2ROs4Whda5XU6jf4gjZHuhww6O7GLuH3BYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrCz+gf+TNT1GBCFL8oZbX3Wd++kAymL4jDh/AA5EdHDpIkXWD
	GBYg6OqmvkjtmpooIOVWDEbJYQpW74HbNCZhn0/yoiV2tHTKmxXB
X-Google-Smtp-Source: AGHT+IE2DPjntaI4HEsSMYwUNRJ10+nrrbcsv/I0ULix1C0zQoZ3ELz+C4Gg6T4rh6U/IVcloMnjrw==
X-Received: by 2002:a05:6602:1486:b0:82c:d744:2936 with SMTP id ca18e2360f4ac-8378f92ee97mr1440446739f.0.1728986896433;
        Tue, 15 Oct 2024 03:08:16 -0700 (PDT)
Received: from DESKTOP-NBGHJ1C.local.valinux.co.jp (vagw.valinux.co.jp. [210.128.90.14])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b28be7fsm23462739f.11.2024.10.15.03.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 03:08:15 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: will@kernel.org
Cc: broonie@kernel.org,
	catalin.marinas@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	ryotkkr98@gmail.com
Subject: Re: [PATCH] arm64: Remove the check for CONFIG_TINY_RCU
Date: Tue, 15 Oct 2024 19:08:09 +0900
Message-Id: <20241015100809.15581-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014131042.GA17353@willie-the-truck>
References: <20241014131042.GA17353@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Will, 

On 2024-10-14, Will Deacon wrote:
>On Sat, Sep 14, 2024 at 06:00:40PM +0900, Ryo Takakura wrote:
>> Since the commit 4b3dc9679cf77 ("arm64: force CONFIG_SMP=y and remove
>> redundant #ifdefs"), arm64 defaults to CONFIG_SMP but TINY_RCU is cofigured
>> only for !SMP systems.
>> 
>> Remove the check for CONFIG_TINY_RCU as it should always be false.
>> 
>> Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>> ---
>>  arch/arm64/kernel/entry-common.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index b77a15955f28..a9765364fc67 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -40,7 +40,7 @@ static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
>>  {
>>  	regs->exit_rcu = false;
>>  
>> -	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
>> +	if (is_idle_task(current)) {
>>  		lockdep_hardirqs_off(CALLER_ADDR0);
>>  		ct_irq_enter();
>>  		trace_hardirqs_off_finish();
>
>I think this code was deliberately written to follow kernel/entry/common.c
>as closely as possible, as we should be able to switch over to that at
>some point.

Oh I see, thanks for taking a look at the patch!

>Come to think of it, Mark, what work is needed before we can move to the
>generic code? Is there anything you need a hand with?
>
>Will

If there is anything I can be of help, let me know!

Sincerely,
Ryo Takakura

