Return-Path: <linux-kernel+bounces-531351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924AA43F6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD013BAECD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66F220C477;
	Tue, 25 Feb 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="P5YmsyYX"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CAE2571AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740486714; cv=none; b=VIJilzqDsj+wj2SXZu4shP+Q5Ow2GwA8JXubQTwsQ5H0iTt7hdfJ7agK7mRmC4nLhUSZRyBb7N0voQR2FvtQWGxZ8cYSYzy0e7+hHxVySZT6Cuy4z9BWr1XPCWxBYxjtzpRqVu7GLlBQ8o/JnrNu//sOPDyWB/J7f6R8n/Eg/X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740486714; c=relaxed/simple;
	bh=BE3dddq/PJ2LGVwbssOwVpXeFrwbodiYdIqHe8+jSQ8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WO2DamCrCCu0M2mPW/Q88154Bm+IlunWDbN1/7czSNSaVLqGR9vW+I79mYYHNREb+DZn44tDpECPIvz/Wz8VlfBtm3JVUSdmrco5GpFbi3ZPtjOJHJ/WaI/D/pYi22FH4vgw0F6uEQmOemEHTJ+QCqX35unErb9IUI4qBqQ+FyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=P5YmsyYX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740486703; x=1741091503; i=markus.elfring@web.de;
	bh=BE3dddq/PJ2LGVwbssOwVpXeFrwbodiYdIqHe8+jSQ8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=P5YmsyYXGHN9ZDoNse3XScWxylVITeZpAIWcAOUmyhrmA68rPjTm0sZ22D1WyTvK
	 BOxMec3dWIxSQXHym+YEnGigQp/+GT5foQ2vBMamjnCDDa6F5/uLE8yi4YaYMa0sE
	 9zr+7tO9tnsgr+n2W4ZfvrZbQUNiO1UAe3cwS7Ldgmz5nja893r+355qLWl20BrHX
	 xlczbC4QTb9GLY3fWUejz02PH2Ozf76zwLted6YcPF8Uip9hbfn4PmLxrbJsbdKFF
	 U4D8iMTN18F80ZrlxOJWo5QEjh3iNimfIDCPyORlJt8A+dueZqZMFReMwlXjI58s6
	 17RQJY6/nt/IvSrT2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M9qhD-1th7LG2WVZ-004otk; Tue, 25
 Feb 2025 13:31:43 +0100
Message-ID: <9bc553de-2266-4134-b370-bb287d3538dd@web.de>
Date: Tue, 25 Feb 2025 13:31:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dave Penkler <dpenkler@gmail.com>, linux-staging@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250222202301.3729-1-dpenkler@gmail.com>
Subject: Re: [PATCH] staging: gpib: Add return value to request_control
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250222202301.3729-1-dpenkler@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A4K7lIFDn9B7GUN6vCI4Ifk5k7USBdi47WS54kZMNLKMDtceSNI
 OTCseK2vw1k7OinV996DZAUzfi/i6KBUdU/NsON/bGTiAchru/KqlEa+9xmsyUmGnKe6bjR
 lB2t/YBzjKGt4H1TZg3iKrlAw0gJtcW7FaSy4sNe/q/NpEYh03uQMOd54PDyF4OyTp5bc4F
 NOPFaV2vEBnMXdfUckb4Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8uJ62oDRgss=;bxudl0MtuFdFeSmj6qNLHwpY+HW
 gb0Mv0Cwwbsqbq/4UeogT6P2Hc8yrhV+aWXP2xnmWD21Qb6raqZGqlHdEnb1HzWzMMHFW2sGo
 uX9SmW2+bYAJx7msKV1rjLBloLwsLc0e++at2hCQNN+M4jlP8eu9a8i2uwolB/mHpz3J524fD
 KcMQMWEKU2M9VOXrXlWTfbIanOey2x/BOPGhzRTl7WexvKKd4FwOJEiasq12axFjTUOnEnH/V
 ibTB413iaiqaBM0Ljihk0QsmXPNlIzMmBOAfgtsed4+oELK8PRm+hafZN3N+F/wnMDwzkiTep
 foPjI2yFRjdZRlrNcf9kgYssOKKtz6ERegBgkpPMlNPNVNMUYnEZglD0bCx1psxfsVNJsUzk6
 Jazm3wq70jO5/r7V+9lc5te3wWwaFDgBptVi+MBApTz0X/9/W0rXzM54aZYq7q9WGHttkcIWz
 sW40upVDh7Qrz9L+QYriEuxj+cYYJ7M1IeEY6Nl01rUhcljNDIO0HmBkCdpZiEsIeJ5R8LGm+
 Hwsrn9AbG6Q4Je4b1GSBdFbkhrc1D+daezZLV4pzxvclxDssxje32Of3N+n5sK9IzDDLYyIrK
 Q2FnUnY8aCuw2rLr0uEXEY8ZSDFSK7CWkNmb1eUD+hhxhrnM9f48Uz0KV1j/TSMB5g/YDWeAb
 Jgs/lynZrxvIymK3ZsAz/shxsWruJF665mlj1sRmMXzCKSOn0CCmO5g1qSUgKmWgqu/yw4ij4
 JG+dp1CmRsJpaffXhOWufZ0CLSref6f7Yj5K809mn38qOEuMi1M0PUvMytJcNmpyVY5HDdNgX
 A/VJbIAJOkVWnDUMUxU8FZGghXIz3R37teb0hTLiRXv5c84ErmhUVtfQ8+HcmKPCVIhvBMkff
 vxV0WD1juuIbzJeAmwRSomwijOxHc0tjrg1ZE2KmtZG5lNjByaHf9y6OTqlPcB2cjHHGGDeVC
 sTp7okPLeQz8e6x5TC+5yB+5qRubQSlWK0DRBq3LExlq90dEh0F/wDzUG90PlvoG9wKSTezPK
 +MPjBHokEdKwT3sFfDvV6KgmoCkQwayYOo14Xv2Y/EUACwe72TTGBS3N04bdM9c7an+ElKQh6
 TcFnNjtIVkOz+9vo0cIIn32Yg2LE7YDdkkl0PFNrLeGU3gpk9+dxCi80G6A0z+pKKBj9I06Om
 /Q7p6qCUgZC0cEeP8ODJ66uBFOR1nD6Y+ieJm3mMQtsLi++2+nv4Heed5DMPSWvZVyB7jueHN
 jWQis1Y87kjpurM6VzG3PvQ2OSRT5gutE8cgra+M3m/uUhrTcNd/vn5+RHIm2oRwbQOxmdx8J
 YzW2yt1JswZ3SigNSqYnERomkw0g1WiPwYj7a4V0+/Nezd5i26BxoUP20D9H5vFRPbhYUyc+p
 uHE2kvVQu/MlJ8qOiiUOfB0kEN0pvD/1oL9N8Zbvc63VHIUaSDZo9QI/itFmE/sqNz6of2a9T
 3h43GgZPjIdvTbq+7k7Csx7Sn3aE=

=E2=80=A6
> This patch changes the prototype of request_control to int
=E2=80=A6

You may occasionally put more than 58 characters into text lines
of such a change description.


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n94

Regards,
Markus

