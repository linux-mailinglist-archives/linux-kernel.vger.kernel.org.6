Return-Path: <linux-kernel+bounces-294823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB19959314
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 04:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727CF1C22A30
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F80C15689B;
	Wed, 21 Aug 2024 02:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxrF5Dhx"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA915445E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208520; cv=none; b=bc1/IsHxiznYo7mS8MfvgX5H4qP4U+QuDg9Z496cP+k3X8RJOTWK8J+NCE905QOYjz5bIL6K85rm5fWFJVtXH6jxytHXkW2OZ+3iTVYkWEsE/e0m3qryTdme9dpFfXevQDQueh43akHJsEmBZZv0ndrZ7XMiYhz5CMKj3FaQKJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208520; c=relaxed/simple;
	bh=3NT4ahnmFddHIRmFwjcHIuJmDlTvjANzEmVMo6qJ1Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZyUcRBnrsUraA08FIioLKSIAnLgUJTSCc7K9BJxOYL696wJvhQfJWQozTVDw8VrAreIVzS8uFqhRICMNND0Zsw61EQQe/cIsPuXywuGhw2x9/cfJSEpM318nFAGJ5iQvaRobeZGKLG18IowYUd1dWGTcqH8aFa8Sy/Cy/H+QtW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jxrF5Dhx; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093abb12edso4494081a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 19:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724208518; x=1724813318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3aEXOpJkCyNHt+4mZOgRQw75y4G0b8DBrW8S6IF4dU=;
        b=jxrF5DhxkziBpUfJywRobfD+oNYly3IMTpAcQq0UqkYVrw6e3mSu+bilKoqpU8xbBG
         CugKmantrLIE0Dsc2itN/go8NRstm5rIcEHTI0VKeUzjyihj1KqWAMo9tUXQBFH+HEGl
         ZVefJ4slk+IoU15ABnRsO+3cNt7C+5Lp+DwMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724208518; x=1724813318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3aEXOpJkCyNHt+4mZOgRQw75y4G0b8DBrW8S6IF4dU=;
        b=VqYK1PLhY+qPXO8ohy9S5R7gIinAIr9LHfadt2CUU9bmQ/9dSJOPRHgdnOB+9Jy8nX
         mMbY9OPMrhna68OmM/HcO+OPjmC5cciQHkVMP1Il8mnIfskGgjvlVaUSA0wEN2/SObHT
         NhUxnzqTKr0zcjh+YGdH+gaXYOIFGJ3y41mA9chlDxkk23OZf1HuZ1JdPozaLjJyAHlW
         4TtUtrerdXUz5WqLcBTo4b6qmJeo7xSAgzqzy9E1iJb3L/0NAZhDTb+crnJ4CFRE6Ho2
         +tSjHJyNtthm4x6z+mn3g0KZF8/9hl3pZlwsGVHQ4kI2Dv4F1/l+LVbq+vu6rKltRM7l
         2YnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Zp/oRuGg/IV5wrrR8QKxaLplFmxNcrxboBdJiq+BomEDp6kfzQkR6FVJuEqNIG4745vEKv5g5Si9Ut8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/nP11YzsRVMVjPlSOdhrNu/TbeWYIA00sY4SmEgO3ZiKyOog
	7tpqi6bjWWWHpIfoTtZajxdha8Iot9lRtoeqsayoAXTvc6lsn0w2ra4Rx1p98uQrb62jgC5tjf1
	RdPa0Yl/xR9+nWwnTgLiJUeuv+j71xBZNu3L4
X-Google-Smtp-Source: AGHT+IGw9BqTX5VOuQLmS/qKfOQP/sjqjFhw2dnBRfUPMUh9JrsC1327k3YS4AeZHPC9FiuuPKxEewNQSfw++XcuCcs=
X-Received: by 2002:a05:6358:57a3:b0:1ad:10eb:cd39 with SMTP id
 e5c5f4694b2df-1b59fc5cfc2mr159679855d.26.1724208517967; Tue, 20 Aug 2024
 19:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820172256.903251-1-philipchen@chromium.org> <46eacc01-7b23-4f83-af3c-8c5897e44c90@intel.com>
In-Reply-To: <46eacc01-7b23-4f83-af3c-8c5897e44c90@intel.com>
From: Philip Chen <philipchen@chromium.org>
Date: Tue, 20 Aug 2024 19:48:27 -0700
Message-ID: <CA+cxXhnrg8vipY37siXRudRiwLKFuyJXizH9EUczFFnB6iwQAg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: Check device status before requesting flush
To: Dave Jiang <dave.jiang@intel.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	virtualization@lists.linux.dev, nvdimm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 20, 2024 at 1:01=E2=80=AFPM Dave Jiang <dave.jiang@intel.com> w=
rote:
>
>
>
> On 8/20/24 10:22 AM, Philip Chen wrote:
> > If a pmem device is in a bad status, the driver side could wait for
> > host ack forever in virtio_pmem_flush(), causing the system to hang.
> >
> > So add a status check in the beginning of virtio_pmem_flush() to return
> > early if the device is not activated.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
> > v2:
> > - Remove change id from the patch description
> > - Add more details to the patch description
> >
> >  drivers/nvdimm/nd_virtio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
> > index 35c8fbbba10e..97addba06539 100644
> > --- a/drivers/nvdimm/nd_virtio.c
> > +++ b/drivers/nvdimm/nd_virtio.c
> > @@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_re=
gion)
> >       unsigned long flags;
> >       int err, err1;
> >
> > +     /*
> > +      * Don't bother to submit the request to the device if the device=
 is
> > +      * not acticated.
>
> s/acticated/activated/

Thanks for the review.
I'll fix this typo in v3.

In addition to this typo, does anyone have any other concerns?

>
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

