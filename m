Return-Path: <linux-kernel+bounces-424999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D0C9DBC40
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC85E281E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E2E1BFE0D;
	Thu, 28 Nov 2024 18:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rtn1KxQl"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8524C17BA5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732819616; cv=none; b=JTM2rGUeHukbPtfP9QV6P0OVq8h3T1fA/2mmahc2bvmhRCinasur2F+RMmfrngjYHWnLoBS+Ga+4uWvxGyCC0G259iUs7SQSZrPsRTTfEeIgh2Nj4D1FvwyGbtzArBL48mTsw/OZqgrxXjabeTJuk8w5DtAC3wP3l1z4kkVxja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732819616; c=relaxed/simple;
	bh=cDwIisDUJoShbmTgj6pbH464/IBW/w9m3BxLxgMoQwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ejd4aErVR61+ktvo+gYROKOgApIOHTQNR5UWgMlFw76JMOMlVRwWvJXXqbguJzwIY3gmbuxxgDRRB1D2E6VpfptMs8NYd0s3/PJ1CUTMwvjuC1u5CDjF2pPeUBhPQMJ1RjxsDWRD68FP4r0qyROaXvfG9Ev7PNmkHNq6yACFnPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rtn1KxQl; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4668194603cso241291cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 10:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732819613; x=1733424413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZRhhNS9RAix/Bu1XiAacKl1HbOE7YMy6PRUju2a9e8=;
        b=Rtn1KxQloDQcCaJLAs82vtve2YUaW8N2bSYoPkNodufIAu61fO/jNhPQ0TUTRDxTit
         5BMSlB39oFXK5HJ6V3LljRci2RYNQv/Md78Tl3VarGfl5/K9SwtV9zQ+NelpQxH38a3l
         KjPL1TT8f6NOMqfLK4XmlGviev0TKggkLeO8FTXEkl1zI9k4qZIF6kGaHtXf64qWjNQv
         aVJ7peLB5+Eb/ufSeaLHRmw0iKD3xXoO1yQi1XCmi/KMB6Jx8aG3FSvqm3JF7uaf+Lsh
         FDnxxFGOhVXFgitLY/GwpHDgwCZ7SV/W7Z9TffQHpVhCL/cvWmNQ8DmQemnUb1DrMed1
         4S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732819613; x=1733424413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZRhhNS9RAix/Bu1XiAacKl1HbOE7YMy6PRUju2a9e8=;
        b=tCmsmUL6NzVLstl02OIFCRSxGx9ixnMT+OpbsXb86sILP3H6CKT9MknuCON2Rc/JtE
         LJO6ChMTS86yVqclCY88wvpuO8ser/CFKlBiQPwDoR8e8SpD1izwxadFodxyMImYYvZx
         T8nDLR3JCkd6nxPLtJqKoL/oJ3sjerucqAe9OPV7LQWlQuwURJImCxvJ9EP6hl5tKjGT
         JTnn4QSMd+AfCjjyExAx2IFre4oZXk+BCSrNUpunxx8G+nN36UfBTElqUdPdZNsj1K43
         kaIVe+wy0EPMyI1IY7FqcoV8w9qb6rxgBqA7mGSi+xZ/DJL4ATMlx7rx4+mN/8jvnjK5
         Q9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1nOyhG6Bk5kN+K63tNAnm5qo+R/fYv3sd5YZjNjbBvclB7X1bXBjitwTDS+WYy9sc2M5xDu3HeQ5DOzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW44k7hqf35MB0MxbKylg4KvVLr3Edb+M6Pr94H0nWV/Tt5+Lf
	em+jS1vIJ6AKQgh/7ijiW5htqyYGolEaYDgXphBGsLa8K1+hK1yIZI6akwXWtZJIBKJ3WBNY/hT
	JnadxxshhFNHcfqa1/RNbMVCyChx9boOaI4Yj
X-Gm-Gg: ASbGncsmP6Z4KmzFceWNrCyFKpEvgOcoNr2mANGmEBGAOmbKp4NTLEuJYNWdUo56rpH
	T1Y1ZoKUgbwhLRdNwYRMQb6fXQx1nYCI=
X-Google-Smtp-Source: AGHT+IGsDBvW/IRVcHF9iDsH+gkUlQQijpsJ144dNRMOIpOBtkesir205os7IkGJG3mJOtobqhTcMzyHahEpJOaoArw=
X-Received: by 2002:a05:622a:4c8f:b0:466:9660:18a2 with SMTP id
 d75a77b69052e-466c298592amr4128821cf.16.1732819613023; Thu, 28 Nov 2024
 10:46:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124074318.399027-1-00107082@163.com> <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com> <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
 <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
 <51c19b31.eaf.193660912f7.Coremail.00107082@163.com> <337c721a.70d1.1936753c377.Coremail.00107082@163.com>
 <CAJuCfpHZhMwK8jOz_evvvD8CaNxxaaRQEx0Qv_yPp4ZA_DkXeg@mail.gmail.com>
 <1801415b.a202.1936d01f953.Coremail.00107082@163.com> <6c49f606.8737.19371e80128.Coremail.00107082@163.com>
In-Reply-To: <6c49f606.8737.19371e80128.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 28 Nov 2024 10:46:42 -0800
Message-ID: <CAJuCfpGVJtA9L=+6AuUuTM6SyiB_n3WEUYHDU4i1y50weBS3Hg@mail.gmail.com>
Subject: Re: Abnormal values show up in /proc/allocinfo
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 12:34=E2=80=AFAM David Wang <00107082@163.com> wrot=
e:
>
> At 2024-11-27 17:44:26, "David Wang" <00107082@163.com> wrote:
> >
> >
> >
> >At 2024-11-27 01:10:23, "Suren Baghdasaryan" <surenb@google.com> wrote:
> >
> >>
> >>Hi David,
> >>Thanks for the investigation. I think your suggestion should work fine
> >>and it's simpler than what we do now. It will swap not only counters
> >>but allocation locations as well, however I think we already do that
> >>when we call __alloc_tag_ref_set(). So, instead of clearing the
> >>original tag, decrementing the new tag's counter (to compensate for
> >>its own allocation) and reassigning the old tag to the new counter,
> >>you simply swap the tags. That seems fine to me.
>
> I will send a patch for this.

Yes please. the more I look into it, the more it looks like the right appro=
ach.

>
> >>However I think there is still a bug where some get_new_folio()
> >>callback does not increment the new folio's counters and that's why we
> >>get an underflow when calling alloc_tag_sub(). I'll try to reproduce
> >>on my side and see what's going on there.
> >
> >Agreed, the reason for underflow with current code should be clarified.
> >Just update reproduce procedure:
> >1. fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --name=3Dtest  =
--bs=3D4k --iodepth=3D64 --size=3D1G --readwrite=3Drandrw  --runtime=3D100 =
--numjobs=3D4 --time_based=3D1
> >2.  echo 1 >/proc/sys/vm/compact_memory
> >3.  echo 1 > /proc/sys/vm/drop_caches
> >(It is very strange, on my VM,  "echo 3 > /proc/sys/vm/drop_caches" woul=
d not trigger easily.
> >4 cat /proc/allocinfo | grep __filemap_get_folio
> >
> >
> >FYI
> >David
> >
> Finally find out why those underflow values on my system,
> clear_page_tag_ref() -> set_codetag_empty() only works when
> CONFIG_MEM_ALLOC_PROFILING_DEBUG is defined.....

Ah, good catch! That's why my attempts to reproduce the issue were
unsuccessful. I always keep CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled.

> I guess you guys would have CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy, but I d=
on't
> think it would be the case for end users.

Correct.

>
> There are several references of clear_page_tag_ref()/set_codetag_empty():
>
> ./mm/mm_init.c: clear_page_tag_ref(page);
> ./mm/mm_init.c: clear_page_tag_ref(page);
> ./mm/page_alloc.c:              clear_page_tag_ref(page);
> ./mm/page_alloc.c:      clear_page_tag_ref(page)
> ./mm/slub.c:            set_codetag_empty(&slab_exts[offs].ref);
> ./mm/slub.c:                    set_codetag_empty(&vec[i].ref);
>
>
> Things may go off when CONFIG_MEM_ALLOC_PROFILING_DEBUG is not set.

I'll go over all set_codetag_empty() uses and check if they are valid.
set_codetag_empty() should only be used when we have an object with no
valid tag reference and we mark it as empty to avoid warnings when we
free it. In clear_page_tag_ref() set_codetag_empty() is used to clear
a valid tag reference and that's not right. I'll think about how we
can avoid such misuse in the future.
Thanks for the investigation, David. Looking forward to your patch.
Suren.

>
>
> FYI
> David
>

