Return-Path: <linux-kernel+bounces-209125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54D902DA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F821F2287F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E322D8C06;
	Tue, 11 Jun 2024 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCOJa0rE"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B717B8493
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065435; cv=none; b=Otvdn+ANm2YkPZDXFpSVRbC6+BgmkcOsJH75Fd4kBbFSv/K2VjKZGJRgl5GukVPMor17hz4od2zj2nxU3H3v5E3BBzdxUqZywCjOeLe3RRz1SFR1NiqtMqtwkiTHkdgqpZn7YE6cLJ1aVWpVxNoYUp3n1Z/qCx0hV07wLjK7lXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065435; c=relaxed/simple;
	bh=sfxnA8+XeygUDSLwfbtWGmP+TC+oSgcwslYXHUTovp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUtJF/vxpHJVhWwX5KjtxkwQHjdTwGA1eq4TiBYeo8tf2U67BJaAA9PsnwNsM8GcrepdxnqOPS/g1QAwLZ6NIXAEebiRwm4XbUvHCvYXPLUAJa7AtGFrftQzct9r/m2SAdoK09mcbcb5x2cuPk+6EtkBOry2CzrySVSmIHsGQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCOJa0rE; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4eb14d993c6so1420493e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718065432; x=1718670232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBcfZBsNjXqvaaAUgvq2fla2LtZb2+mrlHXG8zrdJMA=;
        b=kCOJa0rE093+Gum8HFD47BCwnWIed3aX5mF9JkiS4HAdToKKSgcPb97YXilA4QIN8j
         heyH+mTeAmMe/ESfMhExX1vrC+DxIhERhzhD9yOrUrF7W6IAp4ZOzN4UTqO/WydKEzu2
         Kra19Tc8orKwdtDqX9SyAGFMtTPUsHlFk+VJEH3uE2ClAhgFlRUf79LZ2a4jzy6vi8bH
         StiomTp+GJIvbvO5+DpT+1sTbxdEhz8Hwqr4ozxdcS0kpe1LSEbpSfFfSMg2uwHhUyIF
         eqmyaaB32kd71VNWd4GUZnCVonS0BMr0RH4TfOlvSDE5ahD6IQymary/cXYUDR0bcdJZ
         Rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718065432; x=1718670232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBcfZBsNjXqvaaAUgvq2fla2LtZb2+mrlHXG8zrdJMA=;
        b=cr2dOsy01kSrcrzyfMYxLEOOO58x5mmOUwIq2LzS5evxhxbt8Y6DztAEIiF+xfrfOU
         G2w2q6te224PUQvAVFRYe8sxovEYdEJ8zCXUkPsTDMqKWcdGFXWtPMbZW7mFbb1viqZZ
         Hx9x1sgOFjCWZOLZacrkDl2FAGNKL2gwuXy2mL+vA/b9G8gh3pYGCinJH9XTNzieKnwW
         ArvlP6CkkDKoK2HTieLkXlIEziQIoACGWa/rNeJkpx38nqUviJcU65BTGNbBsaG1cZ9H
         Gdk0E6utH00Lry8AXYtw/sNQbLU8wVwOV86HXPflxCnzzccZ2dL0FbkOhOVNpD3zngVv
         0UMg==
X-Forwarded-Encrypted: i=1; AJvYcCWvusi800TCGnUVA6AFwt5BOlZizD3XVfuCFwrsPVWIZed532EL4+SD8e+PdY2xELPZmv4lbMxZXpBQuHGI1QZvj0iayS9dhc5ZzJcs
X-Gm-Message-State: AOJu0YwEYq2gcUdiKuHKvlJr0OUQWHjRsjyUvuWu6MMwbxMHvdhg4YL+
	a+N2U2TyhVR05+xmiA4ItF74tiBoyZWn6W7S3/fUneFfJbpeVZgyudM2hFMFe7gIg4gI2DbHW/X
	jVFHLME/RjN3tpf+hna1Uce4ARfc=
X-Google-Smtp-Source: AGHT+IEPO+fKpPNitn2Hs2H8gwkhPFk5foJ5Gk5K+ob/M5xFOEIWmXKCuDfDSbOu2UxhBupLz0iYAmsjhIV1/rVZDKU=
X-Received: by 2002:ac5:c7c4:0:b0:4eb:1b53:47a8 with SMTP id
 71dfb90a1353d-4eb562d9602mr8595148e0c.15.1718065432448; Mon, 10 Jun 2024
 17:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304081348.197341-1-21cnbao@gmail.com> <20240304081348.197341-6-21cnbao@gmail.com>
 <c9702789-5772-4750-a609-e44a5bbd8468@arm.com> <CANzGp4+p3xSo9uX2i7K2bSZ3VKEQQChAVzdmBD3O2qXq_cE2yA@mail.gmail.com>
 <emvsj7wfy24dzr6uxyac2qotp7nsdi7hnesihaldkvgo3mfzrf@u7fafr7mc3e7>
In-Reply-To: <emvsj7wfy24dzr6uxyac2qotp7nsdi7hnesihaldkvgo3mfzrf@u7fafr7mc3e7>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Jun 2024 12:23:41 +1200
Message-ID: <CAGsJ_4zTpcBj_0uC9v4YOHihx-vEek+Y6rr=M1noijwbhfBw7A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 5/5] mm: support large folios swapin as a whole
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Chuanhua Han <chuanhuahan@gmail.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, nphamcs@gmail.com, shy828301@gmail.com, steven.price@arm.com, 
	surenb@google.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 8:43=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Thu, Mar 14, 2024 at 08:56:17PM GMT, Chuanhua Han wrote:
> [...]
> > >
> > > So in the common case, swap-in will pull in the same size of folio as=
 was
> > > swapped-out. Is that definitely the right policy for all folio sizes?=
 Certainly
> > > it makes sense for "small" large folios (e.g. up to 64K IMHO). But I'=
m not sure
> > > it makes sense for 2M THP; As the size increases the chances of actua=
lly needing
> > > all of the folio reduces so chances are we are wasting IO. There are =
similar
> > > arguments for CoW, where we currently copy 1 page per fault - it prob=
ably makes
> > > sense to copy the whole folio up to a certain size.
> > For 2M THP, IO overhead may not necessarily be large? :)
> > 1.If 2M THP are continuously stored in the swap device, the IO
> > overhead may not be very large (such as submitting bio with one
> > bio_vec at a time).
> > 2.If the process really needs this 2M data, one page-fault may perform
> > much better than multiple.
> > 3.For swap devices like zram,using 2M THP might also improve
> > decompression efficiency.
> >
>
> Sorry for late response, do we have any performance data backing the
> above claims particularly for zswap/swap-on-zram cases?

no need to say sorry. You are always welcome to give comments.

this, combining with zram modification, not only improves compression
ratio but also reduces CPU time significantly. you may find some data
here[1].

granularity   orig_data_size   compr_data_size   time(us)
4KiB-zstd      1048576000       246876055        50259962
64KiB-zstd     1048576000       199763892        18330605

On mobile devices, We tested the performance of swapin by running
100 iterations of swapping in 100MB of data ,and the results were
as follows.the swapin speed increased by about 45%.

                time consumption of swapin(ms)
lz4 4k                  45274
lz4 64k                 22942

zstdn 4k                85035
zstdn 64k               46558

[1] https://lore.kernel.org/linux-mm/20240327214816.31191-1-21cnbao@gmail.c=
om/

Thanks
Barry

