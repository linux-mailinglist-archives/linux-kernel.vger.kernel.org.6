Return-Path: <linux-kernel+bounces-521658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 495DBA3C081
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911783A50B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11781E0B61;
	Wed, 19 Feb 2025 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFQEn/vB"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E311B4F21
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972808; cv=none; b=fcr7vWEjb3XoCZp9aBx/PA8NusGi7b8AEnq26iuZSzoQ4Fi+Old2KoxB9D3GrSZJGT98pIPAKvPTkfU05rL9Gal/UXFzTauAKwyd6HkTXE5hbnPdcdXJJJl0S97tqh6YM8BWT3zJi5xiIc7UoLUG+dLgx/fnhxPZrhUjHole9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972808; c=relaxed/simple;
	bh=nUXrVDPszJmwB5Bwbq3NpI4cj5YAJ0KMDlWoPy/V5LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TA2O9oYC9k0BG4s63Z05nkcPc1unGq7T3z6S5ZYc4YnyheqTliZCOnz4dmFWmXUyE5NSQjwo2bDPxagPJsYfBeKCC586YOByx5Devgl2f/iMLNJPXN72e2sZhb74wIO+aYt7wZ7/OpNesBdFnBEj3mk/63h9uZ+KWe3ov12MTLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EFQEn/vB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22104c4de96so72923615ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 05:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739972805; x=1740577605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ko00ndovSDIn9wXeXsjiQM4wpEigh6jTkcvJNJZTbVw=;
        b=EFQEn/vBgCy3w99xC9Eazm/xV2XA90k7Lv4NrOWIYLslY94TIUc7Kl9hd9PAb1MPTk
         2kKd6KLPuHGW7GUbWeCXaXyK5tnrmnMyABJ3+syxOCQ+mcz2RAmLtEdQ+Q0QDjJer3/X
         a32yoP0Vp856O4Xvu2eNpa5VTjsoIm3fEuFqp5qG5o9ylQyLyXKAQLf/M7jRy/hOX2cA
         ltZAS0ODItsuqq84ft2kDHt8TrXneus07vdTxCsty8kDJzHrgCUo8gEl9RoOxFz/Fn4T
         DmuTzaQOarFyNoOvU0N1SBW72IUzXN2sfZSwcdonuM7dvvSlCOrH/01f0xBtaY03aUqq
         iMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739972805; x=1740577605;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ko00ndovSDIn9wXeXsjiQM4wpEigh6jTkcvJNJZTbVw=;
        b=pgbJR8wYSanXdOdfceyfVUo+NXLvL8VR43hdEWmGdLz3DRonD4NTjc3ul/tUEzvHY2
         f7+5qGAdCgVJBuZ+BIhlTvhX0kpWnguEzYA3m5ZalFZhLj81Vzc2ollrzl6pLQUkF9hP
         wY7vNB9IsftHiwjw3fJx3v6EANGS/NxljZwyC5F05r7XjJ2T//8NJ7G0P4ONns9Jo1gR
         oAC0jzeeb7vQjCijNUTYiVgksjY4ek7ZOhZlAeVYI7K9mci2qS/d3reUIzRlxiz6J84b
         P3gQm2oDcXZdNPTbwn3eVATisp6ZerzcYMZYQaab1dsrnBuFVUtI5bd38xV4Xfs5+Xg7
         jRUw==
X-Forwarded-Encrypted: i=1; AJvYcCVyauwEbPLVA0Ib9A/b97VuPOrLt+LmdGAqy/Pu+wYl8EljIGaFUJGq8Ki6ynzTNrXSqhW5/T7/oYvxYNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZynkPMzy0Ufx+89IDJSIU4tTzFNb288diEsVcsk+PWeUUmAe6
	Cn5IASZ7BfSE30y0BEdelat0ygZNqU15sTjk9V6V6cu7Q89Yo8rGVNMJeeJAEIk=
X-Gm-Gg: ASbGncsSFKiGedlb56EBwLqNU0MhiXxHcQyGiW5zdF/+HB8FxE2pBNjXYFX0TigfbS/
	o1ndG4GytdPY09mxMUUdzvxrKw9WeMJyt1B9qpQMBAbi1E9nCPpOT6qNHnkHYEL+3q9VHbWwpqV
	r1CNYFqsS1AAwcfaJwJY0Tj1lY2yror+6dE4Bmt2wA2Q/vtNF7L0izg+L9gxy43OdFAh0l/xdZH
	aONe0S0seI+3XVcJXOcKq0a8xoue+tcCumizMwhv7nzPst4uqfyAgdQl+1cyfzLkqW2HAPHb3+Y
	fu8qwVVWI2VU/TlUzpnZYrQD3W1CNGPtB48/dv5/YckbzOuGXCUaGvibWvfOc+Cukda9VPkNpDV
	77Jn/DnAOWjdDmH0=
X-Google-Smtp-Source: AGHT+IHzud8yErWxQizk2X9LlTm6NcH2o64l3dhMPpAt69MusAto549t5CGCBpRameWQHlsswQzXpg==
X-Received: by 2002:a17:903:2cb:b0:21f:7082:1146 with SMTP id d9443c01a7336-221040867e8mr282114035ad.30.1739972805371;
        Wed, 19 Feb 2025 05:46:45 -0800 (PST)
Received: from ?IPV6:2804:1b3:a7c3:f704:ed29:494:9f22:f6c5? ([2804:1b3:a7c3:f704:ed29:494:9f22:f6c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5584dccsm104054335ad.205.2025.02.19.05.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 05:46:44 -0800 (PST)
Message-ID: <191a4cc2-5c35-43f1-aaa4-01395299590b@linaro.org>
Date: Wed, 19 Feb 2025 10:46:33 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Pedro Falcato <pedro.falcato@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, jeffxu@chromium.org,
 akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org,
 vbabka@suse.cz, Liam.Howlett@oracle.com, oleg@redhat.com, avagin@gmail.com,
 benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org,
 sroettger@google.com, hch@lst.de, ojeda@kernel.org,
 thomas.weissschuh@linutronix.de, adobriyan@gmail.com,
 johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org,
 anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org,
 Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net,
 peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org,
 dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org,
 mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
 enh@google.com, rientjes@google.com, groeck@chromium.org,
 mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
 mike.rapoport@gmail.com
References: <20250212032155.1276806-1-jeffxu@google.com>
 <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com>
 <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
 <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>
 <202502131240.A57C749@keescook>
 <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <CAKbZUD16kfO2OBxY2fMbnmnEinTeKbPpTOLVC=Pc+FbWN_kjcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 18/02/25 20:18, Pedro Falcato wrote:
> On Thu, Feb 13, 2025 at 8:47 PM Kees Cook <kees@kernel.org> wrote:
>>
>> On Thu, Feb 13, 2025 at 07:59:48PM +0000, Pedro Falcato wrote:
>>> On Wed, Feb 12, 2025 at 2:02 PM Lorenzo Stoakes
>>> <lorenzo.stoakes@oracle.com> wrote:
>>>>
>>>> (sorry I really am struggling to reply to mail as lore still seems to be
>>>> broken).
>>>>
>>>> On Wed, Feb 12, 2025 at 12:37:50PM +0000, Pedro Falcato wrote:
>>>>> On Wed, Feb 12, 2025 at 11:25 AM Lorenzo Stoakes
>>>>> <lorenzo.stoakes@oracle.com> wrote:
>>>>>>
>>>>>> On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
>>>>>>> From: Jeff Xu <jeffxu@chromium.org>
>>>>>>>
>>>>>>> The commit message in the first patch contains the full description of
>>>>>>> this series.
>>>>>>
>>>> [...]
>>>>>
>>>>> FWIW, although it would (at the moment) be hard to pull off in the
>>>>> libc, I still much prefer it to playing these weird games with CONFIG
>>>>> options and kernel command line options and prctl and personality and
>>>>> whatnot. It seems to me like we're trying to stick policy where it
>>>>> doesn't belong.
>>>>
>>>> The problem is, as a security feature, you don't want to make it trivially
>>>> easy to disable.
>>>>
>>>> I mean we _need_ a config option to be able to strictly enforce only making
>>>> the feature enable-able on architectures and configuration option
>>>> combinations that work.
>>>>
>>>> But if there is userspace that will be broken, we really have to have some
>>>> way of avoiding the disconnect between somebody making policy decision at
>>>> the kernel level and somebody trying to run something.
>>>>
>>>> Because I can easily envision somebody enabling this as a 'good security
>>>> feature' for a distro release or such, only for somebody else to later try
>>>> rr, CRIU, or whatever else and for it to just not work or fail subtly and
>>>> to have no idea why.
>>>
>>> Ok so I went looking around for the glibc patchset. It seems they're
>>> moving away from tunables and there was a nice
>>> GNU_PROPERTY_MEMORY_SEAL added to binutils.
>>> So my proposal is to parse this property on the binfmt_elf.c side, and
>>> mm would use this to know if we should seal these mappings. This seems
>>> to tackle compatibility problems,
>>> and glibc isn't sealing programs without this program header anyway. Thoughts?
>>
>> It seems to me that doing this ties it to the binary, rather than
>> execution context, which may want to seal/not-seal, etc. I have a sense
>> that it's be better as a secure bit, or prctl, or something like that. The
>> properties seem to be better suited for "this binary _can_ do a thing"
>> or "this binary _requires_ a thing", like the GNU_STACK bits, etc. But
>> maybe there's more to this I'm not considering?
> 
> Doesn't this exactly kind of Just Work though? "This binary can
> do/tolerate sealing". I would blindly guess that we don't have very
> opinionated shared libraries that do this kind of shenanigans
> unilaterally, so that's probably not something we really need to worry
> about (though I admittedly need to read through the glibc patchset,
> and nail down what they're thinking about doing with linking
> mseal-ready and mseal-non-ready ELF execs/shared objects together).
> The problem with something like prctl is that we either indirectly
> provide some kind of limited form of munseal, or we require some sort
> of handover (like personality(2) + execve(2)), which both sound like a
> huge PITA and still don't solve any of our backwards compat issues...
> all binaries would need to be patched with this
> prctl/personality()/whatever call, and old ones wouldn't work.
> 
> The semantics behind GNU_PROPERTY_MEMORY_SEAL are unclear to me (maybe
> the toolchain folks could shed some light?), but it sounds like it'd
> fit perfectly.
> I suspect we probably want to parse this on the kernel's side anyway
> (to seal the main program/interp's segments)[1], then extending them
> to the kernel system mappings should be somewhat trivial...
> I don't think we'll ever get a program that can't cope with sealing
> the system mappings but can cope with sealing itself (and if we do, we
> just won't seal the entire thing and that's _okay_).
> 
> Deploying mseal-ready programs could then be done in a phased way by
> distros. e.g chromeOS and android could simply enable the
> corresponding linker option in LDFLAGS and let it rip. Other more
> mainstream distros could obviously take a little longer or test/deploy
> this on all programs not named gVisor and/or after CRIU is okay with
> all of this. We then might not need a user-configurable CONFIG_ (only
> an arch HAS_SYSTEM_MAPPINGS_MSEAL or whatever), nor a sysctl, and
> everyone is happy.
> 
> I glanced through libc-alpha again and it seems like the glibc folks
> also seem to have reached the same idea, but I'd love to hear from
> Adhemerval.
> 
> Am I missing anything?

Hi Pedro,

After discussing with CRIU developers, I plan to change how glibc will
handle GNU_PROPERTY_MEMORY_SEAL to allow a more smooth enablement in
distros (the latest version is at [1]).

The idea is only enable memory sealing iff the main binary (either 
ET_EXEC or PIE) has the new sealing attribute.  If it were the case, 
the loader will still check if the dependency has the attribute and 
seal accordingly.

So if for any reason the binary does not support memory sealing at all,
like CRIU for the snapshot restore phase, it just need to be built
with -Wl,-z,nomemory-seal.  It is also for the case for libraries,
although I think this will be rare.

I will also work on adding a way to enable partially non-sealing
sections, since Florian has hinted that he wants to use on some libgcc
metadata (similar to how RELRO '.data.rel.ro' works).  My initial plan
is just mimic what OpenBSD does with PT_OPENBSD_MUTABLE, which only
works for ET_DYN (and I think it should not be a problem). But it is
a userland problem, so no kernel support would be required.

> 
> 
> [1] we should probably nail this responsibility handover down before
> glibc msealing (or bionic) makes it to a release. It'd probably be a
> little nicer if we could mseal these segments from the kernel instead
> of forcing the libc to take care of this, now that we have this
> property.
> 

Keep in mind that GNU_PROPERTY_MEMORY_SEAL is currently a glibc extension 
and I am not sure if other runtime would be willing to adopt as well.  
So its presence can not be implied that sealing will be applied by runtime.

[1] https://patchwork.sourceware.org/project/glibc/list/?series=43524

