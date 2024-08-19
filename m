Return-Path: <linux-kernel+bounces-292067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCD9956AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA8C1C22F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E0B16B3B6;
	Mon, 19 Aug 2024 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="R0uFvPtf"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B1016A95F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070198; cv=none; b=d/JgPh0rLiJs+1QaRF7ilDEdSm3Fu1hc88oFAK+0jXBp1ioQK+5R95KOypYDQSpsI/y0b1ACJYPPvUFHu8NL/dR/sgSkflKUu0EnONtFRrxLuxWCih5PWwBaxK3BIlNZxqxrG7zEHQlDVx+B3ujs7Os5qQLvelZS8CTA7K7o/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070198; c=relaxed/simple;
	bh=AFyw/l0hm8vgO2srvQ6jG2c0miCzxBtFECLxt3Kq7Mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VD1BowK3HsYds5pqyBL00rWWMG0TRcu0MTCqwByLNuwwZOF/X23dH5P8LELyn1mMqgfU667ds6D9N0B0nxbovi6EMjOxmPbEoD1e9UA4UmDqZGQQBOuRBRjzePO47bCvpg/lGSIuNRb81AZdDV+W6kx/92uK69F8//4IcRghSeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=R0uFvPtf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=DXZ9OYYdz38AQ8gXsqwwGM7UvJTsd4FhVUqGMHaS2z4=;
	t=1724070196; x=1725279796; b=R0uFvPtfLa9w0P4IyGXsLWbcxemgzR6x6dHIfyFwjeLv+iH
	RUTp4010bxTxMO1XNxYfBX21NnodGhHDeOdjiKwridZnncTrS0U630IlMoAnG4lPFUBRrPMR+rsKn
	C8+fLy8oKLReFDvdt5vbhWzYGapjVXGbvwqZPFENbPN+GQNVJiyy/Y5W7Y+QbLHKJE25iwSlfnFPu
	ZU4tBVhshUi3hwddRUIEnTO0TEbFo5RbVLEtX7mBR0r9+QJuoIiX0zDhg8z9oS7a6K0eqUqCsrx+d
	K0bCu0XqdTEGjet2DHXhA8I4wE0++M6QzjwZwEJTiFcJnnTTKPnSWqFEmOF62lig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sg1Pl-00000007YDs-0Y6D;
	Mon, 19 Aug 2024 14:23:13 +0200
Message-ID: <efbb6394805f11de27cace9817418744d8e69506.camel@sipsolutions.net>
Subject: Re: [PATCH] um: make personality(PER_LINUX32) work on x86_64
From: Johannes Berg <johannes@sipsolutions.net>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>, Maciej
 =?UTF-8?Q?=C5=BBenczykowski?=
	 <zenczykowski@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>,  linux-um@lists.infradead.org
Date: Mon, 19 Aug 2024 14:23:12 +0200
In-Reply-To: <20240813234755.3615697-1-maze@google.com>
References: <20240813234755.3615697-1-maze@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2024-08-13 at 16:47 -0700, Maciej =C5=BBenczykowski wrote:
> Without this patch:
>   #!/usr/bin/python3
>   import ctypes
>   import os
>   personality =3D ctypes.CDLL(None).personality
>   personality.restype =3D ctypes.c_int
>   personality.argtypes =3D [ctypes.c_ulong]
>   PER_LINUX32=3D8
>   personality(PER_LINUX32)
>   print(os.uname().machine)
> returns:
>   x86_64
> instead of the desired:
>   i686
>=20

But ... why should it work? UML has no 32-bit compat support anyway.

johannes

