Return-Path: <linux-kernel+bounces-403220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162289C32BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 15:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDF61C208C7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8E82AF1C;
	Sun, 10 Nov 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKlri7W5"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3429422;
	Sun, 10 Nov 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731248051; cv=none; b=WB9saq3OzXHV6ideNNKW14vTWwa5KwKpv4iRWBMHHGcFJduhMav1Jlk95FDMCC3MsEUH4rV0tViyk/ZscRQisSrVSifvAu/b+MV32bIm/2vr4HiNSDzVsryF7XI2J/gofnvtpUH2Oo5clb4z7YYqK8o7wlJFeQyo1cRP34q9N0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731248051; c=relaxed/simple;
	bh=pOzIUOF7wiHLtB7YQ3u3vJikhq9NWR9CPNS8vj3sDwg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N3wkDRUfWtreQV4d5CxYDPAAng4zI/EcXV5zrrrduOAKEWyhX6NQhq8LFYlCqtJnP3U+taX+K6SGZv3ZZmOEQYk9XZOt2G2NQgYTW6GZ4/8RhtC8Vr2+/31i/Jr8JJ80ZEQU9liPy+fnSBXH5XL7KsllNZFibZErjSPle4kreXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKlri7W5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbcc2bd7fcso25317996d6.1;
        Sun, 10 Nov 2024 06:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731248048; x=1731852848; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qUdG7l9v15Zf1jE/yxJ8LrZf94YWwjhDRp1CDkovWY=;
        b=fKlri7W5om48tzEY0WiaxQe4ey0dz2yn/C2D+EV3LCPuCSHXIVU+hmFN2/PQgosO9v
         odIjOV2WYC8bPxGgV+TDoCOqviLXX7rQT+0hhgM60Trw4yyZUf+til/NyWsbx7IbCJjQ
         KIx59Z5d3AIy80qE7O4bqDgsfoY8yUl87K44L+kdZWRuG7de5Gykvgej9V4RajhUTEHD
         KT6Bkf77d6A700sMsehQhCm5DzhAoC7prA+RljZ7IufdOdWSka3+uZoy79GNQmgbHWKw
         GieN6CLUeHz4BqBLdf+C7h+3AvPVPeQar0gBcPRE798ZsDUppMJCDq9q3eHrPy2+v+k5
         o49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731248048; x=1731852848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qUdG7l9v15Zf1jE/yxJ8LrZf94YWwjhDRp1CDkovWY=;
        b=DeV8LquJz0b1KEWEm5ZSgqcT+zQrEqEx+eBKrQqAT5nWlqVmtLtFxnvDchZVWCApVg
         n/OnoL4wFreSNoxMBJ13TqqMbuDN8npQ3vPQjgBVdO4JVshHAEdO5uouCVl38cQ+su2Z
         OG3tu8/N1naho9+b+Xh5+qExXDgAptjur3q2V/Z4ec5uagLpovVNW8+GaOxb2nEdH/ec
         nFZnrmmv9xqIfJHl+wJG28qFWoKz1kCoCI4h2/NqLHZx6qfTOn7o8c6baxDvlniqb7sK
         Wc0PAmuANz9QgVHcyS724DjAt1fBVfzMJ77jmdkKFDrUp4/auHiDvkUIDw7hQ11Ovhx2
         altw==
X-Forwarded-Encrypted: i=1; AJvYcCX0e647n8kmPDcnBqA7j6dKoRGeNP3I461ygGMAi3gBMAo4dZPwl4bV4k2cEz8Zv6DVSkxncKvGwgdiWzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPYsuHyLiPKUlkycZMsV40vQ5wktARNGYtCCujWoiS+U7pOdu
	uSW2je6Wzn8hFHmH5Xhmr2o9Xv4tW5tFpbYysBvZobjB38SSSL62
X-Google-Smtp-Source: AGHT+IG4/Q6M9FyY/tQKrE67oQB9Db/vk7rMOxvcN22TktcM/OhiwoOgIanwDhMtkSiCajlJwAp4Rw==
X-Received: by 2002:a05:6214:4905:b0:6d1:9e77:f5cb with SMTP id 6a1803df08f44-6d39e14f33emr142174266d6.22.1731248048223;
        Sun, 10 Nov 2024 06:14:08 -0800 (PST)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:3d4c:5fc2:8f61:bb43])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961dfa0csm44570046d6.14.2024.11.10.06.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 06:14:07 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v4 0/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date: Sun, 10 Nov 2024 09:14:01 -0500
Message-Id: <20241110-borrow-mut-v4-0-053976068215@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKm/MGcC/23M0Q6CIBTG8VdxXEcDRKGueo/WheJB2TIaGNWc7
 97Rm7R1A/vO9vuPJEJwEMkxG0mA5KLzNxxylxHTVbcWqGtwE8GE5CxntPYh+CftHwNVheWaWwA
 rDUFwD2Dda4mdL7g7Fwcf3ks78fn6N5M4ZVRbZqCySuNzavvKXffG92TOJPGlnMkNFUgbKAtWK
 l1K3fzSfE31huZIa8WlPMgCP1jTaZo+LOKekRoBAAA=
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
base-commit: ae7851c29747fa3765ecb722fe722117a346f988
change-id: 20241030-borrow-mut-75f181feef4c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


