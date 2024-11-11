Return-Path: <linux-kernel+bounces-403816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F399C3B34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED171C21F39
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FA91552EB;
	Mon, 11 Nov 2024 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hF3NsYnf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7583E137747;
	Mon, 11 Nov 2024 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731318355; cv=none; b=KVYhtqoJOHXEqJDkGgV6xnu9LdOgpgLbUDtbxHWooTXEaBFGyfRb29SSIK1TDMoeq5XI8ypepnqyKq/zwpDaduqKdOn2OZ/GoCPRg5O4mtlhI34y16bnN2C/L3iLfkTbg70g5s3deG3fQ8rN/KKJaQkl965I/cNDiWUUa+p+6uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731318355; c=relaxed/simple;
	bh=m8yJRYn1Qded/JlvCWFJqSDg6tJizqZEmCY3MJBAKD0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZCtpUJ/s1PHGclS9iMa6WdRzayW3tOV8x+c0+M/Kmdu9G9Y/GVdYj3X0qIa9aqdiIHvyQ8XVeVgwiSh/ODJGVlFElwggd32NYsl4bHnO/TI8SUtCa9sB1yd+F0w5+TNXT+izhUMihM4QLhtT5lj4BykRXlVWL5rtEPD6nQyLBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hF3NsYnf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c9978a221so48641925ad.1;
        Mon, 11 Nov 2024 01:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731318354; x=1731923154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ8DZ559nDo5G/ZkZVyMN4vfR4RJ1OGVlWo9rNzGIfU=;
        b=hF3NsYnfTUY/GhDE7zpR1zxMUn4D4QPEurFEo/Y/TLXhoxhKPjSOuviij1aWcNcCj1
         eB3sUmbps3iWZJZSLcXpxvK2ubs5qju2lZuuWNjJWevtPC5w/qfqsgPFD1qYKpF4xhCj
         1Hc5F2PfNI+aK6Gvm6dfugLyV1pIXkLkvKXylfRcpDyACuZ+VfLy+n6hd3AulpUNe4kb
         oa4xLnR9kkm+cuTvkdrLeRx/itARP1Z6IXRYECfmGzBdS85yup6fRutqiMSoYkX9mQSD
         oeHkBqpWTJ6EJnyyLUTbuzCfU5Jbopv7HWwshh4jAgWz9wbxxNdrnx4tznw+eIZzw8pP
         trCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731318354; x=1731923154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ8DZ559nDo5G/ZkZVyMN4vfR4RJ1OGVlWo9rNzGIfU=;
        b=WrYpFFFkI3dVhqEiXfevUoFBqv7WxhhjTio2bOt3969m7ogv5dyDnmYJ5t6fq/UzGw
         QjgTPpR1sWOsZgQ8/k2O4hddMyCegalnuBc7k7gm+iOh61VQC7Z7nyV9ivbp/JsDi7E5
         5lRCmG3gDvX2xSfUNPF0PTgiUdn9qnxAl10En9JXqW2tcVct+K2heMvTVFy4zqJy1pSU
         608qx3W6IgDosPH41LI/CpC+EjaVsWpBSevUAz2orAFRPohv1oDGqknLYLBPZ3Ky+5/b
         EogOHya/emn+lYOKlazb8COAeqGgWxtlcjQZU+Fem79UtjTFsFE/ZZ1ihgC/DWg+Ctx3
         dZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYZsVY5nCnJfNVcJzIOUg7FEsDhkrrbXXetmLaniz9D0FQPSoanmrxY28uIbDJHboK+oFISPIjAgTO@vger.kernel.org, AJvYcCXJ/sxwobabgJjxEpT4ADvbCU99MBn9hdqdnN8ROdA7/nIdaO0K7uBJLkxQuEnyz2jQ3oraoTFvsJsI+dbc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rMEWOTADWOel/XOd25lnksiSxnW8ZgC3b7zGO0i9JKhoVgny
	meQaE9bT0eueGC943Ob6gg1K7mOujmb5YQI9fY0xMthuDKq7fSW7
X-Google-Smtp-Source: AGHT+IGUDV2eKB878pIBUT5cLr6EWiWN+Kf478uOtpN1L7KICE2CM0Gjp1DENkevdsD/kTAUP4K0dw==
X-Received: by 2002:a17:903:1c7:b0:20c:be0e:d47e with SMTP id d9443c01a7336-21183dc7f8dmr128840415ad.56.1731318353680;
        Mon, 11 Nov 2024 01:45:53 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc826fsm72248725ad.11.2024.11.11.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 01:45:53 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Mon, 11 Nov 2024 17:43:44 +0800
Message-Id: <20241111094349.2894060-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on:
https://github.com/openbmc/linux/blob/dev-6.6/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts

Base on:
https://lore.kernel.org/all/14e1a0f581417d4228aea8c2569598d42b4bd334.camel@codeconstruct.com.au/

v1
  - Patch 0001 - Harma: Revise node name
  - Patch 0002 - Harma: Add retimer device
  - Patch 0003 - Harma: Revise GPIO line name
  - Patch 0004 - Harma: add e1s power monitor
  - Patch 0005 - Harma: fan board io-expander

Peter Yin (5):
  ARM: dts: aspeed: Harma: Revise node name
  ARM: dts: aspeed: Harma: Add retimer device
  ARM: dts: aspeed: Harma: Revise GPIO line name
  ARM: dts: aspeed: Harma: add e1s power monitor
  ARM: dts: aspeed: Harma: fan board io-expander

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 121 ++++++++++++++----
 1 file changed, 97 insertions(+), 24 deletions(-)

-- 
2.25.1


