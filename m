Return-Path: <linux-kernel+bounces-444402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62819F063A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6194D2858D8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBF91A8F85;
	Fri, 13 Dec 2024 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWpvevPw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C69719F101
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078014; cv=none; b=anRYCP/fqpgrrhbGWmT0P/OgirrPJv+zIYEshiEUEr4E4fXEQc2KFklbpKMJMjGEmpo0Pj3WAQ2X9tACp5vUdbKb87m4wP0zJtWlTS2Q9BomTUHmQb1Hy2/VOFx35ulqKN6QCNXAHx+DBUsQL9TvSGCD1OjKtnT3b0TkhCcvRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078014; c=relaxed/simple;
	bh=ijr3IzqSxPiN+NYmYp1CosWmmhI03eZXSqAuemj7w1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHn2i/7aKzbGDF5FtCCpvnm0yMxnpb1I1CCoCATzHIoVpWfw2KzTmD9kplqOxH9/Q8B9H/IoU3Dr/svfNjSysUCtErPKFXZTDDV3L5tIHXSdKK1REvOu9F+P1Bpv03e2t6/ZeAw1Fd+m1JP1pYYNC+umVAcoesNWE+eLSFqgsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWpvevPw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734078012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UV1wwUvDbgVjftsKa9dU87wk1sPiYCmEM4UeAtv1RqI=;
	b=BWpvevPw18OkrYmM6d8fRjR7uQMdoVAiJ84dnUJ4OOdCHmZ8G6livuMPnvxPiabfmebmdn
	168l6GHOENoEWUf/kkw6G5usuCtPF6rJDFJGpziJeKIH1bekjO9mzGcuYN1v1w7qBPtxrs
	xaSwyTY+LNzKLPG2QxuoZ4Gmf+2Lviw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-2tsPZFjDOiuiHAk26fuEpg-1; Fri, 13 Dec 2024 03:20:10 -0500
X-MC-Unique: 2tsPZFjDOiuiHAk26fuEpg-1
X-Mimecast-MFC-AGG-ID: 2tsPZFjDOiuiHAk26fuEpg
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38634103b0dso771149f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 00:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734078009; x=1734682809;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UV1wwUvDbgVjftsKa9dU87wk1sPiYCmEM4UeAtv1RqI=;
        b=jz8NfN0ggc9M8YgracZ/SNUuL3LNDYTNTC55+g4R/X+BR2lyn4aNaJ0DIjbfLt/3e6
         9xwpgy1kbW4i0Etu/D9Z3clapBxLqKctes+fRubBdb3LlzX/gb8kQuJZhhfUVMTqFFYt
         YWnf+K0nVAzPLcyCd89DQ/NxxWhRPKE7dNYnMFV2rLI0oLxlu8z4/9uKh/60hCIuWAhJ
         1i0DoFcH205fE5/V1KEvaHqCuAt6HIpzcL/fc7aSeKgB60OoI3VU5WgkC/mUIUmPBMFZ
         J+x5tLldW6yteSW5Qx+FxW0VOc16a+Y465C5QLuoOwm9ix0ix2COY1cGCtzfCkXh6bJg
         8ySg==
X-Forwarded-Encrypted: i=1; AJvYcCUqNyXlWOGgX+HPV9hcC/CHuYXqUKinjX1d/x7hGQ+LiLEY82a3/OgElfcTUXieuzv108L2b7F8ZYrY+yw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7dDvvZZe5zQLDl4b5SnHDwDKc+BQOy44WFcwNbLhtp2F5RCM2
	XJkk4A1D8v/lagaA69X73wg8IAnukLKosOeHm6xXCZDdiH5SFNrN5M+avCr6BIb/7hyFFfxu7ZG
	+fcBkN0lOvFRTBQrnrt8y9OODKRJY575yOAErYKSACeaKni1lal4E+GyM0D583Q==
X-Gm-Gg: ASbGnctcPk8iPL7F1FKvCdiAHOKK4G5uuBxiWEniI36KaSYcQPATIVbcYwyKTsJL/pB
	60EeW55CT6JY+CjOqTU1+zXcuV3jXiEMtP6tYsFT8nDSn+9CkwLHbEgya0ccPFFTXY7qvGdtZbm
	wTt8TPVwSc7L12qknXWRflQBeinvOB6v++vNtP2uTWpPUrTIZZrC6gAYq2yzPchtxelD5sACyZL
	HEDGm2jT8EQGbLdgBySgerb9vDVshrv9XiRtvOpl+n8DhtJDmd08g0/spU=
X-Received: by 2002:a05:6000:1a8e:b0:386:32ea:e70d with SMTP id ffacd0b85a97d-3888e0ba2f4mr910613f8f.50.1734078009098;
        Fri, 13 Dec 2024 00:20:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrCHiXBGnM5x0F9+IJDtAVhPlkiWHtx4O9ovcSIL7K/Npye3omEspq5dEzagyGc9xjVrwPFg==
X-Received: by 2002:a05:6000:1a8e:b0:386:32ea:e70d with SMTP id ffacd0b85a97d-3888e0ba2f4mr910591f8f.50.1734078008749;
        Fri, 13 Dec 2024 00:20:08 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4362559ed8dsm42786805e9.23.2024.12.13.00.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 00:20:08 -0800 (PST)
Message-ID: <79b9abfe-cfb8-4ef0-8a4b-7b87787e6549@redhat.com>
Date: Fri, 13 Dec 2024 09:20:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/5] KVM: drop 32-bit host support on all architectures
To: Arnd Bergmann <arnd@arndb.de>, "A. Wilcox" <AWilcox@wilcox-tech.com>,
 Arnd Bergmann <arnd@kernel.org>
Cc: kvm@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Alexander Graf <graf@amazon.com>, Crystal Wood <crwood@redhat.com>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org
References: <20241212125516.467123-1-arnd@kernel.org>
 <35E5C2A3-94AC-446B-A0A1-84B043DBC890@Wilcox-Tech.com>
 <6e971322-8b21-4d73-922c-a6032c6fe9bd@app.fastmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <6e971322-8b21-4d73-922c-a6032c6fe9bd@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/13/24 09:03, Arnd Bergmann wrote:
> On Fri, Dec 13, 2024, at 04:51, A. Wilcox wrote:
>> On Dec 12, 2024, at 6:55 AM, Arnd Bergmann <arnd@kernel.org> wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> I submitted a patch to remove KVM support for x86-32 hosts earlier
>>> this month, but there were still concerns that this might be useful for
>>> testing 32-bit host in general, as that remains supported on three other
>>> architectures. I have gone through those three now and prepared similar
>>> patches, as all of them seem to be equally obsolete.
>>>
>>> Support for 32-bit KVM host on Arm hardware was dropped back in 2020
>>> because of lack of users, despite Cortex-A7/A15/A17 based SoCs being
>>> much more widely deployed than the other virtualization capable 32-bit
>>> CPUs (Intel Core Duo/Silverthorne, PowerPC e300/e500/e600, MIPS P5600)
>>> combined.
>>
>>
>> I do use 32-bit KVM on a Core Duo “Yonah” and a Power Mac G4 (MDD), for
>> purposes of bisecting kernel issues without having to reboot the host
>> machine (when it can be duplicated in a KVM environment).
>>
>> I suppose it would still be possible to run the hosts on 6.12 LTS for
>> some time with newer guests, but it would be unfortunate.
> 
> Would it be an option for you to just test those kernels on 64-bit
> machines? I assume you prefer to do native builds on 32-bit hardware
> because that fits your workflow, but once you get into debugging
> in a virtual machine, the results should generally be the same when
> building and running on a 64-bit host for both x86-32 and ppc32-classic,
> right?

Certainly for x86-32; ppc32 should be able to use PR-state (aka trap and 
emulate) KVM on a 64-bit host but it's a bit more picky.  Another 
possibility for ppc32 is just emulation with QEMU.

Paolo


