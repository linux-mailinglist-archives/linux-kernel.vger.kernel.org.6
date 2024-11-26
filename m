Return-Path: <linux-kernel+bounces-421819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E349D908D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67398B2680B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627124962C;
	Tue, 26 Nov 2024 02:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="S+ksIyi6"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18C53EA69
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589878; cv=none; b=f3RAtsXw7soJhcdYMeFGTbWRbkjCAMT8yj8mtoYWadyEDurAQKbHf/fNJ9YeH8GEEPjn1kMUvMnPLwGccvjjK+oUUovgEE6uIDxcsar9sDXrNGZahsuHb8378wsSeAj4Bvu8cxMs3Esp6AqH53G4ORcIdOFVQtaG40D4xgoEmFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589878; c=relaxed/simple;
	bh=ZxkgMzucYCvlfaLCKRGyCdL2dzvZm0uE/Q2a/S5n39U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRSifZbQ8sShZD25GW2X3xTaze6vbag+FIN0DGh38R41hPPncDOgUunfiQLBcatWG0V7bKvAwszmA1VrBufRurKvJFV+IVKooAJZhGCiR2uIO/El4QhIMWaO3h3ctCuUMsEt2P8xtsM1CUhYc/qIJhzRmN1EECrkC+urodAME8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=S+ksIyi6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1732589871;
	bh=kYITKr1RW0onW7Dxk5ftdG1Sh5lr/y0Q8flJr+qSg70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=S+ksIyi6MRPxig8HC3KGigDzKt4QNrVpZDjU3XDN1M7VpgwstPM87P70Ver2SwY7+
	 TtkB+z77sKWq/oM9qfPgpzILL9P4l7eTSdSszDDNGeU0ELqzBlu0rMJkzPrw5Pg85Q
	 HhHJtBjP7EWAvW4CsJo/gaU4beuCe9ZpdC2ZOs0m4t3QvgN0WKJm9W3KZmavnBXnsR
	 WXIZ/TbmdrDjWaGWtBYUf6iXMXaDWVe0WzkjZ9ljfCveL/wFLKTxCnOVCWJ7U51+ML
	 Yup98FSYWMxQiM/RHChOuf4FwZFbA0TjeOyzozD6vtiChVF6pXho2HP4wymVhLWLp9
	 pycWaKibCWU6Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xy6gy3SSxz4wcT;
	Tue, 26 Nov 2024 13:57:50 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Yang Li
 <yang.lee@linux.alibaba.com>, npiggin@gmail.com, naveen@kernel.org,
 maddy@linux.ibm.com, Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] powerpc/machdep: Remove duplicated include in svm.c
In-Reply-To: <563bccb3-d9eb-4001-8c3e-6021c507f636@csgroup.eu>
References: <20241107010259.46308-1-yang.lee@linux.alibaba.com>
 <87msibcmeb.fsf@mpe.ellerman.id.au>
 <563bccb3-d9eb-4001-8c3e-6021c507f636@csgroup.eu>
Date: Tue, 26 Nov 2024 13:57:42 +1100
Message-ID: <87v7wa7lcp.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 07/11/2024 =C3=A0 12:29, Michael Ellerman a =C3=A9crit=C2=A0:
>> Yang Li <yang.lee@linux.alibaba.com> writes:
>>> The header files linux/mem_encrypt.h is included twice in svm.c,
>>> so one inclusion of each can be removed.
>>>
>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D11750
>>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>>> ---
>>>   arch/powerpc/platforms/pseries/svm.c | 1 -
>>>   1 file changed, 1 deletion(-)
>>=20
>> The two includes only appear in linux-next, and they both come from
>> different trees. They are required in each tree to avoid breaking the
>> build.
>>=20
>> So no one can merge this patch until the two trees are merged into mainl=
ine.
>
> That's in linus tree now

Yep thanks.

cheers

