Return-Path: <linux-kernel+bounces-540079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572A6A4AD63
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86893B5F81
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250BC1E5B65;
	Sat,  1 Mar 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="f+o30AO0"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18C1C3F36
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740854346; cv=none; b=a2+ELH0gcOifM1R3aASSdt9xgI2snFlEnl9oKJJCJY3Gj4TZROLky+vPyQLRiMZ2hRb/tKsiZrlOTXE4k+z5tLNNhG9lK64PKfFKr/4JYzMZCV0doPrMAap6QvLNyEA42RJgXnxGN9fXb315/+AWpmvPFiQTvge+fUsR4gjBA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740854346; c=relaxed/simple;
	bh=stkOczj9wsk0yC8FVzBVC0ck+FsRwlXVEQXdC7KVrtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lx5Ko9qWjHqv9zLmE52lGzBEmlmVpNSNEvuxrckdaKoh+g4OMXwZcxT70rFRluvljiEnfIJmnUCLgVIYrSURf3AaakkBXY4PSBJ8BCcVi+vnGJYtiW4utTCkmuRkFR7Ow846rMHeoisY65gFZsvNF5yQbWonnbPRSKqXuEDpRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=f+o30AO0; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-22348051cf7so7721105ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 10:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740854344; x=1741459144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6GWDVHZ7DE4o6lUs4iU3R7AoMZoHDxMO0VSLoOpHdM=;
        b=f+o30AO0LDxeh4kqTc4fN99LzrIH+BLPDBPpK65MGi0oYIKHdTQGAyLusotrDYvh1p
         MyqbYFSomg/1uu0fjHvsl2XhScBoiv+s3FufWQBKEdZBupvh2d52kEZFiVd1EiWXotdP
         nqh8FbExAv3RBylDaHdxGzQI/BhD6xmhkBLppbRptDZ7EolP7Vrx45mtua5SYqTThFpu
         JGSyxrETa8Ve8hMykWCoPqvVwsXuU1VkMCaRswXbj77XwhpjhkulMCKjlVDc7f2U1rIQ
         4eZvAbXZYRAEO1iYO6qineWTVGcE20eyQMyT+ja0U0Ny/j4YFPY1FE//s4gFLRwIxbB3
         dmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740854344; x=1741459144;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6GWDVHZ7DE4o6lUs4iU3R7AoMZoHDxMO0VSLoOpHdM=;
        b=Sx3QvvHw15prKsSEi3Yf341ndPKDctkEx21Pwq6tWfscdII6Tq0mLmHl2NGf/odq/S
         ErkVExtLNbghBpGhBNMLVAsgaEaNodUlqKT9HcYFZ054qt7u13gQ4eaGkNFAXeAZMzqf
         LqUawcEh7lyv/h9yEmYfBwF9Gk9DEM35tkkFv/56koHoNn909JYXsBhGUQwFA3ITOF7X
         CT8qBvXBDGGT+ukDYEEgDAs7l2hLKggXA3WKgDoOzm6Q7aXNAGfe9fcUWOxfIl9frVSq
         JmABPdFMyKDS9RCLu990hq9CJostam3lQ573ZQeSDJYCezFoTb5a65BcM1FBFSpIhk3H
         9jkA==
X-Forwarded-Encrypted: i=1; AJvYcCVFopwyxf7O3WYXXCr9Ppi2mEJ5XhZHfLeT6rH8Pm9uuPxrS/milRyo1oBJOpdn8Rkhj12VJvIrfN6CswY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTk/t/Ivn3xX9qrDG5gSfP7CjmbEHcSzFb92Xf+YjnsIipYWRz
	bGXRRZ+GwiTKasUCTzwvGBYOVE41fNFG5YybzjZToP3rT3ANYXiEwe0Q9nMBrsrYYOsG87JkyX1
	Uuf7AUDpqg4J8n6btuE6XdCvEdyys/RNl
X-Gm-Gg: ASbGnct/Ky/V+UiERLvAm2jVKULl539K+jSjXjNYZkzH8PtKSdfGHEdWzzyzgKGK37w
	8ZbTPFxnQnhKUm34IRMq+rUfJ+9UrCh8wtko4Bf3KZv330o/qyiHTSQP2En16ZQqX4AWHb08H85
	6hqpyWjLByD/zDKKcrrW7H2Mb9+MKLJ9r0p+io1fYMqoe9rfjDm87+7lsqDEMyk0UWfVDjPM/X3
	JJJPDhZ3BZ5/twneRhII+h/YhrBjVJEylsD0LaeUeNg7og1ILl2wXggNB0ehEzyPayxAxe7w4YO
	a+P5GTmoakb9n8JvpVbTQntXQh2mkaUIBJzVhAgDJ1MjIn/4
X-Google-Smtp-Source: AGHT+IFQXb1LamgOtsmsL5y5qtuMCmuSy0BmT7WOm4l455JDk/1ik0dpiEWhsFU6IHMLgADhF9R4SZeJQb5q
X-Received: by 2002:aa7:9903:0:b0:736:3326:2bc with SMTP id d2e1a72fcca58-736332606aemr1850758b3a.5.1740854344073;
        Sat, 01 Mar 2025 10:39:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-7349feb4080sm361682b3a.17.2025.03.01.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 10:39:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 694F6340314;
	Sat,  1 Mar 2025 11:39:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 63CF2E4112E; Sat,  1 Mar 2025 11:39:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: include io_uring_types.h in rsrc.h
Date: Sat,  1 Mar 2025 11:36:11 -0700
Message-ID: <20250301183612.937529-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring/rsrc.h uses several types from include/linux/io_uring_types.h.
Include io_uring_types.h explicitly in rsrc.h to avoid depending on
users of rsrc.h including io_uring_types.h first.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 8f912aa6bcc9..f10a1252b3e9 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -1,9 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #ifndef IOU_RSRC_H
 #define IOU_RSRC_H
 
+#include <linux/io_uring_types.h>
 #include <linux/lockdep.h>
 
 enum {
 	IORING_RSRC_FILE		= 0,
 	IORING_RSRC_BUFFER		= 1,
-- 
2.45.2


