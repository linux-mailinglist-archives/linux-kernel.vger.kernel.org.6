Return-Path: <linux-kernel+bounces-400962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC439C1475
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2325B23063
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD406194AD6;
	Fri,  8 Nov 2024 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac1PZynl"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A1784A4E;
	Fri,  8 Nov 2024 03:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731035463; cv=none; b=R2q4FmsYxKpJUqb6i2sUombOvp7k0NhHVxsSVsFB0IBajRyGV1jXKPPTEXMbCy2kx6IHyg7SeAQxsscpbcX/dyBQUrGlJRIFdCP/RX2Oo+pRpN5AFXj+ENfJ7Av9apDUyFNReys0tTWC7DSoHJx/qMW25yPH7oAUcy53PNIj0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731035463; c=relaxed/simple;
	bh=ZyGG/JolgOiTLRyymXoaXdc90HntT4LlCnkm9urXYnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ka3jzfUCDN9KENU+yIzlThvgPOO+ZFrxuq4lh/WSnjHgw4XmKjCUf9Bz5keWQsqgM5eF7uHtZab0p1vJkKjhAZwCm6crdGxpkZzUZ0p/mAXRU1XqWl4ASynUriY7YGnZsHtiVmuul0eXdf4S/268SERAfBMQAlJoRIhgX6gnwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac1PZynl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720d01caa66so1544941b3a.2;
        Thu, 07 Nov 2024 19:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731035461; x=1731640261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z81DIwGRLuwATR87Q7SlHrRTHasRWbetKZP18xxS2k=;
        b=Ac1PZynlaHCuAP4QNh7TuSfU6g3EeZJROV2+cgIRB7NL0+fgBbftytQHTUXeNpF4Ys
         UMg0xWMT00lGZ+g/9xx03vEiUQdMz3c2QJ7M+W1dX3b8keX1n65XylYFCZiT6Uayb899
         Ry6hLk0IOdNKhtZG3VmI1gdB0MX/a4ZsWuUgEXxaN+UW4GK21nmREVMe4SeV+GMkTWhz
         jxjlva/OSV7fWELS87l/yw/ybApndLJQC8pccjRg/+3JB5dNiSHfwsMFufzSm8ykqS8p
         EzEaWAa2z3XUtaFxHrzy5MZhyfc448S8TF2/3leeMiDSJ+iO7Yao++j7OP/lQA1Tr4rm
         nlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731035461; x=1731640261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Z81DIwGRLuwATR87Q7SlHrRTHasRWbetKZP18xxS2k=;
        b=fAAYGaXpfJ8Yh7zPYNfwVFo6c94Qa7aGxu6Kts32CMaH+WZjjRCJDKjSlXYXJl8OyM
         FvVHxxOq7JazwsazuHxbHMgPgJGjl2osRvMV3OTkb2jCCYoNQNqxNk0mO3s6dIDqrZKA
         +ZbS2lSCHbBC4GSySnm+3ainJ0tHvLRXErLtElC87CWwjaGuSg6pW3wY10OUUmUFMQ6r
         gyTCg8FpFXEzaZLHXJAaZ6r85+CT5aUyk7YSy7vtlf3EwbF7OH1gpMzWWJ+272Pf+sEI
         dIPHa0uqLx2+yz16L41BdFXMxpR3Bv9bcBOxOVTytTMZTzXv5SGwU/dIBVyL1CS4ilmg
         Ma7w==
X-Forwarded-Encrypted: i=1; AJvYcCUqyVy8QQLSuoSrCb0xgR/BoAl/aixnpc8RP4OVXI6uUVCwtjshWxMllwcQ2dCxlB8FQ75GwTeD6RgYCyM=@vger.kernel.org, AJvYcCXbBr6BzwncLEEYs1MTDUfuGKbCVCfFG5IzUVHflpIt8A2+NnW0Dgu096LdJ1cup2fx8FHUa2FJNG7FdgWz4v0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoM9xIQuLdScDDAgT48TLIG2/B1ZtudPpSrPWSqCs1JbKbEAqC
	YbGNxwO8veNCUmwC/XWr0qgqqcEl2pvbq8/C2Cny6TvWMGi64/SZ
X-Google-Smtp-Source: AGHT+IFg8AbwQ2kdS6FYFn0V0ALEjFXzhM0pq/V5eJ12742S8j8hZTtL3Nm+bXB9HuGq4pGUOY1D2g==
X-Received: by 2002:a05:6a20:2444:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1dc22b576aamr2049699637.36.1731035461249;
        Thu, 07 Nov 2024 19:11:01 -0800 (PST)
Received: from toolbox.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa86dsm2589816b3a.127.2024.11.07.19.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 19:11:00 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: a.hindborg@kernel.org,
	boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	alistair.francis@wdc.com,
	rust-for-linux@vger.kernel.org,
	me@kloenk.dev,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	gary@garyguo.net
Cc: alistair23@gmail.com
Subject: [PATCH v2 07/11] rust: helpers: Remove some refcount helpers
Date: Fri,  8 Nov 2024 13:10:08 +1000
Message-ID: <20241108031012.335203-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031012.335203-1-alistair.francis@wdc.com>
References: <20241108031012.335203-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we support wrap-static-fns we no longer need the custom helpers.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 rust/bindgen_static_functions |  3 +++
 rust/helpers/refcount.c       | 10 ----------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/rust/bindgen_static_functions b/rust/bindgen_static_functions
index e464dc1f5682..9c40a867a64d 100644
--- a/rust/bindgen_static_functions
+++ b/rust/bindgen_static_functions
@@ -15,3 +15,6 @@
 --allowlist-function kmap_local_page
 
 --allowlist-function rb_link_node
+
+--allowlist-function refcount_inc
+--allowlist-function refcount_dec_and_test
diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
index d6adbd2e45a1..ed13236246d8 100644
--- a/rust/helpers/refcount.c
+++ b/rust/helpers/refcount.c
@@ -6,13 +6,3 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
 }
-
-void rust_helper_refcount_inc(refcount_t *r)
-{
-	refcount_inc(r);
-}
-
-bool rust_helper_refcount_dec_and_test(refcount_t *r)
-{
-	return refcount_dec_and_test(r);
-}
-- 
2.47.0


