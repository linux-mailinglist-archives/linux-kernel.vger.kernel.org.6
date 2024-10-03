Return-Path: <linux-kernel+bounces-349646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B998F993
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 00:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15010281655
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992C11C7B79;
	Thu,  3 Oct 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GggXdu0G"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BC61C8FDC;
	Thu,  3 Oct 2024 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993377; cv=none; b=K2CUK94eLNVmo34EZYpv4g3MoSepED4mILHQW4Xs5ILnX/wV7ymNPh9yPd/CJLfT9rsbX3QyjG5TC6b9X/ISx9uN0Gt5SeZJwlfFNgeAo18o5rtqD8ylXW9PpdCBRzoWu9+xjLBuqRzeZNLLM1ffVfOWG5EBpJZQor0TcKmTLYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993377; c=relaxed/simple;
	bh=6n7+vbomkFbCPFn4RZgv3mf6HVQn76NnYlC5aA49agU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Se29vas1syeImCgFA1mvKlc/3eQCE5Cuzja1uXtFXZuL0aAvixT6dYdh+Jn4qAOAqBEWHaVk139ApGZyc0zwJNfDY/21SWgZVNx9G0g9/61NP90jJ6M4f/7LFrgcYkcindcx7ZKSJuiCzcUG2ZUPZZXBuIZCQgERDmjgU+yW8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GggXdu0G; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b0b5cdb57so18623445ad.1;
        Thu, 03 Oct 2024 15:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993375; x=1728598175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XoaMM0FtNY64LLsh00+XPndtkg5AZ7b/gyoqX8OSYIU=;
        b=GggXdu0G/9DrhD9JPVtwgLsNfYcxAktdl6RFFsuFGjmF5ZHajXJyFWPldU/mDs7GiF
         DV5JX7/NyG0qcAbuTeXZOk4fozMBsaCNq9ehLWriKxhSjP/oVb6QFSLjiBA9O6Oo5g22
         Vur5rIabJXIrIHRzyLDyCKRYEKqYU4AgJ1GxjKbXObU93A1Z1c/HeZ9WZ+gs6+LAzisI
         fb572R9pLhVqEgd8vV3AC3bzpFqdcmO5V+Gy/yczhmeb17hrbtN2EwlYe742/ThAfknF
         UH/i25UkzXAn+w1xgozq66BEIR6t5Qg1KmanH//UP+y+PZXqLtg8dZFTGwREu2yqzkkM
         uBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993375; x=1728598175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XoaMM0FtNY64LLsh00+XPndtkg5AZ7b/gyoqX8OSYIU=;
        b=Z9OYxItrD1GBhzwl2ZCpNcn6iCz4famx3EJ4WvOE8mwhfE+3Rsj1altDgA5PEjN/+E
         QhMAMz1jbjQSdsU8JX1fIE6Zz+4NDR7CKobM2s0g6O2elUaVT1N0ypInjHYUh/MtQaqp
         Vk9yFGf0Br9DECV6T3Ku7oZqMLkczSMDvVPDYDtVCXJvNqsA/UPoRujKtO3B7eyv24BO
         6DpKD1oXnTvacFeztJJn+xeui+x0rItQqIUckGKBpN+1+xe0b9oYt3Ffp2L7pY4Uh5uk
         WGzLVxMpLxI4Q93I5bFYvsXLtwPIA0/PmN0AC4qSAqgkwF1bt0BLckVPpRYs3YcxwqnL
         vJHA==
X-Forwarded-Encrypted: i=1; AJvYcCVydFKitTPMXEW15Ho/JO488SO8ZE9ZyV0iK76lCS8jpIWWfPi4doIkAV2OUdAqpJKBhe/zCpIrniLhutkz@vger.kernel.org, AJvYcCXpWQzuXPXmFlJMC6UaV5NUnndSS4oL0atVeEnY1gIICddYBeKblDoT5C/Abj8BHDOStzP3AAskdlam@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZQhpxmO2nyQrx2tctmwH/uygGdtOO4+fhYkXTKL8Wb4/Ys0b
	S+SsImdx6+mCP2dVN1YDRt37lYvo8D9pQwpBoR5Y13FoZFJpIu8Z
X-Google-Smtp-Source: AGHT+IFYkjkt7nmGJX7sb7jqiPRkeeZ8yMA1paTGlr2Ko/zp9lZlmnRQag2WkG/aFdZcdXvLkL1yyQ==
X-Received: by 2002:a17:90b:109:b0:2e0:89f2:f60c with SMTP id 98e67ed59e1d1-2e1e5d63376mr884854a91.11.1727993374925;
        Thu, 03 Oct 2024 15:09:34 -0700 (PDT)
Received: from luna.turtle.lan ([2601:1c2:c184:dc00:b8ac:3fa:437b:85fa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e85d211asm5976a91.14.2024.10.03.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:09:34 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	William Zhang <william.zhang@broadcom.com>,
	Anand Gore <anand.gore@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/2] Add support for Zyxel EX3510-B
Date: Thu,  3 Oct 2024 15:08:18 -0700
Message-ID: <20241003220820.1345048-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello BCMBCA maintainers,

This pair of patches adds an initial DT for the Zyxel EX3510-B "series" based
on BCM4906, encompassing the EX3510-B0 and EX3510-B1. As I am not aware of any
software-affecting difference between these two, I am calling the "series" one
model.

I found the BCM4906/8 support in Linux to be in need of a lot of TLC, and have
just sent a few patches necessary to get Linux to boot without crashing on this
platform. At a minimum, you will want to apply [1] to resolve a panic related
to xHCI not initializing. If you are booting through CFE and want to use the
secondary CPU, you will have to apply [2] as well.

There are more patches to come. An issue with the switch driver is preventing
the WAN port from operating, for example. I have worked around this locally so
I can confirm that the DT I am submitting here is correct, but I will need to
clean up my remaining local fixes before they can be sent.

As always, thank you very much for your continued efforts and for your time
reviewing these patches.

Best regards,
Sam

[1]: https://lore.kernel.org/lkml/20241003211720.1339468-1-CFSworks@gmail.com/T/
[2]: https://lore.kernel.org/lkml/20241003213007.1339811-1-CFSworks@gmail.com/T/

Sam Edwards (2):
  dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
  arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B

 .../bindings/arm/bcm/brcm,bcmbca.yaml         |   1 +
 arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   1 +
 .../broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts | 197 ++++++++++++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts

-- 
2.44.2


