Return-Path: <linux-kernel+bounces-174910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052708C1724
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A9711F21A61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DF180C1D;
	Thu,  9 May 2024 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1m59eiKz"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D7147C68
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285032; cv=none; b=nykT0aprGS3diKVnVDSn/dxw9PagbvPSdhYqaNZF9KdTlKFsTM4DPOM2tNISUqM5GmsE8NfHIj4yp7U8amL7p9cE2Ek+t+OiyjHBrp4PmGTDV/rA2Jd1DJm3a7LQ5guOLqikaJkcTAelfvMmOr2kvvFdVlp2vCMvTZxMSzIMstY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285032; c=relaxed/simple;
	bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jlEZB5xmpczkkh/R4pPYXMKaDhMnlf2cJKRi4SQPy1sQhJanArDAE0KCEEdC8C+YkzI+epdCu0xHSMTrMU52j6KQv45Lf0k9YqULybeIu1xIQFEQa8Msk+g7ix9Quw8GEVvPAnB4AFadcO0zyyCPxVDEp3Q0XwC2H8SwlR3hBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1m59eiKz; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec43465046so11697365ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 13:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715285030; x=1715889830; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
        b=1m59eiKzHQE9r8P8Cbk4EeNRnPxmuKZoft75Yqkd3YujNHTQuZuZTdJBthlVTdhZ79
         och+bX86LBA3SiR9lZgssnmcS5bDoxVWeBpJc0IZfdPWn8LYL6iCtqy0/CjUd1nmr+Y1
         ZXl3qtbs30xLvFBIUNDt/O8NBX3CidJccgkld+91aAFhpmAvziTe4otsbZpl9zVsFR8P
         nM/u+icmcxO1Go7Ss8lPIwHeQevu8F3inRx4ctKcH6L5CMEYqzmCcPsU4tJAwfEHR3/3
         ET2kFFwKfImqUN5P0bl6vufBOsnuEqqXlMfICg+rz3QvcC415RvfS56U44TQo0Xe6jxH
         U36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285030; x=1715889830;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYMEuhcBRYdrdeW7LE9Reeo43EZwSWrRoGWRRX0Ndg8=;
        b=Tg+bfnJYxLL7o8wQyOcJ5Pqu7Q/kJJ9BAuOAveC3yfVJn3O+lKY8FXYkZtSEZ19reQ
         9K5ynZY3+QHRgbSNkACwhJxZiemUmR+U6tQndUKxbt6p3TOS1+RrnFNVRnd4xlMUkXk2
         FdOMiP5iIk9223Hsj47JA7G8HsB+gOaKuLovQOkNWK2xr9GgASO/FrVv+KMY3oPDAl7M
         zPIgxSJfQpTam39wsV2XENbKzRW9KRpva1l8hJwE8ZZJp2dRHuMaN3xLs3IRKbRAhsA3
         gdEE+Gs8pF/rii8qmcmimkEvEXeAUvZcCCUfTyG+2oLh27nlRSEvKjiC4f2lbkeE/5/j
         bH+w==
X-Gm-Message-State: AOJu0YzyfTZ60Dp5LV4UGE9M2IMSeh1rMXeh2MzrS7NzhcjJYIHEsPj6
	IhJNC5Qzslxv3FSc13rFoT7AFwYuYF5Pwen9yiOyIPdRgxwl7miehayjaTKbl3UhQQYXU1X7K+q
	LMA==
X-Google-Smtp-Source: AGHT+IFK4/DhkdFo2+zYDUlJPAtp8Ut0S4wXPjECFM86q7sbokHSPV+dZI7pDpMCgQzT+UzCnASUoNwUkRo=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:eccc:b0:1eb:5b59:fab8 with SMTP id
 d9443c01a7336-1ef43f4cbe8mr20555ad.9.1715285029544; Thu, 09 May 2024 13:03:49
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:55 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-64-edliaw@google.com>
Subject: [PATCH v3 63/68] selftests/tmpfs: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/tmpfs/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/tmpfs/Makefile b/tools/testing/selftests/tmpfs/Makefile
index aa11ccc92e5b..3be931e1193f 100644
--- a/tools/testing/selftests/tmpfs/Makefile
+++ b/tools/testing/selftests/tmpfs/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2
-CFLAGS += -D_GNU_SOURCE

 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += bug-link-o-tmpfile
--
2.45.0.118.g7fe29c98d7-goog


