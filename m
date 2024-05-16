Return-Path: <linux-kernel+bounces-181634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873ED8C7EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 01:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00EAFB20E28
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 23:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA452C697;
	Thu, 16 May 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YFJAVgjX"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F92AF0F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901680; cv=none; b=TMD2PkIxX+loKPesrhbue/walh6RmEJ0q0wwA/V68dBLdI2wFgh/wUH7wAAZRhPDKbSr8fes0e+CbbexVRIHh2S6ZT6b2TqjqSV3cUL6/sVbbJsEyB289k3pAmkfYf+OZmPw5dGx6/QaDioTbULRRdh0BHjI1b/PMTrTrYbCkgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901680; c=relaxed/simple;
	bh=Qui0DEbevuwNLaQ5JuIVShEJXLfv1M7Yu4u8VZtKVeM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JXNTeSWaLTOgB5Q5a6pD+P41hBqSsrmSJiiR/4EM8tbVLcImN2ghyEgSDx1nhO2DdPA8gktc7ZgB7dXlWCUSGYA0tItZj0a04wB7kCwPwTRjwVqoumfPmMfCj/zEwlH1jVLHEjcXGdyvXECNtwK/JINbdcFbbQQMD83Yd7RtzOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=YFJAVgjX; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so5031509f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715901677; x=1716506477; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp5Q4kFI8X/cmoTJxmxu71qy/umo6wOz6GO12/MOAWM=;
        b=YFJAVgjXgPMDvfKpjas29KRGtjZbCn+OLM/26D1l5/mTYQZCe2frNM/j0j2kfgXGDg
         kIQb79ENVSRdV8A7phKrflSIVQpjXN64OlAxYn1YuRojCWtmIc3I3QbIdhXuPDjwiNJx
         DevigPwXbyHsnU3FSUz0i+9/PyZC+K7KBEIZLB4oHn+pGcfqaYTjlLhFcziDi6N8zpbE
         cRL5WwgKrwalFEtV3uo1UCFPEdbOcqGPq67Tl8SSZcZ8LeVAyO2yBgpG3Rd6ZytkPI5A
         Lf5m6FEVI+9fPFZBpsCBePkKr+JDhj+29gkyjlmVxF4+kx9dstZEOnSlLvMaAdZR7b87
         khYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715901677; x=1716506477;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lp5Q4kFI8X/cmoTJxmxu71qy/umo6wOz6GO12/MOAWM=;
        b=c0eh94O5/35k6jhYGJrtyNg3tk1dNx0MuBhwKLNHHoyXfLulI7HqpDRrVTHxhl4Zl5
         UqiNO6bXdiABoDI2cPJx4BDJIQ7r2rFTDKZ6Pa4sihzDXmCqeaomHeS5eXC8s89QkyFQ
         PZuCJt1IZIKs4RhHxY3vnZhxiJSfBimryvAh8ZeCHszSTMREAnOZz5JQM9XyBq5OB7Tp
         gIBjLS7RxOiVDPK+YVT5E1UggtqNfnnwcHLvQ0Uji8ir9VKvtJCokTBya6p9U9j4d4D1
         GvtYOse6rDAL/eNeWULD8uI8eHGHA+y+3sb8lPmxQcOvEJXX/COnBt4hiklHTWxYvSRS
         6LYA==
X-Forwarded-Encrypted: i=1; AJvYcCWitKwE76Os2tX3omd0YzNalOjQCNJLfBoHdx9PlV519q5iBxl5LrLsVwI0uD8IcSAKZtCzTLUvqXAehEJCjzqQrWyLwGnfUp4pzwlr
X-Gm-Message-State: AOJu0Yx5iuiqqruMERX3l1FBnbdNyFg2z4GO20uw4VywWErovf3oghgw
	/3wHTzZJSM41kvjly1owiGAhKsYL+IYiZ3DDmxG0SdGwwC89eyglang95l6Aggc=
X-Google-Smtp-Source: AGHT+IG/4VDfaLpKv9+Hy9psRkakHJC/Qh+jThNDXbSICnYlct9NikIvzEy+1yhDJ0NQy6xbO4H4Ig==
X-Received: by 2002:a5d:5889:0:b0:352:12ff:2323 with SMTP id ffacd0b85a97d-35212ff240bmr1780438f8f.28.1715901677079;
        Thu, 16 May 2024 16:21:17 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:4c77:13bf:9f9f:140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad1f0sm20293435f8f.89.2024.05.16.16.21.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 16:21:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3] net: smc91x: Fix pointer types
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <f192113c-9aee-47be-85f6-cd19fcb81a5e@lunn.ch>
Date: Fri, 17 May 2024 01:21:04 +0200
Cc: Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>,
 edumazet@google.com,
 glaubitz@physik.fu-berlin.de,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 lkp@intel.com,
 netdev@vger.kernel.org,
 nico@fluxnic.net,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <66AB9A6F-4D24-4033-96B9-E5F2F700029D@toblux.com>
References: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
 <20240516223004.350368-2-thorsten.blum@toblux.com>
 <f192113c-9aee-47be-85f6-cd19fcb81a5e@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 17. May 2024, at 00:51, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, May 17, 2024 at 12:30:05AM +0200, Thorsten Blum wrote:
>> Use void __iomem pointers as parameters for mcf_insw() and =
mcf_outsw()
>> to align with the parameter types of readw() and writew() to fix the
>> following warnings reported by kernel test robot:
>>=20
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void =
[noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void =
[noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void =
[noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void =
*a
>> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void =
[noderef] __iomem *
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: =
https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/=

>> Acked-by: Nicolas Pitre <nico@fluxnic.net>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> Changes in v2:
>> - Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They =
are
>> essentially the same, but using lp->base results in a smaller diff
>> - Remove whitespace only changes as suggested by Andrew Lunn
>> - Preserve Acked-by: Nicolas Pitre tag (please let me know if you
>> somehow disagree with the changes in v2 or v3)
>>=20
>> Changes in v3:
>> - Revert changing the macros as this is unnecessary. Neither the =
types
>>  nor the __iomem attributes get lost across macro boundaries
>> - Preserve Reviewed-by: Andrew Lunn tag (please let me know if you
>>  somehow disagree with the changes in v3)
>=20
> This fixes the warning, but we still have the macro accessing things
> not passed to them. If you are going to brother to fix the warnings,
> it would also be good to fix the bad practice. Please make a patchset
> to do this.

I would prefer to submit another patch to fix the macros. I submitted v3
because the patch description for v2 was wrong (type information or
attributes don't get lost across macro boundaries) and the macro changes
are unnecessary to fix the warnings.

I should never have changed the macros, but after first adding __iomem
to mcf_insw() and mcf_outsw(), I kept getting the same errors and looked
for the problem in the SMC_* macros. I probably didn't do a clean build
or forgot to save my changes and just refactored the macros as a side
effect.

> It would also be good if you read:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Will do.

Thanks,
Thorsten=

