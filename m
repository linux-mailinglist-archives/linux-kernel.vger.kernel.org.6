Return-Path: <linux-kernel+bounces-424280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E22C9DB28E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7F2828270B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B917146D78;
	Thu, 28 Nov 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgboAPwB"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A6E143C7E;
	Thu, 28 Nov 2024 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772436; cv=none; b=cVIUrUsY9Yim4SwNp3EWnQ/3p4w5dAaJ9CN1Q/0YcX/lFZqlNpP8BYpD+4mJ63ZvoGVH/YotcYbNW+CYcZWKchoA4wqxpbkANJGQQi/aFPTDI9LXZ7c7tn6wo9dvhTKl84esyuKRdQA6srSDar31y5ZfWxH9lf/wnhj08qaFvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772436; c=relaxed/simple;
	bh=cuwL9VqarSJVGIwq+5/T9t9lJH8i9EKhmCPorLI0/mA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CeuiIcQQZijDkZ2usowHOES2oIzRm9DGD19dWyRFjdZujsZaVgaRl/l9Xrzl19TyMIK1FwpvwdrbD71pN/Z7N0Ru8KNX9qcBJBWvuXY4y+OD5cPFDFyvOPxjIR0qf+DBZn632bKDiJhTSlF8Mo38kS0MgWOcQMl7mbJ1VJaNSS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgboAPwB; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46695dd02e8so4452191cf.2;
        Wed, 27 Nov 2024 21:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772434; x=1733377234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s9sC83tozDH958mCO8AjXOvSeVyc3KvU5CweJZKTNc4=;
        b=CgboAPwBZna0vS7g3TyaM4JNNMtRZlePlmBboILtAt4nExgtiE+UJ19se8nAUx2ltM
         9fWs1pUqdIpZ/YFuCbkHnGh4dupqeeG6a3iIdNu4QjyyVMG+NZTR0+ejXOBKYbALLOic
         OP7RwTZlM7IEcMwcFfsGporp7F0d2M1pchmeMaNw3z14sCxMuKfKJindYmcRiFxk2YLe
         JG5o0JZMqano+hds2zwG3E/ktMdGqcS3G6j0+gmQBt7BGH/LAGtWjaD7sQxYjLXyniu3
         Gc7h85UbYaD8fMx0zgr0rw9RXlAW1XhYrYPJ/E9cZprjCJoOjnB7VYfKaz+g/biPpgfn
         UadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772434; x=1733377234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9sC83tozDH958mCO8AjXOvSeVyc3KvU5CweJZKTNc4=;
        b=nPgz3K7ctQNZHoGVXJHxdfMw/5+x/mhUiwwE7160ON378vvIUWt37D3Op4snvft2pj
         v6dKg9ynwVfzWF+87dWQWvHNHpxsKoppaePC/5EcnTN67eqeeGNKnul386D5tDcR+N4Z
         VqyL+bI8pfATpo0/nrPufMNanED/9ZjS3EdvYiqAFb4Sd6VetlUUPoA1xHyV+3EmZVSb
         8800gjS2gfz8uLyKIe2MDsu7lzyXj8jvGWGf5BWFYvLrMXv9o821NU/axNx4Dkb4wr9X
         pzI3AHOwy350pifW8AHB/6da2E/ZVN9lJEOQ6odzf28uvvotgFkiID+iZuwDxjrI1x56
         9i+A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ9Jlb+YxuY6osai0OXp0AST7MWf6VhyzlF/tbA5jMtM+qcUdz0jc+GKxDdWlvwd7SDB+dmY2xDUZvX3g=@vger.kernel.org, AJvYcCWVx6jBTjWmQhswlVY45ozD9TE5MtDhI/tiSDtGeVWget8/qS8//85Y+o+7BWzRdYGF1d7JSrKpy5TFiGExy0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf0wts0FZo9kiD7NZxWHG4S62JUNXoClj8b9+vhSStTrGy6NjL
	RFLEKOxd8nqJDovCkVDk6p8YEp5TCX3wxlIkYP0kwrt1G3Cxysg6
X-Gm-Gg: ASbGnctL5tK8UKXK6m7weJc0hCPjQJJ4P2uZZ+tWDZ4kLL5Xaur4is9LsnRupe2QxbG
	05FXvhkWyo+jTbMZfQVfl7mex94LPfbcdUiB3SHvYDqsTWj5GlzPsRqq+3x0zsP57eewoDdJyWC
	qti6avpCBEjS6Mh09OJlVoICsSIc82nWPddCuDSBXN1L9Gyfih9FlRQOyeJl94BZvnJpbYxdVo8
	sVpeHYRPX3zFz+RWhs2V7/DBiC7cXCZm6UqkKxZaLLaTgPJ0s7B4dOLjO/RDjzOPV+hS19trfVZ
	iOVqAehU/OVwTjtEKNpimXkVZlrztOozlxqoz1tn
X-Google-Smtp-Source: AGHT+IHgwZdR2+teOyM3YD+g4y+ADT+FCk0IgmuWoLP7jjC9Eq7T3FpxTEktQgwhBiSqurPBoEXGag==
X-Received: by 2002:a05:622a:1bac:b0:466:b122:513e with SMTP id d75a77b69052e-466b359c947mr96108761cf.12.1732772434206;
        Wed, 27 Nov 2024 21:40:34 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c421f832sm3107581cf.56.2024.11.27.21.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:40:33 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D3511200079;
	Thu, 28 Nov 2024 00:40:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 28 Nov 2024 00:40:33 -0500
X-ME-Sender: <xms:UQJIZ30RA3C60Cp6fRWsuO1Mu_rat1efZXcXaT4ZJ6kQPvj196_x0g>
    <xme:UQJIZ2HcNkCmMDj-LnPjieVZH2qzWMY2BONwz_d_ryQDHzsPV_u4ke1-1fQE91f0b
    2JVi02xMqE3GZ9CZA>
X-ME-Received: <xmr:UQJIZ35TJ-AXmvmMcIwbI3A3vKVrH906J8r3UOUdwDMZ8y5EBYmcfvHiDhzj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheel
    hfeivdegffejgfetuefgheeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgr
    nhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphht
    thhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhope
    gsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:UQJIZ80szUYRdczo3krf9V85ip3HVVntx0RBj-heYQuV16Uk9ekQjg>
    <xmx:UQJIZ6EF3Mo0sD-8p85zSx9wp4LGh_-oqnYtJKdgR7cIJxZwdjIKxA>
    <xmx:UQJIZ9-nD1wt6EsozG2naO4iw7Xyi-geM9sTAEBZpq3KP1d76JvCHw>
    <xmx:UQJIZ3llrtlczHh40QrGS4bX5eSMxTc3pwwVlwAaFXPL59z6GyHkDw>
    <xmx:UQJIZ2G3qOBVzby2ftwptk_SYQmEJuMqVPBV7Mk0kg31SZqJWDlREQaD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:40:32 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	Filipe Xavier <felipe_life@live.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 3/5] rust: sync: Make Guard::new() public
Date: Wed, 27 Nov 2024 21:40:20 -0800
Message-Id: <20241128054022.19586-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241128054022.19586-1-boqun.feng@gmail.com>
References: <20241128054022.19586-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

Since we added a `Lock::from_raw()` function previously, it makes sense
to also introduce an interface for creating a `Guard` from a reference
to a `Lock` for instances where we've derived the `Lock` from a raw
pointer and know that the lock is already acquired, there are such
usages in KMS API.

[Boqun: Add backquotes to type names, reformat the commit log, reword a
 bit on the usage of KMS API]

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Filipe Xavier <felipe_life@live.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241119231146.2298971-3-lyude@redhat.com
---
 rust/kernel/sync/lock.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 57dc2e90e504..72dbf3fbb259 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -234,7 +234,7 @@ impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
     /// # Safety
     ///
     /// The caller must ensure that it owns the lock.
-    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
+    pub unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
         Self {
             lock,
             state,
-- 
2.39.5 (Apple Git-154)


