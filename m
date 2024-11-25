Return-Path: <linux-kernel+bounces-421617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663829D8D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CC828A303
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279DF1BB6BC;
	Mon, 25 Nov 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOagGIHG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662141552FC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732568096; cv=none; b=cE2Bbg1zeGVYhH0b8cUWX++lteTFppqvijvVg7AwUt/k0zrtQcs+DOZUwhF5xlmcjL2nTwRNItczQHmiCR5j/ViKnWO14MxHXxl0T5QD9aZ0LiTUMgL92tIbEOaTgygk5Obo+8VUQeMk9I9z07AMM3Gv5EPvS4+gtoNyRtJiYH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732568096; c=relaxed/simple;
	bh=pLNGI3q63utN8E5O8PwVt6jG77VGVKk9hwrtqocmqZ8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=q27vzQeU9WaaxfpFdfPg4VTCS/ql3P8DtGOnhjAX62PP6mdRwa24cW4d3LT9mwGq1BJjGcsIwooEA8bgwpS59BJNZaMrJmA7wWEfIB9El7nqgjU2cU3HBCWUTIev5E0BraMmo0J82ItjPf9FckylK4XqH6Xw5MXzjK6E8E9c1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QOagGIHG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732568093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eXlYeOLU4oFXvqovS4V5YzUg2MzzvE9IQ02L3dWn00E=;
	b=QOagGIHGxp1eHCmhRyYjoXfwLAPPJNTB2urg3kS3NHfyjA5MTVZ4Cu1jbFYAFWgleyQBX9
	zSemkAkpFsqcFyvHYXPE1C1IFq5xNJEV9os6sCNpp0PZqo3xJA9zbiG4WihUKUX4luDHGf
	myR4jM4t0Zl6dr6oQTvevOXE/7YOXv0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-lDu0TcCqNUmUF19kFzaAjA-1; Mon, 25 Nov 2024 15:54:52 -0500
X-MC-Unique: lDu0TcCqNUmUF19kFzaAjA-1
X-Mimecast-MFC-AGG-ID: lDu0TcCqNUmUF19kFzaAjA
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7abbe394dso26893835ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 12:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732568091; x=1733172891;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXlYeOLU4oFXvqovS4V5YzUg2MzzvE9IQ02L3dWn00E=;
        b=o7UAl+hbDvUF6ENYVUdnNYx1We5J58K5VBYYgSCCMkR8YAUEljU2sSznrZaUdCSmg0
         7+21JPR9kmcOPVeI9efOszSDvq5x+OuWu45CRWPvA8+BawrsildghqpkfX0AmMK6mz80
         QSl2e48KibaDNaOM3e6mA7BoL8IKTaIeTq+IRLyhFZGyN3cY2PkWXk6bKrQqYCDGLbkW
         mK9GaZSRzf+oZ4yncpS8D06AwL/09neIy+qbVHcjBrNl8XuXLfnxH8BO66kdQskSxQt8
         2vKKZOB/qysbUQLBMgfHPkGCXKK23JQuJQl7qQ3M2lrNbWiCaLV3wRcwsyAFBLtvbj1C
         mM1w==
X-Forwarded-Encrypted: i=1; AJvYcCXLgWWqNUAhf/WKCFFV6ZeV5rCxThLLIyKs9c+7/uHkTDu5JVB9jLeLpSeEXFkuaXUaO4pS8Qx0MzwV3ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7aS+vx6cDAZ5HUBY+h3QqFTF5dD2nPQGaH9upW68VghBjqliD
	HFb0cMhvgyGH3lLlU4eeEgzvvJDC8BEtK8M06f3n002/DsK8XTSDSoD3s9T9VE8NDZWTfIySBOR
	HwXyM+FrDEiw4lldy/UU5Fs+mi/QgngVrJ595Cc09VbeuWdDLDe3XjIfbUeytEw==
X-Gm-Gg: ASbGnctGbYYjDLXKcYIcpySN2a4D734BGN31/DSuGhg/AYUljiKGv0Ig3obmbiyb1ne
	dnJ4/pJbPLWxajzp7z9xegO5GqCpz/GbHSH/knrrnhtyOpK+7y8rnCrnZ4BA/zBdr3Np9aKU5LR
	R/bVu9ffWkxdD5klfqkG43YJGKNLb3S8Lfb2ytEdizsS9PNJpTXazvLTGlcXL4CJVHf4TiQNJKc
	/u4nBbCdAjqQoIDUmMBAItrwRxbiVweueosueJCinsMxq45Tw9JDtGIbIKnxltkw3Yt5zlgmnLl
	JRaS0Wx0Cu11YRXpyX5p
X-Received: by 2002:a92:cd8b:0:b0:3a7:acdb:bba1 with SMTP id e9e14a558f8ab-3a7acdbbcd5mr88391495ab.10.1732568091318;
        Mon, 25 Nov 2024 12:54:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2OPuDbfEZwRc71nZMt8IBM7SpoizaQ/nKYjayi2HmctgMXcafVqelE4xIlz2UnR/Ohd0j+A==
X-Received: by 2002:a92:cd8b:0:b0:3a7:acdb:bba1 with SMTP id e9e14a558f8ab-3a7acdbbcd5mr88391335ab.10.1732568091044;
        Mon, 25 Nov 2024 12:54:51 -0800 (PST)
Received: from ?IPV6:2601:408:c180:2530:d041:4c25:86b8:e76a? ([2601:408:c180:2530:d041:4c25:86b8:e76a])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a79abbebb7sm20193135ab.24.2024.11.25.12.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 12:54:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <88f47cea-baba-4673-9bd7-7b7c3f421008@redhat.com>
Date: Mon, 25 Nov 2024 15:54:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc/pci: Make pci_poke_lock a raw_spinlock_t.
To: Guenter Roeck <linux@roeck-us.net>, Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
 <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
 <20241125085314.1iSDFulg@linutronix.de>
 <b776ca37-d51c-47e2-b3bb-aee8e7910630@roeck-us.net>
 <20241125174336.8nEhFXIw@linutronix.de>
 <c77c77d4-7f6e-450c-97d5-39dc50d81b1a@roeck-us.net>
 <20241125181231.XpOsxxHx@linutronix.de>
 <72991b83-173e-492e-a4aa-5049304c1bd0@roeck-us.net>
 <5d269249-afd1-44f5-8faf-9ac11d9a3beb@redhat.com>
 <dea92bd5-65e5-4c5c-bc93-5bef547c935e@roeck-us.net>
 <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
Content-Language: en-US
In-Reply-To: <2a940822-b4d4-43ea-b4f7-4294043b76ea@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/25/24 3:23 PM, Guenter Roeck wrote:
> On 11/25/24 12:06, Guenter Roeck wrote:
>> On 11/25/24 11:33, Waiman Long wrote:
>> [ ... ]
>>>> Fixing that finally gives me a clean run. Nevertheless, that makes 
>>>> me wonder:
>>>> Should I just disable CONFIG_PROVE_RAW_LOCK_NESTING for sparc 
>>>> runtime tests ?
>>>
>>> If no one is tryng to ever enable PREEMPT_RT on SPARC, I suppose you 
>>> could disable CONFIG_PROVE_RAW_LOCK_NESTING to avoid the trouble.
>>>
>>
>> SGTM. I'll do that unless someone gives me a good reason to keep it 
>> enabled.
>>
>
> Actually it can not be disabled with a configuration flag. It is
> automatically enabled. I'll have to disable PROVE_LOCKING to disable it.
>
> config PROVE_RAW_LOCK_NESTING
>         bool                    <---- no longer user configurable
>         depends on PROVE_LOCKING
>         default y
>         help
>          Enable the raw_spinlock vs. spinlock nesting checks which ensure
>          that the lock nesting rules for PREEMPT_RT enabled kernels are
>          not violated.
>
> I don't really like that, and I don't understand the logic behind it,
> but it is what it is.
>
> FWIW, the description of commit 560af5dc839 is misleading. It says 
> "Enable
> PROVE_RAW_LOCK_NESTING _by default_" (emphasis mine). That is not what 
> the
> commit does. It force-enables PROVE_RAW_LOCK_NESTING if PROVE_LOCKING is
> enabled. It is all or nothing.
>
I think we can relax it by

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5d9eca035d47..bfdbd3fa2d29 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1399,7 +1399,7 @@ config PROVE_LOCKING
  config PROVE_RAW_LOCK_NESTING
         bool
         depends on PROVE_LOCKING
-       default y
+       default y if ARCH_SUPPORTS_RT
         help
          Enable the raw_spinlock vs. spinlock nesting checks which ensure
          that the lock nesting rules for PREEMPT_RT enabled kernels are

Sebastian, what do you think?

Cheers,
Longman

> Guenter
>


