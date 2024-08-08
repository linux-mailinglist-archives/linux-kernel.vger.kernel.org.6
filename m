Return-Path: <linux-kernel+bounces-279867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4694C2C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2111F23A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DDD18FDA5;
	Thu,  8 Aug 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Fw0ZBUsf"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A6A18E04F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134825; cv=none; b=q0GzAt6oIKakKGgqUBxJOfBtfsxre7WH1dXOZOO9KBFyg/6CiLgGgk8/YQsyw8JKrL/kkgr+yxR5VI64c9JRD3oPmWR3TwPm4w/Ya0MjXCwCU5oU67t51b0otTyNyjlnHdkcf/JUSa3uA0yuTLBihT89tm/1/g9MVm5adUjP4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134825; c=relaxed/simple;
	bh=Cp3sfqfHLcsGlvsmYor99GrDX4MiXqgqAEXC7IaeM1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ON63NN84LXZ+weaHNYNSpJTUbE9MIYCpTLnWK2h6bbNskyxRIeyGZsaGjvB+Pw87b7uqSraWNN8BVqLez7u9GEEJ6siUIjEKqu0UtvROydWEz4XqZnhdccTctiSfm+F36Iau+WZ00EaMyXbhYuUG0OQJxHeDeGx2NGhxt+OzC4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Fw0ZBUsf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f032cb782dso12402161fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723134821; x=1723739621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdSF9wmMV90yZVPB/6CkjluHABOiI6a5iFzuYp6vi/A=;
        b=Fw0ZBUsfsJBRJUVgKwkv/1bomPn6bXmjn+W5TpX8aiT3852L0NWy+U6hKsJuv98vnn
         s29mcY6GSwNA2KKP9msDpdjbDwk7dRXCEUKd1lo1MCbtXD9ULMJcrVq2LKydMk5XFRvX
         u0B1jJFDeHwkXaaWk53vO21uL7rs9a9AEc9dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134821; x=1723739621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdSF9wmMV90yZVPB/6CkjluHABOiI6a5iFzuYp6vi/A=;
        b=Bm/Oh+uQfHvBYfQzRo9lZBlh3XPJdf226rS/ISv9SGzc3r5Ya4SH/d59bWx3GxhI37
         M59ZIwxMCFN9QmI12CkoV6WjbHC/zqT7Fr4C5tS6nCCJbP3SL6eBYuHVgJuOCn938hCL
         s1O7c49AnezG/KB0EkT890G8VYhFOnHlQEzOtJdbmTEuHe0qOrR4hG9MsHNasrnL+/4h
         AiToQ70GQ985X87sYLcy5VWsJPH/ezqSa99+qpORv79y0uI8+7MR4MyMxBt9rnq+qzoe
         PD6ixTJtr464UfU2Z/wkg8X9LHjCq4dgkAgzooQd4ht6SE9WJY8GfwmeV/6hJAW6F/x3
         thsg==
X-Forwarded-Encrypted: i=1; AJvYcCVZHaRCRp2EIdgZNG85wX+OwGpy3jgIFJU/j4NO4COwozSlowgqdFXPV88/FIPU/g8MdcQN7QHtCTvx/rCrb5K+3IJWtfOgxuGOpPYV
X-Gm-Message-State: AOJu0YwXB1yeU/v29ZFv3EyubHZmacHmzo1+A2CpBdukkR6GNglaLZx0
	Oz0SPyo/3VjFN2eECMO++nHwZsUi8O7VrnT6P/lEzao9tidzH3JIl7tF3GKYvhSFVctobq7nQGb
	mGb9mMQ==
X-Google-Smtp-Source: AGHT+IEZJa1FoJq6XofrqkT96P5ftDE1h+qWUUo3EeOr7LsoEcnaT2XhO1mmkaPqXQboM7LrZFylKQ==
X-Received: by 2002:a05:6512:114b:b0:52f:2ea:499f with SMTP id 2adb3069b0e04-530e583c1c1mr1775272e87.24.1723134820816;
        Thu, 08 Aug 2024 09:33:40 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c0d5sm757672566b.48.2024.08.08.09.33.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 09:33:38 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so129736766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 09:33:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXfKTPvgaHYDwnYaE9e5SBXquJIVOUp3tVV8IWEan+iUuRvtZn+yOPt/Q12pOGs0n+lJw+aMvjn/1kgqZB4R6tKn8hGhy2JJ6D30xzL
X-Received: by 2002:a17:907:3f10:b0:a7a:b070:92c0 with SMTP id
 a640c23a62f3a-a8090c825b8mr215179766b.23.1723134817798; Thu, 08 Aug 2024
 09:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731095022.970699670@linuxfoundation.org> <718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net>
 <CAHk-=wiZ7WJQ1y=CwuMwqBxQYtaD8psq+Vxa3r1Z6_ftDZK+hA@mail.gmail.com>
 <53b2e1f2-4291-48e5-a668-7cf57d900ecd@suse.cz> <87le194kuq.ffs@tglx>
 <90e02d99-37a2-437e-ad42-44b80c4e94f6@suse.cz> <87frrh44mf.ffs@tglx>
 <76c643ee-17d6-463b-8ee1-4e30b0133671@roeck-us.net> <87plqjz6aa.ffs@tglx>
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com> <87a5hnyox6.ffs@tglx>
In-Reply-To: <87a5hnyox6.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Aug 2024 09:33:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
Message-ID: <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 09:12, Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > But it looks like "$$divU" should be somewhere between $$divoI and
> > $$divl_2, and in Guenter's bad case that's
> >
> >   0000000041218c70 T $$divoI
> >   00000000412190d0 T $$divI_2
> >
> > so *maybe* $$divU is around a page boundary? 0000000041218xxx turning
> > into 0000000041219000?
>
> It uses $$divU which is at $$divoI + 0x250. I validated that in the
> disassembly.

Well, that does support "maybe we have a page crosser issue", but it's
not quite at the delayed branch.

Because that would mean that $$divU starts at 0x41218ec0, and that
means that there are 80 instructions from the start of $$divU to the
end of that 0x41218xxx page.

And if I counted instructions right (I don't have a disassembler, so
I'm just looking at the libgcc sources), that puts the page crosser
not quite at the delayed branch slot, but it does put it somewhere
roughly at or around

        ds      temp,arg1,temp          /* 29th divide step */
        addc    retreg,retreg,retreg    /* shift retreg with/into carry */

so it's around the last few bits of the result. The ones we get wrong.

Which is intriguing, but honestly, I don't see how we could get itlb
misses horribly wrong and not crash left and right.

The $$divU routine is unusual in that it uses that millicode calling
convention, but I think that's just a different register for the
return address.

And it obviously depends on the carry flag, which is pretty unusual.
Maybe if the ITLB fill messes up C, it wouldn't show up in other
areas? But the $$divU result error is more than one single bit getting
cleared.

              Linus

