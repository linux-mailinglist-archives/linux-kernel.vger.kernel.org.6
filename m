Return-Path: <linux-kernel+bounces-301563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6095F295
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA014280EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470C817C9AB;
	Mon, 26 Aug 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WscjqlGu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19306F31E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678129; cv=none; b=VZ0j6r6oz9PytnXL8xhAtcH+bub+lQ6BUc0H3rNoYPTjGogHNXQ3/ULaHV0dARzMr6LsVBvt55V0WC1M3+q5fz5ma4zsi2ao+mJMaw7p/IcGFz63tUzUGuT24j5srqXrfFM19pCRuqQBRpc0KXctcUVeRdrORGqWn+3AlZbInnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678129; c=relaxed/simple;
	bh=nbx+j22z+ZKthYT5nToIsmG33413+1GTdP6YPI2cyto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1uJG8rrV4X0dA/ml+VqjgwvG8OKM++Uq8VU3NOAo8kPEImwkaOwNALHbyQC7V066H8nEowbHBFk5ubNkC0A9ZhEgM3IvSBQSZH59oqTPZxWh1RMq2fL4emLflx8iwQUeWAWV2h5i4pjvRLeL1NJMZRkbF7Pg+WpAW5UHjsrlHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WscjqlGu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724678126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlU9cDRS151p3RNA7bzVGSnTyd6HT4EiI2pPDBkoArU=;
	b=WscjqlGu9NdB3dt/N7h1k5b6lHLZdBaEjAsHig0Z6i6ELP9+qubMIWAjCz+g6FcBTEZ8Ry
	KidxTn1TQRvoclmgM++R5fZyWnVCKNSpThR8J8T4BFAHcww4BN1Mjh0lgYa2aQUAKuX9b0
	y9xEyOAACf2C9tgDqOZl3xlXPVF3Vpo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-7zPMlMzZPPWr6ft2ETs-3Q-1; Mon, 26 Aug 2024 09:15:23 -0400
X-MC-Unique: 7zPMlMzZPPWr6ft2ETs-3Q-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2705e14211dso7078125fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:15:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678123; x=1725282923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlU9cDRS151p3RNA7bzVGSnTyd6HT4EiI2pPDBkoArU=;
        b=i9DF6WfTnh4Qd935DB805v1yX9ZstrQRHHbmjKvydVPIWkKD2YR01lrFkVHSd7Kpex
         eKpiUxE9nY1P5Bcm3IRJJCU4rfsxdgT2nzlDsfZX+PbueFvfstfQxSwI4JmMYEsHV4mX
         qq091rY111eWdu4SI/3TwAxmdG/YWx/OUgjg2x7TNohJwXjpwo17G2cZii9y5q9l564K
         nXpFkTu1l8mAXMLK/cskhpLLhg3wOgOam2eeUxuasubsgq/JvFH7Ja+Aa+Inqw587VBY
         tUudnjIbEt22dqgXszb8FDagj7nF2ro+64mZLga4t6mKd2JqYpRZkto5xdqbQ05hsmAW
         6kAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzemasCP548S+HYHJrJ3aLgbRbcjdsp+/RvYwGDQMf4rVQoRCYtuFf0sg5vWPbIJxlo1MRzGjz+fWrd7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwBbW5OuyGkZKZrQzsX1LjXdPLb6qSziP97aN2QbpxvZZHiBn
	Qpx2FzfYZdMDiHYBYgIOE6StV0ID5jRXikdEW8upAumVo8gXs546fLoyjDPfacmFb+lElxgcyBu
	L7d9EntT88lpDotIwMMw2UogYHlJhScbcc7c718r1iJUeuOpvR00KKIkvOBQ3Q3YATica3gKv/R
	bhSk627fsQhjfXaE/O9pdFRplHqST9Hf7rwdSpjAsImJOV+BM=
X-Received: by 2002:a05:6870:e0c9:b0:25d:f285:d008 with SMTP id 586e51a60fabf-273e63f21e6mr11597747fac.7.1724678122702;
        Mon, 26 Aug 2024 06:15:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzq2bSMG3n1mMWMxD3e9ncSJzObbAvcFCnCPnp8GOZioFDMaUJRjND+0VdyhQ/m7KU7RFZ8Thw8coLI6QWg6c=
X-Received: by 2002:a05:6870:e0c9:b0:25d:f285:d008 with SMTP id
 586e51a60fabf-273e63f21e6mr11597712fac.7.1724678122259; Mon, 26 Aug 2024
 06:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826120205.5506-1-liwang@redhat.com> <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
In-Reply-To: <CAEemH2dYB3tyG4xjE_b1rGBRqtCDOwByq5ZdA0VUxvL3nqW0Vw@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2024 15:15:06 +0200
Message-ID: <CAASaF6xh7_wXiFn9LakEv-LY-szkZ+5fJ0B67ygdCV0g4T-89Q@mail.gmail.com>
Subject: Re: [LTP] [PATCH] ioctl_loop06: no validate block size
To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it, John Garry <john.g.garry@oracle.com>, 
	Damien Le Moal <dlemoal@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:46=E2=80=AFPM Li Wang <liwang@redhat.com> wrote:
>
> Hi All,
>
> On Mon, Aug 26, 2024 at 8:02=E2=80=AFPM Li Wang <liwang@redhat.com> wrote=
:
>
> > Since commit 9423c653fe6110 ("loop: Don't bother validating blocksize")
> > kernel
> > drop validating blocksize for both loop_configure and loop_set_block_si=
ze
> > so
> > that set large block size succeeds.
> >
> > Error log:
> >   12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg >
> > PAGE_SIZE
> >   13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
> >   ...
> >   18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size >
> > PAGE_SIZE
> >   19 ioctl_loop06.c:59:  TFAIL: Set block size succeed unexpectedly
> >
>
> Hmm, maybe I was wrong here, the commit says
>
>   "The block queue limits validation does this for us now."
>
> which indicates the validation is still on.
>
> So the test failure probably means a kernel bug but not a test problem.

Before the patch, blk_validate_block_size() did validate original
value as unsigned long,
after patch it's validated after cast to unsigned short.

In LTP thread you mentioned it failed on ppc64le/aarch64 and worked on
x86_64 and s390x.
Is it by chance now failing only on kernels with 64k page size?
(Test attempts to set block size to 2*page size.)

>
> CC block devs to give some advice.
>
>
>
> >
> > Signed-off-by: Li Wang <liwang@redhat.com>
> > ---
> >  testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> > b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> > index 317f693a0..4aacd284a 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> > @@ -23,6 +23,7 @@ static char dev_path[1024];
> >  static int dev_num, dev_fd, file_fd, attach_flag, loop_configure_sup =
=3D 1;
> >  static unsigned int invalid_value, half_value, unalign_value;
> >  static struct loop_config loopconfig;
> > +static int novalidate_blocksize =3D 0;
> >
> >  static struct tcase {
> >         unsigned int *setvalue;
> > @@ -74,6 +75,11 @@ static void run(unsigned int n)
> >         struct tcase *tc =3D &tcases[n];
> >
> >         tst_res(TINFO, "%s", tc->message);
> > +       if ((*(tc->setvalue) =3D=3D invalid_value) && novalidate_blocks=
ize) {
> > +               tst_res(TCONF, "Kernel doesn't validate block size, ski=
p
> > invalid value test");
> > +               return;
> > +       }
> > +
> >         if (tc->ioctl_flag =3D=3D LOOP_SET_BLOCK_SIZE) {
> >                 if (!attach_flag) {
> >                         tst_attach_device(dev_path, "test.img");
> > @@ -126,6 +132,9 @@ static void setup(void)
> >                 return;
> >         }
> >         loopconfig.fd =3D file_fd;
> > +
> > +       if ((tst_kvercmp(6, 11, 0)) >=3D 0)
> > +               novalidate_blocksize =3D 1;
> >  }
> >
> >  static void cleanup(void)
> > --
> > 2.46.0
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> >
> >
>
> --
> Regards,
> Li Wang
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp


