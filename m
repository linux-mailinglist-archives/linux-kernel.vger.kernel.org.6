Return-Path: <linux-kernel+bounces-290199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1E29550A3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E07DB24710
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E7B1C37AB;
	Fri, 16 Aug 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MajBbaEq"
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABDA1C233D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832156; cv=none; b=bq1cmSXDS/v7jGJs2BPWNpd5hx5l3YIrAQisylgM1JDRezcnHE0XVwBWdBxEXaaiPxk9TtF3pgz5Rxr/o+v5JQf6C4J7wnCO7PF2UjnuwZhgV9KLXioQVRrROEoFdu4iAfeCaEVZrovR+Viffddo7xwALOo6UgyNzRVUiim6g00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832156; c=relaxed/simple;
	bh=zxiUW/toeZX5AppBzoekrX29ilUmIU0h888Rq44XoHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWyDX1O6AWEX8TIXL1LhJLq2/zpaLfnLIPSqPfdapqpf2r6Thww5SCJOIJ9I0rNVevpaoMrIo7FnaPzJClq5dxpD5kBVuFUkAm0vaIw3fEjF6kxUeUnd4IO43REcMwU3/jLsv1YUXfA6Ftpozh5wa2yPXSb9dDCov2W7mje5GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MajBbaEq; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-4929754aee9so648520137.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1723832153; x=1724436953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WjxybjqjIyQYbHemfFTeOm2xjPxQaOuMoDMlPG+rLzw=;
        b=MajBbaEqqqqd+maMYClarM92nP1WXwjdkBIBZkryE3dkEYoDhyLOnLqKhrI3jdikIO
         M7zA03BkCCdoKngAjXpkPREbjqJTv3mj6yIENcfoHa3CiSNHjgizwT5uJ1e0g7eYeR8H
         KxrO1a5Dy6fUyJzWCsZQCY0tJApYovyKgctj15FN14vV26EPh/byrf/3LX0QENq12iuF
         g7XitROqKjCLq3I4Gwj/wcNg3aOO8T4Pb+RkXecdfCif6l82828n0OWLPfSq2GGx2E7H
         RQUhS9OVo6dlWKAJDAj47dIdD9/VJBHOvC2hxhPRg7uEJOpnYZCuW72F7IMHOZv1LXYR
         9m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723832153; x=1724436953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjxybjqjIyQYbHemfFTeOm2xjPxQaOuMoDMlPG+rLzw=;
        b=YNBbmDNY3LpuJ/8PUMslFwdcQt8mArA4zUqeEHqDtWjW4wl5dUhxI5cZMbMEPwt8Wc
         SKRcifYJme4qMkxp3tJl19+tnPNkfejGUjS44c84UvKEXoNHcQbRuy2+5s+KvbpDYC2F
         hCRKW/aiucmWYSRHFYM0q2HKg9VgDWiQdLO8gO4GSZJiY2NUbKYQuoJyVB86hAND99AL
         r1DtYHfdSF0KjcApXmGyfaj2a7apVrb4a3sEcOj9idyxL5TgOhA4DCSa7ovOjB4l2/Zf
         XPTxydZHibBv/8JL5TR+HjmIVnLMM8x3Wy2dOHOf5INDFIoD4pbdFKaojAddxATgeKMY
         3h+A==
X-Forwarded-Encrypted: i=1; AJvYcCUa23jUYBbsxHdsyCf+RC7HizzwkUXu3/JoqV6yfjmviHPf+jiPUwngXeEfO8rbjJWirb8n0MH0nQXnHd7ZMKT5vwefXQdpRyGlwmOQ
X-Gm-Message-State: AOJu0YynhTPaxw2lxWzy8qH00VH3U1EIZynkfWNmU23G+rc7Kjb5U1uF
	yGoQxgvid0OOs6bbiV38lzAlqAwd6ouSTlZbmOrMHD0iHOzucktpMs2PRnOyIUV1UMEd1z90z8M
	m9IvHd4l71ni+j74Q/oTrl4uL9xrWCrwmDcRu66V+NTLlBxc0
X-Google-Smtp-Source: AGHT+IEcRZRkVqmX6uxa02ElXcDjNwYLEXrtHyOHkT5kx5rZ1E6y/bSW/WG85j0v8EsBvXBI46ol3hg/vwNS
X-Received: by 2002:a05:6102:c86:b0:48f:4bd5:23d9 with SMTP id ada2fe7eead31-49779906068mr4512209137.5.1723832153414;
        Fri, 16 Aug 2024 11:15:53 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-842fb761ac2sm155545241.9.2024.08.16.11.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:15:53 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8D2863401CD;
	Fri, 16 Aug 2024 12:15:52 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 77B37E408E7; Fri, 16 Aug 2024 12:15:52 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: fix user_data field name in comment
Date: Fri, 16 Aug 2024 12:15:23 -0600
Message-ID: <20240816181526.3642732-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_uring_cqe's user_data field refers to `sqe->data`, but io_uring_sqe
does not have a data field. Fix the comment to say `sqe->user_data`.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Link: https://github.com/axboe/liburing/pull/1206
---
 include/uapi/linux/io_uring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 48c440edf674..7af716136df9 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -419,11 +419,11 @@ enum io_uring_msg_ring_flags {
 
 /*
  * IO completion data structure (Completion Queue Entry)
  */
 struct io_uring_cqe {
-	__u64	user_data;	/* sqe->data submission passed back */
+	__u64	user_data;	/* sqe->user_data value passed back */
 	__s32	res;		/* result code for this event */
 	__u32	flags;
 
 	/*
 	 * If the ring is initialized with IORING_SETUP_CQE32, then this field
-- 
2.45.2


