Return-Path: <linux-kernel+bounces-409946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82789C93D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DAECB25205
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98E81AE01D;
	Thu, 14 Nov 2024 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24Hr4otx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620481AB53A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618773; cv=none; b=bfq+dTeUxbO5w6Qc1MD3iU52bMS4rjucoUnw/KQMHYw2nbGeFybza1ql1ZmCEanVN3bUuTguZxxfyjbG26yuPzleGpbeIscb1NxJSN3TEDJ8uWGoa/aaRP+9enOzKrPfyVsPteNXtoVT2x7veMp5xLP1wLMNi8RCqfQ4G4PFWKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618773; c=relaxed/simple;
	bh=rjKvFVzezYepUMqBsrgyRnxEy+YeuC3YPo8a88Ns+xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N/9MdzCuj9ANumqQ4tb/4J4ruLlUgJGd/nXMEzkR2vG1jpQyUcpH/TmISltSa8HaSVoGLpO9gj8uomqA01TLp+rW/Lhvcj4fJq20XmK3P2BilqaYmQBDxJBsCUwuNUw0SVR6MQjcoNnXnzD5Tf/9CHYgx0mwXHgKgRn0JoRSfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24Hr4otx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso13845e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 13:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731618769; x=1732223569; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIZtYchTaSQMndO2ePTqJcpy4qTHfh94M480QB+cOJ0=;
        b=24Hr4otxImCCCV6UL66MqwSDkYaIFFdGAbX/T0WttOEC8XRpxoWw5IK/Y+Jg1on3yg
         lZxde2DOPQRHgbIfuVoLkzgX97H+M1jcbR06xM709kbK06PrbLeRmotaZR5XG3ZCYGrR
         HI6DOaAgVMox+2riVsxDig5S4hqEpXq4j+TAIRhwP8GW+Z/gXhJNgGa1hiy5sPZBsJUE
         e2CqPGJJ5+MFS6YiJzHgKdjqpqjgAvIhqPSu0uKWlrHRq/bhTXNAD9Yd98LeOZxvqJwe
         iBPkHdoHv0HBt98x8rz6rQpaI03NiGlCku6+X6FeugynqpMkj6tGXQnsgcstlEmyMcGY
         CMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731618769; x=1732223569;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIZtYchTaSQMndO2ePTqJcpy4qTHfh94M480QB+cOJ0=;
        b=WwfZrvukXiPs4bRQHhc3sbtRuOQCePn2ZGGZPOS2MHGnJkOgf8JMybg9efYhCnSMjW
         9H4s0rdzt7thU5mAqHG73ztLauNgGB6sIYS4xofjrt7DOhLH2GllpgBH+KwN+YhMzSAM
         h1O9hprNMm4lc4gYeJtaZopdnw5XF952VcGn8ICSkUehD70sV34soTxcRhN9s+doeUqz
         ixj/SHXMAN5Zz29R4AULrgCtFyRzsE4xHkdVAm/9NgIbVFb32zRh0LQTAkXq5S/b4TCb
         VfDknlDPfrJGPIN52JH0633kZOwgjGoa5w5YO9/tjI0IRFp7X0b8zf4Or8PL2OCx/wx9
         tYOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV65U8SB8IgauXn4oUEqyBA6b42GcI5yzs+3ehzaAOC8qhgzCNYXJtx6hl1bIoGrUHZxxeijs0ys/Bz/qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlUwfPWf+Uxs2zZUd/DbyDpM/rVd36wANpFseEif6ahmmOC2R
	u0irUcYLpPR9cGw4r4FVDuls0lI1cgIAbSkbNUKDQXoFhD1Bg7XfLfM6FAeOEw==
X-Gm-Gg: ASbGncucatgUoyouvdHqNcVAk9Ud8ZLiqtYi3EvuBv54Gzu+KeYsj3NgWzt0PnLmTzv
	kK7nCLc3Vx5mKmsndNNDjV7uirbkQuC8X5bLkg7/iUJxSQplKvLo5UxTBvHNpqlDklLAVkms0t+
	4HdxY7v5s3/HT37rM4L2HdQdjVF84siwvEPMF9Od7fPb5NymVHmhgxCX8ISuWEnDEHJvKb4vO0y
	/2uz26CCacAmdlThtWR6b4rKx+SEAIEr3xNmoM=
X-Google-Smtp-Source: AGHT+IGST0bOj1r190JJJgGSMv6FxZ8grtKUGVs3XjXSDeF3CSW+8Y3q4Vex/qRtfWljzlpkG5hiWQ==
X-Received: by 2002:a05:600c:5491:b0:431:43a1:4cac with SMTP id 5b1f17b1804b1-432df4a10e3mr168045e9.3.1731618768334;
        Thu, 14 Nov 2024 13:12:48 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:1e15:9767:4741:f790])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae15d95sm2500636f8f.85.2024.11.14.13.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 13:12:47 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Thu, 14 Nov 2024 22:12:00 +0100
Subject: [PATCH] docs/mm: add more warnings around page table access
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-vma-docs-addition1-onv3-v1-1-ff177a0a2994@google.com>
X-B4-Tracking: v=1; b=H4sIAJ9nNmcC/x2MMQrDMAwAv2I0V1A5JkO/UjIYS2o1xC52MAWTv
 8dkPLi7AU2qSYOXG1ClW7OSJ9DDQfrG/BE0ngz+6QMRBex7RC6pYWS2Y9qEJfcFF88aZGXVpDD
 rXxW1/31+b+d5AQDUXKZpAAAA
X-Change-ID: 20241114-vma-docs-addition1-onv3-32df4e6dffcf
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>
Cc: Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Hillf Danton <hdanton@sina.com>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, SeongJae Park <sj@kernel.org>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, linux-mm@kvack.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Rizzo <matteorizzo@google.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731618721; l=3159;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=rjKvFVzezYepUMqBsrgyRnxEy+YeuC3YPo8a88Ns+xs=;
 b=TwUQmmgfdu9Jzp5V6NkkZvOoWYGpMCSwmvDP6/56zXTXJGJkvpkMW/wo0jPBS6oKq1XQImG8V
 6rwLw94tuwOCbSfaKKCS0nbwNRd9jEXEkQdHEy9w+U/Eo5ApzkGQ/Ce
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Make it clearer that holding the mmap lock in read mode is not enough
to traverse page tables, and that just having a stable VMA is not enough
to read PTEs.

Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
@akpm: Please don't put this in your tree before Lorenzo has replied.

@Lorenzo:
This is intended to go on top of your documentation patch.
If you think this is a sensible change, do you prefer to squash it into
your patch or do you prefer having akpm take this as a separate patch?
IDK what works better...
---
 Documentation/mm/process_addrs.rst | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index 1bf7ad010fc063d003bb857bb3b695a3eafa0b55..9bdf073d0c3ebea1707812508a309aa4a6163660 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -339,6 +339,16 @@ When **installing** page table entries, the mmap or VMA lock must be held to
 keep the VMA stable. We explore why this is in the page table locking details
 section below.
 
+.. warning:: Taking the mmap lock in read mode **is not sufficient** for
+             traversing page tables; you must also ensure that a VMA exists that
+             covers the range being accessed.
+             This ensures you can't race with concurrent page table removal
+             which happens with the mmap lock in read mode, in regions whose
+             VMAs are no longer present in the VMA tree.
+
+             (Alternatively, the mmap lock can be taken in write mode, but that
+             is heavy-handed and almost never the right choice.)
+
 **Freeing** page tables is an entirely internal memory management operation and
 has special requirements (see the page freeing section below for more details).
 
@@ -450,6 +460,9 @@ the time of writing of this document.
 Locking Implementation Details
 ------------------------------
 
+.. warning:: Locking rules for PTE-level page tables are very different from
+             locking rules for page tables at other levels.
+
 Page table locking details
 --------------------------
 
@@ -470,8 +483,12 @@ additional locks dedicated to page tables:
 These locks represent the minimum required to interact with each page table
 level, but there are further requirements.
 
-Importantly, note that on a **traversal** of page tables, no such locks are
-taken. Whether care is taken on reading the page table entries depends on the
+Importantly, note that on a **traversal** of page tables, sometimes no such
+locks are taken. However, at the PTE level, at least concurrent page table
+deletion must be prevented (using RCU) and the page table must be mapped into
+high memory, see below.
+
+Whether care is taken on reading the page table entries depends on the
 architecture, see the section on atomicity below.
 
 Locking rules

---
base-commit: 1e96a63d3022403e06cdda0213c7849b05973cd5
change-id: 20241114-vma-docs-addition1-onv3-32df4e6dffcf

-- 
Jann Horn <jannh@google.com>


