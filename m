Return-Path: <linux-kernel+bounces-269999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EA49439CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 01:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16C5285D70
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 23:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC28618C336;
	Wed, 31 Jul 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOJyIKTQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AC618B489;
	Wed, 31 Jul 2024 23:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722470194; cv=none; b=I8OLNZgqOfGJD7tBhRky61vsbpQiinwrPLWzWdsPoxgOErgruej/JPYy+STTvp79dk13scqJ2eS1AxZP+Yjs5/gEJdg7b/2MooxSrekshVSzEtRBo7GoKi7hSio3HndKY0OThuMRi/iXuwnOZKsnORrSD/vaq1DMi5trMEHvF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722470194; c=relaxed/simple;
	bh=8roy8Xw2jj/VUUAXDLqEtyfSX75T55OU+WbOye7wrto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDlzLCt1ziNHOxKhmjCw7FNiq//rPE46XLGSNYpx0bPb+LZGUBf/Dp6aZtpau7/qNb9PssbEvNcbxs+apu9X6Z8Lu092HvRgWXs3ZNTmJq5LZLNM0FG1QgpWM69QsIueQK0NwLg2gSZwBI3Z3dw0b6YAjZDBpu1Gdlew129NtDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOJyIKTQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9143EC4AF0C;
	Wed, 31 Jul 2024 23:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722470193;
	bh=8roy8Xw2jj/VUUAXDLqEtyfSX75T55OU+WbOye7wrto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aOJyIKTQMvuUvlg5Y6+P1amhoJ4O6lBK3C+xy6c5g3TNR6pNW5apfDzplFtLYI7Tz
	 g/hubAajM0yEHS+5VN+9JovrHu9OzrcfJiRtHEervYSRmsi+2EoAohxQWkw5kpeR1Q
	 uRWYE4jjyA6KWcIA/y6B21ypT30c1/zs5V4sJNk3o4pEqOLxHWIGQi3s+DoC/+Dl34
	 secGByXQZ9GbiY9wNKSPwloXUDSQoU8W1si4tx43EAyMd3f2JKaDH/bQz91n+yZnVG
	 Cig65bEQT2EaM4fHQZihq54dQX+VWghPtl6iuMoUD7xFgREE+0xrc/h+/Oz0ii2bWE
	 YXGondBW7apew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 2/2] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Wed, 31 Jul 2024 19:56:28 -0400
Message-ID: <20240731235629.3929769-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731235629.3929769-1-sashal@kernel.org>
References: <20240731235629.3929769-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: WangYuli <wangyuli@uniontech.com>

[ Upstream commit ab091ec536cb7b271983c0c063b17f62f3591583 ]

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 10 hours, there is a
20% chance that a nvme disk will not wake up until reboot.

Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 163497ef48fd7..a243c066d9234 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2481,6 +2481,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_NO_APST;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
-- 
2.43.0


