Return-Path: <linux-kernel+bounces-533354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC04A458F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9A77A384A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2622425C;
	Wed, 26 Feb 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InbfX1ym"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EECD20C033;
	Wed, 26 Feb 2025 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740559938; cv=none; b=MpUWI1zwbtR3uc3E7darjL0TJgea/gtAGSSG6TY3vEu68oV2FABwbiD96vSOGP/+VXfT5mFAgDzElJwsVqRXxc4s2iNhZpZKwnXtYUogJrdkjHyeSAL5PhTHpCNs/tFa3eGFgMO3f4wAK65dPd2Z6xyEWWrdVMtcrMXUS+/erH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740559938; c=relaxed/simple;
	bh=u8k8xkGSvhfumPla5cLuAM1wtrrO9kw4b4n1qMmxcCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aycoIW+KoLPQ/zLtWV/bq7qmaxZwgx6P+QzHIa8coGqW9chunSdoqabKv4CCTTm6c0Jddew+sjaZ/Nhmz9ibEayMxhUtTZQJHIVgzt0dPBnoJliwnmXI5oJztrEUfpBwgTSgWoFcTwnp4UyEo+O9zukjV8ZD0/DCuRQbyIqwIAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InbfX1ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C50C4CED6;
	Wed, 26 Feb 2025 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740559934;
	bh=u8k8xkGSvhfumPla5cLuAM1wtrrO9kw4b4n1qMmxcCY=;
	h=From:To:Cc:Subject:Date:From;
	b=InbfX1ymiwGRRXfIM2HIgSzuEvpsr2TD33DQR5OF4niI33b2i21t11TqLm7YpGrEL
	 1p7La3xwQ2KiSlnf1tfOWALWS9XL0uP8RT8jKAh7pKSQSIwM2K/RXB7+bNalyG9V1O
	 JArbg9GEEg6U6zyEoLJfZOTxvayYKZmeG/bf5ZUQuFeAUAPC9mg8RCD706lGjqWFeb
	 GSr6j0jsM6neFbNz0V/8SsXCb+WRz8kb4rH3hf+Y64yu2q7dkzwjXGiVkaVZjui9lJ
	 pMEalQNm3asNM5ulpwslW+K/Fb0v3RsU/EUAMxyR+vAhoCTrCTk6MDynk7WpvXKqSW
	 Nvzybh344ZoJA==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH net-next v4 0/4] stmmac: Several PCI-related improvements
Date: Wed, 26 Feb 2025 09:52:04 +0100
Message-ID: <20250226085208.97891-1-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
  - Add missing full stop. (Yanteng)
  - Move forgotten unused-variable-removes to the appropriate places.
  - Add applicable RB / TB tags

Changes in v3:
  - Several formatting nits (Paolo)
  - Split up patch into a patch series (Yanteng)

Philipp Stanner (4):
  stmmac: loongson: Pass correct arg to PCI function
  stmmac: loongson: Remove surplus loop
  stmmac: Remove pcim_* functions for driver detach
  stmmac: Replace deprecated PCI functions

 .../ethernet/stmicro/stmmac/dwmac-loongson.c  | 31 ++++++-------------
 .../net/ethernet/stmicro/stmmac/stmmac_pci.c  | 26 +++++-----------
 2 files changed, 16 insertions(+), 41 deletions(-)

-- 
2.48.1


