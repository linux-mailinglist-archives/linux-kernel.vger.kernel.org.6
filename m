Return-Path: <linux-kernel+bounces-439416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5129EAEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264DC169755
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686711DC985;
	Tue, 10 Dec 2024 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNrwsugp"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12F78F47;
	Tue, 10 Dec 2024 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733828660; cv=none; b=ulca3u7D82ikrLOshDkl5JqcB41grrx4o4/dcqHindajqkfNd5HZpmp7N71mj64LXpcX1bvrhf0wZNaVsIS7ZPOo7YvqiwuwHNgQAKducl0zRovF4hkCmcCHsrH2CSC2P7sggBa04MAkYExJpVtuIpCOSdt4Xadqpd47qZydvXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733828660; c=relaxed/simple;
	bh=FU67rLrViZPdR8qhmmKTXQUYgujidzzYPHnHn8k9EMc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=TV2KBID+FvwalUvwzMN8A0lhwKOTK6lclIk78OXeW7m0/8cYj515CAae9ax0WyoT75ObonjBz2dbpVORZoj1ECPgpFAUYKOmJnDpcHiHzYeBjkH7f1VIBvxUxbPvYgMSBvM2n4gk/QfwngN6ekQ81s542DdCLKLW1z1H5f/Kj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNrwsugp; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso3309344b3a.0;
        Tue, 10 Dec 2024 03:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733828659; x=1734433459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d53c0Q7cNW97XGoMSTKLDLwhm+ZDEx0sfAqw8S7aAq4=;
        b=BNrwsugpxdpFk9AKGgIoy8xLuHVJZCPuVKduRKb5sueyT6Kit4tJaTzHEbBjWAMCEa
         PdE55bdE3lk+p5ocJF4S6nNFP7pO2ZztAHKJGF1pPKNfTGcDVvx9EUrLHKBMPX4hMhEM
         KJnKQ18TXJXd8Eh4vA9AJ4xhj9ri/SAhLXVtmhr7tC6R3hyMTZ3kqEHw8Bup8zgXrxTY
         vSi6EUkQPfjmyPeviD7WGkBqOvv2GQjxGuvF4pqwTPx/jisElehjfqfvHe4EahANO9Ry
         74B4FYxsKke89gH+nzMrQNZXPbWMshZhctCecFpqGNReg3Nv41moATkVQkRbkTZ1Ia5Y
         9OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733828659; x=1734433459;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d53c0Q7cNW97XGoMSTKLDLwhm+ZDEx0sfAqw8S7aAq4=;
        b=Xj1Wil4X6UoobyvYGcSM97St+rpZ8NKwGlS8ePrKUyAaMihra3K8upW9XUG1vfiOCb
         hXbJWhBhQ1e46xraj7+SaCQB8jK/4knpaGNJDpW+4XKfINJnwFav8sFBR8oxhPRroMIn
         pRXVgw48smy6MiJRFaPtkjsENajP8iPqXNufrTBec09fJsDrHelA/9331vyleZj3UPpK
         2gGng6cQkq5VgwO5JXJbxNGl/mgHb2OYcw/4kFBAs+va0BZbYLdnMahqtKDFw1b+rhbv
         0iJZwDAa2BldHROLoqW+mOqrlo8oHH4zMcQ6MFAZu7JfkzjziKaKfe5o1JawGGnnVHsq
         VjXA==
X-Forwarded-Encrypted: i=1; AJvYcCV27N9kbZKE7PY/Gb9wtTIYuQ6rPv8Mu1GOKgSC0OGc3UNj3F0gLR5d61yWOiE4p+NB0lDJA0t04u80o88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cw0/Dup3sJIztoj9rBgFfzupjjlBjcr131wrWTIERhHZBUKA
	GDu9fEzqUFsU14gWKkYPxn4tfs240TWuhC0n8e59E8qg1qoYOtcW
X-Gm-Gg: ASbGncvWk+aByznWjMm/UE8olJPNfk5I4ctpupmRGOmylrbHWguU5AlPWB6GEGUAHw0
	gsCt07dFUxhdRyvAAfdP5+fpG3dJ7iuXTRDv+hedhGbpkrM7aHoHW/kpt5T6Yovxv9gIAZEJQTt
	GxH8bmaJsTa0UHoN9CNHICGSot7ctcYoy1igHpPH0nxVeooWpP3Za4hPx0gYnqGh2Khur72RWig
	ZZT2ySlKjbB6S3x8wu1uvXUKaFD3zjWAUhwe0qBxmbpBl4qiup9J9HnlGzQ1diJ4eqENl6PxqG6
	BOFciKKzrEeUscbd+2bO
X-Google-Smtp-Source: AGHT+IHiq76zZeabk5JBiqlxqVtJh6w677/EJMhuF87IpvjsfK2g86Eal5qMcqbdAM/t8J0FQTTuUw==
X-Received: by 2002:a05:6a20:3d82:b0:1e1:a434:2964 with SMTP id adf61e73a8af0-1e1b1a71ad5mr6301486637.2.1733828658547;
        Tue, 10 Dec 2024 03:04:18 -0800 (PST)
Received: from [10.0.2.15] (KD106167137155.ppp-bb.dion.ne.jp. [106.167.137.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157d79e5sm8892284a12.75.2024.12.10.03.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:04:18 -0800 (PST)
Message-ID: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
Date: Tue, 10 Dec 2024 20:04:15 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>
From: Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] scripts/kernel-doc: Get -export option working again
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since commit cdd30ebb1b9f ("module: Convert symbol namespace to string
literal"), exported symbols marked by EXPORT_SYMBOL_NS(_GPL) are
ignored by "kernel-doc -export" in fresh build of "make htmldocs".

This is because regex in the perl script for those markers fails to
match the new signatures:

  - EXPORT_SYMBOL_NS(symbol, "ns");
  - EXPORT_SYMBOL_NS_GPL(symbol, "ns");

Update the regex so that it matches quoted string.

Note: Escape sequence of \w is good for C identifiers, but can be
too strict for quoted strings.  Instead, use \S, which matches any
non-whitespace character, for compatibility with possible extension
of namespace convention in the future [1].

Fixes: cdd30ebb1b9f ("module: Convert symbol namespace to string literal")
Link: https://lore.kernel.org/CAK7LNATMufXP0EA6QUE9hBkZMa6vJO6ZiaYuak2AhOrd2nSVKQ@mail.gmail.com/ [1]
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
---
This fixes regression in v6.13-rc2.

Quick reproducer:

    ./script/kernel-doc -rst -export drivers/iommu/iommufd/device.c

On v6.13-rc2, kernel-doc will say:

     drivers/iommu/iommufd/device.c:1: warning: no structured comments found

With this patch applied, you'll get reST formatted kernel-doc comments. 

Akira
 
---
 scripts/kernel-doc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f66070176ba3..4ee843d3600e 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -267,7 +267,7 @@ my $doc_inline_sect = '\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)';
 my $doc_inline_end = '^\s*\*/\s*$';
 my $doc_inline_oneline = '^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$';
 my $export_symbol = '^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*;';
-my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*\w+\)\s*;';
+my $export_symbol_ns = '^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*;';
 my $function_pointer = qr{([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)};
 my $attribute = qr{__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)}i;
 

base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.34.1


