Return-Path: <linux-kernel+bounces-416705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280239D4909
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF8EB22FEA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F651BE84B;
	Thu, 21 Nov 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="YUyKT8n9"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E81013BC3F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178502; cv=none; b=RK2azjONmp7iEPg5/WJda1dapFH732UBG5nnL8EriC3Pp5o/Vj5UTNDNC5MBhOXVd+bb2s2v5fVyB88lOCoairP7y56yx0ET8H+meTPTB35VjCbAOkQch6dNFDe1/AEs+KvaBjqB/2Oq+Ws7Wp2NHhH4vFBVXLVJqrCnkmcA3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178502; c=relaxed/simple;
	bh=iC2dxVPZMA4hDutcfzVFMSUBDDuQWaf8P83m6c2pVto=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JVAMfbooTrWUC5Ywk2NnldP9hHeKpmKHVe/gDe7x0pT2UMSo9e2uuT2ISisOkBBlR5EQJzUMqx24kTGsGeduqDUNaBhft/UMJBCR2r3DDJ161Bk58jCdIR0CVvypwOhnIdt6kSYsgCbHNYZNV3zZSJP6lPOiSngTxXyCSmOjrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=YUyKT8n9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=16L1uVsMKT2JSxXl9EOWpH3BTvZFEO5ntf79G2Mx4hw=; t=1732178499; x=1732783299; 
	b=YUyKT8n95mwquJ36PbzMxhwfZ/lODXKRyoZ2k1X1bKn0z+TgL5RDqj9N6ml/E8937fNlPiu9N9a
	cSGtvi3WJ6x/O/GXLyF+W+ulspaf2YYBF7V+EJrgJesFeyPfFqL6lVocc58mYCFpqbYvczB0bnK7y
	WRPBWtdILHto1pXWJm6y8LDK34ZPA7lSl9tDLkbe4q8kIQN9KUNUOI9Pto14MPVWBAE3O6gKAQXP4
	dknfVmXNIGwsST0GSqMvvaoh50PKz33zo/JKzsgyLbJaOQJYcR3Ue2Nl/7E6o3ZHKMf71/yzo3Feu
	iEDITi6cndO+blQ+cwD7xg/vU9dig3A7XCaQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tE2kr-00000002vkI-06LO; Thu, 21 Nov 2024 09:41:37 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tE2kq-00000002G9n-3QFW; Thu, 21 Nov 2024 09:41:36 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1tE2kq-00FJAD-1Q;
	Thu, 21 Nov 2024 09:41:36 +0100
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: mpe@ellerman.id.au
Cc: arnd@arndb.de,
	geert@linux-m68k.org,
	gerhard_pircher@gmx.net,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
Date: Thu, 21 Nov 2024 09:41:36 +0100
Message-Id: <20241121084136.3648581-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <87bjydoz18.fsf@mpe.ellerman.id.au>
References: <87bjydoz18.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

>> Pegasos2 users still exist, but admittedly they mainly use MorphOS and
>> AmigaOS4 on these machines.
>
> The Linux CHRP support is still present in v6.12, which will be an LTS
> for the next 2 years at least, so if there's folks who occasionally boot
> Linux they will still be able to do that for a while.

Is there any urgency that warrants the removal? I could understand when ia64
support was removed because it put a burden on maintainers.

But CHRP support?

Adrian

--
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

