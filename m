Return-Path: <linux-kernel+bounces-261895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913193BD89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6B41C21984
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9EA171678;
	Thu, 25 Jul 2024 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aUfVlSLS"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B2101F2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721894482; cv=none; b=VpfbabgmZVrJaTwUDc0e+ZyOQx66tn6afugQgYTD38njUuSsF5GMtV3oAp4tHEa/zwWPJRlqnR+XLU8VHaPoQHjCUh2T2pqurRAUfd5W1Q3fVzwoaJfFOFmNLj6NHnhHcO6lEk6okix5hNemdCHsMN9lfY01HFHpmUJar3l+Jok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721894482; c=relaxed/simple;
	bh=npkVM7gGMbMxc+smSDTLW0bM0295b37GHeFAWgi8Dv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFdYddksgzh5k6KIi8QRIeaeLmabRKCsG/GJ5muAIUbhdiVD3ox/S+3ejGrzMVVxdrfAJrQ8x0vqCIm0XplBimhCY3vjazN1yOKCEy57Z1xu/NHViQf6p+fsPvKFZqKJ2I29wesqIDOK8vBGEDP4z/aeb9r1McWfrQlpfc6Tnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aUfVlSLS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so9040661fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721894478; x=1722499278; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1rcRioImMxc/6ndik9rsNgcLsBY2YiVPz+IgBUsue8c=;
        b=aUfVlSLSwmH9//CYucRP5E6h4/X+Cu7s0Tgm/ewyJOSrZWLiyuq7E3xQx1GpX1D7rp
         MVJ6zJji7G6nphKbpLWrMqbEEIKBDKsO9GX75mHybC8JL2UV91YOKcMM6KWyp80KHcFo
         42awaRs8dK85XEzQ4m7DHg9AxLKFynbdvfOiudP0zj/xC2CqLREk6aGSVv5cjgdXRl6Q
         AQF2khR/UeLpP8ZZOjUhxQvPS0B8HuJ/2P+h09G3KFtlbFi/qVMckRnYxWlNSY/1qyEq
         X93jJg4V73f31CNNzuyeGF/6jmiZEZ541I1S2Ak7YiKSUJhNhEYaRPd1K0KlfMTDuIk8
         DYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721894478; x=1722499278;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1rcRioImMxc/6ndik9rsNgcLsBY2YiVPz+IgBUsue8c=;
        b=ITTZAr+X1N66Zp17XkhfB+dG8RUjj7wG0GkAmArNiOET8l39+8uAGIsWp+LE0rUfe3
         GLdGtI6rKPj5/B03BSDUF+BnKAhnrGDw6P21sPh6fWAd6neiCaenq7ceEh/02e4i8AMJ
         5KymzbdxjhoF8CVX1cuSULnMXyoqH3uXJARs6DbXl6urfBtSpsX9y/U7oCBGez+19Hlj
         u8iOKmTiXKWHU7uN0JzCyvl+L2DUbf+MzPHCMV4gNr6tfzqYLeWc2T6OUYhoGTFt9gzp
         SnAp2ie6MM09sKRV9WvKRWJjdfAAfeXEPPYULjqnglwXhE8/FhYs/D09Q6viaCSQ/TPX
         JsPg==
X-Forwarded-Encrypted: i=1; AJvYcCU048sFX8qwol5jhtVR9yrWQph43BSCM6Y4RdRtHI/G6NwRqytS0WZikVQZFf27p38oQ3cNygWtbyuYaQc7a2RF3CrWgTVOR9A3UURd
X-Gm-Message-State: AOJu0YzGQfv2QQnqw9CGMRgZK3RYTT5mLiwomkgb4tZFlFMxPfL41v86
	CANKK3HliYBtxws1cSHo/RdVU4DNDQbAJtLf7tezA3de4Ex2FCrQn2mJ5fufmQA=
X-Google-Smtp-Source: AGHT+IHcNb2whkudlAoX0PIxv0wM+WiJHVbabURN52CZ95xVY0/XjQG7ggcKAuwehZjH4LmIdYalug==
X-Received: by 2002:a2e:3603:0:b0:2ef:2dbe:7455 with SMTP id 38308e7fff4ca-2f03db56305mr10047511fa.1.1721894478341;
        Thu, 25 Jul 2024 01:01:18 -0700 (PDT)
Received: from ?IPV6:2003:e5:8729:4000:29eb:6d9d:3214:39d2? (p200300e58729400029eb6d9d321439d2.dip0.t-ipconnect.de. [2003:e5:8729:4000:29eb:6d9d:3214:39d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23394sm44719966b.26.2024.07.25.01.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 01:01:18 -0700 (PDT)
Message-ID: <a249e651-a2a1-4ea9-b262-0d04a8abaf0e@suse.com>
Date: Thu, 25 Jul 2024 10:01:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/xen: fix memblock_reserve() usage on PVH
To: Roger Pau Monne <roger.pau@citrix.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20240725073116.14626-1-roger.pau@citrix.com>
 <20240725073116.14626-3-roger.pau@citrix.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
In-Reply-To: <20240725073116.14626-3-roger.pau@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25.07.24 09:31, Roger Pau Monne wrote:
> The current usage of memblock_reserve() in init_pvh_bootparams() is done before
> the .bss is zeroed, and that used to be fine when
> memblock_reserved_init_regions implicitly ended up in the .meminit.data
> section.  However after commit 73db3abdca58c memblock_reserved_init_regions
> ends up in the .bss section, thus breaking it's usage before the .bss is
> cleared.
> 
> Move and rename the call to xen_reserve_extra_memory() so it's done in the
> x86_init.oem.arch_setup hook, which gets executed after the .bss has been
> zeroed, but before calling e820__memory_setup().
> 
> Fixes: 38620fc4e893 ('x86/xen: attempt to inflate the memory balloon on PVH')
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> While the commit that introduced the user-noticeable regression is
> 73db3abdca58c, I think 38620fc4e893 should have been more careful to not
> initialize the memblock ranges ahead of the .bss zeroing.

Reviewed-by: Juergen Gross <jgross@suse.com>

I'd prefer using 73db3abdca58c for the fixes tag. Otherwise you'd need to
add this patch to the stable branches, too, which is technically not really
needed.

Additionally I'd like to drop the Fixes: tag from the prereq patch, as this
one doesn't really fix anything.

I can do both while committing.


Juergen

