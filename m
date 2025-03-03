Return-Path: <linux-kernel+bounces-542860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C28A4CEA4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BF37A286D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769B23A998;
	Mon,  3 Mar 2025 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="aDnmYlnm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1C23A988
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041818; cv=none; b=CJyd/2adLMYVpPthPDt24BQ5BgUlcRmXMXGCxfIKdBi0up6D0cUQWNkqpgTbTNR4NFVaXHZVugtbkbJVZQrSeghuTXGKmQsmsomU964hFd9Zk/+QOe27YXfKgtNDoBKG6aNPA7qpcq1C+QVdBES5od1xahUlxsZfZ3jxPUc7Wrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041818; c=relaxed/simple;
	bh=iaOb7SOGoDTKBEdFcdchCA5rfNRAvnKA7sIZ9ATcDwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HxUEtILO8EEc3pdC80qSbT/uuecyd6GgM85Hr5sWmKWThhvi4ZTx1gOZZ1EeGv8ee/wOqBGA6GeGqRKqnfKuNlNrhS+wx3H+x+QHvgZZPjwAIkCe/Zb1eQ8CE6C9nN/welXK4bhwE1w7VUZKiMbC5eIFm4eiEm2k6ZeF4U4+480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=aDnmYlnm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AVKxuo1W1BxE3FJKf7YbMkOhKpBvK2Ol0T0KlNBKv7o=; b=aDnmYlnmuYrhIaA0ONYcTOUxRY
	KZ7m8hrWZnAkSc/n4H5qBIjO2jzAITieERvYwcbgNsC4HJv6piGgoWLvrHd4WZ1lc25QWfFwcgXcC
	KgrI0KQ5BSzpUXxPF1Mvlrms/K0lNbBNLgJmHB7ne0/52hnujUALKrWqF4TSTalaRCCr4upJ5Q9u8
	Bt2a0hojXOOlm7Bzd24GXk0CKbp1jUmMa1OE/cEcYW6WGyjQdUHAu8mbMQ18aj6mbr8PlTPehwi4q
	Mc1e//pi1ncYZlLsURNMjw2K0ed9G4Lh+9S/BGXKzEe5o7yfDHhIF55gN/jz3MRXEeJFalp06uhh2
	pIE9G4RQ==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpEVK-0005z3-Hk; Mon, 03 Mar 2025 23:43:18 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] drm/rockchip: vop2: add missing bitfield.h include
Date: Mon,  3 Mar 2025 23:43:16 +0100
Message-ID: <174104179297.19992.1129192365556530821.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250303182256.1727178-1-heiko@sntech.de>
References: <20250303182256.1727178-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 03 Mar 2025 19:22:56 +0100, Heiko Stuebner wrote:
> Commit 328e6885996c ("drm/rockchip: vop2: Add platform specific callback")
> moved per soc configuration code to the other per-soc data into
> rockchip_vop2_reg.c, but forgot to also include bitfield.h for the used
> FIELD_PREP macro. Add this missing include.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: vop2: add missing bitfield.h include
      commit: 95a5c9d197bb22a506913acb330a926d4e51aa95

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

