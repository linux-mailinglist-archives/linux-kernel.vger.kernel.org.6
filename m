Return-Path: <linux-kernel+bounces-282191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5179794E0A7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 11:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105B52819E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD338DD4;
	Sun, 11 Aug 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoPeiUl/"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A792B9CD
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723368155; cv=none; b=dcmRgF2j6xSblIBFwd7k5QpFD5go7ctDhgl5tlI/olFg4Z9qgkjjK1ormI8weEFf8puVh5VjMDrhPECVq2UHWn8pQ/djsjckABUy1VoAcrUdZuBflRDJyML3d8hBecH76ru3lREjElVVr9jyutrpkxX+WPcYFFMuSG+W3lEhn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723368155; c=relaxed/simple;
	bh=JiqZ5F6kcg6CtV3g+73umXtaP4HuI5qMoV3DD+4Atc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bu0Sw63gYQJSkkpuF2/vWS5uzDrbX6ikET3eJb+0Qplnr3A2FttH/nWkRhMnUTw0easxVn0jQQAwtZm9nuuyqG/O/PmTrzK/sxiYfPRD3DrhZryDeWbxtSP3c3Vlf5jNDg+qVJgGnUTmftZR/Rfpj6gugrMzbts0lKLZNv3aDSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoPeiUl/; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f6ac1628dfso1165200e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 02:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723368152; x=1723972952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLaYZ8wOVJRqaAfDCb8RdcM/bRwQ6VYGKjOcAekdAS0=;
        b=SoPeiUl/y0GVlAmwrplUtJjjuGDzNY1rAXED5xxS7snk56Keof+yAPBu3YkSGqvJSd
         mCvg8ojNttWtKxg7dUs284VSy2HjHeRRHc5rlp0yEjYN1Gq5oESCGdkbbWJCiLWf4wjR
         K4l5lc/B5rN6SM0MqQccmY9aBakBaG1T4zajHVWtG2vHBtH9RGkXlLw4tkPbZWp6O1Jp
         mS0vEZx6bRtQJGqeVbaBgl4MRVWrn0dmyIbR2aW3hzXqUSoizSJx1WIKvrjlIwa/LlE1
         PUkuXf6EcDM2KpANt2dUeUsaO9VCTt3tZWiNgOPcCwUzaIefB31XGQwbnJmktENOfqV7
         HDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723368152; x=1723972952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLaYZ8wOVJRqaAfDCb8RdcM/bRwQ6VYGKjOcAekdAS0=;
        b=AbKoo1lrM55GGEDjze0lqZWWFKQEais0JqCrYeC8Wkh6eN9lRUiMJV8WIAG7H3fm6B
         Wn4/HyeewWgwOBfIAl4iQGRs6d8Xghq/0QWBh4aQ0HUEw+uF0jWGEtCxu/7KyHiM5d+9
         ymmbBcHpu7y4lY4HPtjAcVs1WrEkjPBqktGk0oLHGxbb6GoW8Pq+vUJmeRc3BILUSH+G
         QObxkSA4R1zThO+zkbpHkRguz/LOU6DESK/VcvaZfUHLH2biCfV4Xy/SGUPTECnOMEA7
         pBnCY6Qf8G+y5WSs/A1oGfPa6EQXGo3LSg83eKcTUYqdBA5EuxTaw8MDZCxlXMh2FfJ8
         b+BA==
X-Forwarded-Encrypted: i=1; AJvYcCXoJb+NYPrcMKuld0Is7+ufeKoL9xRNrCA7W10QIc2Ix0MY+tM9pilnmCLuRjVrpCDxpJ4F3Ms2MsEZYEq4nOjsdcnSASheIoTbzzrK
X-Gm-Message-State: AOJu0Yw39YqlYW/Ququo7QVQfzNFtIe/3a0DdRg/fU7M1bU5YFPT9ncf
	pit+V43eRPHj1TqQm4u+bOYdo/rGumktD0Wi8ez/AXqDwXUZEn7EMGqNydQ2EkeSQzujuihjXR4
	L7TcSFImdX9HYHLih2FmU2QLfgR4=
X-Google-Smtp-Source: AGHT+IFgcJiZ65dB4VotfMOC9xLv86p3zf1BzDbqZj3vQt18yXBhtkoXUKJEONnKlVRvIQ6njgE75LDjv6rgBcnPwHY=
X-Received: by 2002:a05:6122:318c:b0:4f6:b160:3806 with SMTP id
 71dfb90a1353d-4f9132eaf09mr7349309e0c.11.1723368152444; Sun, 11 Aug 2024
 02:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <41b49313-5804-46ba-9e1d-358b079274cd@redhat.com>
 <20240809070412.33847-1-21cnbao@gmail.com> <62d758b1-595a-4c05-ab89-3fe43d79f1bf@redhat.com>
 <CAGsJ_4z-bCSSQecYq=L4U1QuoQUCtgY1WXbAX=eCEO9rXv8eNQ@mail.gmail.com>
 <CAGsJ_4w0SzyA50zNcGAgUc36GOEVr3L6gcZntw4ejBogC9b6+Q@mail.gmail.com> <fae2def0-918a-495b-a89b-3a8eedd44b1f@redhat.com>
In-Reply-To: <fae2def0-918a-495b-a89b-3a8eedd44b1f@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 11 Aug 2024 21:22:21 +1200
Message-ID: <CAGsJ_4z5hs5ehF=kq+CSHiQDUB=tu=Qy6X6fxhK6Qn4qg-X3yw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: collect the number of anon large folios
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, hanchuanhua@oppo.com, ioworker0@gmail.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ryan.roberts@arm.com, v-songbaohua@oppo.com, 
	ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 8:51=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> > the correct place should be:
> >
> > @@ -1329,6 +1326,10 @@ static int migrate_folio_move(free_folio_t
> > put_new_folio, unsigned long private,
> >          if (anon_vma)
> >                  put_anon_vma(anon_vma);
> >          folio_unlock(src);
> > +
> > +       if (folio_test_anon(src))
> > +               mod_mthp_stat(folio_order(src), MTHP_STAT_NR_ANON, 1);
> > +
> >          migrate_folio_done(src, reason);
> >
> >          return rc;
> >
> > Without this modification in migration code, my tests fail, anon_num ca=
n
> > become negative.
>
> I was wondering if we should do it in __folio_migrate_mapping().
>
> There, we set newfolio->mapping.

Correct! To handle cases where the destination might not be migrated to but
could be put or freed, migrate_folio_undo_dst() will be called to release t=
he
destination earlier. It's better to simply place the count where the
anon mapping
is set and cleared.

--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -423,6 +423,8 @@ static int __folio_migrate_mapping(struct
address_space *mapping,
                /* No turning back from here */
                newfolio->index =3D folio->index;
                newfolio->mapping =3D folio->mapping;
+               if (folio_test_anon(folio) && folio_test_large(folio))
+                       mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON=
, 1);
                if (folio_test_swapbacked(folio))
                        __folio_set_swapbacked(newfolio);

@@ -446,6 +448,9 @@ static int __folio_migrate_mapping(struct
address_space *mapping,
         * no turning back from here.
         */
        newfolio->index =3D folio->index;
+
+       if (folio_test_anon(folio) && folio_test_large(folio))
+               mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
        newfolio->mapping =3D folio->mapping;
        folio_ref_add(newfolio, nr); /* add cache reference */
        if (folio_test_swapbacked(folio)) {


>
> --
> Cheers,
>
> David / dhildenb
>

