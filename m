Return-Path: <linux-kernel+bounces-399900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74DC9C0609
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90C01C20E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3E820F5A1;
	Thu,  7 Nov 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDuW0tWu"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DCD20EA5F;
	Thu,  7 Nov 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983343; cv=none; b=LY7Mtz3gpkQizElSTH3dJaij4LmmtUU60y8n3c4nUp7vTrMcdS9/0aaRhpqtQFp+ok6p1p1d9xy1FJWrqEsXkvDacdePRFo43nUWAaR6ZdGUo3W8tRkTvhPlAnNcudzOH/a1UltO8LyNCzZdqtUPsqU/XxZFq7WWHgXNVuvGXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983343; c=relaxed/simple;
	bh=fDEBLfyJb9nAn3ipO12nV6wnAto2tMxREdWJ9q5mc7U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fDbKjW0vYLgp/vLHhvy99ayWGMpdT8T6Nk2zdqjhygxHTrZ+Y8KHBNfljuR4A4kjNUQEu0NbHRHO//9AZa8sdEDd8AURWMPiN6KAIOoCVI59n+xGDUW8KUmrDc+hiSo5kIK4w8tKFju/jxzsNf0SYNeyGlubwckyR6mogpg06gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDuW0tWu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c803787abso7972715ad.0;
        Thu, 07 Nov 2024 04:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730983341; x=1731588141; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=youLRMmo0sKknJq3kY6wxMpo14aMmgxOgYUVVaBBx1Q=;
        b=fDuW0tWuuZSkZjxzCNe2e1a5SasvQEFu1XrDBPP0kOqJchKfMX9lD37XYaZMF8606i
         OUgm+XUfsAlKCdoHKRPUfATzJe+GVOt5tJeWFljr/yz2Fo6Bhf3KwkLPAuY84eGc+skI
         g53SsNJWeGNVTKWmrXLua+/4hrOASOuZbdoe6SpwKxMtt1WNNUGdUIwHH/DQMNYSiGqF
         wMd5y3pkF3EEiEmWG/IC3aNulif1iqTI7eKnjCD1ID0IlSjnNwJNTG4AsFWzMRabpCew
         AHsrZyDlRlS7UmyiTlK2/IZvWUdC3waDffB6/1avfByaWiLVTeL1BBYMBHgqO73qV8xm
         DY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730983341; x=1731588141;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=youLRMmo0sKknJq3kY6wxMpo14aMmgxOgYUVVaBBx1Q=;
        b=fFQmnXhL1tGqq+5SgPxmMWsyAfcRXuG/2UirHTEENiYhrEBGw86Vzfk07JoRbNKxuC
         04CBNj0BYVfe6Dtg4//g5btuuiLpJO9Fcpx4Zke4VjMPBiie3PhVG2F7Tw+8Ov/ivQTR
         aXw5P4MWDT4w7vedLFmXiWqHorz3j+ys3dFbILyF8uoIpv1ACJKUuZFCXacwUasjZDxO
         l2Xq9JZxiEv0P2fovH/v1dnn1lsT62/RpuLueKtFGdV+GyhZchmcagENXSwiT/Ps37eT
         Q2aC4HpsP9AeCbWK7e+5O9+hS79+OPwTFqND8sFQ8plIurp4+a5FlZpjfQRKOeAoXcU+
         eEZg==
X-Forwarded-Encrypted: i=1; AJvYcCUXjIvqI/A5lTtKK7yJAvgv8dV3qQwiNOwnnlAGXSqLgAe9wg0tTf3US2JywMZOMT10Mft9SK6vmBt+csE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4J+zLTntF0F95mdiBmO9Uh3VoJI+PjYU3m85epzApm/gSxP4B
	1FMZnhqJ+iiBqpoxibiYXFDfqkE4LdQxYBqaFQSmDtjXrv7qcHw+
X-Google-Smtp-Source: AGHT+IGEXo60WK+bnzWKZpp/tb3i21nIWbMBqygL8tAiAdUOQebmGHeK1uuGJEibdV7evN/corYGzw==
X-Received: by 2002:a17:902:d48b:b0:20c:da7c:6e8c with SMTP id d9443c01a7336-21175a93c02mr52725505ad.3.1730983340762;
        Thu, 07 Nov 2024 04:42:20 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e412d8sm11101975ad.113.2024.11.07.04.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:42:20 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v2 0/2] ARM: dts: aspeed: catalina: update CPLD IO expander
 pin definitions
Date: Thu, 07 Nov 2024 20:39:56 +0800
Message-Id: <20241107-catalina-cpld-ioexp-update-v2-0-d7742eabc0e6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABy1LGcC/43NTQ6DIBCG4auYWXcaQGJ/Vt6jcYEw6iQqBKyxM
 d691BN0+XyL99shUWRK8Cx2iLRyYj9nqEsBdjBzT8guG5RQWkpRoTWLGXk2aMPokD1tAd/BmYW
 QNDktHkZ15CAHQqSOtzP+arIHTouPn/Nrlb/1r+wqUWCpy1trO9tW4l73k+Hxav0EzXEcXxrhO
 nXEAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Potin Lai <potin.lai@quantatw.com>, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730983338; l=783;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=fDEBLfyJb9nAn3ipO12nV6wnAto2tMxREdWJ9q5mc7U=;
 b=EKVMgmy3zl5agoZHAZ4L/s+CG8X+hFuX+tTz28Z0g2vxOKOPzhCqGMqrJw48x6vluGrArZFlA
 FR3h5HtOXxxBC6dMyMqO51uFbZ63ua2/BTAb8HexQTzfXHtdyEkt81E
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

This patch series updates the CPLD IO expander pin definitions of PDB
board and HDD board.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v2:
- add more description in commit message
- Link to v1: https://lore.kernel.org/r/20241106-catalina-cpld-ioexp-update-v1-0-3437bcfcb608@gmail.com

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


