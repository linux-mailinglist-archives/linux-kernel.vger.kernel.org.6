Return-Path: <linux-kernel+bounces-557126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D03A5D3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180E4189D630
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D215318991E;
	Wed, 12 Mar 2025 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNSL63Bs"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792B1514F6;
	Wed, 12 Mar 2025 01:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741742270; cv=none; b=bASxPyyiF9Q6qEPiXkCqLH4fQBUvfFb6dadySUUDfjhh65x7wvwmLT8cLCr1mgvbNFe0INkFskUmzvBsVKUNpXMAoR/hku3SLAuKY4knlcDjKSduhOOg76Lk5LVE2/QH1ON5qko0z39akyCNIG9wxJzfn1lsURAkB12AwxsiQl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741742270; c=relaxed/simple;
	bh=ii7HkPP2VjrirJm2gQ2k/s32b8ke3rasYD/JaFl7XYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jaw5HBSC2dEnHTrHxJN7pHIeiPCBEuZXMxrVeibWOQKhJQfeF8E/fXr2uauq0wh26y2we4eo6RK2hOoDC2PPG4V/Jo17KrWjCtAcUA8O7iNih5TWwNmfD/KpTzicLOA3DBxRAeztqeNSCsYotsHVmoSSrA3Tb8lZ5Ql//9gFmVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNSL63Bs; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c08f9d0ef3so366426585a.2;
        Tue, 11 Mar 2025 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741742267; x=1742347067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gKVJ7yGzZjAMydSlkvLD1F4j47gCT43sXLOSNESzcL4=;
        b=cNSL63Bs7Ru0gjEhD049PDHLydUxy1dutq8Jab2pXU+SToU1SXnl7d2I6cz31lE37k
         MRYGYUI5TGsMCxNx1tVKscpx4C/FMLX2FuloWIKF3iz9GdcqPRgCGYucuaHCyqPzdy2v
         TdQVZOdcHDVq//q1wREn3G6f8FZyET6db9PU6OkkeZG393aBSgchynGUZ6eq4TaZuqQ3
         nZW6+JY7YZS2RL3peGTIhjaOO0T3MDK3XrkvdsyM7AzzFp1psckTr2JOl6ZBNb8JTf1x
         4hgzTvkk9HbHu+tnzYUDYGfgFc5Q4yBGObW14kYRebRxsSBkbwlkBtNXtAaEHiL0ievc
         Mrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741742267; x=1742347067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKVJ7yGzZjAMydSlkvLD1F4j47gCT43sXLOSNESzcL4=;
        b=uWspiwRT6d3GRsXbsyxz5dVk+kA7YHKR5yqPn2bo/uQqMXwWQI2bBALi3DmPuO0+I1
         R+I88orVMgwPWF1Jbo1MPPnCJyV4+5Yylf+Xxha8Dsk22q7vYa+xcBAmIsKSZmZN2u9L
         NiWY6sw52vvFZVIA/9iMg4ihyKDsEaoDOAmhNF7ayX7lMambt8bbsVtr8jDL9pGcg0w6
         Intuwe3kgMmpNEpZoGBvHJJ4LjHxmDlXTMnOaYTL0zMYnxrQpxwDaXp6R+tWnjAK8TAu
         Bp66MxO+bObwfFMFIKPKalZoTY9Czuf8qxiPAc5NrbpItq1au5zBmymTL0Q0sQrveNvP
         eYDw==
X-Forwarded-Encrypted: i=1; AJvYcCVjN91A0TMBqz8pCjxzj2l9IGUpo6DSdE13sBTuFTmx7cLX5vEZ2wV+rBsRtwg6Cyq15vrtqY8c0/HJ4ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjlyX50f6EZX7sH7r0ZwRNThJO/rtPSCRXHcbJIiR+sbUCkKe
	PS1tKonpsiexLu87lX/bQ/ztppljoNYU214QRPurCRobUVT93hA8
X-Gm-Gg: ASbGncsFyCPPs4Aep342ijUwueshvS416mFC6JAizP71BgMu2JTerIKb8tVHyIfzh9e
	qg4MfGalhvgjn7VPSjbhkUpB6vhuUmvdoAxZXqxAxBXw10/gX6lFj5+f2GVPUFghCW6zN1cAXUu
	YKRC3vrtzqzB+85RftvPIK/Is89NRMf+v0Lqt4cyM/vabeX0gKAn9cd2ChUO8zdZsYoZb2QakRw
	p3RR97tNh9SUKnA8/PPwDiWYgoLt7N75DzYkO2bFDsH0QVlNCte7XdX1Uq+IPoWuHtLgQKj7+oD
	/jm5K+tuYxNu/ojPGT+zgLRjIftXBKtd9bYkoKM/uyFc3RfeZjR8XzyeUKHN+RYFa6glQ0bNpBu
	YbFU=
X-Google-Smtp-Source: AGHT+IG5ORfCJOzgcdUss93D6cWamWh6VoM1zsW/4khQKAMUvlMX4gzceAAHmAvtzBrlQcd3jXbrRw==
X-Received: by 2002:a05:6214:20c4:b0:6e6:4969:f005 with SMTP id 6a1803df08f44-6e9006c8314mr251458936d6.30.1741742267519;
        Tue, 11 Mar 2025 18:17:47 -0700 (PDT)
Received: from tamird-mac.local ([2600:4041:5be7:7c00:2017:ee95:21ab:177f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70915ebsm78599976d6.49.2025.03.11.18.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 18:17:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 21:17:24 -0400
Subject: [PATCH v2 3/7] scripts: generate_rust_analyzer.py: add trailing
 comma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-rust-analyzer-host-v2-3-30220e116511@gmail.com>
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
In-Reply-To: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
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

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 5913934ecb5a..7e78b926e61f 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -165,7 +165,7 @@ def main():
 
     logging.basicConfig(
         format="[%(asctime)s] [%(levelname)s] %(message)s",
-        level=logging.INFO if args.verbose else logging.WARNING
+        level=logging.INFO if args.verbose else logging.WARNING,
     )
 
     # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.

-- 
2.48.1


