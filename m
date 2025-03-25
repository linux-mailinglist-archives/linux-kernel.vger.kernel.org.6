Return-Path: <linux-kernel+bounces-576115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5BA70B18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C757A80B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DB6267B9B;
	Tue, 25 Mar 2025 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUPxsKsI"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38780267B19;
	Tue, 25 Mar 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933222; cv=none; b=IaWnRlYa2m7VXvVoTCDHB9crZAlPCFJ+P1SwFfFONZpZe6qU7jrcEHwRXkprsLED+29dmZ4oAiSv3YI1gAjXkheMM2vM9NJXdq3atASdB3EXUToKCe8Lit/mubNYSfzKjxMR7NnMN3P+KzLDMPPRyLVRw1kg+eAfA5AFRss4EkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933222; c=relaxed/simple;
	bh=1yFUcOpHUOIgBreFOly1F38SGM7zd64N3dGYLNDoXic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTduN+UieO9yqzy9b2M45m4cEZqji8gh/8HxQjv4WCQFjRKcydoDMlGQAddfSQU4Rg6EZb1gxqgbT7SUz4PP3vbNc/GY12k1+LdPGLnmSy93Zmse+WiMXCEosWd6Mhdo2AK1/YX549Vyi+rxqAQJ08GOKPd1tMyzOnnlBsPmjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUPxsKsI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c547932d2eso361404985a.0;
        Tue, 25 Mar 2025 13:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933220; x=1743538020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBwQPN2xCDYLo+eBhch8X/oz6/HNwZpgTbIjMvkraHE=;
        b=cUPxsKsISQEKK5WbijY4pBsOKM/XA7z0Oon+nlTnkQt+ODZDn9Bokuy7ZZrcmm4Cps
         ljBIn2B69Jls3d35XllKj95vhGCqxue4z1fTrJZk7WAc81AkZ6Pli3ijvZZSN+Yhwqjd
         W3jcXECnLpQ8AdaO8O8M4nD0XnYb+0bAY9DqqriU7IvL2uM384d6g8bg8IRx4BMD40NR
         OwEYuMqafJeCkEsxtZzEoA1kgml1orWz9Vl5S4Ia7EpkzTC/caZ6dmhYN5ftHQLdsW//
         cxgL7hUkm/50u/RVCtZAFYoSMmwPhjmoUzkRm1lV1zu5yGPZYbwzfywuJVe1xAuElXvS
         wTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933220; x=1743538020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBwQPN2xCDYLo+eBhch8X/oz6/HNwZpgTbIjMvkraHE=;
        b=LtloUl76hq2/wBFiD5LVsk9kedTC/kj0bbM7Dh0+HD5WwLjwtCBDzDAtt4SMghkpys
         ny2uLoo8K/QDYgFG2jEoYrEj1SK0LuG8axgVSEIzQOv3PGTaEgKIr9Pg+RlEKyA8FVKJ
         E9a+LuYG40x5CNpxcKKWIZpVjrd2CfNBaQ8Jg+k0m+Qf/C1M3KNqFKpy8WNs0EopKe1R
         0ms8EuviMHgLLF2nY4PGNBLj+buq1PzL0BUfiH5mgz2ZERRrHk6+wUdBlbjgcy7MsU2i
         Jxtr8vpFsywBdz9ApCJqqI53CEqMBvKL+IcHaxZTv8AnKe55bInQ3KckuueaaWLI8yep
         I0UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdJm6TLWLUyaua4Obi2lVMIb1/X+zZ5aqGpleMBv4MoZe2E/IDSDoS2ikraXP6GJMn9SYEs6ORoXfLIeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6cLcgR6VtWt69BG59PwJtpF35BHuWPzTCkxZgOWz2fWCap6LV
	TQ9fxpJnw7XJEMxqaKtWSFzHafnuRm/dJefQE2NVowyEMXnUZutf
X-Gm-Gg: ASbGncuiw+aEYh9Uo4YirPc2mJm8rI2C52HhsVu3jUqgdteR1oz1YdK+xjWHfevj+iC
	ndd/gRGILulYp2/sZGigdASDzrRCvX9QnFntq9A0EuV2NywP8j/8GlVhuTJIQSwOHncwiD/gxhm
	mnoxuAZa0xnCefXTrK1m3ShxeFwti373Av8TIpNcmAsMkFlLYtuwM7VI7Ohp3G/9zXM7G+eRGvj
	m20oPoVi4x3Tuhbp7lsizitrMQ6G8yuR9kehmcB0AGvIJCGfacysPXyXANRNMqZNF+npQjvnYmz
	/LZ/yYUVNGid7HcmS4jL0aFchHD4hCRvqbaUO6D3fN4qRsU73omT4NhqXRShIrdJWe6Paqbxa3j
	hQIZ2AE4grcSKy5FySSYRgYjobj9Kl6/H8AIzwWbOIywzLDCM4SKkzg==
X-Google-Smtp-Source: AGHT+IEKVbuE0KyXkkSD6p62PPcUjmD6BHNj9U3H61XKcvKbWqqImBFROAg6gD4n8iLDTwscXPJFDQ==
X-Received: by 2002:a05:620a:4443:b0:7c3:ccf5:363e with SMTP id af79cd13be357-7c5ba15c1b9mr2818260185a.13.1742933216574;
        Tue, 25 Mar 2025 13:06:56 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:55 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:34 -0400
Subject: [PATCH v5 11/13] scripts: generate_rust_analyzer.py: avoid FD leak
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-11-385e7f1e1e23@gmail.com>
References: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
In-Reply-To: <20250325-rust-analyzer-host-v5-0-385e7f1e1e23@gmail.com>
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
 Tamir Duberstein <tamird@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.15-dev

Use a context manager to avoid leaking file descriptors.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index ea4dd68d0dd9..e3f1ec856ecf 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -251,7 +251,8 @@ def generate_crates(
 
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
-            return f"{target}.o" in open(build_file).read()
+            with open(build_file) as f:
+                return f"{target}.o" in f.read()
         except FileNotFoundError:
             return False
 

-- 
2.49.0


