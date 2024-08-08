Return-Path: <linux-kernel+bounces-280232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F994C772
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96621F21817
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D99E15F40A;
	Thu,  8 Aug 2024 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qynb4fBD"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AD02F23
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160848; cv=none; b=lN03DAYFeLklaCUvH1uUo5TUDFgNjolYcQiZagviAsNcSUN61HV7YbVb2pUA4+YEgqBV5R3pHMF6JSjPRVMNxGkNA4Eafsu8nDy83vZgb9Rj1qtZ/xlBJs6wj2I4SjL7DPXS6yIosZOVByMHZlh7EIOrlrh0Sl6DFuQ7t+C4wKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160848; c=relaxed/simple;
	bh=Tsd2EcXhnmUz+221YdJ5PDCbtnvwGKdxA893zq8JtIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txEm6mQfPWffy1Oqw9YgHv1EWOfCqAWIG88vdSYN3o/JEO1dAO6bcSLmdsvTlJYjXuBCi/9LBxEWQUEts6s3AP1QU6gjAo35nvSO+7xyD5mETuDBwoYruLNJ1XrHAtZRmlCIttUblo4XAceGQxqmRq6H2GUHB4SrTojc3/vVKjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qynb4fBD; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7b80afeb099so1077759a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723160846; x=1723765646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dheW5IIS0EcRkzqbr/liUgn7V1Dn1bc2ejneEUhfSZ8=;
        b=Qynb4fBD97c37JTkz16yiUt71X9g1EOFcmKYKu9z2aCnvXqUBQIgZLyHK1d4cfs/Bz
         Ml1aSFnYku2RfvjrtuRZyey20pV0Kn4P8zCWmJEYlon3RO52p6nlzUaqiCqNs7HwUpYK
         h4uwD4RgKNuLiIKRXpu66tpCrjKPeVosogfAHMooKd7jfK0K2cb7S+91IfYWt27p3MfP
         CFpOqr3FfGNQ3Xwkxx+VwdCMxMrxPygaIVHWJUWRBY0Sskpu2/PmzQiVhHHYX38KD2RE
         Ukj8P3vpX616vo2yDrqTvoMpPyC7piOtd8jriq2dBUqLhpS9jjr8BzDIUNDBQurWrViU
         wucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160846; x=1723765646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dheW5IIS0EcRkzqbr/liUgn7V1Dn1bc2ejneEUhfSZ8=;
        b=JipZvdWSzWXhTSMRG8lUiJ7oUcdn+jIadz6g+UGTdFZAqD3WBIb3NM/uSB/ETQj84p
         ob5TkkEnRW2VIj7yZT6r10VRh15BMzmcyFtmJiwIrVPrxeBO42UKhEQvvcsbltaK5WsN
         lUy6xQalybxjR5lFqC5h+aaZnPnXVwKGwBPezkrWpwBrUDw0/cRUGUSE6mM97mrnGJgP
         8QiVJeXI31bEkNCWsUGwqKM6rAK/pgKPPeImb2ADmEo6SpYc2EjVsuJWvZpDVlS1vDmj
         oiFYB4/XHtgX1/9qxOY6APUItYUaymfmn7XcDJEj70JnkfVkUb4mLKbP72wl576ASgrE
         dzpg==
X-Gm-Message-State: AOJu0Yyzk54ecnteKQA6Sy/4OOF8824X22bj1Uz2ei6Ao9VLSWaW+OfJ
	I+VL81ipLawI/7Unp8aOqjFR6i0ci5F2vd+fRjOEImDd4yofErV8
X-Google-Smtp-Source: AGHT+IEZXoSQLFAhHgphaP43w7Hllhd+zAKZxeEL7kWZhYKWWXsRMRAisexewW0C/Wm1RYD71Hdlmw==
X-Received: by 2002:a17:902:db01:b0:1fb:4f8f:f212 with SMTP id d9443c01a7336-200952e8615mr38659585ad.60.1723160846010;
        Thu, 08 Aug 2024 16:47:26 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592aa11csm130083195ad.272.2024.08.08.16.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 16:47:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 8 Aug 2024 13:47:24 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Phil Auld <pauld@redhat.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 sched_ext/for-6.12] sched_ext: Improve logging around
 enable/disable
Message-ID: <ZrVZDDDssK-gA8Xe@slm.duckdns.org>
References: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrQW4gqIr_hTgp0z@slm.duckdns.org>

From 344576fa6a69ce1292ef669c8d50c2088c36dc1e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 7 Aug 2024 14:52:50 -1000
Subject: [PATCH] sched_ext: Improve logging around enable/disable

sched_ext currently doesn't generate messages when the BPF scheduler is
enabled and disabled unless there are errors. It is useful to have paper
trail. Improve logging around enable/disable:

- Generate info messages on enable and non-error disable.

- Update error exit message formatting so that it's consistent with
  non-error message. Also, prefix ei->msg with the BPF scheduler's name to
  make it clear where the message is coming from.

- Shorten scx_exit_reason() strings for SCX_EXIT_UNREG* for brevity and
  consistency.

v2: Use pr_*() instead of KERN_* consistently. (David)

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Acked-by: David Vernet <void@manifault.com>
---

Applied to sched_ext/for-6.12 w/ the pr_err() update.

Thanks.

 kernel/sched/ext.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 17af9c46d891..143c4207a826 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4013,11 +4013,11 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 {
 	switch (kind) {
 	case SCX_EXIT_UNREG:
-		return "Scheduler unregistered from user space";
+		return "unregistered from user space";
 	case SCX_EXIT_UNREG_BPF:
-		return "Scheduler unregistered from BPF";
+		return "unregistered from BPF";
 	case SCX_EXIT_UNREG_KERN:
-		return "Scheduler unregistered from the main kernel";
+		return "unregistered from the main kernel";
 	case SCX_EXIT_SYSRQ:
 		return "disabled by sysrq-S";
 	case SCX_EXIT_ERROR:
@@ -4135,14 +4135,16 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	percpu_up_write(&scx_fork_rwsem);
 
 	if (ei->kind >= SCX_EXIT_ERROR) {
-		printk(KERN_ERR "sched_ext: BPF scheduler \"%s\" errored, disabling\n", scx_ops.name);
+		pr_err("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
+		       scx_ops.name, ei->reason);
 
-		if (ei->msg[0] == '\0')
-			printk(KERN_ERR "sched_ext: %s\n", ei->reason);
-		else
-			printk(KERN_ERR "sched_ext: %s (%s)\n", ei->reason, ei->msg);
+		if (ei->msg[0] != '\0')
+			pr_err("sched_ext: %s: %s\n", scx_ops.name, ei->msg);
 
 		stack_trace_print(ei->bt, ei->bt_len, 2);
+	} else {
+		pr_info("sched_ext: BPF scheduler \"%s\" disabled (%s)\n",
+			scx_ops.name, ei->reason);
 	}
 
 	if (scx_ops.exit)
@@ -4817,6 +4819,8 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (!(ops->flags & SCX_OPS_SWITCH_PARTIAL))
 		static_branch_enable(&__scx_switched_all);
 
+	pr_info("sched_ext: BPF scheduler \"%s\" enabled%s\n",
+		scx_ops.name, scx_switched_all() ? "" : " (partial)");
 	kobject_uevent(scx_root_kobj, KOBJ_ADD);
 	mutex_unlock(&scx_ops_enable_mutex);
 
-- 
2.46.0


