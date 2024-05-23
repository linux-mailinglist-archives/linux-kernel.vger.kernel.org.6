Return-Path: <linux-kernel+bounces-186872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6CD8CCA37
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 03:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A4521C21544
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 01:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DB81879;
	Thu, 23 May 2024 01:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOdGwzxn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B278475
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716426227; cv=none; b=n8mQu/dYVpHdSKco573N7T9gORisvg+MjX0IWF7gLnNvONnxn8hVAXeauZIWyO5h7PpwFTVyG1x1NAxJc15NewNxQZfpV/A0maO/vRbqHcvQynQcgC3/RTqwDR/RrTGw8HCzpS1fQaarnmHts6uS/d4s9KFZEdixUziWO/PtsCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716426227; c=relaxed/simple;
	bh=oRLFCvmflvwBww972OTFC19rqZZLX6S+rVQ/YdgGPpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsPEEB0+CXO9MNVRofp6jJpMs0dq7TzOo9wVdAhoGsTyWK5jeQwHZQD5VLH+DI5RuUkGdRCQiyyMN3kQrNGk/WwwT/f9k7cuE3ioGpX0Ye67Qf60UKDt0o5TJ82ktpPGm5yPgu3+ZmfOSl6aBlEzoSaeTC2IvfK7heYZL4hdY+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOdGwzxn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f472d550cbso2798887b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716426225; x=1717031025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs+GelHIEijGi4ASLZuiiYf2bpnmCXxrjtSTxKMeS2w=;
        b=NOdGwzxnib2kvRoVVHQ9XpTgibhM6H68Hfis6Yur3Ea8RmOEjasEp25+Eq7HKRsfh3
         uaBXbBdPM3uH/huytSVyJQCS0jUVj3gOqM+97sb3VvcxafegFw25cY7KKgy3/AeHtuXE
         43qq3BuGAJ5LjDfcolZzeP/hz4ipCbd+CgKipDZMzijj9xXUAUFzlETZY0UI4jBTK4BY
         TRztcrxZ/a2cdIQ60Kfyi7zpttQ+T88o21l/jhLCN/f2BrCIxuOaPHjiz+SmvCkucUrW
         xYcZYbE4W08RosUSIBx/nddUcvpnD44x1GWx5B3JXLE9CyOP0VBqOFEjvdWcUi2g6e84
         Lmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716426225; x=1717031025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs+GelHIEijGi4ASLZuiiYf2bpnmCXxrjtSTxKMeS2w=;
        b=CwrqA5VcxAga3IUDVvu0Clq6fFgUYgi6tAYkEgWw1G2jjVg4mdAwJx2DEkTuETPrrs
         JfVqm0bcBzxD6/n1bApd/hgW00S8Xd2CJghYF04xEf9Z4qSjvti3wlsDR0kxoTXOqRcO
         Wxwxldu6vd0rmuu5B/w4fC1y3m8bssNNRh0HgBlglysVi0biM/CFx5Z//KY6tNHm1l8o
         vzbs+L3oE7kM4rNqgU6MrnBk0Er+sz7lZFARUkfFPcXPJpW/4EBb6yo+2SmHikizXkNq
         lux/igwlbp0l0p7QgRCYXZ09NpWTaRoeQd0fIR5TrUXiznz6fJIrjBrXMCNUwx2sGxxR
         ukrQ==
X-Gm-Message-State: AOJu0YxDpIEMSRyp+RlvUBWtsGKyhDnt2VXpknHbui9qtebnDDNmvUjU
	7ic7A/rwG9kvzu/FFTqNjNiLHsq4Ihy/54mz9Bfd3wInt/5BoCTbuWWoKOZBmMc=
X-Google-Smtp-Source: AGHT+IHzcSzrJQ58UIebX/BC+P9BTbbI9t8qhP7hIV00n0wXMGOYcyc2bRo97KfomeOSa09dxJSQrA==
X-Received: by 2002:a05:6a21:498e:b0:1b1:c745:ea2c with SMTP id adf61e73a8af0-1b1f8a84b60mr4048645637.56.1716426225093;
        Wed, 22 May 2024 18:03:45 -0700 (PDT)
Received: from localhost.localdomain ([111.196.74.188])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0b9d4828sm244348265ad.20.2024.05.22.18.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 18:03:44 -0700 (PDT)
From: Xiong Nandi <xndchn@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com,
	cmllamas@google.com,
	quic_eberman@quicinc.com,
	Xiong Nandi <xndchn@gmail.com>
Subject: [PATCH v2 2/2] scripts/decode_stacktrace.sh: better support to ARM32 module stack trace
Date: Thu, 23 May 2024 09:03:18 +0800
Message-Id: <20240523010318.12934-3-xndchn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240523010318.12934-1-xndchn@gmail.com>
References: <20240521194010043-0700.eberman@hu-eberman-lv.qualcomm.com>
 <20240523010318.12934-1-xndchn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes there is special characters around module name in stack trace,
such as ARM32 with BACKTRACE_VERBOSE in "(%pS)" format, such as:
[<806e4845>] (dump_stack_lvl) from [<7f806013>] (hello_init+0x13/0x1000 [test])

After stripping other characters around "[module]", it can be finally decoded:
(dump_stack_lvl) from hello_init (/foo/test.c:10) test

Signed-off-by: Xiong Nandi <xndchn@gmail.com>
---
 scripts/decode_stacktrace.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 2bc3a54ffba5..324e4a6c260a 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -283,8 +283,8 @@ handle_line() {
 
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


