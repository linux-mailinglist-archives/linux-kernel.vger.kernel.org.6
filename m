Return-Path: <linux-kernel+bounces-205158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8698F8FF836
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E2A1C24ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9113E3F6;
	Thu,  6 Jun 2024 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mCxhBDM7"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F534D9E9;
	Thu,  6 Jun 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716960; cv=none; b=dRM2efjeLeIUj1PhSo4kc7U+zKwHNNRAhhFZmDFfKzxiKf+KYaS+CuhL7pd3AkNddlC+bjipZfViH/hFsuZ6SJ8DFdEUTOZVr6f/3noIXc1gD0MLfDQAnN2E0FeFpwzEcXaq/3Tjr+pWJrf029UBlPtHuaiDwQ8n1udgMZz4eUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716960; c=relaxed/simple;
	bh=loi3prIa543fAZtl1vidhU7NhQssWhZqcaExoNvhSDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JphvGv+CNymSWXJU7vm371f24l4d3ezNMbmTo/oYywHII5CKofv1vcBvPcxnoceTpd40arIO2VoWNI2HM6fExLuJrTZvxIHeUIVmdHCEuuCdCXdxw/a23KCfa9SMGLsLIxgWV5CcCwdaLkHfjLr2hcNesN7QwSuJRt9xq+iOOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mCxhBDM7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717716950; x=1718321750; i=w_armin@gmx.de;
	bh=iPUkg63AlL16kRuhkyi5xt3RMl4Pukm38rNdGk2/4OY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mCxhBDM7voF2gp2VGYEwELSKAdlnaqMsOfHUC7dVSQtIEOqPbsP+Q48GxgR5kYOH
	 ehx+ECNhIwCQ8DLe5LidmBUNw9S4z4xeyXrtLMxrBrwoiBIYPO83HdFhV3/zXJqJJ
	 ebT6D2lZhMmewIBBVpclh8Nm1qDYaEASO0tIWhxdMiakTrOVVnfnBuVTIGygizScK
	 JIj0U8NW/P0WcaI4v2jJjLRiQJLNgRTZaDmGRxMY5fqrUSN6OK+s5d6gNyta/2C1o
	 hXjkkUZMM5+5EgJxYTH4teSO/iwOZsM9vnGl83K4iAEUFzOOB9dT1p9BNMIl7A05E
	 5fBwrw0kpMV15E6sew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MfYLa-1svKAQ0Q0m-00hWKa; Fri, 07 Jun 2024 01:35:50 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	agathe@boutmy.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] platform/x86: lg-laptop: Support 2024 models
Date: Fri,  7 Jun 2024 01:35:36 +0200
Message-Id: <20240606233540.9774-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O9N/av9oVdWTx70jsR4CYy9o9fGJwUFvl8Vcs90O09rLURETOBI
 sGADWq+SdQo6XIyDV1zT6Dg/qz6McHLL+A9NBLnf3cgYuwy8Bz8PrODsOPijWg7+37BMRp2
 4V81m4WwlDnLHymPxFYPSWR61QkaOlsKABvaEN66txiRYtl1MErzkh3WBHoCAHcY29kh1YV
 2JRhpMTb19FhyGroxkc5w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KHSGMCtecAM=;65MFDZ+sG1awIV6Y7X1HzD9mQxt
 oIES1J95QisoXEKqxWlMsPNnnZUxYU+789EbnKDsVGdtw4+2RvoHdTTqPuj8qrYI4xmNafkXi
 ZtVg5JTtLmrrT8hsOa9b397Fe8jRjosq71tSPQbIrm+oluKsaKdhyI9kQXQXNnkFYR8BvkyDt
 rJsPm3Lma4dpFX7HIg8lw1c5cCXPMG+Qmuz60yl1nOceSWKrqvyCgL9Xv/2lbd/HfylOYAE4v
 w7FmBM8JnzfgQiiR9Sn9oyDMQsHDLUoJojgjvdWzGhFnyURXRqMNvxcOeJa+cZxIsX869awJ7
 kds+QGZY6ftJUXsIrtOts/8v7Pd2T50tRVKL+FFzTrxJRrXrIADsER0QkG7Bhoj0hsjTFCGK+
 2XVF3n0PVnQSwhPUpDBnu7MZe64HInsWYZspO664yzUGIDUQ0Neu+kabHgD3lTsYBQZsVO82M
 LXJ1GpIijMSrVI853KzdstQlEI2qKMY17ZsxAwGV6UiNZ6+dgE9S+G2gAGw5/IYphH4BaL3xM
 z20qk1qvz2d08Iq++/fpnnl1UO7p1pSc2/T6eJTQ4zXZAfIAtvnzbZNZZVZmVLnskw18h6PdA
 KmDNt5qvUIGnftm/+tO4LfuZL8OycRaz6qlz5LbPo+vq5i3M3DYD57quBitYsH9R2/8iY2L6Q
 NhWdJ+xxb4P9qOY/IgkncA+YsLf+B+DPLy7XLky8rJlylQRdgVSAogZVFopBRTrstYyplcKSb
 gwiqMqImHXR3BrglNgWcBDTBZrOaeQ5z6IVPJcJr9QTAu15gp6t7BFwj1maLbbRsw9XiwKcCx
 2cty6dOMITVVebmkfZ3uPenlpfenBF7OJX1c3lVsjTXpo=

A user complained that the lg-laptop driver does not work on 2024
models like the LG Gram 16Z90S-G.AD7BF. The underlying reason turned
out to be that the ACPI methods used by this driver where not mapped
under \XINI, but instead under \_SB.XINI. Those ACPI methods are
associated with the LGEX0820 ACPI device, which was not used by this
driver until now.

The first three patches move the airplane mode hotkey handling out
of lg-laptop and into the wireless-hotkey driver. This necessary
because the airplane mode hotkey is handled by a different ACPI
device (LGEX0815).

The last patch finally fixes the underlying issue and uses the
LGEX0820 ACPI device to find theWMAB/WMBB ACPI methods.

The modified drivers where tested by the user which created the
bug report and appear to work without issues.

Armin Wolf (4):
  platform/x86: wireless-hotkey: Add support for LG Airplane Button
  platform/x86: lg-laptop: Remove LGEX0815 hotkey handling
  platform/x86: lg-laptop: Change ACPI device id
  platform/x86: lg-laptop: Use ACPI device handle when evaluating
    WMAB/WMBB

 drivers/platform/x86/lg-laptop.c       | 89 ++++++++++----------------
 drivers/platform/x86/wireless-hotkey.c |  2 +
 2 files changed, 36 insertions(+), 55 deletions(-)

=2D-
2.39.2


