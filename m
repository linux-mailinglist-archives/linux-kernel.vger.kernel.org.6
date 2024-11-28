Return-Path: <linux-kernel+bounces-424281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAEB9DB28F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7098CB23415
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BCD1494A7;
	Thu, 28 Nov 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5NIeU3G"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8B146599;
	Thu, 28 Nov 2024 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772438; cv=none; b=o9Nqi+IyinTV8LA6I1qrDUL5A8b9dvAMhtyx+i6IixdPNdQdhJ1aemPk4F2T0ETxLaXz9ErAP1W2oGlUNXu4RD8s6OwmjU4s/6cm4+DKT5lF6fP1NqAWJ/ewS3qC1e0HBWrng1YpbE4SBvSCmv3Cs0WpgcLWEiSm0zUnliZU12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772438; c=relaxed/simple;
	bh=JLuFJCiPXJaBx3ccyANB7IEhy956uEc8w5YOj6ESKzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtNYG6lndu3FGuxD9K4aSsMdjpvngEdfdr2eHIlbA3RoFAj2O5cQEmmKu+OoMzYb4TxWf7ECvM7AA4MW9kdAou4ULjgxpDKxu9xmYr+MuDeVHErZ0LWosQbp0W+iW2rNwDU22FyWrGN+L9oJHn/uEvB2TXhsP8IgxuqvSeYLAZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5NIeU3G; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d41eeca2d6so3780726d6.1;
        Wed, 27 Nov 2024 21:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772435; x=1733377235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a/J+XDTMBujL2eWQ+xCrnrriCPdeqXCUJRKcpurXPz0=;
        b=X5NIeU3GwZjKTkCkDgHBn66cEQxXIzdXzNjz7e4QalGLcBr4uKzqlNsBL9+J1+05eA
         jdCK1CfQx6qLFBDsTwuQ1JSaRlYO7gxZisIHsHWm8v2JJuLjpIcM3PbBI2ri68/9JQqD
         2m6v3YQYYAD0BXzsBf4E+XumaiJQoINUK5fEu6/SQd1vqNfhig2arn6zGWaJaDqlhMRJ
         wGbWWjwo4DNH++GyAxyTUsKWEV0KLH02TDTS3l41JvE3H+dHZh7mUhGC/XeqEvBYEG4v
         98qY+rAWevpNCZdpN1JAt798LWoDSHt/4CxAThJcBGWHgmbp5pVeFR9sm5ZuNf2sWjXr
         UKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772435; x=1733377235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/J+XDTMBujL2eWQ+xCrnrriCPdeqXCUJRKcpurXPz0=;
        b=QaYM8X9snaVoHK9niSvYmuGHWhx/JRR812iItylxTCzn6Ate0jNxvv6Xo1cD5JWqF/
         ZgxQNMgvFBlpjGHRDW/PcSirgnbwRE5992CNI4U8rEQM71Zw2TL96BKarsQiEZMjHEcO
         md338GLIPTvzNAkM/oP91YDpAcV6qCP9HH7/wvF5520nlqEKRu7joTmOYVpEqv2Tl5Z5
         1ai8oqWIKxDxfSEpRs1bio/BSVPejez2pLDcRufdEIRob+18OCdopVIEJDf2vZyEzENS
         W91Sir3jGsvfyjP9UkfYJhwNN1ef7Z7hgeECJorWcdhx+XwaT4DfTICSs4ZYjm8k6Qg8
         qy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSn1LmCKyEBOexH8rMkuwnkKUUa1MDP6Aw9nwgKon+I2Sd+JWLEhlaaWbqWUF7AUBA9Y7N0YmlGIkqy8ME17A=@vger.kernel.org, AJvYcCVHhWu0Ullu2B9MIu6NDY3xwZLfAyff1T/ZpBmxrMLI2zosrh2iuH8PzV2obEKVkNliw1/7gJC2vSYxkuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYCU98rsuKriTK9yw3XvXi+FbN8nBISN/7obaDla0fY5BwR76z
	+acosZFgn/VS4sBwbuBYaFTgRZAUvco3EUqre/HZC7dDsiIdqR8O
X-Gm-Gg: ASbGncvoubHp5tdoM24C7eLmpBuB6FcNilK9Jt/JNPv75Q9lEEksdoyv2euPrtK6+0i
	Kb3b6MW2XIzIcTeLh+pVAxU+hYMzCnnAXUf2FjEpTgrO8TRXRKkWqrkj/1iXdI12pf+A6cJMeYa
	wz9tVA+zeqOGkr2h351KyjJLDDIO2Y9M833FGx5vbUbTbLp6A7zceMlxjYddEfpeFf0a5pncjr1
	xKvGvwE5nTqjIorI9+iQLLHc4KZSEPY02aQDT0h5bsvdH2mIyVOweL0Y8X986HM3sy4KfKJ1LyI
	djFAUSGFeKGrJ3qfOxQqrrwPKcb+2fbwrhIrpEZv
X-Google-Smtp-Source: AGHT+IFhppQntXL1KL7iNkJVtdFW4nUluPJdwKCQ2x0UF4SuXdv+IDNf5NO3sULwF2FDVxLI0pm9PQ==
X-Received: by 2002:a05:6214:1d2f:b0:6d4:1f86:b1e2 with SMTP id 6a1803df08f44-6d864d06e7fmr80452446d6.10.1732772435531;
        Wed, 27 Nov 2024 21:40:35 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8751f5635sm3122566d6.94.2024.11.27.21.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:40:35 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id B403F1200077;
	Thu, 28 Nov 2024 00:40:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 00:40:34 -0500
X-ME-Sender: <xms:UgJIZ5hRZhAnlnGuN0N5srmBUQayIdfrAV4tAOl18Gi5PlWuhOA6Wg>
    <xme:UgJIZ-Bp9Thj1PesmrYANiSuyTevDt4DSMWDCpz2Dhvgad78mopDyRAYl--66iw3k
    BwRkxZGV55NVRQ_ug>
X-ME-Received: <xmr:UgJIZ5GsfY8lkaFvPaSd-P5GYGG50MLF4iDQQcHXiz7SBpT3I0QK8ILzVt5E>
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
X-ME-Proxy: <xmx:UgJIZ-QrHBr4gMzIDwt4KjSi1HxmFH06898MxT6a4w0no9RMueMLRw>
    <xmx:UgJIZ2xM4ddRRqTegD6VnzhAC1WeRthIiZmdSIdDTXtkQLe8ujjAPg>
    <xmx:UgJIZ04uDfIx2OTpqfVI-nfSoGnfv4fJYU5c5UQACvmF22c1Sy_26A>
    <xmx:UgJIZ7xcvK2g3JAFJyhKU53vGLWNqqPd8oY3aqFWzXfYyo0KYMCt3w>
    <xmx:UgJIZ-gwhcJxrKdxzJQMGx0uqsnyYg6fTUbTSqyhSm1FsqPy4xBrsMwj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:40:34 -0500 (EST)
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
Subject: [RFC 4/5] rust: sync: Add MutexGuard type alias
Date: Wed, 27 Nov 2024 21:40:21 -0800
Message-Id: <20241128054022.19586-5-boqun.feng@gmail.com>
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

A simple helper alias for code that needs to deal with Guard types returned
from Mutexes.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20241120222742.2490495-2-lyude@redhat.com
---
 rust/kernel/sync.rs            | 2 +-
 rust/kernel/sync/lock/mutex.rs | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 1eab7ebf25fd..2721b5c8deda 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -16,7 +16,7 @@
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
 pub use lock::global::{global_lock, GlobalGuard, GlobalLock, GlobalLockBackend, GlobalLockedBy};
-pub use lock::mutex::{new_mutex, Mutex};
+pub use lock::mutex::{new_mutex, Mutex, MutexGuard};
 pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
 
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 0e946ebefce1..10a70c07268d 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -86,6 +86,14 @@ macro_rules! new_mutex {
 /// [`struct mutex`]: srctree/include/linux/mutex.h
 pub type Mutex<T> = super::Lock<T, MutexBackend>;
 
+/// A [`Guard`] acquired from locking a [`Mutex`].
+///
+/// This is simply a type alias for a [`Guard`] returned from locking a [`Mutex`]. It will unlock
+/// the [`Mutex`] upon being dropped.
+///
+/// [`Guard`]: super::Guard
+pub type MutexGuard<'a, T> = super::Guard<'a, T, MutexBackend>;
+
 /// A kernel `struct mutex` lock backend.
 pub struct MutexBackend;
 
-- 
2.39.5 (Apple Git-154)


