Return-Path: <linux-kernel+bounces-185583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E392C8CB71F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F660283501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A45476B;
	Wed, 22 May 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vygb7nTa"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21FD42078
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339600; cv=none; b=SkCVLvE2XkUT1Mc2vECZo1rwcksAOi5l00tqRNBZ1mzb8yZyjIzROCFDbf6p4z4eAPXLmGkrVRrDV0GJkWYRzNmVKGKxhIUAfTnzmZhPQuMGlOIbAlwj/Iqvw3KW/pSGHYLKWY0dg0uv9MowMnL3bUE4+K5H9W46h3cTOMyvhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339600; c=relaxed/simple;
	bh=TjcsFe0gqVzale4tacIXWA6aggwGBNR3/qZPOEmsRvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=saHaLnrGLAu/YXbZ8FLdnVoCGFFj2I2QbFiYuSe2ystkrweKPN2NOmJp3IPMf9V8JTyj4uHuIsMDieyexKGYAnXz1mcT4U5nCeKdzUseiEkPxwyaZaQX2YARgY0MqeX/6vBu2wNvotzTRL5CzgfCzHUQrmq/i2fdHP7JiZ4hZV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vygb7nTa; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4d62ff39fso1117424276.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339597; x=1716944397; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ym3nXUXeH07sf/nsYazh/meC97pdGBCDIsOIJ26bWuQ=;
        b=Vygb7nTaltfQwkSIHwFz4O4/wqPIe8xBvdQZ0emCXKMSXsU+PtsH2bDmmc7xS3LX3n
         /EMvc+pKmLWaapdVOGr0Ykqgkimc+a+FQnOUlNoaxS+teG07mmYgZ5rrCkQ7HrXHLg6R
         qiP2xhaJeO1PgN67xOMv1M4eHJc4rXdlF/ermp5nzaZnIOiJs37WmfDaeaY7jGLWvSAw
         NzgYrtq4IETKmsukwAcJLZabXoGRoqtc7V2+yD8EVcAndySlVV+zfcQ76S88teTiGnFl
         p23PxjYzgtwELMdYcKv9Tlud9EDSgE3zuO0HjmIKQYCClSURyg1Lpkezh+vRFDUNwCe7
         8Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339597; x=1716944397;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ym3nXUXeH07sf/nsYazh/meC97pdGBCDIsOIJ26bWuQ=;
        b=ay2rr0bwG42VE5hiQCN9YPzvAdeZEXxO0zMKxqG/sfMf6BCWBtv4Brm56C99U4G5kg
         0kupTwcUdcz06YRpDzZ8WbuUxJI1P6tTzBUIs9Pd4+dcEhH01by6o+sOXFBDmI/t6RKw
         DofuIkOoU2hZU1MvvU+rVFgAK/fnzllaB2pzZg0nF9ipN195gu5P2pp/I55Y1t453/So
         rPmPFldbx+isK/arMqnj+nBVzpab1b84FCTgnflsX5Pp1xU5ZS0tcu+qShh6hpRWgBT4
         Jtsxkx3pVxzEhEIQ3+7sIpRaUZeYj94LoB/fINeEdqhx9auNFlztgyLaics200sgMsc1
         BT7g==
X-Gm-Message-State: AOJu0Yw4vj3vWe9jN9qnc8hWCjYXUTmn+1GvBel3YStUUhfcrOC0zY3j
	pYDQLEaZuSYFgGOsSJqJll8+fnMwHf6g5aFICDHMONm7OICJfE/8Jp4nze+ESSvFWemuC81nNhu
	OAw==
X-Google-Smtp-Source: AGHT+IGqx4zcon16q0eoDTQDxUtzKaoXEeTVLNF4sRkWHpre7T5XR+6WmP9e2dcSPYpPAo5gyN8nv9JO98E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1005:b0:dee:7db6:10df with SMTP id
 3f1490d57ef6-df4e0be43a1mr197886276.2.1716339596889; Tue, 21 May 2024
 17:59:56 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:54 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-9-edliaw@google.com>
Subject: [PATCH v5 08/68] selftests/capabilities: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/capabilities/test_execve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..7c37ae2407c6 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <cap-ng.h>
 #include <linux/capability.h>
 #include <stdbool.h>
-- 
2.45.1.288.g0e0cd299f1-goog


