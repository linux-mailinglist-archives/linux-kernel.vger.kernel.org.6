Return-Path: <linux-kernel+bounces-555998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E97AA5BF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69AA47A9887
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CE6255E58;
	Tue, 11 Mar 2025 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="unUYzyFL"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0EB235354
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693322; cv=none; b=j5UQfM2eS343+b35s9Vbfts8n6lwVKt62TR+0ViCbOtD97korOR2zjAZDLtFwTg5UF3N0yRjv6cBtKKm86pW/1+fZkohNzNzFKuIayiajJaFs+yrUwwFCeY/Reb0QA/lZ2AMPF8uMyb3a1yBCDRBjCoGKAEArFK9q7+mIsuRqss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693322; c=relaxed/simple;
	bh=K8h1Ag3DTU1iuA899SLvbmD6xwY/+vHzivqVPw6SPEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy0FYYtsg2CXgWZXvZ3LLuiZMZY0UVHhpOIQ2Y/wuRl0fQcEpjHR3mBL0fpal9cf8akUbFzdhjEpHRXAuk7YXv5eyrbFtbC7d/U6VSS6SWH8M76z8lgZ8ctQ34QrsYNaxBqb1VQqH2/xVtv0W3Od+f7d3WME41N8W/CD2VXXcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=unUYzyFL; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff80290e44so8514064a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1741693319; x=1742298119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MA/dse0ICF/ii1I0pjbS4LieVE/QLWT9sr4+LkG47XY=;
        b=unUYzyFLfxsUKi65f6JV68/phAuaun5DAq4nRLNY3GBNX3VhPQIZwyL84Vp7whAP5n
         TIP433csQRbgPoelnoGfzMkjGM9YXWV6DDm4bFL3z+O/yc5aeMM9VtWE1mpY11Dkysx2
         Evc04+/GbuuZNuRxGWEAE9I71R5uLyiJiSL55/ofVfceLJWfa9p2q2tuw8hRoV7tT1QD
         hE1jL3/n2Vx0Yl1Cf7b5I/BrBvB2xjERMli8EXwnL/939fRyYY8GQAVwSDSi63XuTd7X
         LVT5wqm5aERC1V2yvvdvviJJvmigOjqj/N4xhW+tIR0FtCNgzmIj2dEZy7zd+4snJZeo
         ilQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741693319; x=1742298119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MA/dse0ICF/ii1I0pjbS4LieVE/QLWT9sr4+LkG47XY=;
        b=AUAXAtDD4nsoq+CSwcci92Bzai0E/4vDlQSKr1Jh0Dx0/Ry+VFa8tjoIXbIbgV3vfB
         Yw+k1Le3UhHI3RD+V/kYkaTOHztNYoRMbup1WV3bEijxfcZGS7T0rMb1IZB3Mp9gWRc+
         EQtjZgw/bxoAdTMl0JFNholJlSrYKpyVTibGZlO2xHx7EbGa09TIm/WQdjBfvEXaNCNs
         ssSFKDk6zPi1eoZWO69kmD0PbpE5wjACAQb7pB5dXOIvdPnaI6UtDqKLVyMNoSqzxMwP
         I2U6KqUnIiAPLsv9WYBbHPbLQ/JtQ9gohl1X+juzoxfB6yiUZvj++NBZcMABtr3XGXyO
         ia0g==
X-Forwarded-Encrypted: i=1; AJvYcCU82kLgpNkUC4oqa70Rf1eeMOTyNEjIJbpGTu9aBbGzvIyWU4Nvmv7B5JisZ+qXMctx4dnhGzgz3REYlzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20mJEenksXuJDI38U+uOybgVNVB1eE4OdTIYrL3gJwpYEhOFb
	NHZ2WNneFc4Cgc9pHSXjSuUWqcfFvrFE97rxjqa5LAJItNJ/CVLOvGVRGjXidtU=
X-Gm-Gg: ASbGncvOHIoGPsoHvQ5xsvM7K6Rl0fJ/0ITwygy0P3yeNOUGtgyAB2IApgN5yFdBW3E
	yctnVotha6D5R/GDkLvQCCcUuHgqz4Af9MaI9z4CWfAC4iM7cEKZScDTvmhy3ZupGWRU/x591zQ
	nw+Nph8l48MNRV9zXQmNqUxKsEJeMpAtERqYJEi95eB1Irr3QU1kadOndteVrKCKzx94tY+2c5n
	GsNq30PeVwix+sQR/XmO64h9R21G9cEZVnp6ynMgBfB0uiopSxVPdJ8/M7XldDeR3i8G3wpjmWa
	URO97XXqiHL6d+R6UxH6gFQXTiUztuB2heKg+96QEbGrvUY7H3ORqP5TT+YFXRqPfr9gucFfrMC
	6/3s4
X-Google-Smtp-Source: AGHT+IFzE9A1jtPzwbrU7Qxi5WrE/iLJ1gwUE4+oXkgzZWgtb2kVGpHneIlCN7fSLf3qIQvdqoqg9w==
X-Received: by 2002:a17:90b:3147:b0:2ff:58a4:9db5 with SMTP id 98e67ed59e1d1-2ff7cf480e9mr24563107a91.30.1741693319056;
        Tue, 11 Mar 2025 04:41:59 -0700 (PDT)
Received: from sidong.sidong.yang.office.furiosa.vpn ([221.148.76.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff8cfsm11647817a91.37.2025.03.11.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:41:58 -0700 (PDT)
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Sidong Yang <sidong.yang@furiosa.ai>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org
Subject: [RFC PATCH 0/2] introduce io_uring_cmd_import_fixed_vec
Date: Tue, 11 Mar 2025 11:40:40 +0000
Message-ID: <20250311114053.216359-1-sidong.yang@furiosa.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patche series introduce io_uring_cmd_import_vec. With this function,
Multiple fixed buffer could be used in uring cmd. It's vectored version
for io_uring_cmd_import_fixed(). Also this patch series includes a usage
for new api for encoded read in btrfs by using uring cmd.

Sidong Yang (2):
  io_uring: cmd: introduce io_uring_cmd_import_fixed_vec
  btrfs: ioctl: use registered buffer for IORING_URING_CMD_FIXED

 fs/btrfs/ioctl.c             | 26 +++++++++++++++++++++-----
 include/linux/io_uring/cmd.h | 14 ++++++++++++++
 io_uring/uring_cmd.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 5 deletions(-)

---

Recently, I've found that io_import_reg_vec() was added for io-uring. I think
it could be used for io-uring cmd. I've tested for btrfs encoded read and it
works. But it seems that there is no performance improvements and I'll keep
find why.

If there is no need to use fixed buffer for btrfs, I think it's good to use
for nvme.

2.43.0


