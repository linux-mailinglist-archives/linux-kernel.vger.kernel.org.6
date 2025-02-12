Return-Path: <linux-kernel+bounces-511258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1EBA3286C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6980F3A7C60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5D4210190;
	Wed, 12 Feb 2025 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/FGpSKB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68620FAB6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739370558; cv=none; b=Bk1WmFqyNtg7kb3FZlfZiVUQASERX+ewGS8D6LOXd71xqQPT31fBvPkAR9RRL7grSe8SUKkDXh9h8lQ+Gi7gRJXO/qMUBFIWYdvjkdpB4773OTRegSexa+ExsBVSYTgt7KVzgzZeVfLkOerhL2OnL/rZGpdQxlRSCr5nH9IzJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739370558; c=relaxed/simple;
	bh=p9WPEvkBQpOGn0vTtNVqi/6VObHeGOYD3hDmy0J7hXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pv1e7053uDTRaH94hjJm/Cn7VT3vYyOQF4Kq319H7BMBTsZfXuQAuB7dEmkk4hv7H1aYkozbavGTV7Mj5OFCZ0wUkUec8Ncq1Y7Ih5QplppvkF5TzkS6h6T4yD4mKHU3xgpmaN45oEiWQuiAQqFs7z6xqWiYhz7bg91uryA1fcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/FGpSKB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739370555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9WPEvkBQpOGn0vTtNVqi/6VObHeGOYD3hDmy0J7hXM=;
	b=B/FGpSKBjTvKvhXpsdIcpeUHumO0tmZO8M7KLfkzgfNeLujL5qsvFaRlEOYO5CxDaKAyi6
	l61flJaNqX4P50ts1TtEPdxWNYKCKOIm498gUaGaxdaH095HrUEhQHhU9OUMJluDHFE4RH
	7/nIlw+ViNK6lDC5y63NbpDDaHObqRY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-0WqTa1QhPH6ojpZB5HWDaQ-1; Wed, 12 Feb 2025 09:29:14 -0500
X-MC-Unique: 0WqTa1QhPH6ojpZB5HWDaQ-1
X-Mimecast-MFC-AGG-ID: 0WqTa1QhPH6ojpZB5HWDaQ_1739370553
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5de363763ddso4234703a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739370553; x=1739975353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p9WPEvkBQpOGn0vTtNVqi/6VObHeGOYD3hDmy0J7hXM=;
        b=WFFBMdDyzx8vCU2BeUDGWoFc5dJRzwmDJf8O6LUukIAAC3BL1aTpjFOFdrPZ5wbTum
         dzEE0B3FUrsRVVJlc27UQqEXtr4TT/hRE0D8LlPJ4eQxXaPejWON1mh88kI7Fyv38dWN
         cNw+pPrpBGD9nMz0evRh16BwZ0Qggi6p05frra7cyCBdsBd+5n3MwyQJu5JsGwECCHyt
         aiEqizkgGU8kT/85LiUN4TZtZgHJnohRwF8fLNB+4qg3hj1uWZ9hDnOJ6t7yHNl9MOuF
         R/itm0bFAkiUkwe7ecdCj4ucCXUxYbde6Uy62cauuDNxK6ize8r5PryjYXWeZGnE+Ebt
         nZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Rp5Gmu9zHWpr+P2iWptTHnnP4fLuVwB0I4sJ+OjX0ruTMuuvA/Gd5Whu5aQv4mDs8Yg4t8ZQXmSR2r8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws9KI60w4iKK/vCo3V+uK1+Hp8WP75nQT3Rq8cDNH+B8VE3TT/
	whtc15VwZpMxXp2Hklrot3c0By90WEVWBDIvGnoVnjRwqRc/o0NW5QqvKmeZQ/jbQLt+9ggG1gx
	Z2vImLmXtwcddHBTBH2DOAIwhxvEQ7FxOG3jecL350Z1HH3Te/U20SsXAm84CSAqRVxteYLdnP8
	VX9Mfgq0v8iUaSCpNmv/wDUksvote+sYn+xvat
X-Gm-Gg: ASbGncunDbKozmL9abt0e4smDNVZZ3EaIcynzlnCbR7LPcstE73v7GLAfmUAjStdooX
	Z/NanarLfsEEXsGZqUeaSukup23rmwpPIKlCWnSiv5w15+n47/AQTDbJVHDL4Alo1BSC/xwzFmP
	LzcOEp8nXErJKsEQa2bw==
X-Received: by 2002:a05:6402:3510:b0:5dc:7374:261d with SMTP id 4fb4d7f45d1cf-5deadd71ae6mr7994592a12.7.1739370552927;
        Wed, 12 Feb 2025 06:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFODMyc0mg69LtDY6AULrP8h8emzE8pmqlTP7h4KHBaL4p+FpoBPUfEFgNkycdGMlVSlAMSgfgepus94exDBMg=
X-Received: by 2002:a05:6402:3510:b0:5dc:7374:261d with SMTP id
 4fb4d7f45d1cf-5deadd71ae6mr7994548a12.7.1739370552594; Wed, 12 Feb 2025
 06:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206104300.416014-1-ryasuoka@redhat.com> <d8a453e9-c8ce-4a7d-8fb9-08a13c44d7f3@collabora.com>
 <3c0e06d4-b5b7-45cf-bc42-8f12b293b7da@redhat.com>
In-Reply-To: <3c0e06d4-b5b7-45cf-bc42-8f12b293b7da@redhat.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Wed, 12 Feb 2025 23:29:00 +0900
X-Gm-Features: AWEUYZlZPWJuA_vK95ztJ7A8EkKN1A4KF5b4RIqvSAABBcmQQ3uMF8dJqmXE2rg
Message-ID: <CAHpthZqYGwXCqZYSXgrbZ8AT58kXS+qm8LRE=SWkrQvgx9CUHw@mail.gmail.com>
Subject: Re: [PATCH v7] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>, Jocelyn Falempe <jfalempe@redhat.com>
Cc: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org, 
	olvaffe@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, daniel@ffwll.ch, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 8:14=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> On 09/02/2025 18:45, Dmitry Osipenko wrote:
> > On 2/6/25 13:42, Ryosuke Yasuoka wrote:
> >> Virtio gpu supports the drm_panic module, which displays a message to
> >> the screen when a kernel panic occurs. It is supported where it has
> >> vmapped shmem BO.
> >>
> >> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> >> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> >> ---
> >
> > Applied to misc-next, thanks!
> >
> > I've tested v7 with a different capsets, works well. For a non-VT FB th=
e
> > vmap indeed will be needed. Looking forward to the atomic vmap support.
> > The rough idea of the atomic vmap helper is to make vmap code paths fai=
l
> > whenever hitting path that needs to sleep. Likely will be easy to imple=
ment.
> >
>
> Thanks for your support.
>
> I will see if we can do something for atomic vmap support for shmem.
>
> Best regards,
>
> --
>
> Jocelyn
>

Thank you for your kind support.
I'll try to write the atomic vmap support patch soon.

Best regards,
Ryosuke


