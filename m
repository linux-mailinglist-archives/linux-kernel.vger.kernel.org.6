Return-Path: <linux-kernel+bounces-204828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF5B8FF3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC6D1F28610
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF71991C7;
	Thu,  6 Jun 2024 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIfgnLn4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C00196446
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695754; cv=none; b=mbgT9jcBotfzjlopNu8yXovjN45gZg5m7mt7OLsADxBkFx4Zdte0okIt3mBsfPxOCG0mFFzWWx37Nr0wrT5EqdAw39ffeq4Lw81OuGV9j6jOSXhEy0sK227pgEPZvr9WoihUgtakkI9qI7gp9o/5i2GaJFbWa3VWN2muxXsFI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695754; c=relaxed/simple;
	bh=BpLUPhuD0Jaux9zNhc6cZoFq9PmN/G6ECDCzUrjjxS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/NOYZIScpEY7X+U9NicbGpwMiXG2xgLtQzfoZzGYL8wC+W72OBdn+Gt0iQHo1Jz3kGGf0vl1BYqKVz/7W1ZkyoZeJ1MJiUDQz2hBG3z994s3fPi+vx+EMx+K/xwP9PGseYsxc4w27qmL0ysYIayHQoRTscAvkPbF39wrbzMOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIfgnLn4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a62ef52e837so164521066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717695751; x=1718300551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1Ut3Dkh+dW6ZjfW0SAbH75TKykJw59snMxcOhxXPyw=;
        b=fIfgnLn43TLsPR67Nwd9jEMggcE7WTgraq9BFtMESX2rpqQ5pvzvJGIkjIY+QHVpnf
         TMzy7aC4+/iJ+NrOlVJVIFLkNO/AHvTqFVF8PvpuHJ8eajmr6IfRgGwcNr5rg9Xp1rpO
         va+xxLb+y4PPPegbq2Bppc9GuQHt2hjsqIMgUrmJ7IMwWDJ7/fPZKFHIn3OxAYTKPW/q
         Xt6O5QSAMOizYVUAP/VGeEAJmfHpEi8nOZMdlf7NZ9jVLST7ahb7kiIKt6YKT2mBpQb6
         j7gjBvL+FsZqnNUqKPcYqd4hEFeqxXZ0FYZWkAFiH5rHCLcbghSEiyoBqkHH1ZpMZbRQ
         1y7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695751; x=1718300551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v1Ut3Dkh+dW6ZjfW0SAbH75TKykJw59snMxcOhxXPyw=;
        b=bu2f7RW2IxPB6C9BG5/1Djlg0D1sp/YNf+kNyO9Nxlp+WnfC10UfBMi/YW0pufr4ac
         Chq30e/pkGQZgcx1QGICnzBiNHoOHSXyQPkQoyxzQeo1DoBOgH+q+pinpQI0O815vjR9
         c5juqrGmFqNQb41WNzFbPfpX4qQTWinWKgHseMh7ur8fF9W7UcRdc6yk/RVYZbI2KjnV
         mSjL/yekv/efATGNJvNiPB2QUO8Fa0kRFlP6qTzGsmrVzrvRhIBEqRo0/MQTPKl63l2D
         14RdVkspL8IGMrIOJyR4eCexST+l58fHNDRoc7TJIElg7i0vS0GIJp3SUgh9zHT4tPmS
         F4Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVqEwalCcm2MH+n7Vg6pUOdtrzxNWZs5Dsfkc2C18QVZoMwRHvZg4RB2l6Hyc75K2Q9K8avNq1st1ogQIEpEhNOMxdDtZvA2pDYLq64
X-Gm-Message-State: AOJu0YxV7xm9yY68LjeVpdJ6FZEkKfYeTj122sk79CAJR9SydCwu/nPA
	voYghkf9267smwG6J9ORWhS3Dkn3W8K3Nnk9e9RjnCxgmLHGW8dsClJsTzh+WYF7WY/2VRA9ts6
	LBuhHFDyeC1hLe++WAj+PHZrepCYi46IFP4Wu
X-Google-Smtp-Source: AGHT+IEGBdWWUZC+WrQXxIBv4KOZPlFFbVSfkIEVyzAaxtZJ4s8YMZ9cpHiZkAazV4knO5rL7j2QTzt4B0g4tFKtZN8=
X-Received: by 2002:a17:906:fb11:b0:a68:c5b0:9890 with SMTP id
 a640c23a62f3a-a6cd7a80f9dmr20626266b.42.1717695751357; Thu, 06 Jun 2024
 10:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508202111.768b7a4d@yea> <20240515224524.1c8befbe@yea>
 <CAOUHufZ-9NmzOKjLedvZFp0=N0LvRZn77qC6k1WXK+NHtKr=0w@mail.gmail.com>
 <CAOUHufZ36rQc8AfLtRv2QrEareysdvbprAEO5XkcG-FeDOxFLA@mail.gmail.com>
 <20240602200332.3e531ff1@yea> <20240604001304.5420284f@yea>
 <CAJD7tkbCRLdy0vD2Pd17fNrxHgkzW1VucN4qMkohLFLBLaaeCQ@mail.gmail.com>
 <20240604134458.3ae4396a@yea> <CAJD7tkYjJJGthQ_8NukGw6Q9EYbLA=8sAH_7=B90KXEL6HWdSw@mail.gmail.com>
 <CAOUHufa0Fpj6SjNgB-z0n5Jg63q1ewkbOAU65forpDwQVs45qg@mail.gmail.com>
 <CAJD7tkb=5GJ9SNUwDsu1Zy3Tus4rjsNo60Hg9N7=gGth409Diw@mail.gmail.com>
 <CAOUHufb6zXr14Wm3T-4-OJh7iAq+vzDKwVYfHLhMMt96SpiZXg@mail.gmail.com>
 <CAJD7tkZ+QY55GTzW9A7ZCm=rxAEfrW76cWXf8o5nwiKSXp8z=w@mail.gmail.com>
 <20240604231019.18e2f373@yea> <CAJD7tkYq5u7B+0UH2XKpeWJnUxoO2kJ1_XZ2JOgYpyNEVR7u0g@mail.gmail.com>
 <20240606010431.2b33318c@yea> <CAJD7tkbhWYzx=6YmzAh0F+cK-_Bn8mPOH7gMbQS7YVXmaFSgFg@mail.gmail.com>
 <CAPpoddc2vOLdQJ7HwG7x+=oZsTz221+YJcNbUtKvPjA9AyeY2w@mail.gmail.com>
In-Reply-To: <CAPpoddc2vOLdQJ7HwG7x+=oZsTz221+YJcNbUtKvPjA9AyeY2w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 6 Jun 2024 10:41:52 -0700
Message-ID: <CAJD7tkb2b0+4_m0gb8DKSTtRwtC2GMa9NF5RuGKhXJARYHK0gw@mail.gmail.com>
Subject: Re: kswapd0: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
 nodemask=(null),cpuset=/,mems_allowed=0 (Kernel v6.5.9, 32bit ppc)
To: Takero Funaki <flintglass@gmail.com>
Cc: Erhard Furtner <erhard_f@mailbox.org>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Minchan Kim <minchan@kernel.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 10:14=E2=80=AFAM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B46=E6=9C=886=E6=97=A5(=E6=9C=A8) 8:42 Yosry Ahmed <yosryahmed=
@google.com>:
>
> > I think there are multiple ways to go forward here:
> > (a) Make the number of zpools a config option, leave the default as
> > 32, but allow special use cases to set it to 1 or similar. This is
> > probably not preferable because it is not clear to users how to set
> > it, but the idea is that no one will have to set it except special use
> > cases such as Erhard's (who will want to set it to 1 in this case).
> >
> > (b) Make the number of zpools scale linearly with the number of CPUs.
> > Maybe something like nr_cpus/4 or nr_cpus/8. The problem with this
> > approach is that with a large number of CPUs, too many zpools will
> > start having diminishing returns. Fragmentation will keep increasing,
> > while the scalability/concurrency gains will diminish.
> >
> > (c) Make the number of zpools scale logarithmically with the number of
> > CPUs. Maybe something like 4log2(nr_cpus). This will keep the number
> > of zpools from increasing too much and close to the status quo. The
> > problem is that at a small number of CPUs (e.g. 2), 4log2(nr_cpus)
> > will actually give a nr_zpools > nr_cpus. So we will need to come up
> > with a more fancy magic equation (e.g. 4log2(nr_cpus/4)).
> >
>
> I just posted a patch to limit the number of zpools, with some
> theoretical background explained in the code comments. I believe that
> 2 * CPU linearly is sufficient to reduce contention, but the scale can
> be reduced further. All CPUs are trying to allocate/free zswap is
> unlikely to happen.
>  How many concurrent accesses were the original 32 zpools supposed to
> handle? I think it was for 16 cpu or more. or nr_cpus/4 would be
> enough?

We use 32 zpools on machines with 100s of CPUs. Two zpools per CPU is
an overkill imo.

I have further comments that I will leave on the patch, but I mainly
think this should be driven by real data, not theoretical possibility
of lock contention.

>
> --
>
> <flintglass@gmail.com>

