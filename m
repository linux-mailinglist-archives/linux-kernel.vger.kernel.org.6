Return-Path: <linux-kernel+bounces-558214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3688A5E2D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AFE169C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293E1D6DA1;
	Wed, 12 Mar 2025 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWhaCUlO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33837156C62
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 17:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800799; cv=none; b=jotebXhVPawZoRkkyPnKghum5UdOrZqo16pxvhDKZIcb9XUTxFC18E1iZrKLIzS6b5auvLSx/ppFYQrwpQbVH9JOjZjkkA+hQSnbqPw09wkJ/lYYrx5P6wejksG9ofM4dQyjcZPqg+LZCx+uPQREFa9kM4RKle1WEQBhKMIrNbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800799; c=relaxed/simple;
	bh=dvyJrdPXem/t9rhGc0og2q57i3iOEHExNGrbOAeLIoQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bgEHJkpuC7faP2l2hWC4iPbhYTaf4+uDSknhmMsAXZoYK8+452GAYC5K8g7wV6p8Yd9R6SOURCNnltBxr3T6OgSm45r28CpNUUYujG0uDPYykD0/4P3In0jUWDUIRLs75CkV858ETlOMp0KqId3GD79UAhWkGt8uXp1dwjVfJdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWhaCUlO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741800796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dvyJrdPXem/t9rhGc0og2q57i3iOEHExNGrbOAeLIoQ=;
	b=TWhaCUlOaY8BAd6UmA9z4kn7+32brsSHsdw1wZHVIjbmqY4XOt0GDarKz5fqCgD3jPRnaM
	WlV+63AfcZ0vlJ0+cx/3fIf7Kjh/HD5YO3TgJj5YsLVB4RqVNHhsgry+wis/A1FoMPojPs
	/+8wwt37xtIMBO3Eay2MQmTLnj5gIas=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-NzhC7er1NUCaJztgk0Bafg-1; Wed, 12 Mar 2025 13:33:12 -0400
X-MC-Unique: NzhC7er1NUCaJztgk0Bafg-1
X-Mimecast-MFC-AGG-ID: NzhC7er1NUCaJztgk0Bafg_1741800792
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf44b66f7so241925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741800792; x=1742405592;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvyJrdPXem/t9rhGc0og2q57i3iOEHExNGrbOAeLIoQ=;
        b=gxNCTNFFZ1b1UMeZ4KG3iz4bx0dtRSQ0P8KGf6bpcTtwVfD+TIY/Onp7BcjPfBQI61
         8UwnsjfWImYLexvYpoo3yM0bKQDH5k8+Jo+catheOAvKpMFY2hI021fBqXRo/+lBmAyl
         1ijc8+3tOGBbaVI91RZhqwHR2P8TNwd2QDTwr0AhgTs35kBzK6eM3KxOp9SFBXXV4TiY
         /Aq5tbMYbeWQJHxNCjsvWQAuPZIBwQMReSOUpKNzJViTYxPHE3CzTnH0ZkmlHe2jPQ4o
         pOLCZtLS00bhBl/g8232OLwK0LXhzrrFZDSdedJfRANZYToEhD2JevV8SFfZ/IIq85AJ
         Ko2w==
X-Forwarded-Encrypted: i=1; AJvYcCVg0ppLISUDbCt3cT/R4kdcQhSzxktaTdOUzUwnN7Wfwys4jiKi0Bztshc/qEOAPdowurCfVBhQycwTEYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnjUIr9Ixw+im0RFkjKjUyKqBeYhK93BLWFIai27Vc1Z1TiRn5
	OwtFoIeYbo8rfAxXd7Vgal0z/iL7Ycjze9bc8+xmt1O4ax/gK+sSiGO1D0oYg+80ZCc2U/SRu33
	OocKbXmi+B8CXuKaLify5NUriMZAW8wmNq/1ohxDxu4gHIP0R7Ievq4SS8bEJFw==
X-Gm-Gg: ASbGncsTuoQETq880oyAYokfZ3lJr35S8t0pBH54c2V6HcMUBbEvl6VNaXsv03WTTtK
	StMitKAmvHPWZTZ3jHUl74xTdMgXvGAWqGh0aI/w4/ELw12C7qLQoOjn5R/1rR2ofA4XGLckVjh
	/PJpKiiVbuMoPGMemIemQJ1gZGnf+T4ss7NY4gmdZ7cHwDjd+iJK1AHTgWgxaNtm1o8r1EbDFhJ
	XS90Bg7p5vfU9ibGB5EPINP3wpgyow1fzFqN9L3ENqFVaJWSQw2A2lHyD6l6Bbib6NrvQNNhIzC
	Y4Eblws7UW9FKIcHJgr5GAWtJVMZXirny6prpR5Bs8NzBsa2sCDjAkpyR4MzSF8/
X-Received: by 2002:a05:600c:190c:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43cea40af7amr151794795e9.31.1741800791752;
        Wed, 12 Mar 2025 10:33:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkDaxroZKHcALMxZZ+BxRIhiOexx6MlAPp0LIXP7yGXSlrtMMJvV8WhA2IxMPpSEUR5gjapA==
X-Received: by 2002:a05:600c:190c:b0:43c:ea40:ae4a with SMTP id 5b1f17b1804b1-43cea40af7amr151794565e9.31.1741800791436;
        Wed, 12 Mar 2025 10:33:11 -0700 (PDT)
Received: from rh (p200300f6af11ec00f9928575aec32536.dip0.t-ipconnect.de. [2003:f6:af11:ec00:f992:8575:aec3:2536])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a74b699sm27660235e9.10.2025.03.12.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 10:33:10 -0700 (PDT)
Date: Wed, 12 Mar 2025 18:33:09 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Oliver Upton <oliver.upton@linux.dev>
cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Zenghui Yu <yuzenghui@huawei.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Writable TGRAN*_2
In-Reply-To: <Z9HCQ40LxShzL4nj@linux.dev>
Message-ID: <eb045be7-69ca-fe71-0333-086b71bb624f@redhat.com>
References: <20250306184013.30008-1-sebott@redhat.com> <Z9HCQ40LxShzL4nj@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Oliver,

On Wed, 12 Mar 2025, Oliver Upton wrote:
> Hi Sebastian,
>
> On Thu, Mar 06, 2025 at 07:40:13PM +0100, Sebastian Ott wrote:
>> Allow userspace to write the safe (NI) value for ID_AA64MMFR0_EL1.TGRAN*_2.
>> Disallow to change these fields for NV since kvm provides a sanitized view
>> for them based on the PAGE_SIZE.
>> Also add these bits to the set_id_regs selftest.
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>
> I can't tell what you've based this patch on, it certainly doesn't apply
> on a 6.14 rc. Consider telling git to include the base commit next time
> you generate a patch.

Ok, I'll keep it in mind for next time.
(It was kvm-arm64/next + 2 pkvm series from the list that I applied
manually.)

> Please do selftests changes in a separate patch.
>
> Don't worry about respinning, I'll fix this up and queue it in a moment.

Thanks!
Sebastian


