Return-Path: <linux-kernel+bounces-318683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12D96F1A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FAF289218
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A761C9EBA;
	Fri,  6 Sep 2024 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="QDfvUoVT"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D121C9DCD;
	Fri,  6 Sep 2024 10:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618986; cv=none; b=YR5CG6W6UNCgUvlrYNaNTQgZ3K/+Xg6vM3eBUdIxG6hBaSyFThbojZoPvf8yWhPIjfZyaAQb9SdSjHVB8DKr6ijYyKsadnWOi7SAOX22XKhtf4EQrSNFhIdmxYfuCsnsWDpA7FZbUOjbaxlRMmYIYzNjdtxxlP4w/ioTLzA8btw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618986; c=relaxed/simple;
	bh=vZox6jFnLX8SSldfu/LCPU5kPKQh7zknih3TNa5rQy4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JS2piAwvLdgAopJv0d2oLaZEU0N+hndKRDUGQFcSZOxvm8rlz8BPMBM6u6ByusATArXZrn8Cn1pYHt2nzDLPWIsgv6u2xtKKKlYV3g28XjLL2N93a/honB/WB8tPSCOb7jnHOYZwT3XU1hBkdX+j4B7cpHaxigZwJw18DkiDVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=QDfvUoVT; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725618981; x=1726223781; i=efault@gmx.de;
	bh=5XoZSLvcfS+cvLX4G6gOk4GvsFgsNsbNfbyGTErDTRg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=QDfvUoVTSlTK3rBspl76gagQKMKb9F5L7akwygWgYv5/QXzwKDLj/Ym4cMXmo7d8
	 H8lOCAxasIIsXdp6nAYOZfJ0Fqie0ptmEODY9lJFpH9PiBsVtkKNUMlazjEbq7Z2F
	 6zAyc3s92dWNnulhdJJr/Rih5WGpueldB90yqVDgppWHLNL/0N9tmCSUi45Tnuk1m
	 jgPpGWAZTdpkBvMZHrSzmtnVB0CKJNCrkyDCfro05MAUvNa0SUsiRqclFJfvq1vxs
	 DHX9up1VuNphKXmFhw/eVeUfsevXF93QrBAaI3QEKA5URv96XeRVJywA8mNcjulZJ
	 YzjbBrnhFkpCeZGiyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.123]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1scIva0Xj5-00JHqM; Fri, 06
 Sep 2024 12:36:21 +0200
Message-ID: <296350ab6981086f2e39377cf59fb4c53971b261.camel@gmx.de>
Subject: Re: Problems with suspend hanging laptop on 6.11-rc1
From: Mike Galbraith <efault@gmx.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>, Steve
	French <smfrench@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Date: Fri, 06 Sep 2024 12:36:20 +0200
In-Reply-To: <7d44b79b-5d60-4fa6-8b52-a276e2baf15a@leemhuis.info>
References: 
	<CAH2r5mtNqn0i5NQSQvMvbHDdRDJxcNQh7iTj76L=90kEhDA7iw@mail.gmail.com>
	 <f3d4b89c752df94407f7becd37b45a3e418d590e.camel@gmx.de>
	 <7d44b79b-5d60-4fa6-8b52-a276e2baf15a@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HrWg/Gf26QD5G7Goif6oeLnVWs7QoB5tMxv5R1iWRizOjd+g0xO
 HmUAmtoBOKQY1uSi9GsMkSRgmsrS3Ud7TMMfppXiXutFTsgL5agYEx6rnnkuyfwzJlMDu4N
 WpGQBqQx4lbRvPaGsqTy0eY1R53xnOrmOAe/G0GE0WpzoHFnY0q0NBuoHLir9cdkE9VMsqV
 JAD2/iMsJ1vPxARgL/y/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZOLMioiH6S0=;M3dtnqWKUXcHd+pRpqXCd3Z0ldI
 ahY2vU8Ho9QKbI8/Yb+ULjewI7l+APwZUVIhmqsGfFX2VdbWjkqCPeWRhrVipFNr34l8rWWdw
 hfw2H1xv7HE65308j51e0nJpUdIkG1evEC1WSdMo1fP7/9auJcz0j12rnYotbe1pdXB4oP6R8
 lGh7gnEpXGtzqvH9J2Z4ni3/OesRtKvxPuo77ZFBgltakDwVAuYQoHitJdGNMIcERwKMIfRZA
 /GBmI9f4RoLNOBeZbFTG6JkGVoaTSHxmNqTwGI4+lGTQGqEqpzww188XXHEDtSr77qBpUNAi8
 NSJPawmvzlumZDJ+4VS5lr/r+kN6jAUiM8fGi/mHHGd3mAoaufF4ShrJEYz/mBXe2BsqHpk+R
 ivR0rxaXSwwFYNtGFDf8cCbhIEfCUf9MilxT98W8g5CtlFEQA8I1fVsEl/RW2J5iYTuCKFnhW
 B3p8g0oP9VoJIYhNYMY1Vupiv51Xp91HaNhRgqwczeBaObXTAn5rjnSv5YWDkbjir13EXBPa+
 p885RN4F5oqClD7nFmsMsGSbVYLoIeJjvMS09V09tS59SjBirgRdtKsSbifBVfxrXHdUdgT90
 HVB2nKS2ajb+WUkcq4rG0mgUjDrdKVcaR8PK74rYBz7uh1lnI+GxKoq4HM53lm9OVL+EoCIpr
 8bdcfUNYLqns41CB6MJdmznjbTkbJFHg/BceoRsGL0aBFSDLoe9g6z8dVTxxjc2ugqb7Mi1mL
 rDJ7jbFgBjgFVKTKA/vdJdcatwMmVTxlsiUQmr7iMLRssixV7E9LswGRdhSRvP/XliCfu70Ji
 40RijQwRXU6JZ2c2ok3luHtQ==

On Fri, 2024-09-06 at 11:58 +0200, Linux regression tracking (Thorsten Lee=
mhuis) wrote:
> On 01.08.24 16:50, Mike Galbraith wrote:
> > On Tue, 2024-07-30 at 10:11 -0500, Steve French wrote:
> > > Has anyone else noticed suspend on 6.11-rc1 hanging the system?
> >
> > Yup, my Nvidia GM204 infested desktop box (using nouveau) has it too.
> > Bisection wandered off into lala-land unfortunately.=C2=A0 I'll try th=
at
> > again when I find a round-tuit.
>
> Hey you two, there were no further messages about this. I assume those
> issues vanished?

Yeah, the problematic commit was reverted for the nonce.

27ce65f65258 Revert "nouveau: rip out busy fence waits"

	-Mike

