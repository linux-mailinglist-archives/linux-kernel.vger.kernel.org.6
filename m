Return-Path: <linux-kernel+bounces-361320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B011699A6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45045285C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206371885AD;
	Fri, 11 Oct 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ZohZ3PRt"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4BD79DC7
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728658119; cv=none; b=i44Yo5/qww5HHsLKP9247OHBeXSC2BJYfuGfiOrx8MSG9gKUzm+n2T3QiKmYvQ10MESFthODVhD/iNPT5as2PIZJj7fUkOvOftGV5F5AKl00usZjauf0rKa8Mmh63ZeR6Aa31sorgQpnNiLOiO6c9F+Yr0PHGcp4XPqLDuwios8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728658119; c=relaxed/simple;
	bh=uQVCJTzTG+CgJBodFQTQpj6z47sYXTr+QgvgQYjK0U8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqH5bM/A7m4wChHLijoP+cy65aBAhRdyryf9N4HmNbruEshS+OKXGmMYAoKwmTqFNNLWB/lSWSnsnFNXR2zxJiT6VISG+1sbiQctHbizwVtm60AOXStK001VBj2QjVrplfCz2uJdmjpHQfwx/bkYdi14MLkU4An2JJeljR7xyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ZohZ3PRt; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 51AA43FE51
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728658109;
	bh=ZeYY7hZCtG5ZzblFqjablxTznhCvL1wjc9Tgelu4NWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=ZohZ3PRtjoo/dYtvDJL8Ar7rpoHttZacWbawJsxX8HIlUE9FU+IAvlQyxmDjums4w
	 qF8eJBSnZBN+P94OQ6N4kZzrsgLgKL4jNJc4Qvrv23ZbAUxCSi2cgJyfPCRcARUBRq
	 A7AbF7EzQM7sxoxkSl2RYUXm3/wITZaHxzY0Ku7a4T2YCLPbNRN3CmG382gzfwmDuL
	 pSryAiZtwAm4iA2kdl10ATApQUZPct0NOanMJsJXsmGj9j0mlREttvISTUaTU0ZRYX
	 RT490IjZ3+uQFuQv8LZBqBh7v29wDpqMmhJaVK9IowxeF47UUvR4Qim42Yhio3qtfW
	 R+mAGsbZ47Fgg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a996be26171so337520366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728658108; x=1729262908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeYY7hZCtG5ZzblFqjablxTznhCvL1wjc9Tgelu4NWY=;
        b=iK/wA2eqp+1YAcmIyviZB0ZB1XIuHB222liS3vtX05kf/acPQcMTUvYT4oUjLufePH
         8/C6MqFWInTFP7kCE47KpDfX4ZTV8XodEX1wbefDwh5GDPWZttvChXMRybljtssgXQxr
         9SSMSU8+ODQu5B778B8agcejzjisWoxJ0hKypnSoDYs32a/l49OZHGGGkOWvV5NVLCS3
         gkDx+BbcU5+058Gaq0VpcT3N4c1nC5UPsLlpBnec5LCrq8b0dF7K5A/r4v3WleiL5jIq
         e9dsJsX9lVDZlWNs6wNrh/fYq8hDtk7oE8tDlHu2uBEI0o5QbI8kFGXYnWNTwvGnGEDH
         VbGQ==
X-Gm-Message-State: AOJu0YyHPlQHYUY6iwfi0J/IVA4hp1NdTFJFKiVQyDqhrk94hu6ggu5e
	9JGol5J2UCoCyWv7YGFXxesgMZQVInE4KzIM0GfIZEgz95IcffF9edoIe6UjZnjza7i49/Q1vPC
	Ml/lVgFsCxNtWOMXx9ornGgfV1hzRgADmpIFVYAzmZChWSc5HlncDFIaJWz7HJsvK7IZvqvq4M1
	ZWo8whiScAwQ==
X-Received: by 2002:a17:906:cae5:b0:a99:4ad2:acb7 with SMTP id a640c23a62f3a-a99b885cd31mr293766766b.18.1728658108451;
        Fri, 11 Oct 2024 07:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZJ/O4DI06C56//3e90y9WubgT52G8l84SnKYNplOkm6YFyYikVWRaSx0ajYVuWo5Sc8h+Ig==
X-Received: by 2002:a17:906:cae5:b0:a99:4ad2:acb7 with SMTP id a640c23a62f3a-a99b885cd31mr293763666b.18.1728658107892;
        Fri, 11 Oct 2024 07:48:27 -0700 (PDT)
Received: from stitch.. ([194.62.169.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99c0c89bfasm54134666b.162.2024.10.11.07.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 07:48:27 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: [PATCH v1 0/3] pinctrl: th1520: Unbreak the driver
Date: Fri, 11 Oct 2024 16:48:22 +0200
Message-ID: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are 2 important fixes and a code improvement to the T-Head TH1520
pinctrl driver that was either introduced or missed when Drew took over
upstreaming it.

It is based on Linus' pinctrl/for-next:

  6dbd1577b7dc ("Merge branch 'devel' into for-next")

Emil Renner Berthing (3):
  pinctrl: th1520: Fix pinconf return values
  pinctrl: th1520: Update pinmux tables
  pinctrl: th1520: Factor out casts

 drivers/pinctrl/pinctrl-th1520.c | 52 ++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

-- 
2.43.0


