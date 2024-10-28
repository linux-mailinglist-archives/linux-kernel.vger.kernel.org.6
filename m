Return-Path: <linux-kernel+bounces-384443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E99B2A28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8EA1F21ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DE31917ED;
	Mon, 28 Oct 2024 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="rfKpSGQi"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE7C18A6BC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730103993; cv=none; b=oFvmmMaDu8gy5A5FoRBIN2Jvq3Y+Z99aU4wQR94FUutOqyPqdw7kWRRvhyiBYLNRWy7RBbGBjRMY+fKsmxsxCBihbviYIM3zoa+lt3ZgVffU4CZnaKRta1JzraINHhDBS9LAGHq3gWeMxx05HYKc0IRMN/G6CsdrwzEwiwia5Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730103993; c=relaxed/simple;
	bh=YC/5jTqP5+C7i+RgBSivmCgEJIMxago/+BGYk3KCf4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qz7vXj4z5V0JZhqVCmPZ/o1TocDPE02WgWFw45mC6fi2jE3g1G/kpQx62JGg1rWHY3CXbs2y7Tlpn/SYo1W3oidGewDyODDM3hBeo9jfPlN328lf6cPmJuuVEQIYSBBz/SRkQs0Ot+foFixH/LtYeZb/HQKiaimFZ2wvgzql368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=rfKpSGQi; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7206304f93aso1526957b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 01:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1730103991; x=1730708791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwNPF7Xr5meifwUXJRYWBlzUxnsK/tjPyZKH5q5KIa0=;
        b=rfKpSGQiM7j3X4gu3ATDkKIY+ldEtIrkkODwlEMv23zmwlSq/4wFdiJOFejtKNoTZY
         UAnqvs0N93IwhxadPHDc16EVdWCHKY1BuV5CKBKbzIb4v7iFdhZm/0LojlGYhXRmw/GL
         eHiPYH7Tu00c61//SC435Wy6oNXnGsq2QFfgMWExKF1D/YGOe+PxIXUeTXCM5M6Tzn2/
         bZQ4Bx9hiLF1sqJPtA5n+oEfFQuEB7lcOPCXO6VyWDQVgvCRRDP17LNUo5DNJeVhcL1A
         wOwnyjln0zdwrNwkaQf4gdrqPjzWD9tT9nkF7iKfb09o+NnZ79+S7AscMj4notpKcHD/
         CZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730103991; x=1730708791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwNPF7Xr5meifwUXJRYWBlzUxnsK/tjPyZKH5q5KIa0=;
        b=vgQ5wLu1v3FZH/TGAMjzvNYSej/XzGQO2n82fQeAYNZunhfJk+aeT/iQt6bN/GgWKD
         lDGzsnXYX34s4bi4v0HrFFTo9xpiPCAPWhy4b0QiKPW8KUR5yX83E0Ug9rC4FSuFEfmK
         NUu/32A4P4NqneS0OdlUlmv9w1FCVa8IXmWo1N7LtrtVIozKLq4o7+0erGgHRK6aNN1L
         ftLRpliZj9oFFr/R2v2cUIdMz38zo5tD1oQ+/shW9tnZNc+v6TValWgx00YjQxH46xAe
         32ctkCs/6Z+QQeYc7jyqyhWkDlVCAzJsTvsLoT++t7kWe7pe0TZ692izdqHHqETp7UI2
         aSjA==
X-Forwarded-Encrypted: i=1; AJvYcCVln8x60BtAB/DO5hqQm8Pj/OuDTABNWaorxKpbATyvNJo4s4nMZ2lx2S8ZXMNjYlCMYDVuYqJNySvN4KA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KLNMrDbaeNrvCJIv5NUnT9NgSRvvmuJjzWn6DjZexg50N2gN
	Avk0ih+Zl+lW/trzg49asQ92h+vxq4TQ03dIqZGvcPocbCYgUJvoMWWoQjfARzQ=
X-Google-Smtp-Source: AGHT+IHju2H63ovx35vxWV3fakzOEuWmj1RtH9OyMmVpZRFGzW4IXwophE/GQPM7KmpSabJGej9FZg==
X-Received: by 2002:a05:6a00:b83:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-7206306d438mr10332340b3a.19.1730103990736;
        Mon, 28 Oct 2024 01:26:30 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::401b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205791e451sm5195419b3a.24.2024.10.28.01.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 01:26:30 -0700 (PDT)
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
Subject: [PATCH v7 0/5] Add DeepComputing FML13V01 board dts
Date: Mon, 28 Oct 2024 16:25:48 +0800
Message-Id: <20241028082553.1989797-1-guodong@riscstar.com>
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

In the original series (v1 to v5), the FML13V10 board DTS file
disabled some nodes that had been enabled in a common included DTSI
file.  We proposed fixing this in a follow-on series.  However there
was some disagreement about the right way to do this.  In the end,
Emil requested that we resolve this by adding two changes to the next
version of the patch series:
- Do not enable any nodes in the common DTSI file that would need
  to be disabled in a board DTS (or DTSI) file.  (Note that there
  still might be nodes enabled in the common file.)
- Because it will differ dependent on board, do not define the
  "dr_mode" (dual-role mode) property in the common DTSI file,
  defining it in the board files instead.

To address this, starting from v6 of the series, two new patches had
been added to the beginning of the patchset.  The first patch no
longer enables nodes that would need to be disabled for the new
FML13V01 board, and enables them instead in the existing boardas
that need them enabled.  The second patch moves the definition of
the "dr_mode" property for the usb0 node out of the common file and
into the board files.

The remaining three patches are roughly the same as the three
patches in the previous version of this series.  The final
patch has been modified, because it no longer needs to disable
certain nodes that had previously been enabled.

Below is a version history, including direct links to all of the
patches (note: in v1, v2 and v3, a single link to each series
doesn't work).

Best regards,
Guodong, Alex

v7:
- Add Emil's reviewed-by on patch 1, 2 and 5
- Corrected commit description typo in patch 1

v6:
- Updated to apply to the latest version of riscv/for-next
- Move nodes enablement from jh7110-common.dtsi into board dts/dtsi
- Do not specify the USB "dr_mode" property in the common file
- Add Emil's reviewed-by on patch 4 (previously patch 2)

https://lore.kernel.org/all/20241027144448.1813611-1-guodong@riscstar.com/

v5:
- Remove the extra "From:" line in commit messages of patch 1 and 2

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


