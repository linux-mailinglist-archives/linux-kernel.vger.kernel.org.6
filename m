Return-Path: <linux-kernel+bounces-245002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EDD92ACE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 02:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F541F22055
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAF54A0C;
	Tue,  9 Jul 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ki/et6Jt"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574A6A21
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 00:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483483; cv=none; b=XLubkqUbTp7JWM9JV3cdpDJVvRJVIiVDxXiWIMVZq2ZleXCg9T7f1BOEAResYi1SWKqgN6ZBHK8uSQP7mSpbumIPrSD+iI8Z+N2jt/eGMZmtUlh7574wvJ2qKEUJdZT3a425q58WUEjiJ6152tv1LVSvNo1AKpT9d/PYlFUXHDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483483; c=relaxed/simple;
	bh=CcplRpOsc2IQpW0F7fmzZKrnITw+xywZk8xOyDhV3zA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JufXqpGZFiWLSDZB88qJxaxX1ePJSkaBiFHbMLqTX7uc56j7HVFXi0WrX8qWPeUzeFaPKK3TFgYgfAG90QvtR5pTIBgKlT8/Cy1HZHzTv3SlY3GSyGoXAJEp+2b3pyOSkLzuAc0u2UYFhx7+3S3mugM3qdUE6uw6Ha7Ew2fIb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ki/et6Jt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb3e9e32ffso18409015ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 17:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720483481; x=1721088281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deUyP1lnzXSH8EcZFR30xTO41SmIssiJ437rHs5VhV8=;
        b=ki/et6JtQdTkSw1jse2G7tiAKuRMxXLd8RWCNYD2urK7Wh7AWmAcLvT6A19JJni/Ck
         dORaomqGJCy51N3Q9WI694ZNCSSHZduBUHNxfvlnrDEIijBLtiXKdVVmEfnaAEDjggBd
         6Yggez68LzxpAOFVRJ419Oe3kj6A/osiI9E8Osaok8N3hk/2seENfVPdBZ8HxwAez9ci
         b/6vZrAsLcfAVF1cFtzwkzMHqkPiRSdNmnOViw8gmsXCjaTkxNhdrYgngnfxv3bluXUC
         DpYIyLQQp0sWSyIqfzVgxz6eqUBZC1scNvtieiM8H7YKTT4UyeIgYp9N82YfrYoYBRJo
         SRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483481; x=1721088281;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deUyP1lnzXSH8EcZFR30xTO41SmIssiJ437rHs5VhV8=;
        b=VBGeLhV8fx2CRYT+dh3h6Ayde/sBNTpBTZOa7MIIjsz4RoAcIkCr3b2F06q/PSnZUQ
         caevo4HRccaEafye4BOWezoTLD5yZVvrAdFEx+voQEixbuoA6p3XW8rSxGxyXAN4UXWN
         pBww4WHKmp8X8ePI60BUAEmJG4ml2pKQgVp/edEZijazusa41rkI1T691gsAZX8a+MOP
         Xlhu5cLUKOdXX2FwgFRL+ipZy+Bkdd0lIzg1xxRy1UeyeVbLCYIsGdzZPi+n8vepr28t
         V9TPsep5Z49m4rDkQ5BJPPeEKU1FRrDw+0uOQ9eJRR1PJm/uHUjL/qZJaDcSBz22dfry
         9QWg==
X-Gm-Message-State: AOJu0YybQkjcBYSfDSSWkkzEYqcYQExdmLQGkRZb7F4J5InbSrTLyLkS
	Y8M4VIdyvS0cTpoU9Z1h+LEL9yzQ+JYmtY6sgGirg6ywlnGo3dMG4sG+6G9gcro=
X-Google-Smtp-Source: AGHT+IFs7x43OcxjSvtALgJHbMeJIn5UQKNtxfa+ImhrPmMGPSqO3CtWrRCfaMLCXWyxXPGGDirJTA==
X-Received: by 2002:a17:903:988:b0:1fb:7435:c2c5 with SMTP id d9443c01a7336-1fbb6ec1c1cmr9453095ad.46.1720483481621;
        Mon, 08 Jul 2024 17:04:41 -0700 (PDT)
Received: from localhost (97-126-77-189.tukw.qwest.net. [97.126.77.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a3ca56sm4268845ad.118.2024.07.08.17.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:04:40 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, Colin Foster <colin.foster@in-advantage.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 =?utf-8?q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, 
 Andrew Lunn <andrew@lunn.ch>, Andrew Halaney <ahalaney@redhat.com>
In-Reply-To: <20240531183817.2698445-1-colin.foster@in-advantage.com>
References: <20240531183817.2698445-1-colin.foster@in-advantage.com>
Subject: Re: [PATCH V1] ARM: dts: am335x-bone-common: Increase MDIO reset
 deassert time
Message-Id: <172048348064.3996825.17911079931147794725.b4-ty@baylibre.com>
Date: Mon, 08 Jul 2024 17:04:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Fri, 31 May 2024 13:38:17 -0500, Colin Foster wrote:
> Prior to commit df16c1c51d81 ("net: phy: mdio_device: Reset device only
> when necessary") MDIO reset deasserts were performed twice during boot.
> Now that the second deassert is no longer performed, device probe
> failures happen due to the change in timing with the following error
> message:
> 
> SMSC LAN8710/LAN8720: probe of 4a101000.mdio:00 failed with error -5
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: am335x-bone-common: Increase MDIO reset deassert time
      commit: b9e33fd0c6f8a29643d3b6ec149d2a7693cbe902

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


