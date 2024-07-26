Return-Path: <linux-kernel+bounces-263090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2E093D0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B481C20F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4D5178395;
	Fri, 26 Jul 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nExR1B2w"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2017623E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988713; cv=none; b=rY7IgBZWiVBfMBlz78vTS/wARYEnKfTxPVFyE9vL2LeQtRDDzQHHo0ZxwbG3kMLW646mu4jPTohsxi4xpHtGnjkGtU+viShAqXOnWsNdPSf0xseLuhRdJEY0pqalNV9UOzzWJzPVSJ9OJ8jPx3wfNeQ5blqD4jBynE3k8Hj4wVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988713; c=relaxed/simple;
	bh=YkqzF8XAzHo9lwZwdFJ6HBuc/wGEIA0EqWO+Qg7glcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWbrSeGpfqzdAfcciWtM3qe64KlWFynlRI98JxTJRtlRb6Sl+FlsuvOOoFNpCrM8xn5qxN1gc0q9OxbQc+jz1VFO6AfUUD+cYByR0zjn/CoqVjKb6AlCvq3H9ZhaADBRDscxHOwoPZ6oB+92qDjntbYSE6bS8Nmr5qLop4HkA3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nExR1B2w; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-827113c1fb4so174555241.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721988711; x=1722593511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eP6nUR3qmQ2fl5mhPqAgNEBfiba7cW0MObDAu+ZAnA8=;
        b=nExR1B2wXTrBXi1zIaZl9OoOTmzYaJG7GH5Ep86Dd8CdWhkAj3GMH1z7Sx8WdGnKw8
         jRuI6XQK/A47WZOA7rGqaqoXFnwbD2fc6AhynBzHxvAT4lA6JB7JG9QxIsujJcagL9wM
         A3xnTzm/OeKJZjGF5DbKKQ5Q4iQvnWH/8y87rFBUQyA3f0lSkhA31S5UR/W7xfgJiR4A
         iyjiRKs6gnq3qhaa1P1U1DwOMYFXxK2v0/FO0GUfPl2HB1NXiMq6bWybM97Bd6Yq6QqL
         HkAke0LCEOQmVRdAFtvbEZFsqm1fWL03283o0uxNIPS7LUXfEtQT1JFcr66v8Jn/oDeh
         +wBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721988711; x=1722593511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP6nUR3qmQ2fl5mhPqAgNEBfiba7cW0MObDAu+ZAnA8=;
        b=eA167TC6ZaEVnY761fk2a3Kl5lL2IlshSYY88gnMM9yg2+6fyQH4HGxiarCdlvmP1a
         ecLttsafMDAwrkdDnI5dbRX5x4e6K6D8sNdrTMbdi9ZqRdXGsJ3zpX5zdo6H7+H1AQL7
         NK6g3dD8r4M1IfQu5DHxWgNzGRCkntAIIm3xNqI5VkAp7JAK6OqqcqjmoN7xyUFDtpHj
         iB0VSo5YCZHYLSFanUjk3ZN3YxYTpraX1blkJ1Vz8xp3kuMVT4CMjbIP0ESrZOwVINP/
         6CIM8euXDDUcxXTp0SOMRV4WPf5k1emkE17gAM5wbT2Gqt1VquEGawZOfWQGeKuXKhfI
         IscA==
X-Forwarded-Encrypted: i=1; AJvYcCXYXQCGOe8K7acRqbPyuwvRvblP/aTE8N0gGwTPdgfxpgSY3kVC0sdUJulie2K4F/JWB0KPMBq1ayRQmAgfU1gS0keLG4JK6p5kGzZB
X-Gm-Message-State: AOJu0YzwECvREsp8g9OpWExnL5AKPGRusfBcZwIExp4PYY1zRO7l81v6
	lKKRQarrKH4scFLDunyYkP2AL9q4vQVCFHCevOIBGvDmhIvu4CKXWZ0hrEgbmspee47nbJsrMvq
	ZLYY90ifw5/VEVG16xpxzndintq+zWBtN
X-Google-Smtp-Source: AGHT+IG2z9yyGyowQXy9edCnhDzzghfhjN0sZzfOaKAQo1+owybdxWT1aS22Rv1MV/Wz6YEiizdByhdbKNqFRX9DCPY=
X-Received: by 2002:a05:6102:3f11:b0:493:e585:6ce3 with SMTP id
 ada2fe7eead31-493e5856f8emr3229867137.31.1721988710657; Fri, 26 Jul 2024
 03:11:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726082818.260008-1-21cnbao@gmail.com> <aeb0fcb9-7c84-4bc4-b89a-5f0f86478aaf@arm.com>
In-Reply-To: <aeb0fcb9-7c84-4bc4-b89a-5f0f86478aaf@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 22:11:38 +1200
Message-ID: <CAGsJ_4wnc_qYyvHF5xdvsRpR1cXAnBSf93HiyOBhz1RTcOH0zg@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't start_stop_khugepaged for non-PMD THP
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lance Yang <ioworker0@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:43=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 26/07/2024 09:28, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > khugepaged will be automatically started when PMD-sized THP is enabled
> > (either of the per-size anon control or the top-level control are set
> > to "always" or "madvise"), and it'll be automatically shutdown when
> > PMD-sized THP is disabled (when both the per-size anon control and the
> > top-level control are "never").
> >
> > It seems unnecessary to call start_stop_khugepaged() for non-PMD THP,
> > as it would only waste CPU time.
> >
> > Cc: Lance Yang <ioworker0@gmail.com>
> > Cc: Ryan Roberts <ryan.roberts@arm.com>
> > Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/huge_memory.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 41460847988c..bd365e35acf7 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -514,7 +514,7 @@ static ssize_t thpsize_enabled_store(struct kobject=
 *kobj,
> >       } else
> >               ret =3D -EINVAL;
> >
> > -     if (ret > 0) {
> > +     if (ret > 0 && order =3D=3D HPAGE_PMD_ORDER) {
> >               int err;
> >
> >               err =3D start_stop_khugepaged();
>
> Personally I see this as a bit of a layering violation; its
> start_stop_khugepaged() that should decide the policy for when to start a=
nd stop
> the daemon. thpsize_enabled_store() should just be calling
> start_stop_khugepaged() to notify that something potentially pertinent to=
 the a
> policy decision has changed.
>
> And I don't think this should be a hot path; I'd expect the global thp si=
ze
> configuration to be set at boot and remain pretty static. Do you have evi=
dence
> to the contrary?

Absolutely no, I was reading and patching the doc
"Documentation/admin-guide/mm/transhuge.rst"
and was also copying-paste your "enabled" code to "swapin_enabled" with dro=
pping
start_stop_khugepaged() in that case. I believe I don't need it for
enabling/disabling
swapin as swapin is a subset of mTHP not a main entry.

just feel a bit inconsistency between the doc and the code at least for thi=
s
moment:
khugepaged will be automatically started when PMD-sized THP is enabled
(either of the per-size anon control or the top-level control are set
to "always" or "madvise"), and it'll be automatically shutdown when
PMD-sized THP is disabled (when both the per-size anon control and the
top-level control are "never").

which triggered me to make this change.

Thanks
Barry

