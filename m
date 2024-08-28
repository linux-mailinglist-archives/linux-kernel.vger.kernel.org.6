Return-Path: <linux-kernel+bounces-305207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4B962B05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9AB1F25418
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E131A2567;
	Wed, 28 Aug 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="2Z2velI/"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFB41A2554
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724857404; cv=none; b=jfWDn1+zqELwG+eEJhXdZS0sMONLWN9G+Z/xOQq95ky/08xvsJZ8vnVsVxci1tlYAXvIb51raGseJkOmSVaeqK0vRv3+muEOCo8YvEqNokgVr1dhWJiN4sSLpARZ3i1t7+fbD1L2WS6pcMPRt4IUJFtzuPqZSxKlHLIIEoFTEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724857404; c=relaxed/simple;
	bh=gZJvAwS84XG2gWnkUBtlpWa9JrbHPHI1F7UydNFtnGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ug5z6+VNX443i+Kn+pcS+htbHyK7eWhCLojr8xZR5TfH+47mpoXaI4MWUy+stySHF3x940pojbrqM2bj2rGLYroPcpx2HNHFxc4gskubHVp2pEHa5w4XT45IqspOPk6aNag1T4E5tIqp93nzLb0J2szeqbrBfZLzXcOr5tsO1Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=2Z2velI/; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-451b7e1d157so35842871cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724857401; x=1725462201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eirJb6fPtSkbDJD3rUL81XHybmkCT08yqrb3byO7jZo=;
        b=2Z2velI/nr/n2+3LWssr/eveZxKwkdLFd2P6W1RvkXvVA4G201zWoY8TZeX6ldWIac
         fs6JcLmNabEgNAjyFZuEFW8VU40zvZcemdCr1ivQ6QHBTYPa+/b3piy7jhk+btH0hn8E
         f0ovsDvF7IMfXpMwhEkrY1vaoYh5FZ+fzmJ/y7iNmNQWms+ml1drv3DebZqh1d2IGYRd
         0OWNxIrCBKIlN9RBwboxIYDnKv1P06wZ7UoC1ttfkbvAS+QH8TDUjtHYGbMfrx22Ntmg
         Vfk5ChCwaPPUkSP0mSGJ6S8OaFQ7jhJqU+LqWuX7ueaZuXCOE2wp3HuTIQhzPMSrAorz
         S6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724857401; x=1725462201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eirJb6fPtSkbDJD3rUL81XHybmkCT08yqrb3byO7jZo=;
        b=gQSfol2koXXA3hRW7fAgbeKXR/ChmuhbgsTgFTKxNeX/FQZAW8ON+XQKmvuOriE0YK
         sO0LPhQGF8zMCgoR0ySizeaCZ7k1370OLPH8cq+jwhMzE/WtL/JMJnXVdBxn4fyi2j1u
         SiiWMoEpL9JWK7FR2lTfyMqmlmn3mtw5ddGTRPc4m+0rd74604OPbf2lB/bQRd04HV5e
         87hYuBOEGG95gvTxWPZXEpaMmIl7LDTCfUZ701DU+aYn2ESQ72PI3WKUP1XSfC5J2Wqk
         K5yqzz+svSJuV12VmHi/BkRGS+4GhM8p4CYVrV529N6K06/+e2Y+UX62crf3WjPrtB2o
         TUww==
X-Forwarded-Encrypted: i=1; AJvYcCUSGSszXVPPlgfWzxqHr3ZVDH8EVYCkqBWzMju17W1UY+yvmQehXa1kyYkrTm/Ybqij6z5ll1eJ0oKF48A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdQtFUDvHMFLq46pHmt8nDiax2AZeGg+iYuUAE6ZIXHPGfvuxY
	b5JJPyFBSFM6+0Eovkjc/bpE//LL54OGdZwlw/z/DgpRCPMDzQEfkqxzmJrn8KYAjZ3P4a7fSTd
	+OClmesoT2QLkpv3qrOoijVLzU4VXp6ebW/6hMA==
X-Google-Smtp-Source: AGHT+IEBiMD+hxI9m00tkhRtoece2YbpN+qgRSgRalfCt3sYMacWDcmWzugzUHSrxMs1y3oNGI+hqbq4OJVjaY2tpoY=
X-Received: by 2002:a05:622a:244b:b0:43f:fc16:6b3f with SMTP id
 d75a77b69052e-4566e62bffdmr24486521cf.34.1724857400716; Wed, 28 Aug 2024
 08:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240824215130.2134153-2-max@kutsevol.com>
 <20240826143546.77669b47@kernel.org> <CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
 <20240827065938.6b6d3767@kernel.org>
In-Reply-To: <20240827065938.6b6d3767@kernel.org>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 28 Aug 2024 11:03:09 -0400
Message-ID: <CAO6EAnUPrLZzDzm6KJDaej=S4La_z01RHX2WZa3R1wTjPc09RQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Breno Leitao <leitao@debian.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Jakub,
thanks for looking into this.

PS. A couple more email send mistakes and I'll go install mutt, sorry
for the noise :)

On Tue, Aug 27, 2024 at 9:59=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 26 Aug 2024 19:55:36 -0400 Maksym Kutsevol wrote:
> > > > +static ssize_t stats_show(struct config_item *item, char *buf)
> > > > +{
> > > > +     struct netconsole_target *nt =3D to_target(item);
> > > > +
> > > > +     return
> > > > +             nt->stats.xmit_drop_count, nt->stats.enomem_count);
> > >
> > > does configfs require value per file like sysfs or this is okay?
> >
> > Docs say (Documentation/filesystems/sysfs.txt):
> >
> > Attributes should be ASCII text files, preferably with only one value
> > per file. It is noted that it may not be efficient to contain only one
> > value per file, so it is socially acceptable to express an array of
> > values of the same type.
>
> Right, but this is for sysfs, main question is whether configfs has
> the same expectations.
Eh, my bad, thank you :)

Docs on configfs (Documentation/filesystems/configfs.rst) say approximately
the same, quote:
* Normal attributes, which similar to sysfs attributes, are small ASCII tex=
t
  files, with a maximum size of one page (PAGE_SIZE, 4096 on i386).  Prefer=
ably
  only one value per file should be used, and the same caveats from sysfs a=
pply.
  Configfs expects write(2) to store the entire buffer at once.  When writi=
ng to
  normal configfs attributes, userspace processes should first read the ent=
ire
  file, modify the portions they wish to change, and then write the entire
  buffer back.

so based on sysfs+configfs docs it looks ok to do so. What do you think?

Regarding the overall idea of exposing stats via configfs I found this:
https://github.com/torvalds/linux/blob/master/drivers/target/iscsi/iscsi_ta=
rget_stat.c#L82-L87
as an example of another place doing it, which exposes the number of
active sessions.

> > Given those are of the same type, I thought it's ok. To make it less
> > "fancy" maybe move to
> > just values separated by whitespace + a block in
> > Documentation/networking/netconsole.rst describing the format?
> > E.g. sysfs_emit(buf, "%lu %lu\n", .....) ? I really don't want to have
> > multiple files for it.
> > What do you think?
>
> Stats as an array are quite hard to read / understand
I agree with that.
I couldn't find examples of multiple values exported as stats from
configfs. Only from sysfs,
e.g. https://www.kernel.org/doc/Documentation/block/stat.txt, which
describes a whitespace
separated file with stats.

I want to lean on the opinion of someone more experienced in kernel
dev on how to proceed here.
- as is
- whitespace separated like blockdev stats
- multiple files and stop talking about it? :)

