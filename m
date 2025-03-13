Return-Path: <linux-kernel+bounces-559768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6500A5F950
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 16:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA94189FE46
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBA22686B0;
	Thu, 13 Mar 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1vMrWTL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5922612
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878812; cv=none; b=foD4v7nL10XuLXNJkltcqKLM4FBcKY/OAQjajmSXXECbuc+Dn3eChq4odAWem3lYXXIo8yiTXqGMRtWCjSz+ZLwwLWVzovgLEH/y8FygFjNCcYvWUAmJ0ucTyT4piw8qiaronsseelon85LzT9tR76eOfuqNkMzXC1vtyKxeTpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878812; c=relaxed/simple;
	bh=F6KcbIPUgfP6kX1LbBxUFczoKtPUcvCPuPG03lq65CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tYbTAWkshMnd7Cpf6822jRYli1WH42IXkbBw8yUSmuynU7f05GccLc/i6aY8l7+M9vYqHPaH2ii//HcYw2DUYdp51qAJt8yfaVgZMMi2enb7j6MF1QtGaOKZPxkCXjhxaOMtOADTdGBGN+UI6MYwzitGJVMnoVeh3L0STdjtB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1vMrWTL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741878809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f5K4pCCizVTVFaCfJxsbcvtellHTlJx5Au+uaHTpI0k=;
	b=M1vMrWTLrfbmfQ0YZXo+nYq7kaV72K1lfL6rmSINnJEMzJT9NshZUhrJu8o+Bx2tcFkTC8
	PXJjYCygDiOux9T//uT/Qw6GtCbebrPRi4ZkZrXzB7kCdp0pn4ONYHAEo02dTqhqd2gZaT
	UMFhWLvSMqQEx8vRR4XfzqIDi8ULXtA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-efF33m3-O4GxvD8GU3iwYQ-1; Thu, 13 Mar 2025 11:13:27 -0400
X-MC-Unique: efF33m3-O4GxvD8GU3iwYQ-1
X-Mimecast-MFC-AGG-ID: efF33m3-O4GxvD8GU3iwYQ_1741878807
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac218738618so86262766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 08:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878807; x=1742483607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5K4pCCizVTVFaCfJxsbcvtellHTlJx5Au+uaHTpI0k=;
        b=PjXeidIOjGkCm9sKHDCIIdtf6Rvit9THq+Qac37WOm6Hsqq/pnrVYPGRL7b9OpwGR+
         OIywYiPYIK3TfA5U/SweOuPuVQhdUTQvD9WB2JzbhwjkDUSIFghbFlCxGpmWGnKZOHPS
         8S2ClC2sQJi0QuB3VqJu61PJRfHKWDk9JCTOq5BQOp1eIvN20FXqlyYQa75gQg4FwWLE
         y33VFAyVt+WK5GewCfnVUahVQ5RsJoo8nWKBQPW0T673WC7CE3pdE0kTgxbf8T5lrBfM
         J6e4EWI0F9W9SoOnnVDMaMkX3Eya9IMe/LzmkVAm3sXjpRtLcVzEUOvxF/UYvjsObTiv
         1X4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVr1wb7hxuRU0+HmVJqA7tUHqAPpC1xvAVSbmX4MN+I6JDHtvqX5SMFY2tZKh79W4mLwYOHWjCvflmLQwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHxt7ttUn2OLtArMdP94tA82JE9X1gLLuzXhDflvJL4HuG2/xs
	AELDxFZ65BMDJxztg8nkqdJXFiqwC6zU9zGwaCt37+2DT/C7g5wV+zAG/EUDJyM2Wzkch9Jabxy
	//xpnoEw32BxlPibTshLr066I1iL1gYKQPuxSgo+mGmriL5G8f9JmohUxATR2uA==
X-Gm-Gg: ASbGncviDMep/gBOz57mr+AXNa/o0gN1aTGuIHlUC5HO7lWYgvsm+9bw5f9pBoCRZnJ
	9OdRmAJOAmDltjSi0ti1DLh0u1pz2l5cJqiVRnDWWbbZm3K1HhwLQYWkuIm0lSp8e8zI+5B6K2x
	LRYJW3U/Rf2y6b74HC7Se4rTvikW7OFmfg4zeA4AAanbSa6R9kSRfmDswet1/npeVOvdZcBfDhW
	GXcCMdSdPb0Puva4LDIG9+0+Y3CZKYgT9iz4oYOvOf5xSSc00IB5EDg23M+CYmPc0zunzbnpVdI
	OJtxLKckbU1+YMSriRQrjASaiWTod8AC9buvz0O4HPp9sNrSaoSC9EzHflwTyhGb/9/2dAJyn/6
	QNiQzm6pLisNt4rAbq8O+6WJxTNFW9ioryI1nQgZhqHUfKkh5OQ3Q4DnXL3q8M5VpoA==
X-Received: by 2002:a17:906:c381:b0:ac2:ff66:dd68 with SMTP id a640c23a62f3a-ac2ff66e08dmr593616566b.39.1741878806663;
        Thu, 13 Mar 2025 08:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIfef2yMH96c0YIEDZ4YUlcCBGhBwi8aFPWDDZ+VDysqpAUegkeCUPWy1GYkWLR9SUagK39A==
X-Received: by 2002:a17:906:c381:b0:ac2:ff66:dd68 with SMTP id a640c23a62f3a-ac2ff66e08dmr593612466b.39.1741878806264;
        Thu, 13 Mar 2025 08:13:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a40f61sm90305766b.134.2025.03.13.08.13.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:13:25 -0700 (PDT)
Message-ID: <d5470665-4fee-432a-9cb7-fff9813b3e97@redhat.com>
Date: Thu, 13 Mar 2025 16:13:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression from 7627a0edef54 ("ata: ahci: Drop low power policy
 board type") on reboot (but not cold boot)
To: Niklas Cassel <cassel@kernel.org>
Cc: Eric <eric.4.debian@grabatoulnz.fr>,
 Salvatore Bonaccorso <carnil@debian.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@infradead.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Damien Le Moal <dlemoal@kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-ide@vger.kernel.org,
 Dieter Mummenschanz <dmummenschanz@web.de>
References: <8b1cbfd4-6877-48ef-b17d-fc10402efbf7@grabatoulnz.fr>
 <Z8l61Kxss0bdvAQt@ryzen> <Z8l7paeRL9szo0C0@ryzen>
 <689f8224-f118-47f0-8ae0-a7377c6ff386@grabatoulnz.fr>
 <Z8rCF39n5GjTwfjP@ryzen> <9c4a635a-ce9f-4ed9-9605-002947490c61@redhat.com>
 <Z88rtGH39C-S8phk@ryzen> <383d5740-7740-4051-b39a-b8c74b035ec2@redhat.com>
 <Z9BFSM059Wj2cYX5@ryzen> <9ac6e1ab-f2af-4bff-9d50-24df68ca1bb9@redhat.com>
 <Z9LUH2IkwoMElSDg@ryzen>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Z9LUH2IkwoMElSDg@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Niklas,

On 13-Mar-25 1:48 PM, Niklas Cassel wrote:
> Hello Hans,
> 
> On Thu, Mar 13, 2025 at 11:04:13AM +0100, Hans de Goede wrote:
>>
>> I do agree with you that it is a question if this is another bad
>> interaction with Samsung SATA SSDs, or if it is a general ATI SATA
>> controller problem, but see below.
> 
> (snip)
> 
>> Right in the mean time Eric has reported back that the above patch fixes
>> this. Thank you for testing this Eric,
>>
>> One reason why ATA_QUIRK_NO_NCQ_ON_ATI was introduced is because
>> disabling NCQ has severe performance impacts for SSDs, so we did not want
>> to do this for all ATI controllers; or for all Samsung drives. Given that
>> until the recent LPM default change we did not use DIPM on ATI chipsets
>> the above fix IMHO is a good fix, which even keeps the rest of the LPM
>> power-savings.
> 
> One slightly interesting thing was that neither the Maxtor or the Samsung
> drive reported support for Host-Initiated Power Management (HIPM).
> 
> Both drives supported Device-Initiated Power Management (DIPM), and we
> could see that DIPM was enabled on both drives.
> 
> We already know that LPM works on the Samsung drive with an Intel AHCI
> controller. (But since the device does not report support for HIPM, even
> on Intel, only DIPM will be used/enabled.)
> 
> 
>>
>> Right I think it is safe to assume that this is not a Samsung drive problem
>> it is an ATI controller problem. The only question is if this only impacts
>> ATI <-> Samsung SSD combinations or if it is a general issue with ATI
>> controllers. But given the combination of DIPM not having been enabled
>> on these controllers by default anyways, combined with the age of these
>> motherboards (*) I believe that the above patch is a good compromise to
>> fix the regression without needing to wait for more data.
>>
>> Regards,
>>
>> Hans
>>
>> *) And there thus being less users making getting more data hard. And
>> alo meaning not having DIPM will impact only the relatively few remaining
>> users
> 
> I'm still not 100% sure with the best way forward.
> 
> The ATI SATA controller reports that it supports ALPM (i.e. also HIPM).
> It also reports support for slumber and partial, which means that it must
> support both host initiated and device initiated requests to these states.
> (See AHCI spec 3.1.1 - Offset 00h: CAP – HBA Capabilities,
> CAP.PSC and CAP.SSC fields.)
> 
> Considering that DIPM seems to work fine on the Maxtor drive, I guess your
> initial suggestion of a Samsung only quirk which only disables LPM on ATI
> is the best way?

I have no objections against going that route, except that I guess this
should then be something like ATA_QUIRK_NO_DIPM_ON_ATI to not loose the
other LPM modes / savings? AFAIK/IIRC there still is quite some powersaving
to be had without DIPM.

> It seems that ATI and Samsung must have interpreted some spec differently
> from each other, otherwise, I don't understand why this combination
> specificially seems to be so extremely bad, ATI + anything other than
> Samsung, or Samsung + anything other than ATI seems to work.

Yes the most severe problems do seem to come from that specific mix,
although the long list of other ATI controller quirks also shows those
controllers are somewhat finicky.

Regards,

Hans



