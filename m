Return-Path: <linux-kernel+bounces-381090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1503A9AFA3B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4700F1C22C59
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C7E18E058;
	Fri, 25 Oct 2024 06:46:17 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E3518A95E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729838777; cv=none; b=DWWf9kIA9DSCLpa9Eg3qed+Sya5tzpkBL9thVmBQtAahJ7BzMADR5oBNTRPpNpuzdgd79mxXa7giM+x8gOl5YXL2Ki0xs/upU+z/eGPXpRONSC5AkibcS3GNZEoMpvag9F4HjqU0KZH+0qte6N/XKiPkc1LTLfU44tFLIqJDFZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729838777; c=relaxed/simple;
	bh=QkqW6s327z+ygsoSwPA1NUOQ5fAMZ5PTERwG1rLA0cU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BOv/ggEYk7+55565orJNkITlSG396NNeJmysJudNxqFv2tpDgZkRkgw2Ur3oo7h1kRQlCUowNpzQRLZoWW90Qhyp5JiOKAIKTISVn59AVCBpt4+uBqMzEPJYs0t9l6ZWjV2gkTXf92GQ9dl2wmq2IW6vQ55xEXr4Z3mbYHyqJhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53a0c160b94so2034754e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729838773; x=1730443573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gdq4o+Qshs6DiQxY0guUXC4Pj+i51VATb6fP1cxTPww=;
        b=bq5Nfezua1jmEXsVLnrF8qo8QuEQIQnfhIj4RMrDlnqChEZLka1FQgSGwbypCLmGCQ
         PRXsEfXqj3evxiIDq/c2CFL4kFSuDiwYzHyuzMqLSIZAF0w0BBJLl5JXvyjpl4cH4CX5
         9rvK8PRbHvfP/dWhckbZI6brbrKZMz5NbPr9HLgxIUl3Cm0UWaiKXkcwiFNH2X5sFs7w
         bck67RiykVNBBmAfNsy5q3DkP6rTPGYHUvnxrjcvGJiEzAyegjSJ5zB2+Ny74wsur4xR
         xp5VvGMkzLprAS6wSBCXC3TFbmM6OyKC8o43nb2nX5Y3Ww6aFBHh4MA1oBFhpkGwD6C5
         EP2g==
X-Forwarded-Encrypted: i=1; AJvYcCUelIEd9kQvulbk2Ze5+i08a4WK80fw34gM+LO6O1Sic0RXEnpPHPdtoaphluDV189gB1kWqMIdQ2naf6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvJ9PbMX5nw0b61tEBihJ1+d69iOYJMvR0X0iW16mtdxpxlYn
	c3iU+VLWcy9R18XGFfs2mBfl8xVe+ehN6fbnkNTD+c+vngkv+k87
X-Google-Smtp-Source: AGHT+IHRnvptD1sNXaUetBs9gaGaAfrFp3hQpM1OVFXg32yqY0LRu8gUB7PSshEV6CdGgy1uuzChug==
X-Received: by 2002:a05:6512:a93:b0:539:ccfd:8f36 with SMTP id 2adb3069b0e04-53b1a310742mr4873763e87.28.1729838772880;
        Thu, 24 Oct 2024 23:46:12 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43193595baesm8762645e9.17.2024.10.24.23.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:46:12 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	=?UTF-8?q?Ren=C3=A9=20Nyffenegger?= <mail@renenyffenegger.ch>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/tags.sh: use list of identifiers to ignore
Date: Fri, 25 Oct 2024 09:45:30 +0300
Message-ID: <20241025064536.3022849-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Literal string of ctags arguments is too long and overloaded.

Replace it with neat bash list.

Identifiers are sorted, and those with a new first
letter start on a new line for better maintainability.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 scripts/tags.sh | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/scripts/tags.sh b/scripts/tags.sh
index 994245ef540a..db7972b6109e 100755
--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -257,19 +257,29 @@ exuberant()
 	    CTAGS_EXTRA="extras"
 	fi
 	setup_regex exuberant asm c
-	all_target_sources | xargs $1 -a                        \
-	-I __initdata,__exitdata,__initconst,__ro_after_init	\
-	-I __initdata_memblock					\
-	-I __refdata,__attribute,__maybe_unused,__always_unused \
-	-I __acquires,__releases,__deprecated,__always_inline	\
-	-I __read_mostly,__aligned,____cacheline_aligned        \
-	-I ____cacheline_aligned_in_smp                         \
-	-I __cacheline_aligned,__cacheline_aligned_in_smp	\
-	-I ____cacheline_internodealigned_in_smp                \
-	-I __used,__packed,__packed2__,__must_check,__must_hold	\
-	-I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL,ACPI_EXPORT_SYMBOL   \
-	-I DEFINE_TRACE,EXPORT_TRACEPOINT_SYMBOL,EXPORT_TRACEPOINT_SYMBOL_GPL \
-	-I static,const						\
+	# identifiers to ignore by ctags
+	local ign=(
+		ACPI_EXPORT_SYMBOL
+		DEFINE_TRACE
+		EXPORT_SYMBOL EXPORT_SYMBOL_GPL
+		EXPORT_TRACEPOINT_SYMBOL EXPORT_TRACEPOINT_SYMBOL_GPL
+		____cacheline_aligned ____cacheline_aligned_in_smp
+		____cacheline_internodealigned_in_smp
+		__acquires __aligned __always_inline __always_unused
+		__attribute
+		__cacheline_aligned __cacheline_aligned_in_smp
+		__deprecated
+		__exitdata
+		__initconst __initdata __initdata_memblock
+		__maybe_unused __must_check __must_hold
+		__packed __packed2__
+		__read_mostly __refdata __releases __ro_after_init
+		__used
+		const
+		static
+	)
+	all_target_sources | \
+	xargs $1 -a -I "$(IFS=','; echo "${ign[*]}")" \
 	--$CTAGS_EXTRA=+fq --c-kinds=+px --fields=+iaS --langmap=c:+.h \
 	"${regex[@]}"
 
-- 
2.47.0


