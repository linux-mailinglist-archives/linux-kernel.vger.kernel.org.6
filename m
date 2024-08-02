Return-Path: <linux-kernel+bounces-272676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE8A945FC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE6DE1C21DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66A52101B9;
	Fri,  2 Aug 2024 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gNDrCqKE"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D41C693
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722610765; cv=none; b=ChXM0nLsIo96QKwViIBx6UHsIExFXHdNoNU+OPEScgZERV3nmIDng5rfXv0krf7o5hkl4D0CS0JZ7vYcEuBPwOr5Zcj5fU5gxCvrFn4gfZ7UKWMjf5MJIDHZraRPDHFdkrPo5cTPf9FQJihlCyc5pAGZdAHk7YvUz5wHmDsJWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722610765; c=relaxed/simple;
	bh=ZdFsarV4vLIqgO0Q0TFdD5Ao9Pq6bc5S8VGAtEDPG7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOq3yRnAqmdQb1l5886jhgJUjfd6zLRb62TW9rXZSd4qUjZuOngRJdDWgvQ2Mv7CTyxnp+nSjcwR+wzv8g1/5wEiq+C0IJDjEwK96DEcMxTnXMxaGsyw5+f7JYQIUNqQoq8kge13vpS2NF7Q+scBASvGuRthyH67Hz/Kbzlb4V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gNDrCqKE; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5e1c86b83so4047671eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722610762; x=1723215562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Fufy5m2OV5adnD39XIC3KOkSG897ehk5PnPWDRKTeo=;
        b=gNDrCqKE6nhx+u2mLRF/a7Ij//2wa7f5sq8AaNkdtDh60UP958Yr2oKmQJf4FFda+l
         pf65Kr/iHRH5/lzrn6L8SVlAuXSxF3GxgTnGASQY/Fm6KmHatRl2qdSqxUrnHlE+x/QA
         0mvkZk0U94Whym+gZJyckOoj14Q6rstLCgWto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722610762; x=1723215562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Fufy5m2OV5adnD39XIC3KOkSG897ehk5PnPWDRKTeo=;
        b=LUTGbyH4PUZx3IqrSFIg8bcXdTJREl7RqsThWhUZ5n2Iyl8kfw/VgPlRys5ZEfEekM
         KbAkjJXu+TV+t2+gA7DBuCNHnpR0vJMibG/CEfFX49CKd03arha0zYwa4G7qH5G1rDE+
         yw/89BVKxYswmmPJIWZLF8PmB9akkpIYS013LCyCNpmtR9aevDwiY1qRaHy/4nTRydZ5
         7pGswA1in0HLCMMYm8BDIeBC19s1M5JvuqAwEFV8DGPWgSe5MtGvW2m8qJZDeEhv4VSC
         327hIe0shoz0m+DomtTW1D7sf/XdG+ieLFOVs8dWzVroT0uzVwtx6iHtdlRMvzaJr9PE
         UbPw==
X-Forwarded-Encrypted: i=1; AJvYcCUh/01N74XZT8974svRc5Q785dPETofkbS+Wh2pyNsXcwBRCkhYF8btNc8Mg6ahapT8J7JdgQ5uB5SCP+scyqMkIahcOvFyeZGEFrDI
X-Gm-Message-State: AOJu0YwA7sgAcxhCVAAbhE6Gu2LGCE/Gv+5m5Gg84xBZ/mqLeYZz4OeC
	emVO/UgnHc+P1crmKS+ww7t9zTjjNIRdees5mRUvo8cJT4Lp4I2cIjMAgRk7OvuW9hTfTBUZ960
	wcNrOfL9QtiTXv9RitKuXiFcfVCdPC4ph+WNE
X-Google-Smtp-Source: AGHT+IG7v+U440RJkotFtfTZE0KJzrQAJ//UGBiRZS6c0xmXngLp+KViHU3IZS02qx6h4QDwAuEDyYYE5rxrF9y/tYw=
X-Received: by 2002:a05:6870:3913:b0:260:ec71:27dc with SMTP id
 586e51a60fabf-26891f3ee4bmr4602532fac.47.1722610762244; Fri, 02 Aug 2024
 07:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkU9BRUnqf70-nksuMCQ+yyiWjo3fM4XkRkL-NrCZxYAyg@mail.gmail.com>
 <20240802090040.GB12343@redhat.com>
In-Reply-To: <20240802090040.GB12343@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Aug 2024 07:59:09 -0700
Message-ID: <CABi2SkXqkC3wX4wnhXTXrLSs-6PLO-Fj4g=Hcvqq=ppv4QWUzA@mail.gmail.com>
Subject: Re: question on [uprobes] special vma
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, srikar@linux.vnet.ibm.com, 
	Ryan Roberts <ryan.roberts@arm.com>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"glider@google.com" <glider@google.com>, Matthew Wilcox <willy@infradead.org>, zokeefe@google.com, 
	hughd@google.com, luto@amacapital.net, 
	"jmarchan@redhat.com" <jmarchan@redhat.com>, "rientjes@google.com" <rientjes@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleg

On Fri, Aug 2, 2024 at 2:00=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> Hi Jeff,
>
> On 08/01, Jeff Xu wrote:
> >
> > __create_xol_area() calls  _install_special_mapping() to create a vma
> > named [uprobes].
> >
> > I'm trying to find out the lifetime of this uprobes vma, e.g. when it
> > is created, will it ever be unmapped/remapped/changed during the
> > lifetime of the process.
> >
> > If  the uprobes vma remains the same during the lifetime of the
> > process,
>
> Yes,
>
That is nice.

> > I can call mseal on it so user space can't change it, i.e.
> > blocking munmap/mremap/mprotect/mmap, etc.
>
> I didn't even know about mm/mseal.c...
>
The TLDR: once the memory area is sealed,
mmap/munmap/mremap/mprotect/some of madvise will be blocked.

https://docs.kernel.org/userspace-api/mseal.html

On a related topic, Adhemerval Zanella has an RFC adding mseal support
for dynamic linker.

https://public-inbox.org/libc-alpha/20240731200307.2269811-1-adhemerval.zan=
ella@linaro.org/

> at first glance do_mseal() just adds VM_SEALED for can_modify_vma().
>
> So it seems that xol_add_vma() can just pass the additional VM_SEALED
> flag to _install_special_mapping(), no?
>
Yes. Before I make that change, I want to confirm that [uprobes] VMA
is immutable during the lifetime of the process, hence this email.

> But why it depends on CONFIG_64_BIT?
>
It needn't, but the vm_flags_t in the vma struct for 32 bit is full,
adding 32 bit support will make split/merge code more complex, (at one
point of RFC process, 32 bit is included but later removed),

If we like to have 32 bit support, perhaps we need to refactor the mm
code to expand vm_flags first.

Thanks for your help !
-Jeff

> Oleg.
>

