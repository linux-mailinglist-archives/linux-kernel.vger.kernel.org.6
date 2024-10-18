Return-Path: <linux-kernel+bounces-370981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1327D9A3498
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B4791C234CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 05:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D154618755F;
	Fri, 18 Oct 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqYKD/IV"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8A185B48;
	Fri, 18 Oct 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729230725; cv=none; b=eMtvNIVsdRmTRzrMsLIsF+CCxw79XP9GUEwVJFUiM05exdFUwFc1Vr8fIyrqkoLW+9DzKHbbY32cGIB4vPExgOwIb6MJ6Fy3mYq6NIWIGCEBOGZZwZpHnxOB6W1L3ujbw/+BqWLWeTsyk2oXxmFjePMyRxHnv1waDLgVHg01gtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729230725; c=relaxed/simple;
	bh=gsxvtbERea0O2/f0HBuFyQYqpO0yQOBbsIBU3bywGwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nI5P5dqyzsUS+//3/FRZms+cISEbd5kgVWhKF3HJ/NKCooZKzZpMVWPyanP22xzWdRUM2NVfh5ga5Cb+BA6dr8sUwtBNhfJva2RK9A6IZ7Hf3KNcX61FCGiASdFZjp8cN8ZEih3AkKwiA/lH8X0ac4UfTVFZZGfhSB9Grm6cTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqYKD/IV; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cc1b20ce54so13993856d6.0;
        Thu, 17 Oct 2024 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729230722; x=1729835522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UT9ol2eK6h7KmhUg/gBQ8DG/6hwW/ccjJZAMJOOdskQ=;
        b=MqYKD/IVgH9vWDyqQwy/HXt4I3Ve1pPN1Dc0PdRUHqOcak34J0JYGOEJWOAnNUeAps
         iK4flSyuaVh+Xb7y+H8GD6hC9zN7iu+2hLXUb9qWNaDTSMk4b+RBml4ktXHQB1hvXwQi
         Lpm3+Em2h9eyeVgukAdpVE21pPYT64wUP+/xPIDCixyMGYhaSp+/Yj6O5TiXX6nFS51O
         4J+p4RjxXDBctZvtK4BR355MIrWrxLuAuD8JFWEZn1hLwRcHYvnE92MaGKmP9rdO8f7i
         tTi4iSHH7i3ISxGTRTFYC4SqsZXZJjXrnAQ8LJTDHBaAFza3EA9xFepMgWGXKdXTfdQh
         dBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729230722; x=1729835522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UT9ol2eK6h7KmhUg/gBQ8DG/6hwW/ccjJZAMJOOdskQ=;
        b=C3Cg8JipFqAWB+2fBJHUMQq7v3ruhirp5URuuk1aeMp54KyzAmJf9uRMFNRgml2n3w
         EKTGJ3RaZGcpmzaqkWO7zGeMcp3p1R1ZSC+kQEpultC+yiGt8mSNJJ1GQcPUuyVAu4HM
         /h7rw+oMP8EKGKptCydtvbUKQTiCelFrqeVEvgARC1vFVd1RBZT11SdiJweLm4uWH0xS
         Z30emxLqb1L90TOJ266tbX8z1SiF3QtAYmqTUFTCO23NTh1+cPi5KFVp0AMDgr+E42L5
         brDuLpS1aO3bxU1pO47dypDS/AgSvln03kW7CPAMu7ZilZZZkTMIJhI/cfH6wv/n3L+W
         EcYA==
X-Forwarded-Encrypted: i=1; AJvYcCUDKTgYffcWxArPSZRwJFzYTVyEkMcLOZJ0iTL2Fa4ckVgNZnTzD3X2ZXOFxup1l3yedHkDX0I2GlnIaGA=@vger.kernel.org, AJvYcCW2+l3pEdXUQTA1nmyFX0ks5c9eaKbInIhttRIXrfYYJlXi1TGXuzR3nH24u+R89WPCDez6TeU7KeWQNzPA9wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUi45w3blVtEreuu4GbZYO29BH47OIy63vFy6T1h4kzdKbx4eg
	txAgzLsO61flrN2IiQsHTMZdFpPzO7BLaT1xGzAJs/vZufOfUvBagtrxyg==
X-Google-Smtp-Source: AGHT+IFEm/N07MN60Ld4bt4U9ttOtYMClhZ0XeRACytbdencWeQlsD/bTX6iRkYxMYVMBHediE+4mg==
X-Received: by 2002:a05:6214:3187:b0:6c3:5b9e:699d with SMTP id 6a1803df08f44-6cde14bd49emr17870076d6.2.1729230722417;
        Thu, 17 Oct 2024 22:52:02 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde136cb69sm3775376d6.106.2024.10.17.22.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 22:52:01 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 583C71200071;
	Fri, 18 Oct 2024 01:52:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 18 Oct 2024 01:52:01 -0400
X-ME-Sender: <xms:gfcRZzqX22yrxGqefPnNsMcBmlcoPy2Fg_HecP1FP2ffomyKil8piA>
    <xme:gfcRZ9qby6BoDc3CiBD4M3rwZq-Bln_JVsOYi1InAUq3LH8IgIQ7QCTQQPv5MaHEn
    d-VZUVa2ni7tB-p9g>
X-ME-Received: <xmr:gfcRZwOQDxWeZfm15qeI1l7leVGMhgIRJ6rhEYiBj6hSFPxeJQS8iLWaugg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddt
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeeljeeitdehvdehgefgjeevfeejjeekgfev
    ffeiueejhfeuiefggeeuheeggefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvuddpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidrug
    gvpdhrtghpthhtohepughirhhkrdgsvghhmhgvsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheplhihuhguvgesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqd
    hlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopegrihhrlhhivggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhl
    lheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrd
    gtohhm
X-ME-Proxy: <xmx:gfcRZ25vqpQC-DwO8A7DfBZXfDUJ-1yj35LXxOqKYJwQdTizpeExaQ>
    <xmx:gfcRZy4KWsafwRWgGMN_2-eOW1W38fUSWNEo3B7v_5f_ZJytMyMB3A>
    <xmx:gfcRZ-hFyiCDnH6CcsYtrTHA4aIFPDTdKeZ41-m5Gwi45UAr25Z_7g>
    <xmx:gfcRZ07Fa8VmSk6QqTVwFNFRSQWLKNnM9w592_dzLR7uXVCpNxpRwA>
    <xmx:gfcRZxLjv3LGdSAgBDSM9CrM-9OzjMY2DhtyCYrX78ycr-DX1hLUvTVI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 01:52:00 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: Dirk Behme <dirk.behme@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>,
	will@kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [POC 3/6] rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
Date: Thu, 17 Oct 2024 22:51:22 -0700
Message-ID: <20241018055125.2784186-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241018055125.2784186-1-boqun.feng@gmail.com>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spin_lock_irq_disable() and spin_unlock_irq_enable() are inline
functions, to use them in Rust, helpers are introduced. This is for
interrupt disabling lock abstraction in Rust.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 rust/helpers/spinlock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index acc1376b833c..8ae0e8f9372c 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -22,3 +22,13 @@ void rust_helper_spin_unlock(spinlock_t *lock)
 {
 	spin_unlock(lock);
 }
+
+void rust_helper_spin_lock_irq_disable(spinlock_t *lock)
+{
+	spin_lock_irq_disable(lock);
+}
+
+void rust_helper_spin_unlock_irq_enable(spinlock_t *lock)
+{
+	spin_unlock_irq_enable(lock);
+}
-- 
2.45.2


