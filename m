Return-Path: <linux-kernel+bounces-273891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD7946F47
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 16:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7EA1C20F66
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413A754918;
	Sun,  4 Aug 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH3ECUrf"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A003BA953;
	Sun,  4 Aug 2024 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722781158; cv=none; b=eVKv6EPF+DPMV1sFRF77fbbw6dLTYtqaovT1z3GRl93btB6cMreNWeiCvSNTNEEY8umNxzkfujpy6Zw5l/Xy4X+ZMD0HhqrIuAvlMCsxdgEFRm3+iYvbPfugtstaNhu+nWsXWr4Vpr+iN20jADEkmNlkoYwVDU2s7mt6hMDQn5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722781158; c=relaxed/simple;
	bh=2ROMgNTHAEBR/PoZgasnwX/E0LjymYg8Sj+ON0CbQUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ePClWsf0FamB9yKiI/lT1r/RNmmmdAhQFBD9m+rC4rKPLQLss9Oa9r1w10/6neVYvyUCsIOr5lpLJLsqRb0N9kmJBHTGUYLLvS8d9kLYdDBwGBwcy8tkAfNvFa9otOOs5m0HKQOPE2nE2BIsDN8oofP0mwngrkJcQcqQHAYJLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH3ECUrf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3683178b226so4871301f8f.1;
        Sun, 04 Aug 2024 07:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722781155; x=1723385955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zGobfmVNy454cB3mFujYC3fx1cCGu8LWmP1DqlfXK0=;
        b=WH3ECUrfEWYpiX7xMNeJ28j6JwGyPjOoWDs5VuH4uIBEgXgPLKNY4mzLjtDXeiVab1
         exk+EBa+k7CHyelhUHqSNbUROBi1WU3lcaQ+dKyrV3N6mTMKN4sbCPa9ir8GSwrJwLJJ
         2QD4kwtGX1j+nc8fEPgtZcZ1rVVZW70vfo8h/x0EViNlFPbBT22niWZ+ikmit7g+ADWz
         f8ryViD7QUNfh00zUq79wJnmnj5MCD8LJtCFdD45p5UqT6tIfFN47/2to+3+ofl1LcLF
         O/HgN371twL4w0SHjinTg2SsnmIhvf4CgCb4EQgWiD2Vd7FenPnj/j0t+sHoldsldung
         cCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722781155; x=1723385955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zGobfmVNy454cB3mFujYC3fx1cCGu8LWmP1DqlfXK0=;
        b=OGGHpG/2OR//5R9qRqIJLyC4Ca2Z9jAKr6CQes+tPzgysYZJAoXFxmyqagTFwiX+pV
         Mrk9Y78EQaHIow6baqxh4u9KE1LS5sb8abekxUTCRFsm6Rqq03Ucv4W9AUAQTM9U2Ow5
         dEgW4LkKT2FHNgwx3wYjBBH63o/lNFFExfxOYAPzsxhAoBdBE3bDCNTdQGQoFinfiemQ
         WAHMfeKGK2gOSOJhK5uXmJwEQTFAUIBO6l59TA23D8Vjq3dQ++2PZ/b/OIx/xFjHGOG4
         qE5+vow7drGU8sHpSfKmIXLFNKJapagwTaDjOMVO2PY0nPUxSaW7yfQY+8qhrJSgsIhN
         nsiw==
X-Forwarded-Encrypted: i=1; AJvYcCVmr6HT90OYTZipDjXkLax+ycyIgMUMBYKgjk1R78oMRnZEs5qG99fZIf/9gbgDsEE+YPJK7Bi14e/SJuJmCkJNnGIJJ4owaCAMXCPf5C5hX1+QRD2G1maV0PFmJKIEGYoF4D8hdYHN
X-Gm-Message-State: AOJu0YwcW06EyWTqDOI8hhHRTRBo0vmD57jBrenQwUd+JdYYGbhIxqcb
	wXIGqdpUu1PzST9AtGecTta/+S5S+22Ou2Urol/EWSvyWCZwMl7TPNaFtGuyKjJj4ZYBUy2t/Us
	/2JBkrDtVY5nJ6L5jUECdRKwxvpT/Eg==
X-Google-Smtp-Source: AGHT+IGwin44sPCMyDPkMwAoXS1sgVTMKhRZEtDM1InTeRC382jpD5DN2XRZ2qI/K90eYkzo7lilkfX3QGzU11k6Fl4=
X-Received: by 2002:a5d:59ab:0:b0:368:5ba0:622 with SMTP id
 ffacd0b85a97d-36bbc160f09mr6363861f8f.44.1722781154546; Sun, 04 Aug 2024
 07:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CO1PR17MB541952864266039BAA7BBBD3E10F2@CO1PR17MB5419.namprd17.prod.outlook.com>
 <2024073114-singular-stream-1dd9@gregkh> <CAB0kiB+tzV2JPc2X_WKr5yMJ5sy7QO2o0mcqUdD8CMd68EGmhw@mail.gmail.com>
In-Reply-To: <CAB0kiB+tzV2JPc2X_WKr5yMJ5sy7QO2o0mcqUdD8CMd68EGmhw@mail.gmail.com>
From: Chris Wulff <crwulff@gmail.com>
Date: Sun, 4 Aug 2024 10:19:03 -0400
Message-ID: <CAB0kiBKpzQjcH02ckCFH0Uxv4QGVLEwVUE_ZtE8L9zd7H0Ow-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL
To: Greg KH <greg@kroah.com>
Cc: Chris Wulff <Chris.Wulff@biamp.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Sands <David.Sands@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greg,

  It looks like this still applies clean with no changes to the diff
  on the latest usb-next. Do you still want me to re-post it?

  -- Chris Wulff

On Wed, Jul 31, 2024 at 8:15=E2=80=AFPM Chris Wulff <crwulff@gmail.com> wro=
te:
>
> On Wed, Jul 31, 2024 at 4:30=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
> >
> > On Wed, Apr 17, 2024 at 06:29:27PM +0000, Chris Wulff wrote:
> > > While supporting GET_REPORT is a mandatory request per the HID
> > > specification the current implementation of the GET_REPORT request re=
sponds
> > > to the USB Host with an empty reply of the request length. However, s=
ome
> > > USB Hosts will request the contents of feature reports via the GET_RE=
PORT
> > > request. In addition, some proprietary HID 'protocols' will expect
> > > different data, for the same report ID, to be to become available in =
the
> > > feature report by sending a preceding SET_REPORT to the USB Device th=
at
> > > defines what data is to be presented when that feature report is
> > > subsequently retrieved via GET_REPORT (with a very fast < 5ms turn ar=
ound
> > > between the SET_REPORT and the GET_REPORT).
> > >
> > > There are two other patch sets already submitted for adding GET_REPOR=
T
> > > support. The first [1] allows for pre-priming a list of reports via I=
OCTLs
> > > which then allows the USB Host to perform the request, with no furthe=
r
> > > userspace interaction possible during the GET_REPORT request. And ano=
ther
> > > [2] which allows for a single report to be setup by userspace via IOC=
TL,
> > > which will be fetched and returned by the kernel for subsequent GET_R=
EPORT
> > > requests by the USB Host, also with no further userspace interaction
> > > possible.
> > >
> > > This patch, while loosely based on both the patch sets, differs by al=
lowing
> > > the option for userspace to respond to each GET_REPORT request by set=
ting
> > > up a poll to notify userspace that a new GET_REPORT request has arriv=
ed. To
> > > support this, two extra IOCTLs are supplied. The first of which is us=
ed to
> > > retrieve the report ID of the GET_REPORT request (in the case of havi=
ng
> > > non-zero report IDs in the HID descriptor). The second IOCTL allows f=
or
> > > storing report responses in a list for responding to requests.
> > >
> > > The report responses are stored in a list (it will be either added if=
 it
> > > does not exist or updated if it exists already). A flag (userspace_re=
q) can
> > > be set to whether subsequent requests notify userspace or not.
> > >
> > > Basic operation when a GET_REPORT request arrives from USB Host:
> > >
> > > - If the report ID exists in the list and it is set for immediate ret=
urn
> > >   (i.e. userspace_req =3D=3D false) then response is sent immediately=
,
> > > userspace is not notified
> > >
> > > - The report ID does not exist, or exists but is set to notify usersp=
ace
> > >   (i.e. userspace_req =3D=3D true) then notify userspace via poll:
> > >
> > >       - If userspace responds, and either adds or update the response=
 in
> > >         the list and respond to the host with the contents
> > >
> > >       - If userspace does not respond within the fixed timeout (2500m=
s)
> > >         but the report has been set prevously, then send 'old' report
> > >         contents
> > >
> > >       - If userspace does not respond within the fixed timeout (2500m=
s)
> > >         and the report does not exist in the list then send an empty
> > >         report
> > >
> > > Note that userspace could 'prime' the report list at any other time.
> > >
> > > While this patch allows for flexibility in how the system responds to
> > > requests, and therefore the HID 'protocols' that could be supported, =
a
> > > drawback is the time it takes to service the requests and therefore t=
he
> > > maximum throughput that would be achievable. The USB HID Specificatio=
n
> > > v1.11 itself states that GET_REPORT is not intended for periodic data
> > > polling, so this limitation is not severe.
> > >
> > > Testing on an iMX8M Nano Ultra Lite with a heavy multi-core CPU loadi=
ng
> > > showed that userspace can typically respond to the GET_REPORT request
> > > within 1200ms - which is well within the 5000ms most operating system=
s seem
> > > to allow, and within the 2500ms set by this patch.
> > >
> > > [1] https://marc.info/?t=3D165968296600006 [2]
> > > https://marc.info/?t=3D165879768900004
> > >
> > > Signed-off-by: David Sands <david.sands@biamp.com>
> > > Signed-off-by: Chris Wulff <chris.wulff@biamp.com>
> > > ---
> > >  drivers/usb/gadget/function/f_hid.c | 270 ++++++++++++++++++++++++++=
+-
> > >  include/uapi/linux/usb/g_hid.h      |  40 +++++
> > >  include/uapi/linux/usb/gadgetfs.h   |   2 +-
> > >  3 files changed, 304 insertions(+), 8 deletions(-)
> > >  create mode 100644 include/uapi/linux/usb/g_hid.h
> >
> > Can you rebase this and resubmit against the latest kernel tree?  It's
> > been a while since this was last submitted, sorry for the delay in
> > reviewing it.
>
> Yeah, I'll rebase it and make sure it still works and then send out an up=
date.
>
> No worries about the review delay. Seeing the quantity of traffic on
> the usb list
> I'm sure you keep pretty busy.
>
> >
> > greg k-h
> >

