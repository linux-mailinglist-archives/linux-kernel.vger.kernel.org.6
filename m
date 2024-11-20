Return-Path: <linux-kernel+bounces-415689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 044AD9D39ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 340EDB29A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F61AA1F0;
	Wed, 20 Nov 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoXHyusm"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FF61865E1;
	Wed, 20 Nov 2024 11:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103305; cv=none; b=kfBWDSli9FDSKxyVjoRCxzDZHvQ2V33ZAD/YDfAqHGNRUdHdPNh3Yy0wjOc1q92BC1OMpHR87DG4nusfAXPczS9ER6G4hyO2STTZD0+hCYHrcgLIH3Nt8XsduWwuzBV/hTIFxIBNz40BztJJeI0vHDzRAPruURl5Kb+9yFhL8h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103305; c=relaxed/simple;
	bh=+qHsMyYa5ga5W7go+25pgFKVZKXM6N2UCRbEAqEPe7U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E9DYeg01T9erSwpDCxWiEZqsEX5QhFPzVRxYuX0u/bQHfgq9VDpnNeZkSkPcxlWg6Nj7jXnwvOIvJ7IOia24c/jcnnMDq020yCWtJsCjUNSLEjeBG22c86VTaxTmwqNzdMviBjN3AwlIaSpPQ2EwF5c7/jNh9FDlujtGK6thEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoXHyusm; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b155da5b0cso421696685a.2;
        Wed, 20 Nov 2024 03:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103301; x=1732708101; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln+Bql7CaJQeNEHAFJhf6sdKI/U/LNT6WuLJuDWawMQ=;
        b=MoXHyusmlLYzQB/9U7ssJgePIfRLBM3/IIcRGdaGxmkm0EIfXddWPccUScf7vG0xFS
         YVvxoOU7zZOk1vPPWCXZohqWitYxJgNgCjhb58E5AzZGXqDOdEK3+LtHtEJqKoMZbFzK
         1WBh0Dzrz9QFnzlpb0ATrldhXTwiPodAeCmcAph4yHie/Nu2i97jL6To2ReHBh5DkDAP
         3dEKFRTc8GBmjT7lzhgKlU0AECx7Mlx+WObjKJ6GomCNCuE6wYRZS3pkBfCWCQiY3wRE
         NCkKq5MEQPRObNjI4NpuJ9AwWpoiRbkeQrh2OmqcNR6wJtAQUejYUroAE5zwWGZgEci9
         RrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103301; x=1732708101;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ln+Bql7CaJQeNEHAFJhf6sdKI/U/LNT6WuLJuDWawMQ=;
        b=CRy+Iv1tZM6xUrNEx8b6Jf+Sp48iZrHBnorn37mAX1E8aZEGBy4uk7jlRaN6+9xuPj
         ivIHSPmAMJyWmcgnxLNpvr25C7zxWMEsNSup7ZfI27uRMw7afz5QG6OQuClVNbVWYQ/W
         AO9JvZHP977SjlK/honOWYZGreUlSlQOaf0YH2i0gP9OoO1COMa5Q5k1mxuPRvm8Yqih
         e5ziIbn6cVjaSNJR+KqfkHqXHjJfVxpA0eZdEUt/wihKHb/QMLoPFCQWO6z8N2qoRs0Q
         WyY9sAz2pBw4Ogdm3s7BiwlHeoAP05BvrfkVcKMqhfz3QiiuJjiyE6pfVGsCZWLXZ2x4
         8YDw==
X-Forwarded-Encrypted: i=1; AJvYcCWjT7vGqtoB4TaVguBYcfosnvZMTVybgkxa7I90Mo/ZDVJodiyL52litJWNIIQAdF0Cd7MB7nkIk3Xzb7oM3D0=@vger.kernel.org, AJvYcCWpXOEXL0qKhWt1AxVy1eXSWxlfHdSVKLvfod90Yt6nqisiotqq3dvB7hcGpfYaTjyRCcXd2lut8oa8M9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzydxTrouKUm3zXgsD+OwOcqSBWcHa+TSH4WNskK2C2PS0eIljT
	P6gwvNAsvQG0eVCtQfDTsBHQQN0XAIqUHk/U4aUV78UosO4eOCLh
X-Google-Smtp-Source: AGHT+IGoKIUIqLZCKk4xG3F2e+/en0lVJXkKzvIVrOUREeewVcXD69PM1uF5oMnNicgi0eBHo82x4w==
X-Received: by 2002:a05:620a:448a:b0:7b1:b252:4381 with SMTP id af79cd13be357-7b42ee73dc5mr274947285a.37.1732103301070;
        Wed, 20 Nov 2024 03:48:21 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b479d46e3esm85640885a.29.2024.11.20.03.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:48:20 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v10 0/2] rust: xarray: Add a minimal abstraction for XArray
Date: Wed, 20 Nov 2024 06:48:16 -0500
Message-Id: <20241120-rust-xarray-bindings-v10-0-a25b2b0bf582@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIHMPWcC/22QQW6DMBBFr4K87kQeY2PMKveoshiDDZYCtDbQR
 BF3r0OqdtPljDTvv/kPllwMLrGmeLDotpDCPOUB+VvB2oGm3kHo8oIJLiRywSGuaYEbxUh3sGH
 qwtQnsM4rlCiFqWqWTz+i8+F2cN8vefZxHmEZoqNfGC+5EaUyQp+wqg0qEDC2NNH1HHq6Bjq18
 /jDiu5zzWrLC/gn1hQvrZKDnWOcv2BcF9DKY43eOS/bZqueDEvJQeaNYWkKrZBrrogkep2T21p
 21pbaVMpLIzw35ATXmj3Nh5CWOd6PgjZzxB+ZiPX/VWwGOJQCTdtZVVa1OvcjhevxzWXf92/xA
 2fTcwEAAA==
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
 rust/kernel/xarray.rs           | 266 ++++++++++++++++++++++++++++++++++++++++
 10 files changed, 373 insertions(+), 45 deletions(-)
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


