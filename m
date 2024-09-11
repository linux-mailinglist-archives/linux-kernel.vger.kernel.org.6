Return-Path: <linux-kernel+bounces-324584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6663D974E87
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE012873C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22A1849E7;
	Wed, 11 Sep 2024 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juXk96rj"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2294183CCD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047056; cv=none; b=IkfxCe3RuoIyE38NVjYcK/nn9LriDQvF6FVmkg16pKzw9IuZhGBJU4c26M2+DHiOcBlkTlIRpFAGefZ3JTeasAOT+jtzudD8e6xJSKzj8W1QFz3XM9r2xj/cxjd/wzUMaGwpjRmyagyqJ6kHO7/2AS7TNuY99Xqc/sBnQ0Io6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047056; c=relaxed/simple;
	bh=/8SgJehhjAGO88IlldewWFs2KgAfI8cLjbzPRVcr1YU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XpzdFA6zDHRoNTh0Ck0WpHZuauZJGS9K043cPCx/+Pv2HaOMZM8948yvkYKIHjO4Z/vAjOWsAEF1bkbqHShcmsJXcIxMD2OZx92zTF43S1A8I9LdoJAvpMOjL+efZRm0qouutwNQqcCFTioo7FWsRhckbdhC0g/a3NI4fmUBHdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=juXk96rj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1ab008280aso3138955276.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726047054; x=1726651854; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIPB93isriVCRhj0WIuzCaItTxePKQBs+tjSg5k4Ryc=;
        b=juXk96rjLdzlBxbJvXUtzYIQPtxoUNtYJXSykARutp9hy61RH4PdgyuvMftLxNRWRA
         Urletq2t3yt7AdpJCh3iQ3QTozEqyN7QLo95X/QdJfMd6ochP/0O9K51qMdh5epaCrdL
         YGpKy+nFy79nBJ46mDySqEnTmiqCFhi8EchtD/xzwnB/tA419Fs5Ndlc9Is6FFZWalHP
         Avz7YoelD8l2cll10/wVCbE7vIzCGanEx6AW+O2ffnWs+L/2cieB3JlvOBSjK8Cb+UVn
         L+zTRH7OVDRkvzJwXsG6RS/OtJ4ddjtrGMlh8+6ekJU8xagnB/b6oOQRHWIDASsTlmYw
         FfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047054; x=1726651854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIPB93isriVCRhj0WIuzCaItTxePKQBs+tjSg5k4Ryc=;
        b=WngQziMZ1Qe6k4Fd403zjOy+oCIhStPuUg4VpBNOhtqoMhpRhCfZNz6GyZa3dQZ60A
         km372inlfuQRnOFENGA4UNF3pUSqK7DRE8vpybMDBc6rKLebMCOFL6QOjUpEfhA9fPst
         Kj5Ff89HJX9dbe2dT/8QbfquDmyE4eOU1edOaDzbhBQTeAoD4gdbApnwK6srLD7digy0
         1YwRFdAxByhzXb83C5UCIGrJ7PaptiNvJMByMXJ7qPXqKxcaUVq5q3HfqQrATuPqnBsU
         z8JSGxzvhFHMtlYQyOwnWSA2vogAKtwAxRp7n+8F45viZhn4EJABaNT9j0CeDWo55MAj
         BeQA==
X-Forwarded-Encrypted: i=1; AJvYcCVixaSeXkxAfKAJfF/68p1IkgUNUG+7xu61HnmRUMDpW1IeEqKjbIXwkmTJgsPFbwpNXr8INbJqFYh7xjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBS3d6C7G52V1p3dCyfnzH+3JCNaCTX3SNZIKFkH4N106f72IN
	oxNzo5hIktBIYjlf+tpq5NA86/6DVic3HCurGv20dkslU9tUBQKJtCOXLTiFMefYprY7OfTe8dF
	mlFxLUWpH7F6zj32OvA==
X-Google-Smtp-Source: AGHT+IF2SiSlHA5A9IgUvxBmmpL9JBXohsa0oAK6x+0ugHFFFRQb+SttHcejAg07bk/cX4Oc/0ZawYqPIQm+mLqf
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a25:d607:0:b0:e1a:44fa:f09 with SMTP id
 3f1490d57ef6-e1d8c260cc1mr2900276.2.1726047053855; Wed, 11 Sep 2024 02:30:53
 -0700 (PDT)
Date: Wed, 11 Sep 2024 10:30:20 +0100
In-Reply-To: <20240911093029.3279154-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911093029.3279154-5-vdonnefort@google.com>
Subject: [PATCH 04/13] timekeeping: Add the boot clock to system time snapshot
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev
Cc: kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"

For tracing purpose, the boot clock is interesting as it doesn't stop on
suspend. Export it as part of the time snapshot. This will later allow
the hypervisor to add boot clock timestamps to its events.

Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Christopher S. Hall <christopher.s.hall@intel.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index fc12a9ba2c88..e85c27347e44 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -275,6 +275,7 @@ struct ktime_timestamps {
  *				 counter value
  * @cycles:	Clocksource counter value to produce the system times
  * @real:	Realtime system time
+ * @boot:	Boot time
  * @raw:	Monotonic raw system time
  * @cs_id:	Clocksource ID
  * @clock_was_set_seq:	The sequence number of clock-was-set events
@@ -283,6 +284,7 @@ struct ktime_timestamps {
 struct system_time_snapshot {
 	u64			cycles;
 	ktime_t			real;
+	ktime_t			boot;
 	ktime_t			raw;
 	enum clocksource_ids	cs_id;
 	unsigned int		clock_was_set_seq;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5391e4167d60..db16c44dccc3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1060,6 +1060,7 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 	unsigned int seq;
 	ktime_t base_raw;
 	ktime_t base_real;
+	ktime_t base_boot;
 	u64 nsec_raw;
 	u64 nsec_real;
 	u64 now;
@@ -1074,6 +1075,8 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 		systime_snapshot->clock_was_set_seq = tk->clock_was_set_seq;
 		base_real = ktime_add(tk->tkr_mono.base,
 				      tk_core.timekeeper.offs_real);
+		base_boot = ktime_add(tk->tkr_mono.base,
+				      tk_core.timekeeper.offs_boot);
 		base_raw = tk->tkr_raw.base;
 		nsec_real = timekeeping_cycles_to_ns(&tk->tkr_mono, now);
 		nsec_raw  = timekeeping_cycles_to_ns(&tk->tkr_raw, now);
@@ -1081,6 +1084,7 @@ void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot)
 
 	systime_snapshot->cycles = now;
 	systime_snapshot->real = ktime_add_ns(base_real, nsec_real);
+	systime_snapshot->boot = ktime_add_ns(base_boot, nsec_real);
 	systime_snapshot->raw = ktime_add_ns(base_raw, nsec_raw);
 }
 EXPORT_SYMBOL_GPL(ktime_get_snapshot);
-- 
2.46.0.598.g6f2099f65c-goog


