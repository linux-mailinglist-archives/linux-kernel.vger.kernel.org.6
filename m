Return-Path: <linux-kernel+bounces-303241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A01960971
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35D23B242ED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0773E1A08B2;
	Tue, 27 Aug 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hW08VMYW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA481A071E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759975; cv=none; b=O06wtRuTSfEjCFJb1JhzOOCr8eQvQ5c29Kn5W273OZWtv9hS7k/TDB2z3VBikDCdhegYVdO9SfgPY4g5rn+SNRWSEmAOmquJbaGmvcAtHbvTf8Bf+Ji4zWWhpO8XAvVIehX8xMCHkCtOUiT+gAZvchWx+lIl4s0IncyIrCKwdkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759975; c=relaxed/simple;
	bh=YPGan9U4uILLIfw5Q904AqkNBa+s23zrDAw3rzx8+0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAjiHmyR/7eJ5MrmrFTdsTHZb5XzZFhcBbIoHZmT2ii9VX0qU2UFn15sy50hSG7xYVh5NAGcAIetk1CDOxDTZfC2Pu/+NjHNo5BbJQMg9n2nwsGPwFj7Ws0OnU9RT/iVD2H9wisrzAcSvVnrx+jBPJhyRr5qDhz2EBRF54nfJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hW08VMYW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724759971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bqJr4BiooH9esIgWULrcJP95PM7XI8L6ZzTNLa0Ai+I=;
	b=hW08VMYW60VgFlMXkbo62UP6GcKu9m8dnULpvOggOlZu9JdAHVUO6f45x5eidFYGLbJsYa
	wxIe7t34VefNC7AOnIVAtOWaFEPp4dX975WVD06C7kV09lkXg2sBkvKhMNstCtXWRcNdkX
	9sPrKPQS/yzUwZ6n8KjlhhCZ4yynoJc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-yMsMWzVDMKGLn8PT8PzG2Q-1; Tue, 27 Aug 2024 07:59:30 -0400
X-MC-Unique: yMsMWzVDMKGLn8PT8PzG2Q-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d406dc42f4so5535058a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 04:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759969; x=1725364769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bqJr4BiooH9esIgWULrcJP95PM7XI8L6ZzTNLa0Ai+I=;
        b=Mo1beRL94B/2zzCFz1rsVaqlP7eQnd7/NHcn4Sw6jYWeykPS7roxkP0++BQXJOQLaq
         UIBhX2+jFAFeY/te7lSVRhr2lULle5qIUSY3JpbGe0Gcq76bjwN1fNZJWUQfoP32korx
         aACSCt7AVZR4PffcmKgmbI3++y8kcv0kwQkYElIwhydb3uU+c/Kvbq+mYThhzSAupNvl
         1L7fw34rg3kJMzddWQgKE/cMd00R56yf6T/XGDHjSWy1psWIvsIswTSLhA62CN1h6CRr
         3kxE3ywgCXDeZLsz55MuKdwc82UoJbglsTzSraun14mBSLmz7OJCEiDDaeBBuVS9N3n9
         X6og==
X-Gm-Message-State: AOJu0YxLaIL9ejJVpT6RLBNBau/dQtAmcKvC4igx29vQhrxKS/uy8zKe
	n3jiMKis9bOrnAMfHD11ZAsutYtMvpbeCrBGKThNvozJpjkOiUBPxI8cb9+XhhrglsMbgSvLQ2y
	h3VR3DBWT6FiyUy5f/+6Gkx2dVvnPCVy29nTWGxjHo3kBvuKIUpeOOxVZ+zqZOr0G77dbX8PWVr
	RvKyJHC7PFysIJU7RpmCLJhfkRzatlVniVSy72
X-Received: by 2002:a17:90a:17ca:b0:2d3:da82:28e0 with SMTP id 98e67ed59e1d1-2d8257d3100mr2564956a91.9.1724759969179;
        Tue, 27 Aug 2024 04:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHUCpxa7e8vAOyba9Zz0k7+axvmhRH/pC1MEvIfdcmABGA2+ctn2KhtQn3O0xDpz6HgOaLAhDsxdqxSL5+cxA=
X-Received: by 2002:a17:90a:17ca:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2d8257d3100mr2564945a91.9.1724759968831; Tue, 27 Aug 2024
 04:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827081757.37646-1-liwang@redhat.com> <b9f2ae40-7c13-4d43-b97e-fe011688a14a@oracle.com>
In-Reply-To: <b9f2ae40-7c13-4d43-b97e-fe011688a14a@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 19:59:16 +0800
Message-ID: <CAEemH2co6g0TCcj7vtG49yq8qhUfjJ83iCRBD6qiwVqGEG9=SA@mail.gmail.com>
Subject: Re: [PATCh v2] loop: Increase bsize variable from unsigned short to
 unsigned int
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, 
	ltp@lists.linux.it, Stefan Hajnoczi <stefanha@redhat.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 4:41=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 27/08/2024 09:17, Li Wang wrote:
> > This change allows the loopback driver to handle block size larger than
> > PAGE_SIZE and increases the consistency of data types used within the d=
river.
> > Especially to match the struct queue_limits.logical_block_size type.
> >
> > Also, this is to get rid of the LTP/ioctl_loop06 test failure:
> >
> >    12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PA=
GE_SIZE
> >    13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
> >    ...
> >    18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > =
PAGE_SIZE
> >    19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
> >
> > Thoese fail due to the loop_reconfigure_limits() cast bsize to 'unsined=
 short'
>
> these
>
> > that never gets an expected error when testing invalid logical block si=
ze,
> > which was just exposed since 6.11-rc1 introduced patches:
> >
> >    commit 9423c653fe61 ("loop: Don't bother validating blocksize")
> >    commit fe3d508ba95b ("block: Validate logical block size in blk_vali=
date_limits()")
>
> Maybe it's better to add a fixes tag for original commit which
> introduced unsigned short usage.

I'm not sure that makes sense because at that moment loop_set_block_size
has a dedicated function blk_validate_block_size to validate bsize, after y=
our
commit 9423c653fe61 optimize that then the problem appears.

  473516b36193 ("loop: use the atomic queue limits update API")


> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thanks for reviewing.


--=20
Regards,
Li Wang


