Return-Path: <linux-kernel+bounces-345889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB598BC8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188E51F230AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F1C1C2DB1;
	Tue,  1 Oct 2024 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa1DQgCS"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241DE188A01;
	Tue,  1 Oct 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727786734; cv=none; b=JfcnSH+tX8+OHNrCpLcPZ8L8yMIeGzqYVvxGNiKmOioWKS8rT/44Hw3p3YtmCBgQMhOONpHeq5QRluePDg4sn7ezSadG/ede4uAZsok+E2UUTluKNh169MeO0OcWsnrxwvn4ba+IwV1ZG9dKqihr38M53kLAyQ2cIRSAvAQfLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727786734; c=relaxed/simple;
	bh=vZ3+CMDw1EvumqOoU7sILf5b8Z/DmzRjPDWTg7aufTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=UqtmlMayXHjp9EKu7RbmRjqBJgh8tOH6gTEMwnUP3ToyTB1uLqn6o47SEHdn66Wn1MeWvbXuMf8C2smWsKAeLHSNt51lIfq27XRciXTSxzraN4ikou1JIUbg18yee2gw8sxbSdC7KgyFppfd91yY1eP7koPIK9rxWQAE8OGX7pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa1DQgCS; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0c7eaf159so3551682a91.1;
        Tue, 01 Oct 2024 05:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727786732; x=1728391532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3hg7gGeL9N4ekrc2dLXOxIsLr5323K9FY89aAbEnDGQ=;
        b=fa1DQgCSpemi5FwFfdizzo5Tzj8YhqGfWB0xnHVAKtD4jxAh78j3Q5NN7bf4iV++ef
         Hy6vcU4vAVkbSA90/7fhEIKMKKwiNnD35HGICGin9KsSXoMEP5QkqlhRV77x9v/nYb14
         jsdSXhUG4nNI4e/ayaXF7MmqYMnM2VIatrk16cucwsA7fE4HThOGBgq14zYqxo3k5DRK
         WlBtSEgIoKglS56W40OEkjCMnAh1ytUzSgB4Elw0ir0y/3SAG5gwx/WzvpKYN3Q2Ysp+
         R4kWQfQ6Nfj/523hI+g+W8z7AXwDMPWzvNYeZ7pFejByHKTWpRiVNr0+Vc9y6AVIuOX7
         IbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727786732; x=1728391532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hg7gGeL9N4ekrc2dLXOxIsLr5323K9FY89aAbEnDGQ=;
        b=vEBI7cK9xfXf22+GK18c2vmr36rYCRw3hmU2NP0uz8RJUKJ9KqnZSDAIpCg3zXzZeY
         1/J/kZ4SaYoqySp8Gk8Phf30y2C2PeVwVpixgD6Pb7kel9mA7hU3ZG4GPa+lU2SnbhKA
         tEFM+48a7sV83u4wDF9sNSg+5AZz099St9ygd2a0mD5MOagvAFm9KGmPG7CJs2dT1Ues
         KVA4ZNnPYu3SymBHhw9+WrAnt0RVSlDhFAI04kHelY0DIG8rUqLUfoF3u5jOJXnOVzJN
         J+4T4QmijIxyHfv+Icro8p6acsdY2T0UQqSjtNKyA60g+QcmQ8wZGNU3bB6+JxLE4SzB
         vUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4IFTI14jEP7JWMHGtYTQOTP75rYJ6MN0JhhrC0X0K3DEID9Y9Q4nH3P9lggp4ZhqjXLG573MljWYOuSoM@vger.kernel.org, AJvYcCXRKx56sNQLDGbb0/ZIiF9qDFcbFyigwI4D2CCf1pLqxnUs8qTXfQjG9pbI4T7vHaSvQ9rLPLQGczsg@vger.kernel.org
X-Gm-Message-State: AOJu0YyFVieUXUpEOMX0WkmA11ZLWCUB64UWikcQ/GesZeiwYhWtBJL9
	lP2EPoyS7zraFJ8cNcjFrkMxzXiRX9tbUub3MswNvOdiNJiDoa7ClVPlfapu
X-Google-Smtp-Source: AGHT+IH/SAm0KdyL1ow9WB9rN2zIwlZz+oqrDSyo3TYfpxV6u0L5k2aW13Vn2k7GTlVkaxXpezGbRA==
X-Received: by 2002:a17:90a:4b86:b0:2e0:b741:cdbe with SMTP id 98e67ed59e1d1-2e0b8ebe8d1mr18202134a91.26.1727786732344;
        Tue, 01 Oct 2024 05:45:32 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1704bdsm13629171a91.5.2024.10.01.05.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:45:31 -0700 (PDT)
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: freescale: verdin: Update tla2024 adc compatible
Date: Tue,  1 Oct 2024 09:45:02 -0300
Message-Id: <20241001124505.73857-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

This patch series updates the compatible string to the correct one for
the TLA2024 ADC found on the Toradex Verdin iMX8MM and iMX8MP devices.

João Paulo Gonçalves (2):
  arm64: dts: imx8mp-verdin: Update tla2024 adc compatible
  arm64: dts: imx8mm-verdin: Update tla2024 adc compatible

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
2.34.1

