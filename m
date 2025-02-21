Return-Path: <linux-kernel+bounces-526295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D7BA3FCD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06844189188E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA9244EAB;
	Fri, 21 Feb 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f7m7PSE7"
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB84246325
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157381; cv=none; b=a0Di+UzN8nyLh7NhD9gnX0inEfsWGVOaohR1tzwiaTLAuOReBiwVSRs3LVYMAUCUTsvciB10+QQK7lIzfebaesNmtUERQZrC7+i3JKWOcm7a4L8zgF/490Bkk6+30ZkouZg3JrZJ+ZeBysgZkYZj52wfYzr1mvloVJh0NuulA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157381; c=relaxed/simple;
	bh=p26yxnUhbdMRoiqj6XHxuH9YLkbrUj4rKzuTeUEX3o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kc4GzXnFczOXktheXEyVF5MsQkLyek26W836s58+m4z3gRcum47SPysR914Bi7l5PHCev/O3pYeQY+2A+6olzTKjljzd4OIMJ144d+5AQYNI6YbWgQxXYgxwDItmM9+NepCtJgg8dLe9fKT6/bFiGKrwhADNUM4UrceQWf7q0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f7m7PSE7; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so3568814a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740157376; x=1740762176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWszliNKbmL8VUqL0WBW3MKacH8rbha5eqW1pX7oPq8=;
        b=f7m7PSE7CbLc5EfFMwi5bGPy2nHJYOCJBaGL6ffvkTB9gNxh8RPdvhw6SoImkvRQRN
         ppTnnJB3oEsFvS/iontAf7ZowZOBsuduoBpYirzmGlq9EuoSFS54zH0M9862jk0kZQ1M
         gV5wLfKv4HKCQFP6bCkB5DKdcl0AHCjHnhrC81t1CSHw3q1lwzQsmlhmsvC8FWL0XBSh
         6pfT6EMt6cuFMoWo/0GNS+oQIQ9GWL+fkN1eKOTinNeq/6olFn/Ilr8m31DoFOMhd54k
         2z7Re/sfPj4BMsnNebyo3I5IhbPdlLoXVqYKHK9lik+dj/Ryv+huwsAKr7OvwfTobhQr
         DlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740157376; x=1740762176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWszliNKbmL8VUqL0WBW3MKacH8rbha5eqW1pX7oPq8=;
        b=l15c6BsHfwuPKVHsSns+ejOIxGfw6IZIMofJ4K6oGqHX4GNtASHNw90B6/sjjTZk/o
         RXZ7LCQE4CdzaxFteAbnxGIcH3e1IfvKhVcDDQBFVB60QotTcL8+HB1c0goFwUv9oKnT
         nW24L2grICxdjpIzBBKJtlwvtBjyG3IoYjtjpCvceNGKfTBho6/EPYzQ0ueueZ83eASP
         JkZr22DZY9rgnL6rTA2LgRe/5B9rgWXbOZ9pbGGvWNMBiVG7hDySEHOhKWXY0HqgT3cd
         kgY2Jjp3CCSucddiLUKGIPMto0pE1Ky74I4wS6hARZmVMpXLQstrFX2VF18BHbFVvoLd
         AwVg==
X-Forwarded-Encrypted: i=1; AJvYcCVkHoiDoc25dkZk2rGKNYcLmdRlnzliKoXMpuT704dVaVOqbU7m34PfQwYT/tcdXWliuM0wDePdxIAWRGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9tMVuuB+ZklWpFzLyM83AiIvvc7wifNRe852+HmTAnIPbmCvt
	KpM6EO/pCh7Ln8k8G6VEOOmMAc4sCdIvYVAaOcQXVGq0WfTmfpgQvugNyANgtWA=
X-Gm-Gg: ASbGncszoNg6F9ctXfyNxGAK5m87mL2XLBwKrZ3kw4nqnUDrN5xeHcWiymLAlnxW2vn
	oGImb4tI+KQFVeIjk4M3UgtTlfr6hqxVqc4xIc+Gp5MIx2es5B6rVPa+KwnLSC/eEmsjSOUHzo6
	jdH5D10xZ9a5zg8l12fyKXKriDbS56QixPp3EEjGKCuIfSj/r4jXAGLnoSOnMAcqBIHD+pEfrZZ
	Bys9CgNDLorA5P7ap9EBorJ00F8BAuCkgZklx9eUJsDOywgwgAcNYdRPw6htda5gCismSPnGTWc
	Cqy1xRUwHWicHRdnIv53khctrk8E
X-Google-Smtp-Source: AGHT+IEwCTRlvyl71solhDgWaKxLp5oopUTcMtwHu3YJJA/SVMpLmQ33tXa83ctCiJhFUIO1Qd60bg==
X-Received: by 2002:a17:906:314d:b0:ab7:9df1:e562 with SMTP id a640c23a62f3a-abc0de55dbcmr343145666b.48.1740157375725;
        Fri, 21 Feb 2025 09:02:55 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8eea4d65sm1105668766b.161.2025.02.21.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 09:02:55 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 2/2] pid: Optional first-fit pid allocation
Date: Fri, 21 Feb 2025 18:02:49 +0100
Message-ID: <20250221170249.890014-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221170249.890014-1-mkoutny@suse.com>
References: <20250221170249.890014-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Noone would need to use this allocation strategy (it's slower, pid
numbers collide sooner). Its primary purpose are pid namespaces in
conjunction with pids.max cgroup limit which keeps (virtual) pid numbers
below the given limit. This is for 32-bit userspace programs that may
not work well with pid numbers above 65536.

Link: https://lore.kernel.org/r/20241122132459.135120-1-aleksandr.mikhalitsyn@canonical.com/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  2 ++
 include/linux/pid_namespace.h               |  3 +++
 kernel/pid.c                                | 12 +++++++--
 kernel/pid_namespace.c                      | 28 +++++++++++++++------
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index a43b78b4b6464..f5e68d1c8849f 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1043,6 +1043,8 @@ The last pid allocated in the current (the one task using this sysctl
 lives in) pid namespace. When selecting a pid for a next task on fork
 kernel tries to allocate a number starting from this one.
 
+When set to -1, first-fit pid numbering is used instead of the next-fit.
+
 
 powersave-nap (PPC only)
 ========================
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index f9f9931e02d6a..10bf66ca78590 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -41,6 +41,9 @@ struct pid_namespace {
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	int memfd_noexec_scope;
 #endif
+#ifdef CONFIG_IA32_EMULATION
+	bool pid_noncyclic;
+#endif
 } __randomize_layout;
 
 extern struct pid_namespace init_pid_ns;
diff --git a/kernel/pid.c b/kernel/pid.c
index aa2a7d4da4555..e9da1662b8821 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -191,6 +191,10 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 
 	for (i = ns->level; i >= 0; i--) {
 		int tid = 0;
+		bool pid_noncyclic = 0;
+#ifdef CONFIG_IA32_EMULATION
+		pid_noncyclic = READ_ONCE(tmp->pid_noncyclic);
+#endif
 
 		if (set_tid_size) {
 			tid = set_tid[ns->level - i];
@@ -235,8 +239,12 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 			 * Store a null pointer so find_pid_ns does not find
 			 * a partially initialized PID (see below).
 			 */
-			nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
-					      pid_max, GFP_ATOMIC);
+			if (likely(!pid_noncyclic))
+				nr = idr_alloc_cyclic(&tmp->idr, NULL, pid_min,
+						      pid_max, GFP_ATOMIC);
+			else
+				nr = idr_alloc(&tmp->idr, NULL, pid_min,
+						      pid_max, GFP_ATOMIC);
 		}
 		spin_unlock_irq(&pidmap_lock);
 		idr_preload_end();
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0f23285be4f92..ceda94a064294 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -113,6 +113,9 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->pid_allocated = PIDNS_ADDING;
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
+#endif
+#ifdef CONFIG_IA32_EMULATION
+	ns->pid_noncyclic = READ_ONCE(parent_pid_ns->pid_noncyclic);
 #endif
 	return ns;
 
@@ -260,7 +263,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	return;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
+#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(CONFIG_IA32_EMULATION)
 static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -271,12 +274,23 @@ static int pid_ns_ctl_handler(const struct ctl_table *table, int write,
 	if (write && !checkpoint_restore_ns_capable(pid_ns->user_ns))
 		return -EPERM;
 
-	next = idr_get_cursor(&pid_ns->idr) - 1;
+	next = -1;
+#ifdef CONFIG_IA32_EMULATION
+	if (!pid_ns->pid_noncyclic)
+#endif
+		next += idr_get_cursor(&pid_ns->idr);
 
 	tmp.data = &next;
 	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
-	if (!ret && write)
-		idr_set_cursor(&pid_ns->idr, next + 1);
+	if (!ret && write) {
+		if (next > -1)
+			idr_set_cursor(&pid_ns->idr, next + 1);
+		else if (!IS_ENABLED(CONFIG_IA32_EMULATION))
+			ret = -EINVAL;
+#ifdef CONFIG_IA32_EMULATION
+		WRITE_ONCE(pid_ns->pid_noncyclic, next == -1);
+#endif
+	}
 
 	return ret;
 }
@@ -288,11 +302,11 @@ static const struct ctl_table pid_ns_ctl_table[] = {
 		.maxlen = sizeof(int),
 		.mode = 0666, /* permissions are checked in the handler */
 		.proc_handler = pid_ns_ctl_handler,
-		.extra1 = SYSCTL_ZERO,
+		.extra1 = SYSCTL_NEG_ONE,
 		.extra2 = &pid_max,
 	},
 };
-#endif	/* CONFIG_CHECKPOINT_RESTORE */
+#endif	/* CONFIG_CHECKPOINT_RESTORE || CONFIG_IA32_EMULATION */
 
 int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 {
@@ -449,7 +463,7 @@ static __init int pid_namespaces_init(void)
 {
 	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
+#if defined(CONFIG_CHECKPOINT_RESTORE) || defined(CONFIG_IA32_EMULATION)
 	register_sysctl_init("kernel", pid_ns_ctl_table);
 #endif
 
-- 
2.48.1


