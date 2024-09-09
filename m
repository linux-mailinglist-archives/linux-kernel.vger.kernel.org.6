Return-Path: <linux-kernel+bounces-320840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499E971137
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE039280637
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43D1B2ED5;
	Mon,  9 Sep 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg4ZCAHC"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0391B29DB;
	Mon,  9 Sep 2024 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869225; cv=none; b=ToMixhIUNtghoamJE4ifZwpbmfjh/qowMz8PQ0GmKUMNk6CqbwP0dYQKpjbj9fX6Uc6iIeyjpae1vlnxt0MgJ34wZtjDrTagk4dGAjEfvQpozP4i6KA+GPgIvUUYYrlfuNsNloPcpDNDqSy+qvjpWpos/z6cpvC0DxIeqD+uIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869225; c=relaxed/simple;
	bh=zIw3F30sM37Fm8BqIZ3U2zAlUIP37CoR2oDGkp8ka2k=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Ph2SgPpx6rV73AVzPXZb3fYb40RAXA+w9b8oT8A2T5ZJsL+CcgOywMfcO/w0ZNb3P28O1kRxeXOJfCwgiXElwdZuUK6WA1fOkaLBmatWq0sBs/9MqwgyuQboQS39YLBugk66sP1TE8I39FfW1kBlaSoFougWA537CepVWkAJCYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg4ZCAHC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2da4ea59658so2886337a91.0;
        Mon, 09 Sep 2024 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725869223; x=1726474023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XsoTzFsLsOI/w258RMCU0+gqn7DEsQeaEMM3PNeHoEE=;
        b=dg4ZCAHClwb7kMdWAqXGLww1xjj0hXl+JX7vjZ0Jags7XIFxWpm7WaFjJx9JbOzCtM
         bk3Y2a9SfvvGkji9f9j5/E8StoXvSkVU5jG1hc+uRpLGr4SBCPr0HfXEwM5TN8olzRQ4
         QIUXOGe+auO4zOQV/gydMV371Roa/obbsIitwj9E4Kz8u4/31WxQzc3yGKy5YBuwqRNS
         V2cX9eElPWr6YBVLagwKwsZqyNqUs+PSF5prePPHSZKsKeb9yO/4MuFTFKZSGGRcKQcY
         fbRVWIj8dTMJSIZx1QVOKdfwH9kUobRp8DAZOzKOkAp1q7M8oeC0ly0D6KyEaVA+LDa4
         hNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869223; x=1726474023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsoTzFsLsOI/w258RMCU0+gqn7DEsQeaEMM3PNeHoEE=;
        b=jpF0TFwF81V8X6ztnjNMMDRydPwVCL4R+7EHJBg+clFPjecCBHE/JBDGxjCMZARpM6
         5nssQ/t+Gm46J6vFNqBTL+nMiGh2XiVuOX0BSIAtpcG66kZShSv3CwYfcFWxzgJKDxC5
         R++CaEmeC29tVO6fCS10IkMs8zbfHvWMrnV5ook11NIH2XWCD94NwE9B+TRx/lDFDerv
         29cXRbrNsgSPsdWv9mZ+t44xFmszrLuwdeql1pzHTcthiqW31tQbAa05MPK2GOfaewZN
         CXnlXJSlOYpXJcNdnK7UjS1k5JkwPW11lhgVtNneTFjBn05pebzMPdT0TvFcd2ZtQUUb
         hBRA==
X-Forwarded-Encrypted: i=1; AJvYcCV8otzTZSM1e0Ky2965jbw37xTaCKzQGt5RGGKKgh88etKUdQ3SSCQew7ohqclREO++Co/ZvV3lW8n7@vger.kernel.org, AJvYcCW0OOuYI0BgYWS733G19OWPyPJbbeNvo0oAssNhpl6NGvB77gCMX/YSjyJKKIk+pQsWUcDiGreQBRsvvHKW@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjg8nlv/fAYn7w+TuwxAhaQJcq6HZGnleBqoEtmP+O5mMrtYw
	t6pe2ohuSqQXnd8lnhpmxfWmzRwLRIQYfuT0V5MstQ0r/oahaMaBgDzFOg==
X-Google-Smtp-Source: AGHT+IF6oXCvfc8VgYNsXQO/2GtRP6QDKcH1+YjF5irjxf2iHlKXOG8pmI561LrKrPwJlXTrMMJ05A==
X-Received: by 2002:a17:90b:3c83:b0:2c9:6a2d:b116 with SMTP id 98e67ed59e1d1-2dad4dde0bemr10713383a91.7.1725869223170;
        Mon, 09 Sep 2024 01:07:03 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db043c4916sm3917541a91.31.2024.09.09.01.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:07:02 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Mon,  9 Sep 2024 16:04:57 +0800
Message-Id: <20240909080459.3457853-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on: https://lore.kernel.org/all/799dbd97b09693fba6f837e73d4ef3421d604a8a.camel@codeconstruct.com.au/

v2->v3
  - Revise sgpio line name.

v1->v2
  - Fixed the mail and author.
  - Revise presence-cmm to sgpio.

v1
  - Patch 0001 - add rtc device
  - Patch 0002 - update sgpio line name


Peter Yin (2):
  ARM: dts: aspeed: Harma: add rtc device
  ARM: dts: aspeed: Harma: revise sgpio line name

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 45 +++++++++----------
 1 file changed, 21 insertions(+), 24 deletions(-)

-- 
2.25.1


