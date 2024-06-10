Return-Path: <linux-kernel+bounces-207643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9507901A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595741F2197B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389A1D27E;
	Mon, 10 Jun 2024 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOlCm7Hw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC611A935
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717995945; cv=none; b=UCEhiibNCDUeSsHOrvFQFN9VORiAOf1WvFGAF4q73DCSQglFKIQlPmI+VF96Jz/p23+0eRM0nxeABx3qYsNCUuvnbpY0rp9tVh6511O9kYiEmKNcB2mnEGgtOeQYcU/ayRAPobkadtsOxK0FPKjYMYkTe4nXF5mTtfcEekd0qSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717995945; c=relaxed/simple;
	bh=j5FOGXUAnWdoxutm5x8dUNPxVoD2pcujMYaDuA1Q0V8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=PsWiEGuc+rmiUEzgMNaD9qe5XCnbnEjlXxCtBnEmbWLnG3MlwKtAOePPZQrPRUJirzXGoZM/F8d6+ZOJoe5O/UXuQpixYrAJfM0Stdzby/oMuh1kTqnYfLofQHuef7M6aQhReJ2EX6Zg/4UgbCH7lzf4jM8Sj249LakunB7U5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOlCm7Hw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717995941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K+Co83OGYBm+sqUn8+I1zL3le/ONfd0wGvFj8DcJCyI=;
	b=cOlCm7HwLMA47pDfxmM3rLFvgyquyFSVe8MAkGfvoHWY9xXNJ7l92mBKqPODlMxBNa6RxE
	ntIF63cIZfW5MjKgKUwsD0I4ecQpHakexox2RIAa4LHtHdMPsO2qy3VZTznTCOZuY5kwFb
	BsCNiod0AN3mMx5aBFHUgu1b9c8TsnE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-m57kS11sP_ScW5MnkHpEfw-1; Mon, 10 Jun 2024 01:05:39 -0400
X-MC-Unique: m57kS11sP_ScW5MnkHpEfw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f6efc8759dso19085325ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 22:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717995939; x=1718600739;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K+Co83OGYBm+sqUn8+I1zL3le/ONfd0wGvFj8DcJCyI=;
        b=B37nc2Q+arMnPXwR2I4B0Y0YccoGEfRiMxUtctGcrOj7o3i3962tNszqcCYCIZOaKg
         QQlFAxPyKjjAS9NQWQsWKe7wUG4U6qNMlnatzVnm81Y7j4ILYZzwPYK56pc6AfYdDXXh
         TJkdfYMZeAOhNnoLpcoCOryDqykAkkxHyVAjBncOtidwtXVa7onBwadGEbxdzwRgnSjU
         bUyOKwlnPjs5gJ9ZY05EGO/91rwlnxSlad4qx56p7OT4d4e1xCQBFlBkHc50NKSpCvsZ
         5anGJimG0F1OQTIU8XWMxLDnanU8nGZvi+W8oUG//HdJWpnWEnuFmTg+YBsz/Nsda3xB
         sqxA==
X-Forwarded-Encrypted: i=1; AJvYcCXea4rELtcFdrW8Onoegpw1Ismh4lmtbcMQmJm75l8p9uv6ElD3XStSQpgsKg/hKuU5510M9GUYqrYxnEjXyvgeohSJli+aWYwfGZ00
X-Gm-Message-State: AOJu0Yw9xcDqwxUC+jK4lJiCr50QnoEa6LACYecDHrfiLJxTw9okWMrw
	9noB/fpQ+vb1poCZzxKA+t8sqjDcfgTYPOLeos6r4QgaIW5QTfmY2gPFNMTU1u6w9UsMC6wkUaQ
	ZW484rzqFGz+d9ZNGWHZDKB+2FIuHmr/8n+IJShDVy/95jUH1xqBUE6R/LPDyvg==
X-Received: by 2002:a17:902:e84a:b0:1f7:37f:728d with SMTP id d9443c01a7336-1f7037f75d2mr42733425ad.10.1717995938745;
        Sun, 09 Jun 2024 22:05:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZrBxGN8O94i/3gd9WUfR06d4I4seD2bQhvFhs6wpLXAlouIdkBGIGfJiiItq/d8bB0CehvQ==
X-Received: by 2002:a17:902:e84a:b0:1f7:37f:728d with SMTP id d9443c01a7336-1f7037f75d2mr42733255ad.10.1717995938280;
        Sun, 09 Jun 2024 22:05:38 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:877f:c7e:9687:60e7:1766])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6f4bda999sm33104285ad.244.2024.06.09.22.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 22:05:37 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH rcu 6/9] rcu: Add rcutree.nocb_patience_delay to reduce nohz_full OS jitter
Date: Mon, 10 Jun 2024 02:05:30 -0300
Message-ID: <ZmaJmhgpzVVyZtnC@LeoBras>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240604222355.2370768-6-paulmck@kernel.org>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop> <20240604222355.2370768-6-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 04, 2024 at 03:23:52PM -0700, Paul E. McKenney wrote:
> If a CPU is running either a userspace application or a guest OS in
> nohz_full mode, it is possible for a system call to occur just as an
> RCU grace period is starting.  If that CPU also has the scheduling-clock
> tick enabled for any reason (such as a second runnable task), and if the
> system was booted with rcutree.use_softirq=0, then RCU can add insult to
> injury by awakening that CPU's rcuc kthread, resulting in yet another
> task and yet more OS jitter due to switching to that task, running it,
> and switching back.
> 
> In addition, in the common case where that system call is not of
> excessively long duration, awakening the rcuc task is pointless.
> This pointlessness is due to the fact that the CPU will enter an extended
> quiescent state upon returning to the userspace application or guest OS.
> In this case, the rcuc kthread cannot do anything that the main RCU
> grace-period kthread cannot do on its behalf, at least if it is given
> a few additional milliseconds (for example, given the time duration
> specified by rcutexperiementationree.jiffies_till_first_fqs, give or take 
> scheduling
> delays).
> 
> This commit therefore adds a rcutree.nocb_patience_delay kernel boot
> parameter that specifies the grace period age (in milliseconds)
> before which RCU will refrain from awakening the rcuc kthread.
> Preliminary experiementation suggests a value of 1000, that is,

Just a nit I found when cherry-picking here
s/experiementation/experimentation/

Thanks!
Leo

> one second.  Increasing rcutree.nocb_patience_delay will increase
> grace-period latency and in turn increase memory footprint, so systems
> with constrained memory might choose a smaller value.  Systems with
> less-aggressive OS-jitter requirements might choose the default value
> of zero, which keeps the traditional immediate-wakeup behavior, thus
> avoiding increases in grace-period latency.
> 
> [ paulmck: Apply Leonardo Bras feedback.  ]
> 
> Link: https://lore.kernel.org/all/20240328171949.743211-1-leobras@redhat.com/
> 
> Reported-by: Leonardo Bras <leobras@redhat.com>
> Suggested-by: Leonardo Bras <leobras@redhat.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
>  kernel/rcu/tree.c                               | 10 ++++++++--
>  kernel/rcu/tree_plugin.h                        | 10 ++++++++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 500cfa7762257..2d4a512cf1fc6 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5018,6 +5018,14 @@
>  			the ->nocb_bypass queue.  The definition of "too
>  			many" is supplied by this kernel boot parameter.
>  
> +	rcutree.nocb_patience_delay= [KNL]
> +			On callback-offloaded (rcu_nocbs) CPUs, avoid
> +			disturbing RCU unless the grace period has
> +			reached the specified age in milliseconds.
> +			Defaults to zero.  Large values will be capped
> +			at five seconds.  All values will be rounded down
> +			to the nearest value representable by jiffies.
> +
>  	rcutree.qhimark= [KNL]
>  			Set threshold of queued RCU callbacks beyond which
>  			batch limiting is disabled.
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 35bf4a3736765..408b020c9501f 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -176,6 +176,9 @@ static int gp_init_delay;
>  module_param(gp_init_delay, int, 0444);
>  static int gp_cleanup_delay;
>  module_param(gp_cleanup_delay, int, 0444);
> +static int nocb_patience_delay;
> +module_param(nocb_patience_delay, int, 0444);
> +static int nocb_patience_delay_jiffies;
>  
>  // Add delay to rcu_read_unlock() for strict grace periods.
>  static int rcu_unlock_delay;
> @@ -4344,11 +4347,14 @@ static int rcu_pending(int user)
>  		return 1;
>  
>  	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> -	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> +	gp_in_progress = rcu_gp_in_progress();
> +	if ((user || rcu_is_cpu_rrupt_from_idle() ||
> +	     (gp_in_progress &&
> +	      time_before(jiffies, READ_ONCE(rcu_state.gp_start) + nocb_patience_delay_jiffies))) &&
> +	    rcu_nohz_full_cpu())
>  		return 0;
>  
>  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> -	gp_in_progress = rcu_gp_in_progress();
>  	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm && gp_in_progress)
>  		return 1;
>  
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 340bbefe5f652..31c539f09c150 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -93,6 +93,16 @@ static void __init rcu_bootup_announce_oddness(void)
>  		pr_info("\tRCU debug GP init slowdown %d jiffies.\n", gp_init_delay);
>  	if (gp_cleanup_delay)
>  		pr_info("\tRCU debug GP cleanup slowdown %d jiffies.\n", gp_cleanup_delay);
> +	if (nocb_patience_delay < 0) {
> +		pr_info("\tRCU NOCB CPU patience negative (%d), resetting to zero.\n", nocb_patience_delay);
> +		nocb_patience_delay = 0;
> +	} else if (nocb_patience_delay > 5 * MSEC_PER_SEC) {
> +		pr_info("\tRCU NOCB CPU patience too large (%d), resetting to %ld.\n", nocb_patience_delay, 5 * MSEC_PER_SEC);
> +		nocb_patience_delay = 5 * MSEC_PER_SEC;
> +	} else if (nocb_patience_delay) {
> +		pr_info("\tRCU NOCB CPU patience set to %d milliseconds.\n", nocb_patience_delay);
> +	}
> +	nocb_patience_delay_jiffies = msecs_to_jiffies(nocb_patience_delay);
>  	if (!use_softirq)
>  		pr_info("\tRCU_SOFTIRQ processing moved to rcuc kthreads.\n");
>  	if (IS_ENABLED(CONFIG_RCU_EQS_DEBUG))
> -- 
> 2.40.1
> 


