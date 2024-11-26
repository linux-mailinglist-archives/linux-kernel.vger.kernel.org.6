Return-Path: <linux-kernel+bounces-422341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DAD9D986D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313E5164A31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AAE1D27BB;
	Tue, 26 Nov 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="LBpmAm9A"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8741D2B22
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732627309; cv=none; b=ErNV05YqVSSleUYrXVx0jiWWBL54GkjTy3ZBAchzisEoBlyM27pVXB8WDHrnJALnGl4Nl1HjL/vcWo6PjISm8R2XUgdZKUH5Ij8/Mb39yRVfNLSE6KKJOp4uyKtZqpnSJWkk+dO/KoaeWa9ivmFjoQrF7xvGBBvsQSECaoXM+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732627309; c=relaxed/simple;
	bh=xam+gvTlNePOXWmvE6HJc/zjRx3Kw98Dpn1CFhvSyqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m63cUgCJh7XIEVp/VP53teehVGf6eFUxl1n74w7siiTME11hX2Zfz9YeW4Qk8CQ4BlRUt+PSmXra3/gHuaDUdEX9Ikg4Yph7pv7e2nK0E4S2lMcUcY+4dQSn3YYzuP3V4tIhVMK7APi9O/t7GiC7URvz/MlO+CIukhMLT+Ocvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=LBpmAm9A; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e388ff24cfeso4973275276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732627306; x=1733232106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JfBuef27ultxtQ0QhYJwcn92wHDcp/POc68y8FNaif0=;
        b=LBpmAm9AObLUzKerHSxN8trff1CqKfxODm7k9UylEpBFQGkD5Sd0hy+st+DT1FpXCh
         klq2v16ibdOsT2orIfQAJR/5C3g3XB3GMBSoGun4NHF1030nBRBCSA3QEZtoltFS7Vxr
         gsSBLqhuWBjB9lLTCAuL7O1ePNzEJiWw7+bxoHe9NnWrLo0+hE1N2eGvzP5HymxBIX58
         MshmXZvziqyVG/UHNgMihx/PfqLjUbG1CT0xilDvZGyIB7jNGUdIHGbN05LGYKCdF/Sl
         1DU5sWBYzTQJ9IRwsG0HhEJvOkmi3+9HMB1FSCL0wpCSE/0qoNbOCEf7JaRF5qs5g+hM
         uoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732627306; x=1733232106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfBuef27ultxtQ0QhYJwcn92wHDcp/POc68y8FNaif0=;
        b=MLH1wikDq28toksrjXVla18x9lcD38vhrtHVDUCdTv83EFPxf9NlTWNUBHozpypgbL
         TKgwa179yzCosO4oDbbmc5dN4OPAQBPHwxF55cMIx9JZZR8K23YVF3pymZgNMlf11aVy
         GqBMnuNs1YRR7CI8zDUO2QeYNFCJOCKbXgudaz4ZJQ0yQN8NqPkZCNRlmvr+DFD8eh38
         lVW2KRM2mAJ5fxQtJgF5XiY5Xwb3/WdRuBDHAQT6BDpVlOjSTT6uicFYoJxO5nv6B9kl
         +n2LUcE151D2VAzAcChrRicQrDONtNVy05vIriFrP/n7QPsoSGeMohzw/cCO07c/CQWC
         ZkRA==
X-Forwarded-Encrypted: i=1; AJvYcCVlmU6w0iTakltKkCIaLnCuPHrR72TAGdwiTCALkXbnmUHue0pxMQKO/SQvGThykSVkDWwRiDHRZwoK4cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxprZQcSI8Yj7lbmPJ0bzMlA2th/sfRRIKyBoQsZU+6+yB/RtZe
	55PWay1x8+gDvPI9Cd8aj4vTWF9y3VkgmqVrYyC0q/X6sJXSv490gBN5EXT7crufjVI+cDlR7vp
	U1z3b6GVmYd83sfIpHgMLIF8GzDchU7W6ohOmNg==
X-Gm-Gg: ASbGncuYZbgMO0yTatPS54KmIZ4RAh3DPYIrlBt7VUaS9ybmFmFQ2/T+RJhyY5c3Mv0
	mppGa+xPHW/cOWG4fjXGYCFK/IjXYGv0=
X-Google-Smtp-Source: AGHT+IHfhcF4QUWpiCk5PqoluUphXMfbjozdMDmHBwlDT1LoH8pl43N8YjZscxunkeOuUY8uIJhg9aIdBNlj/hHa588=
X-Received: by 2002:a05:6902:3411:b0:e30:8568:9d20 with SMTP id
 3f1490d57ef6-e38f8c0c808mr12517464276.53.1732627305045; Tue, 26 Nov 2024
 05:21:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125-imx219_fixes-v3-0-434fc0b541c8@ideasonboard.com>
 <20241125-imx219_fixes-v3-2-434fc0b541c8@ideasonboard.com> <20241126121640.GE5461@pendragon.ideasonboard.com>
In-Reply-To: <20241126121640.GE5461@pendragon.ideasonboard.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 26 Nov 2024 13:21:27 +0000
Message-ID: <CAPY8ntDAnj1uf-fBRbioZSwRm9zO4=e4-E+Rd-PAz0N3cmad-A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: i2c: imx219: make HBLANK r/w to allow
 longer exposures
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jai Luthra <jai.luthra@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Tue, 26 Nov 2024 at 12:16, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Mon, Nov 25, 2024 at 08:36:26PM +0530, Jai Luthra wrote:
> > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >
> > The HBLANK control was read-only, and always configured such
> > that the sensor HTS register was 3448. This limited the maximum
> > exposure time that could be achieved to around 1.26 secs.
> >
> > Make HBLANK read/write so that the line time can be extended,
> > and thereby allow longer exposures (and slower frame rates).
> > Retain the overall HTS setting when changing modes rather than
> > resetting it to a default.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
> > ---
> >  drivers/media/i2c/imx219.c | 37 ++++++++++++++++++++++++-------------
> >  1 file changed, 24 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> > index f98aad74fe584a18e2fe7126f92bf294762a54e3..970e6362d0ae3a9078daf337155e83d637bc1ca1 100644
> > --- a/drivers/media/i2c/imx219.c
> > +++ b/drivers/media/i2c/imx219.c
> > @@ -76,8 +76,10 @@
> >
> >  #define IMX219_VBLANK_MIN            32
> >
> > -/* HBLANK control - read only */
> > -#define IMX219_PPL_DEFAULT           3448
> > +/* HBLANK control range */
>
> Just drop the comment, and drop the blank lines, this belongs to the
> "V_TIMING internal" section.
>
> > +#define IMX219_PPL_MIN                       0x0d78
>
> Why PPL and not HTS ?

The IMX219 datasheet defines the register as LINE_LENGTH_A, with
comment line_length_pck.

HTS is not a term used in the imx219 datasheet, so why introduce it to
the driver? I'd go along with a rename to LLP if you wish.
(HTS is more commonly an Omnivision term, not a Sony one).

> > +#define IMX219_PPL_MAX                       0x7ff0
> > +#define IMX219_REG_HTS                       CCI_REG16(0x0162)
>
> The min/max should go below the register definition.
>
> >
> >  #define IMX219_REG_LINE_LENGTH_A     CCI_REG16(0x0162)
> >  #define IMX219_REG_X_ADD_STA_A               CCI_REG16(0x0164)
> > @@ -422,6 +424,10 @@ static int imx219_set_ctrl(struct v4l2_ctrl *ctrl)
> >               cci_write(imx219->regmap, IMX219_REG_VTS,
> >                         format->height + ctrl->val, &ret);
> >               break;
> > +     case V4L2_CID_HBLANK:
> > +             cci_write(imx219->regmap, IMX219_REG_HTS,
> > +                       format->width + ctrl->val, &ret);
> > +             break;
> >       case V4L2_CID_TEST_PATTERN_RED:
> >               cci_write(imx219->regmap, IMX219_REG_TESTP_RED,
> >                         ctrl->val, &ret);
> > @@ -496,12 +502,10 @@ static int imx219_init_controls(struct imx219 *imx219)
> >                                          V4L2_CID_VBLANK, IMX219_VBLANK_MIN,
> >                                          IMX219_VTS_MAX - mode->height, 1,
> >                                          mode->vts_def - mode->height);
> > -     hblank = IMX219_PPL_DEFAULT - mode->width;
> > +     hblank = IMX219_PPL_MIN - mode->width;
> >       imx219->hblank = v4l2_ctrl_new_std(ctrl_hdlr, &imx219_ctrl_ops,
> >                                          V4L2_CID_HBLANK, hblank, hblank,
>
> The minimum and maximum are identical, is this intentional ?

The limits should be updated when the format is set, so the values
shouldn't matter when created. However I'd want to check that did
happen seeing as vblank computes the limits here.
It is as easy to set them correctly here too (max = IMX219_PPL_MAX -
mode->width), so you may as well.

> >                                          1, hblank);
> > -     if (imx219->hblank)
> > -             imx219->hblank->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >       exposure_max = mode->vts_def - 4;
> >       exposure_def = (exposure_max < IMX219_EXPOSURE_DEFAULT) ?
> >               exposure_max : IMX219_EXPOSURE_DEFAULT;
> > @@ -817,6 +821,10 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
> >       struct v4l2_mbus_framefmt *format;
> >       struct v4l2_rect *crop;
> >       unsigned int bin_h, bin_v;
> > +     u32 prev_hts;
> > +
> > +     format = v4l2_subdev_state_get_format(state, 0);
> > +     prev_hts = format->width + imx219->hblank->val;
> >
> >       mode = v4l2_find_nearest_size(supported_modes,
> >                                     ARRAY_SIZE(supported_modes),
> > @@ -824,8 +832,6 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
> >                                     fmt->format.width, fmt->format.height);
> >
> >       imx219_update_pad_format(imx219, mode, &fmt->format, fmt->format.code);
> > -
> > -     format = v4l2_subdev_state_get_format(state, 0);
> >       *format = fmt->format;
> >
> >       /*
> > @@ -861,13 +867,18 @@ static int imx219_set_pad_format(struct v4l2_subdev *sd,
> >                                        exposure_max, imx219->exposure->step,
> >                                        exposure_def);
> >               /*
> > -              * Currently PPL is fixed to IMX219_PPL_DEFAULT, so hblank
> > -              * depends on mode->width only, and is not changeble in any
> > -              * way other than changing the mode.
> > +              * Retain PPL setting from previous mode so that the
>
> Rename PPL to HTS here too.

Disagree as above. The local variable here should be renamed prev_ppl
or prev_llp.

  Dave

> > +              * line time does not change on a mode change.
> > +              * Limits have to be recomputed as the controls define
> > +              * the blanking only, so PPL values need to have the
> > +              * mode width subtracted.
> >                */
> > -             hblank = IMX219_PPL_DEFAULT - mode->width;
> > -             __v4l2_ctrl_modify_range(imx219->hblank, hblank, hblank, 1,
> > -                                      hblank);
> > +             hblank = prev_hts - mode->width;
> > +             __v4l2_ctrl_modify_range(imx219->hblank,
> > +                                      IMX219_PPL_MIN - mode->width,
> > +                                      IMX219_PPL_MAX - mode->width,
> > +                                      1, IMX219_PPL_MIN - mode->width);
> > +             __v4l2_ctrl_s_ctrl(imx219->hblank, hblank);
> >       }
> >
> >       return 0;
> >
>
> --
> Regards,
>
> Laurent Pinchart

