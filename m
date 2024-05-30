Return-Path: <linux-kernel+bounces-195304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796CA8D4AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24A451F22E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4952174EC3;
	Thu, 30 May 2024 11:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PaESKfPj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E62174EE5
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068247; cv=none; b=gHDxFb3QinGNAT5ab7xl4fuOf4uRczI3AhKBBHpewSWC1TOR1Vzvpu4MxVpKiICF7Vh/xLZw6NV8/srOklAaTVSEQKMlo3sRqRrQ+oHz+GDRWGikweSo8S7rEieX7ivXL2HBWHhvhpjAdsB30dmEW9fYaqZNl702MDiCiznmla0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068247; c=relaxed/simple;
	bh=IbiAcFEwpuYaFXmkBXJwg3JefhvhU9je+ScUl5D7G2c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QoQZAlhHd+GVcs6Ut+EjAZOk/09BSiUu52hR7cKjQkisH4wKMr3/QOk1+NIvlOofheZGPuoKxTqRCIKdqBrFYv7ciw9R3YQMmJOPhn8ydfET/NmYUqMZWDTjGRnk/jGW6edL/hgMMnZ6oQ0vp4+vovYEWtmnMQYbptXm3vEmGJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PaESKfPj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717068245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NyFVukIA+6eMErT5jIwX1F/VfLDC/ji7PYywadLXOr0=;
	b=PaESKfPjSj0XtZvCY38ak9BVj5r994j9GsTQI433VquhQu+OwX0sTvAnR36U8joCD6f1mJ
	UpxQPyce0+L8jHpLStpfvmPoMu89n/QDabOBturmDQ6wZqb0c6EE8wrnoJIuBFqUKKMtOm
	7tEEAIYPhhjWEfo0+XgJBkYG3pVtfZw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-ViP1YuCJNY2QNcqsyce-yQ-1; Thu, 30 May 2024 07:24:03 -0400
X-MC-Unique: ViP1YuCJNY2QNcqsyce-yQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35dcb3f1ab3so239744f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 04:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717068243; x=1717673043;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyFVukIA+6eMErT5jIwX1F/VfLDC/ji7PYywadLXOr0=;
        b=nix7P9O03c+ELQ7/1qhgUeFPGRKpgr8WtD56/3hMvIYw2aX5Ml5uqsYPrNqu4O6BnB
         JCi8XpwoC++BiMglVAvie+KfM8PRerjNYaKQTtGLxcjNzPKqtWh4eemofGLF285hWkwp
         HyQ+4gNTGjAi18cs9QL5ng3KFo7G2YWXGLvi64lzoBwrnr4ezi3ESCTHN38xMfx0jGff
         do2/0tie1oKkpruB6s2IebhnPLL7SQFhuddfXmZnzCPEONfpE0Vb2W1rPA56nz2FEBeS
         f5TS6BaS8xUbPRrmvglHxVRweDjPWl+SJ3MuFi12xPPs6qRon6iSFMiQOdNXDj35qN1r
         LvMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhgQ2JHga7yXAgoJIy/O4PVxIw30DjFZ2A19eCYKdJKbeUbnevyg95qaJOoWbGW0X3JZbf1llI1xXWs3zBHK7WIGZBfUhOZrnviD3z
X-Gm-Message-State: AOJu0YypK1n+DPjFgdreIA0/Mf8GrYfoSrCxzExlt+bu2PQ/uR7yFuKa
	SnXw6QmdramEQRnqTYgwNBx8JZVV7iQtIVwXRlFrJ6QUfRjN+CgWh45VeTS+NjisZgMXNL55VQZ
	7JahlbbGAUDH8ISPRH1P0B4/t9XFScAjWw4F3sHa+3xgeJ+/YXFjxfN8MrVaZYg==
X-Received: by 2002:adf:ef0c:0:b0:357:ce05:7533 with SMTP id ffacd0b85a97d-35dc0099613mr1211458f8f.40.1717068242864;
        Thu, 30 May 2024 04:24:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOLwH0ZFTriyl8uzTdycdGfXdQu8TChCl2APlRFv5WkN/IIPx8ecBsis+IyjdEMOUVvO8E2A==
X-Received: by 2002:adf:ef0c:0:b0:357:ce05:7533 with SMTP id ffacd0b85a97d-35dc0099613mr1211444f8f.40.1717068242417;
        Thu, 30 May 2024 04:24:02 -0700 (PDT)
Received: from rh (p200300c93f02d1004c157eb0f018dd01.dip0.t-ipconnect.de. [2003:c9:3f02:d100:4c15:7eb0:f018:dd01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3579354abd1sm13832465f8f.59.2024.05.30.04.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:24:02 -0700 (PDT)
Date: Thu, 30 May 2024 13:24:01 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, 
    Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/6] KVM: arm64: maintain per VM value for CTR_EL0
In-Reply-To: <2dcfc174-9384-4746-833d-1442bcfb6d11@redhat.com>
Message-ID: <a0295969-eff9-5330-cd1f-1e41b8f43eee@redhat.com>
References: <20240514072252.5657-1-sebott@redhat.com> <20240514072252.5657-3-sebott@redhat.com> <edbe3039-ed42-432e-8309-5a0a46cc2d5c@redhat.com> <90e53cc7-039f-5abc-f94c-cf53a1602a2a@redhat.com> <2dcfc174-9384-4746-833d-1442bcfb6d11@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463795790-1183132592-1717068242=:11201"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463795790-1183132592-1717068242=:11201
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 29 May 2024, Eric Auger wrote:
> On 5/29/24 17:51, Sebastian Ott wrote:
>> On Wed, 29 May 2024, Eric Auger wrote:
>>>> @@ -3557,6 +3557,13 @@ void kvm_reset_sys_regs(struct kvm_vcpu *vcpu)
>>>>      struct kvm *kvm = vcpu->kvm;
>>>>      unsigned long i;
>>>>
>>>> +    if (!kvm_vcpu_initialized(vcpu))
>>> at this stage of the reading, why is the above check needed?
>>
>> To make sure that a later call to this function doesn't overwrite
>> the value provided by userspace. (See e016333745c "KVM: arm64: Only
>> reset vCPU-scoped feature ID regs once").
> but isn't it overwritten through the .reset=reset_ctr() that is
> populated in next patch?

No, this is done via reset_vcpu_ftr_id_reg() and also guarded by
kvm_vcpu_initialized().

Sebastian
---1463795790-1183132592-1717068242=:11201--


