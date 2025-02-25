Return-Path: <linux-kernel+bounces-530928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4FEA43A46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD44F3AE23F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B4266B40;
	Tue, 25 Feb 2025 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxUfeHQY"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D393266573
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476844; cv=none; b=A2L6MFqbH1AgPVVXWkSoSwK5FewNSghOSzIo8TLABo3VJ3dPdHjzEf5v3MkqE8vkmDw4WLWvvjxjr5HjGOKCivCd4e5kA5XMgpBsWh1h/I8M8MwK4iEsmKDLgr4nWUyxqcFZbsNyBumYI3LvMTqGd89UXp4c6cT8ce+fRKmmR7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476844; c=relaxed/simple;
	bh=wP27JPweH/6fjM+NMVybUHMlDRdaIL6FUjjR0i8msYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lP/MO/s4rsKOGE02ts7HjNBjIfaLVgmXcoOZgQB1WW5M3cxR8V1i/emsrqdqNty3WsiXSuaqhm9c/XKCEKOi9MZaLRUS2kFzgagC5Nx7vOPCzzgYrOLMhapxZPMnzWna3hw30ONY/P/+YmEviz+KtsCfZlmCK/2nXObBmDl71cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YxUfeHQY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso10874026a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740476842; x=1741081642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+f+044xs9oe+QU9W9buNo+/acydIG20YX/T/a/LsZc=;
        b=YxUfeHQYZS9+9UqfDZE2+WbJIw5q8IME+o6qeHuufATz0PgJfa1wJpUDROVhaQ/dYX
         eh5vDiDhTjRrFI1SgHspgXJqgwnHV/bKVOhwswxqr934rvGACUGB01TXtSJMQjhw/Cxi
         PCCNrG69yfACsZXF6EQ8lrk0E5cuB7K1Tx/zm2DQjTlXA09I/xiOT1gkKMG8eoukSbCD
         BW9LTJpVO7ZqSF5QSvwyPxwHkJCpJVEVVBkuDa7rSfvPgKwoHAdowy9EBOpPtJh8RHA/
         ffiM3D/zfqBWYnwIoztbktQC+mAyjCt1XgpNSwZExK7vu7z1j044WKZA6CNNP+rIrn0o
         agZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476842; x=1741081642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+f+044xs9oe+QU9W9buNo+/acydIG20YX/T/a/LsZc=;
        b=Ttkuvq20eOmiZNRw1xdSwlBJntRgG/8q09cdO/mdk8EfFPK6nAtTW6IKJMlOD+eq38
         l0Y80ScgnrUcL66pDHsgJ94wG51ADR4NoSfpLfy/5j1Q8pBuP58DpaydY12rtuoNhQaL
         bNSDpiapDyMs+bkhkx+FSlRbGwA/BmkBjzZilokOhBg0v725EeVEnzT7jgAOFeAomwzb
         LYKVUTzabhEthb5feVPMdSXE7DStNe7vH1P3L0U1xhvOG//E95z73Hp06Zt6Fjqg5rvP
         HhfYEgUn83Uuixjx1Kq8SYCypa7vuuFiP9a5Rr9E7J9Px7SELmK2aRbKrHUMJdwAKUQh
         AAig==
X-Gm-Message-State: AOJu0YyMEOScX9PxJTUG0H18HrMfs7AREGssx1kaEVIv1cNsgMSZTERn
	Au2ekiQz6TFNJI/Mp60cYLFxKqV4mcLm4j2angP2HuI1yCsJOyBCAXCfUB21S2Y=
X-Gm-Gg: ASbGncvGlm8EUe7POfZ6REEVrlnuNo+VKSAYA9QxqbVt27dDsd1Zp1sv5H/gN5ivUeH
	9rdMxA1yrQXMUDqGPcMx/Ph4KQyAItlavi1RY6pLTRD+JEtGz6O/99fK/QdwyT/1e+7YIs99WRk
	EhWOTTS7KkqEu91m1G3ojuMBu5imAiQWTgfkyN/HTO6RHO/mkKb8TkJsr0p0RJlypXv8qVwXdc1
	shyJct3uwV51J5J2X8LwrlT6485xAKWaR5gdgf7PbZnclA4kyXX64qd+dUnYKV8HT/kKAdbBvEG
	SoOVjdbQOKof1ek5k5Req/TfzPc=
X-Google-Smtp-Source: AGHT+IEpV3O0DpZJB5fu1atlN0Tq9K+PHFsKxd1ALff89Dfbc3fdDd/hO40dZKnKimmZmJUjhEkl7Q==
X-Received: by 2002:a17:90b:2644:b0:2ee:dcf6:1c8f with SMTP id 98e67ed59e1d1-2fce78c78a0mr31431819a91.16.1740476841935;
        Tue, 25 Feb 2025 01:47:21 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb05f913sm8077113a91.25.2025.02.25.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:47:21 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>,
	rust-for-linux@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 0/2] Rust: Add cpumask abstractions
Date: Tue, 25 Feb 2025 15:17:13 +0530
Message-Id: <cover.1740475625.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series adds initial cpumask Rust abstractions and adds a new maintenance
entry for the same.

This was earlier sent as part of a larger series [1] and it was suggested to
send these separately.

Depends on: [2].

--
Viresh


[1] https://lore.kernel.org/all/cover.1738832118.git.viresh.kumar@linaro.org/
[2] https://lore.kernel.org/all/20250224233938.3158-1-yury.norov@gmail.com/

Viresh Kumar (2):
  rust: Add initial cpumask abstractions
  MAINTAINERS: Add entry for Rust bitmap API

 MAINTAINERS            |   6 ++
 rust/kernel/cpumask.rs | 168 +++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs     |   1 +
 3 files changed, 175 insertions(+)
 create mode 100644 rust/kernel/cpumask.rs

-- 
2.31.1.272.g89b43f80a514


