Return-Path: <linux-kernel+bounces-302459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D494F95FEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF54282F16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A702D268;
	Tue, 27 Aug 2024 02:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7lD3CZQ"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762002CA9
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725113; cv=none; b=hIJYcKLNHsd/NFUFTJSRy4PAl3Wbry1hjBf2JhOP2ZvXFM51cr3nNpcIVlqg02193u+A6uwCl3qmbgxqbn1PwZIkxIzB5A7ClHsJ1fOquWcgB3qVhKkzZK/UxE3PfKXWHrty/ZMr0+t2GJxvyqk/29j0G1NNeMS5q0EIzGC/Uzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725113; c=relaxed/simple;
	bh=siwGY23HicvLdKsR6KM27bLimkfR2eAsbuCl3IO9Kxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIF0u/L8IiokgS4BhIA7+JP7R1SWFhRbON++l0VTvRcFAGvXPqDoilkGuaCFfMEFeZgVSlm7vyxt+vY60QVDX5A9G7MSKBxuKqddQvJeNurO2+LvFhzZmQ4vKYDokMnQNxmO6nBQXB4n0DyINYnhE8DR9vewMQjwABWR50SiRxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U7lD3CZQ; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4fce9f16f83so1538044e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724725110; x=1725329910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siwGY23HicvLdKsR6KM27bLimkfR2eAsbuCl3IO9Kxs=;
        b=U7lD3CZQPEiybe7+gRflpCGg8uNFF4vSiQIyS6p8OgxWYScEY9L7TryrIz+faeDJrn
         QCcVzDVvEFQmfvgL2AjR47IQ8j8qBO+xxa3/pfswLqMlJVAQUDPBH0OPxpVdYeOcXFUx
         h1rSIBCV95PgxBjgJ5tLNrvfl+WoBhpC9PRxBARWN2FGeIiI43WrTN8iflcACF/Om8WC
         ajFh67jNwWPOnIA6j6BNCmyw+OkeSD153yeFsweoTu/6elDQCA1coFzvGAjKFip8Rncr
         D1gYat7eKphVjx4qOVq4io1JHZyRvik80LYZdYumapIcBsBE3KYJDXBaL1fz7lL59oe7
         kRKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724725110; x=1725329910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siwGY23HicvLdKsR6KM27bLimkfR2eAsbuCl3IO9Kxs=;
        b=NGW5elvDIn83i5JZL/Nn9TPhxmnOGy5Mpww6i+DBBKJaGQYRJz2IWpzy+edsEfHyBv
         FAzPXwI3OJ5okU82chtQRfkXEVu2Za4zQl6HouJcJKpzaRVZ/JkJRC/cRdfKowfKHQpJ
         QudsifD9dPVIr7EHO85rbuHt2YwWO04aapfnSiBwVd+qZvShISPsKvVtvoRJ/cocrZnF
         miQXVGIkgBXcogzhP1QetbY0o6tFdfFOJnVVyqm9sYExqp+3R38lhIrJLF1g69i/RWMc
         /yAzm5y3QPdGLvUpfXDUcZTcVxODfl24hZJkwDoXpDfluh0i3zfYKe33Gz7p9e1SXrdI
         vWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbLd9B+vc1I5asHveOJ7IKgMFCEd5E3g2e47fi/gVHX6tFya/RXmaOcvO50TPWAvv3487m1aMouiQlczM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9tv6u3yEZU4VoIiK+hCXP/2C0DGsFC74QhHX78fjsApgwDm2
	pyT+JN2LGyh8p27dybYPAjghxqCtNGzgGWfFQ+MA2lmJMixHQV9W6Wi74uafk7qhh7jd2Dk1Iwe
	tGkWCXXW8L2OHQbdnWe55qtd6GBw=
X-Google-Smtp-Source: AGHT+IFfU6dexOxTYKGD0IqP4V6YvktCXOJAeKUjoJ/4ETcAySvDOxI/AIKRNHHl4Dk1+gNo98G5yZ6BK2o0fJhXGSE=
X-Received: by 2002:a05:6122:c9c:b0:4d3:3846:73bb with SMTP id
 71dfb90a1353d-4fd1a734ddcmr15194320e0c.7.1724725110178; Mon, 26 Aug 2024
 19:18:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com> <20240827021351.iq6i7zkwm32xili3@oppo.com>
In-Reply-To: <20240827021351.iq6i7zkwm32xili3@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Aug 2024 14:18:18 +1200
Message-ID: <CAGsJ_4wUrm1Q7Oxb5BHC2ypyf4wAH+UO9KYhCUwsEbhkcc7QGg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Nicolas Geoffray <ngeoffray@google.com>, Michal Hocko <mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 2:13=E2=80=AFPM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> On Mon, 26. Aug 09:37, Lokesh Gidra wrote:
> >
> > IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> > prioritized for reclamation over file ones.
>
>
> > >
> > > Adding Lokesh.
> > > Lokesh, could you please comment on the reasoning behind the above
> > > mentioned change?
> >
> > Adding Nicolas as well, in case he wants to add something.
> IMHO, lruvec_add_folio is enough. if lruvec_add_folio_tail why not use
> MADV_DONTNEED instead? In MM the reclaim policy prefer to reclaim file ca=
che, if
> MADV_FREE'd pages directly add to the tail, they might be reclaimed insta=
ntly.
> Also the benefit of workingset_refault_file cannot be convinced for me.

My understanding is that MADV_DONTNEED will immediately free the memory,
whereas MADV_FREE will release memory only under memory pressure. If
memory pressure is low, the anonymous memory may still be gotten back
without causing page faults. This might be what Lokesh is aiming to achieve=
.

>
> So we should know the reasons and the benefits of the changes. page fault=
s or ?
> > >
> > > >
> > > > >
> > > > > --
> > > > > Michal Hocko
> > > > > SUSE Labs
> > > > >
> > > >

Thanks
Barry

