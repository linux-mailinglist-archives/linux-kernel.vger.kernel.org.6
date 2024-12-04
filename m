Return-Path: <linux-kernel+bounces-431205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE339E3AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D59B3446C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821541BBBC8;
	Wed,  4 Dec 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifwdZEm2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBFB1B87DB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316704; cv=none; b=ONO/D2CLMeyw04BautHHFZB+IMIzBhaZFR6X7YZq853cK89iOK2LwGDuxcGVnL8c1+R6RzSrHbYrqdiw38nJPA34qTSMEwV2TP8alBuhMVa+IqfXJnZckMaR3VMXPZw+7wQRaMn3JAXlVgYuMYvGBAz7fGB90dSk8ott7esXaGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316704; c=relaxed/simple;
	bh=I9NCyPO4krisSUhdqeg72XRIllo/A9wyK93lujKfyPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fi4mkSZmLFFWdjsg2iPYDmkAdGE5C+U/a57B3UB1cbPIWenxwf98wFISXiKKLl7Z8sDoU+yNag3vfg9XPrn8HsSPyb2nwuN9l/OGS0XlXNchhWhhUaGgqBMzRsZdXXWFA5JTy9RpNFJOa+9Q+IVn21G25P0csjcbJNssYxmJk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifwdZEm2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733316702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I9NCyPO4krisSUhdqeg72XRIllo/A9wyK93lujKfyPU=;
	b=ifwdZEm2FT9/7g9eg/6l9ZQkgSwAkuDcVfzUddnX4je9gGTW3PH3SQO193/xlD1XdwOCC/
	G80y07Usg0XwNndffR/E97HpEmmvI0FLJLBDt59B5sS7VY88IkpXdzLp5wWDHGKfM2QeNV
	5sIyyslBh0HD1uaBhxyWgQnYgMYSFj0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-V5aWl3R9P0-awctM80IQUg-1; Wed, 04 Dec 2024 07:51:39 -0500
X-MC-Unique: V5aWl3R9P0-awctM80IQUg-1
X-Mimecast-MFC-AGG-ID: V5aWl3R9P0-awctM80IQUg
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5d0cd8a0ec5so3119939a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 04:51:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733316698; x=1733921498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I9NCyPO4krisSUhdqeg72XRIllo/A9wyK93lujKfyPU=;
        b=h82vcfpRbJDFUaJH0CckZfQrGL3aT7a9kOnW0VFI6npEJi9aCEhHuNkMkMVX1/QRSr
         A8rmx11/MCQHXF8HYAtYuamDfEm47WiBl5yNfxdbdAIyBeUVtkOemb8GL0gllhUOO6Vy
         YlBK3tw4S0hDtt69WntvlbCkVOIcEqe7UhDu+jo4A44jUsnql9B5MLNgZ+mPBceqtj1P
         y4bCopY1tMluflid3vJomJ3CMS/Dtzl29xvI9ZRULn+G1kXg3Njl+bh6kTlzzDwaB2Wy
         ND+PK26/boB7Y9c3w/IfL8X9B6OVd7cKWIc5ClN5DXfQScpSnxbA3wBDrgDLfhNfOIEH
         hqLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaD0yq8EXFsObAdmrcZZOtF6qIhz8UxYbEUhHWdCF9obWH5iK4aC7B2+RqjnAwKC6cmyNzIFDmPoXRIYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCPPXVDo8tRw2YQKyb++j0q2n40gmr8xMa0nOofmgFUZgS4UcX
	4LBUuvGmQoOb0baaZyP9R7oG3RaoRV/oi4z6n4x+fEbhKh5iiYj4zng3agxFOyRMlszRymQnbaN
	i5Vz5AWepJ/c17c7Y+XdLGiZ06kmLDJgkwEkqSAnlPFUgFyT2oANcegIIyOdU4hFom+eiC5FoIk
	mNRDlHUMRZLSLwlbxGin5cMG7Fcl36zGyKpogI
X-Gm-Gg: ASbGncuosfwi7eH0az/B1mYvwhs35238r1FVAyE6dZddEiYyImgUkEW2mUuIv+/mlF+
	mmOGpTMWu4AAXX/twmfZMQ3n4pUfu
X-Received: by 2002:a05:6402:2553:b0:5d0:e826:f0f5 with SMTP id 4fb4d7f45d1cf-5d10cb4d7f8mr6517528a12.7.1733316697971;
        Wed, 04 Dec 2024 04:51:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE20wvu66FctTl9GL0qP1II/9zpj8SnN8HlRgU9qZLjUzSG6Cef4lVTKQt72r7wwVeJdCksU1lfkJH214DU+Z0=
X-Received: by 2002:a05:6402:2553:b0:5d0:e826:f0f5 with SMTP id
 4fb4d7f45d1cf-5d10cb4d7f8mr6517499a12.7.1733316697667; Wed, 04 Dec 2024
 04:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
 <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com> <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
In-Reply-To: <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 4 Dec 2024 14:51:26 +0200
Message-ID: <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's already in a testing branch; what branch are you working on?

On Tue, Dec 3, 2024 at 2:21=E2=80=AFPM Max Kellermann <max.kellermann@ionos=
.com> wrote:
>
> On Mon, Nov 25, 2024 at 3:33=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > You and Illia agree on this point. I'll wait for replies and take your
> > original patch into the testing branch unless any concerns are raised.
>
> How long will you wait? It's been more than two weeks since I reported
> this DoS vulnerability.
>


