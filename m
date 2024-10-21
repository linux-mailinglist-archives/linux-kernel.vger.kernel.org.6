Return-Path: <linux-kernel+bounces-374666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD89A6E51
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC611283606
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105081C4603;
	Mon, 21 Oct 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AiG2kr1R"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F691C32E5;
	Mon, 21 Oct 2024 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524995; cv=none; b=D2EE+rMundP2zSg6oalrjzj/phN9g1rgcYj2xhhftUNVShCYvMX422xns5eG/aHJx3alMzlUKwVIWv9o1JVGYKQ6ShiRc3XJmFv4IfzqQH+N2hoclrMF2uETown+1NP3eQRGW1n/n2SMU7mAtvds4Ow/va2nJOM4aeEHx8J2L1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524995; c=relaxed/simple;
	bh=r9wKuIpzqbPPGBHMaMbFWYWuH8imrAFecF7S73eJHTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uxcvly1PJhIwSSoeYUIgml3tYCKIPOaBAmkHNRr95pjP2G8Uyl0dlK9JoZwFULBpR5lcnFpf9g72iT4hyOo+cveiHG60AlzeYuZ1JQ7ccZgKlioaXIuAPCQL+w/h7kpEfkqtlTIwUnbfijd29oMGnpv102JWR8D56b4/qanKLHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AiG2kr1R; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DD1BE42B3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729524993; bh=7MaaX1dMu6STuAavkR+AK7KeHDTc4riA3egUyYu2N9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AiG2kr1RyheclnIi0nWMa29ERNmylULAbTUZXk9ZN6RXvVxdH8HoPLDPm9wwi4Pye
	 TfKrGatyupRAs3zkHRLf48+pYcuvV8F/PQaR0mmkM04RDkt8WiQCRz8LtIRdviVo1+
	 xl9UWrNhepfxeDbEHhK2FoAUpCL04fZWBGhKb+kuKSSVMVoJhLLoafQHq8H9JHczpq
	 0YGfyZZEkjtVQtCMXRLdUITJFaLDzeY+p6k0GU+FHcVa/CUtoHTuXmBtedDlFOBdfg
	 Fz8magqNSdHffAN0bjo95s1/f+fRlAM1dWulRb3mQllNJiFQxxNiruKutz5jcW5xo+
	 o5SL1GUj9AEyw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DD1BE42B3D;
	Mon, 21 Oct 2024 15:36:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, Dongliang Mu
 <dzm91@hust.edu.cn>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: hust-os-kernel-patches@googlegroups.com, Hu Haowen
 <2023002089@link.tyut.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/submitting-patches.rst
In-Reply-To: <20241018015452.3787741-1-dzm91@hust.edu.cn>
References: <20241018015452.3787741-1-dzm91@hust.edu.cn>
Date: Mon, 21 Oct 2024 09:36:32 -0600
Message-ID: <87iktltqm7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Update to commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/process/submitting-patches.rst
> commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
> commit 413e775efaec ("Documentation: fix links to mailing list services")
> 2 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> v1->v2: revise the script name
>  .../zh_CN/process/submitting-patches.rst      | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Applied, thanks.

jon

