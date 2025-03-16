Return-Path: <linux-kernel+bounces-562896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2875AA63447
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 07:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AF31895D32
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 06:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1601E19DFA7;
	Sun, 16 Mar 2025 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b="CsMpWE/3"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F5119C575
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742106052; cv=none; b=fqODX1PlVU02MLeS5NwXYdTsJGen+moNYFEjTISJIsjQcC6jQRx08Mmu7WkFkAsJ5InuGzKvMR7M+qUAb2ieLlRAJE6Qq98cC+KaCGl/kl/ZqDR2xNdh+AvYQ7BFLHWanRxp8KKVSRjb1Mo2+mNulb+bRT9lLlpKQOyKEQJwlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742106052; c=relaxed/simple;
	bh=qsB4QebE2TeQIBYybvK6Gs19VRTBF0+x3xLOXlM8h0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dBmx7aOvncfxkesq/Vz4/wJcY+oU923cm9tnuxJWlLFIy69bWRMscvxkiMaP2a/CVvPMEVsTH09IG4GtBbn9C33JOqHgm5d8KlZkd25kOlwwMZ/Lw0k4X5v5S0ELiacMVj/pEBdxAM0rUf28IiOqllsXZhnhZ3M/X7eSvJfi1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io; spf=pass smtp.mailfrom=byte-forge.io; dkim=pass (2048-bit key) header.d=byte-forge-io.20230601.gappssmtp.com header.i=@byte-forge-io.20230601.gappssmtp.com header.b=CsMpWE/3; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=byte-forge.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=byte-forge.io
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e637669ef11so2609168276.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=byte-forge-io.20230601.gappssmtp.com; s=20230601; t=1742106050; x=1742710850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRuBgW5pTmhirx3OpAjIBt1dpt1sUJBVe+vdOmFkWGg=;
        b=CsMpWE/3+RPHifvv/y972w5lw3TLghbZzpPX01/j9FZmyaG5S0N7k8LtGr0eo1dj3t
         saPwgHVUCRKF35yQPMtBVmyA8wOk6QhDZWsQ2BdlxeSJkR43drNFDzk+LeM3z44AQhvI
         AoAggDKzz2cnFxuzqU3hr2ogqZeQ5dM0QeEelK0Yjbd5lY7nF/8HxD9tL17ektsDVIpe
         FikB8Xwxqm1Y3fa4xxIPgiUpdumaZT2JhuJy43eud4ZFo7WCTVSW7a4b19eZoj765FuL
         9h3tnEccwfHXHMZUL5ezAmVm+G6KL8S3wfJCBTi4xED9RddPjWHOudNRxMgN2BANsuiP
         BrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742106050; x=1742710850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRuBgW5pTmhirx3OpAjIBt1dpt1sUJBVe+vdOmFkWGg=;
        b=l4VOYQ3AU+c/i+TU5bBxfRvlPKszdz+bwFclC6f4I2Lh6uml56bJ9fnXvaK8cyrWt1
         Awdgm+rBKN8QXsq8dWxVzS39taO5hpeM0+AccL12JQ3CH37UgAQd/72sJSaqLXryb+25
         CrzGGLp29VHjp/8GKCRAdV/g5qbbPuZaGuVnaqktxBX40RceH8IMFisoEOx/gNZZ/VVJ
         r6hg/5/UOWMcfPSC4kvDrDLMStqEraSvWYa3Sw7ind3Iiksy9F8YttDfw8znIRrhOlMJ
         e8d3wEMLbRizRFuHD+IsuH0CD/VIobpg42tH6CtpRSWPvJH7DF3kNBZ9H4wwF/R2dIjE
         bm/A==
X-Forwarded-Encrypted: i=1; AJvYcCX1DI0/ocqvlERppo8uPkywa6uZGlHPsWWIoLmbD/Ka6IO3f61Nv9G2huPXNti3umYMcOJfifKp8dKTvYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfU2HUqEQjFflFAX2SRjf2jqqYHBoDLawuzURyHxkGdxUnpbp
	Id4MeF6c+sQTo2BSVOG7uLxEkoSxU9ckURojNr7z7RcnZ1zWM3eLIEvste+JCOs=
X-Gm-Gg: ASbGncuqbx+SK94h7YQ6wfpZoeHVrnJgLtJoYdjrp/V2g0QcY5hc9rGQSi19ZaYLBnS
	xzvD4kNP08v/NKwvdE8baf99PQ8eoiJrL0fF2oEKKdxy4F/FDtXPWUSAM06YongxWJzQJMe6Lzp
	PU48CQisoXQ9faAjhHcZw44IUryGIikb3bmDOgaET/tymu8vUaGIKoworqtTAxLrlOJ6PjFENov
	aGEDrs5QSp8PUn8QM95nQKSd7wUoRdUpel0GzC/7mGWnyCTXuurA1Y728ZmA2IfilgqQfYVGeYT
	8H6ArbXYSZKaZq1e0TmM1/0uEOKEToUF0/frkwVvvY9RF+o6Yg5QPnUzUyqqqPMoJKY6PigAtcX
	/g68uduME0IxW8NY7tWH4MyM6bCldbA==
X-Google-Smtp-Source: AGHT+IFjqF5F9SkIm2+wYJJftKckMiDKvYavs3s6/aNn5NMlWlQ6jGMLeiKdZAQvo3sIocBeAP26lQ==
X-Received: by 2002:a05:6902:1009:b0:e63:d10e:edc4 with SMTP id 3f1490d57ef6-e63f64d4779mr10713515276.10.1742106049899;
        Sat, 15 Mar 2025 23:20:49 -0700 (PDT)
Received: from Machine.lan (107-219-75-226.lightspeed.wepbfl.sbcglobal.net. [107.219.75.226])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e63e53fd277sm1618673276.11.2025.03.15.23.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:20:49 -0700 (PDT)
From: Antonio Hickey <contact@byte-forge.io>
X-Google-Original-From: Antonio Hickey <contact@antoniohickey.com>
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
Subject: [PATCH v4 13/16] rust: jump_label: refactor to use `&raw [const|mut]`
Date: Sun, 16 Mar 2025 02:14:22 -0400
Message-ID: <20250316061429.817126-14-contact@antoniohickey.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316061429.817126-1-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
with `&raw const place` and `&raw mut place` respectively.

This will allow us to reduce macro complexity, and improve consistency
with existing reference syntax as `&raw const`, `&raw mut` are similar
to `&`, `&mut` making it fit more naturally with other existing code.

Suggested-by: Benno Lossin <benno.lossin@proton.me>
Link: https://github.com/Rust-for-Linux/linux/issues/1148
Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
---
 rust/kernel/jump_label.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/jump_label.rs b/rust/kernel/jump_label.rs
index 4e974c768dbd..ca10abae0eee 100644
--- a/rust/kernel/jump_label.rs
+++ b/rust/kernel/jump_label.rs
@@ -20,8 +20,8 @@
 #[macro_export]
 macro_rules! static_branch_unlikely {
     ($key:path, $keytyp:ty, $field:ident) => {{
-        let _key: *const $keytyp = ::core::ptr::addr_of!($key);
-        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
+        let _key: *const $keytyp = &raw const $key;
+        let _key: *const $crate::bindings::static_key_false = &raw const (*_key).$field;
         let _key: *const $crate::bindings::static_key = _key.cast();
 
         #[cfg(not(CONFIG_JUMP_LABEL))]
-- 
2.48.1


