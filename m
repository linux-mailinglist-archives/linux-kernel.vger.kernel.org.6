Return-Path: <linux-kernel+bounces-373259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9366A9A5463
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DFB22217
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98361192D69;
	Sun, 20 Oct 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jJMs1AHm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D84C7D
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729432253; cv=none; b=EaJBEqOzsUaSZb88dSHd0Xq8ra5TeylvgjZElj2lALz8NGlu8XDOxTp8hPvmKz37/qTH80Do3zcGP6hXGH3LkNZI0nmkFxJ9XvKl+BYG4q3PvEKlx6VHY30ABXL7XkAG/0ni7S3dg9MVtUN5W8lFLJKUM2/zk+Yv0U/lfMruySM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729432253; c=relaxed/simple;
	bh=3ixVkNJPxWFe97eRFC1T0i5mV+yElzvwk03zFFD0ZzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGDJGgWyQAYIozmpcLu8QdqKnnwDEJcCQMXMbCSlAtyVsoz6w5qefv6S76+9T5dmM3FlamYKFm5GifUfqnpqbjg9iNmarOlkS+UqXuhZylyuiGRM8/E1JWZ4vgGC5a0KWku35ZHWGvKAGYDVvwUk8h14SfYax6tBhQnrb5IHnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jJMs1AHm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb39d97d1so33330555ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729432250; x=1730037050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Inqg1tmm6xHd6cimigwIyJaawPAIIIaPNdfqb/QubP0=;
        b=jJMs1AHmjpYrwIYX8/mXVXzE9dnu7gurx8w3QDnQhNYcaz8DWww+jwVyt/STyW1H+2
         9zR5h7/PTaTsHOpVBmDKOkI4L2gcGoIRZQVzDkuzzHVtvOD6/luTI03bxnsQAAzoh/lr
         rIc/1bFhCU42/K1pW2PWUAf5acltJUcj5rnVCrMwGxJWfp4P3sRlYv2aDGT7ta5A3Wk/
         OefZhatVS3skPGhrP/64rP5jSaXNHdgcJjZgCpxpbRDLp/Ljjk+8P5vYG5vULWKUJ426
         d4Hek9pfl0Dp73SFnAqX2o8E6D1nK8+2HH5RHFjVf9X0jJNNCQ8+EFUBIlbS0CPzygl6
         yjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729432250; x=1730037050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Inqg1tmm6xHd6cimigwIyJaawPAIIIaPNdfqb/QubP0=;
        b=bz/EHzMe2CRzcWFRQpk7F14OKEwRWX+ePIj6XWLRsFHAWyGa8r74YMmVjpqjcdkhyY
         oLsDRi2+2tYES1I2pqmWBlWFsRdMMxipq+JrY4G09jpDLzMOyAccRwdd3O4XPtO7n9eI
         RtXGxS3VDdMw2SjKBhGmbFIg3KcNkyj0kyQaoSGYv1V6LppCnJFHXREMjg3IdIzvKDnT
         GreoCZD1GB3G6q8VDnRmYWGZdSavqsXZ2hNPRQJCeqRbHRqgC3RrBzNLtdKRK+pQ1OSi
         9B87MqQdKTW4hPpxjlDxgJBcazQ7Y83a4VChd5Mn3HwBjh2okkeXv/KFHtrMO3JsV040
         qqYg==
X-Forwarded-Encrypted: i=1; AJvYcCXqfryh54Utckdb0ywS/x038Tvl9CfymQrzFhDK79pEWPQri9NSTWXIAaBdrgvSlrvwHFQ39UpFeKQibS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqtvd8Bs4haPPENL1sc8UfDIGFEPlEGOvii/yQbEfKmbIIjAi4
	Uu2QIdPxZgGp3VE1ayV/QBXGG5rTnWPiIUyOIG0+9Ypak1sBwT7B7cOfTVfwaa8=
X-Google-Smtp-Source: AGHT+IFYcPnxuXktJBagQgtle0401hr/lktbq89F50ipN56+or5lo6r+eP3gufcTxqaRKoDCycgUkQ==
X-Received: by 2002:a17:902:c94f:b0:207:18f5:7e78 with SMTP id d9443c01a7336-20e5a94acccmr102524295ad.48.1729432250435;
        Sun, 20 Oct 2024 06:50:50 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::40df])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee63f0sm10554935ad.3.2024.10.20.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:50:50 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	rafal@milecki.pl,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	Alexandru Stan <ams@frame.work>,
	Daniel Schaefer <dhs@frame.work>,
	Sandie Cao <sandie.cao@deepcomputing.io>,
	Yuning Liang <yuning.liang@deepcomputing.io>,
	Huiming Qiu <huiming.qiu@deepcomputing.io>,
	Alex Elder <elder@riscstar.com>,
	linux@frame.work,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v5 0/3] Add DeepComputing FML13V01 board dts
Date: Sun, 20 Oct 2024 21:49:56 +0800
Message-Id: <20241020134959.519462-1-guodong@riscstar.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates Device Tree related files to introduce the
FML13V10 board from DeepComputing, which incorporates a StarFive
JH7110 SoC.  This board is designed for use on the Framework Laptop 13
Chassis, which has (Framework) SKU FRANHQ0001.

The original three versions of this series were posted by Sandie Cao
from DeepComputing.  Her mailer configuration caused mail threading
errors, which led to some confusion.  After some discussion, we have
agreed to take over moving this series toward acceptance.

Changes from v4:

Remove the extra "From:" line in commit messages of patch 1 & 2.

Changes from v3:

In this version, the board name is changed from FM7110 to FML13V10.

The descriptions for all patches in this series now have been updated
(slightly).  The first patch received an ack from Krzysztof in v2, and
the second patch received an ack from Rob on v3, and both are included
here. Other than the board name, the content of the first and second
patches are the same as before.

The third patch has been modified.  pcie0 was marked as disabled in
patch 3, and Krzysztof asked why pcie0 was enabled in the first place.
In fact, it is *not* enabled, and the node disabling it in patch 3
was not required.  Similarly, gmac1 is already disabled.  So these nodes
have been removed in patch 3.

However, gmac0 and pwmdac *are* enabled (in "jh7110-common.dtsi"),
but they should not be (for now) on this board.  The same is true
for spi0, csi2rx, and camss.  There are a few other nodes added in
patch 3 to ensure things are disabled that should be. Finally, usb0
remains enabled, but with a different operational mode (dr_mode =
"host").

The proper fix is to disable things except where they're needed rather
than enabling them in jh7110-common.dtsi and disabling them for this
board.  We propose to fix this in a follow-on patch (or series), but
we can do this in a new version of this series if requested.

Below is a version history, including direct links to all of the patches
(because a single link to each series doesn't work).

Best regards,
Guodong, Alex

v5:
- Remove the extra "From:" line in commit messages of patch 1 & 2.

v4:
- Board name was changed from FM7110 to FML13V10
- Descriptions for all patches in this series were updated slightly
- Add Rob's ack on patch 2
- In patch 3, device nodes were updated to reflect their proper status

https://lore.kernel.org/linux-riscv/20241019162605.308475-1-guodong@riscstar.com/

v3:
- Update board features into description
- Add Krzysztof's ack on patch 1

https://lore.kernel.org/all/20240925053123.1364574-1-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240925053123.1364574-2-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240925053123.1364574-3-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240925053123.1364574-4-sandie.cao@deepcomputing.io/

v2:
- Add deepcomputing into vendor list.
- Add deepcomputing,fm7110 into model compatible list.
- Framework Config will be included in later a patch.

https://lore.kernel.org/all/20240924080650.1345485-1-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240924080650.1345485-2-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240924080650.1345485-3-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240924080650.1345485-4-sandie.cao@deepcomputing.io/

v1:
- Add framework dts and config.

https://lore.kernel.org/all/20240923053621.1585972-1-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240923053621.1585972-2-sandie.cao@deepcomputing.io/
https://lore.kernel.org/all/20240923053806.1586080-1-sandie.cao@deepcomputing.io/

Guodong Xu (1):
  riscv: dts: starfive: add DeepComputing FML13V01 board device tree

Sandie Cao (2):
  dt-bindings: vendor: add deepcomputing
  dt-bindings: riscv: starfive: add deepcomputing,fml13v01

 .../devicetree/bindings/riscv/starfive.yaml   |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../jh7110-deepcomputing-fml13v01.dts         | 44 +++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts

-- 
2.34.1


