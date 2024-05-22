Return-Path: <linux-kernel+bounces-186326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0AD8CC2C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F2C283236
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762B13DDC0;
	Wed, 22 May 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCKc+LOT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1B6AB9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 14:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716386779; cv=none; b=G0fcev3IHTBg0fXwICyNzPC03peflYMmUEcEVs0EpXvGRoX557Sa6AhwdzL3D15sdnAeb8iFBaw72XMc/FfRWhGUNOhuDom7Y6sGuK0LfgSxIGLyhVd1qddaA7CX3tPvfi6+lQs/uy4Zu/58DmidffIR3jmdlAV2tToPQwQHmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716386779; c=relaxed/simple;
	bh=yG+H6NXM+gADjyTua45URn88sT7dUFGj3GVYs9fsNpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ibf6oyfPnchua4rexpdHsjD3gsfWmuBoDzZSRwSgbNaeKvuj2UEOczdiZO4n7FCojrAIRwLB9/gO9Pnx6IOqD0yziLxzYriyekqir73Luydbk5FavKe+uZoUsrWbReRDnVQl3juRocdt0kP8Mt0t63OksnWoBFomfotZWWSBFBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCKc+LOT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so11092832a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716386776; x=1716991576; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGIHdh6C9kf3xohOy6zelPFZjDHpCE0/tlY+EHwmYFQ=;
        b=TCKc+LOTtw6BligeB+xsnXBtoEXViTjaPriHtN62JxNeW3ximREFScLRc8WF9vzuRt
         J6/HCIS680mVvUwRoNkAYv4rWGzy3zAOhvBe+cB97y8IyKm400mjfbfkLXPAWFZ2s6kX
         6386zYKgYkAUihyMJahbFWVf9f1ZeC1kfIvS5Fe7NyATIn8ntKhuqPwvFVRpAZR4NqL2
         +sE3tNqJo0JyuR4y4Z7PDnDFeXewIo+nJfhr9R9RgGsIspNXNA/QSNjF7TxB9N8Qpn96
         ZXguLNzTGbN3qj6qXvIKuSp/u4ooeeFmTrVSDn//4lJknfmodUcnvEOTkrAW47m5X+cZ
         HXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716386776; x=1716991576;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGIHdh6C9kf3xohOy6zelPFZjDHpCE0/tlY+EHwmYFQ=;
        b=FsmQ/klqeM0nTiRAj4XGBDpjWZJ0RKGEOjq8O5v59xkzMwybuQqd5r1seB+Ce+ZWmL
         PPHFdsa984ixH0NiPe302hnDRYTshqO2HmHDMvJ304Uebfy1VANYqtO1tXk+QlkYpw5s
         3t9hZ/tzWoRiFImvgLu8Mi0cQchr68qkI88zKO8Poqr2t7Ct/D/8z3CNAk37hhAc+OdM
         iPET4r89pf2Xn2jw7RI/gK/4uAQUYloqMe6ZcyDcYYqMn9aFLTaOu1twi3TDLnDZZWk8
         Rb2U0cSzhNlGuqwxY9lgB9eJLgSLsx0CQpNLM3ibmB85dHJ2gfPl0T09+bFYCpvKAcw/
         +p+w==
X-Forwarded-Encrypted: i=1; AJvYcCUFMtmKE0TO7cvCOe6KJ6SdNaRxXGohZpEp+7+z57413u7pFoeEBs1aK64gQjsFWbd9o3UGIqbNWVKVgAURb+Ou9VanOP0ytS13zhtX
X-Gm-Message-State: AOJu0YwcyYIGmf/riKptRHZlv/f211PnBj4XvE8arP1s/e2TYm/zk4n/
	c4eVEM0AjMhzUXmZ9xJmgVFa+i6wNxjOBXl67GC2N5L7HJKIyOu6
X-Google-Smtp-Source: AGHT+IEWudPD0sINnUPaAWCaDDLNOwas6gKTeSgxiwAtj1dxDN2wG+Rb/v9M+BSilFQh60VGoiRnnQ==
X-Received: by 2002:a50:c048:0:b0:56e:22b6:d924 with SMTP id 4fb4d7f45d1cf-57832a3fab9mr1297350a12.13.1716386776003;
        Wed, 22 May 2024 07:06:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57509d459desm8654687a12.61.2024.05.22.07.06.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2024 07:06:15 -0700 (PDT)
Date: Wed, 22 May 2024 14:06:14 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Yang <richard.weiyang@gmail.com>, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org,
	linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>, Steve Wahl <steve.wahl@hpe.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/head/64: level2_kernel_pgt's kernel area is built
 with _PAGE_PRESENT set
Message-ID: <20240522140614.fxe6tw6y5clrnve3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20240323232621.10400-1-richard.weiyang@gmail.com>
 <87jzjmgod2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzjmgod2.ffs@tglx>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, May 22, 2024 at 11:58:01AM +0200, Thomas Gleixner wrote:
>On Sat, Mar 23 2024 at 23:26, Wei Yang wrote:
>> The code is first introduced in 'commit 1ab60e0f72f7 ("[PATCH] x86-64:
>> Relocatable Kernel Support")'.  Then 'commit c88d71508e36b
>> ("x86/boot/64: Rewrite startup_64() in C")', convert it to c. And
>> 'commit 2aa85f246c181 ("x86/boot/64: Make level2_kernel_pgt pages
>> invalid outside kernel area")' limit the range from _text to _end.
>>
>> Originally, it does the check because the loop iterate the whole
>> level2_kernel_pgt, while currently it just fixup the kernel area. This
>> area is built with _PAGE_PRESENT set.
>
>What's the actual problem you are trying to solve?

Not a problem. It tries to remove some duplicate check.

>
>>  	/* fixup pages that are part of the kernel image */
>>  	for (; i <= pmd_index((unsigned long)_end); i++)
>> -		if (pmd[i] & _PAGE_PRESENT)
>> -			pmd[i] += load_delta;
>> +		pmd[i] += load_delta;
>
>Fixing up non-present PMDs is a pointless exercise.
>

Agree. While we are sure then range here must present.

The whole process looks like this

    pmd in [0, _text)
        unset _PAGE_PRESENT
    pmd in [_text, _end]
        fix up delta
    pmd in (_end, 256)
        unset _PAGE_PRESENT

Since we have compiled in _PAGE_PRESENT in this page table, it is not
necessary to check _PAGE_PRESENT again before fixing up delta.

BTW, if one entry between _text and _end is not present, we will failed to
fixing the kernel code pmd entry, which will lead to some problem.

>Thanks,
>
>        tglx

-- 
Wei Yang
Help you, Help me

