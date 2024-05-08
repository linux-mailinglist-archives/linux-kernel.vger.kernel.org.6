Return-Path: <linux-kernel+bounces-172726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAE68BF5D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20248B22EB5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25F617BA7;
	Wed,  8 May 2024 06:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VF7TMJq4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ElyOoeBQ"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DC1A2C15
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 06:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715148012; cv=none; b=X/Qc9FXpHrDbuS592Bqbr4JR90oAg6eBQ6K7VG9NjraV5azrJ+SQr71S4bV1FItc8p+jAINms60iUeSuG00db9iynFkGqx5n1nTTkY/PwKY5PawOel8N2kXydmu3Bfc+WLqqprgaTwtgAT7JBiO5Hx/oHJf3cUGRdG12gXe1tuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715148012; c=relaxed/simple;
	bh=nJBdU/phsT2duo50/TkwO6gg74OzUomF46e0q8KQ18k=;
	h=MIME-Version:Message-Id:Date:From:To:Cc:Subject:Content-Type; b=jqrRLyv5sGMFyYdeFRNLmxAUmmkhJJYhC8C1sP2FFqpL6ortzdpdsDy/XWzk6nr5Tv9v224jD/xlIjRMBoAhwFp1jHjRmptjEk8SiLHasdWG5jfDNHYbvXkRSDvfmnyXxnq9KfAweGpsD3pL4FDMxdmjevDTh3PrmUMJuND24qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VF7TMJq4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ElyOoeBQ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B1EC01140373;
	Wed,  8 May 2024 02:00:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 08 May 2024 02:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1715148008; x=1715234408; bh=Y8akIGgpPxTEYGPDiQP8mlHmghc/is8+
	EovMJZsxLNk=; b=VF7TMJq42dxp00WdJGfVmxJ4UqJYlhc9JbCvEQkElPFeu/7p
	4jDq/ZhHMW18M0S1e6gXQ6ld16kSE7bhAQiK/k7zrpKL4Pw3rbwUjhBfsORl2koW
	UHgsAnbkP13nWA38irgU47T/yOAV0jAxlPvu0O0iF8tWx9HLXyutzjavTWm6NIyP
	MNYZCHZs0QTtSqWcNX6/6Io7+NuWCTZGMm/A4dXTHOwOi0W4egFwIWHPLHjSo6M1
	nIH2mwDDvuFo+gt5DAWX42ok/+4vYfk6HeOGTjJcTPrRUAlOmwMqNcDdH76YgeWs
	qytz8OnSc1oY6DXTCuFchy1mn4sL29ScvRw1Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1715148008; x=1715234408; bh=Y8akIGgpPxTEYGPDiQP8mlHmghc/is8+Eov
	MJZsxLNk=; b=ElyOoeBQQSPqIpjMinoYoMVhH7Vn5Y0lHFgHYgZ3qPnN+xThFC2
	ZRp/JLM6tuOhLX/hEo6ZIiwITGTFPtaH/wRZJxjGtZO2RSTVFj2DDnkXLU6hgWt1
	IoAPo7/m/+M/P+Tbjoeke3BXPwCte6wuiF+5NBB4UbroVqakWoYUvN3o7/kQ3GZL
	w2uSFpwkCJOMVAPqnQ0SdmUXTidlUqX2VyV2Y5JfZXVyZq27018x7wr6GDYJZiXK
	+obUDa2yM4qZqF7Lo+pW0DG4JP0cQxTT2ctFYpAvC9TLWcJjst3PFwiyH9OJChXM
	/dPpHUt6XmiiedSRD6kDwKHl/o2i2+hT3IA==
X-ME-Sender: <xms:6BQ7Zi5PuRzKr2sE5MYTBRs-IDvt_2ts2XnB_S-K_UicZ4ZsojguAA>
    <xme:6BQ7Zr4maOLyJ3OVMkOcdk5IG2MVPN8CRoKb-P_4yNAWd9H6Zts2_91p0E7Puq6G8
    JTU3bJ63nnf8eiusGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvledgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkfffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfeefuefhkeejvedtvddtleeltddttdejgedvhfdtuddvhfeukeduiefhjeetgfei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6BQ7ZheLr2u-9WRhZFrubjPCG18EM0gMC3kBgUDwjbyKCvO_ipBZzQ>
    <xmx:6BQ7ZvJOzABmXDC7hsvmxId3f7dsOtopN57LLq9UDmFh_81pzK0p9w>
    <xmx:6BQ7ZmLNRsUzIchIG0r02Y0SO4xEPAMkvpASG7DbC1TxRPeftk40LA>
    <xmx:6BQ7Zgwb6m5EphtJgLC5brSJZALMNymPvSl2kwl7UIvllPvg5N0IsA>
    <xmx:6BQ7Zi1WXvVohFQbKF9JYO_DX-P8isnkfpn7ZVfOzf70lpmGWTUtMcUi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5157DB6008D; Wed,  8 May 2024 02:00:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7abb76bb-eb4a-4136-af2f-6b22fbf3d79f@app.fastmail.com>
Date: Wed, 08 May 2024 08:00:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: soc@kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM SoC fixes for 6.9, part 3
Content-Type: text/plain

The following changes since commit 14672a9b3ec5c934cf86658328a56207337b54ff:

  Merge tag 'qcom-drivers-fixes-for-6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into for-next (2024-04-26 18:08:02 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.9-3

for you to fetch changes up to 5549d1e39989e2ba86c4775546d0bd8055746cfa:

  Merge tag 'qcom-arm64-fixes-for-6.9-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes (2024-05-07 08:07:06 +0200)

----------------------------------------------------------------
ARM SoC fixes for 6.9, part 3

These are a couple of last minute fixes that came in over the
previous week, addressing:

 - A pin configuration bug on a qualcomm board that caused
   issues with ethernet and mmc.

 - Two minor code fixes for misleading console output in the
   microchip firmware driver.

 - A build warning in the sifive cache driver

----------------------------------------------------------------
Arnd Bergmann (3):
      Merge tag 'mtk-soc-fixes-for-v6.9' of https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux into for-next
      Merge tag 'riscv-soc-fixes-for-v6.9-rc6' of https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux into arm/fixes
      Merge tag 'qcom-arm64-fixes-for-6.9-2' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/fixes

Conor Dooley (2):
      firmware: microchip: don't unconditionally print validation success
      firmware: microchip: clarify that sizes and addresses are in hex

Samuel Holland (1):
      cache: sifive_ccache: Silence unused variable warning

Volodymyr Babchuk (1):
      arm64: dts: qcom: sa8155p-adp: fix SDHC2 CD pin configuration

 arch/arm64/boot/dts/qcom/sa8155p-adp.dts      | 30 ++++++++++++---------------
 drivers/cache/sifive_ccache.c                 |  2 +-
 drivers/firmware/microchip/mpfs-auto-update.c |  8 ++++---
 drivers/soc/mediatek/Kconfig                  |  1 +
 drivers/soc/mediatek/mtk-svs.c                |  7 +++++--
 5 files changed, 25 insertions(+), 23 deletions(-)

