Return-Path: <linux-kernel+bounces-383675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A479B1EF4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B26F1C21D4F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5416B3B7;
	Sun, 27 Oct 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="iZhNxvvq"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3654A482CD
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 14:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730040328; cv=none; b=ECcRuRqSDo58moP+he+THJSnRmhodR6/1z53NlqEK/F5qICnieu7T9RCRst01kAZDKs9TgWzkmM9N/62PKMuo/wNlvJ5ljej1DzRs8tRPiiIQssP0Cxg6MMCNsJV8LuBYrjfZy+tquRLT/exbZGeLQoIgUHTUyCDNps3VJIVjkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730040328; c=relaxed/simple;
	bh=l4Dn5B+g0B7e7WnStCDidZiB7QU9h1YHPVwsaRK2kO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i2ZdC/u24LTBPRqlfObmYehBkN/A/QgQpMJW+TDS+wP0T0AkD4Jjl4BMBwwOblJydzy8hH32U+4RAaE/1gwGDLWA5TdHFM8PY3fEaae9fTIF7JALFl24+0NaDpkfb1tWbiyzTDB4JZ/fffMuGReUYTvLKNF/c7ztRRmGI9Xm8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=iZhNxvvq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eda47b7343so2196415a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 07:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730040324; x=1730645124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LA7ovDYy10u8Lc9oUJDda4GDCHrbHPvh33g7r+01N0I=;
        b=iZhNxvvqHYhYZ58lQavmbQeRxND50NeXi3FBdIkAyzypojYqgKVa+kX8/Ayi1xrUw2
         Q1ToD736T54SnENfn1+j0gWIJYzGVatdebV4JxLvUzMAzjoPJ2Beg/X3th86GgOB4diN
         J09m1bKeiJbkS8pCllZG/sunS1Ctui1/uD8ZVJu+w7b5kTfmJXTgH2bR0L/jboBRD62p
         6KsMYnsnvCg5x9hHuBuA3ORag+v9pzhNTU5Y9UICXLvkjfz967tD1rtAnUQnoLBF9R0M
         Eacq5eiDQ9xMivU1ZcyllAVlLz9Z2KyLC1NcABhVBkl/agJ6n3neY87odqw7qatP3Xh0
         RjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730040324; x=1730645124;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA7ovDYy10u8Lc9oUJDda4GDCHrbHPvh33g7r+01N0I=;
        b=ObS43l2vWtT9DrIxW1xe+SE4cke3KGhapFFLwzxYhxNKOMPpG6VGZJZvsFaiv2Pmc3
         JelOfRqDQcoAUF+gFB11RUQ/0Vl5WJeO4bnYp6pARB6S7I1WZXdxgc8LmzwcUh4fjnh1
         qfTl1KIluV/u4hVHSGHWGbXWPeNyqWZrK/8Gcjlo9ILnAwURSNsSS1Ny3FjsfOcoVzZ6
         YKMEEXPh4MlndWJUqPkHL7q+BTmqnOLpYoQfdKHF9+W3ExdtZXcj3ll9HZkTjRxrCmAd
         9Gv/1R3KT1PpBEpzI+3O+tJXsUysMGH+jEpwva97eYy5o8gp0x6JXhf1HuCc8JqMDlK/
         poaw==
X-Forwarded-Encrypted: i=1; AJvYcCXxRmK9+htQGwPUCIg/fBB+G3LfwdB6GGPPf3Zufq7WDY0b1xx9nLPloyEZdczD+Ro6NdYQdu1oag6pFZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRT7aM4ieGwZz1x+RBazxNqt1YNFF/8u1AlwM41ZnV6S2s0bt+
	xJdzQXM4EqkLCL2VeVbEVqf6w66UQFWK53FhDOVur0FWJZwrHoZ2m46bB6ogZ80=
X-Google-Smtp-Source: AGHT+IEeFI0nqucYFP3u69R5Ja9TjYspR7cibVOeMBZFQT2BryMkO9srCATLXUqSED+U2a84KgdKsA==
X-Received: by 2002:a05:6a21:1706:b0:1d9:2018:9e19 with SMTP id adf61e73a8af0-1d9a85144afmr7512209637.44.1730040324493;
        Sun, 27 Oct 2024 07:45:24 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0cb06sm4065110b3a.115.2024.10.27.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 07:45:24 -0700 (PDT)
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
Subject: [PATCH v6 0/5] Add DeepComputing FML13V01 board dts
Date: Sun, 27 Oct 2024 22:44:43 +0800
Message-Id: <20241027144448.1813611-1-guodong@riscstar.com>
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

In the original series, the FML13V10 board DTS file disabled some
nodes that had been enabled in a common included DTSI file.  We
proposed fixing this in a follow-on series.  However there was some
disagreement about the right way to do this.  In the end, Emil
requested that we resolve this by adding two changes to the next
version of the patch series:
- Do not enable any nodes in the common DTSI file that would need
  to be disabled in a board DTS (or DTSI) file.  (Note that there
  still might be nodes enabled in the common file.)
- Because it will differ dependent on board, do not define the
  "dr_mode" (dual-role mode) property in the common DTSI file,
  defining it in the board files instead.

To address this, two new patches have been added to the beginning
of this version of the series.  The first patch no longer enables
nodes that would need to be disabled for the new FML13V01 board,
and enables them instead in the existing boards that need them
enabled.  The second patch moves the definition of the "dr_mode"
property for the usb0 node out of the common file and into the
board files.

The remaining three patches are roughly the same as the three
patches in the previous version of this series.  The final
patch has been modified, because it no longer needs to disable
certain nodes that had previously been enabled.

Below is a version history, including direct links to all of the
patches (note: in v1, v2 and v3, a single link to each series
doesn't work).

Best regards,
Guodong, Alex

v6:
- Updated to apply to the latest version of riscv/for-next
- Move nodes enablement from jh7110-common.dtsi into board dts/dtsi
- Do not specify the USB "dr_mode" property in the common file
- Add Emil's reviewed-by on patch 4 (previously patch 2)

v5:
- Remove the extra "From:" line in commit messages of patch 1 & 2.

https://lore.kernel.org/all/20241020134959.519462-1-guodong@riscstar.com/

v4:
- Board name was changed from FM7110 to FML13V10
- Descriptions for all patches in this series were updated slightly
- Add Rob's ack on patch 2
- In patch 3, device nodes were updated to reflect their proper status

https://lore.kernel.org/all/20241019162605.308475-1-guodong@riscstar.com/

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

Guodong Xu (3):
  riscv: dts: starfive: jh7110-common: revised device node
  riscv: dts: starfive: jh7110-common: move usb0 config to board dts
  riscv: dts: starfive: add DeepComputing FML13V01 board device tree

Sandie Cao (2):
  dt-bindings: vendor: add deepcomputing
  dt-bindings: riscv: starfive: add deepcomputing,fml13v01

 .../devicetree/bindings/riscv/starfive.yaml   |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../boot/dts/starfive/jh7110-common.dtsi      | 10 --------
 .../jh7110-deepcomputing-fml13v01.dts         | 17 +++++++++++++
 .../boot/dts/starfive/jh7110-milkv-mars.dts   | 22 ++++++++++++++++
 .../dts/starfive/jh7110-pine64-star64.dts     | 22 ++++++++++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 25 +++++++++++++++++++
 8 files changed, 90 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts

-- 
2.34.1


