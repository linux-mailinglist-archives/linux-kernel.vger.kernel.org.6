Return-Path: <linux-kernel+bounces-334942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0B97DEAC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6AE2815EF
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AE484D02;
	Sat, 21 Sep 2024 19:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRq77pPO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA972868D;
	Sat, 21 Sep 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726948453; cv=none; b=d+C56d1AQ/bPGSBDQXpXs+yryjGwPXO0zifa/KM87yae8W/59aurlwsyckhb3LMs37UYzYdBLgUVYEEdVMACWfXcQs2MDPkAlKJ6mh17G4vmBeFYgS8xsW/KIG+dQwP4CM8yLKdTuSC4+LZg85w03LMjmnd8U4wGUG5UAgAPjm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726948453; c=relaxed/simple;
	bh=qbXKiapCk2YXBtlswI/GeCkM3I4qQK1mE6LOkTqbgGc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=A4pJFAfCrzgUHNwP36dPC+d6fMAlRQqg+6I8qky+ZpSQNLYHptEp4+kndyXrXF4qGkmvaRNXSRtvnDvV/iTfVSNDs6Gx8tw2+hagwTX8Lwmxuln8nP9162A6bYJH0lZcOXdpIzXPycw4LtHpS8GY3UDPkR+ZT7kp1+iCJI1BIuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRq77pPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928A2C4CEC2;
	Sat, 21 Sep 2024 19:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726948452;
	bh=qbXKiapCk2YXBtlswI/GeCkM3I4qQK1mE6LOkTqbgGc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=GRq77pPOLe6gr6d9BPlks466UbXW7OYl28xtmU6JuzZkWJ02+5gUCZIZ0mmAR/9KX
	 pmPcJXwAQQvrVnMlw98BsPKhVMxveWNFf8i+YiDrolOikLDgus/Khv6ZIBfFgjYMxw
	 WMxbe9FZAwbE1Gu9N4HD3rlcEgYrpFHlDDALBHG4RaFbtH1EPFvUwndYnEUTBBneJP
	 3v7ADTsOQlc5+qkpy0jXspklwroqKv7xBigNgqcvWCagop4cG2tp4LyCx/UzgwQG4J
	 f3D9i3nzYjmERHNkqiuAoqQKWp4CE1TOkpbQGQMMvxNTEc9l+IY2WSv8YuNFLmEonH
	 MsjIu2bnnRGRQ==
Message-ID: <cae4d71b611c36dab4003fa4ec3bab61.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d9e0ade6-8a7e-4ba4-974f-142ad246ce5d@linaro.org>
References: <67cf80cf-d96d-4249-ac34-6085d4b32948@suswa.mountain> <d9e0ade6-8a7e-4ba4-974f-142ad246ce5d@linaro.org>
Subject: Re: drivers/spmi/spmi-pmic-arb.c:1782 spmi_pmic_arb_register_buses() error: uninitialized symbol 'ret'.
From: Stephen Boyd <sboyd@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
To: Abel Vesa <abel.vesa@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, oe-kbuild@lists.linux.dev
Date: Sat, 21 Sep 2024 12:54:10 -0700
User-Agent: alot/0.10

Quoting Neil Armstrong (2024-09-18 03:34:22)
> On 18/09/2024 12:29, Dan Carpenter wrote:
> > 9799873717398e8 Abel Vesa 2024-05-07  1767    struct device_node *child;
> > 9799873717398e8 Abel Vesa 2024-05-07  1768    int ret;
> > 9799873717398e8 Abel Vesa 2024-05-07  1769
> > 9799873717398e8 Abel Vesa 2024-05-07  1770    /* legacy mode doesn't pr=
ovide child node for the bus */
> > 9799873717398e8 Abel Vesa 2024-05-07  1771    if (of_device_is_compatib=
le(node, "qcom,spmi-pmic-arb"))
> > 9799873717398e8 Abel Vesa 2024-05-07  1772            return spmi_pmic_=
arb_bus_init(pdev, node, pmic_arb);
> > 9799873717398e8 Abel Vesa 2024-05-07  1773
> > 9799873717398e8 Abel Vesa 2024-05-07  1774    for_each_available_child_=
of_node(node, child) {
> > 9799873717398e8 Abel Vesa 2024-05-07  1775            if (of_node_name_=
eq(child, "spmi")) {
> > 9799873717398e8 Abel Vesa 2024-05-07  1776                    ret =3D s=
pmi_pmic_arb_bus_init(pdev, child, pmic_arb);
> > 9799873717398e8 Abel Vesa 2024-05-07  1777                    if (ret)
> > 9799873717398e8 Abel Vesa 2024-05-07  1778                            r=
eturn ret;
> > 9799873717398e8 Abel Vesa 2024-05-07  1779            }
> > 9799873717398e8 Abel Vesa 2024-05-07  1780    }
> > 9799873717398e8 Abel Vesa 2024-05-07  1781
> > 9799873717398e8 Abel Vesa 2024-05-07 @1782    return ret;
> >=20
> > Is it possible to not have an spmi node?
>=20
> It's possible but not allowed per the bindings.
>=20

Seems that we should just return 0 here then and squelch the warning.

