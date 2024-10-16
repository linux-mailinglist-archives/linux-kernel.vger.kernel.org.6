Return-Path: <linux-kernel+bounces-366874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D549899FBA6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D88BB2136C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7F81D63D3;
	Tue, 15 Oct 2024 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEaSpKpv"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C71C21E3D1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032500; cv=none; b=cK0kdprSGWHSIRcASZLNn90jlklOnNLp9vRQxbeaZfIELUj1zC8zDL4Ptmgc5oP6y0Y5L3X663Eof12Oe/4+z9xH5Sw/YV7wvEh9TD27P/La3SaWXoh52Kjz8c3bh9uJxGOFCJeYIlnIdCWBUmsBxKu6+Qnv9VvTvD3igFraN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032500; c=relaxed/simple;
	bh=7iWSSPGf8QiacangIGWXN/WcTOwVCk43rYBmIcX7PKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkTcR5vn8a52xiPaK/bE8IcU3F6hCt4UsJKaxnbf3Q66sqzerIRh17vtdwKAozYqpnwgxnM9CBlxycvIFiDUWY68m67jITCn0JnohtAsHiAKhZkzb2KlGjBl007pkrLspO3WSgWSCjztSL3RvtlT0jEP7g3m9YW+bgk01shlUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BEaSpKpv; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c9428152c0so7617408a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729032497; x=1729637297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9deZMrdsoekpJ9dDYChmkSz47OQPl6TKz/3bjf39fVM=;
        b=BEaSpKpvMLNfi9oMrHIzfIi/L1I+QLgV3ik+PHk02v9VAAQjY9TpeoKfYnupvQbVUr
         IZzFimGLTV3RjfJ+CG83pEhjHLYpBD79TSVa4H+Jg2yGZD8rCagAIxce4FXeHoLaLA6q
         KlAyfaEHzRIdgd8vIXejXYHBPTyaElLhPnj8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032497; x=1729637297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9deZMrdsoekpJ9dDYChmkSz47OQPl6TKz/3bjf39fVM=;
        b=eSRvJeNqRa6F9ERZouJ4lno0j19Mijj9JhdfhAtxcpg0bh+kneyXFUG8Dmaf/cpB9N
         SIjQMySRKupzztPV4SUwyhZ8qssPup6dqeB/VbI0j0vqBG48wp5S62a9NPTH5lM+jCra
         9Z+TBpusKN+0RZ6eJtF7tTcGDhmMqfnlMjAJ7d1eGwUtay8Or5Grh7NuVjCgQu0v8hsB
         VfjTONK+Dha1AqhU2SVsTAi4ReCFVVYsXpbAoMLDk1qXbap/Zs7tsfbR6vJCG4VAZjIf
         Qhd2eHC1lM3CtGl8+QaZkfr5xFRZ4Mi/CwgfEEDLXven9qlmhUlVd9aZp3zVYmfj3TVP
         s5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWjz64h1fEKtM1tK1fAXHkBSGPTEylP0/kV4tKUhRUehGCWtuhz4TADwbxTO3VIXx2EhxBEXGYFG2UvkK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzdchgzxNcpS6vo9hQKyyaANUTyRttAaxj1cG1Vn6/v9iZPtCP
	cuNvDVt7qDB5baa3QzoL5EnzyxUQjvfGW+VKfg1P8WAyHa70dfxf6mDBkWvSq8Y7/aTfKYn06z8
	=
X-Google-Smtp-Source: AGHT+IFOP8ZHMWtYUvutX+pMhW6KUxPmoIz6DTt0r5KjJXhEyXG0C6IAM9lmvTGy7bcEpSxM3gFcew==
X-Received: by 2002:a05:6402:2787:b0:5c9:2cf8:6a34 with SMTP id 4fb4d7f45d1cf-5c99501d120mr1100023a12.1.1729032496739;
        Tue, 15 Oct 2024 15:48:16 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d777ff9sm1093635a12.68.2024.10.15.15.48.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 15:48:15 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c93e9e701fso1289a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:48:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNm7z0vDAGwePZqXg7WSWeRJ1PuUENtzdgYFunNY9Q5rlL9MNeSMTI/xpzYlgzZ1fDTPsSg+qclax88Tg=@vger.kernel.org
X-Received: by 2002:a05:6402:5109:b0:5c8:aefb:746d with SMTP id
 4fb4d7f45d1cf-5c99934a456mr77657a12.5.1729032494271; Tue, 15 Oct 2024
 15:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814-submit-v3-0-f7d05e3e8560@chromium.org>
 <20240814-submit-v3-2-f7d05e3e8560@chromium.org> <65026fea-c591-d072-e7e8-2abf1fd057ce@quicinc.com>
In-Reply-To: <65026fea-c591-d072-e7e8-2abf1fd057ce@quicinc.com>
From: Fritz Koenig <frkoenig@chromium.org>
Date: Tue, 15 Oct 2024 15:48:01 -0700
X-Gmail-Original-Message-ID: <CAMfZQbyfB_tnoc+cvBOqhJ1SaOD=ued-tnOD-jz3=sMH4-y_qg@mail.gmail.com>
Message-ID: <CAMfZQbyfB_tnoc+cvBOqhJ1SaOD=ued-tnOD-jz3=sMH4-y_qg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: venus: Enable h.264 hierarchical coding
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Fritz Koenig <frkoenig@chromium.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 12:05=E2=80=AFAM Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
>
>
> On 8/15/2024 3:44 AM, Fritz Koenig wrote:
> > HFI supports hierarchical P encoding and the ability to specify the
> > bitrate for the different layers.
> >
> > Connect the controls that V4L2 provides and HFI supports.
> >
> > Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> > ---
> >  drivers/media/platform/qcom/venus/core.h       |  4 ++
> >  drivers/media/platform/qcom/venus/venc.c       | 85 +++++++++++++++---=
------
> >  drivers/media/platform/qcom/venus/venc_ctrls.c | 92 ++++++++++++++++++=
++++++++
> >  3 files changed, 151 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/p=
latform/qcom/venus/core.h
> > index 55202b89e1b9..fd46a7778d8c 100644
> > --- a/drivers/media/platform/qcom/venus/core.h
> > +++ b/drivers/media/platform/qcom/venus/core.h
> > @@ -26,6 +26,7 @@
> >  #define VIDC_CLKS_NUM_MAX            4
> >  #define VIDC_VCODEC_CLKS_NUM_MAX     2
> >  #define VIDC_RESETS_NUM_MAX          2
> > +#define VIDC_MAX_HIER_CODING_LAYER 6
> >
> >  extern int venus_fw_debug;
> >
> > @@ -255,6 +256,7 @@ struct venc_controls {
> >       u32 rc_enable;
> >       u32 const_quality;
> >       u32 frame_skip_mode;
> > +     u32 layer_bitrate;
> >
> >       u32 h264_i_period;
> >       u32 h264_entropy_mode;
> > @@ -273,6 +275,8 @@ struct venc_controls {
> >       s32 h264_loop_filter_alpha;
> >       s32 h264_loop_filter_beta;
> >       u32 h264_8x8_transform;
> > +     u32 h264_hier_layers;
> > +     u32 h264_hier_layer_bitrate[VIDC_MAX_HIER_CODING_LAYER];
> >
> >       u32 hevc_i_qp;
> >       u32 hevc_p_qp;
> > diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/p=
latform/qcom/venus/venc.c
> > index 3ec2fb8d9fab..af2c92069967 100644
> > --- a/drivers/media/platform/qcom/venus/venc.c
> > +++ b/drivers/media/platform/qcom/venus/venc.c
> > @@ -734,6 +734,29 @@ static int venc_set_properties(struct venus_inst *=
inst)
> >               if (ret)
> >                       return ret;
> >
> > +             if (ctr->layer_bitrate) {
> > +                     unsigned int i;
> > +
> > +                     ptype =3D HFI_PROPERTY_PARAM_VENC_HIER_P_MAX_NUM_=
ENH_LAYER;
> > +                     ret =3D hfi_session_set_property(inst, ptype, &ct=
r->h264_hier_layers);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     ptype =3D HFI_PROPERTY_CONFIG_VENC_HIER_P_ENH_LAY=
ER;
> > +                     ret =3D hfi_session_set_property(inst, ptype, &ct=
r->layer_bitrate);
> > +                     if (ret)
> > +                             return ret;
> > +
> > +                     for (i =3D 0; i < ctr->h264_hier_layers; ++i) {
> > +                             ptype =3D HFI_PROPERTY_CONFIG_VENC_TARGET=
_BITRATE;
> > +                             brate.bitrate =3D ctr->h264_hier_layer_bi=
trate[i];
> > +                             brate.layer_id =3D i;
> > +
> > +                             ret =3D hfi_session_set_property(inst, pt=
ype, &brate);
> > +                             if (ret)
> > +                                     return ret;
> > +                     }
> > +             }
> >       }
> >
> >       if (inst->fmt_cap->pixfmt =3D=3D V4L2_PIX_FMT_H264 ||
> > @@ -823,45 +846,47 @@ static int venc_set_properties(struct venus_inst =
*inst)
> >                       return ret;
> >       }
> >
> > -     if (!ctr->bitrate)
> > -             bitrate =3D 64000;
> > -     else
> > -             bitrate =3D ctr->bitrate;
> > +     if (!ctr->layer_bitrate) {
> > +             if (!ctr->bitrate)
> > +                     bitrate =3D 64000;
> > +             else
> > +                     bitrate =3D ctr->bitrate;
> >
> > -     ptype =3D HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
> > -     brate.bitrate =3D bitrate;
> > -     brate.layer_id =3D 0;
> > +             ptype =3D HFI_PROPERTY_CONFIG_VENC_TARGET_BITRATE;
> > +             brate.bitrate =3D bitrate;
> > +             brate.layer_id =3D 0;
> >
> > -     ret =3D hfi_session_set_property(inst, ptype, &brate);
> > -     if (ret)
> > -             return ret;
> > +             ret =3D hfi_session_set_property(inst, ptype, &brate);
> > +             if (ret)
> > +                     return ret;
> >
> > -     if (inst->fmt_cap->pixfmt =3D=3D V4L2_PIX_FMT_H264 ||
> > -         inst->fmt_cap->pixfmt =3D=3D V4L2_PIX_FMT_HEVC) {
> > -             ptype =3D HFI_PROPERTY_CONFIG_VENC_SYNC_FRAME_SEQUENCE_HE=
ADER;
> > -             if (ctr->header_mode =3D=3D V4L2_MPEG_VIDEO_HEADER_MODE_S=
EPARATE)
> > -                     en.enable =3D 0;
> > +             if (inst->fmt_cap->pixfmt =3D=3D V4L2_PIX_FMT_H264 ||
> > +                             inst->fmt_cap->pixfmt =3D=3D V4L2_PIX_FMT=
_HEVC) {
> > +                     ptype =3D HFI_PROPERTY_CONFIG_VENC_SYNC_FRAME_SEQ=
UENCE_HEADER;
> > +                     if (ctr->header_mode =3D=3D V4L2_MPEG_VIDEO_HEADE=
R_MODE_SEPARATE)
> why move this ctrl setting inside ctr->layer_bitrate check?
> I don't think this depends on layer bitrate.

This was sloppy on my part. I did not look close enough to see that
this wasn't bitrate related.

Will update and send a new patchset.
>
> Thanks,
> Dikshita
> > +                             en.enable =3D 0;
> > +                     else
> > +                             en.enable =3D 1;
> > +
> > +                     ret =3D hfi_session_set_property(inst, ptype, &en=
);
> > +                     if (ret)
> > +                             return ret;
> > +             }
> > +
> > +             if (!ctr->bitrate_peak)
> > +                     bitrate *=3D 2;
> >               else
> > -                     en.enable =3D 1;
> > +                     bitrate =3D ctr->bitrate_peak;
> >
> > -             ret =3D hfi_session_set_property(inst, ptype, &en);
> > +             ptype =3D HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
> > +             brate.bitrate =3D bitrate;
> > +             brate.layer_id =3D 0;
> > +
> > +             ret =3D hfi_session_set_property(inst, ptype, &brate);
> >               if (ret)
> >                       return ret;
> >       }
> >
> > -     if (!ctr->bitrate_peak)
> > -             bitrate *=3D 2;
> > -     else
> > -             bitrate =3D ctr->bitrate_peak;
> > -
> > -     ptype =3D HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE;
> > -     brate.bitrate =3D bitrate;
> > -     brate.layer_id =3D 0;
> > -
> > -     ret =3D hfi_session_set_property(inst, ptype, &brate);
> > -     if (ret)
> > -             return ret;
> > -
> >       ptype =3D HFI_PROPERTY_PARAM_VENC_SESSION_QP;
> >       if (inst->fmt_cap->pixfmt =3D=3D V4L2_PIX_FMT_HEVC) {
> >               quant.qp_i =3D ctr->hevc_i_qp;
> > diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/m=
edia/platform/qcom/venus/venc_ctrls.c
> > index 3e1f6f26eddf..e340783a4ef2 100644
> > --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
> > +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
> > @@ -346,6 +346,55 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
> >
> >               ctr->h264_8x8_transform =3D ctrl->val;
> >               break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_TYPE:
> > +             if (ctrl->val !=3D V4L2_MPEG_VIDEO_H264_HIERARCHICAL_CODI=
NG_P)
> > +                     return -EINVAL;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING:
> > +             ctr->layer_bitrate =3D ctrl->val;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING_LAYER:
> > +             if (ctrl->val > VIDC_MAX_HIER_CODING_LAYER)
> > +                     return -EINVAL;
> > +             ctr->h264_hier_layers =3D ctrl->val;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L0_BR:
> > +             ctr->h264_hier_layer_bitrate[0] =3D ctrl->val;
> > +             ret =3D dynamic_bitrate_update(inst, ctr->h264_hier_layer=
_bitrate[0], 0);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L1_BR:
> > +             ctr->h264_hier_layer_bitrate[1] =3D ctrl->val;
> > +             ret =3D dynamic_bitrate_update(inst, ctr->h264_hier_layer=
_bitrate[1], 1);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L2_BR:
> > +             ctr->h264_hier_layer_bitrate[2] =3D ctrl->val;
> > +             ret =3D dynamic_bitrate_update(inst, ctr->h264_hier_layer=
_bitrate[2], 2);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L3_BR:
> > +             ctr->h264_hier_layer_bitrate[3] =3D ctrl->val;
> > +             ret =3D dynamic_bitrate_update(inst, ctr->h264_hier_layer=
_bitrate[3], 3);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L4_BR:
> > +             ctr->h264_hier_layer_bitrate[4] =3D ctrl->val;
> > +             ret =3D dynamic_bitrate_update(inst, ctr->h264_hier_layer=
_bitrate[4], 4);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +     case V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L5_BR:
> > +             ctr->h264_hier_layer_bitrate[5] =3D ctrl->val;
> > +             ret =3D dynamic_bitrate_update(inst, ctr->h264_hier_layer=
_bitrate[5], 5);
> > +             if (ret)
> > +                     return ret;
> > +             break;
> > +
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -628,6 +677,49 @@ int venc_ctrl_init(struct venus_inst *inst)
> >                         V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
> >                         ((4096 * 2304) >> 8), 1, 0);
> >
> > +     if (IS_V4(inst->core) || IS_V6(inst->core)) {
> > +             v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_op=
s,
> > +                                    V4L2_CID_MPEG_VIDEO_H264_HIERARCHI=
CAL_CODING_TYPE,
> > +                                    V4L2_MPEG_VIDEO_H264_HIERARCHICAL_=
CODING_P,
> > +                                    1, V4L2_MPEG_VIDEO_H264_HIERARCHIC=
AL_CODING_P);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_C=
ODING, 0, 1, 1, 0);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_C=
ODING_LAYER, 0,
> > +                               VIDC_MAX_HIER_CODING_LAYER, 1, 0);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L0=
_BR,
> > +                               BITRATE_MIN, BITRATE_MAX, BITRATE_STEP,=
 BITRATE_DEFAULT);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L1=
_BR,
> > +                               BITRATE_MIN, BITRATE_MAX,
> > +                               BITRATE_STEP, BITRATE_DEFAULT);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L2=
_BR,
> > +                               BITRATE_MIN, BITRATE_MAX,
> > +                               BITRATE_STEP, BITRATE_DEFAULT);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L3=
_BR,
> > +                               BITRATE_MIN, BITRATE_MAX,
> > +                               BITRATE_STEP, BITRATE_DEFAULT);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L4=
_BR,
> > +                               BITRATE_MIN, BITRATE_MAX,
> > +                               BITRATE_STEP, BITRATE_DEFAULT);
> > +
> > +             v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
> > +                               V4L2_CID_MPEG_VIDEO_H264_HIER_CODING_L5=
_BR,
> > +                               BITRATE_MIN, BITRATE_MAX,
> > +                               BITRATE_STEP, BITRATE_DEFAULT);
> > +     }
> > +
> >       ret =3D inst->ctrl_handler.error;
> >       if (ret)
> >               goto err;
> >

