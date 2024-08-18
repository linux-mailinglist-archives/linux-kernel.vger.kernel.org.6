Return-Path: <linux-kernel+bounces-291249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C8B955FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 00:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E65D7B20C85
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C915156677;
	Sun, 18 Aug 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mary-zone.20230601.gappssmtp.com header.i=@mary-zone.20230601.gappssmtp.com header.b="abvgvQ/N"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE4A14F9F9
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 22:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724019935; cv=none; b=IGYUYMEeDDcT8WL1SZj2lZ1LtzXLZ8SXKr9qsqC6hz6Jl6I5HAPGx2r2Bk33Ap3zJOktqyvpg/7TTp8+Q171ponVs0qc8hyUpcB4EjbrGPcnOj076ipqMFxhy1eiR9qNctu/Bk/xoDZvgyhD4EsGM76CfKqjcjk+6r+ytCqQjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724019935; c=relaxed/simple;
	bh=Irz8y92GskMbn8MArTehWwdO4KqE/UfmIXeuDJiMIe8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VT2fcVZ1BeLg9IlkBaFAW/ob932IOJybM8bbUSshLN9zYAtcD63djXZvjJnh4vAjVVzqqBGRHZ4gioWp7E3YUdG8FKUSXlyyQcK6v1bIw7xK6JLy3By0cMBHx/HCk7bEg7P+prnhNAZimhU9rKSIrc2AujDO0/x2GcY41CyLMxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone; spf=none smtp.mailfrom=mary.zone; dkim=pass (2048-bit key) header.d=mary-zone.20230601.gappssmtp.com header.i=@mary-zone.20230601.gappssmtp.com header.b=abvgvQ/N; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mary.zone
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mary.zone
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3718acbc87fso1888283f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mary-zone.20230601.gappssmtp.com; s=20230601; t=1724019930; x=1724624730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqAdiXwdc4WKD9jrL0+anoPpAO1BeOGGu68HefXAL2I=;
        b=abvgvQ/NdRx4qNNJ28yQzdEW0/GU3XwFPuLf0KymPG4tk8CEzjN/Rize7iA0LiNGUO
         PlAw+JOqUeWhSK5QxCUulpper87vYJSD1cc+EPV6+hK2MVgxgkdeXWwhHjVC9qeKPiCY
         lAB78Znmp9fQcwyMzE892ReaIHyx9q7k905kl4UNv3OCHDwOsMX8kiaL2tiV/ekrsDZw
         jOucKlwCnvnl9NXwuY1o6LgZIlv2weTXkrBQbQyXObiaTTPFm0AHtKeAMLNFDlCMJqmJ
         PpNfeHDQ4Oz8fp2sG3ynj/B+cZijegQ+Em+0LgK9m1UhGDbH9+gycL8MXOcRWDA86P3T
         cGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724019930; x=1724624730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqAdiXwdc4WKD9jrL0+anoPpAO1BeOGGu68HefXAL2I=;
        b=Xotg0JYQdFY062eTajQOTqkiPaFb7cH1OE/urDdMoniQdkXuORJYg1PF8RGQD/Nxat
         rxCyfaCO4zTw1WVSGRwrQ4gjZMY/w+gfoUS8XFZhMsG14Bp+AW0AuouKpGc85Ln2sEDA
         fYuXWh4G4VdLlGSv67O3syjWU0F+Z2kPB5MglWT+RxKsls3+rP42WUFumwmKfCem0uO3
         5i70qtnh8raGyrjD5ri0zYs5/lYQSwy3JAwoCtw6HwIB+bkIZcVHG2y4sPD2IGomaxfV
         MjH4A+RvzfrSELvLAaDWJ09bL56LhV1NkbwuZhhYnrTPGqasPB85/HmlUxGaPtMe99uq
         mwlg==
X-Gm-Message-State: AOJu0Yx8duDmzOTNez3Zf2DkIkb5NMW1FGmNGwVFwGxRUC+kIFTJj+7I
	ywrO0T5MpoOVcCWW+ot47ZZi/lR3rPvZ0lPTu+Rw1qGVibm6E2XpFL1EGvBsOJR0MYeyzo5QNhP
	KAaLWVg==
X-Google-Smtp-Source: AGHT+IGdjgbpAgIAWb01ochQkMcH8vi2E4fIgIqpFigzE1GdfrGGMlZPzfkxxJeClI6M+5RTe84ITQ==
X-Received: by 2002:a05:6000:141:b0:371:8845:b850 with SMTP id ffacd0b85a97d-371946c2b36mr6250923f8f.54.1724019930414;
        Sun, 18 Aug 2024 15:25:30 -0700 (PDT)
Received: from kiyama.home (2a01cb040b5eb100f7cb8228474da207.ipv6.abo.wanadoo.fr. [2a01:cb04:b5e:b100:f7cb:8228:474d:a207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189896df5sm8918631f8f.69.2024.08.18.15.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 15:25:30 -0700 (PDT)
From: Mary Guillemard <mary@mary.zone>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	Mary Guillemard <mary@mary.zone>,
	Peter Wang <peter.wang@mediatek.com>,
	Stanley Jhu <chu.stanley@gmail.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 1/1] scsi: ufs-mediatek: Add UFSHCD_QUIRK_BROKEN_LSDBS_CAP
Date: Mon, 19 Aug 2024 00:24:42 +0200
Message-ID: <20240818222442.44990-3-mary@mary.zone>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240818222442.44990-2-mary@mary.zone>
References: <20240818222442.44990-2-mary@mary.zone>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MT8183 supports UFSHCI 2.1 spec, but report a bogus value of 1 in the
reserved part for the Legacy Single Doorbell Support (LSDBS) capability.

This set UFSHCD_QUIRK_BROKEN_LSDBS_CAP when MCQ support is explicitly
disabled, allowing the device to be properly registered.

Signed-off-by: Mary Guillemard <mary@mary.zone>
---
 drivers/ufs/host/ufs-mediatek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index 02c9064284e1..9a5919434c4e 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -1026,6 +1026,9 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 	if (host->caps & UFS_MTK_CAP_DISABLE_AH8)
 		hba->caps |= UFSHCD_CAP_HIBERN8_WITH_CLK_GATING;
 
+	if (host->caps & UFS_MTK_CAP_DISABLE_MCQ)
+		hba->quirks |= UFSHCD_QUIRK_BROKEN_LSDBS_CAP;
+
 	ufs_mtk_init_clocks(hba);
 
 	/*
-- 
2.46.0


