Return-Path: <linux-kernel+bounces-267146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F51940D6C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E243285452
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69402194C78;
	Tue, 30 Jul 2024 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cV8MjE+C"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C52194C6F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331590; cv=none; b=tRI8L5H8NcXKcFnlNG+utEez5eEI8H7t7ykHgyeWN1CFBqlbpe7LP38tIsLUUcAX5/S0O3xm23n91OIoBdJvE4zTnTTwhCJdGsQP+OP7ZvOuWnKQ0WStflLcGSpXaMihj9xNLgNr1PxZLb/WjwkUe7PK6gPA5peJh5QtcoGrYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331590; c=relaxed/simple;
	bh=DNng86m/nG7eKCwjjSfaE0C/CmytQ2Vd45z8tD7bi4E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NLvbpfNsY0fiKYc+CZ1QnMq+w/ADL4f+UOPrnhpY7Z08Z1Eg2mq4rjqfDadqOXxE23v9Z04GdxdwR77MIxesCKndigG9msiR6zwaSTVILa8I/ugtrJbKLP4JYMPDF1t+2XE5uLOB5/OJ14JtoKj7Hu+N7/eZ0h317LeioAHSOLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cV8MjE+C; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02fff66a83so4908915276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722331588; x=1722936388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VML2HbGiUTKZhi3Ueqq/TeMG//3EarZJVerpVJbBcDQ=;
        b=cV8MjE+Cma1wbBhIN0gSSwUeCJjIx9e9Jud77R/cU+Cm6htbEIHC/Hsetka8gf2KQl
         K0vhLa9r3N3rB+9lOwEGvsZO88FoTmyno7l4E7BMTCZFg6I1oUYh7jioz3394JUwEXwm
         Oo5rmCsJUJS3mF6lHGezN6L/uhpIc3o0e4/JhevpR4jQVBOCEbDF+mbgddiDoEp+Pxbq
         QciEwleDaPsrIVwSbBwDFNh2zCUlUTuZ75kW2RwTFaVwXWBkdWw/PIQw1pXazH9fPSiZ
         ASs0rv3Qz7zpXd2M02m5pxs7E2EAnpsbbEXQNbEhxfCZnlXcgtKeonZUBAlV2027Uj7O
         B4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722331588; x=1722936388;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VML2HbGiUTKZhi3Ueqq/TeMG//3EarZJVerpVJbBcDQ=;
        b=tGsF+AxO67+Bo41YVX9D4pYGdw9UwO1zfneIcDQIHThNaS+uNRLN7REyfm9NtQGVAd
         lNQiFModYneQNd1CLRgiiW68KYQgHOPxk5LzdVxNwxMl+ze4bHaFYu6OFhabBCSHKOpk
         y/LS6uv0XLbhj/FMzQ3D46z/KRnVnpIKMi9CK7oppBOn7tVcbjvh+/DrcsbExDsW1gt8
         uB3yigjUH8KLM6ioyAhnlDKAv/6weFs0/WSALZW2wANCMJt5ZLfULbKSuukQ1I/LI0nJ
         8sPP7GTpFIRAPyk8eO6JD3/9WCVnAMj8RfT5s3vMcEuDc9WgnwRxAXpJ7fNuQQckZ1hI
         Kfdg==
X-Forwarded-Encrypted: i=1; AJvYcCVRA3LC34uhB4bkkpeOZwXVBnb0B3E2aGFC5HLKX2+wKlNQTYihCIavXYXe2QFJiAw058rUBrl+wBHG3o5OqjLbL0l6piLH8lhWPahh
X-Gm-Message-State: AOJu0Yx6od9qkhRJnTnhKjGXfuOG/s5srHkjRzJFeCUHxAC6/uaKfqYn
	SX/8n1Hc+4h7NMW2saIvXXRqPp8eNSomKMDDAMc+qyKWOznb8lrMR3IjyUj0Oc1sBlZqjwudkmi
	xha0+2tZdQUj+uA==
X-Google-Smtp-Source: AGHT+IFRabzit2U8MQ1AhYZVNcAtf+V05lxt2Mhbe36DAIzEK0X8ZTykDoIHEYIJazhezM9vrrGeZDgmzK8JjiQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2b8f:b0:e03:59e2:e82 with SMTP
 id 3f1490d57ef6-e0b545a3f3dmr16655276.10.1722331587758; Tue, 30 Jul 2024
 02:26:27 -0700 (PDT)
Date: Tue, 30 Jul 2024 09:26:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=4863; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=6f7uSFok43hFyVxJDFLBZ+lpJfu275jOWZwnwhrCUMQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmqK5BQcw5lb0StHJAmTTpGoGCT6xllWbl3/SZI
 p/9XiRWnD6JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZqiuQQAKCRAEWL7uWMY5
 RozeEACF3hdtBDVwCfw7llMzHFTre08sQJgsY9xzFZmjF2Pkf9FuouJbPQrme+NMkNS0368suQs
 al0Ach4WVkOU5vvRG9aFcrp7+Aa+1qRmYEZGJBUulPJWqUU4RakCx1PwlIz2LtaDAeWz762mKgw
 2DySuDxnqf7NhihXDDSkcZU3GbTNn4BOowPhhN6SXZbOBxBSyxj8R/6UtIpqfnkh1BDoYjjSOnk
 eX/e4IZkl0ud29VRKngVNjqimclTF3xPbuE4fJHWMKzobQlRCa0zfdlnZkg6GwWeTazkwgnwZXA
 Vhokp1PRpcT67a5iNyRlGS8B7g6xuZqyogdGgoij+h2ZTA0/uYZIgCJ3GtP0fvvxk9fkhZvsEvB
 PQ+1zZ5qbJoZKOe5KwgWjJzYOFRw8wa2aeW77c5rXkb39nMi46Jhsp363Kg66ZU9on3U6Vc8cO6
 b4GjsoDqoEVKGRTPoNWJ+9lmJqBkfezutIfantd7sl3DSN73amlPTss8346G0p0Dm91ru87QTQb
 3Wgd0Igm/UqEf2Z1x5Zmk5txJNvK87w9GHFTtbTCxB7lblKHblR5JfESWckLReVClbmnL0P3TUk
 RU00M2B2DFl+RlgLaANy9qheWSq0ZY8E6wggZVTsOBMpa4TbVbdlF6iGCDvNRy12+ZwJ/nTWIvG mw5JEKLT6xJXYVA==
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240730-target-json-arrays-v1-1-2b376fd0ecf4@google.com>
Subject: [PATCH] rust: support arrays in target JSON
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Maurer <mmaurer@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Matthew Maurer <mmaurer@google.com>

Some configuration options such as the supported sanitizer list are
arrays. To support using Rust with sanitizers on x86, we must update the
target.json generator to support this case.

The Push trait is removed in favor of the From trait because the Push
trait doesn't work well in the nested case where you are not really
pushing values to a TargetSpec.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 scripts/generate_rust_target.rs | 82 +++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_target.rs
index 87f34925eb7b..c31657380bf9 100644
--- a/scripts/generate_rust_target.rs
+++ b/scripts/generate_rust_target.rs
@@ -20,12 +20,28 @@ enum Value {
     Boolean(bool),
     Number(i32),
     String(String),
+    Array(Vec<Value>),
     Object(Object),
 }
 
 type Object = Vec<(String, Value)>;
 
+fn comma_sep<T>(
+    seq: &[T],
+    formatter: &mut Formatter<'_>,
+    f: impl Fn(&mut Formatter<'_>, &T) -> Result,
+) -> Result {
+    if let [ref rest @ .., ref last] = seq[..] {
+        for v in rest {
+            f(formatter, v)?;
+            formatter.write_str(",")?;
+        }
+        f(formatter, last)?;
+    }
+    Ok(())
+}
+
-/// Minimal "almost JSON" generator (e.g. no `null`s, no arrays, no escaping),
+/// Minimal "almost JSON" generator (e.g. no `null`s, no escaping),
 /// enough for this purpose.
 impl Display for Value {
     fn fmt(&self, formatter: &mut Formatter<'_>) -> Result {
@@ -33,59 +49,67 @@ fn fmt(&self, formatter: &mut Formatter<'_>) -> Result {
             Value::Boolean(boolean) => write!(formatter, "{}", boolean),
             Value::Number(number) => write!(formatter, "{}", number),
             Value::String(string) => write!(formatter, "\"{}\"", string),
+            Value::Array(values) => {
+                formatter.write_str("[")?;
+                comma_sep(&values[..], formatter, |formatter, v| v.fmt(formatter))?;
+                formatter.write_str("]")
+            }
             Value::Object(object) => {
                 formatter.write_str("{")?;
-                if let [ref rest @ .., ref last] = object[..] {
-                    for (key, value) in rest {
-                        write!(formatter, "\"{}\": {},", key, value)?;
-                    }
-                    write!(formatter, "\"{}\": {}", last.0, last.1)?;
-                }
+                comma_sep(&object[..], formatter, |formatter, v| {
+                    write!(formatter, "\"{}\": {}", v.0, v.1)
+                })?;
                 formatter.write_str("}")
             }
         }
     }
 }
 
+impl From<bool> for Value {
+    fn from(value: bool) -> Self {
+        Self::Boolean(value)
+    }
+}
+
+impl From<i32> for Value {
+    fn from(value: i32) -> Self {
+        Self::Number(value)
+    }
+}
+
+impl From<String> for Value {
+    fn from(value: String) -> Self {
+        Self::String(value)
+    }
+}
+
+impl From<&str> for Value {
+    fn from(value: &str) -> Self {
+        Self::String(value.to_string())
+    }
+}
+
+impl From<Object> for Value {
+    fn from(object: Object) -> Self {
+        Self::Object(object)
+    }
+}
+
+impl<T: Into<Value>, const N: usize> From<[T; N]> for Value {
+    fn from(i: [T; N]) -> Self {
+        Self::Array(i.into_iter().map(|v| v.into()).collect())
+    }
+}
+
 struct TargetSpec(Object);
 
 impl TargetSpec {
     fn new() -> TargetSpec {
         TargetSpec(Vec::new())
     }
+
+    fn push(&mut self, key: &str, value: impl Into<Value>) {
+        self.0.push((key.to_string(), value.into()));
+    }
 }
-
-trait Push<T> {
-    fn push(&mut self, key: &str, value: T);
-}
-
-impl Push<bool> for TargetSpec {
-    fn push(&mut self, key: &str, value: bool) {
-        self.0.push((key.to_string(), Value::Boolean(value)));
-    }
-}
-
-impl Push<i32> for TargetSpec {
-    fn push(&mut self, key: &str, value: i32) {
-        self.0.push((key.to_string(), Value::Number(value)));
-    }
-}
-
-impl Push<String> for TargetSpec {
-    fn push(&mut self, key: &str, value: String) {
-        self.0.push((key.to_string(), Value::String(value)));
-    }
-}
-
-impl Push<&str> for TargetSpec {
-    fn push(&mut self, key: &str, value: &str) {
-        self.push(key, value.to_string());
-    }
-}
-
-impl Push<Object> for TargetSpec {
-    fn push(&mut self, key: &str, value: Object) {
-        self.0.push((key.to_string(), Value::Object(value)));
-    }
-}
 
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240730-target-json-arrays-17c8d1799f9b

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

