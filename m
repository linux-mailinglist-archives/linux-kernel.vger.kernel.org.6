Return-Path: <linux-kernel+bounces-307387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28823964CD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2F7B21E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61CB1B86E3;
	Thu, 29 Aug 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c058bURC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D741B7902;
	Thu, 29 Aug 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952643; cv=none; b=Nmtqsyw8fIe/l98IiWovSdd+uyISrHdxcLgPBmng6NAJW/5o736+EBfcR/CrxcaSiiQfWulwamgajKAPBPwizu7ry1aOTuQpNmVqG3q3mtHkk1UTxzrRUqMkMXveZz17g5ri7z5IhMkmMfRJKCfzKlZztJDtETplPufxyWZ7b8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952643; c=relaxed/simple;
	bh=KkDLjhRHDEPypbD5pU5fbDPfHN2lQGTV5hmDddEo2iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F8O1BZ9p8UJsfRYPQkc1NAixnVUuiKeF+vfj/HP33UprCkBtqhydHkrLjHQ5/idvCmFJpq1tT7nJjc/QcFeVY/dPzTl1dyYrMzPjn98vwNFrH9Mks1DnZ1Ej505X6AlKYwYnIUQZvVwbo5NLDp7q/3fbRUeV39LiDk4hGccRhYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c058bURC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90F5C4CEC9;
	Thu, 29 Aug 2024 17:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724952642;
	bh=KkDLjhRHDEPypbD5pU5fbDPfHN2lQGTV5hmDddEo2iw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c058bURCbvHdEyKgdr7GjokX2IS1A8gYAP1/xu1ANpSLkomX6Otf+ONWkI8YNUiwO
	 mQnE2uCXaY2Dhu4cW3XGJtYyBjNrd5cKvSwAatPT7U46VyM818yvbDob3AFVg5MKiq
	 Eyi8g85g0PiPFRF4ZWYLdZezMKX9PvCs/DICoj8jBaCSya7KYo3voTcUj4Xl6hx64N
	 Tzq5FuYsTQvvMQkYe4uifuf3Q85RlmU0DJWJX9FZpiyX5/UNVfLigt09EFctlO9/UU
	 3BpwHfT6y0UO0Ij9+thCU3lLXiDItqXiYjuUh0QZ7yQzuBAFxkzzMbVVgKtdi9Hcse
	 LvZ5s++OQ0vFQ==
From: Vinod Koul <vkoul@kernel.org>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Jiang <dave.jiang@intel.com>, 
 Yajun Deng <yajun.deng@linux.dev>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240719102319.546622-1-arnd@kernel.org>
References: <20240719102319.546622-1-arnd@kernel.org>
Subject: Re: [PATCH] dmaengine: avoid non-constant format string
Message-Id: <172495264059.385951.16283879496455820047.b4-ty@kernel.org>
Date: Thu, 29 Aug 2024 23:00:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 19 Jul 2024 12:23:12 +0200, Arnd Bergmann wrote:
> Using an arbitrary string as a printf-style format can be a security
> problem if that string contains % characters, as the optionalal
> -Wformat-security flag points out:
> 
> drivers/dma/dmaengine.c: In function '__dma_async_device_channel_register':
> drivers/dma/dmaengine.c:1073:17: error: format not a string literal and no format arguments [-Werror=format-security]
>  1073 |                 dev_set_name(&chan->dev->device, name);
>       |                 ^~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] dmaengine: avoid non-constant format string
      commit: ae04342b5264fcf90a288a984a69ffb9e93904a7

Best regards,
-- 
~Vinod



