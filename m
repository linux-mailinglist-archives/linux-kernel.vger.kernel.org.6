Return-Path: <linux-kernel+bounces-187006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE08CCBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3AD1F219B7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 05:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE213B299;
	Thu, 23 May 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhIYXWw4"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A80413A3F2;
	Thu, 23 May 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716442394; cv=none; b=mRZTFIJrcmvThF6+pVql6qU+TsU8dS22cyGrlRJMrB8mFcHMj0Pg0+W3F5olz7sejujnDY/WCMGnAzzeNyLDJVwNayuGejJ0G/Ka+vyhX0oY5kQXJEZkg1iEIb2D5GhTRZJaLkaFIyEl8b6niBKZ6yiADeFSfwBU1q7AU+XDvCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716442394; c=relaxed/simple;
	bh=IiYlAd4WaNM02+scnmtTm0a5Xz1nW553J/VFMZi0a2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpCl/NCSu99+2XJp/rj61wMyornOYOy85cwtyvZRSE96ByOLxBx3SRik7E7Qx33PB2XA5XyyorWh4boccO35yu6BCsZgKtQG8PtfmGDoPc2DYGjU8FG7kl80apQHr/eV+7NKd1Hw4XhlaXP9oos3zZhQpabPvVEkurqgEpc6QTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhIYXWw4; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bd9255bc2cso347460a91.3;
        Wed, 22 May 2024 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716442393; x=1717047193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lK6G6w9tGySDIb4n4fBZsvQfFvWjx+nls5lKdheoGIc=;
        b=HhIYXWw4eoUyMkRC2kiUArBicc0ECXJ83hsQ8C+BvRwbINAWg7QiQ6CjyvnlL/FFxR
         VRTv8+RhVylRr8Xc2gtpcKvXxrlOeO+1igOADVxNkqxJb8d6S1/5m/BBO4LZ8QSoybXN
         Oh5XCby76WEL8GWnV2jy6XofW0WcAkNrSVU8wDmGv+F4ZN90iPI0/r6aa9O25wjmQuuO
         uxPkz3rNAPV2lF0lQvLt2v32T6ZR6z5dZsYN42tzb15XstPJRMyGqq/e75uv+NRZsA+t
         DQLAbERVDFBNe65EiQRwx64M/Zd1bIp7IrL5HCZbk0CHzfaevMA5IJ3kCTP9jbNYw4La
         TKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716442393; x=1717047193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK6G6w9tGySDIb4n4fBZsvQfFvWjx+nls5lKdheoGIc=;
        b=VTnY0LIpOT4C83LQZFnWxy9Wszmff4L2z72y+81Ljn6nfQpdDbTOL8zu0bXwOtA53X
         BWwO8FDlaTTThDxpCkab78h+CcMLnWA1igdD7JlmPP7yQWwzu7r2PV0sYpc6f1w662dh
         OzcynP4vPw1hOY16jy3Qc0dYx+z9+dwv3SEx3c94Wm+OQtg9DQdjatxPAf9F8E8ive83
         x86A/mdsu/x5Aj44xfi56ZdnC+U+cLGUXMyZ32ek738AeZ5oBYfbGtAxk6v422/FdpGk
         PCxXspkQgTydwBzovVqljqw2LgfP0txTfFlflilJrs37e8hsxIPWogi9oLi3QNWtwgFJ
         Uu0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWh2VsyIoK+ZVtz8mAap4XvDgyJsHlsnCxxy6tcpurmMjNoXP4RqksI9cG5Zs6ot0DiiZb5061MfjOR+UfznX8tyFekhgVx6l6jYAnB3lPzMkY4iMhOrn9/XBtjrKuTNnpHUAoFbyWJ
X-Gm-Message-State: AOJu0YyIbGH5g7YD1S6XtRM9EnVYl92ikv/fAYtQbl+mg5R3wjcHbqCg
	XzOZHzkioaDnUbM9cbqP/kZtDHL/AhDjgVp4yGczo078ibVrfbq3ciAi0AdM5HIr8G0ZAgYiB9d
	/nikr+8sX9m2oaiCr61GhSImDFk4=
X-Google-Smtp-Source: AGHT+IFsQ1uY90KhB+RKZu3ri7pwe2IhQbEKkQidqKi13tCvcc62pOSd2liAMgX5LRT4U4HFl7le93LjABhdE7PTEno=
X-Received: by 2002:a17:90a:f301:b0:2af:d64:4887 with SMTP id
 98e67ed59e1d1-2bd9f5d610emr4066034a91.4.1716442392624; Wed, 22 May 2024
 22:33:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522023918.7613-1-ki.chiang65@gmail.com> <20240522023918.7613-2-ki.chiang65@gmail.com>
 <2024052204-freehand-say-198c@gregkh>
In-Reply-To: <2024052204-freehand-say-198c@gregkh>
From: =?UTF-8?B?6JSj5YWJ55uK?= <ki.chiang65@gmail.com>
Date: Thu, 23 May 2024 13:33:00 +0800
Message-ID: <CAHN5xi30GpA8Kco4+EFpvOU2wdgW8dpeBjE=Bs1ffbFVbjo-EA@mail.gmail.com>
Subject: Re: [PATCH 1/2] xhci: Apply reset resume quirk to Etron EJ188 xHCI host
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> =E6=96=BC 2024=E5=B9=B45=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:36=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, May 22, 2024 at 10:39:18AM +0800, Kuangyi Chiang wrote:
> > As described in commit c877b3b2ad5c ("xhci: Add reset on resume quirk f=
or
> > asrock p67 host"), EJ188 have the same issue as EJ168, where completely
> > dies on resume. So apply XHCI_RESET_ON_RESUME quirk to EJ188 as well.
> >
> > Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
> > ---
> >  drivers/usb/host/xhci-pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index ef513c2..a0beb41 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -31,6 +31,7 @@
> >
> >  #define PCI_VENDOR_ID_ETRON          0x1b6f
> >  #define PCI_DEVICE_ID_EJ168          0x7023
> > +#define PCI_DEVICE_ID_EJ188          0x7052
> >
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_XHCI   0x8c31
> >  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI        0x9c31
> > @@ -238,6 +239,10 @@ static void xhci_pci_quirks(struct device *dev, st=
ruct xhci_hcd *xhci)
> >               xhci->quirks |=3D XHCI_TRUST_TX_LENGTH;
> >               xhci->quirks |=3D XHCI_BROKEN_STREAMS;
> >       }
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_ETRON &&
> > +                     pdev->device =3D=3D PCI_DEVICE_ID_EJ188) {
> > +             xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> > +     }
>
> Same question as on other patch, should this be backported to older
> kernels too?
>
> thanks,
>
> greg k-h

Sorry, I'm new to this.
These patches have been tested in the stable 4.19 kernel, so they
should be backported to stable kernels as old as 4.19, right?

Thanks,
Kuangyi Chiang

