Return-Path: <linux-kernel+bounces-401906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3B49C20EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6102C1F24FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C255B21B448;
	Fri,  8 Nov 2024 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI8FzV7b"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDA1F5820;
	Fri,  8 Nov 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080801; cv=none; b=tQLOPNdtbxa9kZxtckBC2wdE6uMUI9oKs3Tq49hD2Onclt5zgz/4Hx4QQM+/I9buVwSougC812noSlS2XiFIPJzhmn48r62qI41mJHUJ8b+8ktneEjknGX6EWdu4wGP8gwRJje5+Ay+z1bneyHF/kY5FoKU3+gcK3n+sMaKJKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080801; c=relaxed/simple;
	bh=+b1XDjxCBrhGnASzG9Kh3ezvYWn9GuWNqkqZVaTbJzE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qsk2zqgWrT4wWU4zC5C0NAxhGSNKqylDLUIXRIwbjIn7oJFLVh2CzefTED+01YIGbmmyLRbqRU1SZYNyN8t5RNy07VrzlVprQofWKU8c4PHL3Dr4zIyViX78WK9C5wCTVSWzSBOF8Rtbav0Wr/K2htLx0f6Ezc0n7FNnXQlVEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI8FzV7b; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5f835c024so1437781b6e.2;
        Fri, 08 Nov 2024 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731080798; x=1731685598; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ItRtfsWgwwvEBlsZjhTKt0kRebaLkD439UdEu/s15DY=;
        b=hI8FzV7bv+prSicsecpeauP3W3m2GHfcBViDhxFI78y7gCRV+QjZyfbDoOGrbl5cVF
         ZXWzDKkge060bu3LnDVyLRoH0Ogi76dO8CbeBe68OH4SFC9UISf8klzIUf6Vd2Dz2Gir
         vmrIX/sATatAiJt8NNFKv/dMMveBQgWj9FhR5XLFb+SvTYLKzXXEMTlKQyQRCX2blJT6
         zvT26O27pidzvWPRGq9fuci5Jh5GpLNqUTn6nE9zpeLAZoJaL6a3Hh2UT0y/t3pXgCMT
         YCPu7n5AYuzoxx5ipspq5EmLOsfGYxBHfxUC2F93qkBhZlr+wzr05j8Ut4g9OgdQkrP4
         PleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731080798; x=1731685598;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItRtfsWgwwvEBlsZjhTKt0kRebaLkD439UdEu/s15DY=;
        b=dq3Itr+f1ClG6PWakR/M75NPF2G8Gy9c4IaYf2CFMk9U/qfFY7sZmJVICA5zXlUZsL
         OvXOlk5QBHInHoP6RYYFGCAVW3Pk6p6etFBueTrKBIbYKKGSGezlF/dUXL85+Ugo0qMd
         3cQAmPh6s+ey6Rvc/8V46QyZKMHxL4OygbpFFRIdnpHrIySmWdea1a7+OIIeqD3+UoXh
         9jkEd5VqThF2kCThEzotweK1mU5LX8k4Nf0+LtVzNrWiez6ko1oCDlQ6rMKeOjJoeCet
         Sr60KkndLTRhd6sF5XYVJF+0o5jGsWPxN831+yZDwMmrBAyW+3o7lSpv1fOnIl9Diutl
         uNgA==
X-Forwarded-Encrypted: i=1; AJvYcCV6vUe6fFQvHqYS55gr+Q6NsEoRAKLLRKu7qYOP2A/UazyipdU1TE8WpFkuvyMYDc5PQ4lXPiDVVkNC3gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmJ644X+dV4sGnRUzqYtGpHTTqEzqYBMGt0oHk1xs3GCg2qrF
	m6ZXxY7bnL29V8lWQNG757WSUGWfaxtjkTIMb1060kFR5s/xOhbZ
X-Google-Smtp-Source: AGHT+IFtGptHm3S3IVXjvPkYrl3daZbGksVDhK2PSW+vtNqWjFDnha7FLjBLa13vCuRgbmshpw2FqA==
X-Received: by 2002:a05:6808:3090:b0:3e6:37f7:5a2c with SMTP id 5614622812f47-3e7946aa10amr3566804b6e.12.1731080798581;
        Fri, 08 Nov 2024 07:46:38 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:348d:4cbf:ba75:f557])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d396631118sm20673676d6.110.2024.11.08.07.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:46:38 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v3 0/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date: Fri, 08 Nov 2024 10:46:15 -0500
Message-Id: <20241108-borrow-mut-v3-0-b7144945714e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEcyLmcC/22MwQ6CMBAFf4Xs2ZptKdB48j+Mh1q20ESoabFqC
 P9u4aImXl4yL5mZIVJwFOFQzBAouej8mKHcFWB6PXbEXJsZBArJsUR28SH4BxvuE2sqyxW3RFY
 ayMItkHXPLXY6Z+5dnHx4be3E1/dvJnGGTFk0pG2j8hy7Qbvr3vgB1kwSH5Wj/FFFVluqK6wbV
 UvVfqvLsrwBz+ccZd8AAAA=
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
base-commit: ae7851c29747fa3765ecb722fe722117a346f988
change-id: 20241030-borrow-mut-75f181feef4c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


