Return-Path: <linux-kernel+bounces-180908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB38C74A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C4D1C238BD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F7143C42;
	Thu, 16 May 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ijeQdZ88"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BF8143866
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715855353; cv=none; b=E+FcxGKKFDji7CdBX0FI/U0ICCiaV4HMPI8PXAXPBT0e9+jTcirkw3hlASHWnUCfDk60Mqd/c52Um8oahGW6XI7OQOBvf5F+cfVPacomL+paA3DPEW4NpiBbWahqqLDdsYi4nrRTfviyjyG61vP/I/7hkjcP/4W4XRh9ypeqiL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715855353; c=relaxed/simple;
	bh=B50V4b8tuqE4j58BDda6kbJDZFnCUVds2QKqgis/B04=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sbG4vYzBvMG5CLQzjvZb6U2txP+Vj1VjRNQIaW31rbC+nMR0LemH2N8D7H0m4gvxmBBpw4xkyT7/kZYjpIIZ7JugFuGoIQq+Q/5/zmF10lw4vETi4i3vsxKdzpNMtb7y5GZl/g/PiIHtNUjzNWRWfwkONyR8BmJtST9sl8RANnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ijeQdZ88; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so276577466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1715855350; x=1716460150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfiCrmzMav6jtyX7fjtUp23BCUfl5Tu6+xTotiNhCKs=;
        b=ijeQdZ88l/sSJaHC7unZ71hrNNL81O/80pbgWEuICD9TI4Nw6hX7dVuOw1MQcdcACJ
         B5yI6P3kgpBYqjC90vMJ2C3lZeJL2N/NFk6pzlpm+qSMMVwZtFGIjcFGMWSnX4gba3XW
         52TojMG/3M1iOwulxA2BewPCzDkZV3a0S6tuBnLVN2Qg9GTG6LCOCdiG6VRCaKEDwZnq
         xMD/wBev96KVBQBc8KrExCGsLwVH/Aibp1dPYaTmf2KHwgfMbjZkkaExkdRY6CmD+kKD
         foClWtqRUBPGVQ7NcYaPk0Lwf7G4FoPems2lzUqAqqL7cDtZhMsN5zE7VuP9nKyT0Luf
         uF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715855350; x=1716460150;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfiCrmzMav6jtyX7fjtUp23BCUfl5Tu6+xTotiNhCKs=;
        b=QXXmhAAjvmXCO85iZqb9EYXOia31NILbUVGoy02BpSUW3j1LTG4RiGgVL4fRWP15YO
         iKdXbS5Bpfk2WzjkHTD5gSTIliE2MERSkcpu5MRuYDIW0OU9JZhbiD21BTkxg+hf9Okv
         6p9+RI0gcUeMngrMlsvjCVrvbe0Z5WvbZmQTZlv0tbR1dn/ioX0OtkHOzylwHyZUbatr
         gwKXwxrNd815LH3XJxQbXAc1HZkYndoDb2cdsPUpMkH4Q8xRxgho/l+XRQGT/wYeob07
         CzdsTMt4xLjX7/u0pU+0Cc0Y0K1+Tt3EksiVwMRa9HWcJxtE5V3w275q4iXvJHDmMVYy
         9/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKkImMckvJrwsztvzGCEx3vnnP5KYzzFwIxwuNwOxairUic6zOY27rsBsUonWD2OL7wLTokPl+QjML3wkcD68dG9q5XRRutWitVJo9
X-Gm-Message-State: AOJu0YyZKOAUQ1taBDx7gCBXSitK9DLtKTtZ8KbWwNG0qseNsgpZcE4B
	BY8LpSyOf5Y4PtEbZB+5hfGxwyy0fatq/OqrOK9xDjTUcsGKGSzOXvtqHW+u+OQ=
X-Google-Smtp-Source: AGHT+IExcYKDOZgxgPbo+cpXP+U4PHqgxT6wQa+7CtqYbVSEZVHpbwAd44L/OPkoT6r42Zd20xyv2g==
X-Received: by 2002:a17:906:f898:b0:a5a:8ca4:6781 with SMTP id a640c23a62f3a-a5a8ca468bbmr456970666b.51.1715855349956;
        Thu, 16 May 2024 03:29:09 -0700 (PDT)
Received: from ?IPv6:::1? ([2a00:11b1:1012:4c5c:60c0:dbec:5b5e:a393])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012a025dbsm166085975e9.23.2024.05.16.03.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 03:29:09 -0700 (PDT)
Date: Thu, 16 May 2024 12:29:08 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor.dooley@microchip.com>
CC: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
 xiao.w.wang@intel.com, pulehui@huawei.com,
 Charlie Jenkins <charlie@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v1=5D_RISC-V=3A_separate_Zbb_optimisatio?=
 =?US-ASCII?Q?ns_requiring_and_not_requiring_toolchain_support?=
In-Reply-To: <20240516-speller-target-d453ad060486@wendy>
References: <20240515-hedging-passage-44fd394ab1be@spud> <20240516-7ff4001c9f2edd2a61775244@orel> <20240516-speller-target-d453ad060486@wendy>
Message-ID: <60EFC387-B19B-46A6-AD1B-D6DAC8108836@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 16, 2024 10:59:44 AM GMT+02:00, Conor Dooley <conor=2Edooley@microch=
ip=2Ecom> wrote:
>On Thu, May 16, 2024 at 09:59:44AM +0200, Andrew Jones wrote:
>> On Wed, May 15, 2024 at 04:27:40PM GMT, Conor Dooley wrote:
>>=20
>> So the new hidden config is a shorthand for
>>=20
>> #if defined(CONFIG_RISCV_ISA_ZBB) && \
>>     defined(CONFIG_TOOLCHAIN_HAS_ZBB) && \
>>     defined(CONFIG_RISCV_ALTERNATIVE)
>>=20
>> which is reasonable to add, since that's a mouthful, but I'm not sure t=
he
>> name, RISCV_ISA_ZBB_ALT, does a good job conveying all that=2E
>>=20
>> If we instead just dropped the 'depends on TOOLCHAIN_HAS_ZBB' from
>> config RISCV_ISA_ZBB (keeping the 'depends on RISCV_ALTERNATIVE',
>> since nobody is really complaining about that), then we could change
>> this to
>>=20
>> #if defined(CONFIG_RISCV_ISA_ZBB) && defined(CONFIG_TOOLCHAIN_HAS_ZBB)
>
>Yeah, I think this is a cleaner solution=2E
>
>> >  	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>> >  				      RISCV_ISA_EXT_ZBB, 1)
>> >  			  : : : : legacy);
>> > diff --git a/arch/riscv/include/asm/bitops=2Eh b/arch/riscv/include/a=
sm/bitops=2Eh
>> > index 880606b0469a=2E=2E3ed810a6123d 100644
>> > --- a/arch/riscv/include/asm/bitops=2Eh
>> > +++ b/arch/riscv/include/asm/bitops=2Eh
>> > @@ -15,7 +15,7 @@
>> >  #include <asm/barrier=2Eh>
>> >  #include <asm/bitsperlong=2Eh>
>> > =20
>> > -#if !defined(CONFIG_RISCV_ISA_ZBB) || defined(NO_ALTERNATIVE)
>> > +#if !defined(CONFIG_RISCV_ISA_ZBB_ALT) || defined(NO_ALTERNATIVE)
>>=20
>> nit: It's sufficient to check !defined(CONFIG_RISCV_ISA_ZBB), so no nee=
d
>> for this change or its #endif comment change below=2E
>
>Are you sure? I did test leaving this as-was and it broke the build for
>llvm-14=2E

Oops, sorry=2E I didn't look at the full context=2E You were right=2E

Thanks,
drew

>
>Cheers,
>Conor=2E


