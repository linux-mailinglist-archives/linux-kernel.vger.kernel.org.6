Return-Path: <linux-kernel+bounces-511881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C45A330FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8581168339
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E3202C20;
	Wed, 12 Feb 2025 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="T+xlsJEg"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626311EEA4A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393167; cv=none; b=e+8E2DE7rIyIA5GQmpD7xwablR4FCmy1rQibuKSrS3+k5B+GkoYNEx9avGHYjCWU5DyEDV8tviQQ66nX1TpWTrxki6d0gqjU6SgdKKN2mcknkcVFGMShLRC45/j63D6cMgh1xcQ92IMIt7UnLFfsmYG8JFMHttdFOtc3ZRq6RoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393167; c=relaxed/simple;
	bh=0LJjSt3oEend1gmYZZak25M8M1v0B3rrlIqISknkskg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os6sAnsekJZ0hjWibgrxEFTRslynDR4mmdGxoFIrLgp5J+qKk/Fbjj5e428m+qoquO/KjxeUxuXNUoan8vuE6CBKP2BR2lIR5tKSUipEkSYC56wC53Q+MjX0GR+DfX8P4fR2bX2M5XXTWi1nGN9eo9ilvK27sbaLbrl/PwMZ/sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=T+xlsJEg; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2166db59927so198605ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739393164; x=1739997964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiHGm8Z7lClPdUqk0kB1EHyQ03s+QvOZkIRAonfJV60=;
        b=T+xlsJEg3Enk1k+4E+HGWPbEvYUvBODmMjPAfVZr6smu3MGE3nI7FTv1PnL+nvPCij
         uoLL9/PrCsSsu+WhF4ITXost4ZH6ZqpcEpr3u1YKb5faDDDpjHo3JWQKGU2rqkVwyvOg
         hXl7snm+fujE3z2jw1yTrXFjfu2ABt1mwat4O0/y06TeYZ22IRSQq/Q3U9JGmlB6dHEc
         pR98JMhW37Xn7LTKnqsT3erudRz+NwPcX5FBRFB6GGTqePFRMGJ7ZaiAc+uNY1Ucgv1p
         ng43YLC2L5tb96HXiAKeW1HxRyJ3TjT42+tKiQ/P3L1crpFGPzVJdkXKtKQdeDXpIh3H
         WadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739393164; x=1739997964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiHGm8Z7lClPdUqk0kB1EHyQ03s+QvOZkIRAonfJV60=;
        b=qFOWEBxx2nVT837Q5Zx/Vdm0jDcSoO+PhY5j2LxPP53Da9l4QSrE+quv6UlGYLPC7N
         O9HNwMYYLEyClxuO0Sx/1YtJv1zC8er0Tb4Sl6dPvvTxZ66j8OsiYG7fOzT11pn4cFkW
         NN+yurN//G9gS1ipAOKUTlR36JSkzRY7gCE+wLu3eoh6FNfUi7VtROAbrp10R3fdchYJ
         xk/0U6ogqLDl3BzZ19s8ayzhgM9ijEOvxScC06FP/QEQBskVUXS1xUEXu25MtlTT9Vmd
         fxNSeZhUQDtCdOobjscQj18XMFIJqGQ2/fHBjYsl0xttowcGAwzpmEjT8rWt/iRzJ4GH
         buEA==
X-Forwarded-Encrypted: i=1; AJvYcCVQulba8EiAKZHFKIRM4dMrPgBIaN6bBcd4OzIGVTeDhJJpywbIk4rMU/GnZv2cR/csRycCAIUpTkpoTjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCRs8t6O4ruQ9ohTYEP6cl3UtqaOkmJK3YcT8UbVSYERFb4b/q
	etPqVYV8lCmOxB9uxJC2qQq4Yil7yIuFtj562yZXjlTErNSFlGp3MD95vcLqUmzHgE6p3xfvOXI
	m1StDVguSPcd95gvt+ILItqXByfaBcVld
X-Gm-Gg: ASbGnctOo9YpQLMnVeCI5FDY5taeFlEOs4MH6xmrOq4y3BI8nXylS2hqPOMETj7PDg1
	ynVm//LOISq3oQQwpECYHje5PgamHHj6vYfmnAfoj0g7xz7EKsT7jBLolxDt4l73rGm5eR08qEP
	ThrW0x0KarhEl/S3sWrmTFsVHKXOONPuQ08X/gz8Fsm3L29H7gn+53xJ9YpkQ7wbzrWEFraqs7y
	KsZq76BHuiI3NxJqQjLZu+4Aee1ThCa0cP0w8dRGDrFqkZxtt3xMoIeD3ldrcG9c8XdPv6D4qml
	MDQC7pHKGmiTx1sW5oO0cMa05Em6XLGd4B5paQ==
X-Google-Smtp-Source: AGHT+IEesfnwMWPhBe3XCPFux/HTRuC73toUxHqLiz/tK4QjkS1qFTzqnxeFbt046WfoZgAZrpqPeYrRUO/D
X-Received: by 2002:a17:902:dac2:b0:215:b75f:a1d8 with SMTP id d9443c01a7336-220bbaaefcemr27593215ad.2.1739393164580;
        Wed, 12 Feb 2025 12:46:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220c93caa35sm550195ad.47.2025.02.12.12.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 12:46:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F35263401A2;
	Wed, 12 Feb 2025 13:46:03 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EF352E419A0; Wed, 12 Feb 2025 13:46:03 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Riley Thomasson <riley@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/2] io_uring/uring_cmd: don't assume io_uring_cmd_data layout
Date: Wed, 12 Feb 2025 13:45:45 -0700
Message-ID: <20250212204546.3751645-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212204546.3751645-1-csander@purestorage.com>
References: <20250212204546.3751645-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

eaf72f7b414f ("io_uring/uring_cmd: cleanup struct io_uring_cmd_data
layout") removed most of the places assuming struct io_uring_cmd_data
has sqes as its first field. However, the EAGAIN case in io_uring_cmd()
still compares ioucmd->sqe to the struct io_uring_cmd_data pointer using
a void * cast. Since fa3595523d72 ("io_uring: get rid of alloc cache
init_once handling"), sqes is no longer io_uring_cmd_data's first field.
As a result, the pointers will always compare unequal and memcpy() may
be called with the same source and destination.

Replace the incorrect void * cast with the address of the sqes field.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: eaf72f7b414f ("io_uring/uring_cmd: cleanup struct io_uring_cmd_data layout")
---
 io_uring/uring_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 1f6a82128b47..cfb22e1de0e7 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -250,11 +250,11 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
 	if (ret == -EAGAIN) {
 		struct io_uring_cmd_data *cache = req->async_data;
 
-		if (ioucmd->sqe != (void *) cache)
+		if (ioucmd->sqe != cache->sqes)
 			memcpy(cache->sqes, ioucmd->sqe, uring_sqe_size(req->ctx));
 		return -EAGAIN;
 	} else if (ret == -EIOCBQUEUED) {
 		return -EIOCBQUEUED;
 	}
-- 
2.45.2


