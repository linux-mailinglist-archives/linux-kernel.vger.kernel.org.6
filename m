Return-Path: <linux-kernel+bounces-410962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1909CF0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A79286C0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52331D5CC2;
	Fri, 15 Nov 2024 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlSLfKkQ"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56771D5AD7;
	Fri, 15 Nov 2024 16:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686452; cv=none; b=YzqIXbH8t48vmUTjOsOCUVKzD1BRRLOtSSSvvWg3WoSd2gMKZ2JkO/QOwoGzTKOzcHe5tFa1lV/5Fh0cYtDzn6VsxzQgcAw+smQgjTy0/j/nwF2oE4cf06nnFUfrjXHh8AnWqoAHCSbwl8ewDVZMRoK8X4VPwXRfEIrIqK7S6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686452; c=relaxed/simple;
	bh=au+tvrxXqoBsEhJU2APIFF/tFMFVgwSa45pgxpj9M3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E8jn7ep/+oE52jNjiQZBTK/QgfgLqZU4p2E7puQ2HotM7BhguRn7KqCXnkgCezCmIM0TubvEXYbxY0zL5IsqEgG2fP4jUrl4hsE5jo4AZin2am8wDc2pcJyKNmj1dd7pS0lXzNckMpxfOnz5wcH+Jkj8MDHzvpSD3SmpYmOZ3Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlSLfKkQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b15d330ce1so56311985a.1;
        Fri, 15 Nov 2024 08:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731686450; x=1732291250; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EtwQSRAbsq1SLaVqwTttGeGQP0tI2+PT2UDh7N/ZC7g=;
        b=VlSLfKkQEVCafgX9KyK1iROQ+33diGfpe6HdlpsQxbrtN2M7QvxvxZ6960QvEyPGuF
         2hHyPrqxdrIqciRoFaT2sVu2//NZ+JwmcoCrIcwr9Oz4e4SHQgWDv3ELsHV1qQOyXM6t
         IAHUqS2TGjREc+LpLFJTdbRfr/OZ/D4PhBr791QXK4USD5LOG5YME6Yv21Wrlgr0tYe/
         YThvyaVQNwFvbArwjGM/T59Rou8vJ7HtsIe9jJ2G+FJLqgDJeZhFHfGRPYK0SYhGhQGN
         dTq/7zX7pdGyxJShNj0xPhEY/rxz/ZpDa1dtcbqLOkL+ryTYxFmYzpWAGwjM2j8/Z4ni
         oEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731686450; x=1732291250;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtwQSRAbsq1SLaVqwTttGeGQP0tI2+PT2UDh7N/ZC7g=;
        b=INxzbdcBmRm6EbM7n6CH0zuePgZGRVDb+xDGyDnlziIhWNgY5nXIQZxzDITqRQn+k0
         u3iB7I7LcO5Lsag7HEI/da275wqfe1gnudMfGF8EUioiRvqmILQsg8HGee0/wPJA7VwZ
         SCqNlOwkrPM1TIKGzLNEYfMb3QmnIDvi/ij6nQEjzL4cVuw2F+AwwZ1nu+biNqBXRi1V
         v1GYP3M3svMXvUE4mZUXtBhNQ9kdKJ97OOjVBIB4VYs9VRYu3K2R9DrOWesWDRW29dIJ
         n6fX2J1uRzrRy3mEJ8Lj5qlj1pEJPJmmmhNIVwFeHoCR+mBzBjLUCD5U3WjTP+L91XWT
         GEfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnkxFcegQb12+zftnGwj0na6MJtkfiQyhC+kDq6uQcdgdqp8ZmdTrpfAfz661Ug4qlrrWaqsg7knfaHgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Re3uNZxqMBA+v0HjlJO8ZhnDlaiLBr78UTz/NyAA7tLTEFxg
	F2kojr1FQt740EpQnexse4eT/adOdDc+mstVvScI2WjkfI8IvRDh
X-Google-Smtp-Source: AGHT+IE3EUl5KvT2B7DjCHuxFFUiH7+GdhAIpt9EZtqYJC/ohI3cFMaRz8xY9pQgvs/ESlAPr2P5vw==
X-Received: by 2002:a05:620a:1725:b0:7ac:c348:6a55 with SMTP id af79cd13be357-7b362364ff1mr386272285a.38.1731686448123;
        Fri, 15 Nov 2024 08:00:48 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:edce:cf6f:2815:775e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c984576sm171108785a.25.2024.11.15.08.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:00:47 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v5 0/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date: Fri, 15 Nov 2024 11:00:43 -0500
Message-Id: <20241115-borrow-mut-v5-0-86204b249667@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtwN2cC/23OTY7CMAwF4KugrMnITp0fWHEPxKK0DkSiBKVQQ
 Kh3H8NmWjQbW8/S9+SX6rkk7tV68VKFh9SnfJZglwvVHOvzgXVqJSsDhhAq0PtcSr7r7nbV3kY
 MGJkjNUrApXBMj0/Zdif5mPprLs9P94Dv6781A2rQIULDdfRBxubQ1en00+ROvWsG80cRaEaN0
 JadBeeDo9B+02pKw4xWQvceiVZkZfE3pQnF+cMkFGy18g5cMGindBzHXzGIm4ZVAQAA
X-Change-ID: 20241030-borrow-mut-75f181feef4c
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>, 
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>
X-Mailer: b4 0.15-dev

This is a re-submission of Alice's patch[0]. The leading commits are
intended to improve the consistency and ergonomics of `ForeignOwnable`,
and to split out the code movement originally included in the patch.

`ForeignOwnable::borrow_mut` is a dependency of the memory backing
feature of `rnull`, the Rust null block driver.

Link: https://lore.kernel.org/all/20230710074642.683831-1-aliceryhl@google.com/T/#u [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Changes in v5:
- Rebase on d072acda4862 ("rust: use custom FFI integer types") [0]
- Link: https://lore.kernel.org/all/20240913213041.395655-4-gary@garyguo.net/ [0]
- Link to v4: https://lore.kernel.org/r/20241110-borrow-mut-v4-0-053976068215@gmail.com

Changes in v4:
- Remove (another) superfluous `cast_const()`. (Alice Ryhl)
- Link to v3: https://lore.kernel.org/r/20241108-borrow-mut-v3-0-b7144945714e@gmail.com

Changes in v3:
- Remove superfluous `cast_const()`. (Alice Ryhl)
- Correct SoB placement. (Alice Ryhl)
- Mention `as` cast removal. (Miguel Ojeda)
- Link to v2: https://lore.kernel.org/r/20241104-borrow-mut-v2-0-de650678648d@gmail.com

Changes in v2:
- Call out ordering inconsistency in commit message.
- Restore pointer type ascriptionin Arc. (Andreas Hindborg)
- Remove most reduction of unsafe blocks. (Andreas Hindborg)
- Lift splitting of unsafe block into separate patch.
- Link to v1: https://lore.kernel.org/r/20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com

---
Alice Ryhl (1):
      rust: add improved version of `ForeignOwnable::borrow_mut`

Tamir Duberstein (5):
      rust: arc: use `NonNull::new_unchecked`
      rust: types: avoid `as` casts
      rust: arc: split unsafe block, add missing comment
      rust: change `ForeignOwnable` pointer to mut
      rust: reorder `ForeignOwnable` items

 rust/kernel/alloc/kbox.rs | 41 ++++++++++++++++-----
 rust/kernel/sync/arc.rs   | 42 ++++++++++++++-------
 rust/kernel/types.rs      | 93 +++++++++++++++++++++++++++++++++++------------
 3 files changed, 129 insertions(+), 47 deletions(-)
---
base-commit: b2603f8ac8217bc59f5c7f248ac248423b9b99cb
change-id: 20241030-borrow-mut-75f181feef4c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


