Return-Path: <linux-kernel+bounces-569061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6513AA69E16
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBF419C3CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 02:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262B41E98E8;
	Thu, 20 Mar 2025 02:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="Sh/k5bkL"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115A91E22E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742436539; cv=none; b=Wr0fy3QEEqNYDT8bgKsJMdT56Th9PNRbivEaljvBnT9ihJG6i+nGLdVChIncolMlflRIflhvSGFzEdk/+aiy7CvA39GpHn4Q8UHzgRLJwR+4PvHkOHPesF8JZltyj8zl8WjJlTiiKWcY17ur2tfzTqh1B8cFQBywNg798vFiUA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742436539; c=relaxed/simple;
	bh=w+3mxkeJWPRgWkPVeh+q6udIrxC+GmIGcgfPuZvQ/hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5l4jYl8kXqasPrcG+yb6VpAX7+Qw7aV+84HmL19q7De8vD2ks3oiGYk15PcJOiKgQUGrszknp3faAJmcldvDWnONwwbrHkV9N3b8yrmQ6UttTrAVVI+/Qq+RW49UtJxspWNCPkEzMmtbgr7Pfl1dbQaB5aqVIETftGBfmfA1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=Sh/k5bkL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=antoniohickey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e643f235a34so186003276.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742436537; x=1743041337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj78UMgSb6SZsH/TEr/IJNi7K+Iee3Ee8oiL2FOp1sE=;
        b=Sh/k5bkL+lqe3TpKVLgF5UeotqbmvlrXqNPMNxver0rBqSBpgYYlxY1/MVTnlcswiX
         iXWZ/MGB4GaOxwTP4Go7wWzPpAbTmKl8b130p5sUt5SSD3pTCiYRoJ1S/3obSTLF3bis
         5XRjsYvaMp61Q2Nv42sc+YUGiG8gmatm8jobU+nKlKccd/KxfDpMm/5KLcIHUqVYinU4
         6/rbMg1GQSH9SYzfG19y4qGkAX+cqv9qeMgychePNJTOrgJumvuHT68xmkPKGMIpcX/G
         XIVaothuqDWrDNR+TIQvFa67ZEPP47cf5Kl9aWmSzNtEYw/k/HTI7ASrVPgki0xHD9cp
         fjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742436537; x=1743041337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj78UMgSb6SZsH/TEr/IJNi7K+Iee3Ee8oiL2FOp1sE=;
        b=cdJB1ez8bt6qiO8KNSYuomnk0FJ/X/h59OAp0/0o7Z0T4J+/xr1RPqxoj0oevueI+A
         zfxmEuAC6yLfIUtrX2//EAlia5i4hlMO2+9Mr0hi4dJsYdbx7cJwF+A/8YzlfVNxKjVS
         RRAiYovMM+XaBcfIjTJZ/pyBv42Gu2cy6p6qBp2sFuktoQIqZ6rzfktYabRIMeCq4Chw
         qT/GqYk3YFdiVU5i1vbSGK6Wd4cJBlJUZsp39Ky5g9qCrdMwQJinaK3aq0ydaEuZTAo2
         Pwuv56457NcLLYSDJNG1J9QKmiyNJBnptILHEP3CmUDHqBzhWrfTzszQ59C5cfy9tNZR
         ng9A==
X-Forwarded-Encrypted: i=1; AJvYcCWj1JelbmbWGRqdb8H3XdNbcupX9acjCuYYWshYvSCTc8YODuVjnxubfXTKIDLCSDLoUxtlwNBtYJiZTH0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5LeF20Je65jvh44O3NKaYUWPzl4ppsuH1drBK1RoLkaJFRTv1
	/Yx9EVzlsBwcmNrEm5w+7v+dVZMOCg1Bf+vxRvUXWB2N3+UTSNiLiA8h2K/Lx1w=
X-Gm-Gg: ASbGncv1Rtd2x+LOUl2bKSiNAPDeCYkcwKMnoTkAlRRu7e+Psq4bs7o0gKR2AmLq12U
	WZhGYcwBWlVyoxxjr0kKvJo2Hdr0EXzmSJC01eQBZOkEfBw9LOq48HkHcNEkleZpJ8eiz6zSfTN
	FYCEsakcw1vdT6c7C5STkA9Idviy2kyhwMUrt1WclEMomvRS1JrZFzASSoelI+nSHe99XzzYuUj
	3e8C/eQRkYK+Jd5JFwGOKbZgTEvpOLvmvPi0caLvKMzJ2JvSpF3oO80yQrnV9kTu4qL5fl+ceDT
	fUc2W4W27RhxBd3jRYhd83CYy+Un4Km3gITrAqjBVZ0fkddrWZsMsZ+VcDbCyCN/XQaS7cbJ7Ws
	ATxA5MsEmGkE/yy/gM1/WISMNOEoa8g==
X-Google-Smtp-Source: AGHT+IEkG7Np3EYPQLzZcOpztGKxz58/1QQ7YJesvBpbwMvnGp6f2VV8gB17oSsnBOO4JzGhyGZfAw==
X-Received: by 2002:a05:690c:7246:b0:6fd:459f:dfa7 with SMTP id 00721157ae682-7009c15a3a9mr71229657b3.36.1742436537066;
        Wed, 19 Mar 2025 19:08:57 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ff32cb598asm32826357b3.111.2025.03.19.19.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 19:08:56 -0700 (PDT)
From: Antonio Hickey <contact@antoniohickey.com>
To: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/17] rust: workqueue: replace `raw_get` with pointer cast
Date: Wed, 19 Mar 2025 22:07:29 -0400
Message-ID: <20250320020740.1631171-11-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320020740.1631171-1-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that `Work` is initialized via `pin-init`, the `work` field
is always used. This allows us to replace the use of unsafe
`Opaque::raw_get` with direct pointer casting.

Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250316061429.817126-1-contact@antoniohickey.com/T/#mc7a4757e8c132f84228b728c7d123d73841501d6
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/workqueue.rs | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 4e27df324d26..5cc259c1e502 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -399,12 +399,8 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
     /// need not be initialized.)
     #[inline]
     pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
-        // SAFETY: The caller promises that the pointer is aligned and not dangling.
-        //
-        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use
-        // `&raw const (*ptr).work` so that the compiler does not complain that the
-        // `work` field is unused.
-        unsafe { Opaque::raw_get(&raw const (*ptr).work) }
+        // CAST: `Work` is transparent to `bindings::work_struct`.
+        ptr.cast_mut().cast()
     }
 }
 


