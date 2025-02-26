Return-Path: <linux-kernel+bounces-534759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD563A46AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 20:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E55D16E48B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0623A99B;
	Wed, 26 Feb 2025 19:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T9CLWFGF"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707F22D79F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597663; cv=none; b=QPm5Ul4qPbxain1Z3rapf+QwOlZpYLjCGO5lBQFY5vrK5PmWP/BAkSD38Phwc/uJ15J47PJ8aO3LK4nw5zSBaOu7jkBXoxjEswtyLT+sIzZH1l1xASPSL9Y2brp9S/D8wGRlRo+G7N46RrJY7hp/D11xE9FgH9TCkqL2UTEwtw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597663; c=relaxed/simple;
	bh=f3D5SzrEgNHbb8uoACbdyA7D/ocFrbJamaLh8HLKBTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcfU+91yPLSaB54X+UzMbYnyii8oaWtUARFP6CWoXttNSKzq1tz/8arnf1uhKa7Y+AN5fOidP52BwushC21CCIxAvGuICBL08NwREyIuliiGOefNb1xrVq2kHR72PeL9yTd4iYnoZogPrAyARgXthf48JAz9keD0B8oYNFyzBuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T9CLWFGF; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234bec7192so2524835ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 11:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740597660; x=1741202460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftDlP5dl9GiHDKQQcwmxqQBAFQOLT3kYr7RqF+evPv4=;
        b=T9CLWFGFyxObY7Qdi9ncQ7o6G+xyuOxMupLBqbOD9c3DAw/QZfPyBVK27YA50802io
         qORMbZQpF/wfrBqnpiPnoX2Gl+fA4zbS7JrILqyiKmOupXC+iK6/rXHbtEPowXIvsAYz
         OaCr5vzX/awnAEXfEjknAMKq03TMaICLZl0qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597660; x=1741202460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftDlP5dl9GiHDKQQcwmxqQBAFQOLT3kYr7RqF+evPv4=;
        b=tJhSa7Zcox3gvOpAixalBjr4DHiE5qLi9a2h9bGqr2+u6gV71FzxJbzCOKACb42WFN
         FV9MpFyJMAe7JGD7lqLk5REOGis88nl1DR2Oh08CJZ1uIcTekk07jL7JXOKjDdPjKD/H
         nTYFDlrTIxB183lGIF4Ad7R0+v2c8V2RkovMdzPLpRl0p2IT7BuWPFVWEbNliG6efTKx
         kEGY8dKrgqXqlqPMzPOaCFtjX8AZvkvEKnJmdx+kWhEt1HvO8SjbGviaX55MOMwx+Nj6
         KvHp0aOM6s0Iravgxo6sPh0Qk51hSTJZlcg3//csb6C9VLYnWN+atxPTaCE1qHSlqyyf
         A2Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVqKnHszaJGXkHGKDwl3sa2x74IIdi0m0sza/fLQiX0ZuxD8+rCQYy8Mwuhk88x/PQbbvmoStmJBFDkO/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxAQ3kEBOwIBinT7UJP3oJVntoQOG6SMsGMNlWG70BuPUmfCns
	yy8I0N/nja4JSQ7YFHm5lh2cfRxEZl8f74zUCBRYlKieA6lrlkh9x1KZlTfKHw==
X-Gm-Gg: ASbGnctz3upcfj1NKgjuoaMHf0H+fXnEjaQV6DyjJmRlX8BThAV/sA4PQksVIpqRW/6
	DBxfTdFh335pCE7FSy0liz3zka3NYcxia+riWxLCbdPvtA3uVoFvz67qjPjMPvgOlN9O8ksbPxc
	fA+IZXuorUoCocfG0bbSvoWqwq+qbdL+T2RBfl7xHT2G1U3nrnSiU2NWDWhRnP9ek55NRU/ITX9
	/lG1TEvjFFn+jkJkmTtzYbFco2z9Twd4JIP1TwAVlg3Hbpy7wwa8ddKhR8zXmcQ3nvGibOEc/hC
	WYnKn5mJfMmwhN/pHAXeq4ZmT1a/FxY0V06GqOcsKaTnufKjNp72WOvFtucENP4w9tcoPFgLcT8
	+KebjmCL0m1bi
X-Google-Smtp-Source: AGHT+IEw7fjT6gjAu149mqZBw/+HbKxFMCO0gdM2niphUvj6eNocm8iaPbU/SjDPbzzxoTCe6NQ10A==
X-Received: by 2002:a17:902:d50a:b0:220:d1c3:24d1 with SMTP id d9443c01a7336-223202136b8mr65669475ad.46.1740597659906;
        Wed, 26 Feb 2025 11:20:59 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22341c04d16sm8473865ad.190.2025.02.26.11.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 11:20:59 -0800 (PST)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v15 1/3] lsm, selinux: Add setup_report permission to binder
Date: Wed, 26 Feb 2025 11:20:45 -0800
Message-ID: <20250226192047.734627-2-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250226192047.734627-1-dualli@chromium.org>
References: <20250226192047.734627-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thiébaud Weksteen <tweek@google.com>

Introduce a new permission "setup_report" to the "binder" class.
This persmission controls the ability to set up the binder generic
netlink driver to report certain binder transactions.

Signed-off-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Li Li <dualli@google.com>
---
 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/security.h            |  1 +
 security/security.c                 | 13 +++++++++++++
 security/selinux/hooks.c            |  7 +++++++
 security/selinux/include/classmap.h |  3 ++-
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 9eb313bd0c93..5291cd712147 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -33,6 +33,7 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 	 const struct cred *to, const struct file *file)
+LSM_HOOK(int, 0, binder_setup_report, const struct cred *to)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/security.h b/include/linux/security.h
index 27f64a9747f8..28fcd7047051 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
+int security_binder_setup_report(const struct cred *to);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(const struct task_struct *target,
diff --git a/security/security.c b/security/security.c
index c9fae447327e..6212158cec72 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct cred *from,
 	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
+/**
+ * security_binder_setup_report() - Check if process allowed to set up binder reports.
+ * @to: receiving process
+ *
+ * Check whether @to is allowed to set up binder reports.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_binder_setup_report(const struct cred *to)
+{
+	return call_int_hook(binder_setup_report, to);
+}
+
 /**
  * security_ptrace_access_check() - Check if tracing is allowed
  * @child: target process
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b49f28f15ed1..12da5861ec18 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2092,6 +2092,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
 			    &ad);
 }
 
+static int selinux_binder_setup_report(const struct cred *to)
+{
+	return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDER,
+			    BINDER__SETUP_REPORT, NULL);
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
@@ -7176,6 +7182,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
 	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+	LSM_HOOK_INIT(binder_setup_report, selinux_binder_setup_report),
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 8a8f3908aac8..11e6fa92799b 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -133,7 +133,8 @@ const struct security_class_mapping secclass_map[] = {
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket", { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder",
-	  { "impersonate", "call", "set_context_mgr", "transfer", NULL } },
+	  { "impersonate", "call", "set_context_mgr", "transfer",
+	    "setup_report", NULL } },
 	{ "cap_userns", { COMMON_CAP_PERMS, NULL } },
 	{ "cap2_userns", { COMMON_CAP2_PERMS, NULL } },
 	{ "sctp_socket",
-- 
2.48.1.658.g4767266eb4-goog


