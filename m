Return-Path: <linux-kernel+bounces-561237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F5A60F14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB08E188C632
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED3B1F130E;
	Fri, 14 Mar 2025 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XmtcR9PI"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E7F1581F1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948548; cv=none; b=UG21Him9Woo/UeZQ67J6R6bJ/clXO5w2IyCX5Or0BWRPxI41h0zJqE6wSsbs5sNZCgZ1hULYCP3a5a0LWPjaS50YJ16NYEEdrnyS1kRM5CIMAM+FaNIzLFFAfUoz4vg5RHuzkcRreYmkA8BYrCi7hBFDZhA0f6svywNbhVIF8BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948548; c=relaxed/simple;
	bh=J7Z6Z7JXNqbKUjtcvPWSnNlBFOAB3gZi29fvLe3Xeb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DI4W91GLyuAPy5xGME6V4yEk5ILyDncogZpJW9klIaOVHtM9UKQb0SIWjuL1B5rFUmt0ENnvfpi6pRlsRFjvUx8y3pcNsQxdtBNClnrdMYHCpHIgxD61Y4dcM4BZ9sGBKs99dweXMJsuUVsHzAgeIBIU95vmBc+zI5xvlbvNQFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XmtcR9PI; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so17601901fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741948544; x=1742553344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCmMR17KASub8kG2P4Bhk5E3WXSg+MDPvYkx4oQr4cA=;
        b=XmtcR9PITRed8XXFATyHn9xr2+byIZlDK2FBelsHf7O07PtCIU/g0/o3h4W6IMZgqZ
         0XL/BgY+veqQRJlJYf1HZv2xSRLCVxycSQnHznB2lLv6xPCSR2viSdesxuWalAtSgNvc
         px5qL4S5DkL1AjIcY98JGDsG7JJKBY1qjlsTHIjN35ZUkr0YSE0fMFxk3xeTY8oPxQUC
         GQdDipNf8Gbmz1TSJw7yqlmfiW5flnFXDu3pzXdWSOMrgC5OGE7abRZl/L9a+WfiseBd
         Vr2lp0HVgRvBHuD8bI+pl9WgmG45a1FLb8hm2bMX//szFso/nHYwyPCCCO/xvhgmi27Z
         pDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948544; x=1742553344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCmMR17KASub8kG2P4Bhk5E3WXSg+MDPvYkx4oQr4cA=;
        b=CWn7JjxTlLPZgG0QDu3Wv6laBOmQO2di3qOyuT+xY3xatkKWIY/zNb85coghMX3gtu
         qDLAv6+woTu9yilgxQt67i6HIJVMWUADFXNvl/nLwJ+sDGYicM+BfDU+q+2BM9A/zL4t
         IKcmcQXG1oG0bDFDivog8e2QjiTuKXEWW22GBTqpa9af7X0EY4qyq0Whx5olu0NbBWHE
         9nlgE7N7RqqFPh4t9HTKeiUx1cFYZgc5oVLX1hrUOXLoRV6bGVz2Ku3hQV5mavYYhM0D
         n/jXakXHCide+6WpexaOPcmxQ9Vqpb71/Unb2Cnt95T2abMv8bTHZRIrSwCg2bILwMCT
         JiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFAuPDz8iakxOI49vav439rX54BrI30RGh+odVnfxsrofn71sSNENtnhEkiVLlhGbWBJhLw4NUmOZtDTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCNEQ4KDYrx4bj0Trx/gFbjD/kWLZV0mNue/Tjilrwwf6KS1OK
	f9+Vlk/CLM4SlwvZIUiJADW67U+Z6YzoH5vnk/LRfd+MeHMmvQ5g5Qg0khp5nZdUmNCKGK7Yq65
	XjbMsz+gEpmMSPFXmPAGvpJ0lNwfNQqAltXieJg==
X-Gm-Gg: ASbGncuQ7A9YAE1cdQfMOVabMigAWUH5l67Acv0prKUxxxSoPCDBN6SQBMdUhZ/D1r3
	uuR78/hNRAKvdC3qxZSuSk84RgBTcibhUx4HJgZKC5/EJgMN8KB5jRj5pUfdQLOGRi5Fe/+OBfY
	lK8wL0rFiQTDUfhEjTV+dMCBmB5dk9cDC/M/RkkSDCyRobyDy4iA==
X-Google-Smtp-Source: AGHT+IGmFtwNm8vMybPTd+nTfyXxMsR6vhRH4fTRCZm951GF+DGPrO/St4ijKA18t+Y/Zpfd3omrzTA9U3vvZjG4TPc=
X-Received: by 2002:a2e:3806:0:b0:30c:317:f3ec with SMTP id
 38308e7fff4ca-30c4a875efemr5722801fa.17.1741948544300; Fri, 14 Mar 2025
 03:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
 <Z9PuXMlHycL6Gco0@tiehlicka> <Z9P2nZ6b75FRMhCp@tiehlicka>
In-Reply-To: <Z9P2nZ6b75FRMhCp@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 14 Mar 2025 18:35:07 +0800
X-Gm-Features: AQ5f1Jo5Z3yuAmBxomFYh1PXxcwNGIlc2EbM8aTJzpoe1eRsPDdY8IaOBKGA3VY
Message-ID: <CACSyD1M9v6S6UVPLdPuoBKBMAphWrR-xsegRc6=_TKxMqu1MJg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH V2] mm: vmscan: skip the file folios in
 proactive reclaim if swappiness is MAX
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev, 
	yosry.ahmed@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 5:28=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 14-03-25 09:52:45, Michal Hocko wrote:
> > On Fri 14-03-25 11:33:50, Zhongkun He wrote:
> > > With this patch 'commit <68cd9050d871> ("mm: add swappiness=3D arg to
> > > memory.reclaim")', we can submit an additional swappiness=3D<val> arg=
ument
> > > to memory.reclaim. It is very useful because we can dynamically adjus=
t
> > > the reclamation ratio based on the anonymous folios and file folios o=
f
> > > each cgroup. For example,when swappiness is set to 0, we only reclaim
> > > from file folios.
> > >
> > > However,we have also encountered a new issue: when swappiness is set =
to
> > > the MAX_SWAPPINESS, it may still only reclaim file folios. This is du=
e
> > > to the knob of cache_trim_mode, which depends solely on the ratio of
> > > inactive folios, regardless of whether there are a large number of co=
ld
> > > folios in anonymous folio list.
> > >
> > > So, we hope to add a new control logic where proactive memory reclaim=
 only
> > > reclaims from anonymous folios when swappiness is set to MAX_SWAPPINE=
SS.
> > > For example, something like this:
> > >
> > > echo "2M swappiness=3D200" > /sys/fs/cgroup/memory.reclaim
> > >
> > > will perform reclaim on the rootcg with a swappiness setting of 200 (=
max
> > > swappiness) regardless of the file folios. Users have a more comprehe=
nsive
> > > view of the application's memory distribution because there are many
> > > metrics available. For example, if we find that a certain cgroup has =
a
> > > large number of inactive anon folios, we can reclaim only those and s=
kip
> > > file folios, because with the zram/zswap, the IO tradeoff that
> > > cache_trim_mode is making doesn't hold - file refaults will cause IO,
> > > whereas anon decompression will not.
> > >
> > > With this patch, the swappiness argument of memory.reclaim has a more
> > > precise semantics: 0 means reclaiming only from file pages, while 200
> > > means reclaiming just from anonymous pages.
> >
> > Haven't you said you will try a slightly different approach and always
> > bypass LRU balancing heuristics for pro-active reclaim and swappiness
> > provided? What has happened with that?
>
> I have just noticed that you have followed up [1] with a concern that
> using swappiness in the whole min-max range without any heuristics turns
> out to be harder than just relying on the min and max as extremes.
> What seems to be still missing (or maybe it is just me not seeing that)
> is why should we only enforce those extreme ends of the range and still
> preserve under-defined semantic for all other swappiness values in the
> pro-active reclaim.
>

Yes, you are right.
There is a demo if we bypass LRU balancing heuristics in pro reclaim.
I have a question, but I'm not sure if it should be considered. For example=
,
if anon scan=3D5 and swappiness=3D5, then 5*5/200=3D0. The scan becomes zer=
o.
Do you have any suggestions?

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f4312b41e0e0..75935fe42245 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2448,6 +2448,19 @@ static void get_scan_count(struct lruvec
*lruvec, struct scan_control *sc,
                goto out;
        }

+       /*
+        * Bypassing LRU balancing heuristics for proactive memory
+        * reclaim to make the semantic of swappiness clearer in
+        * memory.reclaim.
+        */
+       if (sc->proactive && sc->proactive_swappiness) {
+               scan_balance =3D SCAN_FRACT;
+               fraction[0] =3D swappiness;
+               fraction[1] =3D MAX_SWAPPINESS - swappiness;
+               denominator =3D MAX_SWAPPINESS;
+               goto out;
+       }
+
        /*
         * Do not apply any pressure balancing cleverness when the
         * system is close to OOM, scan both anon and file equally


Additionally, any feedback from others is welcome.

Thanks.

> [1] https://lore.kernel.org/all/CACSyD1OHD8oXQcQmi1D9t2f5oeMVDvCQnYZUMQTG=
bqBz4YYKLQ@mail.gmail.com/T/#u
> --
> Michal Hocko
> SUSE Labs

