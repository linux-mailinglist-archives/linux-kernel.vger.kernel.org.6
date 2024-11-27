Return-Path: <linux-kernel+bounces-423660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4E9DAB04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C29B163BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA320011A;
	Wed, 27 Nov 2024 15:50:27 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A931FF7D9;
	Wed, 27 Nov 2024 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722627; cv=none; b=qQcw/PhZvYi+RevHRKuBtSCjEV5Qtlx+6mfNSVWodTEx1bjw8m18zWx9EdAUbdrxoS+TCqsQ8R9SLo0bvx+4sP6/uqXGkQqlMcmjD9PC0JruPrr8gGnNfNnJZRDRolkZKHyranYtSFtjHEVDdcGE0nOv7imNdCaji5CX0fzCpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722627; c=relaxed/simple;
	bh=bJTSXVwX41gF5k5VOt7aZRS3t+uZgxzzBvJfSR3giyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Puxamzre3zUJOlbCPBOUPrmsjJZSVtG8Qcb0B4Pqf+/qAktMQjsgZm1sJkxBQGyVQDXlFLqHuiATvXA+YprQFGb4qjRAqWtu7lWZkx1GgQO5GsZQaI9fhEhOyuma6GbG3/vXCgtnBAZ2AP54Dp8RLQuT8WAGIOBF/hzdRroPNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan. (unknown [IPv6:2605:59c8:31de:bf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 22332B4B1E1F;
	Wed, 27 Nov 2024 16:50:17 +0100 (CET)
From: E Shattow <e@freeshell.de>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Henry Bell <dmoo_dv@protonmail.com>
Cc: E Shattow <e@freeshell.de>,
	Conor Dooley <conor@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function
Date: Wed, 27 Nov 2024 07:49:22 -0800
Message-ID: <20241127154958.71094-1-e@freeshell.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable host mode JH7110 on-chip USB for Milk-V Mars by setting host mode
and connect vbus pinctrl.

This functionality depends on setting the USB over-current register to 
disable at bootloader phase, for example U-Boot:
https://patchwork.ozlabs.org/project/uboot/patch/20241012031328.4268-6-minda.chen@starfivetech.com/

If the over-current register is not prepared for us then the result is no 
change in functional outcome with this patch applied; there is an error 
visible to the user and this additional usb configuration fails (same as
it is now). On Milk-V Mars with four USB-A ports this applies to one of the 
USB-A ports and the remaining three VL805-connected USB-A ports via PCIe are 
not changed.

Changes since v5:
 - Rebase on latest master
 - Addtional detail to commit description

Changes since v4:
 - Rebase on latest master

Changes since v3:
 - Rebase on linux-next/master
 - use tabs for code indent

Changes since v2:
 - Rebase on 6.12

E Shattow (1):
  riscv: dts: starfive: jh7110-milkv-mars: enable usb0 host function

 .../boot/dts/starfive/jh7110-milkv-mars.dts    | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.45.2


