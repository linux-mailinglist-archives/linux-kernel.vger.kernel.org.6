Return-Path: <linux-kernel+bounces-419070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4F09D6927
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 14:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E222B20E44
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7912E189916;
	Sat, 23 Nov 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjaAyPAl"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A91EEE6
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732366929; cv=none; b=QaJcrXupszCg9WW4nC1tl7pZa72g1ZgAIsTT1tFCDbtaqT7+CBl0qC9hq5c3oLcmvhI8qS/NBc4oNP4e5OjpufMLsVO2iZpMLAmYh66X8hvpBJc5HsTljHdYMbHwXaRt9+JZ3CbtAKmokjCxCMGH1vgAboq6L3URJsrwkqp3mTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732366929; c=relaxed/simple;
	bh=24PwlOkFwudaBfmB8v+ptbHQ8I4PFH1O52OqyuweuwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCqwIdCeCIZ/e/ci51OzGD0bOLc6Tsbb29wpmbxfR7ixULjb7NgJ7IsDZ0FsxmAI7S7ZxMP1c4xsuETvH0lRtO/ymxd5YzgObkt5rlAm5sSrYf3adV+8RRwz5CKF7yhT1cs+02wnIYxcEjaZOcX1Z9b4gYGZVkjqky+8SjsCMTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjaAyPAl; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fbbe0fb0b8so2111233a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732366928; x=1732971728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pYuajvX8br0TO/x0wPaBVGA/qUmBcUlg7gdRZJk7m70=;
        b=UjaAyPAlVwGMFZqO011nIWcZPUOsbb+yBoXGYUJtjoiORcz5Nde0XENwFAFAXB7VwQ
         1WoCZyMM+C8KJCSFVzVtsBqvacmLEMtlkH8FA7b5c3Qd0yYCVRRPLkWz5R82wvgLHVOL
         TzgNqrKLKCgWdPYcXy2NAXcxLZ7qqA5HacHgfFZ4A2Wi/+8RyPwjahV4QqC4/VpFEjx4
         ZVurLgcYhWpq6z/P6Uhd0gwrfNVM4pQVoTq5NTf9LB22FbAYgUSzQ/D24x9rCoWknzZD
         ELjj8/0GhNjLmorKCaYKYhktRL1J1G/KzpAG7PL7x/KrJL4n1FV+nVIkIyXCCep/ugbW
         CFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732366928; x=1732971728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYuajvX8br0TO/x0wPaBVGA/qUmBcUlg7gdRZJk7m70=;
        b=sdvsqWaNe9ZxgEAmhIa7gTzPArhgqw5mnepmWVjM9ZSbyH7NgLSCKjtRKfoqQSfhTc
         5014DHmSyvXA72w8ljN9OhkyIEJ7mU0kFHVM5mEcTW90Cx/UtNsiSKr31MxxAavgTdI/
         DB84enLX/X3oMKkveX8ZBcL/rA+41zfluRW6+uwi17IEm4RMjoablEOLR2vO8HFAszgP
         aqCGQpXKk2vzktj2+AcyD20/GL0bv+jtwS3mCVJ3G1eWVX6kRkPxKgyqHm0MTZOGlk63
         Bda78LM7OBQYZ5qksPiTUjiEQz0qXNz4f9fdg/jkNVQ0LkP1ylOqPV08YvLruvC9JYs9
         KfPg==
X-Forwarded-Encrypted: i=1; AJvYcCUzJnvxFUs6a7NQkbywo+M6s2UKl/XuoqzeuIeDndAxmJNjfWfsUxLs+lq69CEgkssnpZc1qTmWCF8Mrs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzjm5dFOal/EKKLw0a1ibeX7XFPUftLyBuHhkSSlXePPNnuywq
	ons2VQl5VNgiHrVLA4rRrx8POf3k+haS8SQItMIzfQxexrOF2A/i
X-Gm-Gg: ASbGncuWZ/jtkwFEw0Y1ZKvsenZYQaCJowYzcLdlKorheyq2UA5k50cEbjedc6tbX4E
	PD7HfpKFlYnQ/Gus+TSLlE9WCMTyH44TKZz2JaxkkF8cRjm0acPDJGfSKbIlI4WG3XtiQzdlWJW
	X1Xn1bHeGhFFBDz5zm3jYeQM3FdtDlbY7DCRvFM5lxJkgOw9Dd26H5TXHivgoA+osp8j9NAwEiT
	Z8Nex2rgBOPBmE+sxKWeLwydOWXENgOdc76JBA8Z7yCLjZrWhu4aWqUVyOgsw==
X-Google-Smtp-Source: AGHT+IHt2MDQJm+iAyVcTt9gvAgFsMvRR2kYMlOJv5BLT0znuv3FN4ObplIU3QXQArnMTWRAJIvN0w==
X-Received: by 2002:a17:90b:4f45:b0:2ea:9309:7594 with SMTP id 98e67ed59e1d1-2eb0e1254dfmr7749077a91.4.1732366927810;
        Sat, 23 Nov 2024 05:02:07 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cff8fe8sm3295226a91.14.2024.11.23.05.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 05:02:07 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] nvme: various bugs fix & code simplify
Date: Sat, 23 Nov 2024 21:37:36 +0800
Message-Id: <cover.1732368343.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Here try to fix the hang issue of nvme-rdma, memory leak issue of
nvme-tcp, simply the code of nvme-tcp.

Chunguang.xu (5):
  nvme-rdma: unquiesce admin_q before destroy it
  nvme-tcp: no need to quiesec admin_q in nvme_tcp_teardown_io_queues()
  nvme-tcp: simplify nvme_tcp_configure_admin_queue()
  nvme-tcp: remove nvme_tcp_destroy_io_queues()
  nvme-tcp: fix the memleak while create new ctrl failed

 drivers/nvme/host/rdma.c |  8 +------
 drivers/nvme/host/tcp.c  | 49 ++++++++++++++++------------------------
 2 files changed, 20 insertions(+), 37 deletions(-)

-- 
2.25.1


