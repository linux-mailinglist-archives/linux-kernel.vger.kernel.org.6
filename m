Return-Path: <linux-kernel+bounces-222572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41029103DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F8F282D90
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741501ABCCB;
	Thu, 20 Jun 2024 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAC9DEY9"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEA146BF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886103; cv=none; b=LIRGsXfVqER+7IF4AvHNrX9g0Pv8gCjA9U+rM+dImkeN2rn5OyLEg2qFj6tKDXdWMkaq2rjOl8i3f+yGWVP/p5tkc2ujt8yRo7qtt17TmXu2sXkkn4k1bOfJbPC7gDTWlJhIBmsBCQxJPOfLBABzHgbOaciTqh81TRn4eeBmkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886103; c=relaxed/simple;
	bh=WcKOv7PY5d+xPKn5yCGxcolYNJ1WpaLxbZ4JsCBO8yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pyFgatXoGOzE+nAK8GjiMskj3aBNiOKblm1b3cBNT+V9U7KnTAnIF351N8104PA7vWnBOKoK/lavIs8V6c+v6YmY8E4Rec4T3xTm6wTgTO+secfh1pq4HvIfOQ56jPLLLpCQ/yjqKZvrt5x0NDDgaN70sWzxYOBfpoVRcnwAC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAC9DEY9; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70631cd9e50so683689b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718886102; x=1719490902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XBS1AMhLDhTumK33C3908n6EvwlZ7BmKQIgA6mDuKXI=;
        b=mAC9DEY96SDwRXy9uHcnHO32NfWMJxsITGSJmgtCPXtwylopP9CErJTTqYZXe75gPq
         5JjaS6QMlCPze6SHRohbIOV65RShu6yVLZQbout4MzortsjfAXeNdcRhD8ZmPj+jhTXV
         I2BH/oGS4aKtD0swdxdkq99uUIEEFq3ai8nopuXp4D7RIcLIzJroHzYwXOa6VNqu1kjZ
         dx6324hFRY5I9IljiMkyreoBbLZs829iGGhE3BjAUCPFPXW5aXx1FztCkDW3npHtrfXL
         VclTY9Kvf2nuZNbmi39gyW9rO8aPKDIYm96GRjs8p4m8Lkrak6PHFB5H7RaaQWC3GAEH
         eSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718886102; x=1719490902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBS1AMhLDhTumK33C3908n6EvwlZ7BmKQIgA6mDuKXI=;
        b=Yx3AvttKjILy3YX/vH7L32wbL5kovGzngU6JhYgHPCYyOSJq31RhKCZcWxaMK/9EcE
         0bKokLWp/GLOxFLETz8cDyoKC9yuqBNKxXTswNDrlGcwENN7/OLNu47GgNohPTwEge8Z
         P/nUuH2f5NH6da/Uewt8MHLZNbZJW5+APEMRH3E9SQ0+0k28C7p5cpz7YipvnpgKJdjb
         13LTYPd/ELT/+zCZhiOeUW9o0C4NrqEv48ZPQMIizW0wfg2+D7OE0x/EfyIOf1HsABjb
         IsbJlBicA9WPTo2IcUWFEguN4XORUJMhZjVSiajFw3LHyDgukO6uQYrV+ireoRgoPSAK
         NOEw==
X-Forwarded-Encrypted: i=1; AJvYcCUXVsncJ3KelhHXHAA8xb9s2Ezu+J9HLmjcd6Nv95pwNh7vSOeu2UB5q3lmmLeCl2/W1GntNnTkQIeQmlfHdTR8iImrYhp0bBLoKzwx
X-Gm-Message-State: AOJu0YxWPayZdtq1L/DAp+0kUGvRAIPDpQodhwVXMCKMzVdPmlcJcrPF
	yklPHSUqUncLqqQs3czPynOLMa0Q/0blXDbzYVZUS6AFrw5jxjDD
X-Google-Smtp-Source: AGHT+IEZoRkDMCj3Y9QFI9+Shy3ZbsxWCR1UBXpiYlnmNJQ6tE2CzaTopi+87JJ6Cu3vTiMjQddHvw==
X-Received: by 2002:a05:6a00:124f:b0:706:3ba3:a192 with SMTP id d2e1a72fcca58-7063ba3a6c5mr3335763b3a.22.1718886101652;
        Thu, 20 Jun 2024 05:21:41 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb6dfcasm12688725b3a.172.2024.06.20.05.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 05:21:41 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: akpm@linux-foundation.org,
	brauner@kernel.org
Cc: axboe@kernel.dk,
	oleg@redhat.com,
	tandersen@netflix.com,
	willy@infradead.org,
	mjguzik@gmail.com,
	alexjlzheng@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: optimize the redundant loop of mm_update_owner_next()
Date: Thu, 20 Jun 2024 20:21:24 +0800
Message-Id: <20240620122123.3877432-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

When mm_update_owner_next() is racing with swapoff (try_to_unuse()) or /proc or
ptrace or page migration (get_task_mm()), it is impossible to find an
appropriate task_struct in the loop whose mm_struct is the same as the target
mm_struct.

If the above race condition is combined with the stress-ng-zombie and
stress-ng-dup tests, such a long loop can easily cause a Hard Lockup in
write_lock_irq() for tasklist_lock.

Recognize this situation in advance and exit early.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 kernel/exit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/exit.c b/kernel/exit.c
index f95a2c1338a8..81fcee45d630 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -484,6 +484,8 @@ void mm_update_next_owner(struct mm_struct *mm)
 	 * Search through everything else, we should not get here often.
 	 */
 	for_each_process(g) {
+		if (atomic_read(&mm->mm_users) <= 1)
+			break;
 		if (g->flags & PF_KTHREAD)
 			continue;
 		for_each_thread(g, c) {
-- 
2.41.0


