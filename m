Return-Path: <linux-kernel+bounces-421961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF519D92A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E221DB226D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 07:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFF4194AF9;
	Tue, 26 Nov 2024 07:39:50 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268301940B1;
	Tue, 26 Nov 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606790; cv=none; b=g8W5NQfrIeEjGuI6aZHGIHEGK0OeD9SkILoLKx0azo+f4eh6j8xAs54ZZbqAI1BlSQGUt7UWHddkjBr7G6KgG3wxvPGc78Aivd12OUybn4B9XmZfCiQIZGVPA+cmCGa1I2NNAGt6B+yixaOMy0YCeNoxoPib9HB61lDwM1/nIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606790; c=relaxed/simple;
	bh=l4xNFfZs29V+YFWS2Hm0/icn1VoDKRS6ABKFjfpyraQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TI02JdSnyNeY9fON++dtLPY5LBNW/w9brnXYiH05f4odDroJwPpw0T0+tDbdjBvg32Elx2YAWjXHypU2HgmmCj42NKIyAY1TR3K97mgnYcr+j2/hlPostzsdK3jNbwVVGHu/66sNCGDZhZTE+RL56/9z/3h6ryBkOi/WRWdITAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id C5DD6B2C2027;
	Tue, 26 Nov 2024 08:39:35 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: E Shattow <e@freeshell.de>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function
Date: Mon, 25 Nov 2024 23:38:16 -0800
Message-ID: <20241126073836.17208-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable host mode JH7110 on-chip USB for Pine64 Star64 by setting host mode 
and connect vbus pinctrl.

This functionality depends on setting the USB over-current register to 
disable at bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no 
change in functional outcome with this patch applied; there is an error 
visible to the user and this usb configuration fails (same as it is now).

Changes since v2:
 - Rebase on latest master

Changes since v1:
 - Rebase on linux-next/master
 - use tabs for code indent

E Shattow (1):
  riscv: dts: starfive: jh7110-pine64-star64: enable usb0 host function

 .../boot/dts/starfive/jh7110-pine64-star64.dts | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.45.2


