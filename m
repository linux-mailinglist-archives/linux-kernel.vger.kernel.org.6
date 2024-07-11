Return-Path: <linux-kernel+bounces-249260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB892E8F1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 130441F21FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F1F167DB8;
	Thu, 11 Jul 2024 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mofgraXs"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D015AAD3;
	Thu, 11 Jul 2024 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720703227; cv=none; b=f5kYiXS1bB9cZ/yvlhk0UKDUcIysKh906cDNnrFTuH7+G37XP2mWuntQ1+1AegycrMO7GgMl3V/IENMe76wsC9wm10UhwczcfCendG2PfFzbqhGGfVZ7KwxRTCykF2eb1NUEv1mbec0rAnPwruA3o7z94nXQ+htmVPTb3KyNsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720703227; c=relaxed/simple;
	bh=L//aq6g2sCb7brUZIQ6mvahCmEij6tQ2f9SWRglAYto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IN/VGh9mMLMp5hg22cr9BRKDdvb6Eh9dkp5kcWEqRWFg8Jt2VL2uoXVpRjOe0u2HJlF+XvXqbFUbYbHNJEQ090tt8RP5bPq9EGMkL7Ky5EF+LN2hNuRR6tATk0/4PcrBrRQksIPhx+hXHcs/nDmFBM6C7nlW+h8zuTtqmNAJjSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mofgraXs; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-75c3acf90f0so590474a12.2;
        Thu, 11 Jul 2024 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720703226; x=1721308026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rfcikbn6aIkgCMZzgFg/rRrOdrcIMJdb5nB1Tqsn+HQ=;
        b=mofgraXsu+ZlX93qNVNYA9t91w0JnUJ15y83ke4wVknjCvNVBwkO3Mz0XxoZQditVQ
         wK/zFdl3HLPGIv1y70z31sy50iOar5locaAjdf9GsyuIr4pW6h9JoMYmXokhNr84F8Jh
         EBhR3fb986n2hVacId5AKybvqHm79Pn9IQyuSwLZ1/JOs0GNLbwxh0qVuVIdIBrq0vkd
         54aU7P7nrhLy95vr3PpkjArUpa1vk+vOxJnzDbpUHXaEkBaxikcym7dfCKuH0oJ/HTaV
         qz8srgXfh+Q0fwLh0EqvZQmGI114/RO8lYLb8MBdoEUZFzY9p9IqMuk4T6I+eeu+NsjR
         jnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720703226; x=1721308026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rfcikbn6aIkgCMZzgFg/rRrOdrcIMJdb5nB1Tqsn+HQ=;
        b=PYJ+BPdMlmvpDfAUtkVN71LT81y3Sq8nbVVdw9UXPK9dJl2tcHdCPMyp8A9t+zy+MF
         PUlAaA/qHnhl8AbxyHVzD/Wqw+ijAXzsKRPdr/4jGvKvGSoldthZwKxk9tOcmkPlSuA2
         j5167Ccl4iWOCHB9zFzwTD7Zsun3xsP4QRBqG0QafFNcIWA4q9plukcYiDBlwW2QPpry
         LvdPMlXnRK0k0Cl6E/ZmdJ225+rvN8W9t//x90o3KOcvpwClNsmR6Ow7cVqhSFl1G0zj
         ATj0WqdruyfMx/wxyLtko8FOewp4ekS8TOrTy7Fl6ORTF3WogoTHNv0Iws+j2eEMfbfU
         41Og==
X-Forwarded-Encrypted: i=1; AJvYcCVc5ZmFPAkfvXzjxwxanRCgL+XXSUINy7YgLJlgLaI/lHHbP7GUbOfdHNupkmZ5BJjJYgePOH9bX3X4gcVw8vpPM6a8HMKU/gsSUFjs29kItaurQYrq5z7Waa0OB2x5jjuML1w769z0qg==
X-Gm-Message-State: AOJu0YyNBbzOEHziPQC5gFNniBDD0UhcpvKYpVRbYNyQEHI+s6XyPbo+
	aI0/VsOOCpIJvjbURxFa36d90zm3glP90lRM95l1s8WzWMujHQEu
X-Google-Smtp-Source: AGHT+IFKPXUr1OLuiftkz50lboHtjDhk7taX+ATRjV0+GBPX70PqRG6CCAlN4MArjw88NEwHKiUM+A==
X-Received: by 2002:a17:902:fc88:b0:1f9:9221:6c2d with SMTP id d9443c01a7336-1fbb6ec1c52mr55718315ad.53.1720703225500;
        Thu, 11 Jul 2024 06:07:05 -0700 (PDT)
Received: from obliging-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a10868sm50188305ad.9.2024.07.11.06.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 06:07:05 -0700 (PDT)
From: Yang Chen <yangchen.openbmc@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	amithash@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Jerry.Lin@quantatw.com,
	yangchen.openbmc@gmail.com,
	yang.chen@quantatw.com
Subject: [PATCH v1 0/1] Add gpio line name in Meta Minerva BMC(AST2600)
Date: Thu, 11 Jul 2024 21:05:00 +0800
Message-Id: <20240711130501.2900301-1-yangchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on: https://lore.kernel.org/all/f7412b65e1844ea9f3ad9fe5825e5d1da422ad69.camel@codeconstruct.com.au/

Change log:

v1
  Patch 0001 - Add host0-ready pin.

Yang Chen (1):
  ARM: dts: aspeed: minerva: add host0-ready pin

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1


