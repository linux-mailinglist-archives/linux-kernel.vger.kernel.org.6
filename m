Return-Path: <linux-kernel+bounces-511531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E1AA32C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 446B93AA66E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1348253B5B;
	Wed, 12 Feb 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QRV9p5ip"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA1253B63
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378894; cv=none; b=V0rqxBQMQKDywIioibwpwPjVuUsoJCYwmLiUbWgPWyHBMcE3hDh2AIy6MHqdQuVVrUUq2LX/IDg7hjIDP89MPdGEXt2BRA0qfEgJplYnpn14oqxEKNITiL5XxkCxONZKP8wvwiEyhetzaC3d+LWT3bSl/mRiNbUUOSF/vglYTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378894; c=relaxed/simple;
	bh=Qjj2QMAanOTsP0E6oofq18bt8+1l7KG1JEs5PYmidSw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGDJlVWEWecHF5A6mJQVoAJ1sumlB9aI4UdPYFWvZxA59HRlag9163PTMDzTzDmnRKpDUrqTUmgK/rluxQx/ovKCY0TitZWHgu5mTXEZ7QjUnzFg8eXMSHRDnzlTQRhnzNN7pC3WB5QtvpYi5aJ5JuROVoctY1CdUkmG8dRSuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QRV9p5ip; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d17a853c67so351315ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739378891; x=1739983691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/f8bv9QH5EQJaX+bBU+s7mbL/Dwx7/Hsr9UPWP0QZpE=;
        b=QRV9p5ipIFEB95u8jtDvzsCTTD74C4IvTaHBfmdEjjA7gBtrNX071rsnLtK0kdkWlf
         rDv5sy5dSMW3Y0o42LdWRscCAEhLK8tc9+aOXAXuym1G8jkxh13uesdRsHjtyreBEOj0
         noJYYQR874ZcBRtF+hzOElKRCEXwZQ3V+GVHmJNY+a1Jgj3JOGYOg/1ueQ/DeUxRGyKY
         9u2KQgbZiuTNNc949r+MX4TCtpNRQnPfmFZH5DACMoT5+kYncNATCvpQVDNAhbixE6aQ
         2TsXDm29G6D+HKgSMapTfr0YJXtO1UsgAIrCuBrwo6j0pJO/Yu4YNU5Oy6PxkaKodus1
         DDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378891; x=1739983691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/f8bv9QH5EQJaX+bBU+s7mbL/Dwx7/Hsr9UPWP0QZpE=;
        b=AGlHfXsHEs+RXwuRdvuAEMGFGFfqMP7Lwbf6o3RsB7jrhwUacHQ6vweFNIgWkbb7hK
         X/Eoc2b8NS4JL/7xdYUFO7rikB2p0BeptUQoscUra4M1ZZ53dRZ2kS6eSKk5hpE3eaUt
         oLySQV9uLv132pxEzCe2OweaFiFx647M+TibKg+K0EyqZtX2BWIJiRHf9Uh3+HACKUtS
         Xe1qRA9wJiu9+2j//RBl4FLxPcUTTccH/gs8rU3H09E08JSVywOTHlOuwkFIlWSuDMu/
         aQi7W4L1tLkCbJNybCXrmqZf4L2+u3qSCkTl/zNEXUpaJX8D3gnJWbx+1H53uz1iKGbL
         B17A==
X-Forwarded-Encrypted: i=1; AJvYcCXhUV6/Ob5IqrCRHD5Y3QSJq0TbT8JEueTq2RiRHHCVZzv9XUSGuFD9nKbFvlJ8tW+G5JeG5+FcOR8By4o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+wB23hO61k38DBIR78lef/QAre5OU/Ife9FGnlwFdi6WGO36E
	aIYPzmATv4kRQHnTjVciFx/LI49Mkc7WI2WdVQOyCeHMgk4cI3tv43Ls38Lv68x5r3LKeDaHkOd
	FzF5MTxOyHHOW2UHNjhtYY2nKPdRH2vEVEf3r+poArzi7aBCn
X-Gm-Gg: ASbGncvInrLU4uUwpADAZqCGskeSjcAfdV6oaRMqdxg+3ZGx5nNS+LeH3DuWz8k6VmJ
	6qjfqd3bquu5lVUBG2VVSOZMvk7bvKFor/vIB94vcIyOnzSIzP+ja9kuiNPoZRbNxBQQuqh8DNl
	1ySfcCl58zCvpBkr7Ymr+A2AZP4n/jZAl+M1V96s5IqJTV/p2Y/fvWjqyj97jIgIVUGQX4xiWtP
	ifSdVozcA8DVp36ydC9mcFOp7GRXvXF9FIIMzPmqrWXGdc6ytRTJ2l1HJ7geZyK85rfhiFqGOiY
	E0SIKDQ2m2QP4I/FTLzvls4=
X-Google-Smtp-Source: AGHT+IEnewgTPigF6UFFH5AistoyMlBljeF+wcBNbPlqftf8XpROgWlV8W2TEoX8mejN7RP6z7fc3JFqUo0J
X-Received: by 2002:a05:6e02:550:b0:3d1:8bf1:46f9 with SMTP id e9e14a558f8ab-3d18bf14b8fmr114495ab.7.1739378891173;
        Wed, 12 Feb 2025 08:48:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d18a9081f3sm150405ab.34.2025.02.12.08.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:48:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F31A93402DD;
	Wed, 12 Feb 2025 09:48:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ED64FE416E5; Wed, 12 Feb 2025 09:48:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: pass ctx instead of req to io_init_req_drain()
Date: Wed, 12 Feb 2025 09:48:05 -0700
Message-ID: <20250212164807.3681036-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_init_req_drain() takes a struct io_kiocb *req argument but only uses
it to get struct io_ring_ctx *ctx. The caller already knows the ctx, so
pass it instead.

Drop "req" from the function name since it operates on the ctx rather
than a specific req.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/io_uring.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 8bb8c099c3e1..4a0944a57d96 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1995,13 +1995,12 @@ static inline bool io_check_restriction(struct io_ring_ctx *ctx,
 		return false;
 
 	return true;
 }
 
-static void io_init_req_drain(struct io_kiocb *req)
+static void io_init_drain(struct io_ring_ctx *ctx)
 {
-	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *head = ctx->submit_state.link.head;
 
 	ctx->drain_active = true;
 	if (head) {
 		/*
@@ -2059,11 +2058,11 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		if (sqe_flags & IOSQE_CQE_SKIP_SUCCESS)
 			ctx->drain_disabled = true;
 		if (sqe_flags & IOSQE_IO_DRAIN) {
 			if (ctx->drain_disabled)
 				return io_init_fail_req(req, -EOPNOTSUPP);
-			io_init_req_drain(req);
+			io_init_drain(ctx);
 		}
 	}
 	if (unlikely(ctx->restricted || ctx->drain_active || ctx->drain_next)) {
 		if (ctx->restricted && !io_check_restriction(ctx, req, sqe_flags))
 			return io_init_fail_req(req, -EACCES);
-- 
2.45.2


