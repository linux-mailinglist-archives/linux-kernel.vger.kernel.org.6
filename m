Return-Path: <linux-kernel+bounces-179515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6548C60B3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA641F21FE3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B313BBC1;
	Wed, 15 May 2024 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ODHdMt68"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2063A1AC
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754043; cv=none; b=B7TMMHN4slckOYhLS8DnUo577LG1FjguFc8enRH9GGItszanTWbeQlSZiGrXjf9YoFcEHMNn4kFeXq6YTNaKe8ft6Iwcr/08wbXiYeXmkxRiGDtLaMfHxj7zTqEXqFcz+G1kTqEQt0RCphd3WyYm6HxFHC3znm3l8FM6U7BJaK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754043; c=relaxed/simple;
	bh=s3hMnneki/xCehK7eUpMW9xHCWCBE5YEqu/0puPv3OU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKCu9YxbIJhNL6fJJiLDO3ATyXbi3fmWERDzLsXryb1R7uPJIyf8lWjIF2+zdRs993Qge8ZJlBl9KgdvfVvm59YY4bfTLS3BZdbCyK7UcpP6zE/4Rfo178uMdhMhYiWCwLY+OuZ1ci/aaNswpt/HG5v9HVJDJfBg8q5tDblSoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ODHdMt68; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2b6208c88dcso5022198a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 23:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1715754040; x=1716358840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPp84dK/TP4O+E01WOilhkZ88ufy3AD5Z9rfCYlBsMk=;
        b=ODHdMt68OGUskTUciLb/ixSXlQoVGuneYEgjU15VUuPu/bwS+SsbrIphDOzchBBfbL
         eZbBJs80UqDwxJWtu0zvtS+FAVGlfGwRLVrMcNETYR0sgZkFTneFrDvGsmB8LmjYcnkV
         k9XLaC/7aJX3BVkI9DqYunJLHP0n1bwhnc42X4Q/6Eu2cINw0ZzAq5ior0s9nDXrbz/u
         Ew298HUloXAubJ/juq2eGL8nxxL3/DoCfs0hUy0R/eyDGjB6L+zu9+j3NOICeksBJTXV
         SaxHyMzsAUh/OwWgOF4e0S5QkGl2kdi13nGxV+ofS4IWpxEd3k4LRyO4WITZUpFNJa1L
         SOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715754040; x=1716358840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPp84dK/TP4O+E01WOilhkZ88ufy3AD5Z9rfCYlBsMk=;
        b=nL92gYFR9LhgkS5JSKwMdGX23CEQ1v5ar0hNSpOcvXv+oyWJFguFS73eRdH6z4nbKy
         LEyXJFw72mpIwzs/Xjft5cI1nurjgQuc+LnnWwTFY4bMwwois2qpbF5Mlyk6WEALo0Z1
         eUzgxwsQc9SZr3jRKUk1V5roRp0Jyb9GA55JbigdzUNhITQVVlbgR9lwfNbE5/Jm47iJ
         wHUwanMpl0WVvO/fNdVmsfx/vQEXvjPOCMSj+Nn4Z9uFGG29r2hD2mL+uv+1DkIf+tyx
         QFflBEFuy3ujOFEmjed2dT6VYY9HjIm6L4milNIew95p5A0dj5MsUDIizBr9Avrms/tA
         dmcg==
X-Forwarded-Encrypted: i=1; AJvYcCXHO+POS/rG13K8X9ToPQ+bsvpS0rS0pbsXAaTynkzBhZbRM1lmtwKPo324PZYj+xWxNr+ZDuFdKzGrUgkHzsAkHwA49flWK8bfJfgr
X-Gm-Message-State: AOJu0YwtArNYlo2IxaflUmfRGbeTZ5FNfmXuoGIvbRIVM3aAff6lA4lo
	w/bhY61wofkhrEHFRnDQEhhH6P6hzzQu6FfxN5qddW949k9SKl4W9YL31tII4d9U/0JgxQNGLTe
	6
X-Google-Smtp-Source: AGHT+IEkUavsy1YWv/qicLKe9PIwCoSOIz69b8mCVNDFboxtIWn5GXanEy1bkFItdVpeqmQyZYp7vw==
X-Received: by 2002:a17:90a:a586:b0:2b6:2067:dd15 with SMTP id 98e67ed59e1d1-2b6ccef5ebamr13087553a91.40.1715754040500;
        Tue, 14 May 2024 23:20:40 -0700 (PDT)
Received: from GQ6QX3JCW2.bytedance.net ([203.208.189.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671782d7bsm11948761a91.51.2024.05.14.23.20.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 May 2024 23:20:40 -0700 (PDT)
From: lizhe.67@bytedance.com
To: lizhe.67@bytedance.com
Cc: juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org
Subject: Re: sched/isolation: Fix CPU affinity issues for several task
Date: Wed, 15 May 2024 14:20:34 +0800
Message-ID: <20240515062034.61601-1-lizhe.67@bytedance.com>
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

