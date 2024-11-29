Return-Path: <linux-kernel+bounces-425831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FFC9DEB81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D27E7B222DA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86E019CC02;
	Fri, 29 Nov 2024 17:12:02 +0000 (UTC)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25A21474A7;
	Fri, 29 Nov 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732900322; cv=none; b=V3/+PulsUiPq23pH2euOxnYVBkV05bdywnjmMUDB4YZYEhZbNOLVCGpjuDh6naUCSW/3IGK3LTwNUN3NG7SopTGwVNnB9mto1ROq0O5DAgcK/AZeapuYvv/foNXthYHY+oFQLJlCloaiDh+NIt3jKB9n+aMitYZi5C74rVn4dVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732900322; c=relaxed/simple;
	bh=KGeMQGiTPCgEMm9g59gyJzcFXolJGUf0NVmUDKeuuqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYMJGCmEwTc104pkxPgwGUYhwP4LZSGB2WKqt/ZYL/dkLteeJlg1fcfCQkZcHcEL2abTwfyQwOVNO0ddi6oOyeiaLVZvEAOoHibpqCxpZPCaEHUKnX/CTbXGe9vm3UoseT/04SsvzXYvnkl5BadEkLO4mRfc6REsBPAWnzP+J+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 263A88347B;
	Fri, 29 Nov 2024 18:05:59 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject:
 Re: [PATCH next] clk: mmp: pxa1908-mpmu: Fix a NULL vs IS_ERR() check in
 probe()
Date: Fri, 29 Nov 2024 18:05:01 +0100
Message-ID: <12564811.O9o76ZdvQC@radijator>
In-Reply-To: <5b3b963d-ecae-4819-be47-d82e8a58e64b@stanley.mountain>
References: <5b3b963d-ecae-4819-be47-d82e8a58e64b@stanley.mountain>
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

On Wednesday 20 November 2024 18:18:50 Central European Standard Time Dan=20
Carpenter wrote:
> The devm_kzalloc() function returns NULL on error, not error pointers.
> Update the check to match.
>=20
> Fixes: ebac87cdd230 ("clk: mmp: Add Marvell PXA1908 MPMU driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

Acked-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Regards,
=2D-=20
Duje




