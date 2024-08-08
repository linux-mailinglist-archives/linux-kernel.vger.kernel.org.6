Return-Path: <linux-kernel+bounces-278832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3AC94B568
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 05:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B054283102
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD1442AB0;
	Thu,  8 Aug 2024 03:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="USKEaFCQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F326AF7
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 03:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087283; cv=none; b=TfiIfu6e2psJPMQvqLB5anf5a3rGOJc7H7txKHapas8mRTVZcJ/hUEJEirPG88mwT6gvreyi3zYUHnWl2EQydhYsRaJmb6wMKgyjamednSJSkgycUmp31874Uj0ttMezb412nIc5KvLCt0aRd5jvaFBYfCi6HFpd/D/s9RNHvqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087283; c=relaxed/simple;
	bh=A5Bg/vquHtT7u3bG5Y3/Vgb4L6XwAAGGX+IQK+8QEKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=r6pEqwXGOs1ogsSPcGOpt/uIXb+XFjA0k/afK/+e8NTwPd7qMnRLkhyigtZxzBYPLzAy/0UE9f5x5yBql/bEXuF/DUuOyh+k/pcmmJfnes1+7uF4UiP9hApEzgnZf8A8eWx6HxEptlQL+2Rlkp14Qv75XriP7P4CIbeytJO8lXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=USKEaFCQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7ab76558a9so73015966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1723087280; x=1723692080; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bEY+KUHesW6wFlestGyrYRGy6nQn6hbsGHFH7Mo5eLw=;
        b=USKEaFCQJorPeCP1QQtVOGpBJ2LJNgA49cReWaW7HsqcIk3d5iZ49Ga6fftaKcFn9O
         ZSnIhyn4FW/uC1dOavgLCaqvJxcNljct8JEQMSxNtFEpZ46uzfnc34A74CXytcEzzGHx
         XwUiOdxlXHt2Lfxszb4NuaG07/c79aS2VOECs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723087280; x=1723692080;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bEY+KUHesW6wFlestGyrYRGy6nQn6hbsGHFH7Mo5eLw=;
        b=BXQP2IzqUOz2oTIwHe0FwgudxTjeIrJxMHZW0WQhOKWULg9bzOEkDgivBYRTgQxfMh
         4mKnXFW0cbojo7vGPbDKzMn40OK1rcRgFSNNJrn00prCzNR/we7KRxYWN8cuMIldWIAI
         vmZonPFhJbTFy647MWduiAnUE2f7ACb6bt0LV1DYi5w4jnUlMfldydVGxHd2hBuwACRO
         xH3UIjwdXLKQT4jpIJfQH0/nhe465qTeI0ecJXvoPDu7T9hL6N8zQfonidQiBtWC0PTV
         VeL/7yGyGvVXHvaOUlsM+csm0s0HkXItlYjJ/I6V++Aqvaf6XyycelL/cNfB5+Fw1U7J
         urrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIRP18i3P5myKjdeq/yANqGo3DLKCbH6HjIGSNmIbjw7DMD1krGQSUyPS5fGU99SQItuIiaJHqnuK6l+qymCYcTCxX7VLwBTDeCj07
X-Gm-Message-State: AOJu0Yw1aVsizOIASQmTzhnj0Zceu3ZCmIdLycEEbhbki+cfzMHTxB+a
	xKV4dIms08PkaCqh50xaqxCQBZRzj6OErZrjxLMlL1Ndpfex9NoLiK8hQjUz23VWQ2uxo5GUoRA
	ROKRplQ==
X-Google-Smtp-Source: AGHT+IEK/iEizotRuaMjCH0E4nxwj2JTXO7h03gYymQZpU39DgXmn4FdUEMvCLPs+Ggq3QFEiYvMng==
X-Received: by 2002:a17:907:da1:b0:a7a:a2e3:3739 with SMTP id a640c23a62f3a-a8091f226e3mr31934566b.20.1723087279848;
        Wed, 07 Aug 2024 20:21:19 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecad25sm696072566b.221.2024.08.07.20.21.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 20:21:18 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so79392866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 20:21:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7QnVRJ50ukG3bLoaPvQGlV1VgALz9ao25PoRXn14F18cZ77svDW/aW13EabCUfANhHK/MubGDd080foV3GhpnZx0nTr+Vf5kYfWf6
X-Received: by 2002:a17:907:7e84:b0:a7a:b18a:6c with SMTP id
 a640c23a62f3a-a8091f19b40mr30722666b.16.1723087278507; Wed, 07 Aug 2024
 20:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807124103.85644-1-mpe@ellerman.id.au> <20240807124103.85644-2-mpe@ellerman.id.au>
 <CALmYWFsCrMxkA1v58fJxtyGR15ZGxmSP8x7QC=oeKwzcwGL76A@mail.gmail.com>
 <gtz7s4eyzydaomh2msvfhpemhiruexy53nutd3fwumqfpos7v5@4fnqun2olore>
 <CALmYWFvqoxyBf4iP7WPTU_Oxq_zpRzvaBOWoHc4n4EwQTYhyBA@mail.gmail.com>
 <babup6k7qh5ii5avcvtz2rqo4n2mzh2wjbbgk5xeuivfypqnuc@2gydsfao3w7b>
 <CALmYWFsAT+Cb37-cSTykc_P7bJDHmFa7mWD5+B1pEz73thchcQ@mail.gmail.com> <lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk>
In-Reply-To: <lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Aug 2024 20:21:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
Message-ID: <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@google.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@chromium.org, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 16:20, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
>
> Okay, I'm going to try one more time here.  You are suggesting to have a
> conf flag to leave the vdso pointer unchanged when it is unmapped.
> Having the close behind the conf option will not prevent it from being
> unmapped or mapped over, so what you are suggesting is have a
> configuration option that leaves a pointer, mm->context.vdso, to be
> unsafe if it is unmapped if you disable checkpoint restore.

We definitely do not want that kind of complexity. It makes the kernel
just more complicated to have to deal with both cases.

That said, I don't love how special powerpc is here.

What we could do is to is

 - stop calling these things "special mappings", and just admit that
it's for different vdso mappings and nothing else (for some odd reason
arm and nios2 calls it a "kuser helper" rather than vdso, but it's the
exact same thing)

 - don't do this whole indirect function pointer thing with mremap and
close at all, and just do this all unapologetically and for all
architectures in the generic VM layer together with "if (vma->vm_start
== mm->context.vdso)" etc.

that would get rid of the conceptual complexity of having different
architectures doing different things (and the unnecessary overhead of
having an indirect function pointer that just points to one single
thing).

But I think the current "clean up the existing mess" is probably the
less invasive one over "make the existing mess be explicitly about
vdso and avoid unnecessary per-architecture differences".

If people want to, we can do the unification (and stop pretending the
"special mappings" could be something else) later.

         Linus

