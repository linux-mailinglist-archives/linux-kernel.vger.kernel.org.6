Return-Path: <linux-kernel+bounces-175150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FC88C1B5E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 02:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7691F215F3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F8F13D63E;
	Fri, 10 May 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QP679QKJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19B13D534
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299902; cv=none; b=kBR7ypX1Mh2NZHGBqrFod1Rhtc2f5H0LKfmGLMwB4zyi90JF1ODJr+MzWKm8oIiju87CoKZXqk8i0wjhocwNdnUMSrLcW6Jzl1JKGHhMPhJmDlVrGc5uy8fvD5+T6Ppvhns29clAmfBgYBUgkdDXdtJ26zaK/ScvYeTpX3HQaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299902; c=relaxed/simple;
	bh=JvbDWxGt73x+3I5wycvjFh+GG2YkBR1D3FMaXjgEOUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dAF+LYDlvejyNaYt/b/m+M75ZovXMJiR7ZGUj0Xvb2jpBLlPuGPZoHUzGJx/00VMBCxjkUk0d+320ug7XIbctmNDICNu4wo6TV3XGfDWzVbiurHq+rAzev4vD7AjrhQxiwaxO06uChfJEL8pL9PTccx4ABbDSaIB7j+fzsqaSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QP679QKJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de604ccb373so2283877276.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299898; x=1715904698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=QP679QKJ+YJmUJRm34oeIG2z2fV+eM5+XdTrCwfV3+3XDob7WXz7VcW2vVJIl+ymif
         DtsIA/CliHTTsjmF5m0TikO7867fp+6gSTDWNVuL3FFExEU3lt/9RU9o82DqKRskInMw
         OUFYnwG/v9PfiyXeX5L9a3L/9VCdD2SY/k6Vd6j6Uk2h3tmyZSBVROJ0UxTUuA46x5zY
         sD3BGmKGBS535ty0/EQJhQEGQZ2DYWvrLvXb4IVftMe7RDGttpOuusFpaCgbrQ/EDJyl
         UGhvFjlABNB2orh/7PnnVebuPNvOjyXbkW4MeLCVvvFpXQM2O4n6Aevfb5DeH5PnK799
         WzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299898; x=1715904698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=lxlbgfHG4l/z5V+1uP6of11jMMeFfn3L4cAUrZC9u1bqlipK6wYH+V6j974gext+m3
         J76BmuH8c4TQXwLpFXuhx1yWAgC/M9QlrKMQkWcI9+SKbOdieC1/3sKQ1x5LlffwQwo9
         Vor9C+qQqImgz0P3QNy13N94DiCp3Epn9IOcXz79I9zWM1rNtPHmotQa0CqiYRDeFSrB
         WxPk11hakwPQwOnG7diFKqgZGVIST8xzPoAHzekW5CfKCwhhWCnXevf9+WsKyyRe+V1W
         5XvmYIBaBxkTGYJYh7GeZTUJZuCuppTO+lo1rQ9prrkIbFIWNwGhcBedlZDuPz55GjWq
         6UNw==
X-Gm-Message-State: AOJu0Yzzgrs9KyPV3aIaKciWmohrMpWJHtdqopbWIT9+9EcsXn6TEm56
	SgVVfYvkSFCydz+f/5hCqahF9baS62zO4ln+bQazsDVZDXUc0ba96hzBlg17jijXSWgsgXPcrBO
	HfQ==
X-Google-Smtp-Source: AGHT+IHvqoyfuJd+zpWyzRtMJpM3tPkSIvIsjPanUafDlQuCX9siiHmpPTAd92EjaLgk71HiYZjK7/db9Q4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:b31a:0:b0:de4:64c4:d90c with SMTP id
 3f1490d57ef6-dee4f4fb5bdmr99366276.12.1715299898422; Thu, 09 May 2024
 17:11:38 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:10 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-54-edliaw@google.com>
Subject: [PATCH v4 53/66] selftests/safesetid: Drop define _GNU_SOURCE
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
 tools/testing/selftests/safesetid/safesetid-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..89b9d83b76f6 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


