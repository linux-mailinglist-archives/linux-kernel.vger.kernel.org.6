Return-Path: <linux-kernel+bounces-574538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5168A6E688
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E76173F0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94C1F0997;
	Mon, 24 Mar 2025 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSD+TR+P"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D221EEA33;
	Mon, 24 Mar 2025 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855239; cv=none; b=YFeLByKdWqRh8M4WVvxPoZz5DJIyxi3ZqrAIw9ziKZ/eMIvs3ZUPHkzCm8Wm2zZLm9Jn4TG6vkEB8czDjpVFx26Ktv75Eh+QWNvGmAN35C6ZiSmap3A95UNyWQr/W6Qx2h1a2l8ttBVDsnrsWvIQCU6NcU5U/SyCmXKoxr59Yos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855239; c=relaxed/simple;
	bh=Ul6yh2GW7vuHjG7z9QNBKWXuyuhCQemyxnw+iqFdVS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3b58LI8iFKKI0cAbI3JoiSGJEipqMtKhLaz7E9EE4THOCAf0KwDL+Wt68kOEvx+Efv9hi3Rgklr04Pd/+aXiZoc0TTcEEkp32oJqvNBRCuijnge1IO/GXFKNckWjgBxii4xUegK0XRqe8/ZIA0+AawwdXXoAJx1YSoYKTI0yiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSD+TR+P; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30db1bc464dso122721fa.0;
        Mon, 24 Mar 2025 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855235; x=1743460035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHIXOKfNdT25jyyMqqEwfPFJ5jN5mW07wAXVzl4NvYc=;
        b=iSD+TR+PAcZ8NggtHReMsYiDcXqI+gXtbkN8ysQ9aiWtiAI/dyE20GV2Kup5mfiGzy
         +/mqurTCfygkPul6ID+N+fhkGOoBxeLG6MYkzFJtDw15Y6tbI3yHldJxCfbDZv+gF0an
         4+X2CAS4K23jCItMkK1z5hHDJJaxpnktqwPDqpRFb8369Hpim4hg7gZYLK8tZdZfexdp
         BsJVFIx6mZuKsbeLDTsdu8OKHSnr6O5+89cstu42FbWgMe7ngJ2cj/uA5MxUv74wvPZr
         eg9Wb2hWENHHylTgVJa3SImBHIwbROk0PdWA55ZJSrflc/0KJ6ZZ+ivKkUvLycfLr2yr
         CQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855235; x=1743460035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHIXOKfNdT25jyyMqqEwfPFJ5jN5mW07wAXVzl4NvYc=;
        b=ShJ0gaI7lrm1JACouIgP7odvVJ/biQhpzVFMY22rcL2j8fj1xda8Sp0x6joHsSFKDY
         MKy0CnSmjIeEcuF4dxGOjFEf3a53VeEgWjIIDAegaK7iSdcRqXlSYtyV0FpmqddHDX74
         KaoIQwKpkAH9rK17pygGKHMmh37YUPVBHc5/G/NERI1tSE+TsYQrbMN4P/UpL+gYt8NA
         NRbnYXOO7FnjYqtRyHL31Qbyx4RmQFXNR6ccN0j6M6iaiBbOnmNFShsEuLd8VfONynv9
         Ml+e5zR+SeUzVJsWzI7m6dlOfr5kzayj7I+5Acu+0FU17RIExWrxgDMaUdGHKHEzdrYf
         BZRA==
X-Forwarded-Encrypted: i=1; AJvYcCUXIr7lAR4VsMLwTRRoyzDgV6MQ1/VfN0d3gqr89fSK3i2R0y9lALy/tpF+hLGtHjUEn0IiCZ9LwHLJvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVUJXkz7HGKMZdKCYLofPBpjan90xQgVZwAHviycBgeyeDbO4
	YoJ+h4oiAAVgUoMlcBGA2jWf7Qy7SeAoQ81ADtmeAdvrr7drBnoqB5iTsVjoG+I=
X-Gm-Gg: ASbGncsiziwtSvFEoinOwpXAxUJ2/xaDTn10WHZoGfzYV6Tworiu0yDnJf0GHOgb9kP
	qij9ufTzVEa4aFOlp9WEf8bxhXAbZsRmyN2JS/HfJjYIDjDKjjvlCbhN5gi+Utpmkjb3x6cQwN/
	9mRz1QhW79TbMfefR55oqQK76cD16n70RZGOu22CjAJHOGdIORdFfhp7j744eE66pW3cjbUlcUb
	qxCZAm7wpW6L2V7BxrdRwOAXc6+HfDFofQ2dYyCr3GAL9M2uCluzBiM+0q2N3my0w/q/lQofx9/
	J6lyQPJToSJnJ1cTetIT/gcp0WBviK4hH+eEGU8sRpOunfLpXgSGUvm3nZJTJ0pSlaVU9MEF3z1
	WGBs4wz0M09PgtUzC0KZtmw==
X-Google-Smtp-Source: AGHT+IFrUwCki8IMq9+BtB4IN5tlay3aWKmaXyUARgdXQE8zZ5vliHTsDZLFiMVBZLR18sfRR3yI1g==
X-Received: by 2002:a2e:a542:0:b0:30c:518e:452 with SMTP id 38308e7fff4ca-30d7e22175cmr51541541fa.13.1742855235368;
        Mon, 24 Mar 2025 15:27:15 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:15 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: richard.henderson@linaro.org,
	mattst88@gmail.com,
	arnd@arndb.de,
	paulmck@kernel.org,
	glaubitz@physik.fu-berlin.de,
	macro@redhat.com,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 3/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:35 +0100
Message-ID: <20250324222643.32085-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250324222643.32085-1-linmag7@gmail.com>
References: <20250324222643.32085-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add function declaration for err_tsunami.c to err_impl.h

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/err_impl.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/alpha/kernel/err_impl.h b/arch/alpha/kernel/err_impl.h
index 737b958a586d..64da787203ab 100644
--- a/arch/alpha/kernel/err_impl.h
+++ b/arch/alpha/kernel/err_impl.h
@@ -86,3 +86,11 @@ extern void titan_machine_check(unsigned long, unsigned long);
 extern void titan_register_error_handlers(void);
 extern int privateer_process_logout_frame(struct el_common *, int);
 extern void privateer_machine_check(unsigned long, unsigned long);
+
+/*
+ * err_tsunami.c
+ */
+extern void tsunami_register_error_handlers(void);
+extern int tsunami_process_logout_frame(struct el_common *mchk_header, int print);
+extern void tsunami_machine_check(unsigned long vector, unsigned long la_ptr);
+extern int clipper_process_logout_frame(struct el_common *mchk_header, int print);
-- 
2.45.3


