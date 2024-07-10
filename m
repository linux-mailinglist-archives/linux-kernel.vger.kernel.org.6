Return-Path: <linux-kernel+bounces-248180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11592D921
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4D21F21E14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506D419882E;
	Wed, 10 Jul 2024 19:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ChCi7qZR"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1294198840
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639668; cv=none; b=RqtTOEXbrhGpSEm5Ql0XW09avjoUOdrX1ycVwcHSzadlSOC56VD9oJ63ut+H9MoNU/p1O/WE4KOwclNsuwjkxXti3zW8y3+FdmVwLL0OO0GWLf+9zCmEQyR73linWpSzOJvMxUOivEv46BAnVCGkOaG77ZYYbpD6Q+7dQx8gg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639668; c=relaxed/simple;
	bh=cSkgZxm9opEF4lFIp6zAxaa0YiiGDBE9COTQNyKmsRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=b9YGg66cbFuyCXWSy2f/8bThjihVKMlnR1uLS7XMsrQ5ycV4f2tPcS3NN75a6zWL+dg22zSxSBDU+buGf6XEuKtPiTnpAtifdeHdU+SipOm6uDJgLrnkQ3ejbPU4PRnwZt2BK6XaXnDf/lVE24hO/3RaZhNSbYixZq2PIEEFkW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=ChCi7qZR; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso118842a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1720639666; x=1721244466; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDX0XdF8xtUi8gY57mjJHI/aPqtEadEtWnhLks81CaM=;
        b=ChCi7qZR+vNK+01STXjcXXjcU/xqNnXEX3NH6ERdQUM6CvEU0TXeOb1qyvHkSm+KiY
         YoAwnT7s6lP9ajzWrEAtHg1wBVPZUVIYBaevJQsuMfRsHEKHPdWtz2MusoSbB6MM13oS
         OHFBWrOFgah2SAh+DIpCv/gUnhep045bwRlVg29xxaEdArg3HAD3a9wDGvkwekE3ezZc
         F6pXpaWitXzugGQ4st8Tx67pN8uYTkcAeDmkSuxSF4LOOY1J5sn3/8kLphaJzxYF8NCx
         3SVsnOwXUzJXNstIBi7FCoyVCVHgwFzTJtlCPv1owHwkPdCx8zAXCtFhBpS2GdRCZdZ2
         wh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639666; x=1721244466;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDX0XdF8xtUi8gY57mjJHI/aPqtEadEtWnhLks81CaM=;
        b=e7iTKn+ItIO1xyvQlypMl3un1cQRl3ED/jcGH74jeEOFuC5PMSib3wTehuYji27e2w
         +MVtcXJnQAtHJULtVJVdp17uTmeVv8FJZnPkXq0UA398KIc8z296WUS+8NWe4JQsD+9W
         fTY05itMgZpqqb06jlDw6ASacvS+NSTcp5cx3qB68GKVotkcy6UHaFDoo6w/yn0wxHL4
         Z2I1QI952zG1t3q60UvtplDQ5XdwVtGFY4w4iliKicPqbR6ChV+N8Qu0b1OhDEZG7gXI
         mkHDN/pMrJSdCBs/9uG8Il4omDMH5PCKGj/WyJJc5df0ZZP1PkkW0FHIlgP3TlQAUJqV
         ISPw==
X-Forwarded-Encrypted: i=1; AJvYcCVzpplShs9NWTw+JAYZSG6B1wO76IMFbZ92d5FEIq5KxCOjUVhUWrvStO++LmCsnhbZF43K/ijZs0qSjcHrnmCF8NgXCekDuD27ZPWF
X-Gm-Message-State: AOJu0YzcfNlvqwfA4Lfv+dQ2DxeAjn69pfr5bSdHwp+3wCKOSJz1b7g0
	6vvTZeoNywVfUmT6vbvGklHdaa+Y/HoV1hwYPbDAYTV8gCu2cWsWTKhGOeN9clKHIhfl9pZBjx2
	UZNin2vsZBRsu5UXWGUP8QHLhzGw/QxP7rWvP
X-Google-Smtp-Source: AGHT+IFevCQuz+QUBppsNr3ykaDTOUJGvGoxbbyyoYnSvNNxylRM8YDW9XfsPb9VBk0DCwpi4bmqsSw+rxSkjF9wNFU=
X-Received: by 2002:a17:90a:71cb:b0:2c9:9b65:af4d with SMTP id
 98e67ed59e1d1-2ca35bdffd5mr5203439a91.7.1720639665835; Wed, 10 Jul 2024
 12:27:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com> <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
 <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
 <0998f05b-9d5f-4b24-9030-22421e1dd859@lucifer.local> <874j8x5t4e.fsf@mail.lhotse>
 <92ce2025-51c3-423a-902e-dbd19d5d7850@lucifer.local> <7161cef3-49e4-4057-8a66-ec1ad6eb3f9e@cs-soprasteria.com>
 <zu7c7h7apzzo3amki5vz32v77bnkj46h54k4662tn5naciv5i6@d4uo4rdaoxlk>
In-Reply-To: <zu7c7h7apzzo3amki5vz32v77bnkj46h54k4662tn5naciv5i6@d4uo4rdaoxlk>
From: Dmitry Safonov <dima@arista.com>
Date: Wed, 10 Jul 2024 20:27:34 +0100
Message-ID: <CAGrbwDSL0NTxBRfkPYR7OLJHW=dU=+uXVshe4ykubgF_JaczhA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	"sidhartha.kumar@oracle.com" <sidhartha.kumar@oracle.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <kees@kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Wed, Jul 10, 2024 at 5:09=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * LEROY Christophe <christophe.leroy2@cs-soprasteria.com> [240710 08:59]:
> >
> ...
> > >>>>
> > >>>> Assuming the removal of the vdso does not cause the application to=
 seg
> > >>>> fault, then the user visible change is that any vdso call after a =
failed
> > >>>> mmap(MAP_FIXED) call would result in a seg fault.  The only reason=
 it
> > >>>> would fail is if the mapping process was attempting to map a large
> > >>>> enough area over the vdso (which is accounted and in the vma tree,
> > >>>> afaict) and ran out of memory. Note that this situation could aris=
e
> > >>>> already since we could run out of memory (not accounting) after th=
e
> > >>>> arch_unmap() call within the kernel.
> > >>>>
> > >>>> The code today can suffer the same fate, but not by the accounting
> > >>>> failure.  It can happen due to failure to allocate a new vma,
> > >>>> do_vmi_munmap() failure after the arch_unmap() call, or any of the=
 other
> > >>>> failure scenarios later in the mmap_region() function.
> > >>>>
> > >>>> At the very least, this requires an expanded change log.
> > >>>
> ...
>
> > >>> I mean why are they unmapping the VDSO, why is that valid, why does=
 it need
> > >>> that field to be set to NULL, is it possible to signify that in som=
e other
> > >>> way etc.?
> > >>
> > >> It was originally for CRIU. So a niche workload on a niche architect=
ure.
> > >>
> > >> But from the commit that added it, it sounds like CRIU was using mre=
map,
> > >> which should be handled these days by vdso_mremap(). So it could be =
that
> > >> arch_unmap() is not actually needed for CRIU anymore.
> > >
> > > Oh that's interesting!
> > >
> > >>
> > >> Then I guess we have to decide if removing our arch_unmap() would be=
 an
> > >> ABI break, regardless of whether CRIU needs it or not.
> > >
> > > Seems to me like an internal implementation detail that should hopefu=
lly
> > > not result in anything that should have visible ABI impact?
> > >
> > > I guess this is something we ought to assess. It would be useful to
> > > eliminate hooks where we can so we can better control VMA behaviour w=
ithout
> > > having to worry about an arch being able to do arbitrary things at
> > > unexpected times, especially pertinent where we change the order of t=
hings.
> > >
> >
> > I see you are talking about arch_unmap(). I didn't follow the entire
> > discussion but we have some related stuff here:
> > https://github.com/linuxppc/issues/issues/241
> >
> > If I remember correctly arch_unmap() should have gone away we Dmitry's
> > series
> > https://lore.kernel.org/lkml/20210611180242.711399-1-dima@arista.com/#r
> > but it hasn't been applied yet.
> >
>
> That is good news!
>
> To review, ppc is the only arch using this now and it sounds like you
> want to remove it too.
>
> Considering the age of that thread and the possibility of conflict with
> my series, can I drop the entire arch_unmap() function instead of
> modifying the handling in core mm?  I'm going to assume that's okay and
> start working on this for v4 (because there hasn't been a public reply
> for v4 since 2023/10/11).

Yeah, this kind of felt through the cracks. I meant to find time to
push v4, but from my job side I got motivated to do core networking
changes that were required by customers, from the other side I got
demotivated a bit by slight pushback for v3 with "justify why is it
needed at all?". For changes that are mostly cleanups and refactoring.

So, usually I don't give up on patches sets that yet make sense to me,
but priorities+motivation changed and the set moved lower on my todo
list.

If you have time and urge to finish this patch set, you are more than
welcome to adopt it :-)
Otherwise, I'll try to find time for them, but not in near short-term
as at this moment I cook tcp & selftests changes that I'd love to see
upstream.

> This would mean less arch-specific hooks and that's always a good idea.

Thanks,
           Dmitry

