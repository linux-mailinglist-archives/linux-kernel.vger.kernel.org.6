Return-Path: <linux-kernel+bounces-231188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929C91874F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ECC1C22203
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39FA18F2CC;
	Wed, 26 Jun 2024 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BUopx4bm"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF818E748
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719419177; cv=none; b=mYH9sNg/zLlxo+/qJdJrx2SThzYCplYOncDN6Ta1agHa6JfJiT2WNZtUwWvF0rjDzcXU5LzgRn8arQr7Big5e0AFqaY0lZL+f1tjeWz+pvB5ljCmdGCNhUZ6GsPTn396T7YXlWhkgDheMZtOnDkZoxeo4CkGoPNzi3jBTGoyo+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719419177; c=relaxed/simple;
	bh=4GMKS9rjKVAuKs90LIE7Nud9qV5fRXEVtDwhzxNSU4I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QbRWeUG3X7wdw3F42wo90gfYho4eFoqMsZHiZtlEIvhGHsprtIngDhfLpbp4m1Mi0Mwhu8600ToUFdEjClZyROmbHJ3+r/xuuw41vlXZkSXSVTbfGm67x2dpOl7lRSVtDF36mx53Qo3T9UlAP0zGeqmUSM9T2Llq6Vkk31+rNt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BUopx4bm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719419156; x=1720023956; i=markus.elfring@web.de;
	bh=+BOJNdTWEc0DoeEIadfvO9hcM5W1C0uZqLmVuEgings=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BUopx4bm5LepcSY9IGuR2p7li7I8+ZvtMbKcbPkK24fKoOGXW7RRR4WDEKvKEI3K
	 3Bz/P/EO4IWVje5Y7d0cjg95elb2TI1JDeDVQ5BydMtlUkzLAlH7/+8g+wUIuBRd0
	 EduNZrAi/1lt96GkBBQGGYvjkjtaEaqY59W+MWww6qr8o1OCvE9DLW06A+FrHtbXI
	 XSFgHSH70p9jwP+ILpkrlsuR92Jvgo+VikjANgHKiZzO7rAa6RpMfCIx59mAvzrob
	 3hVmGHuotkix2FUk3Urx4Uz/w/tlVktXnvpSTF5h5eTJsd1iXAUXobRPKAri3k32m
	 ahvdxqkLEzy4+3zk4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGgJK-1s9uYI0kEM-0070K0; Wed, 26
 Jun 2024 18:25:56 +0200
Message-ID: <a8470f92-8059-46b3-b50d-5ed776d5b087@web.de>
Date: Wed, 26 Jun 2024 18:25:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stylon Wang <stylon.wang@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240626130650.2866706-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/amd/display: Add null check before access structs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240626130650.2866706-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hW5T3ytNJy84MW/WoW5rqy1HSSQrjRdA2CQImSwGMFGq+ssNq1U
 2KmdBKYZeF+wxg9l+M2L/2jHW5jC5t+/lswua/aMyCTz9p2rh8pAlhkiYmFyXUnnOzIzO+n
 EqqNO3rgp/TM9HvF3VEe0xF6RNO7J7QVEjCVn2urM4xiJfVlXb6Hr4r/bnGKQRYEgQ/lu43
 7WoEaxsY/oaV3nNnEDWhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BrK4kecaDD8=;x68V+m7KY51k84B+tcqQPLPp5Z/
 02focIqKuCbb14UU9GVSNkg4W0t/t8tKvY2jkL6Mzh3HIBeI5Rkl0m3cwCEKuCqcCgyLoy1Ny
 b5ciZCTEVHM56RKL/1o8Xe8maOPzwYtpWA9EPcb3cvx1MBowLlgYChSjz9VZLbL9s2IHBKxOi
 ZgABaH+zEQ/w/4avT64YEZAU3if2MsivhbfhD5YdM8cMMsWJv5wyHsBTTONawFTXj7CojnjFC
 yY8QA2iZTjeKuLDqppGfzutKJ9M+uPxvD66mKbXAcCh7gBx1kCUgt9QuhLvrbeohFpBJhwAYI
 3I9sfHjQFexgRX4PBIzYdtrg87X9eZHPrU5olO0bwKzeaPYeb/rHsLms257vzy+2YJqzERpzO
 jlq2HwU1uVYia9H1FWTJKrd7osYOYUpg8mSZbyGu8Q/lbR+YaoXdRLKT026iX1+Mhiz/NWyqA
 NPE1hfyN/cBH+DStzuXk0VmcVKTrmdjyjGBqU5mze0F49u8C5UoouniI21U90O26cMv+PcYRq
 b34XFj6f0ZuUq60BpCO3sLJnH15XmU8nxHog8D0KPEkewD5vDdAXaHxV5BnCs7hJuGAqp5jCP
 d5m5iC22zZFRkOvlc0xvp+EidS9CPJDCQ87RsWkFMvplV0zbtd3yChdnotxPIY7SiIuN0rZAw
 lN6MxRh6xEgqjTHSxu5wRWA/IwpI8BU0WKSrECVUYgXARhiqTHGd7LRMCSwtOb9ZlreN5vF/K
 E/nGZBT6IvPWdr9VyBFoJ+f5JCAosy7bf5OrYgMRR/21IxDoSl7ieVAI3Rf+Su+nZI4Oe+RHo
 QgVfioky/3erOihTVwCE+bNVhpCxbVClqx2n69vtaOEys=

> In enable_phantom_plane, we should better check null pointer before
> accessing various structs.

1. Can a wording approach (like the following) be a better change descript=
ion?
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.10-rc5#n45

   A null pointer is stored in the local variable =E2=80=9Cphantom_plane=
=E2=80=9D after a call
   of the function =E2=80=9Ccreate_phantom_plane=E2=80=9D (as a data struc=
ture menber) failed.
   This pointer was used in subsequent statements where an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


2. How do you think about to use a summary phrase like
   =E2=80=9CPrevent null pointer dereference in enable_phantom_plane()=E2=
=80=9D?

Regards,
Markus

