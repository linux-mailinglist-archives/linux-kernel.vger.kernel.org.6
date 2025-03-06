Return-Path: <linux-kernel+bounces-549666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DBEA5553C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832D0189208D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E298F26B2DC;
	Thu,  6 Mar 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="Vh/V+gSf"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5926B2C4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286538; cv=none; b=DcHvpt5/OAa6g8QDd3RJWOjaj18bMZjlBdQ3mhcPK48i8dahRUppRGMuYCzslqJhtKx408NuD7YwaXbugCU5kUPPBU6DDc8nxRHksyhwKDgkn8NKGVVxjPBfsuMdHcz0yRn+i2Ijtsv7+BgK4P7HgRCm3JYD0jJwC+lC/2mzXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286538; c=relaxed/simple;
	bh=UhYnxzjwvRCTrXKHXhPQKkRSpGC3j82Xs/9pK8fLlOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOs8zpTBCLWCCtXinluQat1BAnE8m2VIrwRdvb7RMOA8Xjm+RUgvmnDXD1U0dxblepBV7yhhnKwS3HChblOWkCh18aGSDimFL92etqIG7k6HWBjYDs2HURldn2Fd3OUsoir4HYSCkj00FjLHr+4OQpsCkCpanxDXtt3szeK1Fmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=Vh/V+gSf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43bc4b16135so6524905e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 10:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1741286534; x=1741891334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQryvvyI2Rb/9+Iiv+kqTvYILdOjn2TN/fO7bcat3VI=;
        b=Vh/V+gSfPiZNE2d7FDZz3Su3xgh1WJyLQkbjTQGWlNccA+p1uBjceXFt25lXj8Asn5
         RBP1YgF1gxHFX0BriAqkmjW+5m6DjzQSIBsGHq7JroR+B1I2KxQn+lmj+IBpI2vPkR1T
         My7VlltkSej0ohzpIn7y59ZFWgfUewnk68VpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741286534; x=1741891334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQryvvyI2Rb/9+Iiv+kqTvYILdOjn2TN/fO7bcat3VI=;
        b=fZcW5Y6z5uXwjD7yDdJ663U44PFad2tPBh0LdWTTh6ThfwXRT7jS41M0PF7VUAeN2/
         CGVOWltlmVb5e31m3kDTydaCwNtz95uRwpv6R+hom/cpjDuXdTzdQj0w/DOk8GgUVVAZ
         hhOeG9DEfmcnrisa7zsuEZ52Gq1+FPMtw6epni/vhPSD/NlAIBlckaoyHuxFNmMgAqs3
         byr9hSt7GatPxEMORdRkm4a9gB4Uw2UsKtptyut0qswj0wPNEfU2jqYBIkVErahve8zG
         EjTCS52dKGe5vMaxwm1cMFE/2lKItyyCsdY12edWBCcV7hWxbOoDwv2lB5s4nAOij5M3
         DceA==
X-Forwarded-Encrypted: i=1; AJvYcCVmZpccLL4XWxuSGnPnclYB6dLM9KUI/FmPlP2Dc7VYm+IQkpuNcL/oNlBnWupGifkaob/xg7lAcBhFBKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTwE+uSm69JjCHowl2CHckt99BeOay5nES5y1OR9A57NTgXQez
	b4xI8+9lIsU9BctBKuf1+qvkkThPbOeTQiJBAaOYB2AoQgBQXBby3irS10u6QWpzGQVDsbwdSS2
	PUVO0vw==
X-Gm-Gg: ASbGnctXGUy2cUw9wrdrfNMrIS45gKx4nda1nrNJicJUlpV81ivq4k+OTlmetZvqm8f
	0IEXxVU7uhR4OlRchpsJ8LaKYkGEt31g8LCCnd9oM4kARfYyvA3T1BKBwB1PsWMyY3lvb4TSjw9
	cMdVONHhkOSIQhtPwRp01K+KX4FtkbTA+Z7ZnJB+VJaZFvNeBM47NDwVICbHnCYjrS7mGN/US2M
	tz4KquaBHc/iWUNbt9Las3VdEJZe6DXqMWJof7tCD9maV/j+KuD56EQwJ77MZKYJFnsEYsqteXa
	vTOcf1jJaieYhI9vAMWhIgUs5d62Fa9KgPIBYUYwLZrV7FDgM01vDaATAAj+A4PkcjMKQK+3Myb
	rdQsCNw==
X-Google-Smtp-Source: AGHT+IF9BGfgTuBwcAC8XMcVGfwsC1UdheW7lR4b6ofwc1o+GJ2W5VTjlu3/S4rT0pJ12Hj8Km/zmw==
X-Received: by 2002:a05:600c:35d1:b0:43b:da2b:762d with SMTP id 5b1f17b1804b1-43c601d90c8mr5061635e9.7.1741286533976;
        Thu, 06 Mar 2025 10:42:13 -0800 (PST)
Received: from localhost.localdomain (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42c55e6sm57052725e9.23.2025.03.06.10.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 10:42:13 -0800 (PST)
From: Louis Taylor <louis@kragniz.eu>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Louis Taylor <louis@kragniz.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] tools/nolibc: process open() vararg as mode_t
Date: Thu,  6 Mar 2025 18:41:20 +0000
Message-ID: <20250306184147.208723-3-louis@kragniz.eu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250306184147.208723-1-louis@kragniz.eu>
References: <20250306184147.208723-1-louis@kragniz.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

openat() uses mode_t for this, so also update open() to be consistent.

Signed-off-by: Louis Taylor <louis@kragniz.eu>
---
 tools/include/nolibc/sys.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index a8dca5ac6542..5d8adc778575 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -810,7 +810,7 @@ int open(const char *path, int flags, ...)
 		va_list args;
 
 		va_start(args, flags);
-		mode = va_arg(args, int);
+		mode = va_arg(args, mode_t);
 		va_end(args);
 	}
 
-- 
2.45.2


