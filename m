Return-Path: <linux-kernel+bounces-563166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B13A637B6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBC5188D427
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F61E1E09;
	Sun, 16 Mar 2025 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCiwhVQ4"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2F6189905;
	Sun, 16 Mar 2025 22:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742164326; cv=none; b=gnQWFdZayMhOVmtC3v0ANeDK8rXCVpjgoHdikTFYQxIgHUgQzbGI0mmRIUxTd2jjjx5GZYSGFQM6G8r4buWhddjWkFFWkuCEPt4in2NhhFS2P9iyu1NBMg9PXbV0iqewjligwFDMe44aoJMhM8UPbx8MUdgpw8DHwYVYdLiewFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742164326; c=relaxed/simple;
	bh=Tb0yhOpUYmEnU5OM8rbuAaIvCXRTDxNcFbF2iGDdIXE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pqv/xUlox04mChes7aCGrzE4dcB8LIOzjagAGTfRDToVdn+VuFKDjAqJ2w1lL5ziVJsXkwGWDKtwEZH3GS29FFLljZo1s8OB/2jPZADHjydduzAwo6neGYuaEJeuoyJGnkFoBDMDN33F9/CteDz9PxPex4U7HaRaeXDZDhkyL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCiwhVQ4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso24231956d6.2;
        Sun, 16 Mar 2025 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742164323; x=1742769123; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hFDZLy1XjKxI7qBCF7s8eJhiHvjbOuBPad1LYM+cZ18=;
        b=RCiwhVQ452W5H4475nwZpsN5BjzeRoG5/uCA/B5zuMUrgTkLtMJGuflQR+iMbuEGXW
         irkbU6isrXH5O453CjHATM5yPYt6kIH+vZCABPRYmHApww/1irfC5AYYjVYly4fQdEpl
         DUa8mhsRplTBWz5wLpauHNCyJ0ZI/GYxXvUKlYtQCmCcJgtXr/PL/uoEbN+mUBwYgdLg
         cLILcG/A1r3poth/EN7ixuRt01KI/Rqwh1Y/K5B3IEdEhLQnpcm56XxFDQuUooWrFFz6
         GzTqQQ/Z6eNdO9l1hs051gCiiy7qtVqTtfu5vfjc5KJtudZH7mobUskhORG7EHCmOTQQ
         6vFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742164323; x=1742769123;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFDZLy1XjKxI7qBCF7s8eJhiHvjbOuBPad1LYM+cZ18=;
        b=AWoBIG9dTEAFjuJqZFPzOpERJmXlLAMT/5qnEzD2raA9v0ILdR17DNvfe9GAr+Nbw6
         FTSOPi1w8W/ENo9jgminJEHAvzk6BNEVYKy5+fNnGY8Nm/s2RQ6YqdTX06cD7lxbZAES
         joHtBiL5mT4cmTKbA1S4yCEFJm66o4aeVZLjXt2duZcD4sQLVhwfOCUs/doznyvu8ZD0
         0stYZpdj6D2pjwqrcG+kb1WHHGKYu8CnDHPGOuPpUS+3Bn2frAGxgHifhaRS3QdFRXx6
         j0o7S8pgxQuoXSQPkrrZQptmEilENsTyI5dN1O+MxYgUW6Z6auRGTPDPlHUz2QzszA+e
         znJg==
X-Forwarded-Encrypted: i=1; AJvYcCUjdJO6raQ5zhuKJpGJ1EE3zrdz99uvaNaUtkj5f88bIwKvCKTJtsS+xhaanzfL/sBYf+6fTnLC5cpJ9q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvvlIeV7kzi3sSmV7WM/C34r7Prd8sgU6t7tzhzNKznmjPSFb
	LM1jw2PSfGbyQOY2DrIEmWsj6ZH9F4iwItA21+rTOPYekpLMt/vdpf50LA0cJxo=
X-Gm-Gg: ASbGnct/0hBSgmqFnKcBgtX7RgEoHnQRpdFkBgwWw0iR6OTo1xU8Zxi5QzyHfjIcicl
	N1JfmAXot0kTvtZEYGZA+T5FRxoWK2TayrGEIMowS1TGWLdJ9e8GoZMJjmpmWeywNf+Eb1BJHwf
	mEl2aMifIFaqDPXs/1GN7YTIWtBjn8hjC+nBA8sYqpFMof1aU56RwqLeRGk4YGiUsAQuX1OA7kW
	zooWGO2MIYN+U59hNoLlyNO23M8I2kobEFwAokgGw8OQrT5miiXFzWsVnjFEyrFWvo2W/HPeAPy
	T3TZPE39yQFw6v8PPKNSnypdD0/Ind4NM0UObNGfmnR3q0FoNDFZ+9tuP94TtiXKMyJXFuuHo8k
	sCOM=
X-Google-Smtp-Source: AGHT+IFvYCqOvd9+EU3zUvfW3hn+WxB7tYCgPpoMVPXdumvj69QndIkBZp5EooM6wsjJAxCl+feKEQ==
X-Received: by 2002:a05:6214:2422:b0:6e8:fb44:5be2 with SMTP id 6a1803df08f44-6eaeaa9904dmr164944686d6.23.1742164323340;
        Sun, 16 Mar 2025 15:32:03 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:ac75:40f2:fdb1:31e5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade3343b8sm48262146d6.69.2025.03.16.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 15:32:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/2] rust: alloc: split `Vec::set_len` into
 `Vec::{inc,dec}_len`
Date: Sun, 16 Mar 2025 18:31:59 -0400
Message-Id: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF9R12cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDY0Mz3bLUZN3i1BLdnNQ8XUvLpFSz5GQTC2NzEyWgjoKi1LTMCrBp0bG
 1tQALm1b3XQAAAA==
X-Change-ID: 20250316-vec-set-len-99be6cc48374
To: Danilo Krummrich <dakr@kernel.org>, 
 Andrew Ballance <andrewjballance@gmail.com>, 
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

This series is the product of a discussion[0] on the safety requirements
of `set_len`.

The patches adding `truncate`[1] and `clear`[2] will need to be updated
in light of this series.

Link: https://lore.kernel.org/all/20250315154436.65065-1-dakr@kernel.org/ [0]
Link: https://lore.kernel.org/all/20250316111644.154602-2-andrewjballance@gmail.com/ [1]
Link: https://lore.kernel.org/all/20250311-iov-iter-v1-4-f6c9134ea824@google.com/ [2]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Tamir Duberstein (2):
      rust: alloc: replace `Vec::set_len` with `inc_len`
      rust: alloc: add `Vec::dec_len`

 rust/kernel/alloc/kvec.rs | 34 ++++++++++++++++++++++++----------
 rust/kernel/str.rs        |  2 +-
 rust/kernel/uaccess.rs    |  2 +-
 3 files changed, 26 insertions(+), 12 deletions(-)
---
base-commit: cf25bc61f8aecad9b0c45fe32697e35ea4b13378
change-id: 20250316-vec-set-len-99be6cc48374

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


