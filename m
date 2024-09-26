Return-Path: <linux-kernel+bounces-340013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7157986D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612F61F244C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 07:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54818BB9B;
	Thu, 26 Sep 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNDLovEH"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A36188595;
	Thu, 26 Sep 2024 07:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727334843; cv=none; b=PuDzhYJJFuQ7+/iMC32FvBtIA+RDEsMmlo0NloxQI5Ao3Yqj+41SFnwaYYHK5r/vx5GOv57IbJQchC0hEiH8O6fhIu7Mn6rJoJqGGBeAmIJiUIebVWmOaGVctIugaYZGa8K7y1rRygrhx0+ennYVhaBY/2Vxasin/9rNsFcPF20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727334843; c=relaxed/simple;
	bh=pKM9NTdihtjUsepqgg5XW6WK0UV4+xrQ48OpEpnh7o4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=f2HVTqrTqPk7XjEPDDU2V7jqtba78DNN2hvuyJ+V8bojmqTKa+f96ubCUlddQC6Rkxalog0NjmVZUmfTWkHwXOrC0QVFeAvUnSCDLSxC9dMzUahZtSGUaxh7oAJ0H3R13zp//3w8OjJ1WvxyFmST8PsRyc7iIJOyFqPu0ng2Ei4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNDLovEH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20afdad26f5so7908965ad.1;
        Thu, 26 Sep 2024 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727334841; x=1727939641; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7xg53lKxd/fV5L3yyv64N/7D3XeLu8B2zPZOc1OOJLg=;
        b=bNDLovEHxQXln97tcvAyrIIkagrNJg0BIzJxPnsiWUCSH5sSxZ3zlcNmX64Mk4Ig0U
         9GTVbZeFfJFBJQSjAAHCYqvDBlxTaKBN+oKbzZ/UOFFgq1aI0M/j+Hw8E+3I37WPzx7w
         NiX9sNlbXPbaqKtpZyREuRL5kQV7J0j6cwCqSNeM785lyzNi46r5Kvpj8lUSr4vji8cV
         m7y9sU9LETcCj5XicIRNtpbrBOoPA2CQm7Aj1Vog4k3GL7urvfr5v0Atttvy2ce9Hb1D
         xGOIqxMRvYehLSa3KgiHVoyWYGwTBm0zbK/4VShaKxmbIpx7f4bKBpMRiNxHMcSCzzZw
         KzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727334841; x=1727939641;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xg53lKxd/fV5L3yyv64N/7D3XeLu8B2zPZOc1OOJLg=;
        b=dmvbLDYvJOh+VQzRApLKWHG5GER4PbdfqGGRMLclyZMoHmrvEujlXjRAcs4V38awpH
         JJtwQISmPub9y/TE33qbRDgd+7MfV1pecPDYU5cSXjsjWQ+RgP4WHdtGx6cKNRp+Lx6r
         jdNGAnnRBXsIuhzy/2eKlA2v0O8PCzH7aoPu4fl028qgyN872ANcHs1FSgS1BBt1mpSx
         YmBDhZzYlpBbMcTcjBJofe4jjrBikePC8S3RGpywGXSoUFmZzb9rPAwiykYG8TgqBWOL
         +u1bAVZM9dx19549HzUT13pFJGcwMgRSYbrXxUIvEpI5ZCTuuEcsChNX5Ngt6z92KHxW
         MfZA==
X-Forwarded-Encrypted: i=1; AJvYcCVzQmVy4LQ2lgaaQGwy2EZa8YpvvDkcQpRZEaiRR8+bM3R6uQew/BSLnGYwd7Cw/ZGyLsv4Z4TCYzIuptI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrm8PtYbH7gvYtRtPfVKb9dA8kmE1XqtGvxIA1zOUcIxJc0P2g
	PMeOucltVCdxnKQLTWysHdLaU5kWfPJ6rWjzjroB1pYiW4WLMUy7
X-Google-Smtp-Source: AGHT+IGgetcHFe4KXGimiw8jXeDLO0mzni6P5pkGHGyLJbzUafG8Ci4pkGmfhsrJnqZkafkPJDFyVA==
X-Received: by 2002:a17:902:fa4d:b0:207:1616:60db with SMTP id d9443c01a7336-20afc3f8e43mr62700175ad.6.1727334841360;
        Thu, 26 Sep 2024 00:14:01 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d3e79sm2662906a91.27.2024.09.26.00.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 00:14:01 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/3] ARM: dts: aspeed: catalina: dts update for EVT and
 DVT schematic
Date: Thu, 26 Sep 2024 15:10:43 +0800
Message-Id: <20240926-catalina-evt-dvt-system-modify-v2-0-a861daeba059@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPMI9WYC/42NOw6DMBAFr4K2zkbGMb9UuUdEYWCBlTBGtmUFI
 e4ehxOkeMW8YuYAT47JwzM7wFFkz3ZNIG8Z9LNeJ0IeEoMUUolGltjroBdeNVIMOKT53QcyaOz
 A446PuuyoKHIaiwaSZHM08ucKvNvEM/tg3X71Yv57/1bHHAXWSsuqU5VQontNRvNy762B9jzPL
 wL31cXMAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727334839; l=817;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=pKM9NTdihtjUsepqgg5XW6WK0UV4+xrQ48OpEpnh7o4=;
 b=cBAWdbLSL9JNkjZULyYUfi3lgf0/a+kS/msvkL3oK/yp7M+8lQpkmJKViibHLOq+j+gj7QEQl
 vNhpqlCblhcBv+hqioDDYYVsXbHQODwp2h1aszQ7VeGdpP4OsXH1ngx
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Update Catalina devicetree based on EVT and DVT schematic changes.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- add new commit for change NIC1 EEPROM address
- Link to v1: https://lore.kernel.org/r/20240926-catalina-evt-dvt-system-modify-v1-0-84a27b47040b@gmail.com

---
Potin Lai (3):
      ARM: dts: aspeed: catalina: move hdd board i2c mux bus to i2c5
      ARM: dts: aspeed: catalina: enable mac2
      ARM: dts: aspeed: catalina: update NIC1 fru address

 .../dts/aspeed/aspeed-bmc-facebook-catalina.dts    | 176 +++++++++++----------
 1 file changed, 92 insertions(+), 84 deletions(-)
---
base-commit: e56a4f51601d8d874237557a359a3db0dc50b0a9
change-id: 20240926-catalina-evt-dvt-system-modify-386be551ef59

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


