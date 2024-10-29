Return-Path: <linux-kernel+bounces-387564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B347F9B52F9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7254D284587
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541042076D5;
	Tue, 29 Oct 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aXimRinc"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1A2076A9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 19:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231367; cv=none; b=gcaHzVW68+PVkjNRPiIrcio7IJCKpw6tRb3V+PbI0jTBAqZf4bluvbvos/cwYuz/U/QdFg76W2uW5qDLN0uMoCmJky2kkNtYXMZ7kyVIg0hr6niOxL71stRuk8Kq2RMBhlg9H0NmqmZYRTY+ecE+gOqvJ1NHlMcERTi///cMqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231367; c=relaxed/simple;
	bh=Z8xb9xhDS6y7WP/ezrtNXh14jHanRgt0ZT397g/iMNw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Pu8rpkrcVZPAI9mwCGUyMAvFqIqikY6LJRuj0PEQtnHETqqf+ZOL7nguFyFEhhm6Z7Sfv0295wMGsVqbDbFTLTsOzaiHMt8KpDP7jlc9PN5zEpaFJd/05AZpUIlI94SyNKxASznRbCbAGv8LxXirufhLYgSSazEId9iBhzJPNAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aXimRinc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730231360; x=1730836160; i=markus.elfring@web.de;
	bh=KVa6sUoEsISVLJqp9YsSnJ2+WbranhY7bY8+FHwY44g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aXimRincFyn0PlgowV7FNHByhEhkYIXLOUdGYARKCj90/EwuDo1QfYsfTZK032WL
	 DD9LHTe57bjutJdEMBWa6ANusXGrxS7hAO0Mujn9HTOt18Dk3fP+VQszNaGHlXh0R
	 7uIrNhJeuOcui2tL1QRFuNhlfJKIffWP8kF+s1+6ZJrd3qN1w9/6ZcTOe0dDSgSYd
	 hHRUzbkIdkLrAdqhtUalH9I76QleZj19iMN19fuuiLTtm+kjwkCVpjSQJUiaFVIVA
	 kx6ZtRKpSz7O2H2PNMtNqUdhM6C/BTldt2RKWKf8fIaMIeAOB67OSJl09btIOZ/Ia
	 l2lJbYmkR+k+uzh9GQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNORC-1tUf2q1qyA-00QntE; Tue, 29
 Oct 2024 20:43:42 +0100
Message-ID: <58a77f5d-74a1-4ea2-942e-a352f30f66bd@web.de>
Date: Tue, 29 Oct 2024 20:43:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Huafei <lihuafei1@huawei.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 David Airlie <airlied@gmail.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: LKML <linux-kernel@vger.kernel.org>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 Pratap Nirujogi <Pratap.Nirujogi@amd.com>, Tim Huang <Tim.Huang@amd.com>,
 Victor Lu <victorchengchi.lu@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
References: <20241029202758.2764535-1-lihuafei1@huawei.com>
Subject: Re: [PATCH v3] drm/amdgpu: Fix the memory allocation issue in
 amdgpu_discovery_get_nps_info()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241029202758.2764535-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1eb1mV/sniekV3cSxKRVEOdxvIGkwE3QOfs5C6TbZLC6LbNAORa
 npSbXL1ta54UfT/tJNlaAU7eceDkl2BOSVQszkTX0QzOpY299Uejg0csBbz9Q9oarjvZILm
 rg/OpEwzNhIyXbR4DJtJcYZ/2Pk+RT06aTl8wbqtFMpq2q+bEN8ic49EbISdHBrrzwB83L0
 1ftm2HB80Bxp2+nVLxT2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VBWmokV05Og=;7saiEzx3dBT5lo9PdehhJBMSDfo
 KkXuROz4Y80mL5YMSFi4lqorDsZ9W0A+NWYkU5GbQYvD7YzhY1YzonLtAi3p5rAbaTIW9PP14
 pSqwiXSCQmE3lWzxkl5bgqSTU8OUGqyZ/MXTyaQJpnTxaQlW5nqEQB6ZZDN++3Nev++od1AyM
 1FQMD1EAkwETFC71ImMjY7dqYOpP3MQiCLFKttOeXrJX2BUtEwm7h3UFXfKdmUs/Amu5ujOq3
 Q+ETQd8jU9aWwFDl1bFOTQNhw8qF+mU4Sqn0PdmXpctm8M6C/30tyTMcdyTg/4EmPBtwlcbMV
 oRBVpl7ibvf8rSlMYPmNODOXwlYXaTUleDFNlbxLD+mgEm2qCiYWrYFe21uB4hlytHXPBIjLt
 mTipHVnbZNPEeJwMzDcg069378pFWIWADH6D7WanpYHmi1XdRnUg4CyXIAZsxOOya8JW+NyQ8
 D2O/y6iSjWXxG/4tAGCGPLYQdrWgi+jXhhSJWQzCJbEidCf7lsSVYTGDHpNeh/6lf/qgvGJp+
 9FYmgI/mHAeq9LKSgBqbpEKYCOV1KzddZpoQUReBECTMsTYdgcR96RnmOc1++MM2I7SwPyocM
 WbV9z7scmApGDa7JAqC32bSLmOZGaCLUuIdxrq2uShMIPEuXPp4cToqL4UkS9c7Qd10ccJ1YR
 hoosGl/DVvqTwN9m3MUNjJlDzCVvNZAUrmQ1j0vGMBJBivz0+XItZjXJtUK6UFOHR5banmYA2
 VTgbygXqvNnWS4n2wx+/5nAxcHAfSE7DjfQy6bcsKdbiCuJB9al7OqDvev9oop5dwsFdJFG+V
 5EPbJ42idniKqT53xTh7ecSw==

=E2=80=A6
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_=
device *adev,
>
>  	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>  	case 1:
> +		mem_ranges =3D kvcalloc(nps_info->v1.count,
> +				      sizeof(struct amdgpu_gmc_memrange),
> +				      GFP_KERNEL);
=E2=80=A6

Can the specification =E2=80=9Csizeof(*mem_ranges)=E2=80=9D be more approp=
riate here?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.12-rc5#n941

Regards,
Markus

