Return-Path: <linux-kernel+bounces-263087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C40593D0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28404282361
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A4E17839B;
	Fri, 26 Jul 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfXii+i2"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD29176AA9
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988297; cv=none; b=bOhbEo4tH4zlqW3p8b1A8OoFk7AAiN6t2YG1kwcBV2k33/JNh1yUxmHYS54o58UWOcUZ/+Nz+uTm2x+NUh/rBYcDwn+hCUGs+d2kLdMl3GmxFTojFjAE47G+Zkp1tzMiCfuVCDLO0GQpYQZJtktPxR8ZQ2so08R8nMTG0Vv7W/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988297; c=relaxed/simple;
	bh=8PxTBFCTWxNrQEI/ukDbulvYMXpPaNq5SMqTKHvzbAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJQonUAXSYxLOemQHCtlPlMAKOlGVwGcdLO6wB4T/tVBEKjct29EplmYzlMvejY5Mjm6y57KFHHLGxb0ilxSgMAJKv7M8VuGsS5Vwq4rWW8sB6ppeJOqJ1lOcHzBC1OhYLrd/ujBlUte8jZCziADs6jsRZCWNClK79yd/HVsBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfXii+i2; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8225a1f4d5fso160813241.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721988294; x=1722593094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKRTB+QMsBedr6Tww/gheCywlom3w19E9zE3B85gQGM=;
        b=GfXii+i2YhnGl84slhIQlq9jXr/d39Kfex/f2eWc/X21I/iMugsfhGj3W6jRYO9yH+
         MnRMEkwCdQhM/rR8FRe0yDdZFYSRBPyksGTSDffOE55FlD3pNbVmQs0QDpISGsRkwv2k
         IM0ovOi9vBkBy9fQnuAun+iKKxTGEmtrMWQqnUnRDAUeX/K8XktMQViITbqVFuL5IiMq
         RK+5C634wN2s2SMJUvO8/wQW8BLUWL0LNK57eFLFZRzZXWtxHH/BgSyXNk8HQjIWdl2z
         DiZKvns/3hiQqPZ2kywbe8mZB14rvyk3kUxjdk9Dwzp7C8+hb3wDu5cW16KEHZ75x4O8
         DtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721988294; x=1722593094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKRTB+QMsBedr6Tww/gheCywlom3w19E9zE3B85gQGM=;
        b=v64GfBD3P4tVY7xG83zZ5816mPlzPVsdPBXfRgjIKVBQx98hmPEjZ3QVzNCuEYNyIy
         wBcCBvDo+Pu4Rr/ePW7suTdOTQ7DWvr1ocvCvVw1YEqHQuGnd6inoJMgqGXvgSrdxVhc
         FNScgC5Qg7V2SJrzs1VD73FvaiiD5SW1SloT5+sN0zLgxSvYlNcDSNUhXZvM5+1Jg1Ux
         AtnGG2RBYFVdOEXolKTHhh7kARTQNWAjuFoBCLCGPT1xYbg3JSM63HqCXLN9lPbd1anf
         8xkUShnqXQNgN7dEjRKLud02vehZwGP7fEp9Xdri0TUNltuuc9+8IHAtDr/hUwPpKq6j
         tmvw==
X-Forwarded-Encrypted: i=1; AJvYcCUqAs9zMmzvsTgMxTEBbU+J1jCTV1ZMhfOXn9W+a47wpWcjbc/PgjT9MWuPRo01W4FRTrxYab041wP04YvuEXWknU+KzqFeekmMrpqD
X-Gm-Message-State: AOJu0Yz0DUHmBnl+yRSbVTNLgPw86v+YyY2KJ0mQXjxM481Gk3wK8ILh
	XTPUBG+9hrZCRHTxQvDmoArzD4QtRVXsbnZcP6NVtlxdffLqlVS9YQeKMSsFAohx7C6ycnkCieU
	OhahpMStEltZ6EapvKufkIZUyQSI=
X-Google-Smtp-Source: AGHT+IGOaWEBJFuK43r/CNoMwdmC7g8L/qG9naZ4+5g62JL3Y3DpeolYYj8z4+wBjjHcWStDWojtg64BYoltlh88yV8=
X-Received: by 2002:a05:6102:418d:b0:493:da83:33fa with SMTP id
 ada2fe7eead31-493da833829mr5518688137.21.1721988294216; Fri, 26 Jul 2024
 03:04:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726082818.260008-1-21cnbao@gmail.com> <aeb0fcb9-7c84-4bc4-b89a-5f0f86478aaf@arm.com>
 <a9ff9028-a73a-4a80-b38a-266d1e8c20fe@redhat.com>
In-Reply-To: <a9ff9028-a73a-4a80-b38a-266d1e8c20fe@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 22:04:42 +1200
Message-ID: <CAGsJ_4wN0TBnPDj5oeFdPqCZk6XkMaJ0JbLY+fETWn52npwjjg@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't start_stop_khugepaged for non-PMD THP
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Lance Yang <ioworker0@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 9:48=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 26.07.24 11:43, Ryan Roberts wrote:
> > On 26/07/2024 09:28, Barry Song wrote:
> >> From: Barry Song <v-songbaohua@oppo.com>
> >>
> >> khugepaged will be automatically started when PMD-sized THP is enabled
> >> (either of the per-size anon control or the top-level control are set
> >> to "always" or "madvise"), and it'll be automatically shutdown when
> >> PMD-sized THP is disabled (when both the per-size anon control and the
> >> top-level control are "never").
> >>
> >> It seems unnecessary to call start_stop_khugepaged() for non-PMD THP,
> >> as it would only waste CPU time.
> >>
> >> Cc: Lance Yang <ioworker0@gmail.com>
> >> Cc: Ryan Roberts <ryan.roberts@arm.com>
> >> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Yang Shi <shy828301@gmail.com>
> >> Cc: Zi Yan <ziy@nvidia.com>
> >> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> ---
> >>   mm/huge_memory.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 41460847988c..bd365e35acf7 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -514,7 +514,7 @@ static ssize_t thpsize_enabled_store(struct kobjec=
t *kobj,
> >>      } else
> >>              ret =3D -EINVAL;
> >>
> >> -    if (ret > 0) {
> >> +    if (ret > 0 && order =3D=3D HPAGE_PMD_ORDER) {
> >>              int err;
> >>
> >>              err =3D start_stop_khugepaged();
> >
> > Personally I see this as a bit of a layering violation; its
> > start_stop_khugepaged() that should decide the policy for when to start=
 and stop
> > the daemon. thpsize_enabled_store() should just be calling
> > start_stop_khugepaged() to notify that something potentially pertinent =
to the a
> > policy decision has changed.
>

My impression is that it slightly deviates from the huge page documentation=
 in
Documentation/admin-guide/mm/transhuge.rst.

khugepaged will be automatically started when PMD-sized THP is enabled
(either of the per-size anon control or the top-level control are set
to "always" or "madvise"), and it'll be automatically shutdown when
PMD-sized THP is disabled (when both the per-size anon control and the
top-level control are "never").

non-PMD size is not involved in khugepaged, but I agree the policy might ch=
ange
in the future.

> Agreed, skimming the subject I was under the impression that we would be
> fixing something here.

working on another swapin_enabled and reviewing the enabled source code.
I don't need this startstop for all sizes in that case, so I made a
quick adjustment
to this part as well. If neither of you likes it, that's fine with me :-)

>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

