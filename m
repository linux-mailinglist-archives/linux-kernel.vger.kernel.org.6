Return-Path: <linux-kernel+bounces-338371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575C6985703
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B80C282FEE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FE1607AC;
	Wed, 25 Sep 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqwR1xAD"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D786C3F9D5;
	Wed, 25 Sep 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727259312; cv=none; b=goM39lULlUrrH3xU9YloM049niPExUCYaLAHhQvb4jND2jpMdBqGnMLq9p11jxFjBuT22Ty484/GbNYeOOFnn7xU81L35chVgYc/qwGevaHLufX0ELh45qjKKA0gi2/cTVNvb+OaKjXNfTTAiX92HEUILj26Cldx5VrZd2HgkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727259312; c=relaxed/simple;
	bh=7M6pAgVOmnipHjCRRRJJhaiyPcFLNWvmHrTECV+D4kU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=S2rAQZ/nJ8pAwg/AP0/PgdrIjAnTdXFaj85TrdMlysgm+ub39PJQspcCq+eoQonzQ06aS73NtXBmal5yhbcf5cGdLn+CEXnm3WaPVUzfEt03cuRlSRBm4g/BddVbHe3lgQGqXZrmul1EbcqtX5bsFTqo072vpEYjyt2nVHGntRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqwR1xAD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374ba74e9b6so5397717f8f.0;
        Wed, 25 Sep 2024 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727259309; x=1727864109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilIaUtbIEpTD2StWHvTRKlM/sRvr3jwjW7JtAZ7o8Ew=;
        b=jqwR1xADGbZDrxjq+YgaOXZJNdIJHMJJoA6G/DSk00BdFM0OZDhokUXRvn70ty3ekV
         KnLUbuz8TIbV9tj+ZSkDh1pBywhaEIyaF8tJ61hu7/mn6kkXewFYAgcR7f0iQUE1ap5G
         bOY8xsaq+rMBrNT8Tp2SS9jVqUYROlkPrv8DubVtS0ShpNjfCZZ2kdfoYbYCEpTSBN8r
         m6Q8lOkpD9itJVWRCso2NEJdpBeu+M0UwMADRlYqfxNx1N95t6KC/C3DcxDGEjLK31Bg
         PvZTufoqIl4FNl7BucNZasNuj6MjxbBwHNpAt8r1k3lXnOXe5s7L5obYDdGLe1eRtokA
         5vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727259309; x=1727864109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ilIaUtbIEpTD2StWHvTRKlM/sRvr3jwjW7JtAZ7o8Ew=;
        b=FSnpKD6dv5AlY5L3f2KZ1X02FO6ba0p2bjHr/0zDk98ZHb/T0LWqUt5jLveM+ScsCA
         lFXJEv/uzDaHzJTGeuDDtrdoLsImSNMeqYZjJIh/LPlu/0jqf51KtCycH+B8rPU/GmF4
         c0neo2qX+9K/dT1lihi22caczGeBbYK0e7i/I7A9hOzj8+OvB6o828NW6Y+vyfSXX/Ar
         uZfvwlTN+gOYBf2fG5hQK4fMO8VrSaw2iKl9vqi+fkdIOHzYKN+1ohNtAa9/9RM8dZTh
         b2rx7UGs+mz/tfwEFOuN6b6VRaS68+wdmX5EtHPUbbrho+eWUK5KWQRGHHpefOx8NHYq
         UHnA==
X-Forwarded-Encrypted: i=1; AJvYcCV2BHJ2sHIHoAaZweM5fNoUdhW/7etkVTShSI8KOTl6CNrko6wsWvavDSih9vnAVEALOj8GRuZs/Z1M@vger.kernel.org, AJvYcCWrBX/gJMei1521ep3bTR1/VnsXCIew7kBCjuF55AcP8vLG1mSscwnsc8QKS1Rg/zmGTDy4F6hWQwNqwBR2@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqQ7AGIjZMgnemOU9beXycsQqKcDej6aMi7g3iHchGE7EuGrF
	OpiwG4ILA4bU4qrk7jRBWYcP7Dun+mlt8pTiAsvpMFU8ix+Qi/2W
X-Google-Smtp-Source: AGHT+IEmsRgIRfzVIU5fak3npQDb5hJ8p1AtivNkdH9EjqCFOo9Ah8NVO0bkOdgO29790nCRUCu71g==
X-Received: by 2002:a05:6000:1141:b0:374:c90e:990c with SMTP id ffacd0b85a97d-37cc2480bcdmr1731315f8f.33.1727259308798;
        Wed, 25 Sep 2024 03:15:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cbc1560a7sm3628194f8f.0.2024.09.25.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 03:15:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH 0/3] mtd: Add support for Airoha partition scheme
Date: Wed, 25 Sep 2024 12:13:56 +0200
Message-ID: <20240925101422.8373-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is split from a different series called "mtd: improve block2mtd +
airoha parser" with only the parser changes.

This series add support for the Airoha partition table where
the last partition is always ART and is placed at the end of the flash.

This require dynamic calculation of the offset as some dedicated
driver for bad block management might be used that reserve some space
at the end of the flash for bad block accounting. This special driver
change the end offset of the flash hence a dynamic parser is needed.

New aarch64 Airoha SoC (EN7581) make use of this partition scheme or
calibration data is not accessible.

Relevant Changes from old series:
Changes v3:
- Add compatible to partitions.yaml

Christian Marangi (3):
  of: also export of_update_property
  dt-bindings: mtd: Add Documentation for Airoha fixed-partitions
  mtd: parser: add support for Airoha parser

 .../partitions/airoha,fixed-partitions.yaml   | 80 +++++++++++++++++++
 .../bindings/mtd/partitions/partitions.yaml   |  1 +
 drivers/mtd/parsers/Kconfig                   | 10 +++
 drivers/mtd/parsers/Makefile                  |  1 +
 drivers/mtd/parsers/ofpart_airoha.c           | 57 +++++++++++++
 drivers/mtd/parsers/ofpart_airoha.h           | 18 +++++
 drivers/mtd/parsers/ofpart_core.c             |  6 ++
 drivers/of/base.c                             |  1 +
 8 files changed, 174 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/airoha,fixed-partitions.yaml
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.c
 create mode 100644 drivers/mtd/parsers/ofpart_airoha.h

-- 
2.45.2


