Return-Path: <linux-kernel+bounces-185647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 476798CB863
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB813B242A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D9EED8;
	Wed, 22 May 2024 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCeBkXo3"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B928FD
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339980; cv=none; b=mT8l9Aew4UKx6fMNtK5EQxcCVKAuriPvMoHoqlyRj7MkSwlIEUjYHk9BLlcOjtM6U1FOo4n8y7ZnyQKvpBl4jurJT0WrEmcXGzLzkvDcGwVZiB5KIlWoIxIs4vsTiIAmSWkRO3EHZxn5yZoSWwyFyiRZFSosaZ+8Qs2I6jYMgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339980; c=relaxed/simple;
	bh=J/OK9JoU/P4aXrA7FZp1yntoZLeQUivL/F3j6wQQf6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQDWzVbq3geWtD1nOFFKCNCT9dyE7IvQ1T+mJYJbaK/cZqQO64WJrwMScp3o912ixdKsXKVuvhKRTjeBiCVT7YVsWRaYZfiHnVtD5tnkHI8H+n+o6bfKQS9o4wp60SUJ/IujPzVRjRZo6lGc+yfxnIW7+W/yuEUZFfzD1+ukC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCeBkXo3; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3713ff97cf5so4805505ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716339978; x=1716944778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QRoVunXuTL7aJsorGhwdMs/cGyNJtncIxhrxIr+CyQ=;
        b=hCeBkXo3hia4/kt3mIUHyM2NLjxBtDrgx2b+wtHTwlwbI+1QG7LL2FJpX2tJJGrPjX
         YXvVKStZ6eN5hB9VE+UfHjAS5M8HoB2IRzOGxIbyLslSoTOF8IlPP1l3CdiJLs2XZRNH
         CKo9ofqNSBknOHmNhSN28eWyufAspiiEVeopUn1ol/yFWDkdSlEYtWAgHjbB0NnasSpt
         vYm5cCmatjsCsTRz581Rx8JufioQxncLAX2TSDxg/9pU5rSdf2k2EsvW8h7PC6I2hh3l
         nY4W7Ds1NOpUCL6+THsAwfZ2liKZrzrawJN3AQWWGbm2DHXuV0wDne9Fl8kj3zcTkO+H
         9z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339978; x=1716944778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QRoVunXuTL7aJsorGhwdMs/cGyNJtncIxhrxIr+CyQ=;
        b=FM3m7XwXnY1MSF0VLsp02Bzme4+E/GCIoIzZRaxYAcvPdzokhOvOgYeKj8jsrv3SGM
         5B4Eq2lShHBXsAYIQWwElgeRSqym/mstDwgULaZB7/fKq672yr6xOxXNr9kPptuEEnwH
         L8PW6kRWtTtsULe/GGHOyj7gjZ1Ah6ZdgMmhNUaVq5mMI9U8sPaJKi57/P42lNw6z2To
         MxvucsXtKwfrLB4w6wJuhgm8d7QPOCsHPvtf+jr/f46ulJEKvhr7YB1As4Q37mga3eKe
         Rh9R2aiQdu3XyJF+pDYQn6NOq6yyVNRsKJYIQtt6PiaymV8IRQHfSyyHWO7QuTKlslBV
         F13A==
X-Gm-Message-State: AOJu0YyXg4MicgtZ71UUPRfNqdF4+HtoAuk+r2fFBSwjc+1Q+9a9Mgpq
	3A7k7x0TnS15laZQ+t2JUt8M9xtyrcHR3qRIERblNSL55rwQijIf
X-Google-Smtp-Source: AGHT+IE1IwwFQEw+aG+KNJqb4DFSXGzdgrDNKnnZsN0lwEXDd5LRtVesMV1crJFYZ7n3nJFWPuaLfQ==
X-Received: by 2002:a05:6e02:1a8b:b0:36a:ed0:ca0d with SMTP id e9e14a558f8ab-371fc8d255fmr6363235ab.25.1716339977880;
        Tue, 21 May 2024 18:06:17 -0700 (PDT)
Received: from localhost.localdomain ([111.196.74.188])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f4fa8db6a2sm18065112b3a.177.2024.05.21.18.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 18:06:17 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: better support to ARM32 module stack trace
Date: Wed, 22 May 2024 09:05:59 +0800
Message-Id: <20240522010559.10551-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521005649.12144-1-xndchn@gmail.com>
References: <20240521005649.12144-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry about the name, it is some kind of abbreviation. So I re-post here:
---
Since System.map is generated by cross-compile nm tool, we should use it
here too. Otherwise host nm may not recognize thumb2 function address well.

Beside, sometimes special characters around module name, such as ARM32
with BACKTRACE_VERBOSE in "(%pS)" format, such as:
[<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000 [test])

After stripping other characters around "[module]", it can be finally decoded:
(dump_stack_lvl) from hello_init (/foo/test.c:10) test

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 scripts/decode_stacktrace.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa5be6f57b00..324e4a6c260a 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -30,6 +30,7 @@ fi
 
 READELF=${UTIL_PREFIX}readelf${UTIL_SUFFIX}
 ADDR2LINE=${UTIL_PREFIX}addr2line${UTIL_SUFFIX}
+NM=${UTIL_PREFIX}nm${UTIL_SUFFIX}
 
 if [[ $1 == "-r" ]] ; then
 	vmlinux=""
@@ -158,7 +159,7 @@ parse_symbol() {
 	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
-		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
+		local base_addr=$(${NM} "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
 		if [[ $base_addr == "" ]] ; then
 			# address not found
 			return
@@ -282,8 +283,8 @@ handle_line() {
 
 	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
 		module=${words[$last]}
-		module=${module#\[}
-		module=${module%\]}
+		module=${module#*\[}
+		module=${module%\]*}
 		modbuildid=${module#* }
 		module=${module% *}
 		if [[ $modbuildid == $module ]]; then
-- 
2.25.1


