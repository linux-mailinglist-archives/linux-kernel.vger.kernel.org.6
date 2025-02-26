Return-Path: <linux-kernel+bounces-532944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69258A45404
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F79E7A73D3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DACA25A2D3;
	Wed, 26 Feb 2025 03:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWje9NKn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B53579D0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540683; cv=none; b=mEPIjqS3p9/gnhmnFWiO3rQTVaduPAMeJLSOWy9RroDW8GH2tzrNhXSg5U24SChWVQcLwUIAknZ77v68gHHCIdr3Ib1NqKqqD1n3fXK1EOIDlZldXdEPWMdx21JUdGyl/7QEQWTtmXt0bWbr5znPzfoEcgccPxAZNHuTBHc6kbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540683; c=relaxed/simple;
	bh=nP8hKiHVK/7riq8c54PWOVWLM1kaMXn8xcuMQlrcJkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikq27rn0NTce4Jx2Tg2x/YSaaPgySrdNDWMbSu6QQVMMZ5DfKhqvsvpkRYswZW2uUY5peT1oLumq7ubtxc3bgfbsu36POOHoSInO2zRvMVHcWcMSeOPqhnmhmGmBZvFTDrtrvCsDwWDRtZy8aI8O9Xlo4BEtAHSd8EHcEOe1uh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UWje9NKn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab78e6edb99so897642266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740540680; x=1741145480; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w4woczAwWEwp1Ji8GSgiXmrdqEqLfYh+FgmTaBo87qg=;
        b=UWje9NKn63AfBGAm+jfv2v+TVuYBXdrP6CCEvwmtPIp7EzK73MzN2Y51VTyVWdV4eE
         KK81FkVFZLntOA4JEPGwkm/nI4GjgBgaiyMqkO6WkELMGUB0x8/OcSEVmMk33cVKHzGs
         PTbVRxUV4kdwrx8gbfY9tb5PMhM/DwOylc4jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740540680; x=1741145480;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4woczAwWEwp1Ji8GSgiXmrdqEqLfYh+FgmTaBo87qg=;
        b=IVwgA7pfNe1N2yRIekdy7CahjoZNqKw+XAvvXobIdgudy0AngjaeK3fkvCPLa4LvUB
         0Jf+Gv0K9L16pO3nDRG9ZBX6WPV+9zVYN1Gqa/CKORFBncZkt5KUoqFErrNQkyI+Xaup
         LDTSzviVLRSo4kR4Av5+L2W1TQJFLe0gVWiqjvwicNMAzwspD6F01PFaWeiS27pwINTZ
         Bz+SYts19s7/FTagXk9x2sSEC04X7uj7MWcYAgDzJFBzQ5sD6JO5J/mo4o8UZr9wlwF2
         VvZ0SpYWmPGktAxxzoe687TeZQsMfShs/MAdTJUmU9ArlTy2upGk9fYnFmJ1XuWyK+y2
         Bjsg==
X-Gm-Message-State: AOJu0Yybpr7ZCWUXP6/ZKvP3ZWmgcvDk/rrnIWnwhrVgz+a+ApydIa/m
	8+xvGu7x0sztbrLNTJ08QhSP0R9+Uhfxe9BJXFtnATY+Hhn9VS84rl1dgmxjXy43pXwMqF8wfJH
	G1ds=
X-Gm-Gg: ASbGnctbGh8cHJlToNBRM+SW4MZHuqaV9IFW5V6nHPyru7+OOtdglhrhDM+Hb0SgaHT
	cC/lCU/bzrmVb0nXYmddXKC8EwIgk+KDPAaNpTtBP2oK+xMo68Ig6ZzNLboxHqtlxq0lFYBm86A
	ewGvZRf9lkoYE46hI/iFhw7ce/1NunVN1ANBqB67mdjwbFp59dZhFz9FNv9MS2EOhUNyrQh2RI6
	IdfA8kU7adP4i+YvHVMiLHqP+GKNzvMghfj2eWJLeJf6OJQLFwzM4PGigb+p/di+AtBfL959wwf
	g0ClYUlmfMFjLgjo7ihPLW2tqD5pQqaVl8hghIAFZfW295qAjs+f7nMQ/eklguhnWjW2zYfiVlq
	E
X-Google-Smtp-Source: AGHT+IF9DtcnciHcVf6m5FbBpawM02ny/33LSyl7kSxI2akHfq0kwuzziUeTxOMt6GsWpEqr22cksw==
X-Received: by 2002:a17:906:318d:b0:abc:a40:4193 with SMTP id a640c23a62f3a-abeeecf3eb9mr153963266b.8.1740540679697;
        Tue, 25 Feb 2025 19:31:19 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cd5fa7sm249235366b.35.2025.02.25.19.31.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 19:31:18 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so8543481a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 19:31:17 -0800 (PST)
X-Received: by 2002:a17:907:3e0d:b0:abb:b209:aba7 with SMTP id
 a640c23a62f3a-abeeedcf3bbmr123763066b.26.1740540677605; Tue, 25 Feb 2025
 19:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174051422675.10177.13226545170101706336.tip-bot2@tip-bot2>
 <CAHk-=whfkWMkQOVMCxqcJ6+GWdSZTLcyDUmSRCVHV4BtbwDrHA@mail.gmail.com> <Z76APkysrjgHjgR2@casper.infradead.org>
In-Reply-To: <Z76APkysrjgHjgR2@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Feb 2025 19:31:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
X-Gm-Features: AQ5f1Jp7I0ja65q-0RHKbtvWFR7GAuhvgls2dzRZEZ_p4USgiAWwx3oIsJSdPXE
Message-ID: <CAHk-=wj+VBV5kBMfXYNOb+aLt3WJqMKFT0wU=KaV3R12NvN5TA@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Clear _PAGE_DIRTY when we clear _PAGE_RW
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 18:45, Matthew Wilcox <willy@infradead.org> wrote:
>
> Are you saying that the PTE dirty bit controls whether the CPU flushes
> cache back to memory?  That isn't how I understand CPUs to work.

No, I'm saying that dropping the dirty bit drops information.

Yes, yes, we have the SW-dirty bit, and hopefully that is indeed
always set, but the way we test for "is this page dirty and needs
writeback" is literally to test *both*.

        return pte_flags(pte) & _PAGE_DIRTY_BITS;

> I don't understand why the dirty bit needs to be saved.  At least in
> the vfree() case, we're freeing the memory so any unflushed writes to
> it may as well disappear.  But I don't know all the circumstances in
> which these functions are called.

I'm not saying that it needs to be saved.

But I *am* saying that it needs to be explained why dropping it is fine.

And I am also saying that your explanation for why it should be
cleared makes no sense, since two out of three cases also cleared
_PAGE_PRESENT, at which point the whole shadow stack issue is
completely irrelevant.

So please explain *why* clearing PAGE_DIRTY is ok. Don't bring up
issues like the shadow stack setting that is irrelevant for at least
two of the cases that you changed.

If all of these are purely used for vmalloc() or direct mappings, then
*that* is a valid explanation ("we don't care about dirty bits on
kernel mappings"), for example.

               Linus

