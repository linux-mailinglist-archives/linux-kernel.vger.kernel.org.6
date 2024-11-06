Return-Path: <linux-kernel+bounces-397860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B85209BE182
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C92D283C47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 09:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B3F1D6DAA;
	Wed,  6 Nov 2024 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzLpq0cj"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562631D5CFF;
	Wed,  6 Nov 2024 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883686; cv=none; b=Mxvbmk6kex0LRqdxjOujxaj/2xMGfK1rtO5/3rZ5D3SQe0N+QIUw6n8zTQMY4v1fkcttVpsgL90C9ND10uKtfrQmlS4a9GR+g4Gjl6OArcMixU7QLFlj2DOXx/fIIeOE9C1nY/OQpiAn8srme+H4s/hGx+FOZBLHKHjCXj5x8QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883686; c=relaxed/simple;
	bh=4PoFtxt4Dc071+Aor3cOXjBAyVvWgANaB9cgnRPVnao=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=flK6h8DU7+GLaelXejfEa/nNnzAYnAfp5hhq4nEQTruiRiR8Q2N4HwrkVHP6H0U23y55pcMLkLAMbk9jcoLCS5/+MZ3O1JADe28BylxzcbzFdaQEjKDqpYhsO2xkadWS3Bi4q2AR3VxtcyRfhabUds9z137RT6BdWXCmSKy8hyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzLpq0cj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cd76c513cso50703425ad.3;
        Wed, 06 Nov 2024 01:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730883684; x=1731488484; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dN34SSgBwYUCwi/Jxu+wRXh/eB3/vsROfybEBktpwsg=;
        b=AzLpq0cjaMOWrRD777LKtyQrWqrrpqoSqTS/iRaFrbK5XiPWBJ2G5lMzBQiomNMZgD
         1qE/UtokEEkzeIptKBX5gYBlryuKNM7ihji8JlgwvQtW4zlSu2lTjnpc20BdzsCTNbdc
         wV2CM/2EWldUf2wCHh1IlQ7m2Dmgb31P4sh0NAAlOXzeId/XgN6huJqM8/KVRewbC7/r
         6rnwZgx+qnrSr9/TDDVlI3XdtUeXl5oeNjX+Q+/blf4Rvj8zPel06rO0O6uM3yAz13Lr
         QNEX7pUaeLK1ij5Cnx6hGfh8McNmKbYkiv2YPIMQ8Lau1tUSbBw6UH4LhPP2eS4Yp8gO
         VnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883685; x=1731488485;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dN34SSgBwYUCwi/Jxu+wRXh/eB3/vsROfybEBktpwsg=;
        b=k2poSw6EcOlCehVWsbr+8gSZHI1w8hk2nhoXCYD56lwqVvemUAKLimR0vX/KTuw+ll
         qe3gNiYZ+zsVtXY7f8AGzQRfemttw9xl7/3M0XtVrfdeBqWndspGmQkuxMrk/FXmKKvP
         k3L5Ek2NDsbc2RJVOV97sbJ0uWBV3+gn0aoF/j+kZzZRh2jYkNz66KLKEIn2VPtsLGMo
         eRMaKw4sGXoYbe6xS8nxQdD3cpTmXiMUvLQen/ThXP+V1PQoMteh9Lp7qhqS477bjT/t
         ebVnrwYLAhndQv+FdpPe+T8myUVdChLiGSr6ay1JuTyybooV+C/rLEE+JgA0D3RwsQiM
         GSZg==
X-Forwarded-Encrypted: i=1; AJvYcCWzvsav9hQ2qomp7F6C7sekeXONB5x5s+XWqFtyYqEaSMlXjYdS6bbn3hVPb3bo5NPAa2iw8+L+ysFeqjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw9dWU3VMBpRGYJvaoNd+IcsuorJU0F0kn4Y4gc1qkJSxpNLu9
	JHpp/n5MNaI6o9jHPvmgF7e7FpwjsmBnFK03zc5d6vNSajFRH48l
X-Google-Smtp-Source: AGHT+IGnkFWynLLU5/2Q69B9cDIhpvlGXMSFaoZSiGRLdCoNVTx1MDEWli01wkh9fzWNeKIA/izOUQ==
X-Received: by 2002:a17:902:cec1:b0:20c:a19b:8ddd with SMTP id d9443c01a7336-210f76f2952mr385802445ad.51.1730883684628;
        Wed, 06 Nov 2024 01:01:24 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057d380fsm91317665ad.240.2024.11.06.01.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 01:01:24 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: update CPLD IO expander
 pin definitions
Date: Wed, 06 Nov 2024 16:58:50 +0800
Message-Id: <20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMovK2cC/x3MQQqDMBAF0KvIrB1IQijUq0gXQ+bbDkgMiRVBv
 HtDl2/zLmqohkbTcFHFYc223OHHgdJH8hts2k3Bhei9e3CSXVbLwqmsyrbhLPwtKjsYERrdU8I
 CpR6UisXOfz6/7vsHoiqHUWwAAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730883681; l=613;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=4PoFtxt4Dc071+Aor3cOXjBAyVvWgANaB9cgnRPVnao=;
 b=5pNiHn4f7T6DPb7g/9DOVkSstHqYNgW909o72dsst+ZevKNbg7fFnzKUdhkOrOXHuHdJMWbEN
 uRzgp41XATMAcio4YwxNRdvph8iuwYd/tCnNeLHisu1MY0Iaj+/OQka
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch series updates the CPLD IO expander pin definitions of PDB
board and HDD board.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: update pdb board cpld ioexp linename
      ARM: dts: aspeed: catalina: add hdd board cpld ioexp

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 150 ++++++++++++---------
 1 file changed, 87 insertions(+), 63 deletions(-)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241106-catalina-cpld-ioexp-update-e4ed409a2fed

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


