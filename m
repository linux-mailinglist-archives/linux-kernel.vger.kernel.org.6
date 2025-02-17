Return-Path: <linux-kernel+bounces-517904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92054A38735
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3043A7DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE19217722;
	Mon, 17 Feb 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JR8wWPic"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F720328
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804783; cv=none; b=AhrkKFbvj6QalSriHxSRh5lReY72n8Iw98p+EbCYrujqYGUPkULr0dbO4+cwPgT7UKWJ3xQYH2eATOS8HF2uyo3YNLcp3O9vbkxxTkDLAnyEPdXG/XqpQDDDXk3SFeGKHJYNH08M2TevaddoWpNuWHgQT3EOe+xbpRlTsMmHQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804783; c=relaxed/simple;
	bh=INWds5QQuqynn3QPpkRTgci6yvzjpymnUwqXmd6yz5k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p5PzoLNprNh4jcoS16LEjWnRrkkr5clTr0r+S9am721Zmax5lM58i1MoY2WJaxGtjeA7XMO/bhh0sjVVz2k4dvv3b3iAz+aR7U83hoVd//lXGVGs8kiA/6nfYC1xdaud6M8FQhhtwSOKiia2RAgktNaNkeGTeG7PlppN7ODrMQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JR8wWPic; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739804781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIhN0R5QlN5gfMPD8y/C9Ok4w/DGGUuFXTQ4OChy43E=;
	b=JR8wWPic3TySoWxnOWoSu1KnHpro9Z5373oWQpE0wO3fk/8qAtdP49Tm2huVW530m2D9Jf
	KFmUSrDKV6RHEPKbLO8L0XnfiQTM7QbyMR0oBqoybWaBvPRS1sNLQDlymdhEQnx0M0CjZ8
	4a++msOXHqrjaqTppAmmZfQS5eVGXVw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-XYC0MJ0BM4K4OrSM4vVV1A-1; Mon, 17 Feb 2025 10:06:19 -0500
X-MC-Unique: XYC0MJ0BM4K4OrSM4vVV1A-1
X-Mimecast-MFC-AGG-ID: XYC0MJ0BM4K4OrSM4vVV1A_1739804779
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4394040fea1so25765425e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804779; x=1740409579;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIhN0R5QlN5gfMPD8y/C9Ok4w/DGGUuFXTQ4OChy43E=;
        b=KD5eaD8Rpx7jCKqGXgeOaMLO51ZNxXtzKOyH+qpo9xPQF8Hp/T2A9KZ79EQJDTsnP6
         1ltyOtlOuxfNpuybjulgkYvExansp0Fkkyb7MphpxVVB2z+dhByjDLsqdO4w7ZCMpHPd
         gAbLQt5sQXMtEAWNDzfR1xshEIATsBO2RwTDZgw8h8yaA8Ge0+PEvjSstu8dbz3rq6XN
         av3VjXUDMB28+P3rlEhWrcn3b8vdR/2gJOqYzUuNENJn87j66UiR6rp9ezRl74+rqJDt
         QxaMBLCMjrnbmaZiNqsb0B5IpvyfOJkAgiVlXPgwvybXJp2Us4NjC5SnEWTRT4e3gKCs
         iM1A==
X-Forwarded-Encrypted: i=1; AJvYcCVhtmGnonoQBBP+bhLzoGHIUQ6HXhjETnAuJXM4HsCFQsW5pXlLc2rxy/U9/aAtsAMj6Hph4m14NMWjiZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6P2orp3c2TZLPejtKLzuWNTiz+PD5DjD9vNdoWJVEGmf/E8x
	mQOcE+wZ/8vl8VpN6nqxlv181wHALkbJ6Az+W5L61eW+X9gNGRhB10wGLtBR3gbiUWR8Y+g4d0e
	VDuPFZ9IlwXttOYLNqfPjpjQdtyUP893UPgZgqpgsQfRxRYBgQJCj1vAjn4fkSw==
X-Gm-Gg: ASbGncsOFzniNPlspvLHXadShgDAem9RoMii7W/8b6Md8iQhFePLElf4Byak9gIswqv
	MMxT+tDkIZhodXrKwvgZ1fnyenMZCGUuq0rYoVFsC/UKxk1EUoXPvixOFf/2v6XVvytIk4GkEE5
	/WvU+yk60etmSa0nVzKGLv0aOlov5T8azqq1K3P2noZgm1NMZPcdQRh5R4XujHTtP9ohGOay/K5
	XSJ6/E6s16OM1FjPkPieGQZhSyKuGQsoba52+4VAp00EYnpdnyKniwBO51yJqoRrKeGfpvW8nie
	CLHcgx65LjULIIOZOYp1oW7FqVLPcPpo8e2TOPwwxCm6kJRN7fQhag==
X-Received: by 2002:a05:600c:1784:b0:439:5fa1:af56 with SMTP id 5b1f17b1804b1-43960bbfd9fmr182694375e9.2.1739804778571;
        Mon, 17 Feb 2025 07:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVu6DcpgSOODbx4M+M3zf9KaHfo6c0Pz4pVxnIXGaBPyQrP1BWzFL6eAilUcGtKBfEe91Usw==
X-Received: by 2002:a05:600c:1784:b0:439:5fa1:af56 with SMTP id 5b1f17b1804b1-43960bbfd9fmr182693755e9.2.1739804778154;
        Mon, 17 Feb 2025 07:06:18 -0800 (PST)
Received: from rh (p200300f6af0e4d00dda53016e366575f.dip0.t-ipconnect.de. [2003:f6:af0e:4d00:dda5:3016:e366:575f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5c29sm12533867f8f.72.2025.02.17.07.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 07:06:17 -0800 (PST)
Date: Mon, 17 Feb 2025 16:06:16 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>
cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Zenghui Yu <yuzenghui@huawei.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
    Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] KVM: arm64: Allow userspace to change MIDR_EL1
In-Reply-To: <Z7BoydkyT_h0gwOV@linux.dev>
Message-ID: <afac82bb-2d7d-66d0-cdb8-d8e3471a2bed@redhat.com>
References: <20250211143910.16775-1-sebott@redhat.com> <20250211143910.16775-2-sebott@redhat.com> <Z7BoydkyT_h0gwOV@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hello Oliver,

On Sat, 15 Feb 2025, Oliver Upton wrote:
> On Tue, Feb 11, 2025 at 03:39:07PM +0100, Sebastian Ott wrote:
>> +static int set_id_reg_non_ftr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
>> +			      u64 val)
>> +{
>> +	u32 id = reg_to_encoding(rd);
>> +	int ret;
>> +
>> +	mutex_lock(&vcpu->kvm->arch.config_lock);
>
> There's quite a few early outs, guard() might be a better fit than
> explicitly dropping the lock.

Yea, I thought about that too but most of the other functions in that file
use the classic lock primitives. But you're right - it looks cleaner.

>
>> +	/*
>> +	 * Since guest access to MIDR_EL1 is not trapped
>> +	 * set up VPIDR_EL2 to hold the MIDR_EL1 value.
>> +	 */
>> +	if (id == SYS_MIDR_EL1)
>> +		write_sysreg(val, vpidr_el2);
>
> This is problematic for a couple reasons:
>
> - If the kernel isn't running at EL2, VPIDR_EL2 is undefined
>
> - VPIDR_EL2 needs to be handled as part of the vCPU context, not
>   written to without a running vCPU. What would happen if two vCPUs
>   have different MIDR values?

Indeed. Sry, I hadn't thought about that. That makes much more sense now.

> Here's a new diff with some hacks thrown in to handle VPIDR_EL2
> correctly. Very lightly tested :)

Thank you very much! I've integrated that and currently run some tests
with it.

Sebastian


