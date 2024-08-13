Return-Path: <linux-kernel+bounces-284820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB2F95057D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 451AB28459F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534FF199EB1;
	Tue, 13 Aug 2024 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxPI8Gxm"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33119923D;
	Tue, 13 Aug 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553257; cv=none; b=TQF7NDybbuK+LhDs2YUt+OBZQQ7y+QeFXC+aOzph7T5+LsVDfoTH2fJTYZgU+ZQmDe5t1YsNdvBe+cO4InzpdcGpP8MFksspQyZTNNx+gHhkhBP8mBRMlROVJuzAmrOFqSuC/nEiCgyUAM9qsvOn2msQbZIxsjPxENsdoRXRB80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553257; c=relaxed/simple;
	bh=GL60/f0x8nLlf4rRbjhMMEOGzUva4JtyUO5LqYKHngA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Agb9PspO7GZb6GazpDsEc4di3Uuv3foz+P/OwAG8sN7y4mbf2W5uTjHsa8gffZkgnziXwg/uPj6rEFbUPvGjtzkqz/+kbJ/76uQhHJ4qSIH8ZmntRa4585KzrX3nlZHIVJx37xXPUglEigbNuzMkTKSgWs6MjfFAP3SSRBanG+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxPI8Gxm; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso3633957f8f.1;
        Tue, 13 Aug 2024 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723553254; x=1724158054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cR/LJ57uXe124SDBRg+5DschuuIRzlJDV50Pw4SHJsc=;
        b=RxPI8GxmOGshCyjucGrEJ1VJiPHReNYo5YTUiKVxNNcwGBM3f24pW2Vo7nzJOApftI
         nAQllgdKzzN9I45IjQyiNLeR3S3Q1faiYt/JNTQZzbbZs2C5drJuCtUYLD6vLo9a1uQl
         hVoZr+8S2gOvcOQl+YjIRl81jCsz3UhlkXwdxgnNGnE9VVWOsONLKuD4z1dkExQd5sw/
         JWZt+ZpCaqT4b7grL6F6AG6mOoo2C+5T5HZupQBNHiUbLuBl0jGBlPmsUYvfXwutqw4E
         m9LdpEJ3w2cg7Lu9jdBkg7SWNoV7ypIvsD4J0zF5MBPpT6jyPhL4OnbGdtVHgEuvJiiP
         oSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723553254; x=1724158054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cR/LJ57uXe124SDBRg+5DschuuIRzlJDV50Pw4SHJsc=;
        b=N8V0Sccl+CB2racyHehMc37eKE4a8DNn8ZwINtfF1l60i7sqaPbHvW/FPg1oys7eQW
         rdYpwlG3R3dk4hq9urE3Y7UTVsY7Hkyz1kScm8HzMtR5tWayw7cOfrMf+EE87dRWE2xy
         SCqm8wEU2Jpdy49nnxdDATkfxWauhJwO2a6a+vZr3rWmjKPozAyKBdqYMqPSuw315pDn
         /ZjASTA7vpuYTYopYCR9Fy4xYgltLxLC+Wdgpc2QNqZ4NABRoiyZVRaeVMDTJqAm6jJI
         pQrCFyGcGB2K0ht4MMDIWSvSOnxjcGplcVQCGZj4VofF9C83glvT0sLO7rdaFa/ArOT8
         n/WA==
X-Forwarded-Encrypted: i=1; AJvYcCXDOwnWTkgDIDTeZ8CLCFNFOSYm9b3AUVMj/5cGv+AzCG7QPdfeRBI/KeknX+/HgpgyXSqzG/3Vll8nmSMJVT7zjprwUUEW4d3hlUEW
X-Gm-Message-State: AOJu0YzKml98uxgXPy7b1yFRsOnE7Q6mo507RLXQD+q4IEluD7HgQ1oU
	sQW5jOUV+RC8hbVWLh79miKm2ythtPUB50hYcI22rwfscqSp0/QMV6jvWQQrumiidSaUqF2nxcr
	uCpoJYau1UIRWl1lN6JZIeCezgYE=
X-Google-Smtp-Source: AGHT+IFNbc7860j78hScCdMHJgd97CHbmn5gFg3mms/D4ru1Fw1gV72PWQglosq3cxQIkm2FW3carFdWjl2YVC/gtHg=
X-Received: by 2002:adf:e7cf:0:b0:368:3f5b:2ae4 with SMTP id
 ffacd0b85a97d-3716cd01f67mr2117986f8f.36.1723553253599; Tue, 13 Aug 2024
 05:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810141834.640887-2-crwulff@gmail.com> <2024081345-emerald-subarctic-cb5f@gregkh>
In-Reply-To: <2024081345-emerald-subarctic-cb5f@gregkh>
From: Chris Wulff <crwulff@gmail.com>
Date: Tue, 13 Aug 2024 08:47:21 -0400
Message-ID: <CAB0kiBLTmybSJH-KDMaYc=DQBatQBf=UeZkE1PGGGuEEgTkObg@mail.gmail.com>
Subject: Re: [PATCH v3] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, Konstantin Aladyshev <aladyshev22@gmail.com>, 
	David Sands <david.sands@biamp.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-kernel@vger.kernel.org, 
	Chris Wulff <Chris.Wulff@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 4:38=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 10, 2024 at 10:18:35AM -0400, crwulff@gmail.com wrote:
> > From: Chris Wulff <Chris.Wulff@biamp.com>
> >
> > While supporting GET_REPORT is a mandatory request per the HID
> > specification the current implementation of the GET_REPORT request resp=
onds
> > to the USB Host with an empty reply of the request length. However, som=
e
> > USB Hosts will request the contents of feature reports via the GET_REPO=
RT
> > request. In addition, some proprietary HID 'protocols' will expect
> > different data, for the same report ID, to be to become available in th=
e
> > feature report by sending a preceding SET_REPORT to the USB Device that
> > defines what data is to be presented when that feature report is
> > subsequently retrieved via GET_REPORT (with a very fast < 5ms turn arou=
nd
> > between the SET_REPORT and the GET_REPORT).
> >
> > There are two other patch sets already submitted for adding GET_REPORT
> > support. The first [1] allows for pre-priming a list of reports via IOC=
TLs
> > which then allows the USB Host to perform the request, with no further
> > userspace interaction possible during the GET_REPORT request. And anoth=
er
> > [2] which allows for a single report to be setup by userspace via IOCTL=
,
> > which will be fetched and returned by the kernel for subsequent GET_REP=
ORT
> > requests by the USB Host, also with no further userspace interaction
> > possible.
> >
> > This patch, while loosely based on both the patch sets, differs by allo=
wing
> > the option for userspace to respond to each GET_REPORT request by setti=
ng
> > up a poll to notify userspace that a new GET_REPORT request has arrived=
. To
> > support this, two extra IOCTLs are supplied. The first of which is used=
 to
> > retrieve the report ID of the GET_REPORT request (in the case of having
> > non-zero report IDs in the HID descriptor). The second IOCTL allows for
> > storing report responses in a list for responding to requests.
> >
> > The report responses are stored in a list (it will be either added if i=
t
> > does not exist or updated if it exists already). A flag (userspace_req)=
 can
> > be set to whether subsequent requests notify userspace or not.
> >
> > Basic operation when a GET_REPORT request arrives from USB Host:
> >
> > - If the report ID exists in the list and it is set for immediate retur=
n
> >   (i.e. userspace_req =3D=3D false) then response is sent immediately,
> > userspace is not notified
> >
> > - The report ID does not exist, or exists but is set to notify userspac=
e
> >   (i.e. userspace_req =3D=3D true) then notify userspace via poll:
> >
> >       - If userspace responds, and either adds or update the response i=
n
> >         the list and respond to the host with the contents
> >
> >       - If userspace does not respond within the fixed timeout (2500ms)
> >         but the report has been set prevously, then send 'old' report
> >         contents
> >
> >       - If userspace does not respond within the fixed timeout (2500ms)
> >         and the report does not exist in the list then send an empty
> >         report
> >
> > Note that userspace could 'prime' the report list at any other time.
> >
> > While this patch allows for flexibility in how the system responds to
> > requests, and therefore the HID 'protocols' that could be supported, a
> > drawback is the time it takes to service the requests and therefore the
> > maximum throughput that would be achievable. The USB HID Specification
> > v1.11 itself states that GET_REPORT is not intended for periodic data
> > polling, so this limitation is not severe.
> >
> > Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loading
> > showed that userspace can typically respond to the GET_REPORT request
> > within 1200ms - which is well within the 5000ms most operating systems =
seem
> > to allow, and within the 2500ms set by this patch.
> >
> > [1] https://lore.kernel.org/all/20220805070507.123151-2-sunil@amarulaso=
lutions.com/
> > [2] https://lore.kernel.org/all/20220726005824.2817646-1-vi@endrift.com=
/
> >
> > Signed-off-by: David Sands <david.sands@biamp.com>
> > Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
> > ---
> > v3: rebased to usb-next, checkpatch cleanup (formatting, lore.kernel.or=
g links)
> > v2: https://lore.kernel.org/all/CO1PR17MB541952864266039BAA7BBBD3E10F2@=
CO1PR17MB5419.namprd17.prod.outlook.com/
> > v1: https://lore.kernel.org/all/20230215231529.2513236-1-david.sands@bi=
amp.com/
> > ---
> >  drivers/usb/gadget/function/f_hid.c | 272 +++++++++++++++++++++++++++-
> >  include/uapi/linux/usb/g_hid.h      |  40 ++++
> >  include/uapi/linux/usb/gadgetfs.h   |   2 +-
> >  3 files changed, 306 insertions(+), 8 deletions(-)
> >  create mode 100644 include/uapi/linux/usb/g_hid.h
>
> Breaks the build:
>
> drivers/usb/gadget/function/f_hid.c:567:6: error: no previous prototype f=
or =E2=80=98get_report_workqueue_handler=E2=80=99 [-Werror=3Dmissing-protot=
ypes]
>   567 | void get_report_workqueue_handler(struct work_struct *work)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>

I must not have warnings-as-errors enabled. I didn't notice the warning
when I last built it. I will clean that up and make a new patch.

  -- Chris Wulff

