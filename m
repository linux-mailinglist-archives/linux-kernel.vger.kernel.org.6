Return-Path: <linux-kernel+bounces-569734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED5FA6A6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D336485EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537E226170;
	Thu, 20 Mar 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmW4C+2a"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3422540F;
	Thu, 20 Mar 2025 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475712; cv=none; b=AflUqKfgsHcSJYeQJ3srZBhcAjXAjJqty4oceXMO87rlw2yLu/7UJKrDlnqB78Kdl4VGPSllF6ymCPVn5N0bUmXSP1CPuo2ZYMpu4YAp5iMMd11bZBK9eQ0OO9GPvtiKWz/IQMJdD58QofsmZWn8pIrRCbzzeUDNunO/CMOxZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475712; c=relaxed/simple;
	bh=0DVNgFmCaYiuTa3nRsT6E8kjMPJtRCfoCmjiu+brQuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFEm5QTS/exYW2l4jH/mbrhpCL2/ht8x4J/eTJ1h/uTNkbALlGcwwJiOjTbmQdXRANIhZTMi4qJTytnP8aj58IgwaQ2vcsQIkeerESasJnizR8bpSlQ/7JrgMaBrC0pJwI+r52n7DkfjPZeYNFI3tMAZu2hFO6T6667fCLuC7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmW4C+2a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912baafc58so630708f8f.1;
        Thu, 20 Mar 2025 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475709; x=1743080509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MZocKeaP4+m6t9O2v1jxFvpKpeZLmzryJkfebv96Xm0=;
        b=nmW4C+2aGvUhWA6VYEra9r8M7M0dJj/v//K5Wzk7cdX9tdjf4/3bYAXb+JXVcIdY6Q
         Nz3j5jWaInMrmU8oKkUxv2iqL/P2eX5ic3led5H/1fdvfsbQni2CZXaPEpS9Ibh5bF9N
         DJUuo0vE2hfaM5CpYAV8DmJKdXPGIFHbvL9k7lmIYMH3TVmm/soiJwOocXNuPa8BXCO6
         QXPBZozn5bcugAx9vD6JZ31ohszo+a780sQJDproAmwwgQc7EtdISVnea8TM/i4vdxaM
         IWDSv3pzYhnfyAOYTo/jn4hw+7SXT9dBHCa+jRZNs/rjzxbMTMoEaTbKReV8BRQ6wd9a
         77+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475709; x=1743080509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZocKeaP4+m6t9O2v1jxFvpKpeZLmzryJkfebv96Xm0=;
        b=HkAJDrBvG5FaGSZPvJaSnM6TM8nNl77JMmmyh4X92mD+irUHx8890g6lSweIvOui7q
         pVxlHKMJJq6yPkhdRZBKp9tuwzqq7ZpHnbh7L7pJuYKXZmU0oRJOppskQ0zZfmFNm3+M
         qbEqqOdMJ7EplExhp0rgE0iUfCV759r3rfSrqU87Q0YbuB+rws9ffo6dQHFYrP4w8NOR
         4ChiAu6ojOaF0/l5YaeI2I1kN2bb9V9dwbYgPVfHg4bpIyrdigdwE318xXsDOTRvppI6
         CaQOSMQ6XoXIpBZN/H7kSMTBbq+I9ym/Y4J7NYaepy5C7IOeUg78KPn5G+ZpJQUFJ3RI
         A0mw==
X-Forwarded-Encrypted: i=1; AJvYcCUPqVioU2YZFsl27Gi5rKpy5KwWcUiPx0Bssjk3gCQ5fJLk3wy2VBMLbWGTJqH23osYi3tS6/EQQUXE@vger.kernel.org, AJvYcCVnkLn4YaaLMAGnkw0lkAdtQQOePTtBKkonIOgHe1mefZudQvmJNsdif4UqASwTdPlVXnkweliX8JlP@vger.kernel.org, AJvYcCVqzEAMRZsx89pfp/O4ivfWoJTaVhZpzCiVJ+Qt/S4pXot2sWH/gObzpi37ju2iiYF6Eu4EmWWkir3NaMM4@vger.kernel.org, AJvYcCWAtGY7XmICk6YevOlaf8jcXppoEQNxEM7AwyAJzU20cOJgp+KCRu6llDUGFbJXT1LDmcB0Gs55zE9Y@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1JxPhglU2ef4fIIFxtegm8jL0fod6h6wj0ruL8nMnQvGWBka
	4/wO9EP/7vNIVrmCHKhhA0AvrTYyCNoWCrNo7Lo4Nl+EV2d3ecjk
X-Gm-Gg: ASbGncu31PaKFUoNPblLEIo5eWzsxwXrf0ldjTtb//zFuVCbM1LL5RxQ026Mt15RClW
	na9BQZdjx0mwn5+ujhuFmZhwTBv3byZlbxgA1i02Kk3UBZ7ynZA1kMb99szndYq8G5dTAbskay6
	whpi3yiC74QGoCaY0cJhq/YY44uAaAeBhkb13HjG9Lp9f/BiJkxuC4Jpkt6TpHefnndEme1juWN
	k6iKT4NEAanB0s6drzdIB8x87QjtCMbkC4UIawJ2/u/bSzmVjqdLa+R+cykDynd6Gs7TDM32ANU
	iYAB6Hekh5AvfQgv36PEwycGkyg7DE4cP6GLc+nSU6mJkfBZENaRDjCfTThKYuwbuApOAtX1HN1
	WKI7fDFDJ7tKDgw==
X-Google-Smtp-Source: AGHT+IFwiZIO1zJG6xqsD6hkKvEBYIiPzPEpp2yNsbAclaZLwl3OGlaU/Gn9w+5dTLKNFCSQz4VNOA==
X-Received: by 2002:a05:6000:402c:b0:391:4684:dbdb with SMTP id ffacd0b85a97d-399795ad76amr2805038f8f.17.1742475707909;
        Thu, 20 Mar 2025 06:01:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-397f2837e61sm18492328f8f.97.2025.03.20.06.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:01:47 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Danzberger <dd@embedd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Yangyu Chen <cyy@cyyself.name>,
	Ben Hutchings <ben@decadent.org.uk>,
	Felix Fietkau <nbd@nbd.name>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-usb@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v2 10/11] usb: host: add ARCH_AIROHA in XHCI MTK dependency
Date: Thu, 20 Mar 2025 14:00:33 +0100
Message-ID: <20250320130054.4804-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320130054.4804-1-ansuelsmth@gmail.com>
References: <20250320130054.4804-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha SoC use the same register map a logic of the Mediatek xHCI
driver, hence add it to the dependency list to permit compilation also
on this ARCH.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/usb/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index d011d6c753ed..9d8626f36ca6 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -71,7 +71,7 @@ config USB_XHCI_HISTB
 config USB_XHCI_MTK
 	tristate "xHCI support for MediaTek SoCs"
 	select MFD_SYSCON
-	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || COMPILE_TEST
+	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || ARCH_AIROHA || COMPILE_TEST
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in MediaTek SoCs.
-- 
2.48.1


