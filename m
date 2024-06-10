Return-Path: <linux-kernel+bounces-207927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AFD901DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BDC1F2297C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038974062;
	Mon, 10 Jun 2024 09:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F79GrgXI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5918C31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011254; cv=none; b=rPgAABBtjaNfxqOlhs6v6apw6MBjkL76O1tvQpKHZp//YevdHbsac1KTkUHlfksd5DsLsVmhOLPfbX8e9Lj/g7GYBKSbODrws4iY9V0ohh62ouU7VPfIefjx5s6z8nIh56L9/sBlYAciGBsDldo1UgE5mQr0iBNry56B8Awt+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011254; c=relaxed/simple;
	bh=Xv/dEiCRkSpodmaL2d//ZO1u0bmo9WpTjN01UGyMVF0=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvJBVvDFBDVWMHaSZNdvMK69oMkq1PQMvH0ObdTNp8gWuW5jwAl4ZDWruvJclV+pj8TjLzbRjTBLUNSq1pSoYQlhVXUWenyncGaHWV2c9YZtLbhyqIidsghFbKpru5Ja9nEqHNJnBQyp2kmWrHXu9pZneEpaxmLwpoEYHsCKb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F79GrgXI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iJ6dvPVXFgwtQ4T7unQwyUfRp5ecBG5cGhKrfZARQs=;
	b=F79GrgXIboyumavs4OktKj/EXLJydCCpWHRRADW6QGNKs6Mpz+q+ZDdpaHSgS0a43/OuM4
	y7KGnPmWgYNzaBvKDLrPjg5XN4iXPsQegXPHMk7XflUYmu63rERySs3PDAbpNJ5BY72C4d
	0/feck1Y3zMBFdPgV6j2UusTIFiTdIU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-40eCdvsONTq2B9J-it5ZPg-1; Mon, 10 Jun 2024 05:20:49 -0400
X-MC-Unique: 40eCdvsONTq2B9J-it5ZPg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62777fe7b86so69269557b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011249; x=1718616049;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8iJ6dvPVXFgwtQ4T7unQwyUfRp5ecBG5cGhKrfZARQs=;
        b=AamWHrCoJyxIJMIeY0o9850foyYavD5CZGzpgd6kM2W1G9br90cFBxI8PQXBUSGIwy
         Urx/ACZQzYTNPSXOPs30B/ftBrCw1g42oooIXhyOev/Ch3p41e73MmSGG7FBBgpiaVVC
         DHkXvClIHY1XbQ8AxHppt5ijC9Z/YLA/TQyRFL7xYS1lYvXckVWYklTWjGZR3FciGdUD
         gTQMr3JqFoplqrTL8jWgb610/ppTqlk5/6Y6NNljOJzJkMwzSHpFC3BF8chBFimbagh2
         QctC6IZNtYB3FvBJnM7QW4m/YqrHCpG8gW1TbZmDH5HKVRu2os3lHqbfWcgWhrAzMf36
         p8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUL+DrnbSQd1cu4YI9Vl2DifbyRLg/rDvLavqkkNNSZEbYGXBEMk07zxVEPWV+N1jA2C/3tcV8aFRNLWj+kC6nkAFHPxGCPQV1SUTmm
X-Gm-Message-State: AOJu0YzN5I0QKwrmnlFrryO+47pIKOG/AinKRNbl1aOAregoexV0oK/i
	WVG1WI89mp54cGYh+oMm04bnVAc8+28tLcJglKKM2h8ba5WC2jIfnGb2cbD6YKMDhj3Tui+tumA
	mqp06BWOJugmMv0PwuzIv8qeXrbMOYwIM+zXC9rcNbcBZR4+l5IjRTpegbzAH2t8d9qaq/svem2
	5IOrQnyqRPHi1Rgi/vy2RVTUq7AFDvTZFfZOw/
X-Received: by 2002:a0d:e304:0:b0:61a:cea1:3c63 with SMTP id 00721157ae682-62cd56a9f69mr80025607b3.47.1718011248849;
        Mon, 10 Jun 2024 02:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFjnKBptFBgLEV5bzktHbMReA8zI8OX4PPVkODmioQ2wqMk8XLBtAg+pDd9bzT3M9lgzkU0g8BWKSGH4IH14Q=
X-Received: by 2002:a0d:e304:0:b0:61a:cea1:3c63 with SMTP id
 00721157ae682-62cd56a9f69mr80025547b3.47.1718011248570; Mon, 10 Jun 2024
 02:20:48 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Jun 2024 05:20:47 -0400
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-10-amorenoz@redhat.com>
 <20240605194314.GX791188@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240605194314.GX791188@kernel.org>
Date: Mon, 10 Jun 2024 05:20:47 -0400
Message-ID: <CAG=2xmMgEUVwhqSFV5uXe_HuXeMaN7kDPW5TpmcihHYe0seo+Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 9/9] selftests: openvswitch: add emit_sample test
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Jun 05, 2024 at 08:43:14PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:43PM +0200, Adrian Moreno wrote:
> > Add a test to verify sampling packets via psample works.
> >
> > In order to do that, create a subcommand in ovs-dpctl.py to listen to
> > on the psample multicast group and print samples.
> >
> > In order to also test simultaneous sFlow and psample actions and
> > packet truncation, add missing parsing support for "userspace" and
> > "trunc" actions.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> ...
>
> > @@ -803,6 +819,25 @@ class ovsactions(nla):
> >                  self["attrs"].append(["OVS_ACTION_ATTR_EMIT_SAMPLE", emitact])
> >                  parsed = True
> >
> > +            elif parse_starts_block(actstr, "userspace(", False):
> > +                uact = self.userspace()
> > +                actstr = uact.parse(actstr[len("userpsace(") : ])
>
> nit: userspace
>
>      Flagged by checkpatch.pl --codespell
>

Thanks. Will fix it.

> > +                self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
> > +                parsed = True
> > +
> > +            elif parse_starts_block(actstr, "trunc", False):
> > +                parencount += 1
> > +                actstr, val = parse_extract_field(
> > +                    actstr,
> > +                    "trunc(",
> > +                    r"([0-9]+)",
> > +                    int,
> > +                    False,
> > +                    None,
> > +                )
> > +                self["attrs"].append(["OVS_ACTION_ATTR_TRUNC", val])
> > +                parsed = True
> > +
> >              actstr = actstr[strspn(actstr, ", ") :]
> >              while parencount > 0:
> >                  parencount -= 1
>


