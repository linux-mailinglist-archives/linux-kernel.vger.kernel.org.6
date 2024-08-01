Return-Path: <linux-kernel+bounces-270793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF58944559
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32E21F225A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 07:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2671607B2;
	Thu,  1 Aug 2024 07:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Di1DrEkQ"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82717157E62;
	Thu,  1 Aug 2024 07:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722496927; cv=none; b=JRZBrpVSyJ9dkdVi7p3zSBByzTBE3ET2K1iIj0KYKRAjI5mMUX6tmMTKcQZ6SZO9BgVYUGmiVXLLxbMvkb51el8LU2eBMh9cxGW+eRZHsP7AfhXr9ugL+qNobE+7Ssl3f2cK3iynYYIMdn5lieaT6JN3UBsvg6NnX9SaPM9HXoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722496927; c=relaxed/simple;
	bh=ytA33CRTyB5bmAsMgIaDhmO7iDdK+HOHPKqh6MYB+cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bQgiQTJb+IT/wMoJWxmNEEUOQJfSkgXSO6YlHPp/V4rCUsfG1s1WsuYbNKNO6InnShyNT7d2ReVSlne++NcrHmGH7PWWqpwx9axvGSGxTuMe9/lm47ThXYRYgjS0dzbK2k8RDUagyZdOqXgHDJQ9Mhd8usm5HnkvYzQcbGZJP2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Di1DrEkQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc57d0f15aso3945815ad.2;
        Thu, 01 Aug 2024 00:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722496926; x=1723101726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5saQIelnl5OO8WPHKquus0jHfZjg65IIuO1MIHrvlo=;
        b=Di1DrEkQQu5AckvkTikHj9TTbxLyx839BPuewmvmhu9r6LiDB/0LpPblWZsFllP1kn
         aEBPlWy5hxY377XMPljX5c+W/2xXIyqPqtRzQmapxxhyBJzN94sfE838mhuK4RIBj2r1
         /XvOjmOuAhPBxVMzAI2Iyw7xwojTOU0frtW/s+bYlIO5J/4yfGafz6JRqVVprlo2BSGH
         3qNy3qN1IWDIn/mAv5c1vUeIbvO6a5EX7oENhF2mcSTSl8Uwi9DSWISCOdMil1+YZamo
         98DOs9X3buUdxST3s0lk2sYTWC4Ai1B+qriM84A/NA6WQ2jduKlOKevpj5JYg49JmU0S
         TZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722496926; x=1723101726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5saQIelnl5OO8WPHKquus0jHfZjg65IIuO1MIHrvlo=;
        b=bqDewzifieyYgKZ3V+aB6HA4zpsKWoX/PBlNz5IM0KQJNoN+HE+6RKGYULSGN6GykS
         kdEasntGfelozba0eyW77rJ1AAPX3SRUity4aX+Hd73fG+jSfWUA3HgjeGFS7AVQ3J0v
         lJlQnCElXEYbVdft/ORAdYSmh7ABuA4oIOc8xZ2XeRWwcYRQH5RQGBh2YvLN3dIFNkl2
         anGyMEfAZZYkW7BMnf2hXnIjo3iQ3JGxKr0ZCYF36j61bln4ibJbeLHbv9fCHOusDYbK
         XODQD7HTdBqqzPLSKC5sTCT1q3A9Ue04at+p0rwmsg2lMDV1q+jBgz5VOU+YTz3bFmYR
         X/7A==
X-Forwarded-Encrypted: i=1; AJvYcCV6iCdo5QiIZctrO4GHGGFJRruYD4Z9/d995vZq24AtNjbk2OA90oiewhyWlHDesNbHGw2Vc9EhO4uNYqtGuCdPm5uPwfrkV6RFgfTq
X-Gm-Message-State: AOJu0YwxQM/4QXHfmh1QxuWDJMeVpExORFX1tUPxq1ljHTCvJypxQvxB
	ImAOJZIVNWykQZnf0+fl/RmbsYvVqFPr2Q2EjyS1joidys5mkUJg
X-Google-Smtp-Source: AGHT+IHUHvtIh/kWhOh8dQWKVm3MpKjD4RBmZA1KbW6roshsKEQC5OBsJe+hhqYENADb+J2mP+wZzg==
X-Received: by 2002:a17:903:2292:b0:1fd:a428:a021 with SMTP id d9443c01a7336-1ff4d2ee5e9mr12437505ad.11.1722496925777;
        Thu, 01 Aug 2024 00:22:05 -0700 (PDT)
Received: from cs20-buildserver.. ([180.217.140.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff4619793bsm22117425ad.120.2024.08.01.00.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 00:22:05 -0700 (PDT)
From: Stanley Chu <stanley.chuys@gmail.com>
X-Google-Original-From: Stanley Chu <yschu@nuvoton.com>
To: alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	linux-i3c@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com,
	yschu@nuvoton.com,
	cpchiang1@nuvoton.com
Subject: [PATCH v1 0/2] Add Nuvoton NPCM845 i3c master driver
Date: Thu,  1 Aug 2024 15:19:44 +0800
Message-Id: <20240801071946.43266-1-yschu@nuvoton.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds i3c master support for the Nuvoton
Arbel NPCM8XX Board Management controller (BMC) SoC family.

The Nuvoton npcm845 i3c controller implements I3C master functionality
as defined in the MIPI Alliance Specification for I3C, Version 1.0.

This patchset was tested on the Arbel NPCM8XX evaluation board.

James Chiang (2):
  dt-bindings: i3c: Add NPCM845 i3c controller
  i3c: master: Add Nuvoton npcm845 i3c master driver

 .../bindings/i3c/nuvoton,i3c-master.yaml      |  113 +
 MAINTAINERS                                   |    7 +
 drivers/i3c/master/Kconfig                    |   14 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/npcm845-i3c-master.c       | 2372 +++++++++++++++++
 5 files changed, 2507 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/nuvoton,i3c-master.yaml
 create mode 100644 drivers/i3c/master/npcm845-i3c-master.c

-- 
2.34.1


