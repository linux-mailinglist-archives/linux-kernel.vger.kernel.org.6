Return-Path: <linux-kernel+bounces-557342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C78AA5D791
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D03A7278
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E672522F16E;
	Wed, 12 Mar 2025 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="R+0iOhrk"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076622B8C1;
	Wed, 12 Mar 2025 07:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741765607; cv=none; b=am2qgDlSx0HF4rhF19W5uwGGLNOhhqladUYJ2ucDJopK/TDO4BkpJ9z3TSEAHRW1OKay57UmB12938fS/VpYugXuprJN3HicIgydtDzIRvvdNunBglq1bGb+Z0TiTIdcpUl+Rn2UTMHUzxe31TeAhldBxHWR0FSycDjOXyHah18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741765607; c=relaxed/simple;
	bh=50PBhrwCHqqkqKaYHsK9XyAJBYvngc+6tjTHoYLf4XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkEVYJQgZQsLdAVypYY7p4+BlRD72dZKbL3xJLjOFUGeUKgIUAcImmtimUH8p9tauI6R5efe/rvZ2b+LxKf442FQDOU/n/I/IRR6jpgwNuRErZ9htcZtqgomtuS7jgF4zoAt+Xi7ZYMpgR8qZ7WyRUHF5otde+U2J2hK3UeBHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=R+0iOhrk; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uOaYlMR16ocTVhMNRL7whz12otBB12k1wVD5/NLoge8=; b=R+0iOhrkVzLMeMS4WK5rrjMT1j
	xCzYlbkluSbN+92rrwqkiedltm7RTJoT4ShJHDMUAw5pUrZzqRVBKbXO2KnTeTF1ZGB4iXYOI4Q8T
	rEWn9pa9zBbqsbVJtixVEveeO6l69pOQEfSqpjMfSo1OTMz4SHPM12Nbc8fivMcNud3Uy+DplQcEj
	qvV/2kHhbJIjRdQ/MfGoAhpT0rzkTtpxmih18sMbjGGjWHFd6fikVEcgUdk0son5E34rzpwSQl/TV
	2ezAlW2CAG8vcilkizrqUfcUfD2Eu95EMZc5Tuo3HdeXYrF2AfeMoo/8ojB1X3oCP4ny3W0589kEt
	t+sum3/w==;
Received: from ip-185-104-138-79.ptr.icomera.net ([185.104.138.79] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tsGnZ-0005zY-BT; Wed, 12 Mar 2025 08:46:41 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH] arm64: dts: rockchip: rock-3a: Remove bluetooth node
Date: Wed, 12 Mar 2025 08:46:02 +0100
Message-ID: <174176555639.249409.16980967669607961093.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220165051.1889055-1-wens@kernel.org>
References: <20250220165051.1889055-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 21 Feb 2025 00:50:51 +0800, Chen-Yu Tsai wrote:
> The Bluetooth node described in the device tree is actually on an M.2
> slot. What module is present depends on what the end user installed,
> and should be left to an overlay.
> 
> Remove the existing bluetooth node. This gets rid of bogus timeout
> errors.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rock-3a: Remove bluetooth node
      commit: 9602f47fe6dcca9318f35f7b72b4e98b91c5a5cf

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

