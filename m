Return-Path: <linux-kernel+bounces-544748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39340A4E4BF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013041896024
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72527C851;
	Tue,  4 Mar 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ggFXJvHB"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC892857DD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102736; cv=none; b=M+G/sbs+XEniAMQoTKFOhQhg77Amzrrsw0djvZW6MtvlNvdVNf0doCA8z5tbXxc4ppQXoymSFEyqsDMJyO7aIpKTEdwa+DHWmzUGKPIDZATmxCteuVJfh1KGgGbOo388wuBvu/90U1sg+cx1eWLUNePkkI7LnSGPsHYC3jCW4Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102736; c=relaxed/simple;
	bh=sBkomMAtTTGImKblWaof3H+sklb+CZPuq62TvsZ9BT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4TZWi+KyGplBMs+u4WNG6htGLroe3G0jOhuygu5yOR8QyJwmlZ1Ji+6w+sovWmnb9L66sr8kceVON7mzvoCRLWs27hbWMqqW8BgyRfr5DtqSmqceEPz6rmpWFj5qMbApBojpW+UdMtjkG6z0bKN2jxIzVvvq1snBdV9P4mFd3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ggFXJvHB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso37984965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741102732; x=1741707532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEhwpcuno0WFjY8t9/+hary0RYULU8RVoeuO+wPInIQ=;
        b=ggFXJvHBhk3FyOTugMTLumv9ejhutG93f2c2njr6QhGBm/HpbSfBjnShqdQnZLjEay
         IrNcwvkou/rQNukBMJ0xRX9qpPYt0lbfP3Zqc0+Czb58++kGoiqZ0zzHFP4BpnjAFFz3
         DV+u0dp/I2Kl9Ru1/GC5+n3M0VIXZh2MPR9mt3614qMuBLatnBZt8YYt02b2XC3BJFY4
         wbyLyU5dWlkDHSg+NU4QAXhVpFYyN8UFtnhX9mSjCU57kiVW/J1bArNbm5hCbsnoF1do
         nk8bih0klWP0Le1l6FCGeBxFwLMSGBp1pQ4b2w0mezqruH2+3tL6wT6VCvV1faX67TqZ
         oSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102732; x=1741707532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEhwpcuno0WFjY8t9/+hary0RYULU8RVoeuO+wPInIQ=;
        b=tNv+4DPP09M7Hljjfz0SUSMY/RU7jwS9CQLf0Go4BEwKmuukRZ2KI/cEWwSVQ0kiFj
         1jLL+iSNZLzmL13Mj7Y3d1XBSCsvdU8ZvJ2b/cW2ChjDBpD6nzLpv8yUTFeo1ePoVrLU
         8+uS8atMiKVB+x5XWnuPxrM6BqgQn1cebsd+sPXvA5C834Uvs/cjMkmqqBYBCzsTbdeW
         VpOKYo3DGRjHqIuaI2qS4jabkqvsrhi1CNucogof4PmWRAvhqJiEPBTcjVg+pDz8fpUX
         9RTwFI7SHoaWemKj4Pxm3wywYH+FzVpOxpjmoWJBkW5yVqTigHQe9ykmjiZ75HFGaHaR
         2y6A==
X-Forwarded-Encrypted: i=1; AJvYcCW1yrpfle9mbbcDN7MgkoFB2ehKK90U7pcnK4Xo3yeaKoUAmxzZKwMBI9p+ubYIMj+x2RL1J7yzTGavFxE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3JIETSnB30qWIb/yuJ6wBGvLCo63Lil9x0VRHCAlPh6G8kna1
	P3BWtc+XBTN0NrDqLcnNMheZmATvfj4Ec8IEvZeeTmYfv7ssZOsq3lveBxc8C70=
X-Gm-Gg: ASbGncunrNjwXnSCfNnVF9iPvPgBZZiFoECF3z9LK81i3eUcIo+IXgkmE44ONTt2Yuq
	hbXzs0Vmmn5N62vszp25VmVI6YzZ8OrPJwFX2r1UPNzPO+RsmhzbkzphqX8+zEy2DLDsQbpvj1Y
	XL140tKioNrCAo00ZvPiY4hkgq+nb7WAxAtOjilFDmVloiVVgdVyREZjxJvYBvztI0qdWFvG0js
	9gDHC42TUxCVFrDXgdIMt6CmOC2NX6Ve3DdztBIURdEeOqXZMZm9HtcYQKiIDNh/Rcez2DY0RNd
	OOA2mkhCyNZTyiXAYyh9+2AovCT45anDW8X5n82moUAWbe4=
X-Google-Smtp-Source: AGHT+IEK7ULJaNBAjTgJI8C4sH5VL3JYp9ZcoPsT94hUTXeN1rzXj0hOcFllyp1216i8WCkMP8FL8A==
X-Received: by 2002:a05:600c:3ca3:b0:439:930a:58aa with SMTP id 5b1f17b1804b1-43ba665e31dmr166089505e9.0.1741102732343;
        Tue, 04 Mar 2025 07:38:52 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710ebsm238670625e9.26.2025.03.04.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:38:52 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 4/9] cgroup: Print warning when /proc/cgroups is read on v2-only system
Date: Tue,  4 Mar 2025 16:37:56 +0100
Message-ID: <20250304153801.597907-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304153801.597907-1-mkoutny@suse.com>
References: <20250304153801.597907-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As a followup to commits 6c2920926b10e ("cgroup: replace
unified-hierarchy.txt with a proper cgroup v2 documentation") and
ab03125268679 ("cgroup: Show # of subsystem CSSes in cgroup.stat"),
add a runtime message to users who read status of controllers in
/proc/cgroups on v2-only system. The detection is based on a)
no controllers are attached to v1, b) default hierarchy is mounted (the
latter is for setups that neven mount v2 but read /proc/cgroups upon
boot when controllers default to v2).

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup-v1.c       | 7 +++++++
 kernel/cgroup/cgroup.c          | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index c964dd7ff967a..95ab39e1ec8f0 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -168,6 +168,7 @@ struct cgroup_mgctx {
 
 extern struct cgroup_subsys *cgroup_subsys[];
 extern struct list_head cgroup_roots;
+extern bool cgrp_dfl_visible;
 
 /* iterate across the hierarchies */
 #define for_each_root(root)						\
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index e28d5f0d20ed0..5c59b01024019 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -673,6 +673,7 @@ struct cftype cgroup1_base_files[] = {
 int proc_cgroupstats_show(struct seq_file *m, void *v)
 {
 	struct cgroup_subsys *ss;
+	bool cgrp_v1_visible = false;
 	int i;
 
 	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
@@ -684,12 +685,18 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	for_each_subsys(ss, i) {
 		if (cgroup1_subsys_absent(ss))
 			continue;
+		cgrp_v1_visible |= ss->root != &cgrp_dfl_root;
+
 		seq_printf(m, "%s\t%d\t%d\t%d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
 	}
 
+	if (cgrp_dfl_visible && !cgrp_v1_visible)
+		pr_warn_once("/proc/cgroups lists only v1 controllers, use cgroup.controllers of root cgroup for v2 info\n");
+
+
 	return 0;
 }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index afc665b7b1fe5..3a5af0fc544a6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -171,7 +171,7 @@ EXPORT_SYMBOL_GPL(cgrp_dfl_root);
  * The default hierarchy always exists but is hidden until mounted for the
  * first time.  This is for backward compatibility.
  */
-static bool cgrp_dfl_visible;
+bool cgrp_dfl_visible;
 
 /* some controllers are not supported in the default hierarchy */
 static u16 cgrp_dfl_inhibit_ss_mask;
-- 
2.48.1


