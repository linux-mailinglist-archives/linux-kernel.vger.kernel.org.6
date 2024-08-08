Return-Path: <linux-kernel+bounces-280224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B3794C763
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EF51C22887
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB0B15EFCD;
	Thu,  8 Aug 2024 23:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZC2cC4bb"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E4146D55
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160009; cv=none; b=UfZQNfwL4DPnDyYvCoMz9r4lx7gn/EgzpyB1l38U0KobCUBpte3LyIJ+hKLjuXIIbLYJiBiRfipMGRQlsEbmLobhzcQh/Fv/LZALIt7laqoAvREbyCxqK3V1SzDh8uhSA9xkImf7J2d9dIG+sm6ZDEmuTklCFOQAplehuP0fNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160009; c=relaxed/simple;
	bh=524bUS/jikPk0prhYgnLoimooCyCKUal6MFrC3vnAWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjqJ7P3kccn+2JzUuQLyEvhytA4Lubp5r/BP/Pnyq4zS+lkGhimRbY/aDO/LvsEPnmAu+LRkRjLvQyNRZg7UR2H9igtpqgcrGEr7xPUUvD66xizgfjmeTpo63EztNB6o9VMJCFT0h0Nujfj/Zp/d12yij3A4Ag7JO/zH1vvSCT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZC2cC4bb; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so2063088e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723160006; x=1723764806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rqlZbaQMZu+3GtlIS+SGt/2J89sdAOurpYSJPp/fzz4=;
        b=ZC2cC4bbNr9T6tDiPiGPyCTs4nkUnDyTCwyVRaEPPTbTgE7NPrZpaHRGh6aYt9dXCG
         4ZpTr+QryMp2OVvTVxL012oJ+NiSBqeaDu4/w4TxN1wUrxuYdOQ6sq63ZyBXWDh+ZuIJ
         049IDno2gSi3EeVFFJYFss8Fp0lcWou4J7tfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160006; x=1723764806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rqlZbaQMZu+3GtlIS+SGt/2J89sdAOurpYSJPp/fzz4=;
        b=A6L04eunyqxitVAo1fpHccaS40b9mc7ROYJqcrt9E+vaVnQ6aKQl+I+O4nFncUq67t
         P9hrw/gaHUpCC/DdYO7Nm+C6LjiaJA5lSgom7FLxNnb/EJRZNSntb1rsKy6z6v4lKmSm
         kjj2rRY10THBQzfR1ZLj/5Jf1qqLHeIeCL2vV+bSiypbj+0KYu0TeOKp/QaiNSx48ABm
         DGYfkEeuJNp/VH6D7DRRhawlmSvwk3bA+6co2gs1UEPtuEw5heWh/rfNT1ShqcZBQ+pf
         NNXwZ9iYdvkO4R2OQCrciWuC/MCp3vRr4GCt1rvEjwlkUHt5vcktnwKR0M8gxzBmbqM6
         946Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXaT2Bva89gtqdbnXB14ecLFOMGFMps9k1omklm78l0Odc8v9/c3xbLoFja+9vW1NYVzyCy+f27PX0nDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgRfBLw4LADBKGBs3xluwJqVgRpCVw5oXBVoUE4ECweaBtta3
	jykkhFcSWqPgYywRWpgeVLsHiwQ3R8DPD+nAQ42ofGBzFFD3kSt4iZgYRj+CzGFn4UZl/OLKc3f
	hR3G7rg==
X-Google-Smtp-Source: AGHT+IGIJIpBW71GcpF18Iq3MoQTRou05t4s7aEF6KIpaBUq0Gb9Aq5gLDUc5soqL9Llna+Lr4d5dQ==
X-Received: by 2002:a05:6512:b03:b0:530:db85:e02a with SMTP id 2adb3069b0e04-530e5875653mr2541197e87.22.1723160005642;
        Thu, 08 Aug 2024 16:33:25 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf869dsm1057743a12.1.2024.08.08.16.33.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 16:33:24 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so178821766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 16:33:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOUin+HxTdH3q4vnNOjOgCmHuGgkoprJy54fj+qYehRC/BxLiT27EdJD0sL1y8fzmR904QbsZJ4axm/RY=@vger.kernel.org
X-Received: by 2002:a17:906:bc02:b0:a77:db36:1ccf with SMTP id
 a640c23a62f3a-a8090e40894mr247283366b.42.1723160003998; Thu, 08 Aug 2024
 16:33:23 -0700 (PDT)
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
 <CAHk-=wi_YCS9y=0VJ+Rs9dcY-hbt_qFdiV_6AJnnHN4QaXsbLg@mail.gmail.com>
 <87a5hnyox6.ffs@tglx> <CAHk-=wh4rxXPpYatnuXpu98KswLzg+u7Z9vYWJCLNHC_yXZtWw@mail.gmail.com>
 <8734nezz0g.ffs@tglx> <CAHk-=wiZUidi6Gm_6XFArT621H7vAzhDA63zn2pSGJHdnjRCMA@mail.gmail.com>
 <eba27c56-dc36-4410-bb6b-cbe8769b8a6d@roeck-us.net> <ac7284f9-ba29-4068-ab00-82ddc839afaf@bell.net>
 <37f94771-4ebc-46d2-ad10-f145d139dd9d@bell.net>
In-Reply-To: <37f94771-4ebc-46d2-ad10-f145d139dd9d@bell.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Aug 2024 16:33:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiwG4-5UZY9-ZvnhXuGXMsu+u8k5b2BBL-jRcyagW5oxg@mail.gmail.com>
Message-ID: <CAHk-=wiwG4-5UZY9-ZvnhXuGXMsu+u8k5b2BBL-jRcyagW5oxg@mail.gmail.com>
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
To: John David Anglin <dave.anglin@bell.net>
Cc: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 15:30, John David Anglin <dave.anglin@bell.net> wrote:
>
> > I believe the shladd instruction should be changed to shladd,l (shift left and add logical).
>
> diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
> index ab23e61a6f01..1ec60406f841 100644
> --- a/arch/parisc/kernel/entry.S
> +++ b/arch/parisc/kernel/entry.S
> @@ -399,7 +399,7 @@
> -    shladd        \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */
> +    shladd,l    \index,BITS_PER_PTE_ENTRY,\pmd,\pmd /* pmd is now pte */

This doesn't seem wrong, but doesn't RFIR already restore the status word?

So even if the itlb fill modifies C/B, I don't see why that should
actually matter.

But again, parisc is very much not one of the architectures I've ever
worked with, so..

          Linus

