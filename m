Return-Path: <linux-kernel+bounces-195398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF9D8D4C2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 15:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F621C23685
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82203183068;
	Thu, 30 May 2024 13:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tde9RP/a"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA21E488
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717074009; cv=none; b=ElKmM13HvxD/67tUis4RXMFdMJ8fgLA2SG4mV/ddl/Ghg62eDf+UUSzahpIu7gRwTGB1/aTEljUVc+3GsYjC30nS4ubaeyfBH62XsULI8UYKxoSPAv9e+qGcR3IZVGnbilBpn1AmTlKsr+3RDUxoqhko7hZ34CzEPIaVwJgw97I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717074009; c=relaxed/simple;
	bh=pj0nrIN3Qs7jpx+J/3Wt1XvGRkbyRR2Eq5pw8utiL9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpbY1I2Uf51pRz5JB+12IMuIr50KsLg6DGLWOtXH2Bb+am1mU/pq720b+VnK/2NsxkQOd8X0zRZTlvlb6LoS/kGhXuJOHC2SxJKixejWtY18yTutDF9GuEX6KmLUE3G/XA+OL2PsF3YBwobM6fydDavYcr4qF0yXdVPWe4YdOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tde9RP/a; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-794ba2d4579so58551385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717074007; x=1717678807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oTphgebvOjeWdN1xBiIRxM6zg0yoJ4DRfXlzkZveD5Q=;
        b=Tde9RP/a8xtlAHidSAH9ff4C7X4uMe2oNKfo2PANm7hO5tEJHQ+VGRFOzibhdO34p6
         kFAaCG8hCZeuGkTLGxotqQEPUs3bRUwK8VBDgDKHBVox3N0YsdqlkY3TOz/Gm+biMd8D
         hYifLEcGcLRUFCXE/bOr+pFd709J73EeZnHTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717074007; x=1717678807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTphgebvOjeWdN1xBiIRxM6zg0yoJ4DRfXlzkZveD5Q=;
        b=lFJAxNPLUVUBXJqUVi+WrkrH8uzTfkWDnBUcM5VvXM3oxQ2wq80oCrFe2CJVVWhFdo
         TSGejzcyArdMismqd1LOt0W9ruCgg02mftYQqJXVOr/c0ZyPWY7KAOVHDrJbbLxBj0EP
         NKk9dox3eL7/WsE6PSDq+rTpI9Z8AmpedGaHvY1lrCrY8n4uWh3kJUZCfxdsU+gE9yjU
         hHrTlmXbH72z2nyLWMX+c7lUoJ/q1vpl0ZWs1XfZDBPCHLZi13RsiWv1vwSka//X4SD4
         PvsxAnmDD5/mUceXmtEYb5hdR+N9lDCSOMafib8/mstDkb52Ju9zk2qBIGkhy0uBfDdi
         /s2w==
X-Forwarded-Encrypted: i=1; AJvYcCXV24bMsfQsQrOtLnMgCGNj5FD05B1EPd813zeb2UxLy3BgFzml4IfM+b60UvqRLDVUquXA+Pm+Vso8S2hh1lE3x9f6TkrGTGmHNBSB
X-Gm-Message-State: AOJu0YwGilzR0vgcFkH88EH2SAwEmwf3lOPIeG24pcNg5a8q7bAPF5kt
	BMP/7cdhNv+84+MBJ8PYKVTPHxaFkE0Lz+2uvktcXU1ETqi7hbJ9UFMyziX6Cnq3n3u9H74zN+c
	kpg==
X-Google-Smtp-Source: AGHT+IFu+EQazI9ObMoLnlR8eMjaMYtWhTgjDut6OL2jYG3NlH7N5HO/QRtWnCLgY15A8N8y7OM0rA==
X-Received: by 2002:a05:620a:1478:b0:794:847c:9030 with SMTP id af79cd13be357-794e9da182dmr211049685a.27.1717074006622;
        Thu, 30 May 2024 06:00:06 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdb784sm552575885a.65.2024.05.30.06.00.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 06:00:05 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ae0bf069f3so4095456d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 06:00:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpi/UyyHZPZXrmgvfSKbfAHOo8Ru81U8ADpC+mEGpwIcr3Ul+YRTIFAkxOKYzWS2JIFH2/8bnGK4w1o+WwdV7zryKEs9yFP4jxFYje
X-Received: by 2002:a05:6214:3b82:b0:6ae:5b:c181 with SMTP id
 6a1803df08f44-6ae0cce1c83mr25263506d6.63.1717074003733; Thu, 30 May 2024
 06:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org>
 <20240527-cocci-flexarray-v3-3-cda09c535816@chromium.org> <6823bc58-9461-4a54-b5b3-7ea5c46fc68b@xs4all.nl>
In-Reply-To: <6823bc58-9461-4a54-b5b3-7ea5c46fc68b@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 30 May 2024 14:59:47 +0200
X-Gmail-Original-Message-ID: <CANiDSCt0PXTP63=dkNpUvH6mYSJ2_mr5xiOd9=RpLqVoD4YY_g@mail.gmail.com>
Message-ID: <CANiDSCt0PXTP63=dkNpUvH6mYSJ2_mr5xiOd9=RpLqVoD4YY_g@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] media: dvb-frontend/mxl5xx: Refactor struct MBIN_FILE_T
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Michael Tretter <m.tretter@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Andy Walls <awalls@md.metrocast.net>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans

On Thu, 30 May 2024 at 14:33, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> On 27/05/2024 23:08, Ricardo Ribalda wrote:
> > Replace a single element array, with a single element field.
> >
> > The following cocci warning is fixed:
> > drivers/media/dvb-frontends/mxl5xx_defs.h:171:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/dvb-frontends/mxl5xx.c      | 2 +-
> >  drivers/media/dvb-frontends/mxl5xx_defs.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/dvb-frontends/mxl5xx.c b/drivers/media/dvb-frontends/mxl5xx.c
> > index 91e9c378397c..a15c0438b07a 100644
> > --- a/drivers/media/dvb-frontends/mxl5xx.c
> > +++ b/drivers/media/dvb-frontends/mxl5xx.c
> > @@ -893,7 +893,7 @@ static int do_firmware_download(struct mxl *state, u8 *mbin_buffer_ptr,
> >       status = write_register(state, FW_DL_SIGN_ADDR, 0);
> >       if (status)
> >               return status;
> > -     segment_ptr = (struct MBIN_SEGMENT_T *) (&mbin_ptr->data[0]);
> > +     segment_ptr = (struct MBIN_SEGMENT_T *)(&mbin_ptr->data);
> >       for (index = 0; index < mbin_ptr->header.num_segments; index++) {
> >               if (segment_ptr->header.id != MBIN_SEGMENT_HEADER_ID) {
> >                       dev_err(state->i2cdev, "%s: Invalid segment header ID (%c)\n",
> > diff --git a/drivers/media/dvb-frontends/mxl5xx_defs.h b/drivers/media/dvb-frontends/mxl5xx_defs.h
> > index 097271f73740..3c5d75ed8fea 100644
> > --- a/drivers/media/dvb-frontends/mxl5xx_defs.h
> > +++ b/drivers/media/dvb-frontends/mxl5xx_defs.h
> > @@ -168,7 +168,7 @@ struct MBIN_FILE_HEADER_T {
> >
> >  struct MBIN_FILE_T {
> >       struct MBIN_FILE_HEADER_T header;
> > -     u8 data[1];
> > +     u8 data;
>
> From what I can tell, shouldn't this be 'data[]'? It really appears to be a flexible array.

The field is mainly used to ease the data parsing. There was only
data[0] used, so I decided to make it into a single element array to
avoid changing the size of the structure....

But you are correct, it looks more clear as a flex array and there is
no allocation or sizeof() so I think it is safe to change its size.

Will squash with the MBIN_SEGMENT_T patch also

Thanks!


>
> Regards,
>
>         Hans
>
> >  };
> >
> >  struct MBIN_SEGMENT_HEADER_T {
> >
>


-- 
Ricardo Ribalda

