Return-Path: <linux-kernel+bounces-207783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9D901C12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F03C0281DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7804A2EAF9;
	Mon, 10 Jun 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fF5w3FRB"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E1B1CD15
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718005697; cv=none; b=PwqCsh0efs1hEn2m0BTkgOnQsg9t7g9UxPOsr+OTF59MPD92rolGQFTrGgy5yWHp7xIP51tsOl/n/By3SLSZM1z3rLycGJyiGV0jKQ00Ac23K4pQgOkOa1JxjVvoUWRgiXVvoZhjMxp+5P+4g+WptKH4iRQqjHAqj/8VmsFbOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718005697; c=relaxed/simple;
	bh=yIFJhJlqUEmhDJ796KYs+GXtVDOefUkAE15z5R9Yo5Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KyLtTv86o7GUU3lnf8woM/o0IWW1oLcGbPgbUkMqIcFr2xMRa61sai54MAK0Xec9NTYaeCTNMyYZEIhrXRjQl9jk6lNX0GYWFPDC31limqGqBC9jKsTEwNKMrl+J0lkCi2aGtV9CNLJNE/SzcFYw3fSBfND6oj+htKb0bBajVxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fF5w3FRB; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718005691; x=1718610491; i=markus.elfring@web.de;
	bh=9dz+LpUwqzpAR1PcrgVqI/vrt3YGcppl4SfjD+L/sbQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fF5w3FRBdUeCTc/MyZk9lQbjdSu33hPAQgWsWIk6QaT9vZd2/1SSxFna1b/1bd/n
	 OXNaMwFlpSutwLnlA9k2RKsxvwobgJPP+gIgsyY0sJPGth4ZlAMgZtzGUcYPlkGOy
	 04Nx8tBkm6b2IFPlmLZdtbf6pCS9ikl3jHoWe48Xdb4PDvafHLsJREk+TF7QBDLfa
	 GqpxYsRb0UIM91h8IFYFrc+XZIuKPpcxVO0BxUthQ4VH0qwyC4oN8PWByYFF6s+lp
	 R6OcJBIdF2TO728OpE2CwrBpdmaxLAK1HOmNh/lhvj9TxLVMSMjNwEQCEMsHdLrl/
	 QI2Y1fVdY5DZxY9H0w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8Vop-1sTxjW20fJ-00xUce; Mon, 10
 Jun 2024 09:48:11 +0200
Message-ID: <0485dd2d-488a-40e9-b0f7-24236b9c00ab@web.de>
Date: Mon, 10 Jun 2024 09:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org,
 Evgeniy Dushistov <dushistov@mail.ru>, Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240610034219.14711-1-luis.hernandez093@gmail.com>
Subject: Re: [PATCH] fs/ufs: Use LUT for dir entry types
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240610034219.14711-1-luis.hernandez093@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9EpwbBoA8M65Cv2LAnjdv99MJe5RQMoHiyf5Cqk6SK1M0h53dTL
 kcz45yHLWYfYKEm9ANT+hiM2WAgSse68YAJ2iHvAR/GFB8SOQRkGcmDk3D0xrhF5O+qQXeU
 7QfJ2MloBtVDrzUt+vhifRWk8PQbpdVyGaPXipgCloKBlPgozRB6R0IAdeLDrnrRSPIrsBl
 2u1ExIp/WpLDZD/wgADyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gC+qJnmT3NE=;ll/oDAQ/T5aRm8uQIdaUKQ4+4P2
 y+UYtArfCJumn/pmr+295KNbK1yhk8hl3ZgGC+bWtMzhp2zmm6+rLua6o3jhuqMX+T3CIoAX+
 m7nN7SEOZbPRNORrJKvpkOToF9mbqwnxIVX6BWh34Vqxp4BX7dne4L9JKCD1qklPZwPTAXJAv
 j6C7EqJzl6pEPQiV2/dc17LYA1NsnnZu9fmzwUPYi/FRTmOwTb8tj00X2v6m183VuUN/2tYOr
 YNTalgWKai3KwHbT8RYsLwmGtSMry1BupubGTWp6NSFIcF9N62SEWqJ/m2rT2j0XhnhaDwSpD
 jHKV+KrpXzqtSCYk1x0PpLlEX9U0S1o+Xk+x/teZxel6/h0vEbCFXMY53lE6cIiT4WfwYt5nY
 XcZVWhOrgBPtWuKk+AWZbT7Q1lo73lOU1w0nvKKacqp6kcgqM1s1m0ZwuNn9MCNd4hFjWAFqa
 tmjclvISFfWbumTppkab2KzRp/W03fI0rLZx5ToAK0qvPMcbUS9SpOMWgBnEzc7floM+7dooP
 OXjLinSZM2C64Q5SxhpTxbnOkZq9nilOXawSQVWfC+fDrCoVQ2tx4jsx4Oh25m/XpgX6oSCpx
 gsDE/xJRKj2Tbhc7zwZEuFPAQnaY3tJj3jIMVpvwXD31kayJy5Wp3a7YI5RJje6O9iw50nhq7
 ecBrwUP7b/yabmFA8UfQ9HjPm6rGGxJkvyUsUbcWHUPF2oJke18DTKSlOzRC5Kvr6ahG0vCUw
 9V5IK6i4GCdqmuLaUFhlpzOzvZn5WeCyMa3d/Y6vnLmef+/Jkcgdqz6DYpTtZZV3o9mnROfgr
 rS2c7PMcPgcdYPQyquofasCRbVZYyp1GonUA48dkRuPSw=

> As per the original TODO, replacing the switch statement with a lookup
> table results in more concise mapping logic and improved performance.
=E2=80=A6

Can imperative wordings be relevant for another improved change descriptio=
n?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc2#n94


=E2=80=A6
> +++ b/fs/ufs/util.h
=E2=80=A6
>  static inline void
>  ufs_set_de_type(struct super_block *sb, struct ufs_dir_entry *de, int m=
ode)
=E2=80=A6
> +	if (mode_index < ARRAY_SIZE(ufs_mode_to_dt))
> +		de->d_u.d_44.d_type =3D ufs_mode_to_dt[mode_index];
> +	else
>  		de->d_u.d_44.d_type =3D DT_UNKNOWN;
=E2=80=A6

May a conditional operator expression be applied at this source code place=
?

Regards,
Markus

