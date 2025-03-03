Return-Path: <linux-kernel+bounces-541180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC11A4B9B9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9A583A6CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1A1EFFBD;
	Mon,  3 Mar 2025 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UQjX45Bb"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4921EFFBA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991554; cv=none; b=ArYxpPKS2PkK/9ow2YtcfkYttFIk6RYxBpixZa0oqdCfOkSZtq55Jlkw3+oS2B0Q0Q2Vrm+d3JHBLDaENOo5+0T+ofnNUj/Ul9mUgI9Y3bLjnpxHoGorEGMF/LU2JMlnobRej6R15PWtSw+5wAmIRfc6elK9bDDd+sr5M8RjbsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991554; c=relaxed/simple;
	bh=GN9iRw4vP0biBC3qh1br1TYeqEjFY0JaW5FPcfgG69g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Dd5l8XQUbCmPWMHdqrruwLXlU9ZHqFoXNhbP0OE23p28DbIE7+ivTGKizNPsyH9ygWyG+cXJ8fNSegeWlRfX8fm+4Ky3VfOEwU4Iz1sidEerbJYPOquALXqjJVvc+CzoOLnWCNuYrr1T4zPpyBSvmp/eHGGUcyDAFka4C8LlcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQjX45Bb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43947a0919aso36022885e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740991551; x=1741596351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl6OXiLxc2DNrX6mWydkEen+W3a+U6q5HOC8/Fd7HQw=;
        b=UQjX45BbmOuzFCwAXHzsrAeP+DcZZ94uw3I8CFSpzW6Nq/RXU0H9rUrG91zqqtos93
         K6wRZisMj36oWysO7sKlB8iGU6AWoOCfkymZy0TgN9cqbEIzSFCw0nqMxMlFKn8Av7PU
         3K+mbF4uMs2+RmYnmx0WqrZ+slJbxrlX2hB5u8tM5QQ7XbFD3hh0IjxJaOFzdvzEBF4l
         BvRfB51Cf+2l0zXZmpibI6qTSw31zMigq+9ir1oO2/egoqS0pmqwrqGB6G4nwXhTWZy8
         AGxtSRnlUUa8iGgmEuvCDArUYdyhW/TzHMzI11vZcL/geEMWRdPBWAQUsFpiKv12rmwu
         bgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991551; x=1741596351;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl6OXiLxc2DNrX6mWydkEen+W3a+U6q5HOC8/Fd7HQw=;
        b=lI0VrdnzRGECMeBPSqqZPL+ZHzlfP00NWXEsQG7/6NAMQ0nhzyFK+95QI2tYLWk33A
         7TCMBbBtOAosz1+GWDZVDO4GYdc4oT3SqWRdq8KiGkon1ZPyhSo1jRf7psvJ93/fFiZH
         JZeR18lcb0/LI+bP1LCrCVEYH9jOq7JkjF/OSxySPAswzn+8QUoegO3DazhWjNB2kOQv
         w9X+VguEt3HS/XYxZ96DHVPvy/IlDHCT+FJCqYKGx7dft6YasfpJUAfQzaKgJoADBzCh
         +N+U75uD0RhKpwwvkj+wlBzUPG29J1DPAPtoFWb2GgP1BinIYk0jUSVLTHdnFHONMy4y
         UYAQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+qutougMaYxlc3/4yETXW7Buxv8k3sv/sYR5UDg+Jayc0Yf21Cz+3WZjCHhA4pvZMLGqSo+BJN2ypH/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEm2rwH3nZVGRebLuAqtIQHCWD4dCaqN6PAMi5eERJstJf5a7
	Y78IQXxUhQdfn4MUAkW41UKtm/QGXpHxzOXCtVFagN5Fw9H44wlMyx0qTnAqzU5PSsbFRUndPz0
	0gsKLDKE1+WHijQ==
X-Google-Smtp-Source: AGHT+IHTziRho0PdDiqY+w7INFWExFlSE+JgzgeyQW5xfAW6NBxpwCji0bm/eXLdqeaM8WMzyupzDJI8C6vUsII=
X-Received: from wmqe20.prod.google.com ([2002:a05:600c:4e54:b0:43b:c7e5:66e0])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1990:b0:439:9b80:ca6f with SMTP id 5b1f17b1804b1-43bad205987mr103494675e9.5.1740991551369;
 Mon, 03 Mar 2025 00:45:51 -0800 (PST)
Date: Mon, 03 Mar 2025 08:45:13 +0000
In-Reply-To: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250303-export-macro-v3-0-41fbad85a27f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3689; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=GN9iRw4vP0biBC3qh1br1TYeqEjFY0JaW5FPcfgG69g=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnxWw1V7qzGAYepkGLB5056taWAfpA48W2E+6j7
 36pkLuCplKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8VsNQAKCRAEWL7uWMY5
 Rp0OD/0YxQOPsE7P9lwb5wr1WtaICm79Mv5E1VBseN+IJVPkRaMtI9PZOPMYl2nkkxIthFrBfB5
 VA9z7R/Ayu59wN8WJG0KaAP+4b6+Hf/7NK4Qja/DBtDxkgk7NBz4suJ1OIfC++krRwnTX1Sja+m
 W3tz69mVlP+mq3G4KB/KJ2krJ4m7nmpcQLxjnmyKbjhR4J6FQaYv6HOmelCuvKdkWJGFar4mhe4
 6JPThxK3D45Jmy5k5LnfYQaRNn1xB6IdprUAVEt85bp4HvqgSjMof/Cvv/+ygRmAHijGM6ikJnG
 eCQGzRajiTA5q6rWl1HC0EmbVELa4Wl8ytL5rj+N4RJBCCV9+n5SJeXFy0V3D/6VoY6qDbObxj7
 /y1pjasux7b8tEe3ffOrYqDKK3j+rx6rmzOuYs/Yuv2EnMMCIttl6GuxwQfkKfGXGJrYWrGRTRs
 iyFHvwo4C8MJEvQaG4P/wGwxyM2aSRD7MJoIh8neJFojUpASlc7g/zA+MfArJlfmeuP6ktX2SKv
 xSeAIu6RAEVXp2hC7SQJ2jKkt2GQw3RGvWKosp9L1Jl6kjxUUXV8F1wUTtYAcKB5/ovsh9tqORV
 opNlnGdFoiM4XyttGOBynM7Eq8Aci+A/UPofTC7lxRjHejSQjL98l136YwRA1Mi1eOOV9Bppl5d pjkjLpnriIPhq5Q==
X-Mailer: b4 0.14.1
Message-ID: <20250303-export-macro-v3-2-41fbad85a27f@google.com>
Subject: [PATCH v3 2/5] rust: macros: support additional tokens in quote!
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Tamir Duberstein <tamird@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This gives the quote! macro support for the following additional tokens:

* The = token.
* The _ token.
* The # token. (when not followed by an identifier)
* Using #my_var with variables of type Ident.

Additionally, some type annotations are added to allow cases where
groups are empty. For example, quote! does support () in the input, but
only when it is *not* empty. When it is empty, there are zero `.push`
calls, so the compiler can't infer the item type and also emits a
warning about it not needing to be mutable.

These additional quote! features are used by a new proc macro that
generates code looking like this:

	const _: () = {
	    if true {
	        ::kernel::bindings::#name
	    } else {
	        #name
	    };
	};

where #name has type Ident.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Tamir Duberstein <tamird@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/macros/quote.rs | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 33a199e4f176..31b7ebe504f4 100644
--- a/rust/macros/quote.rs
+++ b/rust/macros/quote.rs
@@ -20,6 +20,12 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
     }
 }
 
+impl ToTokens for proc_macro::Ident {
+    fn to_tokens(&self, tokens: &mut TokenStream) {
+        tokens.extend([TokenTree::from(self.clone())]);
+    }
+}
+
 impl ToTokens for TokenTree {
     fn to_tokens(&self, tokens: &mut TokenStream) {
         tokens.extend([self.clone()]);
@@ -40,7 +46,7 @@ fn to_tokens(&self, tokens: &mut TokenStream) {
 /// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
 macro_rules! quote_spanned {
     ($span:expr => $($tt:tt)*) => {{
-        let mut tokens;
+        let mut tokens: ::std::vec::Vec<::proc_macro::TokenTree>;
         #[allow(clippy::vec_init_then_push)]
         {
             tokens = ::std::vec::Vec::new();
@@ -65,7 +71,8 @@ macro_rules! quote_spanned {
         quote_spanned!(@proc $v $span $($tt)*);
     };
     (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
-        let mut tokens = ::std::vec::Vec::new();
+        #[allow(unused_mut)]
+        let mut tokens = ::std::vec::Vec::<::proc_macro::TokenTree>::new();
         quote_spanned!(@proc tokens $span $($inner)*);
         $v.push(::proc_macro::TokenTree::Group(::proc_macro::Group::new(
             ::proc_macro::Delimiter::Parenthesis,
@@ -136,6 +143,22 @@ macro_rules! quote_spanned {
         ));
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident = $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident # $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone)
+        ));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
+    (@proc $v:ident $span:ident _ $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new("_", $span)));
+        quote_spanned!(@proc $v $span $($tt)*);
+    };
     (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
         $v.push(::proc_macro::TokenTree::Ident(::proc_macro::Ident::new(stringify!($id), $span)));
         quote_spanned!(@proc $v $span $($tt)*);

-- 
2.48.1.711.g2feabab25a-goog


