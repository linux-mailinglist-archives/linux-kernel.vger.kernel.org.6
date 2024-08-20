Return-Path: <linux-kernel+bounces-293235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D5957C54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31CEC1C23C84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094B450285;
	Tue, 20 Aug 2024 04:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fq8opP0K"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2872F5E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127382; cv=none; b=S2ht0P+9/+wJ6DRjqz5EW8orqjHLvPDPWBxvrp2Sfdj+vN3PfedglM6byiqMG5sMYazk7w8B24Le+k/395tsAdtGUtVsWARCi0PGVqUtDO4z1WlkF0LwNCQqyxDgHxBZKSbu62JoA4kelSgm1xl5f/cjnmM2Gkx3BgcEI3wSCm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127382; c=relaxed/simple;
	bh=GAY/p2+RIFAj4DrueEbtoLyRE4CtY/yinwNuslLZZmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ea+c182WLRbkqzoDeDlNnk5AScHj2YfvRxT5qkmzsHCnhu1n7XItAO36Y81q88A6ozOA8PbTNKFkXBIeLiAa2mpzH1bXJj49J10sZofKlxvRoTR5H38Av7X2bqjYuYXZPpsMuxeIKOax4nYR7y2yJMvRPdd2kNZy0ADNDIRGy78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fq8opP0K; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e0bbe834826so603228276.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 21:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724127379; x=1724732179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srakS6qJodiTLporsDBsy+02pc55aKhjRYvyA7MFvdA=;
        b=fq8opP0Kw52zLIscF1QEQEQWZSJhUStV3d+fG9V/PhN5H76JGjt6tJIBSVDvCpMYd7
         ZXfi2ChvJHuwGa2V/04p4SCDTcdrEpwcOXXU1VkyWMMgiRH5ejg1aBqmNmNLpFuxC3dG
         PwhmajnUifIY1SyVEUnRae/TNFUNelxl7eLf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724127379; x=1724732179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srakS6qJodiTLporsDBsy+02pc55aKhjRYvyA7MFvdA=;
        b=E1YBPBRA/ihCHK4Cs5twzjAGys99V2iuFIRT5EQALGwDipDbOqh3INiBWMfnHrZQ8W
         ZsMy9mjT4NV07wBl1dNJ7CYX1cakLE6CuqEVL56sBziwunpMIXD8KoH5YVAFALTh0kf8
         8Xk9M5F+ihAjr0fw3yVw8GpdGXYZev1PaMTNji5eixywpnTTmScMdW2WnY9f2myC33B5
         JQQsIRUUFwxtBpGxltF96FoqhDH0fECGFAywPBsxVpQRfxUkvD7ODwKPUSyltgN0/v8p
         MdPzBkW+6Z6uH54A2+/pQ3qlyEgdZbMFkvoUakb+J3TZIwu1gD307IwalRH44tyHUrWc
         vvGg==
X-Forwarded-Encrypted: i=1; AJvYcCVBKsGHec+t6DURGm1l09cDuQV9QcIIeca6hoKZRStz5MmiknrTenhrcW33k+C6/zrH4RDGva3sgOidNagRMlvAjIjrJ6NRuptuvLW2
X-Gm-Message-State: AOJu0YzlYMrKy0BMAdXErsL0fSk48a5jwSu7h0Pjzm5DdJHnN6gmhBse
	bWpNl9brtE8j9EuOK23cCiv1Exw92ofgZiaj3/Bkpn00KkQN4hCuw7cUByPrnJ8LVz0oMXfpN1s
	H/tVtvwmbkNjmeDtY3tVDFYiKFNA40b+k1CvdOzbTknJImajw6oec
X-Google-Smtp-Source: AGHT+IEYHD2iKPECcKUGr0P+D5te+97WTsQEPEOCLu0NNZ6JYhTtWhlwpuEYA4h/4Hgf62190NgXJBrA2NJRQNfxAjw=
X-Received: by 2002:a05:6902:91b:b0:dfd:b41f:7f5c with SMTP id
 3f1490d57ef6-e1180f6c94emr6027691276.4.1724127379399; Mon, 19 Aug 2024
 21:16:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815005704.2331005-1-philipchen@chromium.org> <66c3bf85b52e3_2ddc242941@iweiny-mobl.notmuch>
In-Reply-To: <66c3bf85b52e3_2ddc242941@iweiny-mobl.notmuch>
From: Philip Chen <philipchen@chromium.org>
Date: Mon, 19 Aug 2024 21:16:08 -0700
Message-ID: <CA+cxXhmg6y4xePSHO3+0V-Td4OarCS1e4qyOKUducFoETojqFw@mail.gmail.com>
Subject: Re: [PATCH] virtio_pmem: Check device status before requesting flush
To: Ira Weiny <ira.weiny@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 2:56=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Philip Chen wrote:
> > If a pmem device is in a bad status, the driver side could wait for
> > host ack forever in virtio_pmem_flush(), causing the system to hang.
>
> I assume this was supposed to be v2 and you resent this as a proper v2
> with a change list from v1?
Ah...yes, I'll fix it and re-send it as a v2 patch.
>
> Ira
>
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >  drivers/nvdimm/nd_virtio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index 35c8fbbba10e..3b4d07aa8447 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_re=
gion)
> >       unsigned long flags;
> >       int err, err1;
> >
> > +     /*
> > +      * Don't bother to send the request to the device if the device i=
s not
> > +      * acticated.
> > +      */
> > +     if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET)=
 {
> > +             dev_info(&vdev->dev, "virtio pmem device needs a reset\n"=
);
> > +             return -EIO;
> > +     }
> > +
> >       might_sleep();
> >       req_data =3D kmalloc(sizeof(*req_data), GFP_KERNEL);
> >       if (!req_data)
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >
>
>

