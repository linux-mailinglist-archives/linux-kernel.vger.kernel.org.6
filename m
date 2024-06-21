Return-Path: <linux-kernel+bounces-225211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CDC912DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E0E71C20A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA4017B419;
	Fri, 21 Jun 2024 19:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oSPIMrlu"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875534644C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996547; cv=none; b=b0gTEsjD8ME6hm8+3ast3S+QmKKmvRBM519qOv35nP0aI0MhNkHpOmNbqdbiDm+9gnxiwMVlpfTW2u4hq3ED92vcijNp532LOOoxvTQVs0Yup5z2NeAmVS676PiadV6/pCpfmDPPms2LRgt5OALPErEO2QMX+iNDjj1sSDFnAvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996547; c=relaxed/simple;
	bh=2ejfWjZZ+2p6n8C/uYSvX+3GJZETSO2UUSX42MmnXY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dObjQ38enlb3DZ4k9eZrkIV8v5K2f728M/8k5egbIhRAx1Hg96n5VHfX9lpgz3dyJXO9in8dzWmFzEShQ1VUKz1f13Fw95+mZxfkZvG/PM7ON6IwLARyXe+8HmSSTUNuifm2wL5tanWtWwK9P3oUhKVzaVu7oCC8gzLoU3v7LSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oSPIMrlu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f480624d0fso18251755ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718996544; x=1719601344; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ejfWjZZ+2p6n8C/uYSvX+3GJZETSO2UUSX42MmnXY0=;
        b=oSPIMrluRj/zDqsgkzy/B80Y/49TndFAp/dYd1K9Q6IfgedwFTuYHt3SHjrKhwfeed
         LAxdZvrp/EefaAsGSak6PZM8qGHhZIc2eqx0d9WXk9LCsaKLUBFzxWo3Z5RFSd5vQBhe
         2KURMGk13DuwOVPM6B1LWsn6dH0la1E+pPT7f5AAEmjEaT1WJS/FK+ac0aGoaUuWKeey
         5dGHVwGTJ9jA5nORxV+PCYUAJQUpHoFwj2LdJNsXJ/XJV2713+71xV5kcqGt6MKh49OQ
         kJJ0vDr4gqflnYJNoWs5TTDUTqByzUKKK66Qc5z9sWXWkI46YSBrQsYpJ/0RcaBJinI8
         EGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996544; x=1719601344;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ejfWjZZ+2p6n8C/uYSvX+3GJZETSO2UUSX42MmnXY0=;
        b=WU9617V9Z9nK+3BCK35j7W+diPXCYtl5sW7RoSCjzsHIS2zqZSPuV0EjaH8hPX39cH
         AjXTrvMe43qSrLrB6Rnzab/vW5Gkg6FZfcNlMlRHS7+/L5+/7nQacXe37T7MpGLMnn/y
         nXXfgVOcaZfEmu+KzRr5OIZh2MGYEzSz/qQi32rSxzP9gj6FyC/N30sEL7c5C3QMaNQI
         Iuxp46DcEftjb81dnAamFAVUWoh5mWk44sfEzDqCPf/O2ayaCz/Qd3jotVhWN/0fwmEv
         38CISiLqzRKL5UEA/wOc6IXmMgRqqiYcY2DsT3pVaTekXTwmKYb0lkWFHW0h99Huyi07
         4O+w==
X-Forwarded-Encrypted: i=1; AJvYcCUYc290PSK8t6PAc6C/NNf1hDCAzmjc5Z2RDxRTMbwtaE9g0fM9HCEPfMhM8OsqpjTIqFSVQP51ACUQW7WCpjOAgT6BWww5pY+WE6Gp
X-Gm-Message-State: AOJu0Ywh+a9xssaN9WoO/WyGTAMDa1loeALfTcFqPZpfVwtQPexvIctw
	CMgtkHKbFmE2grMAbR6P05ZmP82dduN4m9VfrmCop/1+zEJ00nAMMOnnN/IN0mg=
X-Google-Smtp-Source: AGHT+IHNesJtO0UqquNF67ECCx6rJvGVvWqByp4IpDMUVIaiuwlaYkut+gD3Q7guqC20bvpJVZvxbQ==
X-Received: by 2002:a17:902:da91:b0:1f9:c289:7378 with SMTP id d9443c01a7336-1f9c2897606mr82016305ad.33.1718996543540;
        Fri, 21 Jun 2024 12:02:23 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f051bsm17459975ad.51.2024.06.21.12.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 12:02:23 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:02:21 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
	Cyril Bur <cyrilbur@tenstorrent.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] riscv: convert bottom half of exception handling to C
Message-ID: <ZnXOPbuGe3nHNrs5@debug.ba.rivosinc.com>
References: <20240616170553.2832-1-jszhang@kernel.org>
 <20240616170553.2832-4-jszhang@kernel.org>
 <ZnMPhcaTKFRbbE1i@debug.ba.rivosinc.com>
 <CANtDSipXbYSuz6NakbXw-8k0_ZN5hdT7VWMushXvQ5VB0Am_Ng@mail.gmail.com>
 <95a081a9-2307-4e5b-8ae2-082be16b327e@rivosinc.com>
 <ZnTByNTDWnVdtiDr@xhacker>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnTByNTDWnVdtiDr@xhacker>

On Fri, Jun 21, 2024 at 07:56:56AM +0800, Jisheng Zhang wrote:
>On Thu, Jun 20, 2024 at 10:06:15AM +0200, Clément Léger wrote:
>>
>>
>> On 20/06/2024 02:02, Cyril Bur wrote:
>> > On Thu, Jun 20, 2024 at 3:04 AM Deepak Gupta <debug@rivosinc.com> wrote:
>> >>
>> >> On Mon, Jun 17, 2024 at 01:05:50AM +0800, Jisheng Zhang wrote:
>> >>> For readability, maintainability and future scalability, convert the
>> >>> bottom half of the exception handling to C.
>> >>>
>> >>> Mostly the assembly code is converted to C in a relatively
>> >>> straightforward manner.
>> >>>
>> >>> However, there are two modifications I need to mention:
>> >>>
>> >>> 1. the CSR_CAUSE reg reading and saving is moved to the C code
>> >>> because we need the cause to dispatch the exception handling,
>> >>> if we keep the cause reading and saving, we either pass it to
>> >>> do_traps() via. 2nd param or get it from pt_regs which an extra
>> >>> memory load is needed, I don't like any of the two solutions becase
>> >>> the exception handling sits in hot code path, every instruction
>> >>> matters.
>> >>
>> >> CC: Clement.
>> >>
>> >> I think its better to save away cause in pt_regs prior to calling
>> >> `do_traps`. Once control is transferred to C code in `do_traps`,
>> >> another trap can happen. It's a problem anyways today without CPU support.
>> >>
>> >> Although with Ssdbltrp [1] extension and it kernel support [2] for it,
>> >> I expect asm code would clear up `SDT` bit in mstatus. Whenever `Ssdbltrp` lands,
>
>Hi Deepak, Clément,
>
>Currently, SR_IE bit is is set(setting means enable irq) in c, could the
>'SDT' bit be cleared in c as well when Ssdbltrp lands?

SDT is placed in sstatus CSR. So yes its possible to clear it in C in `do_traps`.
Although then you (and any future developer) will have to pay extra attention to this
function because this function can be nested depending on when SDT is cleared or not.
Maintainence (and introductions of error) wise it doesn't look ideal.

If we keep read of `cause` in asm code and pass it as parameter to `do_traps`, it
cleanly defines the boundary of which functions can be nested and which can't. It
helps features like SSE [1, 2] (which expect nesting of events and had to be creative)
to implement cleaner logic.

[1] https://lists.riscv.org/g/tech-prs/message/515
[2] https://lpc.events/event/17/contributions/1479/attachments/1243/2526/SSE_Plumbers.pdf

>
>Thanks
>> >> I think `do_traps` should expect nesting of traps and thus cause should be saved
>> >> away before it gets control so that safely traps can be nested.
>>
>> Hi,
>>
>> Indeed, every register that is "unique" to a trap and than can be
>> overwritten by a second trap should be saved before reenabling them when
>> using Ssdbltrp. So that would be nice to preserve that.
>>
>> >>
>> >
>> > Is a possible solution to do both options Jisheng suggested? Save the
>> > cause before
>> > calling do_traps but also pass it via second param?
>>
>> I guess so if it fits your performance requirements.
>>
>> Thanks,
>>
>> Clément
>>
>> >
>> >> [1] - https://github.com/riscv/riscv-double-trap/releases/download/v1.0-rc1/riscv-double-trap.pdf
>> >> [2] - https://lore.kernel.org/all/20240418133916.1442471-1-cleger@rivosinc.com/
>> >>
>> >>>
>> >>> 2.To cope with SIFIVE_CIP_453 errata, it looks like we don't need
>> >>> alternative mechanism any more after the asm->c convertion. Just
>> >>> replace the excp_vect_table two entries.
>> >>>
>> >>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> >>
>> >> _______________________________________________
>> >> linux-riscv mailing list
>> >> linux-riscv@lists.infradead.org
>> >> http://lists.infradead.org/mailman/listinfo/linux-riscv

