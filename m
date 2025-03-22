Return-Path: <linux-kernel+bounces-572431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BCA6CA47
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C060C189FB9A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504EB22A1FA;
	Sat, 22 Mar 2025 13:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5kPHq8i"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B01200CB;
	Sat, 22 Mar 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742649832; cv=none; b=CPtdjtGxaXWipcZae9/9Z/LUIGx//m3LRy0ScNFZCA3ypzZTD3LrW0+NCgqk2WVoTflAV+k7aUEToS+41MZPj9UjKjXupXbMEzJZjogUDQcewJuFK6nU+k4sTObkG42grtab3YajM0PSJpxLhUfTcNrWuAHTbRxCdoMPU3Epe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742649832; c=relaxed/simple;
	bh=WyQ6kva2XqEInvra8wySAYlNAHMPhlL7bKKkoEbEL4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IpQdw1f1VemQpUJAaTKpdAou9t4oy6RJ5lAX0t8OZI7Z6edwcq/tZBOOImFjZ152OHOp4waRbPJW3XF0YQiJudQeaJQTcF7leAQd+aCF5av0mwosK4RTCsiV7Ln2+8GIcf9xnb8AWFDJxqEAaev7M4wheraGInFAMieqV/ulTY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5kPHq8i; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6dd420f82e2so44953146d6.1;
        Sat, 22 Mar 2025 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742649829; x=1743254629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHvdtb5SYqtFpYlkszLsH7KDfOGRrfKpYlR3U+eUgcA=;
        b=Q5kPHq8ii7+YevOGVq6ZQXJU9kohLFVPf9/MA2Va4Ywzhqg7yYxnQEz44bzOhiTVLw
         eV2pJsG1BZUuQa9pVEKg9GD4LfNCIcjpMzn4t03aiVuPzP2zWO0HyQaCTXShPZbRP6x7
         GU1uJLvBMfnw7LJuHsYrTuWxedIChkoP8sVUhxdvyuvxgDO8soy5HGMe2XWUbh3HkCDY
         OKh4n+OwAF3lc34DDfYCqwbTXaXw5JGjX6tE9zahdQ7qUHjwFBAOgD/KxR/rdPuOud8V
         TjGuH+4KDygReHUCtO9mwZYcSz6nIFXNL+vTIW9tN2heQUl8X/+OYTZ92TVlO1ReK7qZ
         cjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742649829; x=1743254629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHvdtb5SYqtFpYlkszLsH7KDfOGRrfKpYlR3U+eUgcA=;
        b=oQJ9iPX9/le1UPZJQpSaNrIwuBcisEf2PVY2gJiO2+6MqhKUQLibUyNGgQzNuZm56q
         eBLefRVT+SpAzoeYAnff8gtXHk+7UccDK2WBtliW5kvkF3EQIHNvCCLuOZ09bPNFEnUu
         IRfuLiR65o9XRC+5mYGECs0ZpLVPrYU5v5PvngX8JokkAuk9fs/eXkxE6syuBi8aW3Nw
         /Nqr74Fpyd3elhyYR/T799a1QHNiUJLqypfThp5MJ8R3xTdrs5Rt6iOcuutAdhO5GG/8
         dfHALF2y67qws9xJqK9ceVp5WJek4tt+q9/NBMqofT8orVCuaFJpfrgN+u/F/hL1H9Zb
         EGCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMSULFRE2CK3vH2SNIbL6m+Ppz+sjJ0uZhhjxZGQLr2n9+OPamUx2rx/U2Q0VyqDYVM5cdpqtp7n6VSvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx14QAoJYVKVudPUAUkARzXvZ/7KLWc/yjrBQ9vwGrao0znt1kO
	nvoMMXzXojr+KhLClqAuPet5Pr0vy6t9OYm4ipeGRkul/4udWv7w
X-Gm-Gg: ASbGncuPXcchm+O1OAL4KC5wAaqYQd9jN41AwGO2XooeYAs1Cv84zgMd+uWXPjcAMYA
	OmeIpUtCpjpoB87yryB1uZM8pgTR0OCIeIOXYIfFug7aOePTvC768oskcUWpqQ000c0fO0SB3p5
	kKHB7NclRd5aZNk1d/Lq8n6PKvJN6oWNMEFC7OQOO/1OeTFxz4u6gHLRv6C+FfUZSIXYTAZx1RN
	wOPgivpVBVSilKorct2o8xS8gQ93jMeu5rmc+1jkFq9a+rkqpaAVXb4K3PkygP/I979FxirlsTT
	NJMOz2+LXk3rspnS7ZxgjCYnTnx0RVU0g9cO5aWg1RkL/eU9kvWXRyEAKbskJEFxj9jXlu11UUO
	l1WZE6PRAZnxImHE18REGgSaQxjOKtle4Vmi+KoAsqMknj+R/gi/d9hnaQygEFijTtLvw4jg=
X-Google-Smtp-Source: AGHT+IGA9KVp0puOt4h2PEtdTJnjUoz7/FbLrdCXbXHWqhpmq9LlrUUzxTwToOxHP6d61+DcWIyH/A==
X-Received: by 2002:a05:6214:20ca:b0:6e8:fb7e:d33a with SMTP id 6a1803df08f44-6eb3f2f9986mr98636946d6.22.1742649829552;
        Sat, 22 Mar 2025 06:23:49 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2600:4041:5be7:7c00:5ff:9758:a8dd:1917])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6f2sm21944596d6.116.2025.03.22.06.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 06:23:48 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 22 Mar 2025 09:23:36 -0400
Subject: [PATCH v4 01/11] scripts: generate_rust_analyzer.py: add missing
 whitespace
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-rust-analyzer-host-v4-1-1f51f9c907eb@gmail.com>
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


