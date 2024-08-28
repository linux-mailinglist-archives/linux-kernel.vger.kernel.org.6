Return-Path: <linux-kernel+bounces-305642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B89631A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303161F23381
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB2C1AC442;
	Wed, 28 Aug 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATUlLtmc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B82717C223;
	Wed, 28 Aug 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876366; cv=none; b=Zf+hJjECkTUkjirVGQEzl3vp+fCXbyGwrVnhzKC3agizUWtZGOYFXwgZNor4ntN9t15hJ8S036tMjKNp9rfvYnvgW2gVVCBzMbeRZZ//WVDU8UE/3Qpu6xtFKj8FHDE9VB9Y257kdO4TUr2eCJpsP22O9u38JBBWDSRxEGwNYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876366; c=relaxed/simple;
	bh=69Oa7RV1aCusi8DLh4ncaLvDWzm/H61suYgUFM++cU8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IG0IPXkNNbWvBxC3l/dE3FFX+C00zi6ebDcx+BrsVvi8iQYpCOlWpfToY1umdvrOwsoTPZfmHUk7dV2ARg6ynUGjLfrfpdozVmAatoUHSDsk5T/IQP4MuC1p8mRaqcA2/8gpWR/1IMCnqf5KlcJqTVZGkJGhRnd5ITX9ceWmlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATUlLtmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0A9C4CEC0;
	Wed, 28 Aug 2024 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724876366;
	bh=69Oa7RV1aCusi8DLh4ncaLvDWzm/H61suYgUFM++cU8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ATUlLtmcS4xqiFqWoCrTV5+uc5vX/idiy6O6MRa7ZeDIb4NlQXkRgHZfG56YLexPf
	 zw5Wxp4GBy/+IqotsyLRNi8j1iUQXOfTMa5tnGvz74MkZa/wgmKxWMwn6UdhzRlPmU
	 twvGJ71tal+wbIo/GsVYABARL7A2ent5NwpDyuVLxylZL349jO3wCWZD8A8aGcvR+r
	 CvTQf2cNDCHGU61IcvsBW4EuBrXzCbnOwf9wlMQWwkgoQgO1rjaMIEp2Y2R7nOTDW5
	 AItwEKMpTbIV8ytM38Mvn0SzZm9fVhLvATkPfuwkn0X5YZ23vp+neIHfX0yQhWs1d0
	 dqRvjUkonwmTw==
Message-ID: <ba3077ef4b155649812fd8be75f131e7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240826080430.179788-2-xingyu.wu@starfivetech.com>
References: <20240826080430.179788-1-xingyu.wu@starfivetech.com> <20240826080430.179788-2-xingyu.wu@starfivetech.com>
Subject: Re: [PATCH v7 1/2] clk: starfive: jh7110-sys: Add notifier for PLL0 clock
From: Stephen Boyd <sboyd@kernel.org>
Cc: Hal Feng <hal.feng@starfivetech.com>, Xingyu Wu <xingyu.wu@starfivetech.com>, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To: Conor Dooley <conor@kernel.org>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Michael Turquette <mturquette@baylibre.com>, Xingyu Wu <xingyu.wu@starfivetech.com>
Date: Wed, 28 Aug 2024 13:19:23 -0700
User-Agent: alot/0.10

Quoting Xingyu Wu (2024-08-26 01:04:29)
> Add notifier function for PLL0 clock. In the function, the cpu_root clock
> should be operated by saving its current parent and setting a new safe
> parent (osc clock) before setting the PLL0 clock rate. After setting PLL0
> rate, it should be switched back to the original parent clock.
>=20
> Fixes: e2c510d6d630 ("riscv: dts: starfive: Add cpu scaling for JH7110 So=
C")
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---

What is the urgency of this patch? I can't tell from the commit text, so
I'm assuming it can bake in clk-next for a few weeks.

