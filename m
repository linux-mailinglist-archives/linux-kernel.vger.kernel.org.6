Return-Path: <linux-kernel+bounces-576849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0A1A71522
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F37B3188F362
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333F81C84C9;
	Wed, 26 Mar 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="O2Za/e5Q"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5511C8635
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742986445; cv=none; b=QJrr83K3/wm7fObY88H+MWyHFbJNrARFoFORWrRAGfJ5GXFRM7CR7j3ryl4F0kFOC9h4HK3rhecwJ6ppFYRA+Z7CDYHh75IjE1z5JRTyJswBGuEV17VIS6gSFT6tN/HHRQBw8Tm+bkyeFhASLKe14kCTeMfj53Z6NdUJMp7Vehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742986445; c=relaxed/simple;
	bh=FczXml0qH94FKhTjt3X4lAzUOWCVVZ9xk8FYtjX56WE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=rEFv2s2adfgGMQogmdquIBGfUleOFFD6BW/aUkNENBLEfX231zW5qTL6quyfaE4aGMjMgcZRwGMvUzhXDJezlrZiqUtQMWTBEEY8r1K6JMkbLRE3/MmC177kjIycqJTeS9hPyeRHRogIUSDMH2m3FMjgK8tPTz1baLljcDnm7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=O2Za/e5Q; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9o+Qa+LVHu1xbjxfpmNsVxdbPzp4GNai2Og/XLlEipc=; t=1742986442; x=1743591242; 
	b=O2Za/e5QqNYS5ofCYYLFSvaPg6uMirBxw5N7zs8Sll/IL+IcSPRMncHy0gkoAjdSPRROPgl0EE7
	sPEUn8gi6rgUk7fKYQdb+v9J/FRyvxtWmjJ+5MUaPnOMrQ9jBO5qI63/JiqB99E7eE9sdN3BJF8zj
	lz9BERQ47+1j2lihKeDKpCJkeMlWfsVtV3TpT9UZPLYnPwINv/x2wxm+NYbMg3CcffbAB1aXuZsSj
	PXoe+QXKFrPrEBgCBeP+LcaqkGMEqbrTJFvgyFtHEvDue+u5B7lf2TDPNR2IuujFoGZPegqUh6h2G
	YOgYeWCM4+7+Y3ETwJltdNFXnIVUfkUQ9Khg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1txOKm-00000001fAg-2mwf; Wed, 26 Mar 2025 11:50:08 +0100
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1txOKm-00000003xtV-1Zlb; Wed, 26 Mar 2025 11:50:08 +0100
Message-ID: <90872dd1a7f8844e313876afb74ec15aff7299b7.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.15-1 tag
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: maddy@linux.ibm.com
Cc: adubey@linux.ibm.com, amachhiw@linux.ibm.com, arnd@arndb.de, 
	atrajeev@linux.ibm.com, avnish@linux.ibm.com, christophe.leroy@csgroup.eu, 
	gautam@linux.ibm.com, gbatra@linux.ibm.com, jk@ozlabs.org,
 kjain@linux.ibm.com, 	kuba@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	mpe@ellerman.id.au, naveen@kernel.org,
 npiggin@gmail.com, paulus@ozlabs.org, 	robh@kernel.org,
 schwab@linux-m68k.org, segher@kernel.crashing.org, 
	sourabhjain@linux.ibm.com, tglx@linutronix.de,
 torvalds@linux-foundation.org, 	vaibhav@linux.ibm.com
Date: Wed, 26 Mar 2025 11:50:07 +0100
In-Reply-To: <2fff6b84-52af-4320-8c8e-9aca1c009127@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Madhavan,

does the removal of IBM Cell Blades affect the possibility to run Linux
on the PlayStation 3 in any way? I assume there are still some hobbyists
using it.

There is at least one user within the Debian community using Linux on PS3.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

