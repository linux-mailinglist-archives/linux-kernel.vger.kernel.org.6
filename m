Return-Path: <linux-kernel+bounces-417821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8CC9D596D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4541F229EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E6165EE3;
	Fri, 22 Nov 2024 06:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l8jzxS4r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BA015ADA6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732257314; cv=none; b=Kp6KaSm3k+t0hohH7JJP7mnkS+kqNGB4dWYr2/cQ80cHwZqLJ6EN6mZ8+aFuwK9tIpG45F97yFQ5GF4aM0JJjKBnrqQXanHmoh06bT7N0OqlmcYbrJARWt5ULTiB79NjmOzqVi5K4h0m2N1xelOz5QJHdEV74oBBeKSyXT0cLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732257314; c=relaxed/simple;
	bh=Dc35X1AynRH7806Gnedjy6IT8gdRrWZm1YnMEZPAbx0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f2ahhiA5KGw0pyQIL8iQUauqp4fGUyHm5tlIVXXrLsTlLkJ9o2E02xubGLYXYnOdjR8J1gFwlY+UiOZg4CcNlrDGu24zOWsMeukh0g5BSIrrqX423U8f7a5I7jj7UTkW1qqRtjpHRBr2A5GLVhsFqsIx7/AsIB7Xt3al0GfGECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l8jzxS4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747ECC4CECE;
	Fri, 22 Nov 2024 06:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732257313;
	bh=Dc35X1AynRH7806Gnedjy6IT8gdRrWZm1YnMEZPAbx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l8jzxS4rXh6l9+CCMiyLQ4F3ZYb/9W5O0EHQwZ4ZOyvxcq80ED1JJyKZUAkm6CaXY
	 wg1USkZZe8joundRt6mKSTcm3SQD0z2mdRhekRm46t70o8zI0qnzQkOGAzwGGKPrKs
	 HBW370FqZ6JG/AsNZvHaFDDyToL5cD8aW8ckuXuk=
Date: Thu, 21 Nov 2024 22:35:09 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] get_task_exe_file: check PF_KTHREAD locklessly
Message-Id: <20241121223509.a77731933dd7fb3e1728eacc@linux-foundation.org>
In-Reply-To: <20241119143526.704986-1-mjguzik@gmail.com>
References: <20241119143526.704986-1-mjguzik@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 15:35:26 +0100 Mateusz Guzik <mjguzik@gmail.com> wrote:

> Same thing as 8ac5dc66599c ("get_task_mm: check PF_KTHREAD lockless")

We prefer that patches have fuller changelogs, please.

I copied the 8ac5dc66599c changelog text into this patch's changelog.



From: Mateusz Guzik <mjguzik@gmail.com>
Subject: get_task_exe_file: check PF_KTHREAD locklessly
Date: Tue, 19 Nov 2024 15:35:26 +0100

Same thing as 8ac5dc66599c ("get_task_mm: check PF_KTHREAD lockless")

Nowadays PF_KTHREAD is sticky and it was never protected by ->alloc_lock. 
Move the PF_KTHREAD check outside of task_lock() section to make this code
more understandable.

Link: https://lkml.kernel.org/r/20241119143526.704986-1-mjguzik@gmail.com
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/fork.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/kernel/fork.c~get_task_exe_file-check-pf_kthread-locklessly
+++ a/kernel/fork.c
@@ -1496,12 +1496,13 @@ struct file *get_task_exe_file(struct ta
 	struct file *exe_file = NULL;
 	struct mm_struct *mm;
 
+	if (task->flags & PF_KTHREAD)
+		return NULL;
+
 	task_lock(task);
 	mm = task->mm;
-	if (mm) {
-		if (!(task->flags & PF_KTHREAD))
-			exe_file = get_mm_exe_file(mm);
-	}
+	if (mm)
+		exe_file = get_mm_exe_file(mm);
 	task_unlock(task);
 	return exe_file;
 }
_


