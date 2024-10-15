Return-Path: <linux-kernel+bounces-365987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7329499EF07
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F19285022
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8ED1B21A1;
	Tue, 15 Oct 2024 14:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H8m/MibG"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E55147C91
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001627; cv=none; b=rMw8I4vmgAd1GsmmjcqVbb/5gQcHvgrbJ/qsgIhGRIVL3IvmVyAaRJ+S6ewxJRBKklLtS+8SBEJt3VDZfkjl56eHMLrvDr9lMrQ6cUtSM3TawB0xmCV7USrTHfP/iZf5QIdVG/dvb0MC4L3bC9MX/PjjA3WmBjAYgCxGv4YeVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001627; c=relaxed/simple;
	bh=esGUgm7O4TPfTm5BpANJQr6OVFe4+wbDRy3c41wjaPI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=poKR055byhblkA15duSbupJBkKQZo8x2DK9E8f3CbgDSmMvAt4nbnVgfbMn6qGWhijvUWD1nw5+7KGX/RMgc3d5cpzvuF7JZb0wAU6Yu/0VxNH9aGSp1MCpHaHtZ6tc2/Czr52F6HWXag/ivvZAWasj/Ul2efHlitTogYNpC3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H8m/MibG; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so5675729276.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729001624; x=1729606424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k+GdPG1ZhMC8AWALpkCPyVbAT6tm2kiC0WvsS2zGGDs=;
        b=H8m/MibG3q5Yb5BfsAssXcUBko2kC0zAqj7tVyHU/SyGM9S/OgaXYv1YZaXellZ5TS
         4yGtZLQVY2vttVORQwb9B49pdLsweAkl+2PdSEUpnzN6OqJoBAqoOgBDDjIaUMsk6HkG
         g2xAOYjdlAgACX4dMjmAbLc1B5r1JtYNuUqeQiUsU2cPmfodOvVAyDP+iCZKrkoaL18v
         LNE/5NK1/gdlBJfZNMvwV9+SFgr4HQQeA8czaEm7S9p7raBSKw4LXOaNBJzTKVIIcJXA
         OI1/fXm+aZFoCnk7Wo4gzNGScJSZgZLejQZZxl5vV6Ddg10xijnXSzhCt4sTMnDHMrGw
         VBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001624; x=1729606424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k+GdPG1ZhMC8AWALpkCPyVbAT6tm2kiC0WvsS2zGGDs=;
        b=fHmU7vrep3piFD2DPZrvxuuadTt6PtWy40rYSfEIJ6jgg9js5IjH7cAZuSPlkPsDZv
         j82ajqMX7MjR53jAl9oW3x7gv64Oqaqt4/B3Ti0YCSeo4BhqWW+jGigt2vhHHhvozxF3
         jZ75lO569VDGT8WmCSXzHi3ezUQGIDKr2/xqaV2hcipvDa1mEGBQVE7rSSXa5brnTCXW
         CNl0kvynXqRiGMCYJDTHP59jFGI6uPtaX4gk+IygxCZcAM1g4OottGlVqKYjUzKC5B5Z
         y/sD1rHDBs+wmFjsSZmdxo+MViIdZKE1NwdiCQVPh1iosK4OwqQ+6HexDriQmVDNos66
         Rz/g==
X-Forwarded-Encrypted: i=1; AJvYcCWhOIbwHiw5RIDNibuepSX6UUafUBtfFk6hl9eSYLmsVC3EKOv2QgoEces2VK5U9gqusQM7d0EkKUpUH7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1JLxWlX4ru45QDhxLswmPS84OEV4XRUjFUpmDUD6jEzDtGCK
	twhvO/I+cdiRtVdIx5OWY/yv9NZyQnMt/9hZpsoHnXVbKm/yu5qfrhiTE7EeIAdZFb8oXoMhthk
	JFCf9R7T5kLowDQ==
X-Google-Smtp-Source: AGHT+IFmBTdkAjAvW3eNE4H8ryvCsu1yFMMswGAXaVGuUaPRr6+vto9FlLY3i+BbjrfJKSZSB0hMtVmwAjqiA2A=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a5b:546:0:b0:e28:f19d:ed4d with SMTP id
 3f1490d57ef6-e297856f63fmr290276.6.1729001624366; Tue, 15 Oct 2024 07:13:44
 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:13:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAIF4DmcC/x2MSwqFQAzAriJdW5iPIs+riItSq3bhPJmKCOLdH
 VwGktxgklUM+uqGLKea/lMBX1fAK6VFUKfCEFxovPMtbmo8FZEFWdOBTHZgpB+5EIlj10JJ9yy zXt92GJ/nBdkxDEBmAAAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2093; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=esGUgm7O4TPfTm5BpANJQr6OVFe4+wbDRy3c41wjaPI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDniPuBAlFR0bB+F/4Ed6DmSMsCPzmQXwr7DGU
 YeQfhrxkNKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw54jwAKCRAEWL7uWMY5
 RiDQEAC44QnYkXSZLJSNYujCI6Jdm9d1sSzDHceVZCx+KCihIHzx1nbcvdrXOz2ipa52bm5e6Md
 QKGcQQD21YsVwJWGBQZhRxYK/tEAGLrim6IqlNaSISRT4bIMjVe40yrP0NXCsaMVH7vpwi4bpkn
 mtvoZvvoMF3qzpQ/9dOarFDqMn9vqF6NL9vDQrmv4vSXuJmmRV5kcu3xlezDfiZwdkJdL2urX0g
 /bG4PZeC0O33YAjW76EAM303JgoJWv9kMvFc9gjzMtaYi0wlp6RJxXMUkq9gn7QyBJ+6XiNGNbL
 e5eqbvuilaShixZ8cvKNahh5Et/lYblVQoXlrKWOtVhOyK90N7FJLskHcKkhjMfdvEclLUf2eip
 9vk1/vlD3tOSryRCulPPMuYg8eA0VaOAbZw90Oo0XFErIjI5XTqdS17rYGfh3/tmxAmDuDnUH8c
 LcztnmsMrNHzM06U05+aDw8OOhRWH3HD1Gtldib+j3ZIrVbmGgboJhxvaOQMQyQe5LN33gSPamy
 dWXR5lA9asxwf+Hx9EaC6gJKyrVYk7QPmC08vMnhrjoRCCBi7fNJe99tGmL8A8Es8vq8/LyQmwp
 yEeBfQegxgGpQ6RVgP414Cq3pNid7gOu7XScyjwzp8gKIFMQMcCbGffKfeaBJH1ettgGuWm30PP r2N39btUkMSL8Ig==
X-Mailer: b4 0.13.0
Message-ID: <20241015-miscdevice-cint-cast-v1-1-fcf4b75700ac@google.com>
Subject: [PATCH] rust: miscdevice: fix warning on c_uint to u32 cast
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When building miscdevice with clippy warnings, the following warning is
emitted:

	warning: casting to the same type is unnecessary (`u32` -> `u32`)
	   --> /home/aliceryhl/rust-for-linux/rust/kernel/miscdevice.rs:220:28
	    |
	220 |     match T::ioctl(device, cmd as u32, arg as usize) {
	    |                            ^^^^^^^^^^ help: try: `cmd`
	    |
	    = help: for further information visit
	      https://rust-lang.github.io/rust-clippy/master/index.html#unnecessary_cast
	    = note: `-W clippy::unnecessary-cast` implied by `-W clippy::all`
	    = help: to override `-W clippy::all` add `#[allow(clippy::unnecessary_cast)]`

Thus, fix it.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
This fixes a warning on my patches in char-misc-next. Greg, can you take
this through that tree?
---
 rust/kernel/miscdevice.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index cbd5249b5b45..50885fb511bf 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -217,7 +217,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
-    match T::ioctl(device, cmd as u32, arg as usize) {
+    match T::ioctl(device, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
         Err(err) => err.to_errno() as c_long,
     }
@@ -234,7 +234,7 @@ impl<T: MiscDevice> VtableHelper<T> {
     // SAFETY: Ioctl calls can borrow the private data of the file.
     let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
-    match T::compat_ioctl(device, cmd as u32, arg as usize) {
+    match T::compat_ioctl(device, cmd, arg as usize) {
         Ok(ret) => ret as c_long,
         Err(err) => err.to_errno() as c_long,
     }

---
base-commit: 619325ca7abbef5d7d7869f331b8672b6fb4513f
change-id: 20241015-miscdevice-cint-cast-3a9a023ac375

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


