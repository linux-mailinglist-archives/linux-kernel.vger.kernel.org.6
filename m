Return-Path: <linux-kernel+bounces-534454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A63AA4671D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5418B1890EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D1221F17;
	Wed, 26 Feb 2025 16:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMi9d9ko"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F1B21C9E8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588490; cv=none; b=clXrO6ur7chEicClXbbGulPIpzwCa1rtnXZxA2OErFBI8EamwlLC59b2VotiPtiavvXlgeYejgzGUOZeHXFkFRyWIcTwCodUEvSvJmQ07QgJi5+rtlbZnbeGiraadIbCQDzSxxHAR/3I2OJWIlv/G3b2TJEP37o4kg7z0EaWdNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588490; c=relaxed/simple;
	bh=FKuDjPky48EawNRhGHbvfKvn12YiQAezKUHuc/fM6JI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T8CtM5eA29dg6QfUnQKbF2snS6C3AMcVStP1aySnG506r4DES7TM77QjD1AzVjNwYdDf623EeNAfM4R27UQb4d7b8Go/6jlKmNvXyMU8G76HbzXRAjs0D4hOb//hWtg5rxXOr9hiauOE8IuWka83PIuHu2IYWwSsMDjuKOqXCXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMi9d9ko; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740588487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XEVhtESHjA99969kja7lZkPq3yyhhnaBTAi7GUz4sRE=;
	b=eMi9d9koqB7yKpI7MXSSJHypwbojR3eSl/F8YMFKM5OhWdNOyYjzb+9zApFm3RUv5CHkeJ
	A98zKNJpAglUBY2oxB68XpaGHJOcDsdUj3lpQkbqBhOcH84hDJ8k+l8rWb5zha7u3vGXFA
	/1FoapoFRfJxx6mVD46nbxt6vnNDxvQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-ViK998dgOk-Q0kz1ctsWow-1; Wed, 26 Feb 2025 11:47:57 -0500
X-MC-Unique: ViK998dgOk-Q0kz1ctsWow-1
X-Mimecast-MFC-AGG-ID: ViK998dgOk-Q0kz1ctsWow_1740588476
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4388eee7073so4937165e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:47:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740588476; x=1741193276;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEVhtESHjA99969kja7lZkPq3yyhhnaBTAi7GUz4sRE=;
        b=e9JdbPQjSnBf3LRMGmQizoy26+pfbJSJJsNr6HOoNMby4T5qvCobfZMQLPSLDNGEZA
         eJ0Oqa0sPgVsZTeZVpDWENBL7aAKE/lh4WnVCvx1NCI4NP6eYzlHTZgELfG6LVG4yzLS
         9XHjTssX1Y1bvOP+fqVTefMK8pivEeTRZQqluXxgL9z600guWjiYxRSPV99RiI3HXffi
         g633LAXOwmEtBxcpQVP4EBG/d0IpqCbXUUg9l4qdL3+5HbEeQwJDAEDvDM4QHFEB1OXK
         yKY47p5nFUIrkzLH1YxemVboz3gGWlNWTEMoWlhok4mTkDImuLGoP6KKqKXI4x3qwEeb
         j2pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsBuRVkBrT4lkG42xCpLl6hmaovnHgzMPGV/inBfBjPyMW93BKWrOVmFN+oTsTZavr1t4EDwyIrNX1r20=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMBnqcg+mJgF4z6E0SWKPd2JIfFpn/xAHJfwxeezmjjIJYWOkf
	CznG0ORjBtdVjXXp8rKkuTQQsZNqpVeIIYTFGfbexCmAcGBdQWHrtec8Do3863AWs7ILOLca9za
	wu81875TcsrUWtak8pM/wS7HCn3qCKc2vdpqsn25FJCSjIuHWLd3i8KLpkpf3Fw==
X-Gm-Gg: ASbGncskkc0IQZSRq0SYbXk3UJ6+S4ctRYtP6816OeyW/av2FrpH9B1/S7r+/Lnucf0
	qM81b83pgcOWaxQQ3Qc7tY3f2MM4rWNf5e6OX+0Cn4Yo1r3AML2UDH6X+RTGRW3voTSmQdKyjNS
	rs5wwuRTkgRII+oARypesDjY3mLGZ8amGmtkpy1tro/r7x9y34T3Y7ndxqK+GlLiMxhQANx5pP2
	ZKGUoXtgJ7ecwfxGP1aC9p7TuJ7ej2hZJ/DM7Gdpyw9AcK09cvK76X3c2ci/bXdgQfcVE6OX5up
	2jlVjTghnmxyG0AvHggZ21skHsa4sy2djKt3SKPPKLfKXojqRaMOCYRi6sM2dNJv
X-Received: by 2002:a05:6000:188f:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-390e169981emr60094f8f.21.1740588476077;
        Wed, 26 Feb 2025 08:47:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF83oPTzqUwKLHnTkQQgBtRJWLQEt88A6Baykbj08FpuJXByuQdt6jO1meJ6Wj8oNqtztQbXA==
X-Received: by 2002:a05:6000:188f:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-390e169981emr60059f8f.21.1740588475654;
        Wed, 26 Feb 2025 08:47:55 -0800 (PST)
Received: from rh (p200300f6af284000f9ca1328aeaacdd4.dip0.t-ipconnect.de. [2003:f6:af28:4000:f9ca:1328:aeaa:cdd4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866b09sm6275665f8f.19.2025.02.26.08.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 08:47:55 -0800 (PST)
Date: Wed, 26 Feb 2025 17:47:53 +0100 (CET)
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
Subject: Re: [PATCH v3 0/4] KVM: arm64: writable MIDR/REVIDR
In-Reply-To: <Z7zxSdW5b6rqe2bt@linux.dev>
Message-ID: <b2b015de-569b-2cdd-8ec3-8c8690ff950b@redhat.com>
References: <20250218163443.32836-1-sebott@redhat.com> <Z7zxSdW5b6rqe2bt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hi Oliver,

On Mon, 24 Feb 2025, Oliver Upton wrote:
> On Tue, Feb 18, 2025 at 05:34:39PM +0100, Sebastian Ott wrote:
>> Based on prior discussion [1] this series allows VMMs to change
>> MIDR/REVIDR to enable migration between machines that differ in
>> these registers. Since these are used for errata handling the
>> errata management series [2] is a prerequisite for this one.
>>
>> changes for V3:
>> * handle VPIDR_EL2 as part of vcpu ctxt - thanks Oliver!
>
> Thanks for respinning. While your changes are looking good, as I got
> ready to apply this series I wound up peeling the onion a bit further
> and have a few more concerns:
>
> - Current KVM allows guests to read SMIDR_EL1 despite the fact that we
>   do not support SME (this is part of TID1 traps)
>
> - The "invariant" values that KVM presents to userspace originate from
>   the boot CPU, not the CPU that resets the ID registers for a VM
>
> - A VMM that wants to present big-little can do so on current KVM by
>   affining vCPUs, but cannot with this series
>
> All of this is to say, I think your series is going to collide with
> the pre-existing pile of crap we have. I'm going to pick up these
> changes and rework them so we can send a fix for #1 to stable trees and
> (hopefully) avoid breaking the old "invariant" behavior.
>
> I'll post what I have as soon as I test it, hopefully we can get this
> shaped up for 6.15.

Sry, for the additional work I've caused. I gave what you have in next a
spin and it looks good so far.
Thank you very much!

Sebastian


