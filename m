Return-Path: <linux-kernel+bounces-539638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D122BA4A6C4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AADEE7AA4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1BB1DF991;
	Fri, 28 Feb 2025 23:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gqnn/7va"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B41DF74C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740787169; cv=none; b=S9Fo81LgA1r+TGG8zCxTGEu/6jLO5HIAOYg8sZZBg3PUjUTJWotY0I4ksCseVq/zOsyrfml0Ylg4XszW5r3eEYbq+d964Ch31KcCUaLuoal9KPVvZg0AWtjnxE1i5A3f/j+mhmDPMoaPwWXRYNXZjkFD04j2PRqcgo25j5z3lR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740787169; c=relaxed/simple;
	bh=QFjWgNXy9Kx8/WOzwsIn/1I5TFpqOsgdfFlTxY3gJ2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pp0OUXY5BM0axzXY2UoOiNhVq/6FAz64EA7wVvFRdbHcM3Lf79L+AQsw2h1/GMuy/OBfeaUQR8WlMzg5NsEOIVG+NX5eYe6BBqYddD6UaugVGHH8DCIHLZ2lnKPr9c8JZUziKDMDr/7HdxnlEYUTsYw3jTBPAngBTv11UYoCWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gqnn/7va; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3d291a70ff1so809655ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740787166; x=1741391966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK6QOjfXK+fgEevkc21x4GT0Qq5JPIuUXpL7Fx2XzDA=;
        b=gqnn/7vaDIXgAqm8A5CHGZtj+IRGGog0VDj/YYCBW+1EfJ/X7ZJyR2cPp6HkHg/Yxk
         8vDmP/qOG5fGRraMcV7QyFgCKHjtE6LAHhw3PXDShuz2TOxTu4MQDRs9aBhTwZZhah5I
         cYkuEzL3UA5XEke9Ar1wulAmRvCnEwAbiRaYEV9ST2d/79e0+1+UpRTa7F9dui+P0air
         83VVNhJmADSw5k4itOjCTtOCHnrc+fSu7UsF0VPkc1tfvSjqVj4LmWIrMGayi1HBkT3w
         rVkc8bjzNxb4ha1j6Atvhi9l9JOgfSiGj2OJfXWELZ6F2OCYOfVX/1UDoIXIH2Ke0kHg
         8MAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740787166; x=1741391966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK6QOjfXK+fgEevkc21x4GT0Qq5JPIuUXpL7Fx2XzDA=;
        b=VIO6t5pQiW6mTjN5TcmMb9ipJ/sdaK1CgjdAPrHSg0eWrKQ/i19m8ryTNs81LSYHmo
         YaHPX4VPOmbX8ut5kEtHImP3+0VIjLsJ2dHaQar5uiMyte6jB/iJvuIHBtpbA4w43n5I
         5EHtrym15a1tvVu+TyV09tAF52c4dTCFwffavXo/jsZvL93fv3/aX8ThBlonBb0lHBaj
         lJYnHsRmM4v/EmIhccO8ptDIeCB1vn+ZYUvT7sS/j0XIIeYEYlOMVPI8QPyjL+5ZZChZ
         zyAGMELdYovlWs9n5SoXEOJGLYs5KKstDVrQYkzIaFgMRsIg8tT39YErinvH/WHa5IVy
         RbIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhB4hXeCphP7uULSiP4iOcO39Q8UG/VobS16YGr5LPvkSv1pgizhKXSIfTDs+9pkum47ROvJHY5N7yo88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylg2vZ1JwosXMQymbpMMLoSwnb89+zMCFeM8+Z+J1HI66pwoTS
	f36vjNTOa5gqP0jhC4uYAhNdEqQEXzK4eYnKKfjIdWk4SyWtaIbqdaztm0EDNir32ZCZzzJKdma
	MykFVENKvblMQQHNV8sz89O/On8xINE+9
X-Gm-Gg: ASbGncsdzgFssFPqXLlnmIrPXrZhBswHnm+2+NlOQCCboUOLoxAZPiokCWtke2d+tfb
	ZmDQit6bvLq+shK2TatPjWjz440eiIiJB8mG02vtJIW4gQsFt2Jj2g7XJNgSjio8+r660NA6XXk
	wzOnaixoEZ6kO1Urg6SfsqJMKwXYUlL/rRUVbJD9eyt0Xcj8h3mr8VxHpUEh1tS2iAUj6SitBI6
	uDMYvT0ATls5GJpZYa10JbQeKLxrau+JEBG8qiPzC6Uh8xRz6vT/XASoQIBasDWUXUE8Ju4YPmt
	T+7goTgkLsq7L2r+yJPSgWFJijrfSyl4mNgBLO35GTaOkfgv
X-Google-Smtp-Source: AGHT+IG/Nq900tpHhaf/0mNrSn5JRVXcZZ+nNO4WfDhJCn+LVSSYjcj85ej1aZMx9Yzu7PxQoceMQhcBDyrs
X-Received: by 2002:a05:6e02:1fc7:b0:3d1:936d:1e22 with SMTP id e9e14a558f8ab-3d3e6e45d8emr12968445ab.1.1740787166685;
        Fri, 28 Feb 2025 15:59:26 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4f061c5563dsm256932173.16.2025.02.28.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:59:26 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8845F34028F;
	Fri, 28 Feb 2025 16:59:25 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7D6AEE41AF2; Fri, 28 Feb 2025 16:59:25 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] io_uring/rsrc: avoid NULL node check on io_sqe_buffer_register() failure
Date: Fri, 28 Feb 2025 16:59:13 -0700
Message-ID: <20250228235916.670437-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250228235916.670437-1-csander@purestorage.com>
References: <20250228235916.670437-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The done: label is only reachable if node is non-NULL. So don't bother
checking, just call io_free_node().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/rsrc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 398c6f427bcc..95def9e5f3a7 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -835,12 +835,11 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
 	}
 done:
 	if (ret) {
 		if (imu)
 			io_free_imu(ctx, imu);
-		if (node)
-			io_free_node(ctx, node);
+		io_free_node(ctx, node);
 		node = ERR_PTR(ret);
 	}
 	kvfree(pages);
 	return node;
 }
-- 
2.45.2


