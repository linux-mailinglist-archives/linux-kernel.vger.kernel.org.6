Return-Path: <linux-kernel+bounces-213534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CFC90768E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DD011C22A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9B149C4A;
	Thu, 13 Jun 2024 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nx9ykxZz"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D035F14883C;
	Thu, 13 Jun 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292392; cv=none; b=fdWDeWB9+cPc6XPsIen+CMt0n6BQXQyMG2i7UJcTjaLzgUG/vFfdr/fQYf4qHhe2W7sLZ/528YWDzw9MgblXRKHo4975l6rWOEhbijBW5RinO3lbYNimslN1FJu+dbKvYTCIiIwhYzFNbJgBDfHWns6TaXMKUWzmPyWprO1WYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292392; c=relaxed/simple;
	bh=YZ/wqfvO/lskIg9NtcF7V1IpEnsIkDRfYMvzkpIFrFA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=QrmfWbv5Qur/iwHjr5DD+E8bXNLRubrHnvzZ3pG1i9DO96Mazl2ii5DNiDNuk0XHLH2Gv4zEifnRiWjL9oDi0Xi3sHw+GdqHNg2a4ipwzI52ToJD5UEVk/69HoIzs7lwDM8T5CrF6TiZIRTjeBHTQIgH7AxjWCblS3cGeN7VUXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nx9ykxZz; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70599522368so893560b3a.2;
        Thu, 13 Jun 2024 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718292390; x=1718897190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XksUZgqg8NfeHhI39cm8pxdIZtUDqwJpq3PLGmvWKlA=;
        b=Nx9ykxZzln1oVvUyUa0G7azYEbX1sXyqcpj3TyPO+JFSko3g5wCjYDgcSz6UX4p0S5
         i6Rd6KpO3qBJiyScC3s7wnKZE55uZIPrnAO8NLX3iP7DZBSmUVSasEFaI57OUM6GRzfK
         3a0gf+aFif9heAi6y//FI6eah8nOO85g/DlQnZFZzAIL1P5W9mulkpGdmX5EmEHS2RtS
         O3jvzSe0D9KPyfBcrSB6LZGR5SV3xc8d24VtcCmExUzbqz2N8O5Sl6g7I4LcnRNWqA82
         D7elOWDSB1kAEXM5R8T8xOlY8QPukC0pHz82+bg+2jKos8a4OeYG3IfAfKuvSmqWL165
         zyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292390; x=1718897190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XksUZgqg8NfeHhI39cm8pxdIZtUDqwJpq3PLGmvWKlA=;
        b=aDgBhHes5cCA5Fl45Gl8dLp6tP58GO+rXIaVBMzrN+9KLC/XXXp8L8OQ9uUoIW6PNy
         r/aJf9B48RKELTqBOPaK7Umsx2igBrvVNjFIlta8Wy9KF5AP7eOh1aYX/MrgplYukJrQ
         3L5RDXokXM+0k/viwrT/rSNgOwUsAHCpR+d6CyoVTy4cgVD+yXFj3GUv8oUygkfFgW6y
         86GEKGa3XUETCbzaUFDIUoOJp1nrEHd7aDpwHJv7NNgl+HBqtycS6tdk05x32/3HvlB7
         aIEB5NurhIBMTriZhii4v9StYO8/qX+Kk7fMhfPbdVkaZ9tb6cgFo+fJieAHhp4ZDGkA
         LqEw==
X-Forwarded-Encrypted: i=1; AJvYcCW/mPwZ4ExaWNKMfb19+YtTPni5NAPzIbEGZPWrphZkghtiRkY5A7XeueNgP94lZpyWRvFGiM8W9RBhPRCKFNCkscygFmfulQztKbEZ1vbxQ7brh3j4NskY9EeGAfuuv6JD7U3+/GGtsQ==
X-Gm-Message-State: AOJu0YwfLjVY+1OiIyrkCsexn2RtGkL6mOTZm3qMM11Ubzxw3sNLREWf
	bDrMwrKPMByRFRaDZ7O/iX38hLbbys9no1Jz4FkUngFWyfaiiIiyMgk8MQ==
X-Google-Smtp-Source: AGHT+IE5EGv/LZQSRF88ln1cUwqt+xnBZ3RL9ku+PGn1tJNTrwmyidsoS6sanfiqW8DZpU05wSZdxw==
X-Received: by 2002:a05:6a20:7fa9:b0:1b6:dd01:ad2c with SMTP id adf61e73a8af0-1bae8214321mr190662637.44.1718292389931;
        Thu, 13 Jun 2024 08:26:29 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee41663d2sm1198183a12.92.2024.06.13.08.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:26:29 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/7] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu, 13 Jun 2024 23:24:18 +0800
Message-Id: <20240613152425.1582059-1-peteryin.openbmc@gmail.com>
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

Base on: https://lore.kernel.org/all/CAPSyxFRj0twCJG6Lr5UZpznrUHyd_L0Reo=kZSFwCw3FNQ+x+A@mail.gmail.com/

Change log:

v1
  - Patch 0001 - revise hsc chip
  - Patch 0002 - add VR device
  - Patch 0003 - add sgpio name
  - Patch 0004 - add ina238
  - Patch 0005 - add power monitor xdp710
  - Patch 0006 - remove multi-host property
  - Patch 0007 - remove pca9546

Peter Yin (7):
  ARM: dts: aspeed: Harma: revise hsc chip
  ARM: dts: aspeed: Harma: add VR device
  ARM: dts: aspeed: Harma: add sgpio name
  ARM: dts: aspeed: Harma: add ina238
  ARM: dts: aspeed: Harma: add power monitor xdp710
  ARM: dts: aspeed: Harma: remove multi-host property
  ARM: dts: aspeed: Harma: remove pca9546

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 148 +++++++++++++-----
 1 file changed, 109 insertions(+), 39 deletions(-)

-- 
2.25.1


