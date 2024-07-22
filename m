Return-Path: <linux-kernel+bounces-259409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B991393957B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 23:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656861F223AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E993C482;
	Mon, 22 Jul 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSQAGpmP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1ED1E891;
	Mon, 22 Jul 2024 21:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683769; cv=none; b=IOkoNczs5y1/VsR+1kuHAbruhNDAbft1U0YRjvf/U8tXTLuNVXujT95T0Nh+NHunFbrqabrTNx/MK7Ucs+nXqVTjr5596wqPUNB6/8Hb2RhIJWT9xxIOES3zb7S47U3H9OuA+f8nyto979wuI10pWt1wCRLRfdS5dAxbCZcq8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683769; c=relaxed/simple;
	bh=mFsP2LOfOyZ2jsPSJiZwcTQlSlLZNFN9s88E83z1WXk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=GlbGCqNUT6ofp89Dj/CcJWKbyODzGTr/cWDI57Y+cVq2Iqhg/9xDyc1sP0WVJx5AqnECZnWRhKKVpP5jNb8zd/u2j0Ock4keKemnGKK61gACbLlOdYxtGHbGKYL6Gt3iNrUoUJ9PloniejKxiZADciX40H7RW/Vir+gojX0YeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSQAGpmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD46C116B1;
	Mon, 22 Jul 2024 21:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721683768;
	bh=mFsP2LOfOyZ2jsPSJiZwcTQlSlLZNFN9s88E83z1WXk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KSQAGpmPTiOgCqxkDiXIvL/FidGAvHrw2b+5pGiEnh6qgmVe+4KunryRr2PSjKCFE
	 lmUwixp1nKlCLFaPKn8CD+fi0FWin9YjSyPDQuvedrKztcixLcDqw5znCtZk47bTKz
	 7bAGPxjdq+dlQ4Z1iDOee1hcWKTv3q0szIEBfV5jbqNQ8mhs3F116PbXRvkjwZwohu
	 iXBXKFQCjvRHmuQfWnJoKB70ccN3tMfBE0dRDPaPKWMwXBkPJevfJyU0HgcxJ/hQtF
	 N6BCvCqwY3yY8KZ0pp5dfltk8s26V0AsNAR2Yp5dn0LALNk7j9k46stmSh3OQ/UUHr
	 0ZNc1xcAKyWXA==
Message-ID: <63662f96327389ef08dfdecf723de19f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240719151027.16152-1-palmer@rivosinc.com>
References: <20240719151027.16152-1-palmer@rivosinc.com>
Subject: Re: [PATCH] clk: T-Head: Disable on 32-bit Targets
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, jszhang@kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, dfustini@tenstorrent.com, frank.li@vivo.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Palmer Dabbelt <palmer@rivosinc.com>
Date: Mon, 22 Jul 2024 14:29:26 -0700
User-Agent: alot/0.10

Quoting Palmer Dabbelt (2024-07-19 08:10:27)
> From: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> This fails to build on 32-bit targets because of a missing __udivdi3.
> IIRC the right way to fix that is to avoid the division, but I just want
> a tree that builds and the only real T-Head platforms are 64-bit right
> now.
>=20
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---

Applied to clk-next

