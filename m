Return-Path: <linux-kernel+bounces-257266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CA49377AE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492411F21F54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F30F12EBD3;
	Fri, 19 Jul 2024 12:22:03 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDB9129A74;
	Fri, 19 Jul 2024 12:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391723; cv=none; b=QVXkLBx3vhZr9jkt4pxcc2WaJ8stTvOVRMboTo6EWfZxnlIK1wYGzdEpzbq3wp20k7EH3i9n+tjmxK2dMFsu8yHC55zA8syiOhJN0Qx6CX6F7/85P1RHSQb7sr289s2NZgEpBlNUfNC71T3jDkfuk8wnAasb5HMjBBrQu/w+zVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391723; c=relaxed/simple;
	bh=bIc8sWnxQMUjNzrRcL6x7GDCVbT9j5645kBvGNMugsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p4XcHb3MvCfxlJqKdaMes60T3sAT+Nb1wtP9KFwGsp1o41WM3sWXHlqtFWrH18H3nG5qtwfW9xtMWwqGV4DU5KbkVbZL00yGMCsUgIJc1h31df80Psj6T728hUvhRvRpEgQeNsSF+f2Y6ITIXcMAlqfdtqqKC2H9MA32BwXVkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 0/2] riscv: spacemit: add pinctrl support to K1 SoC
Date: Fri, 19 Jul 2024 12:21:38 +0000
Message-Id: <20240719-02-k1-pinctrl-v1-0-239ac5b77dd6@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFJammYC/0XMQY7CMAyF4atUWY8l24lC6FVGLBzHQAQUJu0gJ
 MTdCbBg+dt6393N1qrNbhzurtm1zvU89aCfwelepp1BLb0dIwdcYQJkOBBc6qRLO4IXzmhKnpB
 c31yabevt7f1uPt3s77+zy+f4VcfhbUaOLxAJssxVoSxAIp7MLGvh8Rpebv8Z6Pl0qss4oPrkY
 0gcEjGiSVnlQFElocYkvNZtEcnFbR6PJ/e4c0vhAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, Jesse Taube <jesse@rivosinc.com>, 
 Jisheng Zhang <jszhang@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, 
 Icenowy Zheng <uwu@icenowy.me>, Meng Zhang <zhangmeng.kevin@spacemit.com>, 
 Meng Zhang <kevin.z.m@hotmail.com>, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=bIc8sWnxQMUjNzrRcL6x7GDCVbT9j5645kBvGNMugsc=;
 b=owEBzQIy/ZANAwAKATGq6kdZTbvtAcsmYgBmmlpY/FJNMrsVYtdouohyPcxAyHdn+1LXWDOf7
 8cao4N5wwaJApMEAAEKAH0WIQS1urjJwxtxFWcCI9wxqupHWU277QUCZppaWF8UgAAAAAAuAChp
 c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0QjVCQUI4QzlDMzF
 CNzExNTY3MDIyM0RDMzFBQUVBNDc1OTREQkJFRAAKCRAxqupHWU277fFhD/90/Jx9K6BO4lirUx
 RwpNGXjyHCQ3I/HSbwEduvcF6BrEjIpDO1GqfWOUuG9KEFNbcMe6yFAiZ+PH6IWl8TNZ6mmVY4W
 vCEweyCiFQeI75cByD3M82RqFRDOUWbDbCAfc7ni/ivDJb75anCp/wrRoZ6rtEnDxInp9U8OKXi
 Flr01mlNIBeM6XUs3Ba9fUroBszVpL/uj594vKNziaUW13vO3cJCvt0z83+Q+DXwbHyZR1tNUge
 ZKaZbm1TEM2ZrYwXjP/0SI9gHzceT9c23NFvyD8WWpY92WA51q9ZDtIerK55xTrgikyYkVGm6vw
 MXLX73Zzu+NvDodgidhM9QPMDDMjoG/xxzi/e4XLLb+qdQCZKGsVWN5F26TeMiCiinnUfjVloZx
 hL8L5cC0SnHtFFgqGmlZD4OsFh1fEGEtCKV+Kv6yqJUcrb2foicrbDE7jJZIatWwtp/g9XT7W8Y
 7nozxnf/8g9Q0kX4kSbLj88A4sX1woX7he29NWMNa5sopqi37JUcOZgCCHB21wRGwmMKr9wyVZ6
 VkNx4FdRGOFfAHLCZGeGJXASutWOk5LKFsikTiadNCWLd/HCJcAqkUqM0HWaNlqTFZMRNEGcLAO
 lG6KQdHataoC+hXKI3MuQr//KCtuwpc8bfJANLZcbKKBYKJd5g8BhIj6ze0H29WIXA9g==
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

This series adds pinctrl support to SpacemiT's K1 SoC which
has feature compatible with pinctrl-single driver, then later
add pinctrl property for Bananapi-F3 uart device.

The pinctrl docs of K1 can be found here[1], and this dts is largely
converted from vendor's pinctrl code[2]

Note, ideally, we should map raw drive strength value to more user
readable current value, still need to figure out this..

Link: https://developer.spacemit.com/#/documentation?token=An1vwTwKaigaXRkYfwmcznTXned [1]
Link: https://gitee.com/bianbu-linux/linux-6.1/blob/bl-v1.0.y/arch/riscv/boot/dts/spacemit/k1-x_pinctrl.dtsi [2]
Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
Yixun Lan (2):
      riscv: dts: spacemit: add pinctrl support for K1 SoC
      riscv: dts: spacemit: add pinctrl property to uart0 in BPI-F3

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts |    3 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi    | 1746 +++++++++++++++++++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.h       |  220 +++
 arch/riscv/boot/dts/spacemit/k1.dtsi            |   14 +
 4 files changed, 1983 insertions(+)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240708-02-k1-pinctrl-3a2b0ec13101
prerequisite-change-id: 20240626-k1-01-basic-dt-1aa31eeebcd2:v4
prerequisite-patch-id: 47dcf6861f7d434d25855b379e6d7ef4ce369c9c
prerequisite-patch-id: 0ec28c28b96fb9bab28d05be6f772323bed4db95
prerequisite-patch-id: b0bdb1742d96c5738f05262c3b0059102761390b
prerequisite-patch-id: 3927d39d8d77e35d5bfe53d9950da574ff8f2054
prerequisite-patch-id: a98039136a4796252a6029e474f03906f2541643
prerequisite-patch-id: c95f6dc0547a2a63a76e3cba0cf5c623b212b4e6
prerequisite-patch-id: 66e750e438ee959ddc2a6f0650814a2d8c989139
prerequisite-patch-id: 6bba652dd4f57b276010990ec36cae348b0e1b4e
prerequisite-patch-id: 0bdfff661c33c380d1cf00a6c68688e05f88c0b3
prerequisite-patch-id: 99f15718e0bfbb7ed1a96dfa19f35841b004dae9

Best regards,
-- 
Yixun Lan <dlan@gentoo.org>


