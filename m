Return-Path: <linux-kernel+bounces-385835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4361C9B3C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0891D28297C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C221DFE2B;
	Mon, 28 Oct 2024 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LvLyWoWi"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0B18FDC2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148957; cv=none; b=jdvtJj9JA7abzVCflnGJwWi3a+lQAPLQE4g7+tOarYr2NXz4LRLXCB/lNH6hSR/5vS0JniBfe8T1ZL4uMTrCPDCeCRiK0B5snaZZf1oFakMO5So2gHEqMzbJcQJsmEGOM2hIKGC2oHZIiMr39w/ua3sKT+gNZaxP6ZfVlLRvCJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148957; c=relaxed/simple;
	bh=o0OL5D3wRRnScnzyZ9auDpW3UVQiUgrhsjMKbblKCAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjYTuFFcCkMz/zdDvtVjWz3uebxp38gXZJb1LK+dqLs3Mj1hBzt9UM+mM0YcWOw0Fr9wEb1AlHDNqjt8ws6yOQS7ez1mmDW4MkGygEK6UWNYIsIEozQMXcsvW0gzqA9OnF6hEJfWIvzlZYGvcYB+t1GnlPSb/Xg9g+QqCNjtAUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LvLyWoWi; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1730148931; x=1730408131;
	bh=o0OL5D3wRRnScnzyZ9auDpW3UVQiUgrhsjMKbblKCAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LvLyWoWiUh9ggZTBZ8zvQN5/B8ObjInqvBYhRHgkDODoLIPoHwDpmzcKoCLpx7zTj
	 vW8CXBLVD4VHqjrSARPpXxEa8WG7lLfIBOgyu4y17E9N03LO4Nv13G24lyxJcnPB98
	 ojl2y1CTGAOMKBpUfMyVBIySZ4bL9i2t+iJnwOGWHyx4JQrCZgX95OysTKBSF+4cHx
	 UY+VtUJKyZl0Nrlb4xwUNMUqyTMpLTSa4HvWq/wqzglu6ysFWkrVVtEtgMdcSz9PKm
	 dE51KCNUudFfX0gaWEZti32YbEMyrgava2m14Xqz/qHrsNpKUbRq+Mfk8LHr7oX6hx
	 EjNYZ8PFu1/jg==
Date: Mon, 28 Oct 2024 20:55:28 +0000
To: Andy Yan <andyshrk@163.com>
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, Daniel Stone <daniel@fooishbar.org>, Dragan Simic <dsimic@manjaro.org>, Diederik de Haas <didi.debian@cknow.org>
Subject: Re:Re: [PATCH v6] rockchip/drm: vop2: add support for gamma LUT
Message-ID: <wXgQHAvchmtDzCTJX5pnEcLvGM1Rf2HTeooQ7GwE-6luNP_BLRQ2LW0wWSXcGWgARzDnfhKd1xQXeMMGYSAhIlX9m7pl3CZ6FxM1yc0qslg=@proton.me>
In-Reply-To: <-rVNN65kgfRzFJBJDIwQF3jNMfXIZFP8GibtUgB_p-eWGLBkNZhYFr-BXEas8IjjofHxWQUqNicUSTp5rb9XmuLi35XsDd0PzJPz79j-M-8=@proton.me>
References: <20241016223558.673145-2-pZ010001011111@proton.me> <DurUfF_0TBHKv4DHKIP3ggQh_85nRY0usYWn_fu_oJ45txO7dGKv-OK5rl6EDEPmX5l8WzrwPCzAvYz0xFPfeKGyx7enu1g-prsWIpilv88=@proton.me> <2bb58a1c.6287.192d1dc9b2d.Coremail.andyshrk@163.com> <-rVNN65kgfRzFJBJDIwQF3jNMfXIZFP8GibtUgB_p-eWGLBkNZhYFr-BXEas8IjjofHxWQUqNicUSTp5rb9XmuLi35XsDd0PzJPz79j-M-8=@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: c6c0ed3cb59d5081b7c3f97d9c933c5ec18de402
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi again

On Monday, October 28th, 2024 at 5:40 PM, Piotr Zalewski <pZ010001011111@pr=
oton.me> wrote:

> On Monday, October 28th, 2024 at 7:42 AM, Andy Yan andyshrk@163.com wrote=
:
>=20
> > Hi Piotr=EF=BC=8C
>=20
>=20
> Hi Andy
>=20
> > Tested on top of Linux 6.12-rc5 with rk3566-box-demo in a buildroot + w=
eston environment:
> > weston --backend=3Ddrm-backend.so -i 0 --continue-without-input
> > weston-simple-egl
>=20
>=20
> Thank you for testing it!
>=20
> > simple-egl will draw a triangle on the desktop.
> > After the patch applied=EF=BC=8Cthe triangle will flicker again and agi=
an=E3=80=82
> > So it break some function=E3=80=82
>=20
>=20
> Did you have gamma on? The screen flickered for me when I ran something
> writing gamma LUT frequently because of disable step I reckon.
>=20
> > I've been quite busy lately, and it will take some time before I can an=
alyze what the specific reason is.
>=20
>=20
> Np, I will try to reproduce this behavior with weston on Pinetab2 in the
> meantime.
>

So I got weston (version 13) and ran it as you did, then ran the same
client. Nothing flickered. Since weston doesn't support gamma control, I
ran sway in the other tty and set color temperature there with `gammastep
-O 3000`. Then switched again to weston and color temp. wasn't retained,
triangle didn't flicker. Then I ran weston-simple-egl under sway (while
having `gammastep` running and doing gamma lut adjustments every ~5
seconds) and the triangle didn't flicker too (but there were _expected_
flickers every ~5 seconds because of gamma adjustments by gammastep).

Best Regards, Piotr Zalewski

