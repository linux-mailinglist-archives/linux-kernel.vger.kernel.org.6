Return-Path: <linux-kernel+bounces-385854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE89B3C99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 22:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2AE2834A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595EC1E131B;
	Mon, 28 Oct 2024 21:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MzcI5eq0"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9430E1D2796
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730150379; cv=none; b=uCpDP4W5uv9Eoza8wL5rNVvkLHz04E6ZZ3PJwnOFuRK/bSxCMPLaQya4RcUv/BV/TGY940xR3QqjVIiyA52xipWczxmSMxHyX8gGTh6/1TbBAq5GWTUZbd5N6V54lx8o3nko35uzhHxAko+pyr0rM1sZWUh7bMIqb2PbWMvx36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730150379; c=relaxed/simple;
	bh=qnYSOkyMUfx970F2JttE5wT/wD2MOoWszsIrP+Tu/YA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDYlf9zZ9+s4yJ0QdFQQ38y0M+7l/G/wOE3sClWBzJ7dDIzjsFNPLCnptlx9KEJzUO7/DkHmrT4srIZDP2lV2p+U8K9PTWoYUIsr+rdWDkduUq+HTmY6FvTZ2IIgi6mJgZsP0IpaSGh4n9ycyFvn21ilaTNLUVhZ+cqbBMLFYTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MzcI5eq0; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5cacb76e924so6088448a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730150376; x=1730755176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LzKMMOiYz+t4fL3FqCrSRgCEZ8AU86AJ+y2q5X06rvw=;
        b=MzcI5eq0tFgJ4pf637FmPOVYDDnvYq/P0AgO8PczEDoA+SdsG+kHUiQV0/RqpZpvBX
         zmN30L7curbDzqnCGxu7m2MhaevX+E8UHXSJdxcrTw/kUdNgpysMKUgtNAxeF+byE0/q
         kHvSeT3MLUqPhqQRHOijeV5BVlfCiN8uFJgoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730150376; x=1730755176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzKMMOiYz+t4fL3FqCrSRgCEZ8AU86AJ+y2q5X06rvw=;
        b=jgor86OXWGAykm1OpxLPAKnvdPA1IjuYk2MCrz3EV/BkajqpUvQYfyYq9pw2x3OiKA
         T4L4SmZ9t8KOam7wiP6gCR6OsNSS0HwNiFY5fR3zF4ch2Ey0T5QA1Plw900sfKC9EvjI
         LRTdmbKHHD+peF/IZisoMh8g50mRomm0xzPseh6VPaVZFotnEhYGV4Pv7Jo0FKnH/7Ix
         Adef45WuaLUJO/m32wpdfLiAFmKbaf9juNzO9WrRnBR0Ty9T0YG5KxVEJntHxzHRntFk
         6Lq9ALv/4M/Ds6FDC3drdA1eOrm5QfkWqrGAQeaCAaJato1RUuOL47ZBCXswovweTqYW
         GtGw==
X-Forwarded-Encrypted: i=1; AJvYcCU7bGUVTMNe2cY+O6P0Y+c/zhE8/OD/fjBvQnoEkMG4DWjH4bXIoQnIx7YUvcxBCcb2y0fPuiOhRLML+Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/AotPF3bbR3teGgx55y7RBULHQ5UfoKl4kTdMZvs/TLLr9YDW
	OM8fGo6Q3VBlYtOQawGmsG9B6AdLLhgL2Z4AwakX6X2/CvG+Cgl6Wu6mU7GA+vNKTdSwGXuJJGE
	AODvAXQ==
X-Google-Smtp-Source: AGHT+IG7/ALQyz4IO2iHWvF+zVKhZQKd3uqYphy2hidFfpJMhjUf7SV55vwTnOHDo1JXGWAXH8g0QA==
X-Received: by 2002:a05:6402:5203:b0:5c2:6d16:ad5e with SMTP id 4fb4d7f45d1cf-5cbbf8c616fmr6945264a12.19.1730150375716;
        Mon, 28 Oct 2024 14:19:35 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c4547sm3439460a12.53.2024.10.28.14.19.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 14:19:34 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso5642642a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:19:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6OMYuD8R5/q8Tb+TJMj5W5z8YMC5p26Gu3JeLW/B1LwCYojzCzTcj0aK3kUcLV8ZB2Wf78UDHFV56PK0=@vger.kernel.org
X-Received: by 2002:a17:907:d2a:b0:a99:87ea:de57 with SMTP id
 a640c23a62f3a-a9de5ca5ec8mr765253066b.2.1730150373413; Mon, 28 Oct 2024
 14:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
 <61461dcc-e455-450d-9c01-5465003fc31c@sirena.org.uk> <c24a174d-c8f3-4267-87ae-cf77fa587e82@lucifer.local>
 <CAHk-=whD9MrPwPMBgVG16T_u+my8xYtZg2tUGz932HeodVX7Bg@mail.gmail.com>
 <438f50c5-8b8c-444f-ae85-10e5151f3f24@lucifer.local> <57mgmdx7wgfwci3yo3ggkmcnm3ujamgkwcccm77ypvmer5tegn@opiq3ceh2uvy>
 <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local> <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
In-Reply-To: <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Oct 2024 11:19:16 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
Message-ID: <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region() error
 path behaviour
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mark Brown <broonie@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Peter Xu <peterx@redhat.com>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Aishwarya TCV <Aishwarya.TCV@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 11:00, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> VM_MTE_ALLOWED is also set by arm64's arch_calc_vm_flag_bits():
>
>         if (system_supports_mte() && (flags & MAP_ANONYMOUS))
>                 return VM_MTE_ALLOWED;

Yeah, but that should just move into arch_validate_flags() too.
There's no reason why that's done in a separate place.

                     Linus

