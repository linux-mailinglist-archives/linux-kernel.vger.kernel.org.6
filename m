Return-Path: <linux-kernel+bounces-524489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5947FA3E3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BD6770296B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC69214217;
	Thu, 20 Feb 2025 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B8JvbYdo"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C458820FAAB
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075785; cv=none; b=RHdKXBRSBULCM3740I+JHOpGeC9D7tiqUw7TvDAonublTJ8GdHgS0ynPEgpLfptHO5xQsXfJHamSlfbPGmvcC2wUODlfYXVWONrO+q8ECWu8DJ43vk6cGj5WHy2G+Rz/QjdWXdS1pm1z2ZYfUUB5e7+H2+WaGQuev32XINmbgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075785; c=relaxed/simple;
	bh=+brjcpA6Li4VmWmcewwernBTel3ZbNNKAOCMO9aNPss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeocsQsa4oLP+78bDkGDct2Khf/B0BvhgUKLrkRPlUycgHvkqoIpXDAdT+D66n+QX1kXGgAFnAQwl24fJ1Ggdh27fMHSm4uek0Kn6R6dSR1GuyCe33wy9A2wjm7By79MtXBzThjVFpHbPfrvgHjjbUMj8Gi+bBixIRRvFv2cl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B8JvbYdo; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fbfc9ff0b9so2066810a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 10:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740075783; x=1740680583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+brjcpA6Li4VmWmcewwernBTel3ZbNNKAOCMO9aNPss=;
        b=B8JvbYdoYyeF/Jf1m6YwcZTsOvcreOjoWfTBBjEOAdHM7SyIcLGnz6ueMUy45BwHyk
         xvOyfN+/K5Y772uEUGC2ULrIa8EW6jkH5O7t7RyOG1ASy4h+1MHfrYPJXznLF1nLx0To
         8eDzHY3LH8M2BRJV1hTya/hKFoeSePxgnNHyCeSGmbisNEHcY52QJSLgwzr5kJme8fRR
         T1KLMoAQOPAk+2opO9Qst7o2suLuyWffFt+JRChjKBt54OUwehr87EBMgfHTAVDe2ugw
         w9IG3EGdotRMgBfKu26ByFi8PjrWoC4o/wogcjuyqohaR1GJnt8Y6MoTGI8u/cJgsxRO
         ++mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740075783; x=1740680583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+brjcpA6Li4VmWmcewwernBTel3ZbNNKAOCMO9aNPss=;
        b=kTY8jZzUNBdjjRWQD/OMt7XMvW53E7YhoaCflOKZgZTiv9C6G4V6yTEcvm3v+bGHR6
         10NzdONIgWZzfp1auXE9xS8L5wSjufCYlWubMsdysNVQWKdi3z6EmQlvkQ6L19fpudj3
         utjrXxBxIVpeHmowWJSwiyGJwzlctw3Ei/Q8zEpMUFOPn3/G9V6aAkbA4Ffppoc81/10
         m+ct/IOF704v8AKNN5Uehq+x3wBNbJM7hmc13so/xJ3J6iu6lAJDUEbUx3zSMwm/HKcY
         OoDA9/BJ+xJgFHVhCulZJe8kzK7SK5sKKS1OQCAA6vofbxmbWdr+c19exMdr59KLaTJu
         Nlhw==
X-Forwarded-Encrypted: i=1; AJvYcCUg3LM0/XBxruG87mjzDhGabqRhowhKNI5UrPe7m81SKGTSNFGco5vcCMD4FP1owtFz8ocR/g+qcbR+sOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDEHxaRJIX4udCgdMJfNuQ2s9yMFudgruJyafbf3mB466GGs9f
	KkpzZa3lqMILTePWIQawrFcnDhlc9pEEvC0j0Ocxv6Su/shAftL/tu/ewSkBD2E=
X-Gm-Gg: ASbGnct5GSBYysonZDAopxOg7YWn2S/COAFZC5WQ+vUtY+cyJJgn9eDUdPATCNG3PWB
	scc/ogTlNrkigo8cAb+ONjjdcAY2e4uNry0okhUEX+A2b9PdL5sH0XPOLnMjNKKAh83B4RIHfFc
	qU/yWrl2TNSIW2d8eOiMUbif9mlOOemJLC03Xy2wAgG32Ip8hGCuHed1I7C+EiWwLiEwldoDnyT
	/74wr+2TuPrVLbI3rG50Q6RV8+yldxweSaFGOyy6kTUoBj2mw8zD1CHWdCF9QrlESwPkLQeDxm/
	YxuIyCpSnhSi9lxfy9KN8XUl6A==
X-Google-Smtp-Source: AGHT+IE9M+E7TrIj5xPmzAisbrDh7wCmSL9KAsAbD2jI7mD1njYkys7UD3bLih4YqYoexzYiUnH7Ow==
X-Received: by 2002:a05:6a00:4185:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-73409cca8dfmr10560814b3a.21.1740075782993;
        Thu, 20 Feb 2025 10:23:02 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7328acf354esm6281724b3a.3.2025.02.20.10.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 10:23:02 -0800 (PST)
Date: Thu, 20 Feb 2025 10:23:00 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Subject: Re: [PATCH V5 1/3] riscv: mm: Prepare for reusing PTE RSW bit(9)
Message-ID: <Z7dzBH7SNN7SP3+5@debug.ba.rivosinc.com>
References: <20241113095833.1805746-1-zhangchunyan@iscas.ac.cn>
 <20241113095833.1805746-2-zhangchunyan@iscas.ac.cn>
 <87frl0snf6.fsf@all.your.base.are.belong.to.us>
 <CAAfSe-tRFEXiXJ=tHVnXy4Kb6O7-E2Sr_xybLYxma=ypMhqz9w@mail.gmail.com>
 <Z6rLlkphtv99+bH3@debug.ba.rivosinc.com>
 <CAAfSe-sf+4QY9eif_XaRGXEUn1JyPn_Jj+k2MOq9mfDR2Bd6yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAfSe-sf+4QY9eif_XaRGXEUn1JyPn_Jj+k2MOq9mfDR2Bd6yg@mail.gmail.com>

Sorry for the late response.

On Tue, Feb 11, 2025 at 04:05:02PM +0800, Chunyan Zhang wrote:
>On Tue, 11 Feb 2025 at 12:01, Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> On Tue, Feb 11, 2025 at 09:20:22AM +0800, Chunyan Zhang wrote:
>> >On Thu, 30 Jan 2025 at 16:42, Björn Töpel <bjorn@kernel.org> wrote:
>> >>
>> >> Chunyan Zhang <zhangchunyan@iscas.ac.cn> writes:
>> >>
>> >> > The PTE bit(9) on RISC-V is reserved for software, it is used by devmap
>> >> > now which has to be disabled if we want to use bit(9) for other features,
>> >> > since there's no more free PTE bit on RISC-V now.
>> >> >
>> >> > So to make ARCH_HAS_PTE_DEVMAP selectable, this patch uses it as
>> >> > the build condition of devmap definitions.
>> >>
>> >> Heads-up: It seems like Alistair's series [1] that removes the devmap
>> >> PTE bit will most likely land in 6.15.
>> >
>> >Yes, I've been keeping an eye on Alistair's series, intended to update
>> >this patchset after Alistair's patch that removes the devmap PTE bit
>> >got merged.
>>
>> Please keep in mind that even after claiming back devmap PTE SW bit, a compile
>> time decision to select between uffd-wp and soft-dirty is not desirable.
>
>Yes, I agree. I've read your aother email. I also hope we can have
>more RSW bits to use. So should we add uffd-wp and soft-dirty support
>on RISC-V until we have two RSW bits for these two functions? Is an
>undesirable solution better than no solution for now?

Problem is that this undesirable solution doesn't solve anything for *most* users.
Kernel can't deviate from providing functionality (which is actually arch-agnostic) to
user mode depending on the architecture.

>I can optimize the code when we have more free RSW bits, that's not hard.


We got 3 use cases,

- pfnmap/pte_special
- uffd-wp
- softdirty

4th one for devmap, I hope we don't need to do it. Should get it back.
https://lore.kernel.org/lkml/cover.95ff0627bc727f2bae44bea4c00ad7a83fbbcfac.1739941374.git-series.apopple@nvidia.com/#r
It looks like any work there would be wasted time.

There is a (fast track) proposal out there to get 2 more RSW bits.
https://lists.riscv.org/g/tech-privileged/message/2268

I hope it gets ratified soon. We will have proper solution to this problem then.


