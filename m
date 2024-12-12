Return-Path: <linux-kernel+bounces-442883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E02909EE36C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C399188BAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3795153800;
	Thu, 12 Dec 2024 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JAzp0hR9"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182E20C004
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997039; cv=none; b=BKVLJlC1YBdWGlc7Fbuzbf+IqgOFWX9Y6QoiCic1I2+hvLRF7SIIpWO0hhdokLyYP7yZhrXePXi/+xOhW5MRyewr/HZhAxfmMapSAuvTPR+OI9+Ex8lL+LUeMqyu33ggynCJpiaWM2Ga5jLp9AvnLH+42GnuAyfldrxt0T7V+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997039; c=relaxed/simple;
	bh=pFR1ewhmFGvFOtt40K8D3iDX8i4eQGtXg0QDwmF8L4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRmMNazCpBIQbn+6C5nHSUKxFxvIQjhQOzkiw/rHxmGkHImxsjtA3cmiRdZDgVoVhOdLyhJROjKkh+E8PnwAQOwtzAHfEVIU0RnwJ7fV7SDdken468TYW7xBwWcBTmfyVXzjKMxQCXxhx5QYXUPEE+bD0qVlDf0MC18axMHZpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JAzp0hR9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5ZVXOHLNU1IgwdHLS4CkFOVVZZV6/GwfnLa6e8IEb7Q=; t=1733997036; x=1734601836; 
	b=JAzp0hR9AKCdWd0OT7uBCgWATfq6BEZV+6k6bCM0UO3wsU/mP4BBIDZ0ObOMkaV1Z/JmyGABD91
	d0ngaPeP1slumwAsQoWRsiuHWPy6MK5cEoWgYGUFCK7rwmlDVilqe4HFNv9NktzSuiAhb2nwptw9D
	PZ2O5sjrqFtIs1W6b8l8nb8G/HoFTeuLf3HNIm4ij/2Jvv+4xex7Xzf0TsGqBO7khC9V4LYcYtilU
	1yG9jnqUAeDmtGIDHQF73rBtSopw6qfkxFlPf+mXCRuRRCL5opiMjkVe08AaRf5Rhhg/RrBGO+Bf/
	BjxRD+IHeYiApHNTusTjek8O+1qNkBv8YfZg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tLfq4-00000001o86-4B5W; Thu, 12 Dec 2024 10:50:33 +0100
Received: from p57bd9274.dip0.t-ipconnect.de ([87.189.146.116] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tLfq4-000000007H2-3DHh; Thu, 12 Dec 2024 10:50:32 +0100
Message-ID: <7a08b24bd66dd006be84334788ea224b30012a55.camel@physik.fu-berlin.de>
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: arnd@arndb.de, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Date: Thu, 12 Dec 2024 10:50:32 +0100
In-Reply-To: <a981939be1ad279ef11014d93446762cdaa93823.camel@physik.fu-berlin.de>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
		 <20241121083846.3648473-1-glaubitz@physik.fu-berlin.de>
		 <87sere7jyc.fsf@mpe.ellerman.id.au>
	 <a981939be1ad279ef11014d93446762cdaa93823.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Michael,

On Tue, 2024-11-26 at 14:27 +0100, John Paul Adrian Glaubitz wrote:
> > > Have you asked among the Amiga community whether they plan on discard=
ing
> > > your hardware? I think it's always ill-fated to ask for popularity of
> > > hardware on just the LKML. Most users are not on the LKML.
> >=20
> > I haven't because I don't really know anything about the Amiga
> > community, who they are, where they hang out, etc.
> >=20
> > Please cross post this to any Amiga folks you know, or tell me where I
> > should post it.
>=20
> I will.

I have started reaching out to the Amiga communities now. I didn't have tim=
e for
that before, but I am now on vacation and can therefore take care of this.

Please give them some time to respond. I will reach out to more communities
along the way.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

