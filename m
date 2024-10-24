Return-Path: <linux-kernel+bounces-379478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8709ADF25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EEAC1F23447
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C21B21AD;
	Thu, 24 Oct 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="EzLIN82D"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4313218A6D9;
	Thu, 24 Oct 2024 08:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729758667; cv=none; b=Dr/4qoV37zJtRbKlpAF5u0BE++V1iyBGY82DhXl6xHexQBPzvv0VgmmMNJ5kJ4BDyCaTZU+wHKOqYEheWVzyUOxkqJPafUP8DvM8QFSsEot9ZVNtL6mDbM/8EZ3QJLKWhTcMgUijmWk0T2bLZLMQgbv3RUVxb6iGbCkT+i04bZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729758667; c=relaxed/simple;
	bh=eyfzA6Z8+XhEo4eDN9egGayHNzjtTD4jwHQ7hziTcio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXgr5JE0uWo9fR/fJ3whGAo3ZfAStWpzYLL1Y2fiyOhazZkn0iykeDpw2FAkfAIMfKArRKKmBQZkAUT94SUnkvrozbsMh7XxOtgEWYT9N8cZFVVeJuShs9Y8vjJiJuCBAnmWQbNr4CdWhkYxztXW8O20b10Ig7gmevE3q6CVtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=EzLIN82D; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5qQWxtU6GqzgrbCaUsvRleEvRl4Zs3up4/mkoq8kfWc=; b=EzLIN82D8z0dZajYuP09a2o727
	P926hnzmqmrfZ1W4hKprfKNELKb74TYB+HS8BcmiMFahoht3ZghH1EWi7YnaItkugb7Ucsok3s9/y
	uBZ56WubQdJ7orTam5pyMaF/O5JS23axhM/80SfKQvpSEk4F5nyQkIHzrEAHVBNA+932t9Pdi0MoV
	xhwx3MvZtWI7s+1QPRLfTMZYOyNI0KQRzNqsc5zDX6c1FxhYAn/h54QD3c3lRZ3cvX8yvI795tC7v
	0nUAB00CxtvTVEYDps2eDi7tzKdRi7fum0WPyei6p4hc5HvhiPmmnDA4GNXPohB8XdJcwyjYv0kvL
	fZ9LBlcQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3tF6-0002iS-Tp; Thu, 24 Oct 2024 10:30:53 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Conor Dooley <conor+dt@kernel.org>,
	Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI0 on rk3588-nanopc-t6
Date: Thu, 24 Oct 2024 10:30:48 +0200
Message-ID: <172975863600.1671562.9741515053746960937.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023080605.623125-1-marcin.juszkiewicz@linaro.org>
References: <20241023080605.623125-1-marcin.juszkiewicz@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 23 Oct 2024 10:06:04 +0200, Marcin Juszkiewicz wrote:
> Add the necessary DT changes to enable HDMI0 on FriendlyELEC NanoPC-T6.
> Tested on LTS variant of the board but this part is the same on both.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable HDMI0 on rk3588-nanopc-t6
      commit: c3c9cd8f65f7f833de95dd70aa17393afa58f50b

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

