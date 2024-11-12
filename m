Return-Path: <linux-kernel+bounces-405820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CE9C578F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE73B1F22F7C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A261CD218;
	Tue, 12 Nov 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="edookn7v"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07284D2B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414006; cv=none; b=oFI5oOaPOHbTB096ZP5or3p4ge27bz+wKwAcM4YP5Ix99nixKyTjMalF3uUnfRf3Dt3TJTNaDqJnzurYz4RIkOMBkQZ3OTumL+eOEwF8vZKJTSUoeLD8uOcSYZe79MnMEmw/liRUmiZX8ubUPoWOQCAUSyR5DWsqOa9d3gmyidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414006; c=relaxed/simple;
	bh=WbqUoNGStj0yJBWRAcNQgXuOpvQ0qgq97BNeRTq314k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zm7UCOwJiwUB+SbqtzWfzjBgau++RPYJ2Qo64vGtq952cNL8x1uuHheWKY1lf8sHUTzmf8VWHwBF0PmtfhE6AsREeOHxlHkAa5xcYyoT1Zoz2k5829oHpWb1FLhM3jJ5eqTkbEWjxGQJq+dISZlchO1hiAGuyTGanrbU0rhb1VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=edookn7v; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 8FC8D40277;
	Tue, 12 Nov 2024 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731414001;
	bh=Rk0IMDV/zo3xqw4/+uhsC9QPVxMHlRKdYyoLckuxcaE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=edookn7vE3zkcOcPbpMhHIPJRGqC3qsbW83obD5/k0crimbIcpQsXaLTyeqWEqRZu
	 MuicvhAG+S5UpwoD0CtRvkiRWwNrv9B+cOpyP/MFrQxgk9gP51wQFsF60dgbgTxVFA
	 +DCrTxH8daHsncL0NE44zurKtwihKy4mcDWqLeoAGhEZhcFIeqLnb5p/qPveQ7Hkg2
	 l+5NXMGtnPJ0a0edRJs3PSCuXqTEAhHjpboROz4bMcNMogl9VaTOi1zufrJqomlu9l
	 H53D9EWFdNEMXMrG1atQl0t7D26T1yG7V4P3vuZiLXGx2VQd7To0yd9da5W8VGPcXP
	 4XM7jeJnDFXXw==
From: Agathe Porte <agathe.porte@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Agathe Porte <agathe.porte@canonical.com>
Subject: [PATCH v3 0/1] ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields
Date: Tue, 12 Nov 2024 13:18:24 +0100
Message-ID: <20241112122000.35610-1-agathe.porte@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: drop stable Cc as requested (because the value is not used), and
    reformulate patch description

Agathe Porte (1):
  ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields

 fs/ufs/super.c  | 4 ----
 fs/ufs/ufs_fs.h | 4 ----
 2 files changed, 8 deletions(-)

-- 
2.43.0


