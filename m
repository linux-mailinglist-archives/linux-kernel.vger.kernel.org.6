Return-Path: <linux-kernel+bounces-358062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F13E9979CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB141C223C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7F014293;
	Thu, 10 Oct 2024 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmIg2dw8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAB645;
	Thu, 10 Oct 2024 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521468; cv=none; b=edMj3HNEVCeo4El69uLOofx9ck4guGbhb8XlDfd2X+CsBJA66GQ5xJyPWQwvaG8+2b5wZuocwFhfJQBQHXhNjdlt2LJTJDniZX5oHoGDWRf4lqONPnuphnhqAd7Bf6AAR6W4fc15zSCORAnPj3gJN22u/G+j3dkvkB+D9jGOCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521468; c=relaxed/simple;
	bh=2Z8wLTVOM+7K68JPto5YEPm3viyRLB90jYoAe+grMtY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=idENe9+eoKU3XgRnB+hH3p8lCHuOKuGL8v69FUIY8IEr0RoKU3xZHl5th4oaCMZvPxrU6EidPogju3qrgQs9JuLEFmvLp/Jujj/ivldbeBU8N3Izv26EXltvlJ+PMU7v6zna6u5lM6H3XsGt0tpl3xUMqGDvtrHwo/zvvcGwugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmIg2dw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B4AFC4CEC3;
	Thu, 10 Oct 2024 00:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521467;
	bh=2Z8wLTVOM+7K68JPto5YEPm3viyRLB90jYoAe+grMtY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=cmIg2dw85+sLI2CngcXArl/h/1grueu5e2VEw7w3jyEYJH6mATtGPZwM8PgrET0UQ
	 arF8CrnL/6yqpR/8Z9khEE4HeOO2OK4JWoaP5DTTlAjgtAu41xBlsbRt94udaqqKKT
	 WOeKMT0iaenS89i4a3UklvtuWj7UqPsD+9LhiVz3I6BAEQljvBMV+juikfTaLGjumo
	 MaL0WMlGe/WgCatpOr26qWfYWwNCMxUQ7cBpOCvktuXfhPsCQ1XU7uRTnMBi9igGcv
	 +9y5H2uJp8jdVnrbGw+kMhh8JoTAMrZlAu6tWP/hPT0GObcPqTjQywtaoyfJVMWCj3
	 nvDQ3egeF1Ftw==
Message-ID: <facd2e1b3689ebdcfff7ad70d6a5a24c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913191037.2690-2-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com> <20240913191037.2690-2-hpausten@protonmail.com>
Subject: Re: [PATCH v2 1/6] clk: clocking-wizard: simplify probe/remove with devres helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Wed, 09 Oct 2024 17:51:04 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-09-13 12:11:14)
> Remove need to do various operations in remove callback and error paths
> by utilising device managed versions of clock and notifier APIs.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

