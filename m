Return-Path: <linux-kernel+bounces-278909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB394B664
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 07:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69153281B1E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D93D184541;
	Thu,  8 Aug 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP0YGdQe"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0A18306C;
	Thu,  8 Aug 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723096648; cv=none; b=IRg2wBhq54bTC6/Ur1PPJmPT8oLazm7v4fWRIgVck5mbQqdZYf73ZHu0U5dSLyEYl2+s9tg/XLn7+nxy0+DqbbvDBaN5gFjTNx0vx10h31yPcP+UBLRKs0E2uEAMWTMt/5goBfqml1SYny6dU8ZwoINia4p0svuTONeFZPTIrPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723096648; c=relaxed/simple;
	bh=rnRFuT1S86rsgbUn2JH+zS6oMXRegY+0glfMWQU6zuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MiUfIXmMTLlwn8cF3cVQu4NovWDXdPpPCjX8NdlaVrOszmFbxmHhu/K2QZ18mQnXkZkOlUhi/W+3PF2LKlPOReW0lMMaXdcDSwq7tI3cCg/l17UQ3AdAVosXVNUJtI6x7bSTUAX660rpJNSC8/L3ctSnSfH8H19KQBpdkeHCRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP0YGdQe; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso66299066b.2;
        Wed, 07 Aug 2024 22:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723096645; x=1723701445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bPiAoXpK0JdsQyNpaN7hZCrHpa0VhsUUiY7QeEceZ+E=;
        b=NP0YGdQe3JL03ehA0Kh3ith9jrnA9w9znZklebVw+lb2S1yiTFdJ3raIoMFJKEVK5b
         YjTGwB/FYbbw1yxhYjIgYw4ecitSAKuczbI/Ka3c+61TnHoMBXfZmLgYmXV+r8FrdIpj
         ZOr35VHIVG44gdk7c+c7nwfJk5lMSAX3k+DBdISmWjIGvQujwc2AvyG5cYZZH7vMClq0
         27qUFnyQLQ71JNrxBzh+m6RBuAqSMDwdZ49LWi2JuIJntAka51AYOjvu/aPh7mdlQhIN
         JIdfjtoVKtUvMvPRCNX64UQrxjZtn0EwIijySOaDwkuGH5XkdWpkiWlfgPU9iDQZuC1U
         I8NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723096645; x=1723701445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPiAoXpK0JdsQyNpaN7hZCrHpa0VhsUUiY7QeEceZ+E=;
        b=PRfnBglvDUSrJjcglxLHroQmxzJhNOAP0xyZyhk14MTxukwuVawH2ucrvLSCZ4JeJI
         AFoLi0tC/05mS5+HreKuPeZp5/md3bSPNXhIcwlXETiXi+tSzIxf4ekqkJYfp7R5wDc7
         T0Nc/nS3Uvchs9ByO9TpP52mfl/3eLpdKdj7arfWJnSIcvfkxx8MXKI8TgBzCNV0E13n
         /azrW28s8Ky507TSIOfaS0LXFeWyQ/fCXSarjkxq/iDZ5naXO7vf4PITO7T6UQ7obhsR
         K3t6QGcApo1g+SV+6Q+RESbq0YdTp1MXxsP8R5M4/yuhcRHvbHi+gDGUzpok+kqQSgFS
         d5rw==
X-Forwarded-Encrypted: i=1; AJvYcCXXnzcv0uEdQzPbksAaDM7d7fx59ejklMuLQI00Tt0L2d5cq1iChoJ+i0iNCY6l2NrV873B3G5A22aHK27UVXBeIQi5j0XL0y1uX+QqAHuvxsydTaptFR5QbIU3nCe12i62PyZorwGh7Q==
X-Gm-Message-State: AOJu0Yyb/eqkV/S1tt9mxvSmp7SVO+bsu6f/y95Oh95FkPZMPhusKYiV
	EJxq6F58gaq112TL9stDpMOuDD1hbuTXSQPlwHLDjg2/0Sx/oIw5
X-Google-Smtp-Source: AGHT+IFOK5O6efGExDbiRRC8zbPf8APmGN3SBFAmHarWVs0d/h+onpCcwSHzigQsOOkJQdmzBFsYXg==
X-Received: by 2002:a17:906:d249:b0:a7a:8cb9:7490 with SMTP id a640c23a62f3a-a8090e4e094mr42616166b.47.1723096645018;
        Wed, 07 Aug 2024 22:57:25 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8cc7sm704287066b.215.2024.08.07.22.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:57:24 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	devicetree@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] MAINTAINERS: Update path for U-Boot environment variables YAML
Date: Thu,  8 Aug 2024 07:57:10 +0200
Message-Id: <20240808055710.19292-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This file was moved to the layouts/ subdirectory.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
I missed this MAINTAINERS change in the commit 1b3f5b88c541
("dt-bindings: nvmem: convert U-Boot env to a layout").

Srini: I believe your policy is to rebase your tree and send PATCHes to
Greg during merge window. Could you fixup above patch with this change,
please?

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 760cb3966643..e299bcabe2e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23444,7 +23444,7 @@ F:	drivers/media/pci/tw686x/
 U-BOOT ENVIRONMENT VARIABLES
 M:	Rafał Miłecki <rafal@milecki.pl>
 S:	Maintained
-F:	Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+F:	Documentation/devicetree/bindings/nvmem/layouts/u-boot,env.yaml
 F:	drivers/nvmem/layouts/u-boot-env.c
 F:	drivers/nvmem/u-boot-env.c
 
-- 
2.35.3


