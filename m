Return-Path: <linux-kernel+bounces-297085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C872295B2D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83825283CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F2E170A3E;
	Thu, 22 Aug 2024 10:24:15 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590A7364A4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.228.1.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724322255; cv=none; b=JQfbIVIvgLKfIqCjWOq+nhtvEHqyPYX+iG3JipKLp31O6vzZaJHT1dRfZxn1azRO1d+9nH7aP6Rds0BYwqZLe4YdUfReChZHQ8AFPdmx5+ke9pfW88soB8r63nZSb/zMC8+Av/NnWZOxiwyNSG9d7kG0IibEGLO/RT2pT3TBci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724322255; c=relaxed/simple;
	bh=1IL1tYtoU2em45umUxWpLwCAtl4YrH5Tu65uTlqCZzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgTH+1i5kq2gYsOEowuHWjrQJrj+2u5Ec4NxtZUtb/MNO2fMAfHpPIsWGDOsgLtO0m+dln+43v3NRE87LbOqJMELQGbUx5gvY41W7e/PYsumkh7jRPd9pJJzVATeBmIIwa8PBbBfmH6Lo0MqH/gJvWW1rVC+swEtTZmV7C1WlyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org; spf=pass smtp.mailfrom=kernel.crashing.org; arc=none smtp.client-ip=63.228.1.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 47M9rgcZ003432;
	Thu, 22 Aug 2024 04:54:03 -0500
Message-ID: <8c7980d11a2141a90669b063ce8569736e4675ae.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: warn on emulation of dcbz instruction in
 kernel mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>,
        LEROY Christophe
	 <christophe.leroy2@cs-soprasteria.com>
Cc: Christian Lamparter <christian.lamparter@isd.uni-stuttgart.de>,
        Paul
 Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stan
 Johnson <userm57@yahoo.com>, Finn Thain <fthain@linux-m68k.org>
Date: Thu, 22 Aug 2024 19:53:42 +1000
In-Reply-To: <20240822071443.GA6395@lst.de>
References: 
	<2e3acfe63d289c6fba366e16973c9ab8369e8b75.1631803922.git.christophe.leroy@csgroup.eu>
	 <17fa6450-6613-4c34-804b-e47246e7b39c@isd.uni-stuttgart.de>
	 <9dbf73fe-a459-4956-8dbc-e919d9728f5e@cs-soprasteria.com>
	 <20240822053238.GA2028@lst.de>
	 <e6acf664-5ebd-4273-9330-cbec283ede23@cs-soprasteria.com>
	 <20240822071443.GA6395@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 09:14 +0200, Christoph Hellwig wrote:
>=20
> I'd suggest two things:
>=20
> =C2=A01) remove the warning.=C2=A0 The use case is perfectly valid and ev=
erything
> =C2=A0=C2=A0=C2=A0 using uncached memory is already slow, so people will =
just have to
> =C2=A0=C2=A0=C2=A0 deal with it.=C2=A0 Maybe offer a trace point instead =
if people care about
> =C2=A0=C2=A0=C2=A0 it.

Well... there's slow and extremely slow .. :-) dcbz() on uncached
memory will take an exception for every "cache line" of zeros which
will then need to be emulated. We are talking about hundreds to
thousands of cycle per cache line.=20

(Do we have an optimisation to detect memset in the emulation code and
force it to return to a non-dcbz'ing version ? If not, that's doable
and would at least limit it to one exception per memset() instead of
one per cache-line).=20

Cheers,
Ben.

