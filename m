Return-Path: <linux-kernel+bounces-441823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140459ED48E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 19:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED44167852
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B9A201015;
	Wed, 11 Dec 2024 18:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuQJBaa/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B303024632E;
	Wed, 11 Dec 2024 18:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733941007; cv=none; b=Anjdd0g0Fbjoy89T3c96LTEGs9woJMHBFZKxl4vLsmIvcP1uJ8xVinOrnhPp3OlajB0X4AhoXwMjgL/9IRayRS0+8aIakhmE7ZxFyV7BGMpUcYqDs93/4CM2QFyY6DD4l9PMnTHj6CvL5F2Fc5mjHHN/K828f0tO8dwmrNHdcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733941007; c=relaxed/simple;
	bh=J9kdOOYNwMHlj+AhnO0iZVcuqVZL58lRYPegPbfcWlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p3xGKQpzkfVX+9xOf9ovv+JNjEX0ZgnQ77Qi9c+JPkCCBcMVLflr90s9hxLadVnwtShmX0a9Fm35DLUoTFlhYuxFM3Kd6wYLPh3ZiZAT3/oxXAbrMvB1ulOx+554DJ5W4Gx3bPRFHT4w8jxIpNRBtPH0hjlzJSKJFZUDTedXB7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuQJBaa/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2161eb95317so52911915ad.1;
        Wed, 11 Dec 2024 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733941005; x=1734545805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A18LOoCt5dPiy/l1Xyxb4dGNfh36+AUTCKlwqGR+Rvo=;
        b=PuQJBaa/gDckXRRAmUXJUSxV/VJyrTyaYXlEmJxkHs3NZZLSJI1Sm/YiTwXz3LVxb2
         KDItNiYVFxalPAIR8L4zoFEnuh3dpdepe+iwdfy/FMOg2bdLiSYxt51dQgL1IEMcYcMx
         xv08M5fF44FTtMGlZE9ivF04s6CSOxhPH3eWvZcTLvIaYhg9fGQQd3tngadQ359TcE3Q
         Ry4zqQ4u7DEpZQwkVFvICPjYMzv/b/xbTXfQZlzMsR9yXfilRXie/xnokkBT7PxX/Kbk
         HgvoQaLHvqrGh3Ptkqu8HJi0Rsg/ZyrIRAXuctoUUHGFonoVwAvwht+zgcQL6ZUxbwpn
         ocPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733941005; x=1734545805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A18LOoCt5dPiy/l1Xyxb4dGNfh36+AUTCKlwqGR+Rvo=;
        b=LYhCWisfWUnbQ2V5+s7CnuJMgmVJtAKtLsmYBVZbtQ+2MdCygJT9cIFfshdA5Y1uPh
         2F7SWWR3Fm+2mmueZ40bkTkrdB+SHE+DDPLBuIef3ZWyQrF3bZuvfGDUKjid7IGrBoVQ
         xIDUKZsOcf0PI2wwOT0DFkosU/2+y3sa2F9rfbF8Dc/K3yH0xVhsGFrN4W1V80A1rR0k
         7sIMehg87LUaKhq85K/gqgguHh9rdTC6XZaTgTUN0WcVua2+o5A4lYPCFVBD1g9YZnV8
         TnN/mxzeEaRCPOOtb6NUu0AgBOiMCswsZRqA0aiwkYCLHe0XAPtcIOWS1s98+bEZPBpu
         s1cg==
X-Forwarded-Encrypted: i=1; AJvYcCWku2RhiHmSlyIBVJnnFPPO/Da3HX5KNA7kuyNWEPUfdTdBSg8iEu4/h79mFGXXpgXeXXWkV5bTFfAML5t4gYI=@vger.kernel.org, AJvYcCXJg4Qml+u38Itu0n3wnmWYOcgsP4fGrNDZsm0A0VOk+jpIicEJAuIIKy1n20tY0jLLL6evlWcmHeQ3RRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYC2t+jOiwBhQbC7i6JA8OefJuVCJwY3AxOTZ7TaH633/tBu42
	4rtfPFcgbC7hcjGnxNx5IrxQuLlB7Qhb7T06kklPmiNdO9w2odY0
X-Gm-Gg: ASbGnculQ21iPcAb3uk67kXhhChIDmF1DhBsV2vRRq9CfZB+Af43dlTJTIdQScbvrF/
	hEVdDf/QvEK5RDuFut2DlIvxg4xDSjT3xZqHHriF0J0yZ7s4dLJZiUvfrXkpmC+fymJCWEcf2k1
	ooHdb/NvcTEAV38Kqmv8vufycYB9O/8esMqvl+JZgiSNzEdf43nVXe3YXV6h7LWJxy/76y3HlSj
	LvY+NreuZ/QvigWxvOCgzugHFpo8jazYzIj137a3R7hPWnYbhIl3eUXlmmK1lqLKwdLTg==
X-Google-Smtp-Source: AGHT+IEBUXksE5yTVKC7+bYcmKa7mSoCvBULo19rlfRjo+HR6E+xHox3N1GpsJTMWeJBPpe79Hn2aQ==
X-Received: by 2002:a17:902:f682:b0:216:3889:6f6f with SMTP id d9443c01a7336-217783b5c80mr47256705ad.17.1733941004890;
        Wed, 11 Dec 2024 10:16:44 -0800 (PST)
Received: from localhost.localdomain ([2402:e280:21c5:223:2c08:f85:3644:ef6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216542077bbsm52261875ad.61.2024.12.11.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 10:16:44 -0800 (PST)
From: eisantosh95@gmail.com
To: 
Cc: eisantosh95@gmail.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: Fix EXPORT_SYMBOL_RUST_GPL macro to follow guidelines
Date: Wed, 11 Dec 2024 23:46:39 +0530
Message-Id: <20241211181639.19848-1-eisantosh95@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Santosh Mahto <eisantosh95@gmail.com>

Warning found by checkpatch.pl script.

Signed-off-by: Santosh Mahto <eisantosh95@gmail.com>
---
 rust/exports.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/exports.c b/rust/exports.c
index 587f0e776aba..4b34734d77c8 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -13,7 +13,7 @@
 
 #include <linux/export.h>
 
-#define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_RUST_GPL(sym) EXPORT_SYMBOL_GPL(sym)
 
 #include "exports_core_generated.h"
 #include "exports_helpers_generated.h"
-- 
2.25.1


