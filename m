Return-Path: <linux-kernel+bounces-196809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B2D8D6203
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493941F27A86
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79490158848;
	Fri, 31 May 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SobEOHTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340F155A32
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717159222; cv=none; b=XSgM5J5f7C2DdqVysuMRZlkGAtCVXHfgBpnZ+pOwmqUHHKlW5Mz3qG6WxHklS77b9TatQ0MB/QJ4d5pdX/K0Th1FOCMWkuTDBXoDLAdY5dZEPABurqBiQn/YzbkJY3Y8JMzD8tBNIX3WoAMXxnTVdV41SCajWzP070a+bp/Zbno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717159222; c=relaxed/simple;
	bh=MsC1KrxvRHyGoEgoRZpA5nJme8Xo2JROcu4amc8FmBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lu4LCqRZzfyKZa3GGxXx8hgPwLzDvBP+YPNIO0s0s/SS6PHka55Bs2RXCtJomR9nf0L4sd7AFcIt7BW+F0VdhufOXu/H1tQLvtfBc0EW24vt3Mbx6QQ1vmrn98rsdYAu1FVsp3/fEoBIzbvi47nEgfNYhD1/jOBFByBqO39MuG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SobEOHTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F033C116B1;
	Fri, 31 May 2024 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717159222;
	bh=MsC1KrxvRHyGoEgoRZpA5nJme8Xo2JROcu4amc8FmBU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SobEOHTDWlEJSR5pwg1LtauZKSlDZLjrB3ZTF1OtqimcfeGsU2LD43PEO+gHGTb8l
	 NyxXCSkr2qkjRYCxCDuuxMaXvHx0yxStZYssmR0+Uq66x9xmigyPeEUA+wXMzLjZ5r
	 3vK2EMJFBDTxMKyulCfwbpxnLdW/UtdFuQ3qFsLRJEg3Vh66h7zpwyIy1qLAtxhh7u
	 xhdnj4qNpuQrionG9D7H0d0B2R04YWhVsJpPdu0V3qvBRtjl+H8pfpTrM6G9uSjenI
	 JetAw2PPFf60ndn3vx/cZvrtCzwUTpCauNGJrcA5HcarbLlOnEtRvRzVjvdZMCgfx2
	 G8uwwL3ElBOmQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de
In-Reply-To: <20240510211011.2273978-2-u.kleine-koenig@pengutronix.de>
References: <20240510211011.2273978-2-u.kleine-koenig@pengutronix.de>
Subject: Re: (subset) [PATCH] mfd: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
Message-Id: <171715922112.1068824.2575456159464930318.b4-ty@kernel.org>
Date: Fri, 31 May 2024 13:40:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Fri, 10 May 2024 23:10:11 +0200, Uwe Kleine-König wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
> 
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
> 
> [...]

Applied, thanks!

[1/1] mfd: Drop explicit initialization of struct i2c_device_id::driver_data to 0
      commit: e0dce41bc37ac8222f08e86c2059ab1ff3778f93

--
Lee Jones [李琼斯]


