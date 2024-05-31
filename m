Return-Path: <linux-kernel+bounces-197216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B75338D67A2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65641C24F62
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB865172BA2;
	Fri, 31 May 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFVVihMN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC96770F3
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 17:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175172; cv=none; b=PRNmtljB+qis0BOcVzuvWJ8pW4RX+YqYRtdMD1s0GxSWbePd0O38tIavpABKxFfJkAVX6UqMUGVweq4gym4R+cHk4aGr29BMAmx2Ouh94v2eql72oCkfq8IzHLFFjOmc/mTNRvDQq7IdJY0DNPFYxjSpeUcyml+HdEi2HVqwoGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175172; c=relaxed/simple;
	bh=Z3k11c3xQu0MbNj0Q3e6MPZs5A+U6PeuckDgI4z7mvM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L+OUz32tOKTUwYejVlScMy4QtKKdpk4HSUnX1XQclNKpC15iTpOtNmbPWbKjGUejuOiN2t28GXAR2zZuulsJxSqUE+83xTRQ7xWCIduIikwpZIWqPc7SyGAbLjmvT/Apuoa36/8nOqiqU5ddDNAx3+/pXrCKHboL2nxGEfI6NLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFVVihMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3403CC116B1;
	Fri, 31 May 2024 17:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175172;
	bh=Z3k11c3xQu0MbNj0Q3e6MPZs5A+U6PeuckDgI4z7mvM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=EFVVihMNyORTarDnwaXubMHVjyVgSjcnMEmNNc7hUfIdFeCbAhXXLV9cz7SUQ+1IJ
	 3PlrMUbcG3FvbsUGdinHO2prQXx00+vDC5JT+9E3S4glpwoGgkZzXo3luhnX6kvEuv
	 3wmRCMJ/rf7uyd4OLDSl7x2ug2LDVdciJHG/Uf58+ikA6L/5yFTweMhrKwqT/o2pn0
	 KsAr06lCzvvQuFIFhKrdR4iV25kMI5W4jeSuCHw9eSdp8A50dxB4Iy+1pNdao/SDz3
	 71gomB43Swe5eYYbDLflZqLQvfVmhtAz+V+1IV23zuhCcpUW6scU/T4tUGggSyyRMP
	 j2NuoRw/PrKnQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240530115147.1112498-1-andriy.shevchenko@linux.intel.com>
References: <20240530115147.1112498-1-andriy.shevchenko@linux.intel.com>
Subject: Re: (subset) [PATCH v1 1/1] mfd: core: Make use of
 device_set_node()
Message-Id: <171717517094.1211325.2490410984440943787.b4-ty@kernel.org>
Date: Fri, 31 May 2024 18:06:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Thu, 30 May 2024 14:51:47 +0300, Andy Shevchenko wrote:
> Use device_set_node() instead of assigning pdev->dev.of_node
> directly because it also sets the firmware node.
> 
> 

Applied, thanks!

[1/1] mfd: core: Make use of device_set_node()
      commit: 03ab12796acff74d1c0e8278569499f989134377

--
Lee Jones [李琼斯]


