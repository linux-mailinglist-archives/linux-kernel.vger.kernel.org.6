Return-Path: <linux-kernel+bounces-402969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 768A09C2F19
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72B91C20C9A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1351A2645;
	Sat,  9 Nov 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="oGc46cJD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2BC1A01BE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176857; cv=none; b=g70K39vtwmI2PizG3k3re3jjpOIISave1eJLkPdiHF3Ox38FzALl/ALi8lpxc+2xwWVWYqy2lEWYG5qvygqPSnSa3dyZMDO5ymmqWyzEwQpYlobmhrOzhVyZYNF2ov+VjuVohgEs7TW0DboNi8RDcdPPaDQN3Cf/BHYTKL7ABzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176857; c=relaxed/simple;
	bh=erkag8FvHELw/+/bfuaNsD6ch+DEQZ/8iDBj5vakvB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnS7upKN2R3WXkv9N6By65DMnxSWL+10SwynKTzgmQJDZXo9052rm04CgHfII45puVph95i+eaATvUIlnPZ/wQEUTxr3EMGMweNlOmmytYE1PtMpLWftMi95twPjqc0Bm6UWkD17Z5eiybsOkMBdohiwXygsnxKhIf2I0DpxJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=oGc46cJD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/HDjJGOXuOV38kNqlV+5qjcu2mYVRVqPWxsk6FhjpQ4=; b=oGc46cJDlpYchSg/GFr44IDZxC
	5Ge2fxM7rVRJGx0c9JfOZtmQBo/ppG6jt5sbLHprZqIZmbaWf64diJH/Xv1DetCgzrsms6FbaoPu/
	WRqXbG6udEGW3uC8RNGo7JqL/tOxy+aYdBl6OGJQvf+ptB4P1h9NM6nNkiDDuKR8WiMXMKMkksMV4
	NL6rh0cSrk5o27WEMQWrwrrq5Ec1Q7gQ4L0FYpmKqn77KYQHcLhTCQydz24jjfOl+IKCeYa41+w69
	+W8laKrDnPJ9RZ3loSuUASlWEZGorVDLq663HCucPEHxzA7NEM6mbd+qVzSQerXCPlFfox5UMyNuE
	CHNsB6cQ==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBF-0007Km-Id; Sat, 09 Nov 2024 19:27:29 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Enable hdmi for rk3588 based Cool Pi
Date: Sat,  9 Nov 2024 19:27:08 +0100
Message-ID: <173117675957.1131306.6481140376218988545.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241028123503.384866-1-andyshrk@163.com>
References: <20241028123503.384866-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2024 20:34:55 +0800, Andy Yan wrote:
> As the hdmi-qp controller recently get merged, we can enable hdmi
> display out on these boards now.
> 
> Changes in v2:
> - Remove enable-gpios as it is unevaluated
> - Remove pinctrl setting as it use the default
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: Enable HDMI0 for rk3588 Cool Pi CM5 EVB
      commit: 09372610e765c0e26271e45c4d582ac8b5c97b7a
[2/3] arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi 4B
      commit: ae095c837e9d39216354260778ab6e0888b81ae7
[3/3] arm64: dts: rockchip: Enable HDMI display for rk3588 Cool Pi GenBook
      commit: 4eca4e3f890c5635d25600e680df5adf93742149

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

