Return-Path: <linux-kernel+bounces-184330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8940D8CA57D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 02:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888141C21C77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 00:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E5F6125;
	Tue, 21 May 2024 00:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwLYyvHN"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC09441F
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716253040; cv=none; b=VZoJWQh/6W8hKz5e7MUc98cdRfRr5++aJer6snKV7ahGUNT1MRI8wkO92/0HuIhezJc9hb8ucvcrtrZldLsb9PVMaZg0Cz2mUet7VUXOTSA79D9aL2L/Nd13IdvejZY6L47DB/e9fgpQVsN8WLP1U0mUSdZOA4sh+TOaqGcTGT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716253040; c=relaxed/simple;
	bh=Cgxg75j6kIz+dz4SnweGkimPEmjie9KLL5dqC1Cq1Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4CLv99Sl+B6ukWaZCDgFrvTGzajJjibkleoa88r+u+1a7WNNxWsuEXbq4JLI+Q3pVDNt929s64fz+BZq8wxn2wKvvwFgRvb+woLxOKGiUEos1Itix7D6Kj4Yxu4VuGDvhf71ZmT1x3ZvYbmCDFVJMyb2S9F2Btr2fZTn6m5WYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwLYyvHN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1ed835f3c3cso25504715ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716253038; x=1716857838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNgzHdf48+UJHMZZhQ47WggE7eEoK6YQ70zn/rTT92o=;
        b=jwLYyvHNPRib/Vbr65/hz0sddk+pvhfWE0S5LW43/rev6ndf6t0cLISbLO6wgo+Ci6
         D39xe1I6UEtbOuA/tlBmXCAzdDvbiQcUn6kmmK+VAa0j/ASbUP61JflInRKSnx36MATE
         ovitbJfIvLIavAyqhAdeRYEnXibLT11mO1L4u6SKNt95aWiGV03b4kOfAUJZ78O9JAVR
         gyp2PZWBN8e2GIn6AQSi9ESQZQ4RiWzIv1ZGnVMOvThysBIJP+AVYTnXiqNVtw+uUSf8
         989FN+0FC0hoEDzKaEtzA0wc6OqtgAtxIeaRKYonGUZ97aBdU7R8vnMAnShuNOHHI7R+
         znfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716253038; x=1716857838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNgzHdf48+UJHMZZhQ47WggE7eEoK6YQ70zn/rTT92o=;
        b=MHE8d5KwlvptksjYodiFfypqHne+iUxJpFB0llLIkA4oLWqzl5DR3vnbXIWTIIOr3N
         PVBZ56M0vn8Iu3dhpJxCgS0xqrhFx6JVRiAGugSzvVUXAmAIGdt+KRWWgFUesTbwDvWV
         /7emRNolEvF21ow3IGDo9WcEvySSdoXImSSEpi4/skTbpMZ85/6Md3HFsX/GeXZl/PXi
         QZnBuxPJP7g3jgN5X3dWQm0IngbhBJeqxXB8Sr5hUXQ3m7wEayz4PDU5QKLPP/hc0JN9
         mBMn7u/1i0z7wIKQlG+ZDC4LFDEnEUqSp64oxCEYHbxL/XC9lW7M3tBYbqyXQeaTrzKy
         FsCQ==
X-Gm-Message-State: AOJu0YyHEHhi4TbJIEOrUigbVAhs98QI0+79ZqzDRmV8sR/yfIXaFDd3
	evoxu4EKgaewpdxCAL0Anf01FAAqliy+zpON792cwnzC8BJl356TeU1BXMT6
X-Google-Smtp-Source: AGHT+IFXNYNm8TudLT2nexi/phlgDQmtnxV9t9jfmPF3iC//oGPPqLRZ88B4cczH10eZqiDVT0c0vg==
X-Received: by 2002:a05:6a00:2191:b0:6e6:843f:1d05 with SMTP id d2e1a72fcca58-6f4e02f6050mr38784877b3a.25.1716253038139;
        Mon, 20 May 2024 17:57:18 -0700 (PDT)
Received: from localhost.localdomain ([111.196.74.188])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-6340b76e262sm17463870a12.35.2024.05.20.17.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 17:57:17 -0700 (PDT)
From: xndcn <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	xndcn <xndchn@gmail.com>
Subject: [PATCH] scripts/decode_stacktrace.sh: better support to ARM32 module stack trace
Date: Tue, 21 May 2024 08:56:49 +0800
Message-Id: <20240521005649.12144-1-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since System.map is generated by cross-compile nm tool, we should use it
here too. Otherwise host nm may not recognize thumb2 function address well.

Beside, sometimes special characters around module name, such as ARM32
with BACKTRACE_VERBOSE in "(%pS)" format, such as:
[<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000 [test])

After stripping other characters around "[module]", it can be finally decoded:
(dump_stack_lvl) from hello_init (/foo/test.c:10) test

Signed-off-by: xndcn <xndchn@gmail.com>
---
 scripts/decode_stacktrace.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index fa5be6f57b0..324e4a6c260 100755
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


