Return-Path: <linux-kernel+bounces-263129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9293D170
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D44EB2822A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85F177991;
	Fri, 26 Jul 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byMuv3dv"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E67F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991651; cv=none; b=OUp1+ZTyWEMnzsAHE74XabEvuCWtX8Q7CJn7zSWo9Hvb3Yt3XVpRvDM33de+dZUtn02cAhvYU0heUnAoTqKy5gEVnaE4fPT3nfTHhgyZlilE5keoySIjROmrgrH2ftLRw63SzPffg6yWu26SPM1vzMQWGSX0NU2lw72hfpemXXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991651; c=relaxed/simple;
	bh=Liour3LuFis6qmENC1mwXfLMf3yiac7o8g3Yn+hPDRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lptc4tTXM60djDLYOq102YAyuDoN9bY/l6asJM3P5oUHeTrwEnRRPm6sG1FeWITl4KLtZNnF2CqjR+vsj5UWpDfa6srPVUgvu+MvSuTX146zH+tgtICHLm7MUDj+zLdz68Hf8I138n0mBU/dJK6XDhetqep3aabeZIbN/FeMAK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byMuv3dv; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4928b5531caso579238137.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721991649; x=1722596449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XYZNhl+Yme+X3WfgiEKKEcqAduYmi2Zfs8O87+eZtU=;
        b=byMuv3dvs0b+8d5nnjrw7w1gCFE7sWPW8jBdv9/Ykp1n/Eaw3Qpy3QMUX5tRRdmRv8
         AE7n/4vLvHkqlAbN7zlgPPgekfqpqRMnDOG1zS810cttZcqRe2a+hTdSxz1OmlqOjl6l
         4zUEmyZnIhm6VLtQBUGVAoFLvBNtpd+XFpIxwCYxaqzSdfKXjOf9vxwNpJ+3pKy6+nIo
         KKtI5O1grhazz+h2DdTXEmsVImy8ch9DohD4G4OKCG3c10TzwdizNmguScRXPi2t0sMH
         tj+ndcd2ulWS9UFTfbrf6Y1noCJ0JoB11CrOU+rZkvty1JwMK1k3t60YGWomiIZkjwSf
         Rjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721991649; x=1722596449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XYZNhl+Yme+X3WfgiEKKEcqAduYmi2Zfs8O87+eZtU=;
        b=q8XwJrwrbO0D4wdSgxdgUXdEPeV5+MlQ2fJNONT+0smhOPsMJ/1n8VqF3V1XPEQaY8
         HdA/W1lZwKD9pe7GGNYna2crBaeLVquzDpdD/MNMc1fKNIEbpXhyy+l5AnpS1Kkxl7na
         wP92vEztvqoMYe7CIPxgGx2inTxfuvBef+pIK66C6jxTCTTlE39+Znnx+Vt37fADJh9T
         y0byA6dmKfGdsC4fSUfGJmZoyEmCkS7jSvY64tFH/QG7INjC78VP9IiHLz+ErnqgkQb4
         P50tuwvz/zBd1nxRwIqNrpFAsd6x3uXRXkTOY8BIzKD9dUHpTM/HPzCiTMlpOthFu4IN
         cPjw==
X-Forwarded-Encrypted: i=1; AJvYcCWCkhYd/SjcoifFpxBQcXCatTgvoUSo+MyBWRDhpCBadnF7UBC+rD9fQh1FjIcCwplNgpFrsniGKPhpZcG6TryEw6B+GAVlvWGls2XL
X-Gm-Message-State: AOJu0YySec/d2McWBcCRfzM8Wprcw2LAVWFBVtbOmVZMyUWX4qa7TKUp
	j7FxvMBxrTrUmOBzsmhAjnFRuqmzv0/xwpCSe0kdyh8bxCM+H8G0cVwu0GjyHHnn/o4VikYldva
	oRGrUGalUbQPU6/LjMkBKacvyvQY=
X-Google-Smtp-Source: AGHT+IH0bNJVtUQX7W2OOtHhUPLoQ95PN08Igg9J6vofkYHuC+lp9Nu1CbLdHYyppJ8XrZdJ5JMgBlM9ndnruv0cJ/k=
X-Received: by 2002:a05:6102:50aa:b0:493:e1ba:123b with SMTP id
 ada2fe7eead31-493e1ba1b33mr3801058137.16.1721991648966; Fri, 26 Jul 2024
 04:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726082818.260008-1-21cnbao@gmail.com> <aeb0fcb9-7c84-4bc4-b89a-5f0f86478aaf@arm.com>
 <a9ff9028-a73a-4a80-b38a-266d1e8c20fe@redhat.com> <CAGsJ_4wN0TBnPDj5oeFdPqCZk6XkMaJ0JbLY+fETWn52npwjjg@mail.gmail.com>
 <fdae26b5-1fe1-4544-b496-2273b2c2b523@arm.com>
In-Reply-To: <fdae26b5-1fe1-4544-b496-2273b2c2b523@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 23:00:37 +1200
Message-ID: <CAGsJ_4wmkgNjdjReL55feWFgVonymyS4yyi3426eY0hpTWYAEw@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't start_stop_khugepaged for non-PMD THP
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lance Yang <ioworker0@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 10:45=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> On 26/07/2024 11:04, Barry Song wrote:
> > On Fri, Jul 26, 2024 at 9:48=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 26.07.24 11:43, Ryan Roberts wrote:
> >>> On 26/07/2024 09:28, Barry Song wrote:
> >>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>
> >>>> khugepaged will be automatically started when PMD-sized THP is enabl=
ed
> >>>> (either of the per-size anon control or the top-level control are se=
t
> >>>> to "always" or "madvise"), and it'll be automatically shutdown when
> >>>> PMD-sized THP is disabled (when both the per-size anon control and t=
he
> >>>> top-level control are "never").
> >>>>
> >>>> It seems unnecessary to call start_stop_khugepaged() for non-PMD THP=
,
> >>>> as it would only waste CPU time.
> >>>>
> >>>> Cc: Lance Yang <ioworker0@gmail.com>
> >>>> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >>>> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >>>> Cc: David Hildenbrand <david@redhat.com>
> >>>> Cc: Yang Shi <shy828301@gmail.com>
> >>>> Cc: Zi Yan <ziy@nvidia.com>
> >>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >>>> ---
> >>>>   mm/huge_memory.c | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>>> index 41460847988c..bd365e35acf7 100644
> >>>> --- a/mm/huge_memory.c
> >>>> +++ b/mm/huge_memory.c
> >>>> @@ -514,7 +514,7 @@ static ssize_t thpsize_enabled_store(struct kobj=
ect *kobj,
> >>>>      } else
> >>>>              ret =3D -EINVAL;
> >>>>
> >>>> -    if (ret > 0) {
> >>>> +    if (ret > 0 && order =3D=3D HPAGE_PMD_ORDER) {
> >>>>              int err;
> >>>>
> >>>>              err =3D start_stop_khugepaged();
> >>>
> >>> Personally I see this as a bit of a layering violation; its
> >>> start_stop_khugepaged() that should decide the policy for when to sta=
rt and stop
> >>> the daemon. thpsize_enabled_store() should just be calling
> >>> start_stop_khugepaged() to notify that something potentially pertinen=
t to the a
> >>> policy decision has changed.
> >>
> >
> > My impression is that it slightly deviates from the huge page documenta=
tion in
> > Documentation/admin-guide/mm/transhuge.rst.
> >
> > khugepaged will be automatically started when PMD-sized THP is enabled
> > (either of the per-size anon control or the top-level control are set
> > to "always" or "madvise"), and it'll be automatically shutdown when
> > PMD-sized THP is disabled (when both the per-size anon control and the
> > top-level control are "never").
>
> But start_stop_khugepaged() doesn't unconditionally start khugepaged, it =
takes
> action based on hugepage_pmd_enabled() which only returns true if there a=
re any
> pmd sized THP enabled (currently looking at anon and file, but should als=
o look
> at shmem in future; that's a known bug that's been there forever). So I d=
on't
> think it is inconsistent with the documentation?

My point is that, as a code reader, if non-PMD sizes are never
involved with khugepaged,
we can proceed without needing to check the lower-layer code.
otherwise it is a bit
confusing, especially since start_stop_khugepaged() unconditionally calls
set_recommended_min_free_kbytes() for all sizes, regardless of whether
they are PMD.

However, I agree with your point that if non-PMD sizes are eventually manag=
ed by
khugepaged, then this approach is flawed. This is the downside of this chan=
ge.

>
> >
> > non-PMD size is not involved in khugepaged, but I agree the policy migh=
t change
> > in the future.
> >
> >> Agreed, skimming the subject I was under the impression that we would =
be
> >> fixing something here.
> >
> > working on another swapin_enabled and reviewing the enabled source code=
.
> > I don't need this startstop for all sizes in that case, so I made a
> > quick adjustment
> > to this part as well. If neither of you likes it, that's fine with me :=
-)
> >
> >>
> >> --
> >> Cheers,
> >>
> >> David / dhildenb
> >>

Thanks
Barry

