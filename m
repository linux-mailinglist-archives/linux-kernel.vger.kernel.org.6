Return-Path: <linux-kernel+bounces-560235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0067EA60075
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 20:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53EC919C0F61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 19:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ED41F1932;
	Thu, 13 Mar 2025 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zjw9b1/W"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D961F462C;
	Thu, 13 Mar 2025 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741892617; cv=none; b=cnLBLkmJZMPd7B/blQEfBD1vN4jfAPUIJb8RMjiu1odvGbOaCfzJMzbUHs24mVGGEDLMj9QFhdDc0aOJ76yMTm9vvenlwCyjn8iurhTTMlEMjin94B07nQy0AC+1gpWkiRSjwdlQ2fYCroYiRoh6aiPjPCI1JRsa/5+HZdenpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741892617; c=relaxed/simple;
	bh=zbiRm6nvzjjJNmZae/fA2d/LFL/98Z98f2fhvHp8QAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ow8ybgo6xVlNu/3NKP7o7+ha+Cr0S1e0C5b5BQni1hmSet+kj54m6x7pxQAAXxgLu5V/AU/RBYm975oNE+cZkp61ALgEoqK2+DmwbVsf0hfstw15ndHPnsQ3Vta9+D8qfAiJjav4xh4mONpRAGPoI7kK9lqq0V6Z6GBYLC95/X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zjw9b1/W; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=H5mdS2EnE4cpGSwW2dj+33eKcmSk0c9tKXjXQcM25/Y=; b=zjw9b1/WQHf2OAGZlzSVLoknvh
	L1RzSpSTzDaBy2/7e0enIt/0atwWM1R3t4p6z7c+Lnp9Kqve3jzidGIU2liFppchMDCJ/55q3o81w
	wBmcrUYreJ14Nl+B7ENvo7tK0OH1ZmtsY8/c0UnHNNz+gu04WenM0+w7HgetKI5XlUgGYuG8mkSh8
	lEllzjETEAnNXmGdbyWXjj8MMiE5V/9s4fo/aMhSSXgEKAcJ+5X+VSiqLyqWVn4FiuW1RLhqOw8vz
	LcCcK+pI1jy9CJy2gEJbZyAZvLAOZ/0xnSZkRtjgcKlUAZG/vq038NnSC1FWFqmSfZQZvM8XjDBvC
	fwApDVeg==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsnq2-0001sH-Jr; Thu, 13 Mar 2025 20:03:26 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI audio output for ArmSoM Sige7
Date: Thu, 13 Mar 2025 20:03:13 +0100
Message-ID: <174189257844.294070.2578524540715601524.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312164056.3998224-1-liujianfeng1994@gmail.com>
References: <20250312164056.3998224-1-liujianfeng1994@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 13 Mar 2025 00:40:49 +0800, Jianfeng Liu wrote:
> HDMI audio is available on the ArmSoM Sige7 HDMI TX port.
> Enable it for HDMI0 port.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI audio output for ArmSoM Sige7
      commit: e2759a8d452bcc1b64ecd4e819411fa26b6ed72e

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

