Return-Path: <linux-kernel+bounces-260713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0CE93AD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 09:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510381F228C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 07:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99EE78676;
	Wed, 24 Jul 2024 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im/oUYiM"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD42D047;
	Wed, 24 Jul 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807050; cv=none; b=LuCADADOb7v4xDxiYXctFUgOYC0x4zRag5uOmPtpOZWDYtwNJ7FXrAA/hs5D5/5rI1jPVBFvNO/nsTsOzflqwM4hDbGO6fkvfiSu5P5hMKOo+5TISDOTVywe0NuCAjvbYYpYZzwzxaQ6U7Ttp7qq2LfFh8Jej0Qrs7K/ufZOwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807050; c=relaxed/simple;
	bh=YuV6ArA1Xeknabf2oY+P/DgfOtGp1wRcYZboNfCQoH0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cnC1Dj8s0EG0nRLDDKaDVj2+nWuh6Qw5L0UMnTL0JgvGr4EtIG/BshNGgkCOhfrnlbxuUhi3rlU9YQ4ASUm7sMzpNDyNoypIMlcVzv2pC6sWmTWbhezAnYfSBzWEYRHRrOkRqoKub+Qx+coLBcCHtGJY20THIEUDRNmlsGcKXco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im/oUYiM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso449053a91.1;
        Wed, 24 Jul 2024 00:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721807048; x=1722411848; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4F00nC0aEQgAU2JQcnZhvx+pNtSLi0UD2dyzclH44fc=;
        b=im/oUYiMROh5mLqQ8awSSIy/7hNB69lA3ql4CTncNeXbXWvWMsHeH/jyPrDXJxx2i4
         xWRfoqz83QaI950fOF9Yt9LiMnvwEHmzW+6GraZYfrjbEwhlI4dwSwu5rrI3RD+i31p2
         Vg3zoo2ng+UJeb3O2H2N2DCQbhASIuacb1N4dDGV/81PwDthyJtZ0zNWDInb1+0+QxSy
         4FoqYG+51to5C1r9lbLJHzaMQBarj/ecYPd8zVNWTemZT1ilTX9wAHQFb+RA699ymo/w
         zFzW7tphMXwBZxHLfvu7zaLIourHf20dTBKH1BOrx1Mlw9+kW8HrI0ldsW9uOlo8eccL
         Zn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807048; x=1722411848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4F00nC0aEQgAU2JQcnZhvx+pNtSLi0UD2dyzclH44fc=;
        b=f9auWH+Ra3RB5Gkp5ZRyOz7I9MqtCiOeXWXSpDtgigHrUrI4NLk//qwP6fAxglaHmP
         2s3kA2IVkxWvnLLGWEAcvxjM1976dh7KfVugnrAeZ+M2rFwFV1jEzX2BO84mTLiBB5hh
         3Y36L2vBnKim8kwq3RxB0awKcJEH402oSgtkP5o1JiE3H/mKQNJsuuVQOfWg0v8phrUB
         UCwxLdR6x/JCZ7+uTJnJnmhGP5CK/uibMtXVyy9hQb7uBKeXZnlnkS4MbodyUQO8lZu7
         0BR/k+SDWzwkhkogTk7UDEKFIw39P70HHvElz0ld8CX1PK19f6jg3lgBXSiGPw5SR3FI
         OBnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLttqrW4rEKfbLO6Tn5WAuEj+asEcckSgqstAfySbMe11UijBS4RdjA9s4EdP+b+/tDLRr0B5sFss9hWR+9p3bCOwmxs8BK6iO0tRG
X-Gm-Message-State: AOJu0Yyhca1IItxStyqui2b7b+rnykpoVvYexWbnCA2hHr3O5Xqsl50h
	G/UBPplvHCPtPcdwpHnApzbKDQbcBYLdV/IRV2Z3+08jbYvxkiXj9Jb7jA==
X-Google-Smtp-Source: AGHT+IH+AwD1aouWTaRvdXM6MuGKk9ijP8X4cF9PTF6xlLLizdRT0IHEkSF5UkMMP5UhMDiEV+RPRQ==
X-Received: by 2002:a17:90a:3983:b0:2c9:6abd:ca64 with SMTP id 98e67ed59e1d1-2cdb93bcbf5mr1736629a91.9.1721807048050;
        Wed, 24 Jul 2024 00:44:08 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb74b9ed5sm901067a91.49.2024.07.24.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:44:07 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
Date: Wed, 24 Jul 2024 15:41:44 +0800
Message-Id: <20240724-potin-catalina-dts-v2-0-ba8d475c4073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiwoGYC/x3MMQqAMAxA0atIZgM1CkWvIg7RRg1IlbaIULy7x
 fEN/2eIElQiDFWGILdGPX0B1RUsO/tNUF0xkKHOWOrwOpN6XDjxoZ7RpYir40a4pd7ODZTwCrL
 q80/H6X0/mljLcWQAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai.pt@gmail.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721807045; l=899;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=YuV6ArA1Xeknabf2oY+P/DgfOtGp1wRcYZboNfCQoH0=;
 b=zzLqfesCJ2y9JPuSPO3YM8JcLVFon8Vg59eJr7NsHxEV8Use4SeRuMO+trlUElrlC1steRYBs
 ObNcWYcZ2Q6B/SbfKI7vrtBnOcmzFl/wqzPv106AbHak9owKyYAwKFm
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entry related to Meta(Facebook) Catalina specific
devices connected to BMC(AST2600) SoC.

changes v1 --> v2:
- drop commented code in dts
- rename i2c-mux channel nodes as i2c1muxXchY
- rename gpio expander as io_expanderX
- use "stdout-path" instead of "bootargs"

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta Catalina board
      ARM: dts: aspeed: catalina: add Meta Catalina BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 1020 ++++++++++++++++++++
 3 files changed, 1022 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240724-potin-catalina-dts-fda1ea3297b1

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


