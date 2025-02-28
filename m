Return-Path: <linux-kernel+bounces-538518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4FA4999A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5C63A802B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEBF26E147;
	Fri, 28 Feb 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mz1u5BPl"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FA926D5A2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746414; cv=none; b=D5K6OrNMTBmLZAuK+ZE6dVNGipZlyVaN2751GLjFMGe1BoR8/kqeFh7luRM/EsOsNye2yhGzX5eYNeOs/7Mp2BpUOxfos90t6i9BNup5M5/BsyiKEk2WcQOO+OE5biyvfM/hnSteB3ziUy4yymEMO2pPAW9updnkgCMItLGSCCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746414; c=relaxed/simple;
	bh=2kxCqgatimm9DkO+86c5Mx3XyGNaZZFNb0jwXIeUduQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mH9pi0REOhuVKUwJtohaCMw9kSsLK/b5VEJZfpeerqohmSqqscabzbqBVigeC5coGmb+N4SK72/l1/PQJMb/9FCvEDQRk2E63jjVFqhWH6jgGQfBpgrbs7TvRr4TqwKIMc+IA5jc4e6Uh379TSZJa/gMjYNn0UDj51dLkfuB+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mz1u5BPl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-438e180821aso11335305e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740746410; x=1741351210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihZxooYknzT0g7MIwrtZdZDoHsnETfvcwFPVB5oE20g=;
        b=Mz1u5BPlTn1EyJPtEYazVKxoAu0MUMfM7xIRW3ev8A2pDpszZejna2SHgvyv0GiajK
         0mtMGz9HwKxZJOURg4i68Nw46BLAHf6TuDdR9JzX8M0WGpMIYVchIe111MzUq2ACEbZe
         73R/at4Wj06tr96TswTzNniDYrsH+M4VUM6R6w/ul2tDp8FCKSDOj1gZLROj58r1cYt0
         R0dzSGAJ+763stNF3ItlcnnI9y9kdkGA32hpl85407EGuX2TRB5J5B134bMbae7ZIJhM
         S8ZxDbQwWj76x/YMjDBk4/OOPLVXTcM5y49IEUT2A2f+Kd7VyIt3YKyZ5LQwc7SnYRGF
         G80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746410; x=1741351210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihZxooYknzT0g7MIwrtZdZDoHsnETfvcwFPVB5oE20g=;
        b=aISa7onXNUE/R/o/haj8xrB/KdnQfGeUhzR2rxx+JDHHT324PlBAUaOmtfJ8Ww1f8H
         GRE0/COSLrH24mjrh4ZCwoU4PW1QJoyZQ9ssU0M+Evzy57/jtjOTPshBDebUIkQu2UTC
         TcfixSQqufm5powdGxQH9Ywz2whysJ+BzoUxmwWVwFOqW/k2AZAOVsxPmAtQaeEersMg
         yy/NlIIoeV1ZGfimwJRn/faAMB+FaAJkNKnMvocEDtZQyVHWAY31Ix8inW8aXxm47Gij
         FoaEdCZHJ44QrpYu1oCZuGCyXcQrYOYZCH3F/DLe/0zKbcx/5jebFK0KIdzQMMUMkUd1
         GnhA==
X-Forwarded-Encrypted: i=1; AJvYcCU+H+lMzCohymab09lyQ0PYN21ZtLkF4AACeLdm88Hj7lgUils4lyh32e0C6qrwRVcqZbsmtoBkxXwgPM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3RDKJdeDqlyOJZeXEUtewOupsXR2YoxU3q3ot4e1/ioyBFybw
	AW35R2viP7zEPVpt0vqvBUgWu2nwEXjsxKLfEu1kJFSChh01GQGWSBUdEyyJcdouGAuSluNg6FZ
	/1QLlsOwUCpWzuQ==
X-Google-Smtp-Source: AGHT+IGMEITDLjU4ASlaZS6GD8Wn7exwSBzOaUHr7x/3v0wRj0xk5+dqwptvCzuTjq4s4FptkTDfbSPgA1O7jVk=
X-Received: from wmbjg14.prod.google.com ([2002:a05:600c:a00e:b0:439:942c:b180])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a03:b0:439:9b19:9e2d with SMTP id 5b1f17b1804b1-43ba6702becmr29268005e9.16.1740746410006;
 Fri, 28 Feb 2025 04:40:10 -0800 (PST)
Date: Fri, 28 Feb 2025 12:39:31 +0000
In-Reply-To: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3131; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2kxCqgatimm9DkO+86c5Mx3XyGNaZZFNb0jwXIeUduQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnwa6gi4HcYLwOcjP1+4ywczOPXPU6Ct2zzIOxr
 Bd2hpe101yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ8GuoAAKCRAEWL7uWMY5
 RpM/D/4hjhqbZcF9DblDJ2gtwYChZ7TjKidwXbqaZS2uFBN1bIFeweV0YoVoeZcFHADd8cv7bfs
 Ub11cChO1fW+ZTL0mjSIyMS040tnKhjG6eRgkq2emew0vBTo8K1FVrJYcTQIA0HJMfogwOWexr8
 oA/kxR+bUlhTOJn1fXdositwbuiBsu+2ZDkkeocob8oFDkfgsGoctAU30UKauDwdE2HNAytT2TS
 7eGXelDyCe2HCYBuY7N2f1j/sInwm+eudSi+6jJynDQUg0RNUrGYmTb1zPrX6AZN8jeAMfsegQY
 zpw3e3lIYu/augysePE1HG95uNFNL9fYvh8jFr72nuLlP7qtpu3/fcB3wpHhxcSkv+lyG9Cpjbu
 alfvEgF26SVpdND0F5ng4XtNROT/ZLKYOnUPJLHrroAO3N5m0dvhfu1/D164xIzvZymhyeEByiF
 x3rYz8qQNqJOvypQ2PpcTciMJshzHlraOEoMtpONn7C1Dnk6nG8tSNquB9ffhF9xhY8yGajyNKV
 uJck4NUgxNadRWg4JrHJS/X5uSChoHCZmqsG0028wjlDhRGu/B3dvBOhRrhFWX4kpVbxTqyK3Os
 01jSp9gEmFWSGRJhaJROwxY88GQyKPhXJkqTlFZMyW/lq+4ypr52F/jJcmp3V/S+L9/O5uSKxhJ 0wTtrurvO1EjnWA==
X-Mailer: b4 0.14.1
Message-ID: <20250228-export-macro-v2-2-569cc7e8926c@google.com>
Subject: [PATCH v2 2/5] rust: macros: support additional tokens in quote!
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
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This gives the quote! macro support for the following additional tokens:

* The = token.
* The _ token.
* Using #my_var with variables of type Ident.

Additionally, some type annotations are added to allow cases where
groups are empty. For example, quote! does support () in the input, but
only when it is *not* empty. When it is empty, the compiler cannot infer
the item type of `tokens`.

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

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/macros/quote.rs | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
index 33a199e4f176..c18960a91082 100644
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
@@ -136,6 +143,16 @@ macro_rules! quote_spanned {
         ));
         quote_spanned!(@proc $v $span $($tt)*);
     };
+    (@proc $v:ident $span:ident = $($tt:tt)*) => {
+        $v.push(::proc_macro::TokenTree::Punct(
+                ::proc_macro::Punct::new('=', ::proc_macro::Spacing::Alone)
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


