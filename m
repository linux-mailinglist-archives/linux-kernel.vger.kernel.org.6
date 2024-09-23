Return-Path: <linux-kernel+bounces-329685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891119794B4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19FAB2239E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 06:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862522334;
	Sun, 15 Sep 2024 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R+xzG2YJ"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C6200DE;
	Sun, 15 Sep 2024 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726380505; cv=none; b=nZjMJZcsOe6QtWyPJgotNO03opgEyRkL4zDYonO74b3wdGCtEQRHMMeQEAOf88B463aA2Zznh0VJMFSDCcwoZ3gBbVfr5ub3AYPGDPMlhBGOnmWH8/BvEUfqIvvecJNmnfrStZSt568Cmn3OIz54HVNDHhRrfsw1FdVasHf75T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726380505; c=relaxed/simple;
	bh=L3eJl6CdvysS8D+2/c8wFT9mytYLO1s6eBj3mjV8OjQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K/o2jnc1RQ5XV9ieZlJI8VilIGi0vFtxmEKipZfK84A5qcppK9ajtD3sfke6EDsKS7IDmcfLush7etwwu1duGTsKRl8TCugVZQggsssQr2+ZRIDgx+lrboJmhCv7Ubvt7CCsD/BLh6+momepLd1pp3KMagvo3wGbPf/qljQZ7As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R+xzG2YJ; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48F67bol080272;
	Sun, 15 Sep 2024 01:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726380457;
	bh=6R4bT4eG+pR13vlD+1lb47ZNgfISERBM6UKaIOkTBQ8=;
	h=From:To:CC:Subject:In-Reply-To:References:Date;
	b=R+xzG2YJQndSEIKqNk3CDItHvOpmLqJwxfZPPp9/2IYsRgKG45vAJhe2iI/fY1WzU
	 ldddRPjr2ogRkRtAjrvsN4+AI/l/7a5dHoEJV55BMDcZipUd7dH93lyIzAgBIMqP8b
	 Yt2/mSX6+2i8tf7HXiNblUOjJsJIFdklMZmIA9oc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48F67b6q020473
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 15 Sep 2024 01:07:37 -0500
Received: from flwvowa01.ent.ti.com (10.64.41.90) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 15
 Sep 2024 01:07:37 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by flwvowa01.ent.ti.com
 (10.64.41.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Sun, 15 Sep
 2024 01:07:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 15 Sep 2024 01:07:37 -0500
Received: from localhost (kamlesh.dhcp.ti.com [172.24.227.123])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48F67a7E048692;
	Sun, 15 Sep 2024 01:07:36 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Danny Tsen <dtsen@linux.ibm.com>, <linux-crypto@vger.kernel.org>
CC: <herbert@gondor.apana.org.au>, <leitao@debian.org>, <nayna@linux.ibm.com>,
        <appro@cryptogams.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <ltcgcw@linux.vnet.ibm.com>,
        <dtsen@us.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/1] crypto: Fix data mismatch over ipsec tunnel
 encrypted/decrypted with ppc64le AES/GCM module.
In-Reply-To: <83a1ce2f-c633-42cb-92c6-2477cd2e47f2@linux.ibm.com>
References: <20240912174537.1409567-1-dtsen@linux.ibm.com>
 <87seu4qmv6.fsf@mail.lhotse>
 <875xr0m5ss.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <83a1ce2f-c633-42cb-92c6-2477cd2e47f2@linux.ibm.com>
Date: Sun, 15 Sep 2024 11:37:35 +0530
Message-ID: <8734m1mouw.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Danny Tsen <dtsen@linux.ibm.com> writes:

> Yes, checkpath was run.

As you're splitting the patches anyways, this may not be
needed anymore, but below is guideline for subject line.

https://docs.kernel.org/process/submitting-patches.html

"For these reasons, the summary must be no more than 70-75 characters,
and it must describe both what the patch changes, as well as why the
patch might be necessary.
It is challenging to be both succinct and descriptive, but that is what
a well-written summary should do."

I guess check patch is not checking that.

Also avoid top posting,

Read "Use trimmed interleaved replies in email discussions" from above
document.

Kamlesh

>
> Not sure what you mean by "some indentation changes.(This can't go with 
> fixes patch, will just add the noise)"
>
> Thanks.
>
...
>>> As this is a bug fix it should have a Fixes: tag, and probably a stable
>>> Cc as well.
>>>
>>> But that diffstat is really large for a bug fix. Is there no way to fix
>>> the issue in a smaller patch? Even if that is just disabling the feature
>>> until it can be fixed in subsequent commits?
>>>
>>> cheers
>> The commit message says "The fix is to register algs as SIMD modules"
>>
>> and
>>
>> "A new module rfc4106(gcm(aes)) is also added."
>>
>> and I also see some indentation changes.(This can't go with fixes patch,
>> will just add the noise)
>>
>> Would suggest to break the patch in three.
>>
>> I see a big subject line, have you ran the checkpatch?
>>
>> Kamlesh
>>

