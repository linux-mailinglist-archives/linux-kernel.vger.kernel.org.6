Return-Path: <linux-kernel+bounces-425035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B469E9DBCB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C9E1646DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FAC1C1F34;
	Thu, 28 Nov 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pqk7OzgJ"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590137A13A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732823917; cv=none; b=Izl2TmG+68xNxuh0jDkFK9MhdpFiY9awnlETMzVK2vu3CZfh3kLWZA9WAbRxK40sJX+LgMumLfExq5yVm7YDnpllQithVY0CDaW26nskzgBFHwQgH22qp1uAhcU1cbtTRRzME+tkLBSmf3l4XukboLOax5/oCk97DF7A0cwY63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732823917; c=relaxed/simple;
	bh=jgBoTn9Q+70E1Te6Tg6d704cGOXnAGn27HePc7uiSwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9DawgAzxXQ4e7z9kvG1M+cMfrMtoQ+wuwjozJ7xLBpzqqVg7BG6XblCaGy/l8Ekv9XY/GdXYjkkxtGaL5dyfMDEj3oBzeKOlOwEvQiO807Wwqj7pp08wVuQfXUCf2KkeHPZd7YGIGSgwAPkefP7Zzsjp2BAWRWExXlBPgSY418=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pqk7OzgJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4668194603cso250191cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 11:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732823915; x=1733428715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXtFVS4qQ8/3Xe8zXCwz7prkcbz5Oro8xRq567KrsEw=;
        b=Pqk7OzgJtdcmS9gwwnSd49hdif8xT23hqyl2k6k5PqE8FfTGbcmk11KxlqWDIVvRSf
         jLV2CQYkRyaEbsAhA+myJG8svJF8vBTi/IsRfu3TLDjdNwWrCQFp136agTEfLACE6vx9
         ZGM8EQ7SnblnOS2mwO2tyqD7hS0NgCgqlPWdtM6roypXLrLzBSFHX/V1oJ49bd8hc6MS
         woucawou/WNJ4yB92DxwTCmCBoAYKRjF9pAkK5KIFh9tXZ9g5VNOXXdaPiflhHyhEQsV
         nIrWWd1OtapJW/46vJPbUBZ6YSG5z4KS0pkO2s29TQmyQr7KTxixEQMMrrLffMXsgesR
         +DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732823915; x=1733428715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXtFVS4qQ8/3Xe8zXCwz7prkcbz5Oro8xRq567KrsEw=;
        b=t11OlncqImRNvh9l2d8BMsYcVcBTk1r+8xwpQwS2hCiKIGAtLcyaIuWOZgxl2TsHCq
         tWE4j048C2gRdvY+4N9uUNaxIS4To+bpnXmSd5G5YZbJvFeDT+ihduxq/JpZuiPWGh9O
         nohybtAy9hu/Z8yntavB5vkPPD0MbEUVDtL+UMDm8qiQ3g76AlsE3wIWMytC9nJW58jC
         Yr5A1WLROAZhpylC/Vqc87K/1avimupOHcEgj7qj5lGu/kCoPNCuoZ9Fa6ptomF/BOUE
         E9nXdtStyc34BEci3dTBrTpH5Fgvlvv1Fg9eQvn0eFlMtCGphwQx+4F4SnCcqwHsDRcf
         gOCA==
X-Forwarded-Encrypted: i=1; AJvYcCVeqq6KZGuAM8DQqMIsMZarYblTFybrDWGMSHOS861ZAocCCz5aOFGpiumBWJIEVG/UOsRhOLa4uZt1B3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNM5jOGCcm2N7F2FPCoUuoT2uqNGbfONOwwXvpjVl+V0a01kP
	0IL3jKYC2ZCCuL8hpzqiX2bRDWi0sErTTkUYLOIwgxi9dI1o5MJ4T1nQVnmzu2es02MU/TBWxoL
	VHosnUPvxxCFdpFRS9dS+KQfZu3JgVEoXdRve
X-Gm-Gg: ASbGncvhGDzP5YG3cipB7/ESA/C0Z6wNBtHfs8rd2UTr2v1xnDUR06PluiNNOPhiDlH
	sxW99uP+lX8HEPpuNsUTeuT1QV4XIyxk=
X-Google-Smtp-Source: AGHT+IFjKQXeYjlTEH+9gVqNsRWCWhVsjZTU5he7XsaMSS56d0RN/H8YNPhiTHyCErsrLnLjl9HJo3WTELT4tX96eZs=
X-Received: by 2002:a05:622a:401b:b0:466:8c23:823a with SMTP id
 d75a77b69052e-466c3f591damr2971661cf.17.1732823914940; Thu, 28 Nov 2024
 11:58:34 -0800 (PST)
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
 <CAJuCfpGVJtA9L=+6AuUuTM6SyiB_n3WEUYHDU4i1y50weBS3Hg@mail.gmail.com>
In-Reply-To: <CAJuCfpGVJtA9L=+6AuUuTM6SyiB_n3WEUYHDU4i1y50weBS3Hg@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 28 Nov 2024 11:58:23 -0800
Message-ID: <CAJuCfpGgranJLOgQjsEFV5Cy+xEOH9701bs9Nqavx9XWFus+JA@mail.gmail.com>
Subject: Re: Abnormal values show up in /proc/allocinfo
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 10:46=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Thu, Nov 28, 2024 at 12:34=E2=80=AFAM David Wang <00107082@163.com> wr=
ote:
> >
> > At 2024-11-27 17:44:26, "David Wang" <00107082@163.com> wrote:
> > >
> > >
> > >
> > >At 2024-11-27 01:10:23, "Suren Baghdasaryan" <surenb@google.com> wrote=
:
> > >
> > >>
> > >>Hi David,
> > >>Thanks for the investigation. I think your suggestion should work fin=
e
> > >>and it's simpler than what we do now. It will swap not only counters
> > >>but allocation locations as well, however I think we already do that
> > >>when we call __alloc_tag_ref_set(). So, instead of clearing the
> > >>original tag, decrementing the new tag's counter (to compensate for
> > >>its own allocation) and reassigning the old tag to the new counter,
> > >>you simply swap the tags. That seems fine to me.
> >
> > I will send a patch for this.
>
> Yes please. the more I look into it, the more it looks like the right app=
roach.
>
> >
> > >>However I think there is still a bug where some get_new_folio()
> > >>callback does not increment the new folio's counters and that's why w=
e
> > >>get an underflow when calling alloc_tag_sub(). I'll try to reproduce
> > >>on my side and see what's going on there.
> > >
> > >Agreed, the reason for underflow with current code should be clarified=
.
> > >Just update reproduce procedure:
> > >1. fio --randrepeat=3D1 --ioengine=3Dlibaio --direct=3D1 --name=3Dtest=
  --bs=3D4k --iodepth=3D64 --size=3D1G --readwrite=3Drandrw  --runtime=3D10=
0 --numjobs=3D4 --time_based=3D1
> > >2.  echo 1 >/proc/sys/vm/compact_memory
> > >3.  echo 1 > /proc/sys/vm/drop_caches
> > >(It is very strange, on my VM,  "echo 3 > /proc/sys/vm/drop_caches" wo=
uld not trigger easily.
> > >4 cat /proc/allocinfo | grep __filemap_get_folio
> > >
> > >
> > >FYI
> > >David
> > >
> > Finally find out why those underflow values on my system,
> > clear_page_tag_ref() -> set_codetag_empty() only works when
> > CONFIG_MEM_ALLOC_PROFILING_DEBUG is defined.....
>
> Ah, good catch! That's why my attempts to reproduce the issue were
> unsuccessful. I always keep CONFIG_MEM_ALLOC_PROFILING_DEBUG enabled.
>
> > I guess you guys would have CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy, but I=
 don't
> > think it would be the case for end users.
>
> Correct.
>
> >
> > There are several references of clear_page_tag_ref()/set_codetag_empty(=
):
> >
> > ./mm/mm_init.c: clear_page_tag_ref(page);
> > ./mm/mm_init.c: clear_page_tag_ref(page);
> > ./mm/page_alloc.c:              clear_page_tag_ref(page);
> > ./mm/page_alloc.c:      clear_page_tag_ref(page)
> > ./mm/slub.c:            set_codetag_empty(&slab_exts[offs].ref);
> > ./mm/slub.c:                    set_codetag_empty(&vec[i].ref);
> >
> >
> > Things may go off when CONFIG_MEM_ALLOC_PROFILING_DEBUG is not set.
>
> I'll go over all set_codetag_empty() uses and check if they are valid.
> set_codetag_empty() should only be used when we have an object with no
> valid tag reference and we mark it as empty to avoid warnings when we
> free it. In clear_page_tag_ref() set_codetag_empty() is used to clear
> a valid tag reference and that's not right. I'll think about how we
> can avoid such misuse in the future.

I think the simplest way to ensure that set_codetag_empty() works for
CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dn is to change it from NOOP to:

-static inline void set_codetag_empty(union codetag_ref *ref) {}
+static inline void set_codetag_empty(union codetag_ref *ref)
+{
+         if (ref)
+                 ref->ct =3D NULL;
+}

> Thanks for the investigation, David. Looking forward to your patch.
> Suren.
>
> >
> >
> > FYI
> > David
> >

