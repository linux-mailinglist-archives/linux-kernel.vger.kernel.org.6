Return-Path: <linux-kernel+bounces-366005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29799EF93
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A472B20B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4721B21BA;
	Tue, 15 Oct 2024 14:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKVI9wtt"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCD1AF0AA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002528; cv=none; b=JYXZIujUYT6NRYl4THw5nn8jtVDZAfoua5TsZ+itNSh7+YpsY92GpbHdoZUFMFsFu2EAVP3+2Pv6csxwwM/lYbBI0ftqAFuAL8qsd9q+IJYho1M3dzteWZ9DyvVstQo0gSobEW026ig8N0J1a0tayQqRj4usbKd7PI0sZsU//4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002528; c=relaxed/simple;
	bh=t8U1gyWwNSEhj9d9K6BaPBQ0ctfmm7LA5efgRVulxro=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bgkv1lQE8wQclMeIdYbTmB0UmRgBAqM90lhMP3ZZjpwHITRfbUW/ffm1NL/EiLDsBR9XgamalhD+vQQuVe1LDIdwdrYYCx9Coje1ReVpNC1LQS9nUdU29va1rSIV+8rS46uT33AmwKdYm2i+/FjiyhhzZ84Wumza5Cb9fzeY044=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKVI9wtt; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3705b2883so38502327b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729002526; x=1729607326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XNJeKzAtPjp45SIJ3/kfvuUMRNzvKyffpnVSTmM2Fh0=;
        b=NKVI9wttr8zX3D/62rJd77UBVNheJgdQXXvVvp4ikoA041oG7ioO8iSuWjWQY6VFRq
         1aHCB//0VF9EK6ouCZjeF2FgQbJ8far4qD7kJoKTW4Ln0NHz0Yx8wtQlLX894Ty5ldA2
         NVsZfe4x1U/L/l3XadSKKzlTBNdelb944aeNTbumj0OoXKIFIs9qBvvcCYQ+q8teuPve
         mLNtxRjfdPP2S3uiyL9Yt/sP21Z3ygWTdXkc8rEMKj8jWD9JVr2KwBiwKUES5HiXw27c
         ORLOfsZhKicxIwO7jJWiBri6kpB0mVUZH7Mlsb9ccAveEPb1hbcsVLsc6nN0fJBTUJf5
         9AqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729002526; x=1729607326;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XNJeKzAtPjp45SIJ3/kfvuUMRNzvKyffpnVSTmM2Fh0=;
        b=DTSheM7sqQEogjzl81tb7ha+uxBxbsQeHdwCn6qoVhAQRAoSNkcM7HkI/2U0qc9lwO
         nd0UFdfSlw9MM9IdinZmuZOVCrHktRsQWM7CnO4/MFnETHajpwN0rFGeYg0usutSluXN
         hpugayeRJ0kVxj4pGDOk5W3jexZ9zkE6SbB8Wp67QZYgud2JXiDTUx1swsDlNJ/90360
         OXUMIZ2mM6Kv21uajFvejRqO+F5Ui6aDaPZSnKyy2gj8RzXlePDsn+gF4oniCCJGPqoR
         A2rjIAJvhJCCGlmSzKxIdtJBMKuhBXcoJVbWJ1srX27srJKp6un1IjsW41rnJIaFSUTf
         7E3w==
X-Forwarded-Encrypted: i=1; AJvYcCV9nANsSUr6qz2EQSXDVDi4v351Ji3KFEkSxSHqIH76tX4kpSGPiNvlKrR4NHFJvNnylvKSCpNAtsagPO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/F0j884dcSo/vrpqy4hUagF9UQd6fDa+YrWaWhntXZeU9HjSW
	mO4Va4gWKs3TohX4ClFNcTky4+eOhvR7ImUz741Ao3FfkmxBvO+x5UHx1gSpoTvEfjTmbIP5QCI
	nrakJ5VG5IK/vDw==
X-Google-Smtp-Source: AGHT+IEJsZCQdJgQDK83UiVeL8PodNSP1mZnK7L/+YXxdoFRVd72bLcQ3Ll9Bb0b3OGyiUHdTm+vltTMRxpnJ8A=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2d08:b0:e28:f6b3:3666 with SMTP
 id 3f1490d57ef6-e2978567367mr346276.7.1729002526293; Tue, 15 Oct 2024
 07:28:46 -0700 (PDT)
Date: Tue, 15 Oct 2024 14:28:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAt8DmcC/x2MQQqAIBAAvxJ7TlBRhL4SHcxWWwgThQjEv7d0n
 IGZDg0rYYNl6lDxoUZ3ZlDzBOH0OaGggxm01EZJZUXx7PxFKQuHNnoTnFU7AgelYqT3n63bGB8 omyDhXAAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=t8U1gyWwNSEhj9d9K6BaPBQ0ctfmm7LA5efgRVulxro=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBnDnwMVnOv25ulL3mEcQA0kNsek3R1xTz5taYha
 5Y1rpWY31+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZw58DAAKCRAEWL7uWMY5
 RlXgD/4939MppK4B/TGTf4FZZfeJydTXzv8UMnCIqv8aPgKYfnApFk+PbRKDUXzGxTGrpdw5fKG
 zxA2rh3tCYAMTXueMSZdEFoE8lagpvilyS5Z/cvPQZB3xmh3yTvIjCTlbPG6LPZzHptiGW1RqJC
 vo54L4y3uiCl4HYLNKGUB3lkzHJHAytQeILBRRWgPtQpZFgQyiNa/cGE3EHPbTqTAOqZXDwo+aF
 GRql97MJ/xS5HOV4V1miU/Hv0jFDdRphecPH4nDwQ0Ja/d6roUDfpp9MSJwr9MjGfaACh8Nzu8e
 Rnr4rPSCpdZwokcA7ZbI/NjI/9JMuYg3kqVvt9pTt/g8a1X3HX++F1i9XYfUgkpxcuH6zseKWNc
 sXl+RmfNUDWsyr48LDF/MKbhlYDtBunbJkcXsUBobeCy66UvP1Ae+zqe+9a6xUypdz8f+bz8ujh
 FaxQB6i+VwUpCE8BtJ+Q41aI9N3+1PCjA98PmY1EG3MkX2IK+SCpgFFBIWIICa25NIg49cKfDRE
 TfqYM/LRME+ON8Hxebo1R5stTn/eT4226Qi09e2sEr7N0ov+ZidylEj+XlfmvlLNsbUizpo+D2T
 qC+TkH6et19oK1qsE2ynkRNeiBojAAiHeSNgr8I0Yw7PyautHKZP0hxLafIwKcIyjP5QeB+k3KK mzG1gXcw+kOfGug==
X-Mailer: b4 0.13.0
Message-ID: <20241015-page-align-v1-1-68fbd8b6d10c@google.com>
Subject: [PATCH] rust: page: add Rust version of PAGE_ALIGN
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

This is a useful for helper for working with indices into buffers that
consist of several pages. I forgot to include it when I added PAGE_SIZE
and PAGE_MASK for the same purpose in commit fc6e66f4696b ("rust: add
abstraction for `struct page`").

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/page.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 208a006d587c..90846e3fe829 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -20,6 +20,11 @@
 /// A bitmask that gives the page containing a given address.
 pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
 
+/// Round up the given number to a multiple of `PAGE_SIZE`.
+pub fn page_align(addr: usize) -> usize {
+    (addr + (PAGE_SIZE - 1)) & PAGE_MASK
+}
+
 /// A pointer to a page that owns the page allocation.
 ///
 /// # Invariants

---
base-commit: 8d8f785ceb21b9a0de11e05b811cc52d6fa79318
change-id: 20241015-page-align-7e5fa4c751be

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


