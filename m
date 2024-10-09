Return-Path: <linux-kernel+bounces-357461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D60997184
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855E4284C05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765471BE869;
	Wed,  9 Oct 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTx+AqnA"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B51E00BD;
	Wed,  9 Oct 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491049; cv=none; b=ZtoOIeTnmsyBRquvkHvZ/Ta8Jf/ptiu6e2e6k8SBL75xHDqQCfCkBuIRNKYrCGbEVhgFNF3uHLNrtXpvjzGE8XfNQB24jMHTQzfvCb6ci+mET+Xj//x8eySHaQcA6MGBN2Cr56M/n30rnpHCUZhXCN97hFPUpM8cQfAALaqIo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491049; c=relaxed/simple;
	bh=lSqKr7ujv2pq7bGJq1M2LimIU35mzssWOxO7oJPtrHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dENAiY2FrufHmFXQGrHBdU1LlynfSfqQuFeWLXUY7kIcGahb81X1L5VXva0L7VMAhjMbU7R+7+fe9F0wg4a4AbEHsY7lrNeM7HeVP321bhyC0mhAhAyA2u0tJIC98XkRhpRlvVCYiWmDhUuNHzvCEPJc25xjCjpJSTKfehS6nqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTx+AqnA; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbc7c77c99so232486d6.3;
        Wed, 09 Oct 2024 09:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728491046; x=1729095846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujutxpaq9CZiYtd3me9TLwpkpP+oG02z8shTk8cW3us=;
        b=DTx+AqnAFZ8K9mTmUDr2f+K0+umzQCsvL24WMWew4AdLdqBSNpyZ1gngArC4YkPzh3
         mhRC/W3ZJvK4EDLKmdgXpFrq7zW/ZIzrGdpzDj0xyjAY7b2OWmX9u+ZvQ4WgtdIjWmKT
         aa4Ku0RIRYe7+cLmtfkqtjbOIB5wJHT37NAauIZU548qlzHNC+8WuS8BczAWFFrjAo5q
         UDRX6eHHdBkvtL/ThCaKsG3KpNaRUMcNU/DcKQelB4iX+y+o6appBHM+fory7MxSyfj7
         ag/QKBxHXn0Dpw/uc12liuppwclMSeoFpEwIvPGc5LTySlyBUnAYx45dyPX6Oz3DxIII
         W5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728491046; x=1729095846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujutxpaq9CZiYtd3me9TLwpkpP+oG02z8shTk8cW3us=;
        b=TdA2l7u1AzosYiA+nFOhUPG71qaiSSIVijVhDzrCC5F9BsWjn2qC/DnVjxH1+0VyWG
         HKksQMBoeM/uGdMWuY43S9npHq4QYTCImsE8iNyyl5hXZ+JOtqR1cRnfo8d7S9GOwddr
         FpKCvEtbpF337/JeX+qQvCwM8r34k652GymdqieSa+xDxyCoLSVzszY1ZVDqPLgUdeok
         mSjOLzp9SaKh8nEmXK2Im2sL5vge1nNVFrCprT3WvZOLlkTV9bTahLll1oNYZdX8kp6/
         IanyNuAxnBqulMiXECUl7n72XkhVBS1NJE5m8bEbcF5nvTraw+/7AMkGbhZ7dKlzLgEa
         TGeA==
X-Forwarded-Encrypted: i=1; AJvYcCWwrnxnndxmcjM3vxYM7u69Zh8k/JnXeRRzmD86mj+9jIQoJzPMY7njA/PvnRubVNrviSDHEaVgy5GGMOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9ex+MvFijpDYb3n+KvSlvfqvYHnawgS+fGStn1ycjAJq8s+L
	jv8lEZEQ1GYuP6vxXVsvEThFJBXZC7tFfgweIXaVsh2njhXBkjRkE9fiN1bT
X-Google-Smtp-Source: AGHT+IEhzl2yBkieCTYVSOyYm1n4jbWf3LryjJ79u5MZZHDut8Zn/bszLCE70uhwqwcf5y3Hr6zAng==
X-Received: by 2002:a05:6214:3287:b0:6c3:5a86:6a29 with SMTP id 6a1803df08f44-6cbc9321ef0mr45731476d6.21.1728491046219;
        Wed, 09 Oct 2024 09:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c091:600::1:6bd1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc48e691dsm15015956d6.68.2024.10.09.09.24.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Oct 2024 09:24:05 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rust: improve grammar in commentary
Date: Wed,  9 Oct 2024 12:23:58 -0400
Message-ID: <20241009162358.27735-1-tamird@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
added an errant "the" where one was not needed; remove it.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/exports.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rust/exports.c b/rust/exports.c
index e5695f3b45b7..fd278e272751 100644
--- a/rust/exports.c
+++ b/rust/exports.c
@@ -3,9 +3,9 @@
  * A hack to export Rust symbols for loadable modules without having to redo
  * the entire `include/linux/export.h` logic in Rust.
  *
- * This requires the Rust's new/future `v0` mangling scheme because the default
- * one ("legacy") uses invalid characters for C identifiers (thus we cannot use
- * the `EXPORT_SYMBOL_*` macros).
+ * This requires Rust's new/future `v0` mangling scheme because the default one
+ * ("legacy") uses invalid characters for C identifiers (thus we cannot use the
+ * `EXPORT_SYMBOL_*` macros).
  *
  * All symbols are exported as GPL-only to guarantee no GPL-only feature is
  * accidentally exposed.
-- 
2.47.0


