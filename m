Return-Path: <linux-kernel+bounces-353738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016069931F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B1A1C229C7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0511D9678;
	Mon,  7 Oct 2024 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWRuCFBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA91D9340
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316133; cv=none; b=Aa0aGBkRWdAkE+OsNXJalzxaM63HNXumwd4QL0PCKylUsvPD7SgDtNVREGlewDjEBNH/Hd6RP5EYRVkzjm96w5jUO1ZRI7lnUQVJYvRtckeCAswjgNMHtUzd2lRZsxtB0TJOqDBbpFbiFFOhGugFaC6JyCrNL2RnH7xafRJPzR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316133; c=relaxed/simple;
	bh=Gh9ajqPoQnJUuZc9tYe+iYr+Iu41onmPi9i3M1+Dq14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OjV9oIfnm33mzIUDmzRqIe9a7jWfNYLfRW3G0px8evaUp4OlrovZGZHzlozm1Hx66LBvMHE4cw9klhZ3DIcNZ2iNcSUxP3WcAFRG4EIqEy7txy12sP6Bn/4cfRj1g58zXUBmrP7hj9hN+0/J3IIGViIFb6WblIJ697Oty0F1euM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWRuCFBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B153EC4CEC6;
	Mon,  7 Oct 2024 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316132;
	bh=Gh9ajqPoQnJUuZc9tYe+iYr+Iu41onmPi9i3M1+Dq14=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lWRuCFBFXN9I3S+L6FNYC5leJICEIhmOVccppeA4OaRo/cDp1ilMmnYTntzorhEIX
	 NNcY0o2pqpyPOSooPqhsis7a28Yl5pTLChwfRpYy+8IBfcSWRQMeqidP3ecyzf8Fmi
	 Ca69yzkvRzExzM0iPGRoQ9waVpJLbJQPxp8Z4tsUl0Kkkk8Z3alhA4TzHJR5phh83N
	 5in/M1bhDSMhrlwoA0XnyCDOO3+iv6m/gfnbc0FR6R4lju01Js/HM8EYJTtU2CCtSl
	 9KnYq/2TGp6ZLNCexGiXmbpOfwTQtfEy4rnAXSHJqevQhxulj42zSkxl/V8uMAwmnj
	 6NJSJyLGZcXQQ==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Josua Mayer <josua@solid-run.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240704-mvebu-utmi-phy-v1-1-9d3c8eea46e5@solid-run.com>
References: <20240704-mvebu-utmi-phy-v1-1-9d3c8eea46e5@solid-run.com>
Subject: Re: [PATCH] phy: mvebu-cp110-utmi: support swapping d+/d- lanes by
 dts property
Message-Id: <172831613135.134526.5113681936204889250.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:18:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 04 Jul 2024 16:57:43 +0200, Josua Mayer wrote:
> CP11x UTMI PHY supports swapping D+/D- signals via digital control
> register 1.
> 
> Add support for the "swap-dx-lanes" device-tree property, which lists
> the port-ids that should swap D+ and D-.
> The property is evaluated in probe and applied before power-on
> during mvebu_cp110_utmi_port_setup.
> 
> [...]

Applied, thanks!

[1/1] phy: mvebu-cp110-utmi: support swapping d+/d- lanes by dts property
      commit: d6c496f05e98c6d25ac73f23fd0075913620de56

Best regards,
-- 
~Vinod



