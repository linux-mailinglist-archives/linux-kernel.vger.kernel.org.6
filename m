Return-Path: <linux-kernel+bounces-571198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D864A6BA52
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3684A05C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F622577C;
	Fri, 21 Mar 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHahGHRf"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D26C22576C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742559024; cv=none; b=LcrDpKsAdhNWPpPJGe6rn9/qUTbDFCekR7XwTip/jUNGs0dLbULf3qvFLMpAcZxwOUQUlkdzTYQN+muzxHuspE9MJzVx43gHnPNNGraasvjtNGmdF1b3KOg4z9uczuTsz4zHicuG1OGRuxvMQ2ZShGvJFL+MSQGzvwb6TZlIbiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742559024; c=relaxed/simple;
	bh=m77GtzyuRQyH9r1AhRKLOBDFfhXXm3iZOjUs15wpL+s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bN+dx6mLlQukHTYdM9d7A2xGcUunXv3BrR0aeDpuTiigJd8/5qXOgwhWFXgeHZqy2WTFjP7WJd16CbrY8y+ot+wOORoxsjeoDXD7g1wJXgM4OJGx0JX/RbEXKkmRJH/QQDU2rj1TwOZBNluFyN6F4wmN33wkRo4ij7M6QV0maDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHahGHRf; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912d5f6689so1093956f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742559021; x=1743163821; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=niclr8+DoLpZdWNc9oriyXHlvdFbMf2iV3dQAVqT6ps=;
        b=BHahGHRfxTkFvIMbVFp+5heh3oZCiWPpyaPwsBrpjtRwxMYBA8dmpWUcmvUcOlTPlQ
         CDf3Pgi1VSJISaGAMJgTAloUukPg86EmDkRz5odgLkx2e6apZDmf5Vefc2nTk977wngA
         TQ3d/UpMyVlEuFihRUl7AaMKIoOxglwRWEUxmnzIA9WZbX8XuIrXNainTuNbLjw7c834
         W8A7x1Q9ijbdxrf7PlCdvBQZ6frsJYbFRPGY++Dq7jLAwjooB0Jj2ZNqwOKPn3o0GSXU
         yr7bTyAuVufDg/H/ojIHUk60ND3VSzwnumavUZa9/AF4vQI7+BJ4kVhR6KI9CaJ+/X0X
         topA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742559021; x=1743163821;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niclr8+DoLpZdWNc9oriyXHlvdFbMf2iV3dQAVqT6ps=;
        b=Ky/8AZrFiRKSqGKT4PcTGXiWv2IvwdPCmWwwRdd6+uw8mTMgpLSBOUBfpt2TxtjJs3
         78KP1JY0rRNrekAfVNz0HVO1wFpcILj36QJvUVqBfW0GXf9SodEqPSjtMQxTnim3q5a0
         4IqfIxBNSk/U95fxWditr+T+ar3r7J86jXSpXB5R1u9zGX5mh+I4hmUmBP5tvkOnDsT+
         liZu3bROZYDasSqwmTjEkKNH1vnvTKfogVrbeKPlY/1T28MQ6NcQ3SRarnLN6ONzvOrw
         x/Wk3Am7ZwT5i7kiwNFu8uJ921PPvSaZFv9tVGejZ4febx9lUI4IE3BZonqgjt//czdg
         UzFA==
X-Forwarded-Encrypted: i=1; AJvYcCU/w7SVcDZIvmfBo4V5AeZV/d+OoDTR0YBY7xW8XzoLIxxByEOYykF2fhbQ+klYYtGKXxeaoaUROGxm27w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1D3G0h4e2t1ggo9KOg4yN/4mVTHOGpvURzHC/CvTi3egCp1vE
	DO+WMjMjw1icLYZKrTp3akV7MQprIKVUCJj7vhvzfPhM3tirRtDLPLJTscwXGMUSvZXnBJBNWel
	78v1T8pc22i+QxQ==
X-Google-Smtp-Source: AGHT+IFUnWcxjonRBINox1/nLtB0v8eeiJ7whsk3pcv1B6qRkzdqH7Y3jkCu3QtacO4RnclOGnfKAtSfRW+GlvY=
X-Received: from wmpz15.prod.google.com ([2002:a05:600c:a0f:b0:43d:55cd:66bb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6d88:0:b0:391:29f:4f70 with SMTP id ffacd0b85a97d-3997f8f9259mr2879692f8f.3.1742559020693;
 Fri, 21 Mar 2025 05:10:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:09:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABNX3WcC/23MywrCMBCF4Vcps3YkSQ2KK9+jdBGSyQVsR5ISl
 JJ3N3bt8j9wvh0K5UQF7sMOmWoqidce6jSAjWYNhMn1BiWUFqMSWMniQltkV9A4by6StB6lhP5 4ZfLpfWjT3DumsnH+HHiVv/W/UyUKvDrvtfVKe7o9AnN40tnyAnNr7QtXy9ORpwAAAA==
X-Change-Id: 20250320-vec-methods-adfa41e55311
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1329; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=m77GtzyuRQyH9r1AhRKLOBDFfhXXm3iZOjUs15wpL+s=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBn3Vcaleg9wtsMTP1gG/5SVuhcKOhy/X/BW2oiO
 JtO7u5HrTiJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZ91XGgAKCRAEWL7uWMY5
 RhFfEACzabiIIfDN4MB/FllsQTwoeC3CKWvpewtW0rc2FuQh7P2E7A0XNRwXagFTqP98EPBGpIP
 IvoWAxlEymm3mPBair50ajtBnBw8rQhlupJfOnBc2xXCqhuqhDkiZmfw6PZuscPeZ1p9bw1pfZs
 eKG/k852uG7wd1S6sj6nGE/ROqgTWb6ESS5SA+ek6pCMzXkirElGBevDS/gSX7w9Gn31ajUAV1j
 +ipxJwbokxICnKdkJsm4K59YcET3OkUPj7cdxacoP8N4rnyQK7Y0KKXlGU8bmbZhsFNbwYWd+Y+
 R7ZIBRKmmG0tvFbEf5s6nE5812dtToXiyR5KxULKKLK3QYC2sqSoUti9MjYVEO2jysSlH1XxtWe
 vb6hVL5QoGrmsFuFjZNl53jRjE9gq9cUdpFuVcM+ZPFh4CY4a7mkkeBVtR1tD8ebJUNiXSpWKtL
 95Nryo40h4Ql4Tq9h/RgwfTapKgEnxKoxITBPiQUZ9BR7H3iWt7o5a7hBERjvwCcMIckGENsUY6
 QSLbb+2ndl0UQ9pscB4298tpOUOdTI9K+jhZbRUsFdHPGxjj1+9mvFrGz7YUy6aA/WzYO4e+alo
 0Hbarc9pCq99E8UV703CJUKwr2d10mCuf75i+7RW5wBpY99L6RL9pt3TEVRh8JmswfEexsLUd9N G8S5SJxM3KEcIrQ==
X-Mailer: b4 0.14.2
Message-ID: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Subject: [PATCH v2 0/7] Additional methods for Vec
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Benno Lossin <benno.lossin@proton.me>, Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="utf-8"

This adds various Vec methods. Some of them are needed by Rust Binder,
and others are needed in other places. Each commit explains where it is
needed.

I'm not sure what we concluded on the set_len / dec_len changes, so I
don't depend on that series for now.

This series is based on top of Vec::truncate from
https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjballance@gmail.com/

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Add two more methods that I needed.
- Introduce some uses of set_len.
- Add example to retain.
- Simplify pop.
- Adjust 11 to 10 in push_within_capacity example.
- Link to v1: https://lore.kernel.org/r/20250320-vec-methods-v1-0-7dff5cf25fe8@google.com

---
Alice Ryhl (7):
      rust: alloc: add Vec::clear
      rust: alloc: add Vec::pop
      rust: alloc: add Vec::push_within_capacity
      rust: alloc: add Vec::drain_all
      rust: alloc: add Vec::retain
      rust: alloc: add Vec::remove
      rust: alloc: add Vec::insert_within_capacity

 rust/kernel/alloc/kvec.rs | 202 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 202 insertions(+)
---
base-commit: a337a03281efc4553191b432d757d4c04884bf4c
change-id: 20250320-vec-methods-adfa41e55311

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


