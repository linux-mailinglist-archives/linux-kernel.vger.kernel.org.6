Return-Path: <linux-kernel+bounces-256058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D25934874
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86DE2829F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37CE7345B;
	Thu, 18 Jul 2024 06:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POjl5k5A"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC31BDD0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285912; cv=none; b=YWTBBAa1bGSTLKCZJJ1fNPOtmKJJ1NweOupzLy6+IupTe7dmnJo9Y/IxyX2KpdSM9SSqLdgFqmIq1valg6yA0LvN6duYHk3Dn+DS29Nrnpc/x3kODZK5Ra2aG8Cob6ex0MKYtzS62FiN+GuIgZK6Hox4+Ww8kfcbJMvvi6R//Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285912; c=relaxed/simple;
	bh=Kqn6cTrmfIzgkIx3WEH8VYDiK/t68yBsPcxpcm9FGG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlOyoDFO1ChdgJBHviWYgS6agTqDPc1fLr46CLCnLbJpk4+yk1hnHtad58KxrjiGj2UEtA4vpVN3Cn3Oc2BwhLC0yeQRMjLDVa56MBEFtfaU7aDWe+9l1MU2f7aVsuqYhi9IkJk7YDBYKh0/zRlK6fkWO2PVVUIwLu9MKQWeo/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POjl5k5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721285909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+K3lMJtnJCRQkaiGsSYsWcq1BscDhBThSdy8hI3z6g=;
	b=POjl5k5AL2vfsPN9I/+ixN6q0U2e8fcjGjfzLd3PqFRR386Vg3KPksQYb7XAwjOmcYSecP
	c+vX10IId6E9i46jnUkg0OxpKMz7luoZnMzmAKmmJHN6xkg13G8nGvy77bqAuDWEnhXxmL
	NcQ+ZVToL4yIlosITwm295ur6T8jDro=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-MPIIFtv-NXqjAhbjR1ZODQ-1; Thu, 18 Jul 2024 02:58:27 -0400
X-MC-Unique: MPIIFtv-NXqjAhbjR1ZODQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8064498eb84so11540939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 23:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721285907; x=1721890707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+K3lMJtnJCRQkaiGsSYsWcq1BscDhBThSdy8hI3z6g=;
        b=BubZiKVWSlNWapuOmnrfxXDxfTExG6pVmayoZVk9TvO936NS9Jnf6j12MgV/PqVLye
         Kl4POSCoSAgGPaalHHt3djnYzTFNtmzDhQMOOX/6+8dwW6mJjjrKBrqNQZgKoeFkPVKV
         2I8HeOxepKrq6mFHyAF4MudZ5ITXzwXIFzHBJTffQKJP4PFVvYqnA2NB40iBHqF1PDNj
         +Wes1mVDaOWiizkec78u6PhLwi25wY9NaWnhujQfynuatdQQkijqo+XD1zo0yvWgS+0v
         JhdLzdUCNiFC3kT0k+D6jyjnF5g4gz4mEQLFXwBQ5rUHPgT8jqv977ZfRvnr207uiYuN
         GvDQ==
X-Forwarded-Encrypted: i=1; AJvYcCULxyijSi3UKL50m0jMA7k2uLVaVMnaocNLxLRzXUKXJPHELEbeeIUFAK57ULxntf3qkUpoMAXengVM5Of7Bv7WbE2n5OWcvWd8R3mv
X-Gm-Message-State: AOJu0YxcWDBpxR4cv5R8QrHOMvkc+iHuLV/C10BECaEFW/C0EisOgZfB
	3JRqW2ZUo6R7DCf6Ne1QheGBQzjGS/odHbvbxiWLzPNn5KyQUBtnqvecAFDCqDLziACQTdgBAXJ
	0PzOXyPJ68mDXKpHhSZNGmvd1+IqmD5hRUK/mxf1NZM5dVXSv07xPMVS3A8FKKw==
X-Received: by 2002:a05:6602:6e81:b0:80a:4582:cef1 with SMTP id ca18e2360f4ac-817125e2e78mr282664739f.3.1721285906777;
        Wed, 17 Jul 2024 23:58:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1CUDdb/pqONt4Je62LN6f3jGYm7SmTlakN/c+RI3Vxcjrt9NAAPcskLboMdbw0D7ZJe4dZQ==
X-Received: by 2002:a05:6602:6e81:b0:80a:4582:cef1 with SMTP id ca18e2360f4ac-817125e2e78mr282663039f.3.1721285906340;
        Wed, 17 Jul 2024 23:58:26 -0700 (PDT)
Received: from [10.72.116.35] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9e26fsm9201874b3a.21.2024.07.17.23.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 23:58:25 -0700 (PDT)
Message-ID: <817b5f2b-ec69-4a66-ad7b-ea8c8b9d0f24@redhat.com>
Date: Thu, 18 Jul 2024 14:58:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] KVM: arm64: Disable fields that KVM doesn't know
 how to handle in ID_AA64PFR1_EL1
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
 Mark Brown <broonie@kernel.org>, Eric Auger <eauger@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240718035017.434996-1-shahuang@redhat.com>
 <20240718035017.434996-2-shahuang@redhat.com> <ZpixhBjsqhWTpEQH@linux.dev>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <ZpixhBjsqhWTpEQH@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Oliver,

On 7/18/24 14:09, Oliver Upton wrote:
> Hi Shaoqin,
> 
> On Wed, Jul 17, 2024 at 11:50:14PM -0400, Shaoqin Huang wrote:
>> For some of the fields in the ID_AA64PFR1_EL1 register, KVM doesn't know
>> how to handle them right now. So explicitly disable them in the register
>> accessor, then those fields value will be masked to 0 even if on the
>> hardware the field value is 1.
> 
> It is probably important to note that the only reason this is safe to do
> from a UAPI POV is that read_sanitised_ftr_reg() doesn't yet return a
> nonzero value for any of these fields.

(Reply again by the plain text)

Yeah. That would be more clear if I tell the reader this information. 
Will add this when updating.

Thanks,
Shaoqin

> 

-- 
Shaoqin


