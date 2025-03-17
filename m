Return-Path: <linux-kernel+bounces-564220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7224A6507E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D0C3B3446
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAFA23C8B2;
	Mon, 17 Mar 2025 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6HznVes"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0E23C8CC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742217511; cv=none; b=IcKs1Q9TJ/zT6btHNZt3ZBkflCb00gryxXsa0vRS5732mEbuABcDdvMl+sNB/W0muey7elALsn8vus/PF86p3NcEfpqmZKoWwUzLBmar0/6C+O4uAVqnHLIobKYq7tkbNMNVDQrkLyj7hKl4TDx1q7GPMzjGALLeR/I4y3BSFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742217511; c=relaxed/simple;
	bh=7zBxgDLmRyuN2tksX21djAzeULq4KTsOuHQh0PC/iw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZFy+C0dOMqpjpTwx7N57syirhTlEJG8KQGP2WYutGFAupcG69tWPyXmOWq7J/Opxb9POJUKWvVAlfkV3tNlxrwJIZg7Ryk+8oP0nvpbOseXsHHnvKbwKV/eRljXOg5HAqrDPXpXwPDTR08nntiqRBeByYB99f8vprWavWIrFxpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f6HznVes; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742217508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Afpft8skurz0RxHFxyQgeYTVmB1+2p35x8L96D8+/xU=;
	b=f6HznVesU8oChwNI/X/wfL4CZiBGXpAFDmxq3KkGyd49waUBLQQa8SRcfjxbAh4hJEYOSI
	vYPG80kque6Dj5psTmOx0JF5m/BGwXYFDUZSGfJWwZbDGZbkNK8CQm/Q4UXdU4CQHEM1YZ
	LOSEQdWSaHMDJ7QAhdYS4EZ7Dz3hHR4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-aBoMtzy4MCGGmoe3go1T4g-1; Mon, 17 Mar 2025 09:18:27 -0400
X-MC-Unique: aBoMtzy4MCGGmoe3go1T4g-1
X-Mimecast-MFC-AGG-ID: aBoMtzy4MCGGmoe3go1T4g_1742217506
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-30c4fd96a7bso14999671fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742217504; x=1742822304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Afpft8skurz0RxHFxyQgeYTVmB1+2p35x8L96D8+/xU=;
        b=nh1m4q16lE9Cp2WvxeTlOEY0LME4O50KibLSZN7Dc1rjE5LmdMt2wvO5Vxs3kyk5bL
         m85/qHcyOjD42hhVdBb/Dvd2pc5tfdwhb5I5o5SpaaG1PPwAE8XJ841VGJW1HEnyDFpw
         SPOalBnsX20HFzyCIpPe+PUVYz4Tjlqa0LBDv8aMlHW6iAjEeJ7fGu+SierxtYqQXcyN
         9eubeLvMHnHPhzEoKvzJjicsf4yBOZ6W6qJugUUjDRZM7Wk4Ax5lKWrS5+djzASJ/hiS
         dvsg23LWoVOTe95HxouiVe2tNGBj/fr8AKtJ1V7r+8fMZCqIPmGFiqdgK9IGfcAM1hPv
         K4DA==
X-Forwarded-Encrypted: i=1; AJvYcCXGXKBMU2mQShy5IQq+RFyZWmhY+/KlXfReV3sWtAO+JliNegsKFKSDfaNUwCVIiPy9GcmYq52PLYk8WA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5fGHb9TK4hwbQ3emjRtRhePt2wPVXVvH2tWEnnhd/g3aYYhh
	t+Fa2RAaytdviLDMK+i/cJefQuqiT090MexgUvSd0Uiz79Sf3icKi+YtEpekvweKVUZ5jIgxqiv
	Bld1+LF4JGiuIgg0cAS45Q78h7p0M6KJ5MKzZR9gsTDA+R4E/9KXQx/CZwIHsG1dXuH/6AxN5mr
	BDG1pOcnZokOcE4bmzwaKvYYVY1L6qTmSkPMTR
X-Gm-Gg: ASbGnctibdO5AN7tz0djkwx1BIWXSkhA67JJsY7r0NsvGWysMRdsvWRbCRWQofLXG9T
	/RJe80JAoFZ2Bc1mF/iXKb+PEf6zLUEz8/Ce5slqasDQ0pjvwYSRjGCzW84Kn7ZMgumL05nLAN3
	eVkQmqvFqNub3YgjWzabIsSvfTmuTaKA==
X-Received: by 2002:a2e:b8d0:0:b0:30b:d44d:e76a with SMTP id 38308e7fff4ca-30c4a8d8ae1mr95299471fa.25.1742217504129;
        Mon, 17 Mar 2025 06:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5e3W53gMkfkeykIwmpLkSrz2341q7IBqghmSfK0LJIM3WFxW09ADMZX3ChTL5saR5IwHCEUz3Wxz+z2zVvVw=
X-Received: by 2002:a2e:b8d0:0:b0:30b:d44d:e76a with SMTP id
 38308e7fff4ca-30c4a8d8ae1mr95299091fa.25.1742217503740; Mon, 17 Mar 2025
 06:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314175309.2263997-1-herton@redhat.com> <20250314175309.2263997-2-herton@redhat.com>
 <CAHk-=wj2MhDH_zjnyrUhYUf3ZqokC-jKSeRp9G6GnhwFU9z+Hg@mail.gmail.com>
 <CAJmZWFFVL++yU1XJLkXSck=GRQXiim16xVSvdxjq1k=c=Aaiqg@mail.gmail.com>
 <Z9au20vtMSXCbdXu@gmail.com> <Z9axe9Ac5biyJjCC@gmail.com>
In-Reply-To: <Z9axe9Ac5biyJjCC@gmail.com>
From: Herton Krzesinski <hkrzesin@redhat.com>
Date: Mon, 17 Mar 2025 10:18:12 -0300
X-Gm-Features: AQ5f1JqGlFxNO34vfr-7gqAckDSJ0wHh9UfeBTke3vzdzF4l0bXrVSF13M7Crwo
Message-ID: <CAJmZWFHV+HM5V7mVpE5XEyrgM7jaJ8msZssOb2JdmqSrKKyMhg@mail.gmail.com>
Subject: Re: [PATCH] x86: add back the alignment of the destination to 8 bytes
 in copy_user_generic()
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-kernel@vger.kernel.org, olichtne@redhat.com, atomasov@redhat.com, 
	aokuliar@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 8:10=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > > It does look good in my testing here, I built same kernel I was
> > > using for testing the original patch (based on 6.14-rc6), this is
> > > one of the results I got in one of the runs testing on the same
> > > machine:
> > >
> > >              CPU      RATE          SYS          TIME     sender-rece=
iver
> > > Server bind   19: 20.8Gbits/sec 14.832313000 20.863476111 75.4%-89.2%
> > > Server bind   21: 18.0Gbits/sec 18.705221000 23.996913032 80.8%-89.7%
> > > Server bind   23: 20.1Gbits/sec 15.331761000 21.536657212 75.0%-89.7%
> > > Server bind none: 24.1Gbits/sec 14.164226000 18.043132731 82.3%-87.1%
> > >
> > > There are still some variations between runs, which is expected as
> > > was the same when I tested my patch or in the not aligned case, but
> > > it's consistently better/higher than the no align case. Looks
> > > really it's sufficient to align for the higher than or equal 64
> > > bytes copy case.
> >
> > Mind sending a v2 patch with a changelog and these benchmark numbers
> > added in, and perhaps a Co-developed-by tag with Linus or so?
>
> BTW., if you have a test system available, it would be nice to test a
> server CPU in the Intel spectrum as well. (For completeness mostly, I'd
> not expect there to be as much alignment sensitivity.)
>
> The CPU you tested, AMD Epyc 7742 was launched ~6 years ago so it's
> still within the window of microarchitectures we care about. An Intel
> test would be nice from a similar timeframe as well. Older is probably
> better in this case, but not too old. :-)
>
> ( Note that the Intel test is not required to apply the fix IMO - we
>   did change alignment patterns ~2 years ago in a5624566431d which
>   regressed. )

Yes I'll work here to send a v2 and try to test on an Intel system, and com=
pare.

>
> Thanks,
>
>         Ingo
>


