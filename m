Return-Path: <linux-kernel+bounces-416558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33589D46D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 05:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27231B23D21
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 04:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D003142E6F;
	Thu, 21 Nov 2024 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQ59fLjx"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C4F230992;
	Thu, 21 Nov 2024 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732163786; cv=none; b=cbeSHdFyhEKIgM9GzJCXQtoo6OnvgMHfyGWI+zEu74glk7dexOYzPnl4RpAtNktjmIbH1Uoisxasydn85KVfWXwM90UlpPiLcqK7ohBGLmXe4yKuBBNjPvcFDOAPEz/rNltD+w3QW/0WcMXoU6qmB5eBeHjPFs27iR7HPy5WurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732163786; c=relaxed/simple;
	bh=381WngC8iKFV1PSpDa07H1nZ9xgbAG9Xckkdyqb9St8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nAzdVP2oRic4TLP6oqi1jX6eIBkD4imBEw6cJ7on+99tKagD3qtIDf7fOmYU6GiSAj83A4E6cq9dfwt6rYfQTqmwBrtXyCTWkTJpOTtFVn8mPnkt4J23kWC8hNCRFl8I3kyPmL6kB3c9Z4Pu2glm5Z8yfEw2EPquEBUmGULk65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQ59fLjx; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e383bbcef9dso428025276.3;
        Wed, 20 Nov 2024 20:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732163784; x=1732768584; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gq+ad7sZfGrLxQrmLaPQvEe+2stpRD0g+Leamoq1YOQ=;
        b=BQ59fLjx6AKHkyB2/OaaLDKvXlrKBHnBZ3P0qA6FNalvy5DK0mJ/5jeYVb1At+TKLO
         mxdwwJnZmsHlSDOe1YDrPkCZ+wIxnnBosYt++8WBooFlUdZlUJEKG7zeIxDVBPwSV4W+
         j7ywwqCcaBprBLAwgnqAokdWE/sam6h/zK7cgpl7nJjThsNGKMTffx5xcxPjWbbPTzVj
         EIpPfbteCmnRNLajigaGEBCCk8bhJW/SDis8HROn4rT77+DxpqBgwlPzQ1e579kfYRGT
         mNj9tezZ5Ijqg2LHtpTTDvDsHxkQbpI4Fl/hqZw/1Na1CwHbAspbegOetUM6Sw1Japm/
         ilDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732163784; x=1732768584;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gq+ad7sZfGrLxQrmLaPQvEe+2stpRD0g+Leamoq1YOQ=;
        b=D1PlSUP6LwnU/EKb8LhjAFhh18Xw4EVIiEK1Sds4fnvZN2azLoN61WrseQj2RlwFhG
         AQBvzI6yAp+DxcoP9Il4QZGmJZZ40tcM+MKTXvEWov+OAvbLWUNhdq3H8lpH9Lij0JSC
         OAjFpZ7cj6Ape+hibX/Bzay7x+S4yGqyzQu3UQyQY7/qfQiJN3WEgsiurWPIjI2Ci77v
         j9OoQaNIuZcCpCipwchFa7MvvH2UwO+7mC8t8cIeWS7DTOvT2edJH7dUPUy307wKS+xn
         vLDDBCOslYUl5DAFHgZuejj/3XT3vw/FUVxOVg8g7vYYFIvVQI41IS5gUQAjvqRLuqFY
         Ft0w==
X-Forwarded-Encrypted: i=1; AJvYcCU+CR1cyuiHpD4Gg2ENdZM+noXGs1kP4LFsY6wRnMvWY7IGvc3ruIcLu1p/P8dGd+TrPf24h2j/lnNRa7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUqPDqLw237bjkg4UV5UHPTwNqaZcj8Jjo+p7byURM7HXUnbgr
	71Iy2fcq/jsbxaAX3EOupqRliWUtySgk6vcnVhU7J3t1ijueFlHQ
X-Gm-Gg: ASbGncvWgEF4v43fd4ac1GO9wjciRpTzFoqFzFGmWXGLKkcFFVFwezxbZQK0qiYny1m
	IcEs9jIa+xDb1jWgapZa3csN2BerwIn0TwIQHauLBXqQQkeqrTsyuTkMR38SKeD8r3rCSSRRxv9
	iP96RSohQu6kZmACatEH3fcG7yTnnF+hSLd0m9I7n982Wup4RWVU06PHlu8fgcL+ldEkSgtfvsV
	Tjjdl9wF4cRgs+PyK+SYCsM4hmth0z6XXjEUQ1sSaWmjFyIbJLJUpf0E74tm6jWUAPFxiKY759a
	TiBBZj12+FGAjJMcX/vd7F94vMw=
X-Google-Smtp-Source: AGHT+IG6v9ry8rNPMTv18xrWoIOcEji23ZUnLH/q33uEBsqANBSy4agWkDZk0KmSDWfSx0CnygepHw==
X-Received: by 2002:a05:6902:18c2:b0:e30:e1f3:2a9c with SMTP id 3f1490d57ef6-e38cb3cfc5fmr6450392276.0.1732163784062;
        Wed, 20 Nov 2024 20:36:24 -0800 (PST)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbb64e11fcsm402013a12.15.2024.11.20.20.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 20:36:23 -0800 (PST)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 0/2] ARM: dts: aspeed: catalina: revise catalina dts file
Date: Thu, 21 Nov 2024 12:34:03 +0800
Message-Id: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADu4PmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQyMD3eTEksSczLxE3ZSSYl24aKqxiWGSpYG5oYVJqhJQb0FRalpmBdj
 c6NjaWgB6tcObZwAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732163781; l=647;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=381WngC8iKFV1PSpDa07H1nZ9xgbAG9Xckkdyqb9St8=;
 b=h1qEWQAugQzZbGZaOABW6eYNn/tU2euJILA3NbFag8tPDo0xTstUA80jjiwz3tvv9IZAxBccc
 fZl41CP7LWnDOZrzSz1yCjzHIZR9KIn9VwTnPzNBZU2Lrk9f8nXcu9h
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add following patches to fix issues.
- revise ltc4287 shunt-resistor value 
- remove interrupt of GPIOB4 form all IOEXP

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Potin Lai (2):
      ARM: dts: aspeed: catalina: revise ltc4287 shunt-resistor value
      ARM: dts: aspeed: catalina: remove interrupt of GPIOB4 form all IOEXP

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)
---
base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
change-id: 20241120-catalina-dts-20241120-e341b907184e

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


