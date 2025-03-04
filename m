Return-Path: <linux-kernel+bounces-545646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3379BA4EF95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A789F7A4E12
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA652780FD;
	Tue,  4 Mar 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="Tkh7mn3A"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4222780E4;
	Tue,  4 Mar 2025 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741125152; cv=none; b=u+FVbccdJvbS1vKp4SVYbu884Ao0HuqRsxfvzgr6j7gtT57G8DRGfHHt4e21uoUU6G97zXQqyjRQ18TJJID/d5JPGgvJqxmiIEcGtwpIfoyLtfwnoPvbZHnRRDURih5Ylir+sdyFumIV5Bs1pVpmKqB6LTPIcwAMKh5Aob0meqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741125152; c=relaxed/simple;
	bh=jbUYXbpvU141BlebTQ7l6pAnXZWMdd92RibBqvtskwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVO8P7SB4FbAWhxduo+tFKkiNgHrYL/8qkv08pmaD//HSQjDrCoZS6d5e+Wsgg6t2isDz/jhfeBhQWtQH3NU51sLKISRfMO3e3K/I/XAvJIgADxy7dsxJ8oCa/o9X+X4hWn/vLT2vpRWKl5ldtbL1NNZgqu5rvR482NnyE+NmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=Tkh7mn3A; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JofA2Qh9JGaxtMid0/5sEvR2yQLob0lQuZxap80vKqw=; b=Tkh7mn3A+PYTIgV27zWhch/208
	ETUALWlqEqZb9jksjEgNDlpzfKLYqN2rarathziQV8Ntjv+PPBBfpKKage0LcF7B5AYw5QcG4mzHk
	Nds+uv8i40buo1duskWACkkerB1c8+77MtGCmUqDCz/AWnTbCcf/VEohCydBFaftKyZDJ4/Buxmfy
	mPtQZSVrBco/oLg3OHlqc4Wn15Q5yI3xcUjWkH5zHT1Lf0r43ib9TeG6ezMFV4R1zoTZ6I17a2l91
	INcWrZvknMxlFFMkx2w45YdSG5m6sc+nEHFuQA6yVC26YXkNz7i4f39l6AJ1KWr3USk5v0Ew3iEAH
	kPVZlMcw==;
Received: from i53875a38.versanet.de ([83.135.90.56] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tpaBb-0006QR-08; Tue, 04 Mar 2025 22:52:23 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, didi.debian@cknow.org, chris@z9.de
Subject:
 Re: [PATCH v2 0/2] Slightly improve hardware description of Pine64 RockPro64
Date: Tue, 04 Mar 2025 22:52:22 +0100
Message-ID: <2630232.Icojqenx9y@diego>
In-Reply-To: <757afa87255212dfa5abf4c0e31deb08@manjaro.org>
References:
 <cover.1740941097.git.dsimic@manjaro.org>
 <174104113599.8946.16805724674396090918.b4-ty@sntech.de>
 <757afa87255212dfa5abf4c0e31deb08@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Dienstag, 4. M=C3=A4rz 2025, 07:44:59 MEZ schrieb Dragan Simic:
> Hello Heiko,
>=20
> On 2025-03-03 23:36, Heiko Stuebner wrote:
> > On Sun, 02 Mar 2025 19:48:02 +0100, Dragan Simic wrote:
> >> This is a small series that introduces small improvements to the way
> >> Pine64 RockPro64 [1] single-board-computer is described in the DT=20
> >> files.
> >> This applies to both production-run revisions of the RockPro64.
> >>=20
> >> The introduced improvements boil down to eliminating some warnings=20
> >> from
> >> the kernel log, by adding a previously undefined regulator and by=20
> >> adding
> >> some previously missing references to the regulators.
> >>=20
> >> [...]
> >=20
> > Applied, thanks!
> >=20
> > [1/2] arm64: dts: rockchip: Add avdd HDMI supplies to RockPro64 board=20
> > dtsi
> >       commit: bd1c959f37f384b477f51572331b0dc828bd009a
> > [2/2] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64=20
> > board dtsi
> >       commit: 64ef4a4320e7aa3f0f267e01f170f52b90bf0b1b
> >=20
> > I've moved the pcie12v supply up one line.
> > While in a mathematical sense it's true 12 > 3.3, we're sorting
> > alphabetical, so it's 1?? < 3?? .
> >=20
> > And yes I sympathize with 3.3 < 12, but also have come to appreciate=20
> > not
> > having overly many special cases :-)
>=20
> Great, thanks! :)
>=20
> I'm fine with the alphabetical ordering, albeit with some caveats
> described below, but the following part of the patch description
> should also be removed, if possible, so the patch description fully
> matches the introduced changes:
>=20
>    Shuffle and reorder the "vpcie*-supply" properties a bit, so they're=20
> sorted
>    alphanumerically, which is a bit more logical and more useful than=20
> having
>    these properties listed in their strict alphabetical order.

I've amended the commit, dropping this block

> I'm hoping you'll agree that specifying alphanumerical ordering
> for the properties in the DTS coding style is the way to go, just
> like it's already specified for the ordering of the nodes.  I'll
> go ahead and submit an appropriate patch for the DT guidelines.

vpcie0v9-supply =3D <&vcca_0v9>;
vpcie1v8-supply =3D <&vcca_1v8>;
vpcie3v3-supply =3D <&vcc3v3_pcie>;
vpcie12v-supply =3D <&vcc12v_dcin>;

In the end I don't care _that_ much, but personally I find that
alphanumerical ordering harder to read ;-) .

Because in the example above, my mind now constantly shouts
"why is vpcie1... after vpcie3... ..... ooooh right, it's alpha-numerical"

But I can live with it I guess ;-) .
As 3.3 is smaller than 12 afterall.


Heiko



