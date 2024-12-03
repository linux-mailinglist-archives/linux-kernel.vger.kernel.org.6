Return-Path: <linux-kernel+bounces-430334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1B9E2F4F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FBF282164
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DA320A5EA;
	Tue,  3 Dec 2024 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPVurdUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B020A5C8;
	Tue,  3 Dec 2024 22:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733266427; cv=none; b=O5+n+7ev2tmJwYsHtmBm8ISOrdopwwcEXFhdZMDKTi7zVupybCUfLibijHJa5iu+uNSWLwDPH+ijUOXkwwtwDjYba4IfW1st7PaTWN4Rw/mrv8d4GyPOdGwrp5/N+xzepowCVTP4mspPcZRl9kTYrOeJuypfzJsD5V4UwYC/66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733266427; c=relaxed/simple;
	bh=hxJM0uX66rDrdmeB4lH8XrQkCJxJlOGvl0CFbwZ7dXI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Y+YCYVr1lb/HiMDU1DDOzDZYqFFlQrrB1f0ASRkTa+lRhWtpXMjJhaFJlUC2aCs0VXhX5SPbZD8goAt3WEnBeHoLcHdnu5dTsymFJKR1FqdogL8Fp8hGZVFdWDhCPAsLqIDDmLDNVc7V+6R030TeWYUbmrKm6lXhg2Seu5rETGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPVurdUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380FEC4CEDC;
	Tue,  3 Dec 2024 22:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733266426;
	bh=hxJM0uX66rDrdmeB4lH8XrQkCJxJlOGvl0CFbwZ7dXI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KPVurdUY+AxlcDq/kWJ170VjyO9jjmU7KlqD7y5yWINwP1V2gpmvcznd2WWVeE0j7
	 SQObpKE/PNyRRq+fbY3oJl1mcOPiH8kS0vNDCrTbSrsqXRD1UQ/vVTvozKEk+5iGfv
	 pSeuwqn7L6BNF3x36181A1b+BS8UlEQCPjIFFEoJccqhBzk9zVF1BbJEv7MXe8Gr3U
	 oBL+f+eJN0+KiOVo2a4lQhjhHfV/HKGY2mfdKjTUK8VFXzX2gPtNNmeucE1W2BT1nD
	 0uv0EXdLKkaG4yVU09PWJhJmjtZeIR62mZcnW8T601V0vXaJB+5c0VWROkIEpbtXI5
	 PXNx/UidhA+ZQ==
Message-ID: <a83b9497295bd8efd6260dadf37c5a77.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241203142915.345523-1-lihaoyu499@gmail.com>
References: <20241203142915.345523-1-lihaoyu499@gmail.com>
Subject: Re: [PATCH] drivers: clk: clk-en7523.c: Initialize num before accessing hws in en7523_register_clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: stable@vger.kernel.org, Haoyu Li <lihaoyu499@gmail.com>
To: Gustavo A . R . Silva <gustavoars@kernel.org>, Haoyu Li <lihaoyu499@gmail.com>, Kees Cook <kees@kernel.org>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 03 Dec 2024 14:53:44 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Haoyu Li (2024-12-03 06:29:15)
> With the new __counted_by annocation in clk_hw_onecell_data, the "num"
> struct member must be set before accessing the "hws" array. Failing to
> do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
> and CONFIG_FORTIFY_SOURCE.
>=20
> Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __cou=
nted_by")
>=20
> Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
> ---

Applied to clk-fixes

