Return-Path: <linux-kernel+bounces-430326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405F9E2FBA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99DA1B2A033
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF666208990;
	Tue,  3 Dec 2024 22:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6QfXn0h"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD71D8E1E;
	Tue,  3 Dec 2024 22:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733265843; cv=none; b=q9I5211XCV7f/YDyHBke+nwH29u++eyfJLLeB/JbDP32wTuK0pTD6HmjTUGb6C9bj8FNEzwI85c9Lcu5du09jrjSfIWP8uAvXrx5z9IOy6s7CEZv44SNy3kDZ0mEtdu+IJTgyj6ac2NhoaRoyHNBdB5n3PN4wtWopw98YAQMjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733265843; c=relaxed/simple;
	bh=NxqFKC3aR1WSuX21cxhK1J36LrgpLKyK+3Z3Nk79CzQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hlGEEGepe1OrowJPE0aCaEPVY/xEeUdWZ0IcKNoMUXczc9QNJaG+60TPeY+0rlpeH37Dq7wgPMV9H9ohoZ20FPfbkiWVHeZ+2Oa07AvdapKUfqKWBVtyvkK1w5vlBIPqx34nhPeZJh+X8naWyuQJki85NSqoc2dZnqBOcArI3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6QfXn0h; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b666215645so266841385a.0;
        Tue, 03 Dec 2024 14:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733265841; x=1733870641; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vYSFlQM16Rx/QKczowrfky9Gm2rZJT0hevYPDz04FeM=;
        b=O6QfXn0hapOXv5rlT78Wu29lh+xl3Vj9gayLVSSYWFPEgLO9uBv+fX4J5F2el+jEQE
         30qUkGbGgiHtBZLCsrXieM+nlldgyEFeCpkbiky0Y7LL2FF5dfw83+mrCVDaRhu6ADCF
         9is5QZu6N9j+L1fu2+zf3ht7YdvKBNrhzZLyMndOrJLDL3xxOEM2cmXt5vhe/xmqmSHe
         i4PBLWP2LDodjutn06ia3mXZeZ9t3iISOgTJLjP4NtfDKIjTyEXT7Mq8xEiwTraOUB/S
         EFU1vSTyat/air0ElJUsSorqwwQ1iEByi+0cUvEJy/yoVUS1IyrM8lt6YEs7I3a/KQGe
         FSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733265841; x=1733870641;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYSFlQM16Rx/QKczowrfky9Gm2rZJT0hevYPDz04FeM=;
        b=dUoJZHKxEKnq6xeEwX/lw4yFERYEqGKeeoRF38hbfKx4HleO19c0NAwT/Y1CV/SsLR
         /Gd9TNXDBijzlfm+pgq2c9cmnbmGky2FLmmCbwg/zsbC8w4E9ZR/ZZwuYgu5OkvECOJb
         TNmkPw2xqOmKabWb4LSfeoWce0hmXcKN3CSvb5PKKCds2WQnVAC3YJaLfupyLe7vqOBW
         3ynCSvrgiz4qOGPcz8ubE/2HEbwjQ7dZCQAJ3gloYFq29PhWeDGHC3SUs016EQwv+pQM
         aW/MvqItI8GzSpziU8wGbbt/3EyqhliHbEFkVP4vVzqyjzzl1FogrP4/DH7dJ/1ApZwN
         nf5A==
X-Forwarded-Encrypted: i=1; AJvYcCVh+9yNmAEiaKw4Yc/5TVqQ6/XWIwOm1LOWgNFzZhXOnUNfew9C+SH466SaXkR9Iqa70gklgM89EeCb5k37Tik=@vger.kernel.org, AJvYcCWWoNjAD35TFPEyYMVroteqFHAGQBYh4vtKqUhtegIvUIvfeuY5N+ETbrLG/k834RVZMyu01rmmgG/90sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXDK1eSANArdLxY8552Cc5z6QIOXIklyNVKM8jkiBwpB79VRu
	V+ZIXglc7gNbmsneCfjqWb/byw4AhsR63ePU1lcUCKET0IpgwFZO
X-Gm-Gg: ASbGnctjNbKOOqbrWjbdtNf/JIRvnUvDVJNNmXmZRyHdLIjS6c7e5b6QrBoX4HJweqb
	ceLv5XUftO9n9b7a++4+BLjI+YOZpX49fMzGfWttqtL/0yeHaFbyke1NIGVEd/UzFNT+5SGLNSg
	XwKW7qO0tScMI7souEdYbuKMB4DKwYwVbwl5hhxkX2xfTwgOh2iebSxKudLcpAiQDcgDtbvXJCj
	c2I++ZobXihIwGCoE8FwNmiI9Z5NUvUmz1JD1idUWBUnJPLDu92xlfqy0qmFJRZvBt6vPONrrjJ
	6i4t8buIhysyibFk9/fm74q3fRDULG15efkZ5VDdrHXNQB2mJRzTsw==
X-Google-Smtp-Source: AGHT+IEAoqcO40G2bFH/xu4u/0GhgP9DSv+q4tIc/uijGEpy0O6tFb9S0vKZ6TuLYznQyXKvnoG00A==
X-Received: by 2002:a05:620a:44c3:b0:7b1:549b:b992 with SMTP id af79cd13be357-7b6a5da81b4mr380287285a.23.1733265840642;
        Tue, 03 Dec 2024 14:44:00 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:352d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849495d2sm555516185a.68.2024.12.03.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 14:44:00 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v11 0/2] rust: xarray: Add a minimal abstraction for XArray
Date: Tue, 03 Dec 2024 17:43:49 -0500
Message-Id: <20241203-rust-xarray-bindings-v11-0-58a95d137ec2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAKWJT2cC/3XQQW7DIBAF0KtYrDsRg8GAV7lH1cVgg4MU2y04b
 qIody9xqjaLdjkI3nz+lWWfos+sra4s+TXmOE9lQHypWHegafAQ+3LABBcSueCQTnmBM6VEF3B
 x6uM0ZHA+KJQohW0MK0/fkw/xvLmvb2UOaR5hOSRPPxivuRW1skLvsDEWFQgYO5rouI8DHSPtu
 nn8tpL/OJVoywP8DdZWj1g1BzenNH/CeFpAq4AGg/dBdu3a3A1H2UPxxri0lVbINVdEEoMumzs
 je+dqbRsVpBWBW/KCa83uyQ8xL3O6bAWtdlu/7UQ0f1exWuBQC7Rd71TdGLUfRorH7Td3cEX+p
 PxXaLlVGBLKCcddUEY8M7fb7QumOLrbugEAAA==
X-Change-ID: 20241020-rust-xarray-bindings-bef514142968
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This is a reimagining relative to earlier versions[0] by Asahi Lina and
Maíra Canal.

It is needed to support rust-binder, though this version only provides
enough machinery to support rnull.

Link: https://lore.kernel.org/rust-for-linux/20240309235927.168915-2-mcanal@igalia.com/ [0]
---
Changes in v11:
- Consolidate imports. (Alice Ryhl)
- Use literal `0` rather than `MIN`. (Alice Ryhl)
- Use bulleted list in SAFETY comment. (Alice Ryhl)
- Document (un)locking behavior of `Guard::store`. (Alice Rhyl)
- Document Normal API behavior WRT `XA_ZERO_ENTRY`. (Alice Rhyl)
- Rewrite `unsafe impl Sync` SAFETY comment. (Andreas Hindborg)
- Link to v10: https://lore.kernel.org/r/20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com

Changes in v10:
- Guard::get takes &self instead of &mut self. (Andreas Hindborg)
- Guard is !Send. (Boqun Feng)
- Add Inspired-by tags. (Maíra Canal and Asahi Lina)
- Rebase on linux-next, use NotThreadSafe. (Alice Ryhl)
- Link to v9: https://lore.kernel.org/r/20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com

---
Tamir Duberstein (2):
      rust: types: add `ForeignOwnable::PointedTo`
      rust: xarray: Add an abstraction for XArray

 rust/bindings/bindings_helper.h |   6 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/xarray.c           |  28 +++++
 rust/kernel/alloc.rs            |   5 +
 rust/kernel/alloc/kbox.rs       |  38 +++---
 rust/kernel/lib.rs              |   1 +
 rust/kernel/miscdevice.rs       |   6 +-
 rust/kernel/sync/arc.rs         |  21 ++--
 rust/kernel/types.rs            |  46 ++++---
 rust/kernel/xarray.rs           | 270 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 377 insertions(+), 45 deletions(-)
---
base-commit: 7510705aa41f7891c84dbb37965f492f09ae2077
change-id: 20241020-rust-xarray-bindings-bef514142968
prerequisite-change-id: 20241030-borrow-mut-75f181feef4c:v6
prerequisite-patch-id: f801fb31bb4f202b3327f5fdb50d3018e25347d1
prerequisite-patch-id: b57aa4f44b238d4cb80f00276a188d9ba0c743cc
prerequisite-patch-id: 2387ec5af1cc03614d3dff5a95cefcd243befd65
prerequisite-patch-id: 75e26dd500888d9a27f8eac3d8304eab8d75c366
prerequisite-patch-id: 7f845443f373f975a888f01c3761fe8aa04b8a3c
prerequisite-patch-id: 5a9856c7363b33f0adfe8658e076b35abf960d23

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


