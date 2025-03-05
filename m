Return-Path: <linux-kernel+bounces-547345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8879A5060A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF27B169D83
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830B21AAE28;
	Wed,  5 Mar 2025 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P1p3UOO0"
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818721A841A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194582; cv=none; b=DcgTBS8GE5DMoM812ao6N6MJHx8XJGhj9/i2eM/qI/dDWQTrp4wnAv7SWUSJk31zFVKaZ107KFdx0ZUjH3Be6mM0KI+xrquMVBPXUybhOfvehyNd+BCs20exJLBdCmLi0ruEWfgdviTzn/tG9saWKPtB5cuhe+9mIppU7KifR08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194582; c=relaxed/simple;
	bh=irFcCVMJ+YoW6k8byXnRJIVW9wTUS4yGDTwhsoaB6Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I2gGiM9WdvoC0vM5LePqwWfNmfDTZP2Ky7fH2Qj175KSsHpZSdnFAKHmRPG2s8xPDgoBSf6lk2Q05xWIUKrhnyx0Qp+BlWcXGeSWd5pGX7Hqdkgvd7Tk/RKhSz4dPdYuVsWILioeb+YROiAEoFMDRI/COzkx+YkiTtadnFWotB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P1p3UOO0; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43bbc8b7c65so41438075e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741194579; x=1741799379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xwduz/qNPiyy4RhwG9d9PScJsmgmVdCqCQSC6jOGw4=;
        b=P1p3UOO0b9YDJTFpWR4YE+ZSKZf6Xcn52yudVG+sPHwyBxBtardW009r9baCZcBeB4
         4YrBwUNx2JnWKUZCwE8P5GXIHIEPQ0jNvCevdy2YOChbqBHkzpHt/1wzFn5RYouw4lg7
         Ubnyj/AmJTt084JQMIhTcWp0jpVFjR0Xndt2RDe864mTy2ddPAAr0onst3U6rKkFxD45
         H0M4bgWyKxC98MlJmxb9oAlG/J9F2VNQt4FJxc+tUtjyiDfKCDHtPn8v130bldZUxkdd
         1L/Pie03mBgGdJDVfupW8ScDCv5mNHuWB5VmdaSSZ68xZEXatoTBkzENiNCy/KsCr8T5
         oqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741194579; x=1741799379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Xwduz/qNPiyy4RhwG9d9PScJsmgmVdCqCQSC6jOGw4=;
        b=ktBpBQa+TKudCas7iZ1VDcl49Ka5pMu9/t+FkGN5PaC0L8y7d7ezelwquKrR+hvzeu
         EmfZcr17rXnvxyM8QbtME5aXengHm5n8wWddTxxDknamtQr25HCKnm4q/uA6OpfUmb+C
         1yPtNAshsvTxWp3FucT9NF+3hunzz/EENTVy8m1YTn7L9Ab99+NNnG9ZEwameD0RdX5T
         X3eYwL1fe9A6KnVIdYOubhh/XJU7TwokCT8s6rOQlUr///lPNfBsTfpNonT60Fw7DcTB
         6S71G/QuI2NJWOB6MqtwO65crxJWgxePBka4fy2JjpNYF/fjrZcKYcekybvU+nimO/La
         fCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+nzsR9lRy9dCekAmbiloEBiQyBEE8cGwu2qdojChzEW/Cim8t5Y8qPFN08kQ+wDKw4JlBbZeRHYdls1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxrLyyt9GY3xJyliit/4LLwgaWFa63NNjTWdN6KO//++cgMNW
	iQkjtczcrjwxMH6MsKrR36IBl3VOxQlm653pT84Tz1ivgupbyCrIWGUJVhq6r3c=
X-Gm-Gg: ASbGncuL8VZ2SH7UWgCHAzuZBA08sZqIS+SsQvDnTCrriewyNfqW8K8iDN9SAA0noe0
	vZtBGP0cqe4N1TB7OKWFP6Y2LPhnaiUSuFPZBo5xKW53l6P6bibUqD9EgMzcF7cXG2jmOoyrUcM
	iIb7cgRbhfCeDtjVOa9BrfFkneaMNiL3zJKNL7zytuCBL4xma/B6ut1JzJzM+LRGFvJMYzgUygM
	7hO3iHYY2tZ5MOAhEY1UODr+uq6CtyRK/NAX2D8+hmTJA0A6vT8eVcdWeQbiITISUbSynNupiZz
	zthbaBe9ypfT2y0DDLVPpqpQt95cA7aaye2pPxMxmpHrLX4=
X-Google-Smtp-Source: AGHT+IHtALOlZRY8OEkAfMy/8LP4eO3WEczzKfPhSQDmbP+zhNlJTZUTR0mJ/R+5FMnzK/l5vhD0mw==
X-Received: by 2002:a05:600c:1d01:b0:43b:cf12:2ca6 with SMTP id 5b1f17b1804b1-43bd292e1cemr28484335e9.1.1741194578635;
        Wed, 05 Mar 2025 09:09:38 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6ceesm21323862f8f.45.2025.03.05.09.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 09:09:38 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cgroups@vger.kernel.org,
	Jan Engelhardt <ej@inai.de>,
	Florian Westphal <fw@strlen.de>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Date: Wed,  5 Mar 2025 18:09:35 +0100
Message-ID: <20250305170935.80558-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The xt_group matching supports the default hierarchy since commit
c38c4597e4bf3 ("netfilter: implement xt_cgroup cgroup2 path match").
The cgroup v1 matching (based on clsid) and cgroup v2 matching (based on
path) are rather independent. Downgrade the Kconfig dependency to
mere CONFIG_SOCK_GROUP_DATA so that xt_group can be built even without
CONFIG_NET_CLS_CGROUP for path matching.
Also add a message for users when they attempt to specify any
non-trivial clsid.

Link: https://lists.opensuse.org/archives/list/kernel@lists.opensuse.org/thread/S23NOILB7MUIRHSKPBOQKJHVSK26GP6X/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/netfilter/Kconfig     |  2 +-
 net/netfilter/xt_cgroup.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

Changes from v1 (https://lore.kernel.org/r/20250228165216.339407-1-mkoutny@suse.com)
- terser guard (Jan)
- verboser message (Florian)
- better select !CGROUP_BPF (kernel test robot)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index df2dc21304efb..346ac2152fa18 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -1180,7 +1180,7 @@ config NETFILTER_XT_MATCH_CGROUP
 	tristate '"control group" match support'
 	depends on NETFILTER_ADVANCED
 	depends on CGROUPS
-	select CGROUP_NET_CLASSID
+	select SOCK_CGROUP_DATA
 	help
 	Socket/process control group matching allows you to match locally
 	generated packets based on which net_cls control group processes
diff --git a/net/netfilter/xt_cgroup.c b/net/netfilter/xt_cgroup.c
index c0f5e9a4f3c65..c3055e74aa0ea 100644
--- a/net/netfilter/xt_cgroup.c
+++ b/net/netfilter/xt_cgroup.c
@@ -23,6 +23,13 @@ MODULE_DESCRIPTION("Xtables: process control group matching");
 MODULE_ALIAS("ipt_cgroup");
 MODULE_ALIAS("ip6t_cgroup");
 
+#define NET_CLS_CLASSID_INVALID_MSG "xt_cgroup: classid invalid without net_cls cgroups\n"
+
+static bool possible_classid(u32 classid)
+{
+	return IS_ENABLED(CONFIG_CGROUP_NET_CLASSID) || classid == 0;
+}
+
 static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 {
 	struct xt_cgroup_info_v0 *info = par->matchinfo;
@@ -30,6 +37,11 @@ static int cgroup_mt_check_v0(const struct xt_mtchk_param *par)
 	if (info->invert & ~1)
 		return -EINVAL;
 
+	if (!possible_classid(info->id)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -51,6 +63,11 @@ static int cgroup_mt_check_v1(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (!possible_classid(info->classid)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);
@@ -83,6 +100,11 @@ static int cgroup_mt_check_v2(const struct xt_mtchk_param *par)
 		return -EINVAL;
 	}
 
+	if (info->has_classid && !possible_classid(info->classid)) {
+		pr_info(NET_CLS_CLASSID_INVALID_MSG);
+		return -EINVAL;
+	}
+
 	info->priv = NULL;
 	if (info->has_path) {
 		cgrp = cgroup_get_from_path(info->path);

base-commit: dd83757f6e686a2188997cb58b5975f744bb7786
-- 
2.48.1


