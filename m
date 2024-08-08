Return-Path: <linux-kernel+bounces-278872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDBA94B5DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB511F22DB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D475B84047;
	Thu,  8 Aug 2024 04:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x5U+P20w"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F10280C13
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090774; cv=none; b=k/dn9fLJgRafzFxTSysuIAGp2+pK9awL66jurh6rNFZ3aEtJkk7/fpYBybBUAPYXLRUXzUQAzeM3QqLn+Liz2WlojexU975i5R7MQM52okWvbO8dtJ69TmbIwe5c+3BnlK7pO1uTbLPpsDwTQctJTfJ0Omy7AfzD6Iw+QWVfv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090774; c=relaxed/simple;
	bh=fI2srWBTppSppNQvO6BbPDAwCPul7dh5YxlTowXsbLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e13zRCHZuDxWyuEmNADpNLXOdK3noPtip+gv6MtFWuJ7EDUmUjTaOHUsfCQ5YHuoyCmfBllDWGxk/8El3i7c0bUxxrJrsZXRjE1FZTMxVv3rkjG0o7C+KgTAb2EygJTAhELL9zMQ/VktFQzSFTGJFi/MzYcZUaajDeYtyK8gGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x5U+P20w; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so5712a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 21:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723090771; x=1723695571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZk32ybyfJysMKEtVNqzsqnpkLDPdzMxBTy2Khfhbdc=;
        b=x5U+P20wsLzYeMpfWORO6ur5bi87Cv1N1DntfXjqeA8+FJYC+V8uID3t4M8mb6N1OR
         galnhDUllqZSZnLXmHUKNmx5GgN0tAMLCaP1oNKcub/Am6IR95yzNJlLfnzMPqlpXaGz
         LqagFb8xC2Ct4p9eZKmzVXD0YtsA3Z/Zk1+Hs/P6UfivIAKp1MMnCYO2KggD5Uk46eko
         uZd3W7cgqLWWCt8vB6P70M16j3MLecjv549tN+Wu+r2I6OKKwlOfFPZCkfQiZB7Jyghb
         hweVYIKtaBSE1gtY59KtLQZ3tp/x4/TtRMVwJPpQghFMDRGNW2r/0NnARA/yUhLpuqAj
         gukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723090771; x=1723695571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZk32ybyfJysMKEtVNqzsqnpkLDPdzMxBTy2Khfhbdc=;
        b=dYeJ392UY0d8XS8EOjehneVDMKjSRzq8VhaPO+bVhLsonphfpZGu7K9Ds0u2VNFTa6
         7NncAi0UCs+a6UW1UHXLv5Dpys4zwl4xqH0lsNMwLSDL+r8JQn3hHHSwv0TkWcgPUGaz
         8rDpR8kA5Fc5cv76koUyqRLeFkytrubxOPeGUMWlIaKl355SuhwyT1vFeKAa1fT57dm+
         WZZlZ9IjahchG0aGL+h3V5hxtpjcQPtxBSB1mhMF2DGx22dgcssJYlSovN+4Qeg1pgPF
         2/shcwuBE6mZWFXLGs1AgdkmytN84FQI+2lE75/lIN6ljTAAo9JSrnkbQBOEBeXd1jii
         Nghw==
X-Forwarded-Encrypted: i=1; AJvYcCUFY1wu9qPIZ51jUNZ4kaq3oqP3W9IXIlpEjSdGS6YcWX1BLnFdFdKlLXDXpKsIpbAomof8NdHgHcqSpabcu7UgDhh7ooU2lRteRNGd
X-Gm-Message-State: AOJu0YxB2uszroFJw7nePGbcFZACYGd7fa+leuT3stfIJDTwNaO7LcPk
	MHxNUAtpb736NCpJz74oC7ztnJchUJdgonVd6LUI4jEG4ESBsE2FpU8WsS5Qly/gB20rb5lQnpF
	5SRjDM4m9zv1ZbhMR9qGHOZAdotkHSnVq0xaS
X-Google-Smtp-Source: AGHT+IF9wTii9sNrIpFz5Knt/ZVxdahDtVUqVqQHwq/Pqk7lkKg6jGof3hX1jcw49iQTUZ6TDfAFMIp6ZsF+LfSrOK0=
X-Received: by 2002:a05:6402:51d0:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-5bbb179a00cmr59759a12.7.1723090770367; Wed, 07 Aug 2024
 21:19:30 -0700 (PDT)
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
 <CALmYWFsAT+Cb37-cSTykc_P7bJDHmFa7mWD5+B1pEz73thchcQ@mail.gmail.com>
 <lhe2mky6ahlk2jzvvfjyongqiseelyx2uy7sbyuso6jcy3b2dq@7ju6cea62jgk> <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
In-Reply-To: <CAHk-=wgTXVMBRuya5J0peujSrtunehRtzk=WVrm6njPhHrpTJw@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 7 Aug 2024 21:18:52 -0700
Message-ID: <CALmYWFvtXXi9YMH8jwyWcOwPwZ0+PeCrP2QyJBBK8ExXiYa+Tw@mail.gmail.com>
Subject: Re: [PATCH 2/4] powerpc/mm: Handle VDSO unmapping via close() rather
 than arch_unmap()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@chromium.org, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 8:21=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 7 Aug 2024 at 16:20, Liam R. Howlett <Liam.Howlett@oracle.com> wr=
ote:
> >
> > Okay, I'm going to try one more time here.  You are suggesting to have =
a
> > conf flag to leave the vdso pointer unchanged when it is unmapped.
> > Having the close behind the conf option will not prevent it from being
> > unmapped or mapped over, so what you are suggesting is have a
> > configuration option that leaves a pointer, mm->context.vdso, to be
> > unsafe if it is unmapped if you disable checkpoint restore.
>
> We definitely do not want that kind of complexity. It makes the kernel
> just more complicated to have to deal with both cases.
>
> That said, I don't love how special powerpc is here.
>
> What we could do is to is
>
>  - stop calling these things "special mappings", and just admit that
> it's for different vdso mappings and nothing else (for some odd reason
> arm and nios2 calls it a "kuser helper" rather than vdso, but it's the
> exact same thing)
>
>  - don't do this whole indirect function pointer thing with mremap and
> close at all, and just do this all unapologetically and for all
> architectures in the generic VM layer together with "if (vma->vm_start
> =3D=3D mm->context.vdso)" etc.
>
> that would get rid of the conceptual complexity of having different
> architectures doing different things (and the unnecessary overhead of
> having an indirect function pointer that just points to one single
> thing).
>
> But I think the current "clean up the existing mess" is probably the
> less invasive one over "make the existing mess be explicitly about
> vdso and avoid unnecessary per-architecture differences".
>
> If people want to, we can do the unification (and stop pretending the
> "special mappings" could be something else) later.

OK. Now this is clear to me (at last).

Treating vdso mapping, (maybe all the special mappings) as normal
mapping and handling mmap/mremap/munmap properly from userspace will
indeed make things clear conceptually. I'm OK with doing this later
since it is a big change.

Thanks
-Jeff

>
>          Linus

