Return-Path: <linux-kernel+bounces-511811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27851A3300B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6071889322
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EE11FFC6A;
	Wed, 12 Feb 2025 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctIHaaUk"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456411FF615;
	Wed, 12 Feb 2025 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739389683; cv=none; b=p0La7cCdAFF2ROsx+uW6in4jzOIi3MUxVInLVJ3Ph37dxHXH237do44V6MEVgo3StvWTNu4Uw1oepws5sMC6933jiJu2chUzk+9POQVQsMi6c/16S0PTxg5Y7x278ptp3yAuBkd28mkqy8YKy/cmSnCRITvIfqBmhbSlJj726yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739389683; c=relaxed/simple;
	bh=yTr21wjBOMkX8f7EXjuTZlsatgxFVgWBZKd62qEkpCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qeuOJidX+/DI6lOBEGcRe7shmRqQYA078hxyXOlukf5pITfSQ4MSia79GAo0JXCiMvZCmicUcF58IlH2KS0w6K/Pslo6nMp6UyxoTAeJPD3EcqA889hcyN90OA1NHkajruisPP9XWDDspMLVGinuCwtyGnDQuKMQwfywmLQiayM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctIHaaUk; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-726fd9257f7so70445a34.2;
        Wed, 12 Feb 2025 11:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739389680; x=1739994480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/i6BbIu8Fi4H13JzAioH1AfyU9dkQktoEa5HnOpZ8Q=;
        b=ctIHaaUkBLNVZ1+atyP9FqmzsazXN2d49hQYUdK6f/Ususj36jXtXcuV0HkZD4P6J8
         wV3ADhViFxPDZv33hCXX7fNTRe5KD3i/Afje+8uAM0CuohlNTY9mB0F6b4AAw78O3yoY
         M8CTMy2T99kMNab6hQTvrHnOF2wWZmc313F/rQeym9vv3TBSZUpt0yIFd6a0LRKOtIrm
         7jJ5l/3KjmNJokxRoemnKrYK4V7P5fTdHNxYFAL+iOWwJJNHpE7/MPkFhMT02mcLB5d4
         ++8oRJjaEBkMtJxagDweMGPCuCACDQc87gBYd2wAR3k+5RX7/BARvWmZP1Ryu/UrfEFf
         LlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739389680; x=1739994480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/i6BbIu8Fi4H13JzAioH1AfyU9dkQktoEa5HnOpZ8Q=;
        b=d2Gsqn3VgD2B8zYR0pCCZ7tnKNc1KgneupnuO12ayq1vRv+9/tJVBMAT5k/011yuLa
         Qno/ZYuD7QryB69JZ+waU++KSOt1q8KEjQDf2Dio+5gyrtbd/HpFQ7+eIPm22a6pqij8
         A/Ro4Dbxr9pWRHj7RxR4vLYK6dyuKX+EfwONYj37vxD5JgG8M5uE1TfzHiz14scwfe+R
         XbFnFoEY9HYkNKU8rb3LO4kV1bRmjytKdEy+ixi/y3owD/kW0ZQH1uX8+aT0S4Ekj3km
         dyw/6zyVEklnwdRnLXxE5jX8mvQSFnmRrz/RCzwIan+i3kpXlzkifGo1lJdGTwua93ZU
         9f+A==
X-Forwarded-Encrypted: i=1; AJvYcCUtoLZ8HTOod7lSoCx2hBnBaMJxA7dXmd2jXvJVHiJ191xVea1BDF52m7BVJchpOTVPkCdTApJx2XAAf5G5NU8=@vger.kernel.org, AJvYcCWSMmixhXyd9JvsQjmuHW080yAUYckNX37p5V0KPvwCeYfkJIWNOG5cSggx0es17gSK9528DrJ724p7TEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6TefenA2iT4gHc20K7XH9KQwbP0Wm9nNwai84s03m8j4mBBq
	nDBy1HM2Cae2fl9dQK1Lf3/F6Vn3EWm3kgNrIQ8SRRS3BHfLsbF5
X-Gm-Gg: ASbGncuioEuE6bKvJ32xcG26wQKTuY0if6lcNwboq8ibfFymI7ceimHsa5ozxc71XFy
	H0EPhCGIeh/NlXRsrzlEcB0EsdBr47Ra8v1Ud+IQ0CSEnqycR2V6MFoI9NTcokCvPnWmBnyTcgJ
	6KTgOH9iQ2kGqyA00Yg4yPUg+edgmaxQCau63Pn7+Yi6YmcWv3TD2Ze/S9+U/yC4MmpfCrBwvlG
	g4Q2PD8EsKJbruS/JVR+56iFBlXCJfQHiEW6Gesf5pY02vA1W6QSdimc5jH9xjAruGd829oUVji
	2S7h2tHC1GPnsDojoM0FcQAa
X-Google-Smtp-Source: AGHT+IEY2CRyGkzf4oZCm0CkRKv6HQSO1Njl5lblV4RJC+GkC5M/4Q+srFLvmA/T5mmLwe+uApCc6w==
X-Received: by 2002:a05:6830:258e:b0:71d:f6d3:9fd2 with SMTP id 46e09a7af769-726f1d19019mr3622355a34.24.1739389680238;
        Wed, 12 Feb 2025 11:48:00 -0800 (PST)
Received: from linuxsimoes.. ([187.120.154.251])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726f151c732sm1433485a34.14.2025.02.12.11.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:47:59 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	apw@canonical.com,
	arnd@arndb.de,
	aswinunni01@gmail.com,
	axboe@kernel.dk,
	benno.lossin@proton.me,
	bhelgaas@google.com,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	dakr@kernel.org,
	dwaipayanray1@gmail.com,
	ethan.twardy@gmail.com,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	gregkh@linuxfoundation.org,
	joe@perches.com,
	lukas.bulwahn@gmail.com,
	ojeda@kernel.org,
	pbonzini@redhat.com,
	tmgross@umich.edu,
	walmeida@microsoft.com
Cc: trintaeoitogc@gmail.com,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: [PATCH 1/3] rust: module: change author to be a array
Date: Wed, 12 Feb 2025 16:47:15 -0300
Message-Id: <20250212194717.191979-2-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212194717.191979-1-trintaeoitogc@gmail.com>
References: <20250212194717.191979-1-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the module! macro, the author field has a string type. Once that the
modules can has more than one author, this is impossible in the current
scenary.
Change the author field for accept a array string type and enable module
creations with more than one author.

Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Link: https://github.com/Rust-for-Linux/linux/issues/244
Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 rust/macros/module.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index cdf94f4982df..09265d18b44d 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -94,7 +94,7 @@ struct ModuleInfo {
     type_: String,
     license: String,
     name: String,
-    author: Option<String>,
+    author: Option<Vec<String>>,
     description: Option<String>,
     alias: Option<Vec<String>>,
     firmware: Option<Vec<String>>,
@@ -135,7 +135,7 @@ fn parse(it: &mut token_stream::IntoIter) -> Self {
             match key.as_str() {
                 "type" => info.type_ = expect_ident(it),
                 "name" => info.name = expect_string_ascii(it),
-                "author" => info.author = Some(expect_string(it)),
+                "author" => info.author = Some(expect_string_array(it)),
                 "description" => info.description = Some(expect_string(it)),
                 "license" => info.license = expect_string_ascii(it),
                 "alias" => info.alias = Some(expect_string_array(it)),
@@ -184,7 +184,9 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
 
     let mut modinfo = ModInfoBuilder::new(info.name.as_ref());
     if let Some(author) = info.author {
-        modinfo.emit("author", &author);
+        for author in author {
+            modinfo.emit("author", &author);
+        }
     }
     if let Some(description) = info.description {
         modinfo.emit("description", &description);
-- 
2.34.1


