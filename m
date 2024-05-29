Return-Path: <linux-kernel+bounces-194505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CC8D3D43
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88F59B23C06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01C18411B;
	Wed, 29 May 2024 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPo+aNNf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B161B810
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 17:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717003075; cv=none; b=jeB69I9mklQJpG+zGLuJITKsq2/+ifWYV+fuD2XGkgGYP78gVfTzNHddYSCF9yRahhYevnyDO+PnZ6uc9qdbA0QwVz/vTL41BsvxMcJX9SGjkrKuT9tGMkdtWAfAmjnFl1YhDtI7qetmik40OcqnW/Birn9jyKtyPM/bVspH/DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717003075; c=relaxed/simple;
	bh=HRL5ucaZ3hB/3mleme94MeO065BSrwW91Qyz+lyN1pA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od/isfG2SZdwA7BdMzejFlGlerEfuZPt2JMnyrys0pCT1CYmMUJdovaww2N8JUGar0oY3o19hQAgQKVjEPgQgiastQ6MUiNKwhJZaN4tIARVCE7viZ0eaShrQuuVPSaFFo2k8W0OAZNdBZ+S3fGkJiAk+X2pg7BYLYwSlyQeHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPo+aNNf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717003073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUv7XG4pn3BZlXmqpi1zpSIKGCzhas+XxFu5FSvHJzQ=;
	b=XPo+aNNfAVVNaACqAv9Lr5RqQVwn3SEEU5d+Xcb/GskjOe26WA7tGTKa9fyK+BQDwnKQYH
	qWe1osyq9MWN8HcXelYnRm+UyVZkL+VS1nS87QPffoKC6kuX5O0Q+XVfxh+QUeuw8RIOew
	WQavmA7Jbr+ee7ndHH64sZEcs9AJEKM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-kAGvB_v8OWOnrkGPo5GT8g-1; Wed, 29 May 2024 13:17:50 -0400
X-MC-Unique: kAGvB_v8OWOnrkGPo5GT8g-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-43fcc9b4a5cso26109251cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717003070; x=1717607870;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BUv7XG4pn3BZlXmqpi1zpSIKGCzhas+XxFu5FSvHJzQ=;
        b=ID+yLw01YT/+js3hrM0kfxX29TTxtSOJM82KUmPsrTKXVLGjVvQPKfGReyhJ8c+OFS
         ID5LqE7bwdRCvax/l7qWLcWcgHBnSf1ukaSxS3RY9qSrKVP9LHQIL4MSu1RjU4Vcoqps
         NdHdivW/mJty1fX7/mJN12Ulg2lSw1BpmZCmXIB0pv3YyOquJ9Upuu2ncNWUePFw2hFr
         cMt500armVMbvjBOFIGTelfBleWerx0a3+SxrfIVC54oV7VoXaKZb1fZREwVD9vZnCir
         srqFKEuyNb4LkiBbXOPNZuvp0sxsAGXg9QxzMk0PkP7jF8yjIHzH5gf46UkDhQgiiuHa
         qbDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZHuU00mLTnXwbtvw4IWi/yZKkHcGyY/ewbx8q4MBKnLR8bcO2zqGFerUpQYE1KQ4y4B9POKKaz/sy2xoyGcFSYfld6SCY/Pr5qt6w
X-Gm-Message-State: AOJu0Yz76CENiCgSjEMqfe5R8X5XjyjRImFe2xnuaqJGxlJZtVTDbXal
	UvcanFJ7UzUjatsMqhkeRZUaz+MkPYGigcKOdz1aSDoKC1enZ+ddYJcbWhoMvQ57fg1SzqQQw7b
	BOxF7Wi7/P1qc6+XbJUFszAp2NQlVFBnOAzuUkOKvecmZcndTsjL5aFvzg2Kh2w==
X-Received: by 2002:ac8:7c49:0:b0:43d:e4c8:8059 with SMTP id d75a77b69052e-43fb0ea5fe0mr202225511cf.38.1717003070019;
        Wed, 29 May 2024 10:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPhv+rJGDUBPVu3ue7naEkW4C1RVt6Bk1ld4bFm4zpbG8GKGPbUuO/g7eqHWUwbs4l5gK7kQ==
X-Received: by 2002:ac8:7c49:0:b0:43d:e4c8:8059 with SMTP id d75a77b69052e-43fb0ea5fe0mr202225211cf.38.1717003069653;
        Wed, 29 May 2024 10:17:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fe57b7014sm5448301cf.80.2024.05.29.10.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 10:17:49 -0700 (PDT)
Message-ID: <1af3cb52-4311-4375-b384-71b0adeb8a32@redhat.com>
Date: Wed, 29 May 2024 19:17:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] KVM: arm64: rename functions for invariant sys
 regs
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20240514072252.5657-1-sebott@redhat.com>
 <20240514072252.5657-6-sebott@redhat.com>
 <b045f810-eb79-4de6-b149-0d64834d53d4@redhat.com>
 <5a00647d-7d33-81a6-c783-2212ff73ca8b@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <5a00647d-7d33-81a6-c783-2212ff73ca8b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On 5/29/24 17:29, Sebastian Ott wrote:
> Hej Eric,
> 
> On Wed, 29 May 2024, Eric Auger wrote:
>> On 5/14/24 09:22, Sebastian Ott wrote:
>>> Invariant system id registers are populated with host values
>>> at initialization time using their .reset function cb.
>> get_##reg call read_sysreg(). I don't really understand the above
>> sentence. Please could you elaborate?
>>
> 
> struct sys_reg_desc has 2 function pointers (among others):
> .reset and .get_user . The functions implementing these are
> usually named accordingly. For invariant registers only
> .reset is used but set to functions that are called get_*
> (which is usually used to implement .get_user).
> 
> E.g.: invariant_sys_regs[0].reset == get_midr_el1
> 
> When trying to figure out this code I was confused by this, hence
> this patch..

Ah OK, since ".reset=" was not used in the initilization I missed that.

feel free to add my
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric
> 
> Sebastian
> 


