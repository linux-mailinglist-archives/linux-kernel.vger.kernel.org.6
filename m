Return-Path: <linux-kernel+bounces-344480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B022F98AA36
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E239E1C20383
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BDF194083;
	Mon, 30 Sep 2024 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnmgzZbU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AA9189BAC;
	Mon, 30 Sep 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727714788; cv=none; b=A0QbgKy1Agj4FM1g9C6rgPbSjL7tSKivr8MlmmIvyF/i2xWY2KyQFYUm3e827t50RS71s61jtzyUaPl+UQo/qXVJ7WwcMOqhuu6dO8uSunFxK4iUF5up5rZwdUkOfZsSXIPL+jsipi9eiOCStXZDJi9DE4Ws2BNhZlc4vJb88vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727714788; c=relaxed/simple;
	bh=FDaM7NdLIq1t8IGD761/2fBvYY7KPbsk8Rk/C4KHhcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9F36UC+YJ4xB2OiItpm1qSXhkyhE/xItVrRoX5SQeAt4tZmrYjBWrDJDdtM3W1xfFBFHcn1DpmEsf0qjOw625b96xDYf/PKADAfybnZPAAJYO50XJGQMGIrJf5P6D+Q3hSF2V4QvtFtRKZ8ptnNsVIZVUrNSKZfKETf9eLiONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnmgzZbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76418C4CEC7;
	Mon, 30 Sep 2024 16:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727714788;
	bh=FDaM7NdLIq1t8IGD761/2fBvYY7KPbsk8Rk/C4KHhcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AnmgzZbU2fLjvfFsfvLgi8wMD9vo0z1Ii8YSfmMlYYDmeOJDZu7yKoPbsOY6MF1AS
	 lp6wwWF8lPIbrfdJ97l3H3EmJh24W5EzI4R85H7ac5YPGFUx6Ddn1JXgIQV089OO2I
	 1PR3pH4zHEK4Y/d9b6cavDiBlc8fYXOsmn/CuXJfdw2eneUejaQNcOIs+/GFvo8vfp
	 Isl1rkU7h4y7P7/0zQCxOcRwb3mtkrPQ7j7kkMJDr6I2sYitZVg1PxyapyFBtBHbdK
	 3B0ytt1QToUUXxsafYWM+4lIgznnE0nBfDcex/mKyXEnJJLRpTG87FeUATqzfQVGhf
	 Oi8oL+N0H9vjg==
Date: Mon, 30 Sep 2024 17:46:24 +0100
From: Simon Horman <horms@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac4: Add ip payload error
 statistics
Message-ID: <20240930164624.GH1310185@kernel.org>
References: <20240930110205.44278-1-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930110205.44278-1-minda.chen@starfivetech.com>

On Mon, Sep 30, 2024 at 07:02:05PM +0800, Minda Chen wrote:
> Add dwmac4 ip payload error statistics, and rename discripter bit macro
> because latest version descriptor IPCE bit claims ip checksum error or
> l4 segment length error.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>

Reviewed-by: Simon Horman <horms@kernel.org>


