Return-Path: <linux-kernel+bounces-333042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A929C97C2AB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 03:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE26B1C21989
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 01:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481AE1CD29;
	Thu, 19 Sep 2024 01:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC46j25E"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3128312E48;
	Thu, 19 Sep 2024 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726710284; cv=none; b=bDS5KpV6UOLO1X/b4bmK2dc7ySjSy8mROLkhmuEXnrULTHkF68J9ejYA8O7Hs2fnwYP02JxIQKL7oJ8D61Vxgre1nOFBqPclIYPrzSsz/cYgJsaZCZK/8/XedROlLm0NeGopYyY9zgUQVMbrDnXqMpM/ZlBUNHhbUCikuF6jZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726710284; c=relaxed/simple;
	bh=gOX2Efoo6f2Mn2ISU9WRaKt7vI3dsEcG5PIE8Whds9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akKXiPx//WcX3ggs77GT4G9NTKVD8czJfWxlvkL8ZGWf7xv1LJUIaja3mr32IK9g3ByspuFg/DObv8Lvd+IrXreRwFjPl1xoMi6R/+xNUi1NNNytOofOtIwSaqPd224md/1o1riP9cvk4LxD0my8wvBMTcJT//vtZwFCn0t9x10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC46j25E; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f56df0ddbso1332975ab.3;
        Wed, 18 Sep 2024 18:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726710282; x=1727315082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DX8B0AVGc1Jcf/sZuX/Lm5rKGNOWSa7SVLWhBKf+5LU=;
        b=hC46j25EYk4HsNeKbaRxZMzcjwm2ngn9aUItp5JkzMebn1pTO3WUJog/hB+cPapqwG
         lMzBeaa36KBE6hDuQ8JyG2DHPK77KggmbFZ49og3vG9KNsrrWojZtgbhsXvoNwrBUGXJ
         DGJLpPMjLQFeB9ZcpNQhgaphWSYGQfN+xdC6vsXgOLPF5wLa6KEzlY0xxpj/zK7Hf43y
         ck2h15LpDY9w2VjMiFEXqmJfLbo7nueh9tVXfABJu+wpO5DqXeN5/R+fSXYzQC20pH/k
         vzadINwjz+VVE3r1QtGzhtLe1TX8RYT5WbDiEove9k+sjsCaoq1QNu3qq65mk6Ua3vzh
         F4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726710282; x=1727315082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DX8B0AVGc1Jcf/sZuX/Lm5rKGNOWSa7SVLWhBKf+5LU=;
        b=e8W/v46n+x9iX8hGT9bE6Zt/b132he/4T79m/3dhk35sKfppMiiOHcVp83nxa7VFDf
         /gVwsefp7dUrPwpicewwnQQEGLO3M0V22CBZeamHrtsOJqwEBDWEFMFW3Gs0ASsgvWIg
         Dou5x5/uEV6Z1hpEKE3chdHvW+OCM33mMajUpfUc60wXrrlUvXIouXmvkvajAibAF8fq
         meSyxhLWJZxXzReSkaieaAG2Kr6QPiVJEKw7/5DSWVlinAk3vp6pKQa6aMcV5ogfw9rJ
         r3/KQmK/bVidbS8C1IN9qIwRBXA4rFtbEM6im2YyUVyaBmJKvQocyRBc4v5as6cYxk+S
         ATQA==
X-Forwarded-Encrypted: i=1; AJvYcCVgDLep22OLxeeQRKtPhjHgwikfeb76lRhkQNpuMLHyfjsEvBd9Fzm1bZ86l/9Rrz/XubOBbN2aCk2X5Ss=@vger.kernel.org, AJvYcCXMYh529ylU/ZeARqEA2S/jkoukzKkBn5iKseGLIqmocAPDy4uD2MJL6rK32Ix7NvAOMdH3jyA/OAe3Mzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xk1hGtQOGM1Le0L0PjLaoAP5fxcz72OljXDYIeHBoUMfPO+f
	TVa2Nh/xEg+4lZPyGcVhqQRm98SW/rGbDBezmPIKd2gA+MgTHxv1SPvNC20C77UgO+NCGZ1v1i/
	VTc1dAyBkA2oiNX1oISaZDcgJYUMUcA==
X-Google-Smtp-Source: AGHT+IFvWrciDr6mTn/0jLlxcfQLFJaLJCVtLl6E6HMysiz+7fvxdv5D3t/y67xbPvsZHZCxSp+6BBa6yDCK4/1bo5U=
X-Received: by 2002:a05:6e02:13a2:b0:39f:6180:afca with SMTP id
 e9e14a558f8ab-3a08491196bmr275534325ab.13.1726710282105; Wed, 18 Sep 2024
 18:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1725615837-24872-1-git-send-email-shengjiu.wang@nxp.com> <CAA+D8AOkQOanya6RViXfk_=CmNmCWx-N3cb-0SjMhSy0AA7LeA@mail.gmail.com>
In-Reply-To: <CAA+D8AOkQOanya6RViXfk_=CmNmCWx-N3cb-0SjMhSy0AA7LeA@mail.gmail.com>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 19 Sep 2024 09:44:31 +0800
Message-ID: <CAA+D8ANFn6yD=gV+uMYXyQ_7TmOoBnmJtMZ70qPOS_dHn8OkPA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] ASoC: fsl: add memory to memory function for ASRC
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: vkoul@kernel.org, perex@perex.cz, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jaroslav

On Fri, Sep 13, 2024 at 10:29=E2=80=AFAM Shengjiu Wang <shengjiu.wang@gmail=
.com> wrote:
>
> On Fri, Sep 6, 2024 at 6:05=E2=80=AFPM Shengjiu Wang <shengjiu.wang@nxp.c=
om> wrote:
> >
> > This function is base on the accelerator implementation
> > for compress API:
> > https://patchwork.kernel.org/project/alsa-devel/patch/20240731083843.59=
911-1-perex@perex.cz/
>
> Hi Jaroslav
>
>     Shall I add this patch to my patch set next time? Last time I
> reported an issue
> about "list_for_each_entry_safe_reverse", I can help to add it.  or
> will you send
> another version by yourself?

A gentle reminder, look forward to your reply.
Thanks.

Best regards
Shengjiu Wang

>
> Best regards
> Shengjiu Wang
>
> >
> > Audio signal processing also has the requirement for memory to
> > memory similar as Video.
> >
> > This asrc memory to memory (memory ->asrc->memory) case is a non
> > real time use case.
> >
> > User fills the input buffer to the asrc module, after conversion, then =
asrc
> > sends back the output buffer to user. So it is not a traditional ALSA p=
layback
> > and capture case.
> >
> > Because we had implemented the "memory -> asrc ->i2s device-> codec"
> > use case in ALSA.  Now the "memory->asrc->memory" needs
> > to reuse the code in asrc driver, so the patch 1 and patch 2 is for ref=
ining
> > the code to make it can be shared by the "memory->asrc->memory"
> > driver.
> >
> > Other change is to add memory to memory support for two kinds of i.MX A=
SRC
> > modules.
> >
> > changes in v3:
> > - use Jaroslav's suggestion for header file compress_params.h (PATCH 01=
)
> > - remove the ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE definition
> > - remove ASRC_RATIO_MOD in this version because it uses .set_metadata()
> >   Will wait Jaroslav's update or other better method in the future.
> > - Address some comments from Pierre.
> >
> > changes in v2:
> > - Remove the changes in compress API
> > - drop the SNDRV_COMPRESS_SRC_RATIO_MOD
> > - drop the SND_AUDIOCODEC_SRC and struct snd_dec_src
> > - define private metadata key value
> >   ASRC_OUTPUT_FORMAT/ASRC_OUTPUT_RATE/ASRC_RATIO_MOD
> >
> > Shengjiu Wang (6):
> >   ALSA: compress: Add output rate and output format support
> >   ASoC: fsl_asrc: define functions for memory to memory usage
> >   ASoC: fsl_easrc: define functions for memory to memory usage
> >   ASoC: fsl_asrc_m2m: Add memory to memory function
> >   ASoC: fsl_asrc: register m2m platform device
> >   ASoC: fsl_easrc: register m2m platform device
> >
> >  include/uapi/sound/compress_params.h |  23 +-
> >  sound/soc/fsl/Kconfig                |   1 +
> >  sound/soc/fsl/Makefile               |   2 +-
> >  sound/soc/fsl/fsl_asrc.c             | 179 ++++++-
> >  sound/soc/fsl/fsl_asrc.h             |   2 +
> >  sound/soc/fsl/fsl_asrc_common.h      |  70 +++
> >  sound/soc/fsl/fsl_asrc_m2m.c         | 727 +++++++++++++++++++++++++++
> >  sound/soc/fsl/fsl_easrc.c            | 261 +++++++++-
> >  sound/soc/fsl/fsl_easrc.h            |   4 +
> >  9 files changed, 1260 insertions(+), 9 deletions(-)
> >  create mode 100644 sound/soc/fsl/fsl_asrc_m2m.c
> >
> > --
> > 2.34.1
> >

