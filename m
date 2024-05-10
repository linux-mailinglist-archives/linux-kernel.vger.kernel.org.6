Return-Path: <linux-kernel+bounces-175144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15CE8C1B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB30F2897DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB54413C3DF;
	Fri, 10 May 2024 00:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDr/juiT"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42013B58D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299885; cv=none; b=AwkgpfFelXmA8OYOM011iRqKgeiHhCs1fTxGeFUV22pe4QAkMZueEFZVoDHI+/2rMnVsUbvtaWmkWhz9im4ZADQ7n/VsRbZQmxcLkIRCfILJBLkSWNijDxIvi2dF+K/h00Iy+BXEzVp7+LZOEGlH+ycxbrGRV0pppCPJndbzeK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299885; c=relaxed/simple;
	bh=2Hd7RVO2oQyAycS+cMBSvHkXH+GbjR8gypYKXDXO3so=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sl3HU96h63wCPy0VEI5L3WXl11Kz7FIdec6K9Zz9yaV4yofcmUPtK4HGaopP1WUKZxqxizaf53Z/PCS8boF+Q8wZLuKVtnrgeki8DGJ1Xicmj+2fRdqvBv+r04dCON2pKUxrlOQGuTObMNSF0l11qsAnSTA4h4G3TRPjOUOILaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDr/juiT; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b6209f5246so1427807a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299884; x=1715904684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhc5ZT51Bf+X0xh3itiryFkYQiK1VIkMBG+josVXNL0=;
        b=nDr/juiT9/zNodX5yvr5pUwsI3rUbPg8efciwqnMYworN8aFFupTmfNPrC9w/nXRrB
         SFIjAC9YRGovqgXyC1118ywtXhI7rFvSnD57uYVSZ6NLRyXEFnSMaze0+D8X7ktQ4Fzs
         DqhB6JXvOh6nBPnac7EqAKoRyszx/wiNEdGlHzOLBK89cHp/2P0Ud7NQY9lIsXG2l+yV
         JS+ve2b0rAd5qgdhHmJGkCUjBPfa1wViiYKcHoAx2YryidsBDbLXZa2DvEkOUMOw2qLk
         FniSHwOVIe79bQD7f93Q15yY0p7PNQ6dYKLXXvtnre4VGz+ny6qZzHR87Y0h8HeJDgNe
         Qc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299884; x=1715904684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhc5ZT51Bf+X0xh3itiryFkYQiK1VIkMBG+josVXNL0=;
        b=ba54mdY+dqDA1AwclyIrf2uFQqhEkLT+OZSjrtIVi+AJXn3OdgBJZaJgPREvIwOUqn
         Xb9Czv2r6cugXJVPDJcfkFtXSGjI50+H/QwrGzVZRbS46980v/Iv0XSvZvIeyWDVVjo2
         ++lVuPsD+0CGUjL6IqHyDAworKQYixyNzDre6vIlR+7INGsQqe4xV93gAEvWz36bsUGL
         sswDDpfwesJVGRkyApdoCfMNtRV5asf4XnVqPSEbeQ9nRh7FqqW26Vt2Di37i0W20Dgt
         EBgtzYUkpMDoEfLKxMtkW5JMLTw/pGtHH0nLsJFKndSUpxKea2T3GWCw7ZosLY846dom
         s33w==
X-Gm-Message-State: AOJu0YxWO4I0XyUIPvwv98JIfZjaMmx/XPGIyfrjf4beXOtRHBzi3/0o
	MZojuPiw6ugNpVsoqVtnQZbjSM2OCA6g2Z1f+pT39VP3lgU8nUirGi6uwl1a4U0C3XweYtujhcC
	3KQ==
X-Google-Smtp-Source: AGHT+IEeA3HoMtx0riBcurUZp19Bisk3YOU2mcitL9911KMtdK5oYFtWJ3cEeUHag98MrRliuC7lKihL3M8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:c7d1:b0:2b6:c70e:d3b6 with SMTP id
 98e67ed59e1d1-2b6cc44fa2fmr2940a91.2.1715299883775; Thu, 09 May 2024 17:11:23
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:04 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-48-edliaw@google.com>
Subject: [PATCH v4 47/66] selftests/ptp: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/ptp/testptp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ptp/testptp.c b/tools/testing/selftests/ptp/testptp.c
index 011252fe238c..ea3c48b97468 100644
--- a/tools/testing/selftests/ptp/testptp.c
+++ b/tools/testing/selftests/ptp/testptp.c
@@ -4,7 +4,6 @@
  *
  * Copyright (C) 2010 OMICRON electronics GmbH
  */
-#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__        /* For PPC64, to get LL64 types */
 #include <errno.h>
 #include <fcntl.h>
-- 
2.45.0.118.g7fe29c98d7-goog


