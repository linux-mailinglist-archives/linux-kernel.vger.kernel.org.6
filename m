Return-Path: <linux-kernel+bounces-278637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE0694B2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6EAE1F21B35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B83C15444E;
	Wed,  7 Aug 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR4iGA77"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C490146599
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723068822; cv=none; b=FjoKnXoQ1ZxgJ6zm76P/fJ5O44MSd0XPeuGQFJs116JFZedq+Q1Lo1JUQcUWowb4HTv/yVjKta7uKdbVsSoNRIoArjXVR9wMFokjd88XzL3/vzAOSMOKJK/bDXt6kFtNgJgTNB3S5DJLw6GxPtOdfUWjpg+8e0PHd9rs6Thqo30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723068822; c=relaxed/simple;
	bh=qP0tXpbvH9fYKgEjC7/dnZ3/8hwll6w+OIBEzdJnEgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o1rrZo7pY8ozqd0aM2tY40cf5K/H5fSxLt7TAcJRMo119zkWTZVKoo+fMOzKtEYSnldFLiKkCf5K4lX0VYpiyvGDo5oi09ugUAaNfgtbpOJgTcw3vSprt4uHsZccOWLYreR4l4oW0+/P8GNty5Eq99EsWFC+UIMr6nB6ydsCPo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR4iGA77; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb5243766dso338391a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723068820; x=1723673620; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=L4c74XUvKqvPq8lCy29e3ihQEGo3cVeCQ+c376ACG3k=;
        b=HR4iGA77rzfHdPo9EOVEEYJdYWR3MQcJC8sbfBbMrwCIu8dtfrWMp3cwTYxC653qq+
         9eyS0a9wmUvLOkiGfemxsNV0i31ryjJ0bUEqJ7vn07Y+nGDbsPvfX+9MlyjN7Z8xEDGG
         OTcYk0HfE17Vd1Donjx8RQaf5qrzQhv6fwxmHoNZpQyQfTgRNOkniPiOftmEqd80ZpRf
         TvYPPRz5k/sh4KdAQmXmGjwNxul5SHGL/ZwzM8yW7n4JygaYbA/IjVcVj7zNiKC0sM+W
         nea4jCDxfQgPMi3qBya2Z6onNM35qm6+w8MFklBij1dx+avMg8scBq+l6TFaTZuYV8Qy
         tlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723068820; x=1723673620;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4c74XUvKqvPq8lCy29e3ihQEGo3cVeCQ+c376ACG3k=;
        b=SDfrYj2WmWWXIQ9xkPbdRRxMiyb/Bmkja+H+sZC3DJiHBYX664qfq9lLYACdoXXPKj
         S/AVX4NcKkA6Ch49jsNfw0anAu84+djhPNYksZQz/wwzFWViblDuQ2OIcwCpRc3Tu6KV
         ueE7WAYsui+5HFdPJ6o0P4cJ5KmXH0BeLGWndcDOHuW8GTEw5mJtB0+wGsp1GFhQyDC8
         v4mQGW/3nxiErW+AHOr4UAmvCLuq2zpclbPm6P0NSkcg8ScmPvr4mnb5HBu2MXxencUs
         onQSOUN8OhhcmKiDZEeSqaod4RGRC7MOuK8m4erD8yLd0+o2HrNAOxyBRnfghyQEjTsB
         QoXw==
X-Gm-Message-State: AOJu0YwqYcZwI4Ej/NqlOq+7J7do4cI49smz7UMJqlZHSkAstN6cXpuJ
	q39dAoMC1hg0ozX/Mc2pPlwwM6wXlBa2A5x+bJlawU65KS31e7QFPzkhkA==
X-Google-Smtp-Source: AGHT+IFRPJazpBS1GRBlGMCkC+PY049F6iB6Xo/Nw7zjkP4UsByQbgsmpZBhM3GFITb5ag1SQEl0MQ==
X-Received: by 2002:a17:902:ea0a:b0:1fb:7b96:8479 with SMTP id d9443c01a7336-2009533506amr613555ad.58.1723068820149;
        Wed, 07 Aug 2024 15:13:40 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59178772sm110881755ad.195.2024.08.07.15.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 15:13:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 7 Aug 2024 12:13:38 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH sched_ext/for-6.12] sched_ext: Make scx_rq_online() also test
 cpu_active() in addition to SCX_RQ_ONLINE
Message-ID: <ZrPxkt57GdP6ILlA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

scx_rq_online() currently only tests SCX_RQ_ONLINE. This isn't fully correct
- e.g. consume_dispatch_q() uses task_run_on_remote_rq() which tests
scx_rq_online() to see whether the current rq can run the task, and, if so,
calls consume_remote_task() to migrate the task to @rq. While the test
itself was done while locking @rq, @rq can be temporarily unlocked by
consume_remote_task() and nothing prevents SCX_RQ_ONLINE from going offline
before the migration takes place.

To address the issue, add cpu_active() test to scx_rq_online(). There is a
synchronize_rcu() between cpu_active() being cleared and the rq going
offline, so if an on-going scheduling operation sees cpu_active(), the
associated rq is guaranteed to not go offline until the scheduling operation
is complete.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 60c27fb59f6c ("sched_ext: Implement sched_ext_ops.cpu_online/offline()")
---
 kernel/sched/ext.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1818,7 +1818,14 @@ dispatch:
 
 static bool scx_rq_online(struct rq *rq)
 {
-	return likely(rq->scx.flags & SCX_RQ_ONLINE);
+	/*
+	 * Test both cpu_active() and %SCX_RQ_ONLINE. %SCX_RQ_ONLINE indicates
+	 * the online state as seen from the BPF scheduler. cpu_active() test
+	 * guarantees that, if this function returns %true, %SCX_RQ_ONLINE will
+	 * stay set until the current scheduling operation is complete even if
+	 * we aren't locking @rq.
+	 */
+	return likely((rq->scx.flags & SCX_RQ_ONLINE) && cpu_active(cpu_of(rq)));
 }
 
 static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,

