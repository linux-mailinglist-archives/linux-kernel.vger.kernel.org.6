Return-Path: <linux-kernel+bounces-409881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B09C92D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E030B1F21F55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0661A38E3;
	Thu, 14 Nov 2024 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nuz6iWm+"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A051974EA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 20:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731614606; cv=none; b=ItQO2fk2X5r2uULoujz4fccHkQXy66BVJbIwP55wpukhEabPyeXHxlVz+qUVO/P/NvHQ22vUkNF117aL70YquxbB8+fsd3bj9Mbcwm4VHzmjI2wK32o1lIGR2VJ1kHuSMj59Ekl1sEiTQI+dNFOwkzBUo4IfOuXkr/OpKkD9GwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731614606; c=relaxed/simple;
	bh=uN4TYUcdBvZnUKjVY+38/YVjBDOaPDFntj12jx6Dl7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMm1LH61bLNNAPmNbGMGNhv5sjxk5ep8yU5/QPLjd0cewecAW9BfATa0zfMkmOfhntveHlEjauCt0gc85nI0DC+5G5hFFt/RLFDeWH31Jx8VM209UxYbFKBg67A9/tnneaNfWVwcLMtEEWoGRh+h/PA6GGnif5dm2vq8a0d2oVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nuz6iWm+; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7206304f93aso853899b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731614604; x=1732219404; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LcJAM+PKYkMOtdwiCS7fBXkCHNwR9hFBAB9pRay23v4=;
        b=nuz6iWm+cldhE4/vZSzwmr/fmm5taesgZWssr3BXQSfPY5PuRH0/HiJy2ns9vahVB2
         lYrjlcxUJS4B+sa5WWuXvjJuCorhHWbeNlukp4Ryf+/mO5gN9+Amfpm2Uu6DtBLBdsRC
         1HZN+Sj0207KjTwY623mZqvcETlGwdTsDVf9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731614604; x=1732219404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LcJAM+PKYkMOtdwiCS7fBXkCHNwR9hFBAB9pRay23v4=;
        b=rKuOKlOU73NodCfVTCkqyWH8OVFIUdqZimXaV6oK39QTrwgR4TvGM+3ouit9hsRzX9
         zvSS3rYj+TIh9qcK0/hP0h65WcWQRR3z34zz43/5pmt4/crkrscfgF9VVZjbD6LrwD6M
         /yMzl8OhX0UgaiOn6AgxbMJ7mzM+obeIFbyDLJZAzu+2fgyNG7g4RAWu5sZLNaGlKE8Z
         HM3swhxGDfQ5utcYVIfGzKBhVEJ+MhBcXWpYWLCfLoW+NMkaV4Vd4c/rNb8uhZT35qHj
         Pq8GzgLQFkt9lKhUTauaEJPqDHDsFzV6ypKU3D6oRAeJ+rPXVi9viKrnPuCiCW2nqCJT
         XQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUvTAeCxM3ZYTV/L88HDVtxe/YRxk64yuGljbZSTblBm85TAzI/9KFFIzChb8e9Ro4dLeNkwpwBi+RY9j8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx0gF+EcAmbmp/AGJbn4pvnKrzf/lep5ZTboDYjAl+rLOkqJpl
	Khuxpvt4VyHyfE3uF/c0Jkc21KnYWOc9j/sq0TRkB6WYd81uNXp0BfBTKgVYe8sOae3LTXW1HXg
	=
X-Google-Smtp-Source: AGHT+IHg83tAONi3XMs/r7MPgdFtqgVPk/UUMkS6cvR8nv4/+YNUZmJWM8vT3CFYYUZZ+y4ZtQkKEA==
X-Received: by 2002:a05:6a00:80b:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-724769f9eb4mr234315b3a.0.1731614604178;
        Thu, 14 Nov 2024 12:03:24 -0800 (PST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com. [209.85.216.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72476c8fc47sm36196b3a.0.2024.11.14.12.03.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 12:03:21 -0800 (PST)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e3010478e6so869346a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:03:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9b6m1V2DSZRHXnGNXH7kX+HcYEgN96H4QtSmTiYScxmsxt/ZXSKxiSML7QfesgIfgPjleZN9jt57/K08=@vger.kernel.org
X-Received: by 2002:a17:90b:3ec1:b0:2ea:1463:ee2d with SMTP id
 98e67ed59e1d1-2ea15582c39mr209304a91.33.1731614600666; Thu, 14 Nov 2024
 12:03:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-uvc-roi-v15-0-64cfeb56b6f8@chromium.org>
 <20241114-uvc-roi-v15-18-64cfeb56b6f8@chromium.org> <ac8ea4ed606cbc7dfb15057babc29e49a152ef01.camel@irl.hu>
In-Reply-To: <ac8ea4ed606cbc7dfb15057babc29e49a152ef01.camel@irl.hu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 14 Nov 2024 21:03:07 +0100
X-Gmail-Original-Message-ID: <CANiDSCuZTYDsQ3yCpFV_rhbQ+vFGJnsuU-jXwOacxZVbbzEPfw@mail.gmail.com>
Message-ID: <CANiDSCuZTYDsQ3yCpFV_rhbQ+vFGJnsuU-jXwOacxZVbbzEPfw@mail.gmail.com>
Subject: Re: [PATCH v15 18/19] media: uvcvideo: implement UVC v1.5 ROI
To: Gergo Koteles <soyer@irl.hu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ricardo Ribalda <ribalda@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yunke Cao <yunkec@google.com>
Content-Type: text/plain; charset="UTF-8"

Hi Gergo

Sorry, I forgot to reply to your comment in v14.

On Thu, 14 Nov 2024 at 20:53, Gergo Koteles <soyer@irl.hu> wrote:
>
> Hi Ricardo,
>
> On Thu, 2024-11-14 at 19:10 +0000, Ricardo Ribalda wrote:
> >
> > +     },
> > +     {
> > +             .id             = V4L2_CID_UVC_REGION_OF_INTEREST_AUTO,
> > +             .entity         = UVC_GUID_UVC_CAMERA,
> > +             .selector       = UVC_CT_REGION_OF_INTEREST_CONTROL,
> > +             .size           = 16,
> > +             .offset         = 64,
> > +             .v4l2_type      = V4L2_CTRL_TYPE_BITMASK,
> > +             .data_type      = UVC_CTRL_DATA_TYPE_BITMASK,
> > +             .name           = "Region Of Interest Auto Controls",
> > +     },
> >  };
> >
>
> Wouldn't be better to use 8 V4L2_CTRL_TYPE_BOOLEAN controls for this?

If I create 8 Booleans, they will always be shown in the device. And
the user will not have a way to know which values are available and
which are not.

We will also fail the v4l2-compliance test, because there will be up
to 7 boolean controls that will not be able to be set to 1, eventhough
they are writable.

Thanks for the prompt review.
>
> Thanks,
> Gergo
>



--
Ricardo Ribalda

