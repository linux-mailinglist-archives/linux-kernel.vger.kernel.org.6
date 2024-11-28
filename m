Return-Path: <linux-kernel+bounces-424278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A89DB28C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51806166E5D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 05:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626CA142624;
	Thu, 28 Nov 2024 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FByEP0nu"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65713B780;
	Thu, 28 Nov 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732772433; cv=none; b=j+tG7QG6Ac71vlal6VbiDlCDUFWYsLzpfR1rNVfHmrO4gXtKW93pJnwxs3ZdxUIVr7bgnQweUftRY3eJ+jkZXx1py5KLvC43l3VcPnTiKdxqOtU+QOhUpJaQF/zFYonKDM6nuTdYp29ascbkkN1FKO+RcD6lb1Vq6YuVrgs7hQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732772433; c=relaxed/simple;
	bh=ixRiRLFUR6ATH+j6wrA/Rib8wv30TgwPXmEuEgllpXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D7eoxWWc6PsEUiqypsEHr7CsWdnrKUY7FQS3zOvODTUNAQkluhjgUiyFwRi8CoISnbwaNgBfoCk6PJkd0KN+KNIQ0Z1iRUNDKIgdEq01qIskYnmTYsQQ+Yd/63mqxk7W2q1aIZETZ/OVNfQQ/OMKyFZqfA0uwWvNPLZEG7FNwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FByEP0nu; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b15467f383so34672585a.3;
        Wed, 27 Nov 2024 21:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732772431; x=1733377231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UuDqpNXPe14+YM41wgrKY6nvGGrPtfugmk04sFpdLAU=;
        b=FByEP0num8YBxhdfV/jKyl9zoRI+b7MMNbyMETEOyl+dEIAon4D3AhWNDdnYRuN3Nt
         dtZ6Jr1LbhT9c2FI9SxIR/h4pMa1lcOWYzhACcPWD5zp5S+hVuG/VZDq+V0FImfT1MiI
         WN+YKeNZXVolSqVdC0bnqNSsdmoiFsMmIp+oia9we7NoTkw/oaF7fXKJVN9p0xkVVj6W
         Nf7vOQ49QiT9bR6KFB5602SmuXjYQwsoyydISwc8RniaQ1ENXmv7Ofo+w+x9uSCa/Oe6
         YGaZBU5ZfMfqpBNFgpTxPtnqun18cRClTAlAdorf2AJcqifJPvSIGB53/cDVXKwl1+c4
         7IXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732772431; x=1733377231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UuDqpNXPe14+YM41wgrKY6nvGGrPtfugmk04sFpdLAU=;
        b=sMNLoaY8vzM3qnBfc4AdvM+NGJn/3CsZ9uv/sX3FfZ8BG98BC5S7WCPAUJyYoV5lxh
         PFqV5P4BRdo1/Ww6xmcVzBoIM/9uhz04o10ajAbx57i+uyw8qtZPql9my22iruwqtVza
         Fi34xryrtic/TK4QGdADn32HoBzDPW7B5OfbanNTpnvzo/Fw1ltKcThLRZMdkydeYCyI
         p7+Cln+HO7JEyZg/tE18gG78S+QOqxa134o+uVyAvN4fKlh8LYNMc1L4/K01iC4GXAps
         YeTu0JTQ3zlX6GIEV64GgEgwP2i98ugbxkMpI13cd1g+99yt0ipfy09V3BCGwgHOa+mb
         Bs1A==
X-Forwarded-Encrypted: i=1; AJvYcCUntUbf3N/pI+DsNnf8ejvDE4GLDKgJNT1J3RUsl6U87yl+DqwryzzRXqi/YHBFC23NQj8BJjhZg9nAna8=@vger.kernel.org, AJvYcCVllmFVIar26I8sPyTPpi1xlq7yo/dPtoP93jv8rH/dNEEppgEm2fM1mwFRjNQwrexvWV6q2A8IOMlqhOZwBbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMdPMw4spAgy72W6ztHP4wi7yVwdIixYEitMvesOpwQEsJu/Ry
	PPSRLppMaO7obfcndXtUM5HE+DlC204tdwdHkMvRVSeghn4VG42d
X-Gm-Gg: ASbGncuW36KcPKopIQSSh9J1/Zvwsk3+VQA618jX9+AIZP6IAeivA7b+TqM3wAW36vx
	2JaeQV6g/otpnziXofua9Ix0betI8XrZeAfjlng+SAumQhUYCfUywg54/Jd0i0HO3+HJCcSFuSB
	ESvxAqh22KokVC/s/xp/mJdoQxopJbtRVLsKGeerguExinv2A3Z4lVLC6RDWvoycKQE+5TajxGD
	tku+l0k/ydhhX5Df3GX21dyeP/MFTSd1lvyfG9VdhHllUMJ/+y4eJ+pYHfnnkmzBsXkRbLGvy3H
	sGQq9cgWkEiLOIwSZchTwTap5L2RRipC4R1vSNYg
X-Google-Smtp-Source: AGHT+IFMeO0gyRy/2FTu1UOOggSxZ0ngWzcNP/odyYzUJLnyityrEomUr8M59JcExIYe9ne+knR6Qg==
X-Received: by 2002:a05:620a:2715:b0:7b6:6765:4ca6 with SMTP id af79cd13be357-7b67c47113amr642131785a.34.1732772431022;
        Wed, 27 Nov 2024 21:40:31 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849ab218sm29149985a.95.2024.11.27.21.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 21:40:30 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 358701200077;
	Thu, 28 Nov 2024 00:40:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 28 Nov 2024 00:40:30 -0500
X-ME-Sender: <xms:TgJIZ_-147xw5gGJpA7Ke0446xZ5cO3wZ-8plPLpHtG81p7tY_ikRA>
    <xme:TgJIZ7uzgTNhj0sc0WBmFr7BbM-znZ6ysAbASCtQ5lLuHzByC9M6gUZxKmVkCUTu1
    IEJKYDa0nSA21KhtA>
X-ME-Received: <xmr:TgJIZ9Dgd0dW4xFebLaOMtM2Sw0YRDfpCrAxnG8voUwgkwPSYVdxHJMEbbVD>
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
X-ME-Proxy: <xmx:TgJIZ7cEqQYhT5GzYOqAd9uZdQ_YRC7D0AR6oJBIA9RTHcch4Gg7qQ>
    <xmx:TgJIZ0MwK_cV5s3x-LNPwMEqUmi-CC58rABzf3XlgHSENHNHC6SNGg>
    <xmx:TgJIZ9laaiNbCM9CuFF7rMaW9txeEBJkVLhx2CO7LEcxDuC9wlF40Q>
    <xmx:TgJIZ-s1kQJDFtDUzA5FzeFLId9c2RY2AL8kNwYgagK4_aiSRa6JUA>
    <xmx:TgJIZ-vjmRXF_0NXwRifc_MnoqXsLLw3Wb8QD0pel5qF_5Xb8t9a1_aQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 00:40:29 -0500 (EST)
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
Subject: [RFC 1/5] locking: MAINTAINERS: Start watching Rust locking primitives
Date: Wed, 27 Nov 2024 21:40:18 -0800
Message-Id: <20241128054022.19586-2-boqun.feng@gmail.com>
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

It makes sense to add Rust locking primitives under the watch of general
locking primitives maintainers. This will encourage more reviews and
find potential issues earlier. Hence add related Rust files into the
LOCKING PRIMITIVES entry in MAINTAINERS.

While we are at it, change the role of myself into the maintainer of
LOCKDEP and RUST to reflect my responsibility for the corresponding
code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 443217066eb9..3a6a193fad99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13351,8 +13351,8 @@ LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Will Deacon <will@kernel.org>
+M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
 R:	Waiman Long <longman@redhat.com>
-R:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
@@ -13366,6 +13366,11 @@ F:	include/linux/seqlock.h
 F:	include/linux/spinlock*.h
 F:	kernel/locking/
 F:	lib/locking*.[ch]
+F:	rust/helpers/mutex.c
+F:	rust/helpers/spinlock.c
+F:	rust/kernel/sync/lock.rs
+F:	rust/kernel/sync/lock/
+F:	rust/kernel/sync/locked_by.rs
 X:	kernel/locking/locktorture.c
 
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP/Vista Dynamic Disks)
-- 
2.39.5 (Apple Git-154)


