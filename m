Return-Path: <linux-kernel+bounces-417881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2969D5A30
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3006FB214BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2114174EFA;
	Fri, 22 Nov 2024 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NxLi/nQs"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D4C1531C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261597; cv=none; b=KXlMB6GU8RYDuCFKrsE6h6VMvCEWR3SZClp0PfDthqyrP6ZZB1RQDsbRCun/a/PBuCnymIYhl0vQYOoF3L02lL+6xiNYHgI67Fho5UPiBQWSsxxxiAj9VtV2WbQNFlNPXSpl5F8P/VyfxVZhEsY2Y6TKaXDYdO8DXWm0DnNcG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261597; c=relaxed/simple;
	bh=ZEt3yoR0cr5/kASiXDyIBRVJ5cVFZ2AeNaZON5w/kHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4Zba9NS5YE35nuxNyiDRk865oXSeY1HjyMj7RYx0aES7HPamYL4J3WzhQNocRPIdWxQYzXtdklSL11cjcTzdKAFFaISIbNp7XGgiBotpOowfAiCL7A0rXSdUrXD9083B20v3wLkel0MzBwVPgC0nSl0z1edvIcTsVf9VsgIZik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NxLi/nQs; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1440194a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732261594; x=1732866394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rV7OUDMMlgxjwFF1dF4a3L3rrV3TIom9pYtmVzZiP3c=;
        b=NxLi/nQszJxZ38c92b01yrWLzhHtKcsPUOe8GT7kd0ZGNeyaYNsAeh9nNF7/gxQZ5N
         YhlIVG5IU620p5aerdElFuCdDFo0xAkgOxZHY/3Qhq0MSpNfy/VwIGA1E+KeaM0UsCAK
         UaLsmhWceWL51KLmK709esK8UGhxIVh+m/S88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732261594; x=1732866394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rV7OUDMMlgxjwFF1dF4a3L3rrV3TIom9pYtmVzZiP3c=;
        b=ePoP+0s/1HJRETRk4jjZrUhre7ykwViOqlXleh+086bShbjNCXZ66fCweA9XOqTUI0
         iJ4SxhM0mbGiSigWxSfS7fDj9QGeB65yD/yCWdAtVhMBlxHaykrJ/IYbjcoX184O4/K5
         xxEOHhxsv/KnTo+yDRtc3enLH1i7Lu6GNEL2y9mGNf35FsbRoQK4WKDa/PL8FUDeX3n2
         8AbCi5KeHSDphW8W92TolkxiEEDK3AOgM58L2+xv6QlvlDxmM+PBmkprHcIeC44O0fsa
         DQxpch+u3PD23Oql94SnwTpilNZzT3ojFunrKoXFpEOF+3PUZoj/GvrcdChrlBAyCrZx
         DYGg==
X-Forwarded-Encrypted: i=1; AJvYcCVIouvuyfrZMJ5kvt9KyE6Olf06Kyn+hJ+NO1SaYVYjbDE5ODMN1NACLT9IBJItK3Fga/cjcNJ+5t02ILU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUE+E7FKPeRiIAnyrImDuOZemPSniOd+DnDOi/YE+SuUCZdTU
	3KbvqLtIRxJB3HVGAUZ5yldlFSS5bnv6xQMObI0+YoEaJG9HdrPbNDKW0iGJwtaqBjmCEScZ36k
	=
X-Gm-Gg: ASbGncs6bhKS6AZsIwLDMXAO77iGv7KDX8jB1nm02x36AeC+DIlGiO5l+2vlfrfltVB
	GKREntKIl4eKjfXAUKvPHCC4tXOYsW5NecZ0KfBLAbpp2ZieVp5wydAN3pzzvmHE7byDfJXIG3j
	TMebT2FO3VfOshwUzypjSwoguTNsCJvCqWM3i8T+eqUlR4GqgCpEQo3sGNJUevh9RdU868m2koC
	SCSGSyWhDpMiqtwYNsC9pWGE506tC8WZ+XERRu+6hUz933cHYve5LkadP58MMxyfyPJc1LzuGju
	jE9JeCT0w8FoWoly
X-Google-Smtp-Source: AGHT+IHU/EqCb0NfZ84xapGc34LHfAq0RxCFAkvbQjgXufzm3819+LDc4BXSFHEsnMEjbLY6EirjmQ==
X-Received: by 2002:a05:6a20:6a1d:b0:1d9:c6c5:70c with SMTP id adf61e73a8af0-1e09e3bcf3emr2391325637.5.1732261594481;
        Thu, 21 Nov 2024 23:46:34 -0800 (PST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02eca46sm4464417a91.7.2024.11.21.23.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 23:46:33 -0800 (PST)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fbc65f6c72so953647a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:46:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAih5e+MLxocXEret+/BWhBa2l0OFzpfkWLIzz+Paw1kkHJ3uOhy1GZ+3mrRoNyYc/9qddJQH8DkwaC0s=@vger.kernel.org
X-Received: by 2002:a05:6a20:3949:b0:1dc:2365:a114 with SMTP id
 adf61e73a8af0-1e09e4b19b9mr2861897637.24.1732261593103; Thu, 21 Nov 2024
 23:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-fix-processed-v1-1-4fae6770db30@chromium.org> <853def565622848427e6e5df8f073465fa52e76c.camel@linux.intel.com>
In-Reply-To: <853def565622848427e6e5df8f073465fa52e76c.camel@linux.intel.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Nov 2024 08:46:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCuV1zo0=wGLir26Bn0np+BbVj9aj-JK3ZMreOT78c73UQ@mail.gmail.com>
Message-ID: <CANiDSCuV1zo0=wGLir26Bn0np+BbVj9aj-JK3ZMreOT78c73UQ@mail.gmail.com>
Subject: Re: [PATCH] iio: hid-sensor-prox: Fix invalid read_raw for attention
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 17:44, srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Thu, 2024-11-21 at 09:16 +0000, Ricardo Ribalda wrote:
> > The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
> > IIO_CHAN_INFO_RAW.
> >
> > Modify prox_read_raw() to support it.
> >
> What is the sysfs entry to trigger this IIO_CHAN_INFO_PROCESSED read?
> Don't you have an entry *_raw?

/sys/.../iio:deviceX/in_attention_input

There is no _raw device for it.

>
>
> Thanks,
> Srinivas
>
> > Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more
> > channels")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/iio/light/hid-sensor-prox.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/light/hid-sensor-prox.c
> > b/drivers/iio/light/hid-sensor-prox.c
> > index e8e7b2999b4c..8e5d0ad13a5f 100644
> > --- a/drivers/iio/light/hid-sensor-prox.c
> > +++ b/drivers/iio/light/hid-sensor-prox.c
> > @@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
> >       *val2 = 0;
> >       switch (mask) {
> >       case IIO_CHAN_INFO_RAW:
> > +     case IIO_CHAN_INFO_PROCESSED:
> >               if (chan->scan_index >= prox_state->num_channels)
> >                       return -EINVAL;
> >               address = prox_state->channel2usage[chan-
> > >scan_index];
> > @@ -107,8 +108,7 @@ static int prox_read_raw(struct iio_dev
> > *indio_dev,
> >
> > report_id,
> >
> > SENSOR_HUB_SYNC,
> >                                                          min < 0);
> > -             if (prox_state->channel2usage[chan->scan_index] ==
> > -                 HID_USAGE_SENSOR_HUMAN_ATTENTION)
> > +             if (mask == IIO_CHAN_INFO_PROCESSED)
> >                       *val *= 100;
> >               hid_sensor_power_state(&prox_state-
> > >common_attributes, false);
> >               ret_type = IIO_VAL_INT;
> >
> > ---
> > base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
> > change-id: 20241121-fix-processed-ed1a95641e64
> >
> > Best regards,
>


-- 
Ricardo Ribalda

