Return-Path: <linux-kernel+bounces-568979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D22FA69D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 01:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C9B3B812D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 00:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A9F8BF8;
	Thu, 20 Mar 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcwXXDf0"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F74A04;
	Thu, 20 Mar 2025 00:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429245; cv=none; b=H6TutBOLi8Z02yXsbU5u+DJ2VRl/At4PQkURtLifGs7LeD55Y5FqZsfl9vwBgPoZpVLAH/qtV+K3Jqq3wvsAP19wQAGMEac3FvDUOxkaoB7iDsP3wc0/ZRqPm1IJiCobiHqZNL5fJ4LYqxBwsj87O2S2dgKrgH/8HRosUAhr4jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429245; c=relaxed/simple;
	bh=WyQ6kva2XqEInvra8wySAYlNAHMPhlL7bKKkoEbEL4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZliUpiSKZSeSbCsaaqQyvE0E4mAThTtbTXjenq4z4INyZV7f7uZihlzpav7X7QNT4MVHp+iyIZJ/9VZFQDX7q3kERLN9v8mr6rfAfgcSIhdkA3pRPuSwvBN2pKb7+nl//MNvloXfqDI5GOaf2QjZ/IWrsFU3nDzMp/6uNrWQHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcwXXDf0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3bf231660so35941785a.0;
        Wed, 19 Mar 2025 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742429242; x=1743034042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHvdtb5SYqtFpYlkszLsH7KDfOGRrfKpYlR3U+eUgcA=;
        b=fcwXXDf0HZUnO3LHlZdas38m0EK1WHkXEJrNbkCabpbRBg5C6NxcjCUUvbzqOXBC1B
         4BScdMTu7SeR4UQYc4cgeitrDlOMsz6JFl7aqabjkdkBYU/litSUCFP6a6WRbVkEdr8n
         FIYJIdFxzUD+TAC+2GU153TdRid/0g4Zihc19mTHD/nnwMKI/HFD6KJlhYDkrN1Tfrd2
         wFZLzL6UPnoQYwboBWvoqFG72KT8c9nyLMt1sdrfaCTCoZVNRuFB0EIxB15EVf5f5FT5
         rpXioYk9G65k65yQ8t875KHQvtjDsKPdprcjwxKHmkkGFwW5aQVQruImDdX8F2/3xy8/
         1c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742429242; x=1743034042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHvdtb5SYqtFpYlkszLsH7KDfOGRrfKpYlR3U+eUgcA=;
        b=TbY3NTCZXa96hyexJzc+qzzWdDd31ye/krZNOZoVcl+CPyTU8V+yV8zCWE+lXaow1Q
         SDRe0Ar2gH3/pLfO3z/XuIRtmOojNzTMFb1NzsaFpJeIjo+U4yTnTUlIQf3cXsDxARmk
         N8eNSeTAKhJ7B+TbShlQlyC7WbncRZlDOhGdggBFT4fH3qRWXJiKHw3j6tZZDjsIqxC1
         b+gjpvu3dFEcBCOqxHRxL3iSvKm0RBNGjdpcYycyxL1JEhrL/RMVgZ4O8WUHD8vTaKye
         I5N0NTQ/dt/WwoROjQRgbryFBuRbDjP1wwf3o2ZFneTlMjb4FsaqFKwqlNSarJgtFJGG
         xRXw==
X-Forwarded-Encrypted: i=1; AJvYcCWaaocfWli0l0FvMEVFOg4RkhoGP+Dd58qBWfJv/1O0rbr+orpOGNHGw1Y/XbqPskAYd6YJhUs5FN0vu3U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym5guYoaxw3xG5Ww/IaN4FtdIlE9jTpzBTVuAb7wltpNyu+YJe
	lzi+J/hdDMQrx9zPuxrBeXWQV7v2sJsDahDJMht2Ympo/eH1IMgI
X-Gm-Gg: ASbGncsy1a5KMEs/4cGw3KFBFwJodoRF0BnZCJ0AWFixm2rJ7eTCqoOmQt6W9Ux3Koz
	Si+UhXoHtaZvSj5dcZEwx6m9umZG0AlVcSVteqvX0y0cap2XLH33W7Jhb1f2EW5CTNZzlaXImdG
	x4qk8VappyaqvVFRQsCt4ujOQy6312DaOMqqecgf2XylXtLR+/EsZGVytNfflzXIjIA/C4GgPPB
	bwRRBeT8duIo5SE74u6y6a96hH4B3p7nI0b23bfjANr94/L06svS3IuuSWHVlBYI9YK3zr4N1KG
	zmPX+z/hzQyhzwQJY5zwqLueLV8jO/pZogyO0UVeh9vcTbTtSZH1XlpK0pI+8nmiyCKkC2vYtnV
	sB1gdH0iRKgc=
X-Google-Smtp-Source: AGHT+IEDNVkUo0F7+/L2IvufaBksNLn+Pt+JwTAqE2SsBfk5nQkgTAZDjEcYe+qtdX4lpcHqUcYHdg==
X-Received: by 2002:a05:620a:40ce:b0:7c0:a3bd:a787 with SMTP id af79cd13be357-7c5a838eae9mr657229385a.13.1742429242003;
        Wed, 19 Mar 2025 17:07:22 -0700 (PDT)
Received: from 159.1.168.192.in-addr.arpa ([2600:4041:5be7:7c00:1098:764b:3230:64c5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c98225sm921389885a.49.2025.03.19.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 17:07:21 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 19 Mar 2025 20:07:17 -0400
Subject: [PATCH v3 1/7] scripts: generate_rust_analyzer.py: add missing
 whitespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-rust-analyzer-host-v3-1-311644ee23d2@gmail.com>
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

Add a space before the `/` operator for consistency with surrounding
code and code formatting tools. Add a second newline between top-level
items in accordance with PEP 8[1]:

> Surround top-level function and class definitions with two blank
lines.

This change was made by a code formatting tool.

Link: https://peps.python.org/pep-0008/ [1]
Reviewed-by: Fiona Behrens <me@kloenk.dev>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index a0e5a0aef444..fc1788764b31 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -118,7 +118,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
     ):
         append_crate(
             display_name,
-            srctree / "rust"/ display_name / "lib.rs",
+            srctree / "rust" / display_name / "lib.rs",
             deps,
             cfg=cfg,
         )
@@ -193,5 +193,6 @@ def main():
 
     json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)
 
+
 if __name__ == "__main__":
     main()

-- 
2.48.1


