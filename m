Return-Path: <linux-kernel+bounces-357990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C05A9978D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83900B21DEA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53E1E282B;
	Wed,  9 Oct 2024 23:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnkJyJNn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1318F2FC;
	Wed,  9 Oct 2024 23:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515233; cv=none; b=pOZtDWrSWeQWmSZEC5sxLD7Nlp0qnaTsLujaCo2fkywO01CbGikTfGOfWm9K/C03kRXhjGWlhmNvgz2jOYAMY9RD64XBNmtP1tUOp7Reu1GKxZx2mqSqlWu+Z4RD1+NCgAeoSm4g1og935Q3rSnoS3MSARrlh2BITjncUZBfqDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515233; c=relaxed/simple;
	bh=TVqBbA4LJPgAz/Pby5EMBMLAeg4R/vxfOcMu54Ul3Jw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=B+Bf6J69Ny21R2qm7AGc1FOvqGo3BR7BepP7nFjz0eBU22XaXdM9ntjyYG/6ryfh/IKifLJsr0d+V+mnl77clhc+t75BmEg3fIZMu27isM1eyZt98B9ZUnitulPsxRbjvZgZ2uw12p8gq3sHkpUvuOJCZqddx2ga4QEEuJ0ukAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnkJyJNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECBC4CED7;
	Wed,  9 Oct 2024 23:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728515232;
	bh=TVqBbA4LJPgAz/Pby5EMBMLAeg4R/vxfOcMu54Ul3Jw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=JnkJyJNnPY+0ghfQZ4QJ9EvBtSftcoN4JE/D32wIgEh4d4rCtfVTwsEFav18Grcgd
	 NcXQa0hSdOr2Qp8de9LL869NFm5qG3ta4pYQi+xtziEDirhSpkRiM6IANfKEHegLGp
	 0FZwBDap9uYdVbI4B8mqO6UQ4L0UwwWyoe0tQKnzHsCddFZC710f9jViOTaa5ND68r
	 9omC7QT5//79bpGqdcVsx4AYCYrTQOs/2m7Elpirpgi+xhs/1WWUjeyXJzOlDTpb8B
	 rrDWE8e9Bv6VMDEczGWfeQQe7Q59sAMFSr62t/mHtxlexUA1uu4DaegcIVGdfJdOXn
	 p3Srfap5Cg+fA==
Message-ID: <8e205197e157cd8ca77b7315887e2932.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240912133204.29089-2-ziyao@disroot.org>
References: <20240912133204.29089-2-ziyao@disroot.org>
Subject: Re: [PATCH] clk: rockchip: fix finding of maximum clock ID
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Yao Zi <ziyao@disroot.org>
To: Heiko Stuebner <heiko@sntech.de>, Michael Turquette <mturquette@baylibre.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Yao Zi <ziyao@disroot.org>
Date: Wed, 09 Oct 2024 16:07:10 -0700
User-Agent: alot/0.10

Quoting Yao Zi (2024-09-12 06:32:05)
> If an ID of a branch's child is greater than current maximum, we should
> set new maximum to the child's ID, instead of its parent's.
>=20
> Fixes: 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---

Applied to clk-fixes

