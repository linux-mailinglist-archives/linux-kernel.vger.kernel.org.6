Return-Path: <linux-kernel+bounces-424298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC829DB2BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7CB7B21CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E471459F6;
	Thu, 28 Nov 2024 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQKWxYAf"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2491FAA;
	Thu, 28 Nov 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732774679; cv=none; b=gMO4VHO9fvZB7DNQndNWQjBXkuqdUvAbmGEvnZDTA0vw6EdYfaclnFiarX4qyd+m2YXdBSY5f5xnxxqyFDpZg7JdqGwbzBYW6bSSwdsEt7gQDVKlEr5P3yjAchCGQcoo2FbEyPdnraGmAMM/k8DFdBqmOM7dV4ApX/cP+9Oql3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732774679; c=relaxed/simple;
	bh=W2QYBqcJ8gQRsDuV9ugDhc03k7g4zaU68kwFBvZDArs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PNuDi/uR4TlVY8RZd+9x5SZnfYXlBaj8d4M4zIT/jlyXp4DkRB6K5yIuIxZxbkpeN7U+UHRvpEly8pchSPs12TIqbbZ+Y96IMg5FElCbT/1l9jsJWrhXmH5RcTJ7FaG2sPUuxPEp8HgEyTy2X33RIm9EV5pzI9ezGXB35/OToZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQKWxYAf; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7fbc29b3145so1212598a12.0;
        Wed, 27 Nov 2024 22:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732774677; x=1733379477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O7TEqs3CaJIZ8ZSMvw22hlhssJfAbI/Q1CZi5Dk7eio=;
        b=JQKWxYAfPndNnM7yQ5A2OR8/HQxMTRs9ocZFztJHfZ+GrwwR305rc4YywCAptFEQPe
         voiClR/YQUqTxGsHnNNNuNxFCLIr/pgup7wIsu+Uo3VdbSTo0QiKZibFIpgyp0B/DCPu
         RNCpcKfCKlFYiJIVAs5iRQvO6KGpdgJF6S7hHH3wMiO2ZwERCa6k+6PvP2IvvJIxC+8T
         wL04m38J7nTQt4/DgO/LMNAHy5Fsc6U/WNFlovbbJ62MZDmrdIrTz2KBbxYHSuB+hhNZ
         KrAp70NPFoxKmVR3Hoc2lOVINu+n73SvXgQB86TXyFLIsz24WNqjPoL89jy/h0xo3h2Z
         Qwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732774677; x=1733379477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O7TEqs3CaJIZ8ZSMvw22hlhssJfAbI/Q1CZi5Dk7eio=;
        b=c4M5p1XeehnFQYGMwPQRGBCJic4siZ2/71XABNqX+kKF2vPxaQBcauv4Ux/ofSJkFS
         CwHsz/P7OX3+4oHAimIklpjcqWRyUJuSjVb9SSvlbHjHy5ZFuAE1uF0saECdOvpSVHNy
         uHNSP8SxBM39jAuykKbPaGEroOVlT+yyoQocvspQG8u45Ym3+q7e9zDFieFuonO3pikz
         wAEo6r5xZQgOo1Vpj+g/0RVyHpAvlAo8esxS2YUkgSEChgWUcXA9Q0sM3+vCW8CpjmRO
         mZVT2BHeLXjiYQP5bRdKsbpbYX8R6awRKRMze8VvDuoAkSIntiA2uIcOH+mIUxhR/rm+
         6jvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLDu12myv7aBf1rWwGkgcYS5Q36oapQ3gxA6jcSrTEPq7v/CQzLY6RgYQSPMsCy1TxRveOn1UAlW0=@vger.kernel.org, AJvYcCXxHtf0IxdL05OPAUirAFZuhYy9nRiQDETrKRxs8vG966JmmoIzO2XqSNDXRHlcmwTLb55zyk6XVugm4dDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxicI5VW9LcBvwKcO4590xbtpkOzozE2UUKwOeQygDDI7jBQVzF
	DP3whJ9JF9hSab7a5uaDTWnCCz15fGMO+WLJmfc24KblPAXoK7ib
X-Gm-Gg: ASbGnctO/zIPwPVI1G76Ri3cnYroNNRlX20/ydLGupIvKFIs4Hqv6IBuvsvuMEODxj1
	U8bgxApm3Lb7PljQvQ4cl45K8xxl71Mu2LujXJ+TwukHGiY5nDEg4e0CA9tYE3zF2BKKCLOrxM+
	LgH2vNB6WqKXaITPDGEhRcL7F0bi86Z3Z0QT4lXRJfpY2Vb6aHxnNsmu5a84x1M03lEuWbURixy
	CLS/n/RtBZl6AeJzFdq3/3tLE6fFNT016uL8jQ3Npqh5OzY3uQFyovEMOvCZFBHqRW854Ikfw==
X-Google-Smtp-Source: AGHT+IGpz5MlizxFyFGulh60WFsE0eWiwBGqmOGC3O2KfxUki6dboBrdAc4EaOU1dW0y9pR1y0NYVw==
X-Received: by 2002:a05:6a21:33a6:b0:1e0:c77c:4516 with SMTP id adf61e73a8af0-1e0ec8c5237mr3609910637.17.1732774677248;
        Wed, 27 Nov 2024 22:17:57 -0800 (PST)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2e6e79sm557720a12.25.2024.11.27.22.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 22:17:56 -0800 (PST)
From: Guo Weikang <guoweikang.kernel@gmail.com>
To: brian.haley@hp.com,
	davem@davemloft.net,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>
Cc: Guo Weikang <guoweikang.kernel@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/ipv6: Fix missing MODULE_PARAM_PREFIX in ipv6 parameters
Date: Thu, 28 Nov 2024 14:17:38 +0800
Message-Id: <20241128061743.747624-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation for some IPv6 kernel parameters (in
Documentation/admin-guide/kernel-parameters.txt) was missing the
MODULE_PARAM_PREFIX. This could cause confusion during boot,
as parameters like "disable_ipv6" would trigger warnings such as:

    [    0.000000] Unknown kernel command line parameters
    "disable_ipv6=0", will be passed to user space.

This commit updates the documentation to include correct
MODULE_PARAM_PREFIX

Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
---
 .../admin-guide/kernel-parameters.txt          | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index dc663c0ca670..534db0ace5dd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -424,9 +424,6 @@
 			      useful so that a dump capture kernel won't be
 			      shot down by NMI
 
-	autoconf=	[IPV6]
-			See Documentation/networking/ipv6.rst.
-
 	apm=		[APM] Advanced Power Management
 			See header of arch/x86/kernel/apm_32.c.
 
@@ -1140,9 +1137,6 @@
 			can be useful when debugging issues that require an SLB
 			miss to occur.
 
-	disable=	[IPV6]
-			See Documentation/networking/ipv6.rst.
-
 	disable_radix	[PPC,EARLY]
 			Disable RADIX MMU mode on POWER9
 
@@ -1154,9 +1148,6 @@
 			Disable Dynamic DMA Window support. Use this
 			to workaround buggy firmware.
 
-	disable_ipv6=	[IPV6]
-			See Documentation/networking/ipv6.rst.
-
 	disable_mtrr_cleanup [X86,EARLY]
 			The kernel tries to adjust MTRR layout from continuous
 			to discrete, to make X server driver able to add WB
@@ -2387,6 +2378,15 @@
 			an audit event when a binary is allowed. The default
 			is 0.
 
+	ipv6.autoconf=	[IPV6]
+			See Documentation/networking/ipv6.rst.
+
+	ipv6.disable=	[IPV6]
+			See Documentation/networking/ipv6.rst.
+
+	ipv6.disable_ipv6=	[IPV6]
+			See Documentation/networking/ipv6.rst.
+
 	irqaffinity=	[SMP] Set the default irq affinity mask
 			The argument is a cpu list, as described above.
 
-- 
2.25.1


