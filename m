Return-Path: <linux-kernel+bounces-576104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6473A70B03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC899179EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009B265CCF;
	Tue, 25 Mar 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/4BNR/Z"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F89226658C;
	Tue, 25 Mar 2025 20:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742933207; cv=none; b=iYXMzER5caWNNpK7roonVXpGi9uf7Xbh5OwrC8TsqYS1dn3QQmLm1wqhAgdisSrAUXojzo2E0K/1zV7EcMAKrliZbAzz0bo4PfW/5ZMxp6sZ/+EVimgozGETezXvZ7YzIkysxdQXUtN74s6vLZ0uIHC5CT4s3CD1b/iLQYAujT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742933207; c=relaxed/simple;
	bh=KzJcDYaRYVBGE14IrF5T2tfeI+/FPLq5rRUvIwvAh0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HzSoyoIC5SWEYrqzUZtuNdcinprVgi+AhHDOGI7Tfp8WGV8HdwIk4wExDTsxKhIs7iJF0qBAm4E0rck2ft+N8kLE+V/H6JZbkxRz7QuSXMbYWlFqX2D26y1qg15ybUL8wbeLTeOidbbNGT+1hhK7/jznA2zrJb63CaGhpf5fXgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/4BNR/Z; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c546334bdeso471958285a.2;
        Tue, 25 Mar 2025 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742933204; x=1743538004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G32l2HyQ+FkpTwxZZqFUM96NhKTRbqsXkzkvTLTmdxY=;
        b=T/4BNR/ZDYBC0VYiNlHj5bCegZ3tg0/waSbry/6P7L0CQCeggoepWdoUnkT09pQ8af
         w9QvB7Wi5sfnlmtlgfJz053Iqf/TETLU2N1ymS7auY1rcZogTTlPnzKgE0Y5z5xUoP4R
         R9wQIwWtNePv+Y1vvIS/ZgzXW65+3XDqx05q0YLnpMm+TIMZsKIDY1AD2AAG8qcPBhYW
         DitYKAvHjfHNewX3qgUcROT3WLVnV6GngjSgol0M71HgvdzD2+cEiJPKeMO9ye/jyK3P
         jz27WVZMOIQI5E2J7zGJpHlMyZtynF9fxSzhwIgW6+ird90h2GPKySX2ozMWpzCKisQW
         kQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742933204; x=1743538004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G32l2HyQ+FkpTwxZZqFUM96NhKTRbqsXkzkvTLTmdxY=;
        b=NlDu/usbPqN6OMR0uIiukNeo4LKr7HQ0ikgy6fq7g/6pYgbDAzxm8QX0ASYjH7yIKQ
         KVDD+ZUsLP1lbJwWQzXryLoAXQoVOq+KBj8rhgwxAHAW++65bAWwlcJi++SvSlfbuUVf
         CpAIgvOrdi2Al5Wl5BSefp87WgX0BmINPEs3oRcY99eA8l4gSDeUO/NKnubFvs4Qf8be
         F/CxAVYRdq/uSV2bJZxiUE0IZ0bTCRb3KbFYU/POzKHUQMiEjncjBFw7fg29H6wy/ofi
         nFjxsCBltjMeOB4tovkXvIyoWH+ZaDcEKwRGIvEIVAgMW7g5pcx7SY477vnM7pAV5uQb
         N0qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOz6cbyu9jTat01dbcSyyYttj4fCAV+cNxNd0tSkrQtnu93BIDQGtNDtHOl9Xc8fiNH6SLJqUjIMQmP2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvvlhnC8iOQQ10tgdSuwi+SPl5oPkC3DqozgAlfE5ByEf4ueO
	SMPyhhPrrU/xb3kMiJK0mHWQY/kg7UcDr8wcP9ClfAM2Tab/5p+Q
X-Gm-Gg: ASbGncuGAQKoJEv635FpFzncWXeiCHfonA5wh+gjvJ4Nfkpb6aCFC7PWW9erJbwNBvf
	9/d0FzKpX3/GkOGMRK/pUmcTafV04famqX6b4nBX26uUmTFyATB7im9d44pQ/67IzrOchZmTzPp
	kIEbfW0eu6O+oc3alV03A2NZeJtts2pr99yIXQNVVYQoKsVqMPX7NZOb+SRBUiOexVAcZBMSSbk
	ZBz97gAKUHMcEi2eW1VyJISGmNX1cP6e1PWdFhqhi3wMAXMLe46kns/ki2dHyXhZrs4zJPg4ysP
	WeWl8wa9v7jXFQwFd9dy9f3eCtrCWx1yrXJ+qEU4eX6/DbrfjM9QKvo6D2lqMonUhZFyayIep3x
	LEVzUO+lnegbepQIzwA9rspuENP9XcKO9PX5RWjloJ4C3tI28Y1bhW+36BHkCm/Ff
X-Google-Smtp-Source: AGHT+IGpDXonpZKIOyEk0HcogwpRWoL1drf0sHIBjvIHUpytS/fH3mJOyhqf836pDVzebC9ecb8CSg==
X-Received: by 2002:a05:620a:40c7:b0:7c5:3c69:2bce with SMTP id af79cd13be357-7c5ba1358a8mr2865736985a.7.1742933203869;
        Tue, 25 Mar 2025 13:06:43 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:38f6])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ed179sm673528485a.57.2025.03.25.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 13:06:42 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 16:06:26 -0400
Subject: [PATCH v5 03/13] scripts: generate_rust_analyzer.py: add trailing
 comma
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-rust-analyzer-host-v5-3-385e7f1e1e23@gmail.com>
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

Add missing trailing comma on multi-line function call as suggested by
PEP-8:

> The pattern is to put each value (etc.) on a line by itself, always
> adding a trailing comma, and add the close parenthesis/bracket/brace
> on the next line.

This change was made by a code formatting tool.

Reviewed-by: Fiona Behrens <me@kloenk.dev>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 scripts/generate_rust_analyzer.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
index 7d4274ee90ab..1b6b69501131 100755
--- a/scripts/generate_rust_analyzer.py
+++ b/scripts/generate_rust_analyzer.py
@@ -181,7 +181,7 @@ def main():
 
     logging.basicConfig(
         format="[%(asctime)s] [%(levelname)s] %(message)s",
-        level=logging.INFO if args.verbose else logging.WARNING
+        level=logging.INFO if args.verbose else logging.WARNING,
     )
 
     # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.

-- 
2.49.0


