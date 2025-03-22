Return-Path: <linux-kernel+bounces-572439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16132A6CA4F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C828C1B66F7A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0529233D72;
	Sat, 22 Mar 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEVrdUkL"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965B227B9F;
	Sat, 22 Mar 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649846; cv=none; b=Q5sjGAFEUr99G0FhSogqkEzJZizVYYH+1FjdI0nh8DQCll/EVQzZ4I9AXVaY5fc6sIyNU16gdvZ8UgdUoAOkP9O4gstq2FRMIhcTDF0OfqPZgsExGBu5yf+FqhYkEnFTvnztDzM5eEUMpslI7JC+jRcVEoWMezx/tyiSQ0raMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649846; c=relaxed/simple;
	bh=WBRr5EikhCVjjE4bm/ihnKJwnG3fB6VmASkvX/SElZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uis7F78kFRKhC4+dHXaLG4jVKr7HZEJLzalKovaIyIYxsN8+ItzmgTw9ml5yTq4KniWI1DOuJkas0GnUbQxxelwuIey4h7s/VxuNNcUp+jFOFtDvHZmIUDbEtmZKczP39n5giT7NOLYqP6ddtBBgJ9EA8c55I0KxnmxVCAqV+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEVrdUkL; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6eb2ed352ebso20715796d6.3;
        Sat, 22 Mar 2025 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649844; x=1743254644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+pDfZsvmk+gIicMJcOqJq7xp9xL289w2h0St/wDsY9g=;
        b=WEVrdUkLEZpsEmzBRFmoC83aXjzhKVAQfnC84Uu7PvJORAMSBixjzZqjw4T8fB1Q9O
         dY5+GKY2ZDRI5YS3c5u3Xs2HSzn87lOYjyj5BX7Kv/G3iqLE7Xv13iK7oC6JAVPM5WjF
         cETdPvrcxOLs7RdJPvD2Ey/U12sg3sDlXDa3sQcr1SbOzDhEMNb3J+K4LBSyQCVVHFi9
         JqOEPukF1kfBLppmCyoCWfVLokthj7sNvVtMOTMYt95seVHagNm6IJlmblYCRCYfYjJz
         z1ODsoGIr14tCEqCmkPHNIoPiLdh2p5tgCXGlGoOCxrbUS010QOjNSnTi7I9vyqsz42V
         Od1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649844; x=1743254644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pDfZsvmk+gIicMJcOqJq7xp9xL289w2h0St/wDsY9g=;
        b=mlR9q+XU/w6xhR7jg7sIJLNd9S3KXoviie/xQNojMIEDkJlWZu7v8CSoMD4PKAQ7J7
         SHON8n+k2NvT7hswbnD7uj4hf4jgcIxRjKZLVCXRE5yQoWzho9G/XQnXrX62JLiy9K0h
         CFpHn+KEJf6o1qYvOhVabF6wodKhO/MMw8LXAIeuiFWOBUGND+bqg0Tn3T8f/a3Qrc1I
         K/Npna0XDyfaqSSqbb8Qu0p3CzNaZwnx8aOPchP4vGmoDN4Z/G9AAb5yjWUofWQAg6WI
         BNqCuemSjEd/XeGT+UMd0D3Z74vK8aRFeHv40A7D2k59Vh693Y88HZ3kkipeGntq0kC0
         4VcA==
X-Forwarded-Encrypted: i=1; AJvYcCUJbsQpxTiHUOYlld98m+kLej2OhD+oLJFTkQYSRzfloWB+TE9YWGj1LrOGA5MM9jUP3CEMj0h32zwscXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG59FUrwU79J+qXxTdmKxZg1WQED9uaaSVfZGTYEV/7vNC0w9V
	8thk25nofk/7E1dUbfhO1d9CPlIkXC2IyY7S4dEBM1f+doBEXd3p
X-Gm-Gg: ASbGncuJ48OQ8IH1zoGZaZQabO9WQ1TEeA+uAWHXuLlCGAVjY5ZnXarBonfGzhJp/r0
	Wu0o9f4Ne8MxPtB8UdbyshUP3E1a7jr4zt0PMiiE3v+og4EPJfeTPf5RDHX+ok1wPCI/eJKAo1M
	OW3U3RRRGcgwfctFUuC9AWtyXnSnAPNBPZfbSgCBOnvYihI0hp33gCb5RGPNnC8vQlciL2JOEmj
	cN4Erfn9apU7A5qQf2S+iIAnd5vk5aJJpfWsXPUdWhS47E1+mANVKHQeQCHU9ijWyb8AUI/dziA
	ifcN226W0g/USUEkNyI8oBN9Z0nkAYdxmX/IzCi6jYQjPLGKZi0tLHduhA348Ha9NDjyo1OP+d1
	NcOezNV1i6rrJ+nC6DOtdZW+SsfDr95f61g1W7T+IJh7Dd379TynUD7Miz7D8JBLUq/GOd2I=
X-Google-Smtp-Source: AGHT+IHSqfkkYZqoy8kYcfQcvhE5Fpeez1I/BsbfEI6zs6+FDZ6Oxz6H9VER2H0FX92tzfLxc9ixuw==
X-Received: by 2002:a05:6214:b66:b0:6e6:5d61:4f01 with SMTP id 6a1803df08f44-6eb3f27568fmr118916626d6.8.1742649843715;
        Sat, 22 Mar 2025 06:24:03 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:24:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:44 -0400
Subject: [PATCH v4 09/11] scripts: generate_rust_analyzer.py: avoid FD leak
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-9-1f51f9c907eb@gmail.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
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

Use a context manager to avoid leaking file descriptors.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index bd6e321a6aa5..ccb15aa66929 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -211,7 +211,8 @@ def generate_crates(
 
     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
         try:
-            return f"{target}.o" in open(build_file).read()
+            with open(build_file) as f:
+                return f"{target}.o" in f.read()
         except FileNotFoundError:
             return False
 

-- 
2.48.1


