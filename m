Return-Path: <linux-kernel+bounces-252366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B74931243
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E641F231D0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363BB18785E;
	Mon, 15 Jul 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS1LCod7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5F18757C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721039295; cv=none; b=sBi8b4NwDgXDEyEnsM8bqup1yeo8e0gEtEwlUH7GTv4rtOS+K/6PkQ5szg5DEl0iz2hjxntVoyUlTKxtdEmOafjPvdh/WaR9P2UT0TDHnuMjFuga68oNv+0ZNUAllqo2DMp2C+XyyL9GeLe8kQRzSlyPN1o8ps75LKGjE99QAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721039295; c=relaxed/simple;
	bh=+xTWXNB9goKErdd7zsLIfBIKWebwItFQTsWRxe+U2d8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pepvLC8XpB3RPM3LUyXGqVX6oWXVnjqWYkt2nx3sizjf3rjCkbfGdDAiYMqO64++hTIVzcCAjV5dT1EvJM8Utf6cYOhttRuw30Y9Sdoj8bzYxo+KU5t1YfzBVdssV/biRfCWyZVUe9SGnVmRLn3JkGKlL7YFTUbNXCJ7S8v7Iv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS1LCod7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721039292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GH/UMjm9Bv3Ls7RPi1qyRi7O73kNYwzhssTIeV97gbM=;
	b=IS1LCod7cKuxgxDT+SHkMuDH1VLSIOUDBIPQ5LjVSH0Eh0QKRz0rlgCyEo2/EBuOytFaOD
	Ngm7IGBuRLzO2ldOYRWex7DWQJDcy8AufNVMWsG8gVwkZLsSL/KVjzuIi1kCpNPIZMsOPA
	2//JgP35IXdxr/orRTbV/BRqmp/wMyA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-Kqqu1hpvMbCTFRhb9oEarQ-1; Mon, 15 Jul 2024 06:28:11 -0400
X-MC-Unique: Kqqu1hpvMbCTFRhb9oEarQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b75e880a12so36166956d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721039290; x=1721644090;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GH/UMjm9Bv3Ls7RPi1qyRi7O73kNYwzhssTIeV97gbM=;
        b=kyIwDXgyweS7Pcpw+BkXkLh97tge9E9wNXGI+IDWnB4sWIop8Th9JihnV38og9c2/v
         z8ab2wBfei9xXESXG+0UANcLzXsjHvBRGYStwcOngLwg8H3bZrfMXnN5BD33lsP40Q5Q
         yzG7zMPOt2cE2Y8g78vCVUFdtkrJJMwxdk1aIHg/m2ZixaiIbNnC039hxPlV9hmTALp7
         i2JosMSWyPNoh8hDJFrtHpk/Bz8ZW9KKEhdAAM79kxAx22KCS1/pY4gukjFXM8H8TlB/
         qqxOWi7pt+4h5r2Hu033rVTTTCYr2FjzpYTuzagQQIm2nLFsn7ZFaE9Bjw3OiQK1U8Zk
         y00A==
X-Forwarded-Encrypted: i=1; AJvYcCUN7JNCGeV+S/jJuPBCMc7HFQL+X34ZrXU2Xqzeuzn+dRjcIjyWeZtA2q23MxksbnjEsx68WcQwGt0eRrWBbCR6RtqX152Wb43QXD0J
X-Gm-Message-State: AOJu0YyoZETAy5CRTvhlCI/ILSC604aGz/qpYmMkmTgfbZK4+fH4p0Ej
	DYownqzASfdakXr/SHbn5CybbLXyYVvQ77qwAvWw1IOI6o5wTvZCi9QsEMt1dKwYzP4D7rj2L19
	r7iFlVW0Z0UC36/JrFg9FLHRL1p0GjFXrwm9uU5qzfwAKxwpBo7b1tbb0MYo4+A==
X-Received: by 2002:ad4:5aa5:0:b0:6b0:86ab:fe89 with SMTP id 6a1803df08f44-6b61bf24454mr253416226d6.33.1721039290702;
        Mon, 15 Jul 2024 03:28:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtZ5aPh6SJPX0vALIcQbxvBsBt7/FyT5/BtnGUEqoH9PUJwi4W3cEfWV3d6Sx5qRQ1lvAo8A==
X-Received: by 2002:ad4:5aa5:0:b0:6b0:86ab:fe89 with SMTP id 6a1803df08f44-6b61bf24454mr253416076d6.33.1721039290402;
        Mon, 15 Jul 2024 03:28:10 -0700 (PDT)
Received: from rh (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b761a10d8fsm20015876d6.99.2024.07.15.03.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 03:28:10 -0700 (PDT)
Date: Mon, 15 Jul 2024 12:28:06 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    linux-kernel@vger.kernel.org, Oliver Upton <oliver.upton@linux.dev>, 
    James Morse <james.morse@arm.com>, 
    Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
    Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH 1/3] KVM: arm64: fix override-init warnings in W=1
 builds
In-Reply-To: <8734oep96j.wl-maz@kernel.org>
Message-ID: <3b882ac0-fd2c-35df-38d7-b89cf073bcc3@redhat.com>
References: <20240712110332.10970-1-sebott@redhat.com> <20240712110332.10970-2-sebott@redhat.com> <8734oep96j.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 12 Jul 2024, Marc Zyngier wrote:
> On Fri, 12 Jul 2024 12:03:30 +0100,
> Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Remove double initializations in cases where that's easily possible
>> - like extra NULL initialization in static global structures. In the
>> other cases just silence -Woverride-init.
>>
>> To fix warnings like the following:
>> arch/arm64/kvm/hyp/vhe/switch.c:271:43: warning: initialized field overwritten [-Woverride-init]
>>   271 |         [ESR_ELx_EC_CP15_32]            = kvm_hyp_handle_cp15_32,
>>       |                                           ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  arch/arm64/kvm/handle_exit.c     | 5 +++++
>>  arch/arm64/kvm/hyp/nvhe/switch.c | 6 ++----
>>  arch/arm64/kvm/hyp/vhe/switch.c  | 3 +--
>>  arch/arm64/kvm/sys_regs.c        | 5 +++++
>>  4 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
>> index d7c2990e7c9e..2c049746657c 100644
>> --- a/arch/arm64/kvm/handle_exit.c
>> +++ b/arch/arm64/kvm/handle_exit.c
>> @@ -291,6 +291,9 @@ static int handle_svc(struct kvm_vcpu *vcpu)
>>  	return 1;
>>  }
>>
>> +__diag_push();
>> +__diag_ignore_all("-Woverride-init", "Allow field overrides in exit_handlers");
>
> The wording you are looking for is "Silence stupid warning". I really
> mean it. There is really nothing wrong with this code, and if the
> compiler doesn't understand the purpose of a default initialiser, then
> *maybe* it should be fixed rather than polluting the kernel with this
> stuff.
>
[...]
>> -static const exit_handler_fn hyp_exit_handlers[] = {
>> -	[0 ... ESR_ELx_EC_MAX]		= NULL,
>> +static const exit_handler_fn hyp_exit_handlers[ESR_ELx_EC_MAX + 1] = {
>
> Is this really any better? I don't think so. It makes the intent
> disappear instead of making it explicit. Intent matters *a lot*.

I'm not claiming that it's an improvement to the code. But yea, I see your
point. How about disabling that flag in the makefile?

Thanks,
Sebastian


