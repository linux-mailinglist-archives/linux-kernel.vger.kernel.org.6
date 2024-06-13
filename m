Return-Path: <linux-kernel+bounces-213717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FFA907973
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20401C23050
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD763149C79;
	Thu, 13 Jun 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B51TCbhl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3821494D1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298656; cv=none; b=inPd1emuwgQTNZHoJleK85mTqSIzZnRvqEkrfiWAwkFExxKFlf89Lyac4zfh3CYI86U/PV4SSIvvAmcEehEEkd29L31AFBbYK//DdKGCCW8aVqUn1P9BnAyMm9evNWs5ogeBhX4OtRUpWeZpFtpp2yMquyneuANbMf6EHUK3vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298656; c=relaxed/simple;
	bh=hAvadJc30c7xwyyr2Veg3piHx/bbbzaPI9OpNL5/0Og=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ip8uHKnvRTAHwQTCdLWCrrdnZHQLgnIs1KLH+V0BT1Jx8leIFCYnYnnuN1BDXIk84lvTmv6lpvs3OhT5oGV58/cTO3kTaG/fHDr8VhyL3UwQrDkEo3C/XHT5o+W82NieJCDPlX6tPrGZ/F0ojHcnCX5M4SXqk11bR/4YRqGF0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B51TCbhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6FC2BBFC;
	Thu, 13 Jun 2024 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718298655;
	bh=hAvadJc30c7xwyyr2Veg3piHx/bbbzaPI9OpNL5/0Og=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=B51TCbhlWFhEyQtPYVLxn7b8XSjANrp/Wp28BAiDKti08YwzLiSjExRS49v4yRIR4
	 DzhSXxhtZrW3ULetc9FgaIA2UI9937UOYSQkYN+c6U1Ky/z5YRyvK5tQO0wNtJbhFj
	 UsAMfZ9swL1g6a5Qg8KveiPWpczbXJkj7+9/fnCG7d5yvpb95jMDs1LdylqStJjdW/
	 cAUpShmbjOqpsQcF+wRx+uQXMAcoCCyEETmavFexfzF0kAVe4TYy1wKq1eiqlYCxiU
	 4Zv/ysm4P5qmvzEyfVknUASnGsLYnHxFX2A/Og6Dz7cR/1wpH0NSt2ucMStGZZir0f
	 8m/zox0p+s/xA==
From: Lee Jones <lee@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org, 
 alsa-devel@alsa-project.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
References: <20240606142457.130553-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] mfd: arizona: Simplify with
 spi_get_device_match_data()
Message-Id: <171829865427.2725542.2835088856988490637.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 18:10:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 06 Jun 2024 16:24:56 +0200, Krzysztof Kozlowski wrote:
> Use spi_get_device_match_data() helper to simplify a bit the driver.
> 
> 

Applied, thanks!

[1/2] mfd: arizona: Simplify with spi_get_device_match_data()
      commit: 6cc27f7d3e26c6e661385c3cdbc554a8fefbdce5
[2/2] mfd: madera: Simplify with spi_get_device_match_data()
      commit: 8385f6c81bb6042273a6b6cf793424b309ec8f2b

--
Lee Jones [李琼斯]


