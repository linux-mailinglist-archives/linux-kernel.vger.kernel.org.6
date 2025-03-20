Return-Path: <linux-kernel+bounces-568980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCBA69D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1448A2D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676B1805A;
	Thu, 20 Mar 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGvoPY2c"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEE33E1;
	Thu, 20 Mar 2025 00:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429246; cv=none; b=Ab3gnwTmXaOTXzyy6hDrMxPLELlNrwcu0X9SftVFGrzyYJFR+tDScHmJ2rHtbpszb5NqY1Odhx+f8gIVPV3WWAzuf2wQHJbfMagspmnTzd+D6w8Ej0MZaOObq4EQfpc93wzIyR+SpawQ/QTnwBzK0BBCCEk6OaF4erolUownGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429246; c=relaxed/simple;
	bh=dk7KtJtdwq5rZi7r+9Pb0NMmgsZabVAVOwLSoSxDi30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHO466RugRL/g1wgZQuYsl1Fh7KLEWM3rGBKlE81ykz6c6AEYCNBkwwrev/Y5DqBYTS9zhk5efyzqn+Sr9k1QTkxkxMucnJe/LX5VAeCp9eWibQE8Fn5awr1a+8bWEo6U0IfDMUl6ujGsQOsPmC6yLYkttTW4wfPPeGymholOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGvoPY2c; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c08f9d0ef3so14334585a.2;
        Wed, 19 Mar 2025 17:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429244; x=1743034044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19Gdfw+4D4XqpAXnlFcAX1akfkMiVtAPuON1TfNX38c=;
        b=fGvoPY2cCIpjHg06YC3Wbme3cLNFa1DD4NOErpoAIthgaO7k3NsyB8bOacuWCocoba
         GbRvECOUZVGi6fjQpag0pbbVXZNfXiRtVVFwzozk1rCkHq41L15TlsC8HzvWI1/ePOWj
         A5LN5nY7/Ny+J2y35ljsw7g+X3bL3tbms4yvKwCyKEgVlMlKuUQuARq+pTmAQ5hvhHiS
         lVCGcHnSkF9w8tDlItKL4vGWTZpNyoeqizj+t4emjsEuzekWDqbX4PP0g764YuXMV9rf
         mtdDNN6H4SEa3+fIkkiU8Hri9kpZ2IiMY4xCwYSPsYm3BNkH7/mBNcyH5ii00qokHeho
         6cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429244; x=1743034044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19Gdfw+4D4XqpAXnlFcAX1akfkMiVtAPuON1TfNX38c=;
        b=xUDhT5HiL1Oh5agf8EYIJNM0ti2CjbdF/Jv/89ZKdvMDm89JS3iiWlgNT2wi9Orfdr
         cjbqKnptv+3QEPpbXgDYB9L+T7VzwVzjfdEuKOMbrGfaRUmcLJM4MGnF9pNRkrkRW4wH
         FY3TRMtKb9o7ZTLRJdyXG7qQRW3Dq73BXMmuWsm9zD7OdTGeIs6RO4wrmc5tR3D2NE3B
         CerkKA0xYX33xcg4yZcrbnn+ku5yrqOpBMxR+jA5xmEP1c/EJx46E8dtsDTMfYzw4iI7
         p+OsSKt9rYg5ihv9Djg8KH73rHGQKP3sJqk7YEGnNPRan0N1YBTKNat+OxFJDwMT49dA
         zy8A==
X-Forwarded-Encrypted: i=1; AJvYcCVuQBfxmviipbc7/eKnNS72ESJihTA4lfpQYOgV9QDZ2K7milWqkGofvRoOUPd2xOoAl9JNeoHDKSYOP/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPF5dZr0gPmILHOy2+M+Yy1UQR3Qhvkav+nhLQKoJdJXEz58k
	i93V9LwQcJhLNFc2uixCyCUgf1Qfs4kjaJ2GVrnoLOvYjzzk3q5Q
X-Gm-Gg: ASbGncuk4IRGjpngjGCEWgzkkMxfQz8vymz8PKzKMMgbYO6JaVAgL0eLvplGN0IhZwb
	LuD66IYcSV62vS8Iw8Xet5bpuso9BQMiEFVWjhBCUrKCSQGupYTjPDADA8OHXFoDxrj8rnCG2/f
	Gt5p/5nptS5ModWyvjZYgHBCzxtD3OQdRecJQD9zn5sHUH1QoUeKfoBIa5yB69yI690oV6XTKjU
	AbZx+t+oL1JyIx25feSQ4sHtYWaU2ddoklIdHVdHpcRodwKmZWCOV1+FWyIX2TNEdSTLfx2V0XB
	EXmbLAyU7zvxV18oaBTgWHA3n+VK8ewEUTetpJDZ4d7HCS40/j8MAohLoneUlEc26M5rU9JDqT3
	k7iWpgEoXFec=
X-Google-Smtp-Source: AGHT+IH4Mmor92NRGNz3oGdG4wFf6JXN/YgB7e5SvujuvxVdMlrbF43nRXAYbux/fp8yLehYrvYq3w==
X-Received: by 2002:a05:620a:370f:b0:7c5:6678:ab18 with SMTP id af79cd13be357-7c5b0d06909mr164112485a.42.1742429243869;
        Wed, 19 Mar 2025 17:07:23 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:23 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:18 -0400
Subject: [PATCH v3 2/7] scripts: generate_rust_analyzer.py: use double
 quotes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-2-311644ee23d2@gmail.com>
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

Replace inconsistent use of single quotes with double quotes.

This change was made by a code formatting tool.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index fc1788764b31..e2bc4a717f87 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -169,8 +169,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
 
 def main():
     parser = argparse.ArgumentParser()
-    parser.add_argument('--verbose', '-v', action='store_true')
-    parser.add_argument('--cfgs', action='append', default=[])
+    parser.add_argument("--verbose", "-v", action="store_true")
+    parser.add_argument("--cfgs", action="append", default=[])
     parser.add_argument("srctree", type=pathlib.Path)
     parser.add_argument("objtree", type=pathlib.Path)
     parser.add_argument("sysroot", type=pathlib.Path)

-- 
2.48.1


