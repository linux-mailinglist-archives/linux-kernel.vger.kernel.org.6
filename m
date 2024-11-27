Return-Path: <linux-kernel+bounces-423125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D449DA330
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54741B23531
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D0178395;
	Wed, 27 Nov 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmN1+zrR"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692521547C0;
	Wed, 27 Nov 2024 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692984; cv=none; b=d7QX3JVnZhQzuygNngz5UVrFu6juZ7PeLdYskvYAlowtmVCAC/lHpkO0XfgOxZ551LiEfD4bJ6g7FvJdmNYZzyaiYO7CNaC7iK1B0X708VXqmItKQP7+dJNrTOqQBD8wm+Ksia8djNDyBrZhEuir3wzKiBDDdALrUFhWye5n3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692984; c=relaxed/simple;
	bh=BZelmbIiuRBBJk0vXPrcjah2RN4zEn1GPubWkHVurvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oey8OMcdfQxm+TLH21p+uCpExsNfkISkp9DSagMN5QRSDT1yhPD2AZ/IpGz/U4muT6yhU4evtzGF0JHrAR20z28U987KadAE6oAikqbzXr6vf3l7t1ngmatFC7XGshIi6LoXqWanxDZpcdwjnezejHsooRvmAgIPpmiRRIObULg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmN1+zrR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2124a86f4cbso58136725ad.3;
        Tue, 26 Nov 2024 23:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732692983; x=1733297783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy8cPLCOovByR7duSkHnLMlAAw1x2JYUBLYA70d2EL8=;
        b=VmN1+zrRpnXRPxYM4O35A3GJRjYJLdyQc3Mbge+x5xQUcLMDsoT4aL7O0BXj/K5IDr
         Lj3WNUq+tSl1cck84IOdTeR0H+Tsl5GfKBpb98fIY+uhBYMoSC9iRKkg5vXjEKHr1/I4
         wAo1zx6dlDMt6dYoXFFMu/jQhBp9WdX5AX0TUZaFSNqcG6YYriqcCXu0+1UozT47oyoA
         KfOnAwsNY9uKKC8jz4NIv9kiYGa8lRsSJ1Jw18IaJKTVbL4dOyw1Nbr0RCtyv6FyE8G5
         tETi7rXsU4Ft+JELNov+hNBL59PicrYn5Oegaea7BAsvehcBVediKW84t2AzVoblFRmf
         dlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732692983; x=1733297783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fy8cPLCOovByR7duSkHnLMlAAw1x2JYUBLYA70d2EL8=;
        b=M4g3j6/7XzmbpgKIHkMMwUPUXeisVZTFQtZHpScrcblnFkALVep/bRYJhVAvvaRsS3
         +z5+2/roBtBWkfQohSghCfEynlq4ABNSdUuUN18VDnA09qhdZwUfU+bKhvS5Fpsa/iy1
         mlDEqurQDFC98UADBy1p11nZXC+GXWPrJTD6JDatABMXJRFl2+OtA5UqKSDsvnTm8XUT
         02hRAqUBUUSFxHz+kEm31IIYfkX1CGNryfvUpthXQhs/kUDX8HwMKeC1S8NAKElt8jaZ
         fr6TlHXHdUrvrGG7TK5pCksAwreVaq8uMpFEvKxl3Y44wQ+nejvBDBKatsMTMRn32Yub
         QoGA==
X-Forwarded-Encrypted: i=1; AJvYcCUgowxMV4dKzZcPYbBDptKznaJu70tadqfd88DsCcl/L1ZXn4z2AZDwTFm8/LgKHG3mUQ3AjHXE+yu4Qdmj@vger.kernel.org, AJvYcCXoCrde0WFM8tS2UCRdRnN4/ojyE8SQlVQvGohZ16+CXLjzFOxxmsTdrxOM0HG2aGvEwvPmGuwX6IT9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1HIBd5c96DLQW38io72/+X2SZcJtj82049umRUhxw2TBd9vh
	kpxkxnZH9UOpv2LcIJi4R9Dz0oasiVuByuItUrkklHsi2htHp0s5
X-Gm-Gg: ASbGncvSuoNU4yO9+wSIesD0ipNTNP98rv+iE+oAHTyhYfdlsXm6Dtfeu6vFFCDGfhH
	sFeKd/3kmkFx4Wk6mJ9TztNFRddVFmkjP0eO/Qd2gwNtw8miF4G0vijocMNSPvBh1jXkcP0dXBx
	sa1aGsf/WcnMyKFZ9g6kwslcLi/OhF5JR0Q1fem0J9bcidwDmMv0uSV2vd7rqb3nO5IQWKpVQx/
	ioyIU7oWx7Av5wiS6tC34v4SgIN3O0ukeFJgXe0x7EBc8kXvMWcT5GFben6o0RUhN755X+yLhCl
	MkkuvmNC4PF2nKhHIUP3oHd0lUCtiHlLs+7+eOA/audUE8PZxywK1e5BfoX049y9
X-Google-Smtp-Source: AGHT+IHNTUQ81YL/jM93lEIywiHdpzGHp07oN4iZZhDd/1Fq5BjO2kzmAdEFYgPuCUXoBa1FrIKwmg==
X-Received: by 2002:a17:903:98e:b0:212:3f36:d985 with SMTP id d9443c01a7336-21501e5c1e9mr30168905ad.53.1732692982407;
        Tue, 26 Nov 2024 23:36:22 -0800 (PST)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c645sm96597095ad.16.2024.11.26.23.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:36:21 -0800 (PST)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH v5 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Wed, 27 Nov 2024 15:34:07 +0800
Message-Id: <20241127073409.147714-1-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Linux device tree entry related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
---
    1. Modify email content.
v3:
---
    1. Add mail list.
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

Jason Hsu (1):
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

Jason-Hsu (1):
  dt-bindings: arm: aspeed: add Meta Ventura board

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 877 ++++++++++++++++++
 3 files changed, 879 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.34.1


