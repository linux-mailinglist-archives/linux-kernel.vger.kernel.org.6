Return-Path: <linux-kernel+bounces-410109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A79CCD1C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 528DA2840AF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38CE1E49F;
	Fri, 15 Nov 2024 00:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="iYeSDixr"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE021362
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630646; cv=none; b=mrdkapiAcA0/UCF8tncXqAuHCCiCr28fSUAg/75FitjKKBdmC18ByE54bfuaWp6dNC0+ws+2T5f2ymsG0nBeoGPaeja6bu0OBZomcXG8SPLP3INXolh+KCvK8sn3t5G64LHtQpU09wG4shlzMeB/VLwKI4B1FDWa1d00iFt13lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630646; c=relaxed/simple;
	bh=a4zPVfXx+Crpt0YpvibCUWUMvHkAdXnWt+x1HwkP4ME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LrVG/q0+xl65PczCeMnUXr7oCWAG+MGPRqiqeg4uR8PyvxSnGS7foQoOzsYkJQ6tw8vX1Y0sMKyvglCA+MMvXIG6bL8cd4oQxbfzBni2JQmW2LmIPNHvSNWUjGV5N2eFXNGfjMR30PiabWKA+hQ+lWbWV66aIewC5n5jbL8++Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; spf=pass smtp.mailfrom=ozlabs.org; dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b=iYeSDixr; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1731630637;
	bh=a4zPVfXx+Crpt0YpvibCUWUMvHkAdXnWt+x1HwkP4ME=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iYeSDixrpiK43bsxiTaUgCxI3BJPzHZamA6dbA4BFFESDPztJoZbK7h13Jj6wHoRZ
	 fv/LG9fZTuQHkcZg+963TZY0uknXy3U6cVvE2YCYfmTJzrlmmBoLSZW8irZVq+3KVr
	 CIL9YHr9Y41Rlfg8uD/VGudgbamwb6Uu5ON1QzXFDMnrI77OM4nsyKlViIwtbvmP2c
	 sySWTHdU8eWayLK5/T2wbuNVfylZm4wqVhJ5B5lnaXYjr/B3wyVictTbdKJgNre/4u
	 ICklwF7KmZB2uB9ApA3jW+pTzuXrA9zeFCXSd9yEUFVVduy+0ivdSYcQaVwWHzl6WP
	 PfbIlcS4GWglQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XqHx8588zz4xPy;
	Fri, 15 Nov 2024 11:30:36 +1100 (AEDT)
Message-ID: <fa60468bfebb7392bac54454fe196f306f6db97f.camel@ozlabs.org>
Subject: Re: [RFC PATCH 01/20] powerpc/cell: Remove support for IBM Cell
 Blades
From: Jeremy Kerr <jk@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, geoff@infradead.org
Date: Fri, 15 Nov 2024 08:30:37 +0800
In-Reply-To: <20241114125111.599093-1-mpe@ellerman.id.au>
References: <20241114125111.599093-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Michael,

> IBM Cell Blades used the Cell processor and the "blade" server form
> factor. They were sold as models QS20, QS21 & QS22 from roughly 2006 to
> 2012 [1]. They were used in a few supercomputers (eg. Roadrunner) that
> have since been dismantled, and were not that widely used otherwise.
>=20
> Until recently I still had a working QS22, which meant I was able to
> keep the platform support working, but unfortunately that machine has
> now died.

Oh no!

> Remove the top-level config symbol PPC_IBM_CELL_BLADE, and then
> the dependent symbols PPC_CELL_NATIVE, PPC_CELL_COMMON, CBE_RAS,
> PPC_IBM_CELL_RESETBUTTON, PPC_IBM_CELL_POWERBUTTON, CBE_THERM, and
> AXON_MSI. Then remove the associated C files and headers, and trim
> unused header content (some is shared with PS3).

Nice work, thanks for pulling this apart. For the series:

Acked-by: Jeremy Kerr <jk@ozlabs.org>

Cheers,


Jeremy

