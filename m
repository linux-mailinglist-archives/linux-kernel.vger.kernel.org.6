Return-Path: <linux-kernel+bounces-568981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1FCA69D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D9D465485
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C2282F5;
	Thu, 20 Mar 2025 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y10SCJ6e"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3E1E87B;
	Thu, 20 Mar 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429249; cv=none; b=HXKgYQK5MMBiVf6kT13UY2Fp99m5kcq3bKUZhmj9y2qi91qqMs7BeshFcq3zG8PVy4ipTIXWgkts5AccByKlgIKtAt758OFn+Y1fy9R8I+Y2qnq9+j7OHI0sj/OVekUP94zlp3v5Q/4qgSuzI1UO77EjK9tpnHQcB9hQl63wZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429249; c=relaxed/simple;
	bh=+gfaBr0cvuia1lqZHH3v6pzlDrS6h4TAK+d5tJ7V8Kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gyoybv+kQJ5hTEIcWa6Y3fZ0kL4pGkj9J+8wP3hpEWpAQhAlxIWwXHxm9OKn8qtRt5ETc/tarvDEJ4w58YaDLuOG7PPFoZkYubRM/IUwOBqpkwVwy0g52NVXi1tAVa+6y+gtii20M3mWK/r/m5OTrYmQvsuPP/AhaRBrtN4oJA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y10SCJ6e; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c54f67db99so117101385a.1;
        Wed, 19 Mar 2025 17:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429247; x=1743034047; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlyTaHIAWGAAzL1/7e7BfZlkyKveDUKQV/GQUWtfP5g=;
        b=Y10SCJ6eEQzsnzW/5eqz9RjmPnL0kM5pTPCaLdQKMwTlg6ATJktLaTO6D2fG3ibvxi
         jOdKqIKCyt6h9/S2nmZDVwOYc2MpxOU7gsoDU9RlVNekgN2xoT4PG2suCZiIy1F/E1PL
         wXaATEsny+RjgzKTz3SSeec7Z9vY2cTPxzixvc5FPdZS/t3TuRlgM8BRz2k0BToB5d+p
         bnmxoxus8ESazmXG2b/3hGfEsoNwxzPNvCenXUP8tgO8y6F4nHv1yT1i8EGMf6lHZlIz
         5CeGatOP+z9jW45a2EVTrRIcEqy1IpNNoa7TAfS4ptvsFOjGr1PU/81AlvrDxyMq7CAX
         0fPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429247; x=1743034047;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlyTaHIAWGAAzL1/7e7BfZlkyKveDUKQV/GQUWtfP5g=;
        b=B+saiDLInsTgpVPFQiHIVIgfjs6QP8iAmdNyYddl+fyStJwJ2tPS+oveu8l4Fax49O
         2l4nFX2afhwey3d3nkpq/MthL6B1cpSBXMACGTiTvuL4Lx7WEIebP84dIESfqw0zCL4R
         qrtjI8eloS72gL3v2YWT+wv7zRJxOwEwZcx2nBOl1tIOJnHeoPNCMq2boRTIgJxug0Aq
         +i1ZY/RRAkq9Q4pYcgpo7JKmM7s20GCBrHhhGWk1mg8yUS2zG4rbE2joiPAwBIxFS8AV
         3Epu6zvlXLHUL2cXpYZsq/b3j3hbsUa70AAOTueapgNZ8kWizLh8vcrcPde5iESNjnvE
         0f5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwWfroA0T3AyHekRGeZ++eHcCYcJTnRD0QX9fFjUEbpJ+s2xB5vLhmBnGMLas/jo56XavttqUgqD827eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytL0u/AXdKMy1+GdaSbLFJ0LtkiRa4VFCqdh5cRlTsaQXatPOr
	mDcfmdSyZXp6C9Q/396U6ay5LiLEem2QO+iL45eff/TY6QK79mi8
X-Gm-Gg: ASbGnctXai4LktErcOEY8QC/TzObI+No14nw4e6rYQLdLW4b3EnnU783U/VqD38gRvf
	8bC59L7ueb6YQTPhLFQpT/X2B0OJgIS9gzCUd4T6xH8sGq3gbTk5ZjtZMDusJoUdY5P1mm7Hk6I
	s3BvxtxVrtrXv3I3lpgkzTkjjWHkkXALetOIN+lX1bax4Ed/48RxeZvY//zD+gTWbfqhuv1zxrx
	Tp+stfj/yBhxw0CY5Ob2gFgHduf5K5fVtKbJG8NBzbldGPSVefMlHNbejDNAtmH4WM3e0a0Kf0D
	AMT4lrBtprZJzLNxGVJ44O6L0tdxwCvtxlHkbkx07RYS+DZ3sTY3e6GMwonkReR8qlJMWj+7ugz
	BN4V4hRkXuYA=
X-Google-Smtp-Source: AGHT+IEuxEfGRUjYQk5zrlqyTlW04e1NtEAjbnqE6SETPVAYjVVGWLTghJSO8k4sZJVcMbO3QKcdMA==
X-Received: by 2002:a05:620a:2697:b0:7b6:d273:9b4f with SMTP id af79cd13be357-7c5b051a702mr239990785a.11.1742429246704;
        Wed, 19 Mar 2025 17:07:26 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:25 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:19 -0400
Subject: [PATCH v3 3/7] scripts: generate_rust_analyzer.py: add trailing
 comma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-3-311644ee23d2@gmail.com>
References: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
In-Reply-To: <20250319-rust-analyzer-host-v3-0-311644ee23d2@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Boris-Chengbiao Zhou <bobo1239@web.de>, Kees Cook <kees@kernel.org>, 
 Fiona Behrens <me@kloenk.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Wirth <lukas.wirth@ferrous-systems.com>, 
 Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Add missing trailing comma on multi-line function call as suggested by
PEP-8:

> The pattern is to put each value (etc.) on a line by itself, always
> adding a trailing comma, and add the close parenthesis/bracket/brace
> on the next line.

This change was made by a code formatting tool.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index e2bc4a717f87..e997d923268d 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -180,7 +180,7 @@ def main():
 
     logging.basicConfig(
         format="[%(asctime)s] [%(levelname)s] %(message)s",
-        level=logging.INFO if args.verbose else logging.WARNING
+        level=logging.INFO if args.verbose else logging.WARNING,
     )
 
     # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.

-- 
2.48.1


