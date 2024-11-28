Return-Path: <linux-kernel+bounces-424059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB64A9DB029
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A52B21F98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B51487E5;
	Thu, 28 Nov 2024 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gb18l8j8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF013C836
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752038; cv=none; b=KjCEkSLeQDHqDMy4lkEitWnU7UWGFVP7eEk8dCOyNlxAmf0OEqPKkmUlglxRINSeCvhjf+fX5npLMlC9DmOsvcyRtsH6fbpIeFRxpYVQBpeO1kUfXNDNYL4H7pd2aYKvwUSTSJUVtnBVpGHcVmEoGR2WCwcEqKbIpWaEYIO/+Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752038; c=relaxed/simple;
	bh=6gIsCc4IkC+hcRuhvD2ZNEKegFuh0ytvFOiQCLUT1ag=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UkqY3YgiDiV4ZVxnta9qAunGQVtFoHPVOjBOFxN5oBqTaWFSFRXwQw/h7wgIrpTdqc5LSJLR+xaZcG4HlMXFpWHzCWfjWWxdm7iO398TW1lNLwMo/nWQAziY/C8v8cLzY0paloQe8N6oWGSv1xg0ouFDNkKw1XAy2zXKqIt0/kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gb18l8j8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732752034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+R8uojgiebLHWmkDPWGhwU6Zssoy9XmlcsUZU81DYw=;
	b=gb18l8j8zoP6Amnl2HDPC7Za/FBPrQusWBarD78urUX7zNUHl2KGWIomlEz8UN0onkYVoG
	oVXMqGx2EWB2pT03iZqUvMdNUbEXdqbtuIJMKxh29JfPh955VjPE4iIFaw8NTdjlYMadcy
	/oP/xzs5VUwSP4M5cNRLvMJPNvmP1gs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-LZZVHlavO9a9nUnKopwIFA-1; Wed, 27 Nov 2024 19:00:32 -0500
X-MC-Unique: LZZVHlavO9a9nUnKopwIFA-1
X-Mimecast-MFC-AGG-ID: LZZVHlavO9a9nUnKopwIFA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-466bc740022so5404521cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732752032; x=1733356832;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+R8uojgiebLHWmkDPWGhwU6Zssoy9XmlcsUZU81DYw=;
        b=GbdNBL0LBCZGUAZWxltTYjLFXHPbesDy5yBlTzjk7k1k/bNDEHpjhV2vd42QlA1Zle
         b4+pj1/G4gDkR6um4aS2T8q1KMyvZ7TYLYVOQtuSAxGoFy1QYTy4ZuUU9RPCGcob0ZAw
         Bb0PAhdM2YKgh6XnLCVWqPUyfsiEe6dj/hnB7artTvZDFxhUOj2IlmjZKt5pvYXnWn03
         y8LusxZQHmINmbkVVCWy0WQUmn+qu8On5t4M+OF4DKcInYbNoAOZiZCTWtaB0ttyz4kW
         NZS76Z+8LUOE8E4Q7usHTcJcm/wSOmyjVeXooj9dZS/vCRlj7yyKJgj8BvTftXyef34R
         Z12w==
X-Forwarded-Encrypted: i=1; AJvYcCWhkYwyTZO7QLzdpQdKxrNkvA3N13fHGzt5RacEepzIDPZeK3jd4v7QAYwQ9Gbew/z9pwD94GAzMFwoYv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1uAnqYor6x+n+RCK1wsUX5ED+NnsCgLpY/XnQNFLsHaCAbNw
	vvN41yeV0GOgangEtGfT5hxYlOlqvgX+UuiDQCMaO5tJ6W5N/YY2ZWDUwQel3G7wCfV5O3A/3fs
	ytLCLkUiCFmieKJmskzDusi+8ZXepVNnhA52xN8PuPwtdYJOMXgfllCWlPjhHYA==
X-Gm-Gg: ASbGncuqzAtab1PVSqJv47RHFtCUie7ot53TcrGKtiMylGb7YGq5vDYUsWdMTLZS1ic
	oZeXlsIcScjdZkGzZo+aFELGzepRX/5Scwvq63WstMqvJ1xwk+SP7e2WCRRCbh+OBkVdVIhvXWR
	sNdlKuxmbchqANfBhY3XbJgbKUa1XWObFiBiskUKngtYh5sI1rMgVJEXYElcahgrbS+l9ca1A9L
	gHKaVe/8aYYBKdkw34v10Cc+3dQo+dNDcdr2nYQ5H7rwiFd76K0IlXPtcgnOt26lOytw2qIbFR5
	Xo9VjhLQvXTdX1J4K7DS
X-Received: by 2002:a05:622a:113:b0:466:a9e6:6d69 with SMTP id d75a77b69052e-466b359e51amr66981851cf.20.1732752032215;
        Wed, 27 Nov 2024 16:00:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC11BrXt0UBkBasOn2RPwvpPJuTnd36onZqlY956vpd8yia/A9RX2+BB7AriqgXE136b0oNw==
X-Received: by 2002:a05:622a:113:b0:466:a9e6:6d69 with SMTP id d75a77b69052e-466b359e51amr66981141cf.20.1732752031266;
        Wed, 27 Nov 2024 16:00:31 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c421d812sm838051cf.68.2024.11.27.16.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 16:00:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e40965ae-cb21-4b23-b393-a86a1f601236@redhat.com>
Date: Wed, 27 Nov 2024 19:00:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/lockdep: Enforce PROVE_RAW_LOCK_NESTING only if
 ARCH_SUPPORTS_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <20241126231154.29151-1-longman@redhat.com>
 <20241127164442.catRG_Aw@linutronix.de>
Content-Language: en-US
In-Reply-To: <20241127164442.catRG_Aw@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/27/24 11:44 AM, Sebastian Andrzej Siewior wrote:
> On 2024-11-26 18:11:54 [-0500], Waiman Long wrote:
>> Relax the rule to set PROVE_RAW_LOCK_NESTING by default only for arches
>> that supports PREEMPT_RT.  For arches that do not support PREEMPT_RT,
>> they will not be forced to address irrelevant raw lock nesting issues
>> when they want to enable PROVE_LOCKING.
> I don't like the wording here. It is not "irrelevant raw lock nesting
> issues". This is documented in Documentation/locking/locktypes.rst.
> *IFF* we agree to ignore those because we don't want PREEMPT_RT on
> certain architectures then okay. But please don't describe it as
> irrelevant.

Sorry for that. I will post a v2 patch to fix the wording.

Cheers,
Longman


