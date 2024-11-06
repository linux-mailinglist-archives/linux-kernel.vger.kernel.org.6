Return-Path: <linux-kernel+bounces-398048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B69BE4AF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BE9E283B62
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 10:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7541DE3DD;
	Wed,  6 Nov 2024 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="f03K9Ojm"
Received: from mail-40135.protonmail.ch (mail-40135.protonmail.ch [185.70.40.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E8F1DE3D3
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 10:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890079; cv=none; b=KRN8vyZ0IZdyy3GL5TIYS9b0zoH2qm6HjfOqJJH8bbfi1PO4NEiBTi4Uui86w1AWpt5oDvoFh8SEL0iAPtW9U8nRH0WuQe92mHZDG6I0+Ndbkar4OKYcaWBWzS7D3PQXWt6Zv+Z9wUt+QMJRxBt3M0LCFKN3msPpKRJX9yqu6wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890079; c=relaxed/simple;
	bh=v0ldc4MKuJZxd0Vs4Lc8g4q7qJQo/4A845isTxqoHzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qcn27xX5+k7ZvcKqedpNQzkAZHVCag4I6Zl2mUEPWwupf/8BjBN9UGDwmVkMxdo7PoOsk7EHxDXVpmFvAU5M9m7m58o9xUDmYV44tMst0xWcVqownpq19b4vOqUI1zB7Bg0zLyLy+I5zYovST/Qo6F+DiRNc2//h/FMaatnrd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=f03K9Ojm; arc=none smtp.client-ip=185.70.40.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1730890070; x=1731149270;
	bh=okwVwo7asZ9u+tVOHleOHRoJjZ574ZQY9yfS63ntQdM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=f03K9Ojm1YKTa2f7VqL7KWrRdp47xlYl0cBwVOYq6zyWRWu3LU3bZlKRsdIX4ROLa
	 noPNHsmSxxgp3PQrt7SbxWSPx3Zpavi/X+ubull6a1XpFSS2c6KMd1E2JOShfklsQo
	 uB1zNKPvFSNvNOo6TZvY6zePQdKaUqJBmNCoNPQmbTDqSOllCOu7AOPlT9r7xik+1T
	 4vn94zWTP3xFu9MQaebWHAu01QJjlGYHnYenPohpc1bilsrDrLZCPiUgIiQuHFa3Pw
	 dtHXbOgCFJAPv7cyUZj1YF/CUQBo93DVI1hi1vxgNG57oHz8UjKw1hQGAMDxtfPyTg
	 EQLfSZfN2JecQ==
Date: Wed, 06 Nov 2024 10:47:46 +0000
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] MediaTek MT6735 TOPRGU/WDT support
Message-ID: <20241106104738.195968-1-y.oudjana@protonmail.com>
Feedback-ID: 6882736:user:proton
X-Pm-Message-ID: 09934d38fc3ebae1fee80fc7dd599a9c054ee796
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

These patches are part of a larger effort to support the MT6735 SoC family
in mainline Linux. More patches (unsent or sent and pending review or
revision) can be found here[1].

This series adds support for the top reset generation unit (TOPRGU) found
on the MediaTek MT6735 SoC. TOPRGU generates several reset signals and
provides watchdog timer functionality.

While doing so, a fix is made to the restart handler to make it work even
when the watchdog is disabled by default (never enabled by the bootloader).

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Changes since v1:
- Split restart handler fix and MT6735 support into separate patches.

Yassine Oudjana (2):
  watchdog: mediatek: Fix mtk_wdt_restart
  watchdog: mediatek: Add support for MT6735 TOPRGU/WDT

 drivers/watchdog/mtk_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--=20
2.47.0



