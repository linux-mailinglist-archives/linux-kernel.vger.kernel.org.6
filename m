Return-Path: <linux-kernel+bounces-199625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029258D89AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339161C242EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F9813BAC6;
	Mon,  3 Jun 2024 19:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="J1JsREm1"
Received: from sonic313-21.consmr.mail.ir2.yahoo.com (sonic313-21.consmr.mail.ir2.yahoo.com [77.238.179.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821F13A876
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.179.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717441825; cv=none; b=fGfqEm4wBfr8rSXulLrRZN/H6rEWVyhvJpi2QntH+RSmuFmwa8Y2BXPk9uKDh6fKBs3KZui4fj2ezEBe5wK93n5aCnbvVC1M1wD69GooeLDuXaEl88w7+/lVwoNCC9VgVwx8Ulfvp8XrccFQZl0hZ+gUIQGIeYkekstmOs0EyMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717441825; c=relaxed/simple;
	bh=KPYkAqhmju7XsyzBTxmcRoWn5S92tOqYTNT7Zf42wUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NLIdMqIoqS0+zCCZcynXvAsl+ATLAQ6OisBtG7oT005Ifq7TGyw1CkuA50+9/CA4UhyIiDYPt/mzA3VGD0wlo+jt0wkMCSigRyq3XRNq7iU+510x4ZEVmWUs9xZvo666r6XezhHq/RIRRixTogcJqk5anZcMlPy6rK3/A+kyKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de; spf=pass smtp.mailfrom=yahoo.de; dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b=J1JsREm1; arc=none smtp.client-ip=77.238.179.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048; t=1717441816; bh=edWCNicz5SLkhidXgXtdvBzRygTru67Exq0izoAmB5E=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=J1JsREm1GMQyjSBjtQPGnapUvJYCq2JZfCXRXdfBJ1dJRQaxMgDD9ZQreCpnZFN8KjYxupZOFgY8b6ju/GnctuTNW+Ke5xKhIzSlFUvd6kQRWBuF55ZoGAzkbdx1/5S4loUdNlrjauTZRYieE0ugbYbqJpa+gqNGFY0n9zhFSknDGI36IFKNsRwrjUrX5nu7VpDbtoel3DgDhR7xsBZXyYsTI/gl9G78oX9H1tZtGT08sYg+yWjXaMtCW1jEFficU7ke7FEf7IJX+mU85ZqtV43xuy3wgxLP2QqValdES2VShCuYT+02DYQIbrPS4KYiFx5W/d1EBdOHBL0ruhSczw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1717441816; bh=HLLzKbN86DMWAOiWBMzfwvF233zZVKaahPOtp3NrJ2l=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=O3gxnjEk528WBpcvGNkUp+l0J4TaTDaWUZL20MhwoI+/IIDXzUQC5T7kK2kvSEHlj8U/VH6dfyt4fvMbQazRIstgzCHZfVB6pi9K9E43kLpIhgRIbj/NcD2cZwcQUX0nhl6ndiU8MTodkksB7Mnje/cW+dEH8z4kiLerW36evjo6NnDRgH/Eo0L/uEub/LoMXlGOu5sG7MeodlrkSknuUghuKXqanONJiS/eQmjMmjYHrjR7tjlGdGAXNpidUXVpYZnXcnpyljOQkFMDlrvBQKlbZ9lPGPGAmCA7z9oVe81MFu6W+e48qav5c/fG74QYJHbVqH5crZm34WGdEpqvFA==
X-YMail-OSG: RRRAq.cVM1n6crMbCT.spnjMTieSo.tt0qvtB4AOa0lp934HpKZRmcMBUd.S_Fs
 pqKphfUtzKyDdzA0YyYE_2_O5wds9gfEJHib7hAywVMfMKFSIYpdBpb9khpv0e0n.0UEnoPCdBhv
 O3wF1k7a7OzlcFMzX84f_cAo56wUB92GVfIeXQSWK9KSewfWkTE2Fadgap0U93tlS_ONLoqOldOa
 QNkeTZDtXt2cMCoZJP.be62Hm4fjUlCbxIpvkuo6FPXlbv7PyIZAbklVazvfFTW9JPAku1Nllhdh
 OaBDpvdiqdgZM7NjZeiWKNFOWDah2Xcurs2qLEbGPAK8.jD8wfSIkjPOHj00c8yepEQowSgPi_MW
 vBUlcUBLj5Oa5DCYwNg7KZb.6uyTBh1mDz14pv.gb9sp9OaYbLHMKGcikhLextuU0sfe9rvLP0Si
 _6SFGmQ7UwNqTK2YdjOJR62CQF3W5TnqYpJdKc0eyoHdGKwkFCrxpMiZTJ7hAbBvw2iETrABl8hr
 tvADER.UGLaUsf47f70aclGO7w1cAz7sngtu5tq.THxK2fyX8_PrXb2fKVHogj4JnXCuzokj8bI7
 7RJ56L82la.HeIumagtCCEf06xQ1HTyY1HmWivB_UWqDcSH9twW4awJim9pDZpbE2F.itilM3wr9
 e6HMUjnEcglfYUrKgQcdnUTw.cuwAztFaBu5c9HrpI3YJNQ3sySn4YvUMR7cbZKkm_JbVz9gz0kG
 FCTOT47xmaSw7y_HWcbgQqg0H94d5gTh0eAd5TeR6RVqHJm6fBvz7Yh3dt0e9bMwxR3ly_ambSPk
 7vnJHa9Ycg79VMdy2yGRKtBY2b9YQ3KgAMD0zn5VaR7xpD5ct3dN0_tYiv_Xgj6_TmZ41JU88ept
 3O3_R8MzeohgmAQ6jiBh_4LsuQVRCly5ZQzLLUkiUxNpNWbXhy0uhGde01.IsrRKL498bIUWTotK
 hlazkSrXHiISCeeDIC73LnFLwfWtHU.GHSsz30_Yp0dBoSqIxjKu32Y.jfQ.f2BNNPZmizE86FQf
 E..nYeW__tvIDYDiPv474VlxieQvJ260emljUo2DqB3Ehh13kUbBFnH7S4Zar5N10CUiY2QWl6jx
 fRRtKL6MjBopYdy46jpc43pOHvyuHFZv06J_e2Dbz4gGJ3sQSXywrcPBzcM_BDQeocn7rGUxpJnA
 B763QKOGlvPgTaYQmZiQWMxJB6QCNKG1k71265Unc33l.RYiu50HoFVlycBlID1rALmHvjKeLht5
 mMvvcV6pGOzDgHihvoUHiGR.wESEDOYKEzOzJt39H3i41vcR0zXxDY3dQ9Sgqia_6p8eON4ZA9eG
 Y.xx9baR.EFAS3HxTPaPq.0RFkxvGNHh5ZNv1r4GA6QeadYTdwTZr8SngRzw6P3r8a8MaLjcMNDi
 uVoCDx0BpKfk7CEFCupCJK8X2VjhNDTmpAdBE_zUMNdZ46QawukiKtVfATKS0vkVwADWcylZSdt_
 BxkLBol9tx3RWMuGNo7RNG7l9HPou49C3TbuIPNvrVgpZs4qn6_Hgbabmr.nOuJbqqzY5kbvMM2z
 DzkJ0HaQlz.wWfVfiU781crKod9984S8_eFAdaJKfrbBVpsbT02LInBFo3CaqQRYDwanjuVQrLJd
 f05E3qei4DnL.gKzlDsOdnh6WYH7kcXDAZB2nWd6Ty2nwK32ZKUD_keGuayhfvYFp72NSGNi_oki
 SD3npZa3yqP_1Lu8gKP_JajAa7F5zxjNvRnaaqY8T51weOQCTmUWNjI17FbCw.8js1DDbbkmuZeB
 SBWIfhzCESrYtg0Dl7zsW2hAH.SULdOxKK5Y55LlC7Va8qN1SNlWgOX44We9bxI3POXeJMu4M03j
 WeVYwgz3QKr5AGFHW.CKI19r.40xMIVC.Tv6fVWsdbThv6.kBB585UxEg4adCdTqO2WCAaeGRwPF
 tVcCtT6J.iZLb2OPLkA9tzg4e1XBa1h2jjInP_fTMUtC3ib5hhjnA8P2Chk9GQztEjJKAab6JlIv
 sixBpNiOvdzL3nxgrJ8as0Wzhc5WGHSRtzeGuF2OqizEUjqtbnL989FBQ8ealhkUvLgmrKoEv8zQ
 qC7ktR51sFka5I7Bmqohewtn51_zL5u4q57FahRZGq6yj54y6Mqu0yVWpWa_0v4pjIDAqPu9c5LC
 HfQ6wPD2pV7geth9K5w5.pfbloEKJzoPdxBqjxruAwMGAlVeVBUdIABkQDeyDMsQL18zmdRk7gLA
 QMb7xc0jYZBMBF2L3sAgZALgqeBuxzBr47wEvxPa_Z1_SHiO9LXUzluhM3AHm
X-Sonic-MF: <fhortner@yahoo.de>
X-Sonic-ID: 83e29caa-1270-46e0-bf41-7b4f52bbe70c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ir2.yahoo.com with HTTP; Mon, 3 Jun 2024 19:10:16 +0000
Received: by hermes--production-ir2-7b99fc9bb6-z99rq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID abd44bd1c36a5049a30287d79d773928;
          Mon, 03 Jun 2024 18:49:57 +0000 (UTC)
Message-ID: <829c478d-f547-4e12-9976-ed465dd8d4ed@yahoo.de>
Date: Mon, 3 Jun 2024 20:49:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression, thermal: core: battery reading wrong after wake from
 S3 [Was: Bug Report according to thermal_core.c]
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <1051df4c-067f-455e-8c7f-9dc47dc8ed00@yahoo.de>
 <7f4a777b-88f6-4429-b168-d1337d291386@yahoo.de>
 <435867b5-029b-419f-bb7f-2d4902c62556@leemhuis.info>
 <a97f9f4d-17f1-44cf-a0f4-634fd38aba2a@yahoo.de>
 <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
From: "fhortner@yahoo.de" <fhortner@yahoo.de>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jwvq6W0u7Zx4GzQxJOnrF4KvN1RHtqqDcaMvN6yp0hDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22407 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

I Totally agree, this was also my first thought, what has the battery 
state to do with thermals.
But at least, so far, we have in total three repros confirmed in the bug 
report. All of the same machine.
Thinkpad X1 Xtreme Gen2 = Thinkpad P1 Gen2. The only difference is the 
graphics Nvidia Geforce vs Nvidia Quadro

these are the types of thermal zones:

cat /sys/class/thermal/thermal_zone*/type
acpitz
SEN6
SEN7
SEN8
SEN9
SENA
SENB
SENC
SEND
x86_pkg_temp
iwlwifi_1
INT3400 Thermal
SEN1
SEN2
pch_cannonlake
SEN3
SEN0
B0D4
SEN4
SEN5


Am 03.06.24 um 20:38 schrieb Rafael J. Wysocki:
> On Thu, May 30, 2024 at 1:10 PM fhortner@yahoo.de <fhortner@yahoo.de> wrote:
>> Thanks Thorsten for the side note.
>>
>> I have compiled kernel 6.8.11 with reverted commit
>> 5a5efdaffda5d23717d9117cf36cda9eafcf2fae.
>>
>> Battery Status works fine now with reverted commit after S3 Sleep and
>> Wake cycles.
> Well, the connection between the battery status and the resume of
> thermal zones is somewhat unclear to me at the moment.
>
> Most likely, the commit in question changes the timing of system
> resume which affects the battery behavior and it seems to be related
> to the EC somehow.
>
> Let's first see what thermal zones there are on your system, so please
> send the output of
>
> $ cat /sys/class/thermal/thermal_zone*/type


