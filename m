Return-Path: <linux-kernel+bounces-425827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825659DEB74
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47021282230
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91DB155CA5;
	Fri, 29 Nov 2024 17:07:25 +0000 (UTC)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2562C18C;
	Fri, 29 Nov 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900045; cv=none; b=gi6Z8GJx7yE56xvpUg4v3MhXrhx924khCoo5CCn6p4uarNlGQl9FMn+aJM3cLO1J/S13ONII/YWn3LtAoN+zyvGgb4ifS76ZZ7TNvQ/6LgHhqD5fPUMFy79ypk4vA61CJyXGYKSVUtX1XrVFOkZ39hDP1SgaexuGA67bj00tEJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900045; c=relaxed/simple;
	bh=NOE2eDrnm/P6MIh27gYZlbptNqTwu9iKUqkjPMlM6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMOMV/o/KcywPhtJOx1LNwY/Q3XJMIU93mDxCBPsgNy59ShxWqEJI+/OU5QOh/5Dlb901L06areqKj93Rwcb7Y3SLp8h6CUA+L9rxR9pBX0I55egiaaJ+kBB3srFGftt6jwfwyVLq+blWMhPF/4F3L+QhfAfubxqq0xpGH6eHWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 300DA82170;
	Fri, 29 Nov 2024 18:07:20 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH next] clk: mmp: pxa1908-apbc: Fix NULL vs IS_ERR() check in probe
Date: Fri, 29 Nov 2024 18:05:37 +0100
Message-ID: <2352491.ElGaqSPkdT@radijator>
In-Reply-To: <d7078eb7-a7d6-4753-b453-8fce15245c34@stanley.mountain>
References: <d7078eb7-a7d6-4753-b453-8fce15245c34@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday 20 November 2024 18:18:38 Central European Standard Time Dan=20
Carpenter wrote:
> The devm_kzalloc() function returns NULL on error, not error pointers.
> Fix the check.
>=20
> Fixes: 51ce55919273 ("clk: mmp: Add Marvell PXA1908 APBC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Acked-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Regards,
=2D-=20
Duje




