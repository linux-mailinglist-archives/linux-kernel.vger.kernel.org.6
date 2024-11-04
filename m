Return-Path: <linux-kernel+bounces-395566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7BD9BBFE9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B361E1F22395
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3CF1FE0EE;
	Mon,  4 Nov 2024 21:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkqAUFkW"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC291FDFBA;
	Mon,  4 Nov 2024 21:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755243; cv=none; b=piWonicWJvDhYZ82L/etcgja/2MWaK9lAQkL6R9SqTUiJ8JthQaZhtkYsfY11mWSRXaPd2FnVRCqR0bVzTlqnY6RieLF0kq1maUBNJo861Oeby7z+arx3aDsC2M5QbGvdmvR7c94lcYTcsaYbUjskvWx/ywL1ZgPsIkzDBVgYD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755243; c=relaxed/simple;
	bh=DP9anbMhjZ9XA8YZROoJwdFzrkdKSmSxASx2gY57IUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzyKPOzL0Vbq1OWIo9NwKNj8SfeHzkQdGZ9qeonovkDUJsnYSRLqVOg1VHLg7dTtzGEC6idU3ofM0nj6uOBvtndo3939SXQJPs8GIDyiU7FUOrMnO4FKdQXTovq6Y2VtC+TgyWCb3pHuFRcfVy0AYzrHlzbSutGg3r1/mZfIXhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkqAUFkW; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea051d04caso34657457b3.0;
        Mon, 04 Nov 2024 13:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755241; x=1731360041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IREF9jMIoVsYmfw326uvfOb6uWdfXcXPz0ts5IFgljg=;
        b=GkqAUFkWSxHRpwo/67r0dRGDDfLz+jS8btc99Z8/7HY1siMuFaHO2vIXWtXeYH9Cb5
         a3WAQ9hgYxIqj5Kxd5AWq+FtB3wzrwQ4TjWL35SSWw1fvVtvc4+8e6wcdC7SmzpXpdSe
         jEhclATIZH/EVgSQ+PMeRkalP9MymdGwdl5W2Labrw+8K9mexPKOPi3IPxL5tAOFKmAr
         8q2kCdON+ri59BL2eKqjkkJkxeOlMd0Td4b4i1PlfG411HFvX+2hNqDBT6WZDnzR/S0/
         Dhho6zQV/2S7j6yHVMlBtbbr1KSiAHtRA4QpfHchk0hO3OB8tcH2AK1s9ZT/kIdfVWxR
         53pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755241; x=1731360041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IREF9jMIoVsYmfw326uvfOb6uWdfXcXPz0ts5IFgljg=;
        b=BdMcZxiHSDFFu0N6HAXy9itPo/ZjUX6rS57aaLKuDuJ1KZOZmIgULOxC3A1VpzGA6Z
         BXj0eZEV9FZZbblOP5K3HgBP1HMwhDZqbr9lFsgWhgbpIpE2IOfy7buWZdQgOmHf3gaE
         CPT44yRvg5BYqe8rsj4gERi1iDUnm4wGxh4LFiG12zURxeZVPHFVcTHSq6sxEHJ0/0tj
         Qx4Hhuk4Pf4OMiO6Sn5CcALYKxkTtwf+phOCe6oKmW9Zn1PvcjECGmO422QmXLsjXrRY
         xGSvAgtFDvtRIj4vaksgnextPOTetjFcdFFUJo33zbGNjVhYmYUpY9X3qm0ZUQBvGUM1
         2O8w==
X-Forwarded-Encrypted: i=1; AJvYcCXSdN2wF54iYyyQhnSqQjzNSxioiTSv1a/O41yoNkXOKYrbNGIk8KGllK86RHGf60qlg9W7Vp5lrv2zf5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ3ac+vgWAWT/qkBM/IE9xV9MrtkgVdEXviF12xqlfv5PDP+DJ
	KMQVff9kpW4eKODFe0JOt125u6deYLKbBwA71zwfbRdK+yiTtBkH
X-Google-Smtp-Source: AGHT+IH4lulu3t030chORFcZy8Urvlxhm0SWkTzugE34rArx4yYHNbUvKu+F00TQuW5m7MljRbsUNA==
X-Received: by 2002:a05:690c:9c0e:b0:6e3:2ec1:457a with SMTP id 00721157ae682-6ea64bb23e7mr135448547b3.29.1730755241204;
        Mon, 04 Nov 2024 13:20:41 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:40 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 04 Nov 2024 17:20:29 -0400
Subject: [PATCH v2 3/6] rust: arc: split unsafe block, add missing comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-borrow-mut-v2-3-de650678648d@gmail.com>
References: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
In-Reply-To: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

The new SAFETY comment style is taken from existing comments in `deref`
and `drop.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/sync/arc.rs | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index af383bcd003e1122ebe1b62a49fe40279458e379..9adea755a5ad1a7b03f7fc30a7abc76c1f966c6c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -377,10 +377,14 @@ fn as_ref(&self) -> &T {
 
 impl<T: ?Sized> Clone for Arc<T> {
     fn clone(&self) -> Self {
+        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
+        // safe to dereference it.
+        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
+
         // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
         // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
         // safe to increment the refcount.
-        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
+        unsafe { bindings::refcount_inc(refcount) };
 
         // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
         unsafe { Self::from_inner(self.ptr) }

-- 
2.47.0


