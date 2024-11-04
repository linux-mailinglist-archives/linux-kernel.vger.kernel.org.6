Return-Path: <linux-kernel+bounces-395563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0EF9BBFE6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1BE2817D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACFC1FCF62;
	Mon,  4 Nov 2024 21:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG7kB8Ts"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0811FCC75;
	Mon,  4 Nov 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755237; cv=none; b=fAlBuUuqsduhSG2Vopn+3LpCd7gmv110U5UlhLEvY4LB2L5TuBScEvuYfF513glTiXFoqEkCUSoS40rsxvk6BTImhQVptMtkuYV4wCaSujtbAtEec0JIFl+9sdU93iyq4Wrl6JXY+Ca2KROSbLh6ElGWex6kDAx8WKinlf/0JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755237; c=relaxed/simple;
	bh=m0Y5Rp6+/e2kUI+Xg+kKf/AOPGOZrxL1D0JvYZQ/9D4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TCdnMsfJdp8wxWyv3h5hm9kGzZlenVjsWIlcx4e72y+hJSq0LuJ6T0ENJntbTErs5UxrAqsBrECBIyUXgmsPAAANQH6SgHTjC7Zdk/6Yne1oyikv+aOkkS2qDGW7i3dB3nUWbnkPJFosK/4WDCe6rYL6t+rQ00K70zKxZQQtyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG7kB8Ts; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ea1407e978so44600417b3.1;
        Mon, 04 Nov 2024 13:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730755235; x=1731360035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/TH9Q/4cZksjuLSZyT1yIRptqpNc6XkFqa9Aunlve2s=;
        b=mG7kB8Tsn8QQTVzEZgzHMF8woIpiDOvnYrnsKVTDs5v0kxmFF3jpTOgTy3cTZk+5vA
         IPimOiD/B5KbGX3jXUiKdgleHgJBcdtZbUj+NjOy2GIOmD/oxtrfW/qxcsnXfTUw5ZXe
         0lXyZIKOdzwz2e0H8EMJtc2gkNE5PxQplc7s0z5yR0TQveRcJ269PYgGeDct5j3uPgCc
         jfxb/bsZOj4XvQSjtF6l++Q1CwnYVAGkscwKaI8gnBspSw/ukoyleuLBk/A2wdKqWUSg
         IM8c5le3hA2vd9ZRM8ur8KA577sVH0kaWVlRuBBUTgSPKUCSJ4oLfi1QxhpeTL8vnsJb
         MvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755235; x=1731360035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/TH9Q/4cZksjuLSZyT1yIRptqpNc6XkFqa9Aunlve2s=;
        b=DVnUAo9XSeQwh6x1NkIEiFPxGshZYj3t//YP9Wcuq/RQxjzjjHkD9Sw5eF5dd0oP4V
         zta7GQjaSYLrnoQ6bQ/ea91PmeQ7BXYGHSotDT4WsFrF0sUTuPB0JJqoqu0NtBEsXWt1
         SiQaIs8ZOtO87DArdRdqJQBB/JRXD/OEJ8yT9r3ZmM5t4viVaSmi/E8xl6c0Gqe+1ZP/
         Q0wmPVgJjsMPgJc8PucP7U+f1dKQ+mQDPVl0euB3SZsY+rliwBxC0D5AyDn2MI+Gf8kQ
         hSoIb4KsUNY1uQ99jCfSTdEs4VrQOQzW2T3EDxGy8yo6iYzRMFAm18w4fkd688hDuVSK
         ybvw==
X-Forwarded-Encrypted: i=1; AJvYcCWIx0fTDjxuYi/gYZNbKDlSzNMCVSZK9RyVBuEFBzg83+mNJUBqrTTaE3bV19z+qw17Ip2xJ4/ea8AdT1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3G/8wTIoSh7fcdHR2VxkGD4GeAPxXiywBesfKEiAU2MWvhzCW
	vN9Y8WhrJHAzwjimArMiy8djFA4MSc0pwYJUL5bAHcHZ2CfDmNVJ
X-Google-Smtp-Source: AGHT+IGNKFfmBHNRQ6O8tgnXEN8XT7zoqEycWoSaI9Rw9FLcVz9wyDhCaNw9BvcHSKCjuvm0D/LsfA==
X-Received: by 2002:a05:690c:708b:b0:6dd:d709:6f18 with SMTP id 00721157ae682-6ea64be67f5mr142437967b3.39.1730755234655;
        Mon, 04 Nov 2024 13:20:34 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([102.129.152.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea55b1ed29sm19555817b3.53.2024.11.04.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:20:34 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH v2 0/6] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date: Mon, 04 Nov 2024 17:20:26 -0400
Message-Id: <20241104-borrow-mut-v2-0-de650678648d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJo6KWcC/22MQQrCMBBFr1Jm7UhSKw2uvId0EeOkHTCNTGpUS
 u5u7NrNh/fhvRUSCVOCU7OCUObEca7Q7hpwk51HQr5Vhla1nVYHhdcoEl8Yngv2R6+N9kS+c1C
 Fh5Dn9xa7DJUnTkuUz9bO+vf+zWSNCo1XjqzvTZ3zGCzf9y4GGEopX48GKhSkAAAA
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


