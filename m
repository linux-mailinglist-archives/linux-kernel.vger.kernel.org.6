Return-Path: <linux-kernel+bounces-358065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B17699979D7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72768285228
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C391DFD1;
	Thu, 10 Oct 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOgnFu/s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340A04F881;
	Thu, 10 Oct 2024 00:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521483; cv=none; b=d79aL+AEnsz6KhKs5jKbCw9N17lZ58CjkuurKEith9TjEzfb+SOm42S/10xvlg8oiE/P3rjFhyhDlXCVKZ1RNW7xhjuPHrKJ6769xQITOJfpCbfCbsgtTk/MA1li60An8+lcfB6nZRnAkzEaidqxTkuN/OlESdY85R3Fz7Hn0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521483; c=relaxed/simple;
	bh=Un1b56CDRNEdvJurfc/tp3SXkUEvV4iCLdPGd9Kojc0=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iGuVVvIZrLogPlhtbDdUKdwBGvSgzCpoGjTwfwDVTIIpGAF8Ul4UJ6OlmOMStYGvJ4PuzMh05jrefxIbVxt8VKYgS8Pbr9AT0yAaTn1slCA7Z/DXuPOtkOhFTR1ifYr+DL4Ld3qs4BL+8gtyZ7Qz2MnPCS5QmN+OGzqdT0BtzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOgnFu/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB345C4CEC3;
	Thu, 10 Oct 2024 00:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728521483;
	bh=Un1b56CDRNEdvJurfc/tp3SXkUEvV4iCLdPGd9Kojc0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=uOgnFu/sUEDkJjKI9T39ewXCPggwLpBOmvSa1ubugkRwCz1v93OiFvwL1fXJcHgSG
	 eGD6MGUKPIq3VMmNaLW/hBBOeCS+Mpp4VO8edrJAUUauG0P8diypAa4hVXAeTVweIM
	 ZZg4eHtnpOIS1uFdBLkOHmqIBBOhU28DgHTMOKHWz80z2UOpmH1CR5xn0xYFBzYnqf
	 HBPWMuHqaOm8XI4utm4cG6wZclSdzqIjl9ukU7fa/tEYzdRjaf1Ol9wiTMsjEGlo5H
	 aRQTWkwjSKpeGQDSRoSsGoG9Np77ypCaIpeY2DdSciLAf3HRucD6kCYLJmzKb6Kn3K
	 EB5W0QYg9DM5A==
Message-ID: <3531b072eeaa815c23adf630eaf7822c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240913191037.2690-4-hpausten@protonmail.com>
References: <20240913191037.2690-1-hpausten@protonmail.com> <20240913191037.2690-4-hpausten@protonmail.com>
Subject: Re: [PATCH v2 3/6] clk: clocking-wizard: use devres versions of clk_hw API
From: Stephen Boyd <sboyd@kernel.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Harry Austen <hpausten@protonmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Harry Austen <hpausten@protonmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Date: Wed, 09 Oct 2024 17:51:21 -0700
User-Agent: alot/0.10

Quoting Harry Austen (2024-09-13 12:11:26)
> Use device managed versions of the clk_hw API, entirely removing the
> need for the driver's remove() callback and greatly simplifying the
> probe() function's error paths.
>=20
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---

Applied to clk-next

