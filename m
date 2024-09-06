Return-Path: <linux-kernel+bounces-318106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F53796E869
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D4F1F24C04
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6538E43AB9;
	Fri,  6 Sep 2024 03:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd6SzacN"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A25A41
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594637; cv=none; b=lSGhXv4VF/W+tQrzyV2xKhSsPAEjA1Tst6GvIkaRXMfp8g1RhPIzhfpNgPxCG/CLPp3HICVpNoEonZksHVlyaKZYmexzk/60ItwuP2oRAVa/etkU5nujCG6X6rXyWV4zshyjpyWmJ+qf3kdrbqAvmFxcZSXzFVY6wWmd+2qGvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594637; c=relaxed/simple;
	bh=MkjEi1fLEUzwLky66ohtfmoAPM1VtKunnA7A5hfo4Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S1yNTr9tNxB2OO31L1eFbotCrkeNCJQYEAOb0MvVKBQWqWwXlq3+CAMcx98GnC2WTvm32bCNARrghtEdtawVPIMvknC+veRCfLp7RFKV/eVJJ65YuVv+D5lJNGmNveOkHbm+9KS9WBm8lanWnjRSCE5uqwMVtUWlgNl8Zu08UM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dd6SzacN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70f660d2250so1015366a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725594635; x=1726199435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07jLzEpcesGBjWhFDqtujhuQLMMXaeMmn6OQvBvkAyQ=;
        b=dd6SzacNQpNnO6f669fz6nevN/1r0KdI4dXGd60wHdrf/QWrTukXq0/wV3P9f+WGi+
         LErjIuzll3R3LLRNNbtvp4arY2PN/KlZIj7XaYXwCuXmY54hU6Gbnif/o4hME+Y2dZzk
         k5PM6/LFvI7Tqj6TTAcU9vVNYpJQtE9hL3b9trqFpwFsnRLt4kjWp9x7T606756IpjqS
         a20KMEunyPnLM/YhwzhG//fKPRnVmkJQ9Y8zNfE3kHhfJcWI0E/ec5lYrLJUEv/WnH1N
         RNaLwyWqSSgFjkRD4jgk4+qsYfdoY6pmxAqNoaIdEeQNrQyfw1cW5xti5BogkHmHlV0h
         4l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725594635; x=1726199435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07jLzEpcesGBjWhFDqtujhuQLMMXaeMmn6OQvBvkAyQ=;
        b=L98Ja1l37riuR4DRHIohxc1qSPoZ1ek6ffH57mUGOqan+//StC4m3lM39tUc8+Nsg6
         BWvj++lY5z3ADvuOLul+PNuER31e13bKR+5LCNU5uNpEQA3MI+LRxLBxbv2fiW/p/iLi
         GdadK1QrSsjfWd6X7P7uqS2tnFPe+OA6sc8XfZD+++ndvmx/erHIo5MSWxL2RskeTrAW
         caudKuvngVRZgB1dclfGMlO/dhRzM5tLsyCHhYDOcARH96j1T9DTTDpNC+cJj3BVTvYR
         UAJhOJVAsAIDpCFBBUrGfu5yIcW+NvWgUs2mV0bQ8oGsEDhuj62r9yfWmWpenyIl48Sh
         FaCA==
X-Forwarded-Encrypted: i=1; AJvYcCUOV0EQiQKU9amxT1W+hn3wF1QBE3uWyhEhqphM2z0cVLOztgk9ePIyKfg6ROIdJQwDRQu8JlJT4KEqmWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16QULQ8yXgGc/0KDFAOLqEbG3BjfVbovu5MNaA/vYfyAh9I/F
	75q2+fy03Wyphjnrtkj5JM2vDjdP1D1eIHMEz9uNj0eYDdRfNPTSC62wfEfMQecY1Dz/VwP1o8Q
	qKAZIktA3+0UqW9VbFgrhmiDnG4L02ZKGOXA=
X-Google-Smtp-Source: AGHT+IEoWVV3J28AqNRDaa8EBZcliKYPTohZN2yjyXFkS57mLRYybPWak3Y1DW9pUeNIspX/56oBRC6mnhVfXdPs3oc=
X-Received: by 2002:a05:6358:9986:b0:1b3:93b8:8c1e with SMTP id
 e5c5f4694b2df-1b603bebef8mr2994418355d.2.1725594635203; Thu, 05 Sep 2024
 20:50:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905095216.7888-1-wangyibo@uniontech.com> <50595531-87b0-4420-9624-948810066a6e@redhat.com>
In-Reply-To: <50595531-87b0-4420-9624-948810066a6e@redhat.com>
From: Lucien Wang <lcnwed@gmail.com>
Date: Fri, 6 Sep 2024 11:50:23 +0800
Message-ID: <CAHViUT11yTKKMhuGckX33RzoonUkFfijVpUXTYZgRhbjKfxbMA@mail.gmail.com>
Subject: Re: [PATCH] mm: move bad zone checking before getting it
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, trivial@kernel.org, 
	Wang Yibo <wangyibo@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 6:22=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 05.09.24 11:52, Wang Yibo wrote:
> > When flags from gfp_zone() has an error combination, VM_BUG_ON() should=
 firt know it before use it.
>
> s/firt/first/
>
> Please break long lines. (checkpatch.pl should have warned you)

I will change it.

>
> >
> > Signed-off-by: Wang Yibo <wangyibo@uniontech.com>
> > ---
> >   include/linux/gfp.h | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index f53f76e0b17e..ca61b2440ab3 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -133,10 +133,11 @@ static inline enum zone_type gfp_zone(gfp_t flags=
)
> >   {
> >       enum zone_type z;
> >       int bit =3D (__force int) (flags & GFP_ZONEMASK);
> > +     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
>
> Better use VM_WARN_ON_ONCE() instead while at it.

Although I do not know what results BAD ZONE flags combinations will
cause, I think maybe a BUG is necessary for security ?

>
> >
> >       z =3D (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> >                                        ((1 << GFP_ZONES_SHIFT) - 1);
> > -     VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > +
>
> Unrelated whitespace change.

I will change it.

>
> >       return z;
> >   }
> >
>
> But I don't see why we would want this change? It's not like the kernel
> would crash when calculating z.
>
> Or is there some change in behavior I am missing?

I just think flags checking should precede using it logically, when I
review these partial codes. So I submit this patch, there is no other
reason.

>
> --
> Cheers,
>
> David / dhildenb
>

