Return-Path: <linux-kernel+bounces-409915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB189C9345
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CCE1F22DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021081A76CE;
	Thu, 14 Nov 2024 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQQz/1pr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9EABE4E;
	Thu, 14 Nov 2024 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616342; cv=none; b=AJd172RyD+yjzsMstRZgkF3r31lXNsB1Ne11we0KsdHCr6fMwSAdV4S6RhAI/OZ1EYmDJe+q3xZkis24tmsPODF6WUxkZ0p2dYxY2d3S0ysOIrF6NuVXSb0Jzg/GiobalBg++DU5JS1+U1D0f8ugc5f3CftT9ADWeNmVcouWqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616342; c=relaxed/simple;
	bh=l0rtORJJ9abL/ePiJ7sVqGnSvdaSIacBHfsCGwvk2sk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=YcSVmOTQb0yeh8LT0PVZAmEGCuQ1pvOJNo8rkwAb9FrDBjmSqoK8qhHTkFRoUzVGCX0Sn4YRS1J2lL3Qi088MgO6PjdL0PTzUzJP48PkZwgzjRX34GwwVpnX3aJU4deAfuOv//MRn2TgpVzNN0g/BDokEeFP8kT8diMyfoA4GWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQQz/1pr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D09E4C4CED9;
	Thu, 14 Nov 2024 20:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731616340;
	bh=l0rtORJJ9abL/ePiJ7sVqGnSvdaSIacBHfsCGwvk2sk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jQQz/1prrlHzrNFH55gT+ZTWhO3fuynNtInRbDSb6D+n6uKwL5sCmPdYlh07UuJMt
	 PqyI7cjm7HxbOI9JVwTtJIqljdxdp/zmOuANnkmve4I3UidR83xeGYL6HSmwlcz8Qi
	 xnyREcnLYBP3Trc/15geWBhiLbo/SNr4s2AjekxJREtl3V/Pk4Aio0r/+tG+qTMMdW
	 FNUG4iFxd44VLz+e6r+nQdBXIQ0AJX9uErPIt6sHpX+xQtp2ChlRPuWjLkFJEMd/gd
	 /5ngM5IOkI6pSm9h23iPRUlbFgt1DnFqWWOEkUfLzHFxklwull+MlyS/DaIcpxcWUx
	 8udeqnhuk5oOw==
Message-ID: <d7cd72829cfd4ee9bd880d6d32e4dbc1.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241114091422.75412-1-hanchunchao@inspur.com>
References: <20241114091422.75412-1-hanchunchao@inspur.com>
Subject: Re: [PATCH] clk: davinci:  Add NULL check in davinci_lpsc_clk_register
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Charles Han <hanchunchao@inspur.com>
To: Charles Han <hanchunchao@inspur.com>, david@lechnology.com, mturquette@baylibre.com, sboyd@kernel.orgv
Date: Thu, 14 Nov 2024 12:32:18 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Charles Han (2024-11-14 01:14:22)
> devm_kasprintf() can return a NULL pointer on failure,but this
> returned value in davinci_lpsc_clk_register() is not checked.
> Add NULL check in davinci_lpsc_clk_register(), to handle kernel NULL
> pointer dereference error.
>=20
> Fixes: c6ed4d734bc7 ("clk: davinci: New driver for davinci PSC clocks")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---

Applied to clk-next

