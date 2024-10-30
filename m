Return-Path: <linux-kernel+bounces-389518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD49B6E02
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 21:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2191F2171D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE311F4738;
	Wed, 30 Oct 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwC9LBdm"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E64C1DDA2D;
	Wed, 30 Oct 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730321204; cv=none; b=c/6N9oVdd/DIcEvPCRgTR8fu3QGB5nYFFG7c2CeAisHd8vDqqIKeHUmaeZ18F6ZeqvV2NSS9NC7f5DIbL/393F1jEJ5bPLgVOLWwGYmmhSgRSf9Wu0L+cxMoElyzbFRmUvD8GP2RUZuYX+Ke/pXfPvxmWKBJizDhFVQbHD7lcw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730321204; c=relaxed/simple;
	bh=OG1nm0WBJCwtB34UvJCCWn0SbL5RFOVbH0plDHBLLY8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qzAUwkU9hWwh9NZ2ttTINDkzT+WaO17NCCIyFdD9iF9hKbPclw1NZOp45mcjIOXcYglzxGmSB4lZbHkQSf0u3zDiGC53WrHvoXs5miLEtrEXCbn/Tmo9L8R/71p5/F/XfGkflPbxi+AWT20wYJdQb6aQTiUS9n/J5ycEOELG7M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwC9LBdm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46101120e70so2007421cf.1;
        Wed, 30 Oct 2024 13:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730321201; x=1730926001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dzPXg5GuN1dkHpzU3w00t9rIGUdFp2phNz3aiRy6mHo=;
        b=bwC9LBdmkRS5FC6uQvBFMgJxCKK/PSIIJkP+70MWyiC9Bqs04tAjOEl2rOMTsdksLU
         G45u+IglMuhZknkJLzmXI2/gQDehld7UOTxvgU55WrPR/N6dEoxnZBNQ8OlIMfT6Nair
         uQLBHdPMOR4FLYdLco8+k2crl3z+xhhlThhKJ5OdC727aEU+C8OuHCjinMbLb5xI+wQn
         BZUsyC2iBtaFJ3qpLWjoIR9L/7mmAYwkmGMkq0zis/plmQsl7mPnAUvk/2j3o+GMbkJ+
         KwUKPTduV6LhRW4RS3NTh4VIc3a3BWuCHChhzMjwmhyyD+PqUyoYbkbVepDW88h9ixCh
         Q6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730321201; x=1730926001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzPXg5GuN1dkHpzU3w00t9rIGUdFp2phNz3aiRy6mHo=;
        b=Wx3jaPjQ1KtyV5k9qgvtLDEuIySiGd26d+mkBIHUnuHupwX9sckyH05kM7kimnJAJ2
         qxQ6lt9J131IR380aWd/9zyXxD1rcqobkBvkdGxC+mkd3Krg7H/irParlGF/VXfE+e4T
         BN2Q1Tze1v5tpkeQgp/Sy4BmlG5LzDdBFy3r1oasSGQpNFAJISd24Qv3CQtBEvHqN0zH
         65zYjvzEzMXfcRgek42jJpfuUv6noM3fSiHKtFieDLLEoAU8eIcxkNo9U+5LIbqNAZ91
         ZaYm77PWAc03repGCcnkaqSSoApKblTBo55V+iDyUQ8yTYt6nnuJ4W4+O+bqwkglJNfj
         claQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzqxe49pAtcUPk3N9plJhaT85cggEDgla+3INpcYV8VS54u7/StGl7s7Uee6nw5F2/7MT31lAIBXjHQXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28k0feUFOPDUXofLHPGSX5pOExK0kFvpQgk+NbWjFRIewxLoT
	yJ05mRv7hZCV5T9lPG7z/Vupu3bga1c+FI5ESAiXGYK9TTjv8pL+
X-Google-Smtp-Source: AGHT+IFNerQSeeeUeGBoh3PkvRz3va5jlUPbRyvdMQ0azpvEY4sSYMKBVAU+llXcNQ5H/SQ80qhh6A==
X-Received: by 2002:ac8:57d6:0:b0:461:4002:4d1c with SMTP id d75a77b69052e-461717c564bmr50518381cf.50.1730321201290;
        Wed, 30 Oct 2024 13:46:41 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:89dc])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad0c72efsm271271cf.50.2024.10.30.13.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:46:39 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Subject: [PATCH 0/5] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date: Wed, 30 Oct 2024 16:46:37 -0400
Message-Id: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC2bImcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA2MD3aT8oqL8ct3c0hJdc9M0QwvDtNTUNJNkJaCGgqLUtMwKsGHRsbW
 1ALXa7ztcAAAA
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

`ForeignOwnable::borrow_mut` is needed for `rnull`.

Link: https://lore.kernel.org/all/20230710074642.683831-1-aliceryhl@google.com/T/#u [0]

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
Alice Ryhl (1):
      rust: add improved version of `ForeignOwnable::borrow_mut`

Tamir Duberstein (4):
      rust: arc: use `NonNull::new_unchecked`
      rust: types: avoid `as` casts, narrow unsafe scope
      rust: change `ForeignOwnable` pointer to mut
      rust: reorder `ForeignOwnable` items

 rust/kernel/alloc/kbox.rs | 63 ++++++++++++++++++++++---------
 rust/kernel/sync/arc.rs   | 86 +++++++++++++++++++++++++++---------------
 rust/kernel/types.rs      | 96 +++++++++++++++++++++++++++++++++++------------
 3 files changed, 171 insertions(+), 74 deletions(-)
---
base-commit: 718c4069896cabba5c39b637cbb7205927f16ae0
change-id: 20241030-borrow-mut-75f181feef4c

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


