Return-Path: <linux-kernel+bounces-191837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2BB8D14EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4464DB22328
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDBB6F08E;
	Tue, 28 May 2024 07:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="qaJGv4g0"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B51DFEF
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880169; cv=none; b=GWCrlQBseqVBJYTnwwem1bM4vat+df6FNW5EPPzutU4QKuXLJJ8NIsXxto8OtZ3SNt4GNRYs6Iy39xpj0lifjR4risgGKDx0eiMTrVbJUSdjMDAlACQmRwwePH2Q9EeKYXKsK7E2ltAfbBVbXqkWCJicyqRc08mf45bK7syNiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880169; c=relaxed/simple;
	bh=DYXadX9QCc8lmRomMBMDMpieeZ6MUEEyBFu3Ldgus2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0P6VxgXoWjBDBpKlNKNTGGYTMICuebgMDWNZVUDlqCZC2smSRqQy2m/WZCJGtk1iWIlY6298qxVdfAzmGoQGvn7LK8MFhTUXWoN/7LYqcPinubjNoSq2h6jUeDgzRNwXQjjqEPL7FEj1wlkO3TSalnPjCZ6dWu6AzqFZiEyD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=qaJGv4g0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a088f80f6so28305117b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1716880165; x=1717484965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28c1rMC/X0dW+TO6kpUchR3zmdXaj4zlqVXQbL/tt3M=;
        b=qaJGv4g0NpMevmXL6TvgEFftMEKJkCLtIIzX3AdTP6lNyZ5vTLvL7eO5tcBRpjNDfp
         /luTiWSQMOBHXBY5DTMOAP4Obx4Khpac59cJF7Ys15YFCZmJHc0Z6992zhD7LIguYWl+
         h5ZzXnnvXSZKba5pUL3l86iucj7bleT5lGrrmLJJ+moYVOD/wzmG8HU0dqPSNWwyL5SC
         hasclxHCynBvrwiyEDwFP7wXEq7R21nVnFk6H9eoeQs9fhcKbNtm1m4tXSQP5kaBrqwR
         dAyWojziHZfP8BUl7+lMT4UOe3A8SRPamOajjJ+dWG/ErqKL+2c8FqPNm9R6IqWherOA
         yDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716880165; x=1717484965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28c1rMC/X0dW+TO6kpUchR3zmdXaj4zlqVXQbL/tt3M=;
        b=kfZKCqfueWp3ZVAY3fYgCvYgPaUY/9uYB9E7xff72kZskzLtcdk0PrryADjXXh2hkl
         nCftn09Ub6J6KhSvEjDNtdVxXLw2/2gzL6BW/1QerB6OL+fYwVD9SSunJ6f8KHwAwIWp
         KUunUXfAY8O/MbpWOcPRx4bzrUWTWQm28wfG4412IKXtgFVolJB2DbTP8EvwT7tGkTPb
         3oLudX+j0mT0cY68hREOAtmxxQDOREt9UJviCT6gpa7X+OjqwLUQe2laA0xq5butTJcQ
         GZnrPgzwNgEu7s4WN8TuzJUqVda38qzKsEzzS2AX9PyDjKo59yqD0TmNeq8Xr6D3sT6m
         vHhA==
X-Forwarded-Encrypted: i=1; AJvYcCV8tJ4bqYc9S49MP5EAs2/ejswlSqeMhYd/XhUaKpE2tD86yCzS+m9jKt6n5aDA+t9xIzmfyQYWW6mwpfX7ah9ZaiGl9RcwbsWVCjjE
X-Gm-Message-State: AOJu0Yzcu8s3lkDrPowuU0amjQnyk4F305YqAI8fSzwM9Hasa2B8B9Oy
	MPEN0+UAS+05rgbAH4o4f5yh7ccP4GONfTz9Gtq4ProcfWaMAmAtb3Ifmrz49F0PuE3SY4MqO+n
	gLnI=
X-Google-Smtp-Source: AGHT+IElUa8542f1s0OIBUh4jOnbwb47fWtTE+bG5pXg9354yNtEwpXYqQVUTebzr/luRO31v97lRQ==
X-Received: by 2002:a05:690c:b1c:b0:61b:e13c:e3f4 with SMTP id 00721157ae682-6281ba319bamr100334217b3.15.1716880164834;
        Tue, 28 May 2024 00:09:24 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a4ee22esm19587487b3.78.2024.05.28.00.09.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 00:09:23 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a052f74c1so3813267b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:09:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVjCjT9XlY6SuHWpSqEWG9qonBDFl0qUnx7hgmdpId/qxbp4E3jCldK3R07VT9MRjW4+sI9L8PEN2bv8Ii2FGCvl3JKJB8RetdFFbxS
X-Received: by 2002:a81:4305:0:b0:618:48ab:e597 with SMTP id
 00721157ae682-62a07329a37mr78269317b3.8.1716880163322; Tue, 28 May 2024
 00:09:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAObsKAw174AhGaA13Hyw0ANW=TxJHpK10+OwQGNMVca85Urdg@mail.gmail.com>
 <ZkyPoIXBeBUqFJ48@phenom.ffwll.local> <CAAObsKAJvgg54zBEP-e3PKPLVeX+akZFJudjutjzVVZOJa-41g@mail.gmail.com>
 <e22ffdea-3c18-3a23-e526-25809e98fcd9@quicinc.com> <b19b95ca-c235-4738-a586-bfd1a36183dc@linux.intel.com>
In-Reply-To: <b19b95ca-c235-4738-a586-bfd1a36183dc@linux.intel.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Tue, 28 May 2024 09:09:11 +0200
X-Gmail-Original-Message-ID: <CAAObsKCdU5_O7HgcPQ3SHAuSbCKFPU494GS9dazZ9CfPtvgtcA@mail.gmail.com>
Message-ID: <CAAObsKCdU5_O7HgcPQ3SHAuSbCKFPU494GS9dazZ9CfPtvgtcA@mail.gmail.com>
Subject: Re: DRM Accel BoF at Linux Plumbers
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, open list <linux-kernel@vger.kernel.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@gmail.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Christian Gmeiner <christian.gmeiner@gmail.com>, 
	Oded Gabbay <ogabbay@kernel.org>, Olof Johansson <olof@lixom.net>, 
	Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 8:35=E2=80=AFAM Jacek Lawrynowicz
<jacek.lawrynowicz@linux.intel.com> wrote:
>
> Hi,
>
> On 21.05.2024 17:10, Jeffrey Hugo wrote:
> > On 5/21/2024 8:41 AM, Tomeu Vizoso wrote:
> >> On Tue, May 21, 2024 at 2:12=E2=80=AFPM Daniel Vetter <daniel@ffwll.ch=
> wrote:
> >>>
> >>> On Sat, May 18, 2024 at 10:46:01AM +0200, Tomeu Vizoso wrote:
> >>>> Hi,
> >>>>
> >>>> I would like to use the chance at the next Plumbers to discuss the
> >>>> present challenges related to ML accelerators in mainline.
> >>>>
> >>>> I'm myself more oriented towards edge-oriented deployments, and don'=
t
> >>>> know enough about how these accelerators are being used in the cloud
> >>>> (and maybe desktop?) to tell if there is enough overlap to warrant a
> >>>> common BoF.
> >>>>
> >>>> In any case, these are the topics I would like to discuss, some
> >>>> probably more relevant to the edge than to the cloud or desktop:
> >>>>
> >>>> * What is stopping vendors from mainlining their drivers?
> >>>>
> >>>> * How could we make it easier for them?
> >>>>
> >>>> * Userspace API: how close are we from a common API that we can ask
> >>>> userspace drivers to implement? What can be done to further this goa=
l?
> >>>>
> >>>> * Automated testing: DRM CI can be used, but would be good to have a
> >>>> common test suite to run there. This is probably dependent on a comm=
on
> >>>> userspace API.
> >>>>
> >>>> * Other shared userspace infrastructure (compiler, execution,
> >>>> synchronization, virtualization, ...)
> >>>>
> >>>> * Firmware-mediated IP: what should we do about it, if anything?
> >>>>
> >>>> * Any standing issues in DRM infra (GEM, gpu scheduler, DMABuf, etc)
> >>>> that are hurting accel drivers?
> >>>>
> >>>> What do people think, should we have a drivers/accel-wide BoF at
> >>>> Plumbers? If so, what other topics should we have in the agenda?
> >>>
> >>> Yeah sounds good, and I'll try to at least attend lpc this year since=
 it's
> >>> rather close ... Might be good to explicitly ping teams of merged and
> >>> in-flight drivers we have in accel already.
> >>
> >> Sounds like a good idea to me. Will check if the people that sent the
> >> previous aborted attempts are still interested in this
> >
> > Looks like the Intel VPU folks are missing from this thread.
> Hi!
>
> > I like the idea of a BoF.  I suspect I will be remote but this list of =
topics looks good to me.  Nothing obvious missing from what I can tell.
> I like it too and I will try to attend. I would maybe add to the list GPU=
/accel interoperability.

Thanks, that is a really good one.

Tomeu

