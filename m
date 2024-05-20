Return-Path: <linux-kernel+bounces-183360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77398C97F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 04:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900C028108A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 02:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBAE9457;
	Mon, 20 May 2024 02:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y3jSmPxo"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2160FBF6
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 02:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172714; cv=none; b=fKMd9LYEeEbTaQP9i8UNOo0n9U5AR6CJ8RvQIQ4cM2VnNGd57ue/mbAP13i9M8+R5VdhS6OnVZ4Sk0WZvt0PPgZyPK7DeH5ZSDhOcnMbY0+151ceVXIZeQJ+EHPiP4Wh0JLs8XmsK1+ISriY3KVp995wq3eAC11bzxbigbUvDE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172714; c=relaxed/simple;
	bh=s3hMnneki/xCehK7eUpMW9xHCWCBE5YEqu/0puPv3OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F/j4NMK4L4LVNlGUkKkNsYosTkRwPLi02iLfvRTKbKrV1ihYeQkghZho3c4OSkUnn66tFMW2DiEzYXeCRviQwbmiYdCRvajn8mkvwJnA4JI1pGijVp4ZJMC3QNdc6P4MuXabEDmjmYd7saQ9sPItzkZiN4lNZ67cHH0PFQPl1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y3jSmPxo; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso1243606a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 19:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1716172712; x=1716777512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPp84dK/TP4O+E01WOilhkZ88ufy3AD5Z9rfCYlBsMk=;
        b=Y3jSmPxoONfor9ibB0XyYGwscQ+srl1vo8/fMw/SlgqZJaW/HwAmJVFbqOfRCtMRgP
         s9AAdI/FoS+kH/YCVfucaliVTr+VcWoN+rYNJMBxIOEHnCBcx4qM0Qk7ese4xSzD3isi
         eSs6Ya58hx9ITKeFxrtn4TRn6wYPi5nf6DFOE2FYAdcB4ghyRdROypJl7rdI49RAME64
         nYBc8ymp7eciO14OMrasa8ybQvFn1rKjBZPgWVh8w3UuTUmIAs3atXPnErQt3tCeCADI
         V8cEHsz953Zs+KvSaPI2POLsHLH/0Hf7ba9GTuHkG6gOUfFrI+x3LIBYrXnaeml4LtGM
         tLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716172712; x=1716777512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPp84dK/TP4O+E01WOilhkZ88ufy3AD5Z9rfCYlBsMk=;
        b=ieivnnb5gT1TS9FnPaTweIk9+OJGxm1OxReW9JEddgJsHq0HWvVYzDtVr4TuxDQelR
         uPH9jqCfTjaIDqByCx/fOhcGaW75TrURgKD77q2q50EawkhNH+/V7Ge0zXraj2mOsXia
         1zvMwFkqovYGKaz7txRDQdY1V8z/5lxg6jePF15KufEY4Iqvcl6bVjX+83atL5YAKlBP
         iopIAZHTcGyRP6E1AjHJY216nOFFHQ5Gs4ly3KhMN1oxTMyg1qemd1x+NkMcRstaZ3QP
         4xiNwLA1y0tUYwb3+Ll07Nji/x80lroB5i97YCjBUEEdbayVMJKsNXzSFJseGw68Ma33
         NYsA==
X-Forwarded-Encrypted: i=1; AJvYcCVE8jMV8+dzPwNmT+tGhANBmPm/iPBLmGSvia6iT46QnzFOMmQevyzNpuo+IJurwUu6MuTUjAs8updtJrMGX2aRG6d5G546rNDfpkGI
X-Gm-Message-State: AOJu0YxMfK5g6c+xun/wsCXFXGT3XSfKujKPCWMxagnzz1zt8TDesRnQ
	Jz8E9nTCrMIhss4uAyKFMRNYgo/1wRKfNk6mSoGWs4fAG2u8tJVhW0ml9Dy8Dhs=
X-Google-Smtp-Source: AGHT+IFYhjBMmBGtUDZ2xn8cKzlMdcIzdtP4Pr//gGImzZKdBkGIrfYAuAA/jvvzmKYFH8sWV/s/Mg==
X-Received: by 2002:a17:90a:d597:b0:2b0:e9bd:e794 with SMTP id 98e67ed59e1d1-2bd603e892cmr7116121a91.19.1716172711884;
        Sun, 19 May 2024 19:38:31 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ac16sm19073695a91.28.2024.05.19.19.38.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 May 2024 19:38:31 -0700 (PDT)
From: lizhe.67@bytedance.com
To: lizhe.67@bytedance.com
Cc: juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Subject: Re: sched/isolation: Fix CPU affinity issues for several task
Date: Mon, 20 May 2024 10:38:23 +0800
Message-ID: <20240520023823.31604-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240430033948.12165-1-lizhe.67@bytedance.com>
References: <20240430033948.12165-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Apr 2024 17:44:27 +0800, Li Zhe wrote:

>If the parameter of cmdline "nohz_full=" contains cpu 0, the cpu affinity
>of the kernel thread "kthreadd", "rcu_sched", "rcuos%d", "rcuog%d" will
>always be 0x01, that is, these threads can only run on cpu 0. This is
>obviously not in line with the original design.
>
>The root cause of this problem is that variables 'cpu_valid_mask' in
>functions __set_cpus_allowed_ptr_locked only contain cpu 0 before smp
>initialization is completed. If we call set_cpus_allowed_ptr and pass in a
>cpumask that does not contain cpu 0, the function call will return failure.
>Thread "kthreadd" and "rcu_sched" call the function set_cpus_allowed_ptr
>early in the system startup. Thread "rcuos%d" and "rcuog%d" inherit the
>wrong cpu affinity of "kthreadd".
>
>I tried to fix this problem by adapting the function set_cpus_allowed_ptr,
>but the variable task_struct->cpus_ptr will be referenced or modified in the
>scheduled process, which seems to make it more difficult to fix this problem
>by adapting the function set_cpus_allowed_ptr. So this patch clear cpu 0 from
>nohz_full range to fix this problem.
>
>Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
>---
> kernel/sched/isolation.c | 7 +++++++	
> 1 file changed, 7 insertions(+)
>
>diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>index 5891e715f00d..7b9bcfcd3c55 100644
>--- a/kernel/sched/isolation.c
>+++ b/kernel/sched/isolation.c
>@@ -152,6 +152,13 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
> 	if (cpumask_empty(non_housekeeping_mask))
> 		goto free_housekeeping_staging;
> 
>+	if ((flags & HK_FLAG_KTHREAD) &&
>+		cpumask_test_cpu(smp_processor_id(), non_housekeeping_mask)) {
>+		pr_warn("Housekeeping: Clearing cpu %d from nohz_full range\n", smp_processor_id());
>+		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
>+		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
>+	}
>+
> 	if (!housekeeping.flags) {
> 		/* First setup call ("nohz_full=" or "isolcpus=") */
> 		enum hk_type type;

Friendly ping. Could somebody give me some advice?

