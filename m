Return-Path: <linux-kernel+bounces-410061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF639C9605
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83796280FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0961B2196;
	Thu, 14 Nov 2024 23:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERrQyPQ/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37B618BC1D;
	Thu, 14 Nov 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731626242; cv=none; b=iatFBLp2WhfdNVcqw+oqcKu9tNpwqQnbn1ZhBxgmAanF2vnvKvzvDVU0A6zBlGYlJ7HI/RRAXVO3HvJnz0elD+JonFg+9ETJksm/d6JSjbNjyLFLHjyqevDT6gOvoRO2298GXvfuaxOe3GJvg1XColhiFWd0yJOpJx+73HXacGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731626242; c=relaxed/simple;
	bh=4+8a7cmDyZXmllSyoE0Q6DeOS813QuLGqC6l3uuoyrk=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=QLWDQ2rOfKZ/w73mlWKSiYlBRS1ic55+tmVX9AxcmhWX8eV7vZWkfhi915SlAc1opdXSpVT3JV6bWuFQxNiqvlspHiD1xYJAN/I/gh7I4nJelhKAjUpucJkESC46bL5MX4B6jQwQSEqZ3WZD4vXCzhSQj6RvF9JrXiilAoaONwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERrQyPQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C949C4CECD;
	Thu, 14 Nov 2024 23:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731626242;
	bh=4+8a7cmDyZXmllSyoE0Q6DeOS813QuLGqC6l3uuoyrk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ERrQyPQ/Yz89FiHeIMiLKVQrWz2V7CmTi3DVk90pz2+fyrrf3VKT1zL7sY3tRO/JB
	 mIC2HMWqrqlkCIKD0CR9m2xO+PcYjgFy4HYu8k171+8nklyFEsnJqwXr6fdpZXgIYS
	 rqlcKu7+5PPEzxqNhbznqSNgwAEyGnZIlIfazW5HnfgFnp/VtV2XRQ8LaEny63X4o2
	 lAG15aT6qXLMNKGyIvQqdF3QP0fZb5qFEDh0zze0FmFtAw3R8zA/wTYpZ6IYuPzqef
	 tQSQNo0uZU2AxmqUdtFiWFIY2m+yRGNjZcySjOsDNl0drYv+QFv1q1F1bRDF5ehc0c
	 PDBbp7kJC1Djg==
Message-ID: <0ea59af3c891859681cac378eaface75.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240910-fix_clk-v1-1-111443baaeaa@amlogic.com>
References: <20240910-fix_clk-v1-1-111443baaeaa@amlogic.com>
Subject: Re: [PATCH] clk: Fix invalid execution of clk_set_rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Chuan Liu <chuan.liu@amlogic.com>
To: Chuan Liu via B4 Relay <devnull+chuan.liu.amlogic.com@kernel.org>, Michael Turquette <mturquette@baylibre.com>, chuan.liu@amlogic.com
Date: Thu, 14 Nov 2024 15:17:19 -0800
User-Agent: alot/0.12.dev1+gaa8c22fdeedb

Quoting Chuan Liu via B4 Relay (2024-09-09 22:53:44)
> From: Chuan Liu <chuan.liu@amlogic.com>
>=20
> Some clocks have rates that can be changed elsewhere, so add a flag
> CLK_GET_RATE_NOCACHE(such as scmi_clk) to these clocks to ensure that
> the real-time rate is obtained.
>=20
> When clk_set_rate is called, it is returned if the request to set rate
> is consistent with the current rate. Getting the current rate in
> clk_set_rate returns the rate stored in clk_core. CLK_GET_RATE_NOCACHE
> does not take effect here.
>=20
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>

This looks obviously correct but I'm worried that it will cause some
problem somewhere. It would be nice if there were some kunit tests
associated with this. The worst case situation is that we recalc rates
if the CLK_GET_RATE_NOCACHE flag is set, right? I guess I'll just apply
this as a cleanup for the next merge window and see if it causes
problems for anyone.

