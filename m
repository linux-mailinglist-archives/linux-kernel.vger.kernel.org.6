Return-Path: <linux-kernel+bounces-211243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF4C904EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFCF2812C4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77FE16D9CF;
	Wed, 12 Jun 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIRt93KF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5981022F03
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183731; cv=none; b=hqdIm4xvW/euQdLRM3Gb18HQQjf5sr02zw/8wQaUjRgtfk9CWzbhBlc6DY99w0qvOSE+bdI4p9eCtIUlHdsxU8HgIZiwSGfrCmKFptmfzp589ZrKmX6h3VspDHvQkI5wOr1oBYwScNfPRMJQhNbfhu20V1zSTvjLG7kzeZWwF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183731; c=relaxed/simple;
	bh=ZZLDZGrsXleuFBc4RsExldckDr+PAkGbC1Cmc2bDEB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfKhMClHsIvY74xyoPWZa4unqgDMOQhk7tvpp3DISSxVsigJJ314QobZEkdpKpz9yX/IzZn6hDo4/a8jvvAu6HU8vEjtBbrTSQWPtM7nGou9huSxsSgJiN9D+G2dzafqATPKbApKwSMMYaw2NslFDafbiWzB/OYoip5j1P2NXKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIRt93KF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718183729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=un8SRk1QK3gh73P062VSrSrJKKXRnZBfCkdy6o8Wkfg=;
	b=gIRt93KFx2i0XCm+L8zMKHuXL6HrCpzHFHb73tBciPEoJNO2CS38Paeftb82QFDB0vmafm
	VyumD6ZUo3HkPpoH9EAv0fX/ZXw2mdaeq3ktJL4LJ6mehOUdZrnwf9ppQe8FGcRWjCmAge
	2pzsX1AKazTCZUVix4/LA+vb62V6V68=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-v37eu0aJP1ehX3_e7sDAAA-1; Wed, 12 Jun 2024 05:15:27 -0400
X-MC-Unique: v37eu0aJP1ehX3_e7sDAAA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2d6d44becso1363166a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 02:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718183726; x=1718788526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=un8SRk1QK3gh73P062VSrSrJKKXRnZBfCkdy6o8Wkfg=;
        b=YtV1imE//yPVOY6UIpNHlGEz79Q+PVRiIa/Su65VieJtbik6AP/spqGTnR0XEgSGvc
         hEUjmfxOr9D3VYwMtS0F9QlTEsnsN2Y0jxIqbZmkmjGentbvI/1B/aH7UD2GQ3ma6OX1
         bW8+DmLBA6Dz/dRGMZrZT0/PBRDevcDUYhTxtP7wH2ZZhhCyB2UnoXumnV6lqmTudlur
         ASnIfHXct/J0cMgCa4dFQhCOvpIsaNH/wL5gIqrropqC6ovuofQGrJt20s8ZqZal1Tfe
         WeXm6/zgMlZmJKkfEYsM92nnygqzj2kUE0DzO/4drVfiCxMDFSw3lPxWinBW6zuXuSYB
         Fe8w==
X-Forwarded-Encrypted: i=1; AJvYcCW9Y5bmkCRtQv8KvBq4yAxNRVkmAbmu3loeIk2B5qts/fByiHdfqI6/OyNsVwco8BZalzi7OXbuH1XoXlkLwbo/CBtIn4EliKVV9j7v
X-Gm-Message-State: AOJu0YybjmMsOQFV3wz0DQzT3DgPAHS2J/Dz7xx8IJIj2URbMR+Ml3o1
	OI6xpMO9VrbZpgQStF25tO2TWhWsYzDP30gWcoSGy/gegTO5fV6fhwtbiJHl2shMIlFvJWTgJp8
	AHUJPS7ftke/cw1hTAtqmAZG4dcdt1q14i+TJ6bGRdWWxWqdakkc4CLdII9pQQA==
X-Received: by 2002:a17:903:32d0:b0:1f5:e635:21e9 with SMTP id d9443c01a7336-1f83b5f24f8mr14183385ad.2.1718183726604;
        Wed, 12 Jun 2024 02:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlfi8iK/GU9xosOkQREwF9CY2gAivPhKjECT4Z/o9Qr5ZBG4/An2Y8v8HVWdDCyHn+JqWBBg==
X-Received: by 2002:a17:903:32d0:b0:1f5:e635:21e9 with SMTP id d9443c01a7336-1f83b5f24f8mr14183205ad.2.1718183726217;
        Wed, 12 Jun 2024 02:15:26 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f2adsm118813225ad.24.2024.06.12.02.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 02:15:25 -0700 (PDT)
Message-ID: <d1b3e694-820c-4693-bee4-1569941be486@redhat.com>
Date: Wed, 12 Jun 2024 17:15:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] KVM: arm64: Making BT Field in ID_AA64PFR1_EL1
 writable
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Catalin Marinas
 <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>,
 Zenghui Yu <yuzenghui@huawei.com>
References: <20240612023553.127813-1-shahuang@redhat.com>
 <Zmkyi39Pz6Wqll-7@linux.dev>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <Zmkyi39Pz6Wqll-7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 6/12/24 13:30, Oliver Upton wrote:
> Hi Shaoqin,
> 
> On Tue, Jun 11, 2024 at 10:35:50PM -0400, Shaoqin Huang wrote:
>> Hi guys,
>>
>> I'm trying to enable migration from MtCollins(Ampere Altra, ARMv8.2+) to
>> AmpereOne(AmpereOne, ARMv8.6+), the migration always fails when migration from
>> MtCollins to AmpereOne due to some register fields differing between the
>> two machines.
>>
>> In this patch series, we try to make more register fields writable like
>> ID_AA64PFR1_EL1.BT. This is first step towards making the migration possible.
>> Some other hurdles need to be overcome. This is not sufficient to make the
>> migration successful from MtCollins to AmpereOne.
> 
> It isn't possible to transparently migrate between these systems. The
> former has a cntfrq of 25MHz, and the latter has a cntfrq of 1GHz. There
> isn't a mechanism for scaling the counter frequency, and I have zero
> appetite for a paravirt interface.

Thanks for letting me know the cntfrq will block the migration between 
the two machine. And we don't have the solution for it, which means it's 
impossible to migrate between these systems which have different cntfrq.

> 
> On top of that, erratum AC03_CPU_38 seems to make a migration from
> Neoverse-N1 to AmpereOne quite perilous, unless you hide FEAT_HAFDBS on
> the source.
> 
> These issues are separate, though, from any possible changes to the
> writability of ID_AA64PFR1_EL1, which still may be useful to userspace.
> 
I think I can still making the ID_AA64PFR1_EL1 writable to enable 
migration on some other machines.

Thanks,
Shaoqin

-- 
Shaoqin


