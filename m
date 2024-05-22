Return-Path: <linux-kernel+bounces-185586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23338CB72D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE79281761
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CACDF6C;
	Wed, 22 May 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKmZZGPJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9077F13
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339607; cv=none; b=WTZiMcTR+xzRuh9F1WSETNiScF/0LwAf2AfgwFiGoDnsalLOhZVXA3KMV/bNoM0YOxv7QhiqZqm8507nhakkl/iyYscHJ9zLKqCJb6bP3171yHRCE0yP1Zaelee1HpvXMLAnzB9fui3ezma5ORIGF9YxLBoryzXlGBEmywTXe0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339607; c=relaxed/simple;
	bh=Dzdcnsg6q93Dx/VQ4J5vnEEbAA9pDEU+SlfSfSnZ0a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSKEr+ahZabQvdfL871n8nX0xO572RVUX/2/blIBym63ZG14uDYJsxkmJg4n0xopijT4T3OydlOqIwFwngmZcXiV03zC3WNlq47WsGnL3Z1dTFmUNb5x/KPs+cTu9r/XSimwwyv+WYY+msku+CLxrzVeqVku7Y6+PLhSPd7d3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKmZZGPJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so257374907b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339605; x=1716944405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lmQNJORVSfCUFFoUd1ViMTpUw9e5KrZZN0Cex2QGeo=;
        b=rKmZZGPJmgiDLzhdg8t5T/uJw7g0/Y1rQqAWxzN76pdtBHfHCfkgA5flqk86htTc9C
         oi1/o6AUzs47YiQjAGwVRWcdxMsmaW7OQ4U9NLcKgPHTXNDB4kCkNX4jTSOIMgxVekkE
         miG0Ju90JFXXxYMdyFth6j7m/pjgzE8bw4i3ssxyF/8dlvz5yXD296Rp8UxuXvoEJYGO
         MeGz1tsaeKdryzFl0HE5r7oUH/HFKEG/Ok1l5zH1fsRjiDtF4noZySZLjQAQat2+BNJc
         veX0u0foh0+j0hiWEdXvPeD47o6ipchfTjlV14YSd+7+PAtfJiSBCv+Qf3ONGwFrn4Ty
         c6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339605; x=1716944405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lmQNJORVSfCUFFoUd1ViMTpUw9e5KrZZN0Cex2QGeo=;
        b=Yv171a/oe5HvwcI92BAP0uvFOPcoo+6QHO0jPNdRyi39M8WRmoJuW0V9wMEW6WR+ZF
         U3YPpgSzwPFIrMTwPf36sKxU2NqHdPELjZZggiszMd/zMYHR0RmPNM8+1qdj4jijAYbg
         FOdIsqioV1FEDnLdboN8qG0BwPupVlnk1KbZCXeTStPgQM4fYOK1Wgm+dyyyTl1BqgsS
         GL6J3Qyp1neP6vyjww+xJy29MIhDj+8Q4lKIF/L3FmPg5E1iuc8uaWc1yaGTpma1iJxX
         AsOoLi1YN6uKz3EjPX+IX70us/D656Da636lUd53fI5i50WqeMIAYZvRKvB7VTCMkxuM
         niKg==
X-Gm-Message-State: AOJu0YzNrt9vJ7byBRhQ6GpUbJWuFsTu1lqcKkQaCFu/zfumO2OWs52u
	11Ph6uNa1DujrlVZAoZ2SCkaqbvanY78S8OxEJMqEq3NvLgtRFJRx1aZV4zaalwEr492wioOGP+
	fmA==
X-Google-Smtp-Source: AGHT+IFHbotlZv7fBN3ho5Rqkkq34fEhQTmj5VOO1FIjb4w3cqdjQsyZMPao6gSz2IdVEby5LAMyjSIG9hg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e609:0:b0:627:d549:c40b with SMTP id
 00721157ae682-627e4848affmr1773967b3.5.1716339605428; Tue, 21 May 2024
 18:00:05 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:57 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-12-edliaw@google.com>
Subject: [PATCH v5 11/68] selftests/core: Drop define _GNU_SOURCE
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
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 991c473e3859..05781c7fc578 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.1.288.g0e0cd299f1-goog


