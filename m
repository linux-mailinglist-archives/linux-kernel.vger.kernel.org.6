Return-Path: <linux-kernel+bounces-514909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0903A35D38
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C526018865CF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8A263C65;
	Fri, 14 Feb 2025 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTJKRePl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4015625C6FD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534280; cv=none; b=nVNiDBX03XsHRhHJIqnXlfCOhOS7Qul6Iaz1vKkWZcBgJq/cJyFVWOg2u2grOi6Z7HUNS3va9eJ7gbVQic6gAHI6Hsq2JM9cPDqlH9ad9ArJktTjgil+TiQEKSzBJb/bZ5TRxzn0TlPkxKAEeni6o45mCELl2nGkRIO/kY+uHK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534280; c=relaxed/simple;
	bh=4GEF/jUnMIA9bG7IkLYtiOpL+02Vd2ZnJPoZcE3ddVY=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=b5/QG5BQYQ15tIvV2zvm56MgSXYRBXGKWPYeMJE4lx/0F4I0cOC12Ywn/RHac7ETTydRBEiPvrQxqILlWPS9KP1Xx9wOuznIJOMKT00vEcbrTAzcynDLQyacpjlnID9O8p5SwtxDkOirQFt6NyCFrMn3/fvxCA1G2Wh43YX5Cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTJKRePl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220f4dd756eso6793705ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739534278; x=1740139078; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X721XEsLg6ExWO6tbi7bwwjJLWMrOT7ilwqqiFNpjQA=;
        b=TTJKRePlhjgne85ANepGBhSwp6eLflu5/F1QvJX7rPdJChfcUARlCr2v4QGm5jRDi1
         bnIfZ+grwxlWI701rab/idZKYKmbgBFpGF05dqvufRLWBmvDCMtkiiLzXYws9Wmau9jO
         036wKsQxJq1GG/v3vcPd4FqaeWEVQ9naXICs86iV6W2xh6iPRdyaJi86cDXy+VoXIWd1
         Dr12+iu07pb94VYnd0eM4b9n566STBvd3FyMZx4fQGIYfkX6dBtFwW9uTBn2kbBROWlP
         pWXOwo8OMsKKuANZDrQJrQsO8JW5Mp0dSBx/KTIHAQLAEUrwJsUCzJu1RHNtVtytJBmD
         11iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739534278; x=1740139078;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X721XEsLg6ExWO6tbi7bwwjJLWMrOT7ilwqqiFNpjQA=;
        b=RCCIYghByYtCobust/pK29d3vwj1FRICXdlM48NC/326Ccij57GK9iiHLaEtRQ3rFc
         V8Uzgv0F84f4M8L/TRRqR0mHarTPjqjzQPyOwe2xsn6Dbr9MApt88gnPqv9jx5ZD+cwp
         NPidnYrH6BpxeDj8Th1HJ2SkBx3ekvXJKCEcfvri7j9dyOWG6Ie5Z55MlGMnfrgBOMJt
         +ApoitPSCd5GqcOPOf6RB/BF/iDwSiu4IAW2QjPyG/rlMEoqKXgq0cF1aZYmvEK2QHGm
         uzcvcfa2CfFeLH8s1iHMbV+hw1tF01Tusr2E9KfK3kNUtYVlO+aNdKvYPkL/xEfKU74Y
         kSUA==
X-Gm-Message-State: AOJu0Yx7Joo5mY+JvQoJlR7dUT/rD2TRj7aCgwUdlfHmjbIsFUTxc72D
	to2O3rqaV7lwFCrQHJvy13b5u9c7A9DGnsrBMFuJx/r56dqUTa/f
X-Gm-Gg: ASbGncu1cfEvjpRW6XUGRTk+ZVTvQML4V1IBjmfjWL5A1NKlu1TeKrfpfE06KRbOXos
	zVhHzolH5N5tYLqyImMwj3okZ51MhQEvSJ3FzkfoAWzIydQpmf04Ik5sVckuiupWhU0kqE1CQLo
	blKyiPSDMnHzr67/xuAtkEyPReyeaKv8ReDKgZSy0tJNIVCD5ZQ6TCwNKqKfQskDse0/662FNcm
	0GzsO0NmLS5MfVHR9ZgkQTw8G62uMOzaWp7i4qpsw3SVvxn0ocCJA/WdOgkbdMxGupyccYV5roh
	0cvJI7ZpKTVbkvmt9N95tXiYudqiqSYSym+8aPi4/StSHfGyghsi2s2C9RHFGVWAd3phtQ==
X-Google-Smtp-Source: AGHT+IGk75nsq0xJURpguHuNehaYujjCzZ7rN5CG1OHwesP3kZFKeKokC9/9W8DcTEbTcXHxCLoJsw==
X-Received: by 2002:a05:6a21:730a:b0:1e0:d380:fe66 with SMTP id adf61e73a8af0-1ee6b18c9damr14253189637.0.1739534278425;
        Fri, 14 Feb 2025 03:57:58 -0800 (PST)
Received: from ?IPv6:2001:8003:4a28:1700:781a:db22:adcc:4c9a? ([2001:8003:4a28:1700:781a:db22:adcc:4c9a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e2fesm2944076b3a.118.2025.02.14.03.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:57:58 -0800 (PST)
Message-ID: <3785d2b4e561eef5b3b0e6dc0ef07ebf349eaadd.camel@gmail.com>
Subject: [PATCH] power: Changed CMP_THREADS from hardwired value to
 configurable value
From: Jay Penny <hills.a.joel@gmail.com>
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2025 22:57:54 +1100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From a873292405b37921d6a7428a7e9263f662e957cf Mon Sep 17 00:00:00 2001
From: Jay Penny <hills.a.joel@gmail.com>
Date: Fri, 14 Feb 2025 22:27:39 +1100
Subject: [PATCH] power: Changed CMP_THREADS from hardwired value to
 configurable value

I don't know what the rules are (unspoken or otherwise) for stating
that this is your patch - The CoC doesn't say anything regarding it,
so I'm just going to mention it here. This is my first kernel patch,
so if I mess something up, it's due to a lack of experience on my part.

Changed CMP_THREADS in kernel/power/swap.c from a hardwired 3 threads,
to a configurable one, and created a corresponding config option in
kernel/power/Kconfig.

The fact that this is such a simple change that hasn't been made yet
probably means that it shouldn't be made. That, or I'm just being
pessimistic.

Signed-off-by: Jay Penny <hills.a.joel@gmail.com>
---
 kernel/power/Kconfig | 13 +++++++++++++
 kernel/power/swap.c  |  2 +-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ca947ed32e3d..432e75c76c49 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -80,6 +80,19 @@ config HIBERNATION
=20
 	  For more information take a look at
<file:Documentation/power/swsusp.rst>.
=20
+config HIBERNATION_THREADS
+	int "Hibernation threads"
+	depends on HIBERNATION
+	range 1 65535
+	default 3
+	help
+	  The maximum number of threads that should be used when
+	  compressing/decompressing a hibernation image. The number
+	  of threads used is calculated as:
+	  clamp(num_online_cpus() - 1, 1, HIBERNATION_THREADS).
+
+	  If in doubt, leave at the default of 3
+
 config HIBERNATION_SNAPSHOT_DEV
 	bool "Userspace snapshot device"
 	depends on HIBERNATION
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 82b884b67152..6ac787f8421a 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -534,7 +534,7 @@ static int swap_writer_finish(struct
swap_map_handle *handle,
 #define CMP_SIZE	(CMP_PAGES * PAGE_SIZE)
=20
 /* Maximum number of threads for compression/decompression. */
-#define CMP_THREADS	3
+#define CMP_THREADS	CONFIG_HIBERNATION_THREADS
=20
 /* Minimum/maximum number of pages for read buffering. */
 #define CMP_MIN_RD_PAGES	1024
--=20
2.48.1



