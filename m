Return-Path: <linux-kernel+bounces-416702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 775949D48FC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA21F22D64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 08:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4B61CB322;
	Thu, 21 Nov 2024 08:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="K5E5LPB7"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC1146A6B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178342; cv=none; b=H7wrg6B+bla6mWYBvPajwozS/8C3/h6y1PFWCBwqkISH/Y+ZMQt0ACUqrGMf3EBE78hiGpj0FCrU6c7v3o6nL15+MWlDbDB+FawBije/KRr7fng0BYZJ350FcGpE95ED+K0NNiW2m0PorKc+QnN5Dflcd9lGoRtOUlmeQ4voMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178342; c=relaxed/simple;
	bh=pzembqrUVPK9F44sznnbwZxaJ5QPuV+5mqPWq5PcR2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAj6Zop/Bm8QUQM/78kgh5d6NlRm2kzFooSHBOPOCFrKSbuQjHsqjUM/O7XEWZrdtHgGOjT5HSiu2fJ5UlIQWb1KBXhmi8KXe6saoFRiphfkoA3cTsBnkkxo2lBd28KNxLSQgZ1yUCFTto00WetvATCswIIfdg/fgIUgqvwB7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=K5E5LPB7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FHKNk3ZnkRHZqy1I3MVdZq0wTw6nyYKhvWFL++uRWnA=; t=1732178338; x=1732783138; 
	b=K5E5LPB7HvETdCimRRacSvGhCjbU9KVmgNQgTp+CkGa8GdM0dDFgGEjj3+y9ThYqr6EH24J+oLr
	yO90fTwD+nc9n/enUmuaKuRZxlVOlMnEliRLT7fCOPGews4LlHTCbgHgQ/QiEkWthvIsBbyH636hN
	Qlsn0y8QrcFs64as1rC2gdy+y249M5Tmi72uDSmhQW0uLQqKZogQ5oGPQXDtoM586aRJdYq4EkPwr
	E0DgZAsxEWONXcgSKFdeCWE89YavD3/6Zo6j53TazTxKOBQGLFTP29LuRRmVlD0EzgcIoAHic0dAS
	NGEvCTzMkxXoR85taDXLOWLQSRFQuqEjtuFg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1tE2i7-00000002umv-1tkB; Thu, 21 Nov 2024 09:38:47 +0100
Received: from p57bd904e.dip0.t-ipconnect.de ([87.189.144.78] helo=z6.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1tE2i7-00000002FgF-11eP; Thu, 21 Nov 2024 09:38:47 +0100
Received: from glaubitz by z6.fritz.box with local (Exim 4.96)
	(envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1tE2i6-00FJ8T-2m;
	Thu, 21 Nov 2024 09:38:46 +0100
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: mpe@ellerman.id.au
Cc: arnd@arndb.de,
	geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 01/10] powerpc/chrp: Remove CHRP support
Date: Thu, 21 Nov 2024 09:38:46 +0100
Message-Id: <20241121083846.3648473-1-glaubitz@physik.fu-berlin.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241114131114.602234-1-mpe@ellerman.id.au>
References: <20241114131114.602234-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Michael,

> The Linux CHRP code only supports a handful of machines, all 32-bit, eg.
> IBM B50, bplan/Genesi Pegasos/Pegasos2, Total Impact briQ, and possibly
> some from Motorola? No Apple machines should be affected.

I have a Pegasos 2 and I planned on keeping it.

Have you asked among the Amiga community whether they plan on discarding
your hardware? I think it's always ill-fated to ask for popularity of
hardware on just the LKML. Most users are not on the LKML.

Adrian

--
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

