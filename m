Return-Path: <linux-kernel+bounces-415678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879759D39D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B4281396
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF971A0BEC;
	Wed, 20 Nov 2024 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rs3V+DcC"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E419F429;
	Wed, 20 Nov 2024 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103178; cv=none; b=d6WPdy93oSbR+9opZRcl6qW4t2GlPX0mXUTh1r0jMVIj0EI2J53/P++e3s2QMu24KqCqPtwmj74rHc+HFyxkMNkKU/sR8lhEINoT1obzIx7yrMwCYnipbj0ZU6AKN1dKpKIUcYOfPN2eQ4GUL42gFluDcm8Yo4kus8q/Dig4Ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103178; c=relaxed/simple;
	bh=+/iznN0tX6X7p00xB7aOPLIGzLIenbTfc3wblS5xH+g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bJS9uhk/oOvosUh2D6BYgYz4vgc2gE9jC5+7wshsJu6M58xa7ZiC5toQF14GDmVkS/2hS3nlFvysYofItd/1WZLKAIwuODX8GntLYQNAaM/4tHSbO+Tm0V3jTqNAQF50X5f7scHZXEBIkIV1raA2K6t6NyuEfLrQ0Z3I9FIjnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs3V+DcC; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6d42003c302so23278176d6.1;
        Wed, 20 Nov 2024 03:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732103175; x=1732707975; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb2ojcgd/bMqY70qgClcOTG9geNNnjtqkBjWzdJ592w=;
        b=Rs3V+DcCHclBxpBtaMqRTjpHLgFC9CQu0wsyS0AQLr6NTwXPtDGuOrNI7J4aYVL6Rf
         o7oHBWVpCr59nkL2/OHUkdmchOkunwDCLWhkan+EUt6YwEDKvBFQtyFJM0EbLMrZXJK8
         FsVu4pl/U39UERFITJd5k427TjVPbHgcgIuWEsOtwXnZmudalnkgmU+XSwXpfMoryVMN
         BO3QsC5FxpKO+xXHRmY0ck7QVzsuYCI5yzjDjJ5MRoqChUZycAq+Y0jf6pOsZEs6aeKi
         GFnV9WMFpXT+Xtrf8UeW5GzJGU2BE/+2O3oWlbYtC8AfprKbAkJBubjZxY+BBJii9Ktj
         DGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732103175; x=1732707975;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cb2ojcgd/bMqY70qgClcOTG9geNNnjtqkBjWzdJ592w=;
        b=G6GMl7YZresA8SlDZ24rEm0CKu7rBSriNi7YsFRCsqeYf226/onocVSj8vewOdKPmp
         XOtH0UtE9loNEpsx9e1xhfHOIjzY6vvCqFFnRwRvyVMaTzUhKHpz7OMS0a05VArDsl55
         xTVDQN5g2Xy+7ormodWsmsomgRGdqk2RijUtwb++C5x5PQQBmQHpUl+iSq/X+FoBPQ0c
         Rpxb4Ld54c91ON+Sy5uTcYTMtsoL20B8u7ghrIU8RkXh7cL6DpfhsepSP13IWMGui0e0
         CYSpBPkyMpjVwnVHPbYCbD8jOO8hHWkyPoZhEPRrROhJqPm4nVDXjJPAgtv4UHMfHnqT
         o3NA==
X-Forwarded-Encrypted: i=1; AJvYcCWR5Cdh5BErbau6WyLa6cq3UzV8J9BXfjpDxWxZlNNcp5XsqYOzTkjr0WBut916zCZWkIwuYPzW0vLrxSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrc/IIHvrIMOkN6Pxtx8AkdkBdBBrgtCCUjFhd7SmC7loLCd0X
	YNxwagp/R6kwmyuLLZAo3pvyRSnPX+cKxLdwTi2yv37bLfGZcW1d
X-Google-Smtp-Source: AGHT+IFqx/rqe+UvGL/u1Xy3LiiFFA65ueU8zJBlAVqhr6s2yTzTMHb0fTX9LOhPPSYZXW4c5H88Sg==
X-Received: by 2002:a05:6214:21a9:b0:6d4:10b0:c242 with SMTP id 6a1803df08f44-6d43782650cmr32224096d6.26.1732103175585;
        Wed, 20 Nov 2024 03:46:15 -0800 (PST)
Received: from tamirs-macbook-pro.local ([2600:4041:5be7:7c00:8dca:61d2:c8fb:a544])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380b6390sm9705696d6.5.2024.11.20.03.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 03:46:14 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v6 0/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date: Wed, 20 Nov 2024 06:45:59 -0500
Message-Id: <20241120-borrow-mut-v6-0-80dbadd00951@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPfLPWcC/23Pz2rDMAwG8FcpPs9DdmTZ2WnvMXrIH7k1LHVxu
 nSj5N2n9LIk7GLxCX4f8kONXBKP6u3wUIWnNKZ8kUAvB9Wdm8uJdeolKwsWDVSg21xKvuvh66a
 9iyaYyByxUwKuhWP6fpZ9HCWf03jL5efZPZll+2/NZDToEKHjJvogz/tpaNLna5cHtdRM9o8aw
 A21QnsmB+QDYej3tFrTsKGV0NYbxBqdDN5TXFGzPRiFgqtqT0DBGrenbk3dhrrlr2QBW4s1kV/
 TeZ5/AX/lU6yQAQAA
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
Changes in v6:
- Rebase on linux-next, resolve conflict with f893691e7426 ("rust: miscdevice: add base miscdevice abstraction") [1]
- Link: https://lore.kernel.org/all/20241001-b4-miscdevice-v2-2-330d760041fa@google.com/ [1]
- Link to v5: https://lore.kernel.org/r/20241115-borrow-mut-v5-0-86204b249667@gmail.com

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
 rust/kernel/miscdevice.rs |  2 +-
 rust/kernel/sync/arc.rs   | 42 ++++++++++++++-------
 rust/kernel/types.rs      | 93 +++++++++++++++++++++++++++++++++++------------
 4 files changed, 130 insertions(+), 48 deletions(-)
---
base-commit: 7510705aa41f7891c84dbb37965f492f09ae2077
change-id: 20241030-borrow-mut-75f181feef4c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


