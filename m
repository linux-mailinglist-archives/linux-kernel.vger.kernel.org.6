Return-Path: <linux-kernel+bounces-250900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0995D92FE41
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE951287774
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AA17624C;
	Fri, 12 Jul 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="l3a9UQMH"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0581482EE;
	Fri, 12 Jul 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800501; cv=none; b=HHr7l7SNNKU6qsFlt8IzlFdYt8xSgnfhdF4ofTZytQmKAX77bxYXAomYId0dddsLT0DkQVum0RxQ8UU0nS5TiMo75h5hMxGrBb/LPeH7s1GK6xBQx6CyCJjjetZADqxDJVylNHi6wol7uyJmGp9LqBCTk+FDFI76spQgyhddM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800501; c=relaxed/simple;
	bh=l3QgR88V5HHq6F1fL37U4aDtHrSe0v5lPcGP8SSmJF4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ew2MBQWWjAAG+aU2L3T1PDTOShxakN/lhwNrZu+x54MTe4zojuc0Fj8fv9BncQYXe5fggsgaOAaOk7+tWTR3H6KrQ58i7SxcZKgYCKh6tIyCBuEAzFYVSnYEwqX5MAh9aJhtTuQCwol3mOy44Jmm2mQLDztbSlrhkwvoCw+/U0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=l3a9UQMH; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720800488; x=1721405288; i=markus.elfring@web.de;
	bh=PoXnPXg62wl2EOZFTNpH1Jo7p27pLNtzNnYtglY0Pgk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=l3a9UQMHfDF4FIfMvqYa37Y5szJljAkldt8rA4BR0TJ63vjCFPbO3xc5xdQkZ6ef
	 rWKH4KQyRHqWcx3JgalxOk6SWHYDrD1Fdum52IuJMuUqtoRLYc98NNn2lS5uegCrx
	 I5OAcPqSWIxZiA1+736tPrK/ONEbKg5QrmQlopC3Se8udwYOzvJ/Z803ONeJieQtr
	 5+nMLnv/tWf8UZPmFZXaCEYcaBdfq139dSY+qEPMBi0J3gyBysw8YRAXSrNg4KggT
	 eee60dSf+A50i1gf6VjgzKAgyIvAmXlh5ib4hoWYjhkpRuNa1zLPnd8VQfbMh3Gge
	 9xCPmUFMKFAYB94Kkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrwrx-1ryTq10xiX-00jKm1; Fri, 12
 Jul 2024 18:08:08 +0200
Message-ID: <4e6b5185-fa2f-4f00-9be8-c80af7a91cfb@web.de>
Date: Fri, 12 Jul 2024 18:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dan Carpenter <dan.carpenter@linaro.org>,
 kernel-janitors@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>
References: <01cd578f-127b-4c8b-a8c6-5e11a0a2555c@stanley.mountain>
Subject: Re: [PATCH] regulator: bd96801: Delete unnecessary check in probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <01cd578f-127b-4c8b-a8c6-5e11a0a2555c@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kDliC8+yNYhg7cffpPreT/FLcqrrOv+II1E7G5CyiNY1W9StSYl
 EJBIOK9YhnsUT0EQI4+VCE6NpcBiEl6g9Br3glF90+KANuAEGfuyIXJZsI/QZBzx+AWcjkm
 n8UaUhLnmsvc+rddFCE+7z/cb+7OROFJ4qpxnZ48jkYzKKsRqqPmNvnnPDo2Y2+q7G9EFr0
 QqlYGo3o/1OxjT/YTbrLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PynEmgzOQ2g=;ecvRgKjXp8lWE+pQo4CmN7Gr1U0
 bCDsoPW/en+keQCJYAyMLfabLc4MSQ8CJxYmvzCAgW8PiOLE3BeLYX4HfdXTb00aUdvrqxsUh
 U2HHpf6pp5vRu0oF5fsf4UFSKFaofD1eg/Ryx+dXxXD3M5bIoDTjqvj/P2xVhz4gM3A36Gm8B
 xXL244+wMObR35l4DUWDzBAJx4/ifO+3BwKfRPQeD9dsnG79GooBRfVMFB4udR8d20JdWkdPN
 C1Ggp4ofZU9F34vVyEeG+Znn/FT5zAQ6XmCZHiemD8AHAa5V6YnzELxoKdELEhleba1yV26gr
 iooMZ3Fj1iC+QTu48/PgwAgf0dDFBoTZ9KuS5z1VOylg7TWyiHr8LOXODWkBSzhvkpXOKlGX/
 UWlcUrVua3sMycc/hY1p89wFofaF8jErpHiJfVG6UwZ+Db6oX4tgzqpUvHri42sl8hrV2ocHX
 +08FUO6LPLHSbpAlO4v/Zx6UTl1zbykNQoun6Je0DnVDCuqDxTCX5R+JBy0jUtiOoJH05IRMX
 iFK8PXDuEQJDk73gg+IPpVBfTkMW1OOrN9SgmitpdVQIav5uXK3OoX11gFDa+KH78tz10Blk9
 DrJ2uFrhka7hclLtcVTPklqZs2Jy4rmf/dMoFYxNMmQKo3bsVPvl1pF/zSfKw3cXhqzmVYofe
 o7eUnLQ1yHI83EWnLpVk9Jb3Ek636I+RlirJjQ+ow4CVIRmHmf79BPWdg2gMK4VTw1gjyfSaM
 NY60WSDuFTx55PNlkTKvL+Qeha1HP/ixvZbqlMJ/M+GGpBD/BsmViPxACxmcCV4XZELjXqNkA
 8HJXQDIqHZDHCYm+g3hBrS3Q==

>                              =E2=80=A6 Delete the check.

Would you like to refer to the function name =E2=80=9Cbd96801_probe=E2=80=
=9D in the summary phrase?

Regards,
Markus

