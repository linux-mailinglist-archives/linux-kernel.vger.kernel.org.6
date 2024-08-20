Return-Path: <linux-kernel+bounces-293479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF42295804D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C03BB21364
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D41189BA3;
	Tue, 20 Aug 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBRPcSze"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70B84D8CF;
	Tue, 20 Aug 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140354; cv=none; b=nbnSdi1LIkkxnz/5LghKcml7B1IezuYXqjN3xj1OCE9my+CcuUeE/n7k5kjycqn+W73FTvRSO1Nzs/LFy9mrLHWIlN4TYeST/0zwpHc3HRWXXfIW4GMFSep//fHknGNBJ8ho0vT37DLh5RbZ9K6StgSVJF/E9VAhS+7fIEEpvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140354; c=relaxed/simple;
	bh=t+SS2sYV3XPALotEG8GtBNrD6YUGb7AIiW/aIuUoKwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3weumoJ8rHlqUXdz2Vm0jAw01Y6mHvKLT8YlZBXTM2NsSO2IoAzxfiEGbxNwZi4aRAwjnvu3HCdtL0Z2R2XnzuUipcC7RGZrgWkeYvjidSqfgruyI1oszU8GsiP3ul4WW+wnLG+2b1AmBP2CBsC3g9xOkChvFHHrG839BMLCdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBRPcSze; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39d3c8bc608so10070375ab.0;
        Tue, 20 Aug 2024 00:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724140351; x=1724745151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z2IPnhCGoD3q9tMfApbwEBiQbgRS87uwpXJiohxsSxo=;
        b=mBRPcSzeQDIicRCi+ZMfa1GuTHmW4aXgr5S1xW39xYUnJPTAhDjfU7P6Xr8FIf8blS
         +kJnGyAvMN2KiwXcXNTvK8wbIuO8FpyF8rSRioC+qeYcZYALn8LBU5bpHHf7RZeBS17K
         0y05Fdf1DHcbgJVBN/TsgV050Qs+/dxaGffD5d5gJpLx1RON9H9fiF4W7XfVgx4If+1I
         ElxsYmeTZZ0hXr8ZOsQ3SVVrsvBYIEZjFUH2seSV/F+cUYgCA7oE3buxf/cyKFHznNY3
         a6LwgZdIoiDW4hwjRXgtE2ajdZXxEvR/3rJh0EV3QAZ+vHuiWFq2vvtHF3SB6gTMM2t4
         J2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724140351; x=1724745151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z2IPnhCGoD3q9tMfApbwEBiQbgRS87uwpXJiohxsSxo=;
        b=kKkxcA2CiXzKT3/uXItxT3uDgzWYQFhtJX+UatiF2e8fMV+7288IW5ZiVQVCOTZ1H6
         zQXewo2qiudRYTcq/Ngbp8m/iV/y8PX458Ny1bFFNJ2iILOCIr7WBkmrSgCBxoABvL4r
         y+LlbhuYa+99Wal+yano6bmeYLZ3aw1OEdpRT0/y8jRGWTk65qq3WL2oG8gi17RpkUcm
         m1wuDCbY68c24F+/fE7EIT4IiRHCRa2WhGDCfmcRe1paZ+879fn9JtWSTr6tcrfJpHPj
         HgCRwf0gaop/kZKYQh2w0bMqhGTE3t+FH+OzEQHKLVnUgl8K3SPBGBVNf/3t2dsHYjDS
         thGA==
X-Forwarded-Encrypted: i=1; AJvYcCU5GM0qeI0CvEsOYKc31YuWjp/xvEQJPCz3VD2J5YwDV7wfcjo4K2I3sthFgvykyYIitk1VGPfKl9xp/IE=@vger.kernel.org, AJvYcCWxCECTHdA956aG0OlZhz0ueDFzjtBRF2p31Fbe5xVeacCF0zOrLmCS6SCK/PHiwJDXAHH5DVj4/EN7TMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2mCpcNzvhoKjrQljvIacxa96sVYrral57TD4mwKYamhYL0g3B
	6BizpEAgBTMtRX8Zz18IzLcxPvtqK/t/U3ArSc3rjHaLrITmvEaF5SXAdl95u/tq/yNf/uqar/M
	oK2jajqZw814ulDqE+wY1A6BjCto=
X-Google-Smtp-Source: AGHT+IEO2EWDuz6eY2EowaDwGtJ0jIVrmGJxLUqdqJsxC8SyVkLr3sdjBBMTIcU/r8joe3Kel+0mWeYYnFgqJYzgQmc=
X-Received: by 2002:a05:6e02:1a25:b0:398:36c0:7968 with SMTP id
 e9e14a558f8ab-39d26ce6426mr141331125ab.6.1724140350868; Tue, 20 Aug 2024
 00:52:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1723804959-31921-1-git-send-email-shengjiu.wang@nxp.com>
 <1723804959-31921-5-git-send-email-shengjiu.wang@nxp.com> <6d83cd58-5f02-414b-b627-a0022e071052@linux.intel.com>
 <CAA+D8ANDAxS42=9zOLQY_h_ihvJCmaXzE+_iZyxbSuikqt1CBw@mail.gmail.com>
 <ceb54a27-144b-40ed-8de5-482f2b0664a0@linux.intel.com> <CAA+D8ANqb89UavAXTiHvcHyv9uMt8_MYR9hfBaxEJDPNy5C=-g@mail.gmail.com>
 <eceafeef-2dba-48aa-b8b3-198b9bb39fb6@perex.cz>
In-Reply-To: <eceafeef-2dba-48aa-b8b3-198b9bb39fb6@perex.cz>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 20 Aug 2024 15:52:20 +0800
Message-ID: <CAA+D8AMOr8=JS7A0DvOEatL79CwwT4De7vDs6H-VDi05AnkjHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] ASoC: fsl_asrc_m2m: Add memory to memory function
To: Jaroslav Kysela <perex@perex.cz>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, vkoul@kernel.org, tiwai@suse.com, 
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 3:42=E2=80=AFPM Jaroslav Kysela <perex@perex.cz> wr=
ote:
>
> On 20. 08. 24 9:37, Shengjiu Wang wrote:
> > On Tue, Aug 20, 2024 at 2:59=E2=80=AFPM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >>
> >>
> >> On 8/20/24 04:53, Shengjiu Wang wrote:
> >>> On Mon, Aug 19, 2024 at 3:42=E2=80=AFPM Pierre-Louis Bossart
> >>> <pierre-louis.bossart@linux.intel.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 8/16/24 12:42, Shengjiu Wang wrote:
> >>>>> Implement the ASRC memory to memory function using
> >>>>> the compress framework, user can use this function with
> >>>>> compress ioctl interface.
> >>>>>
> >>>>> Define below private metadata key value for output
> >>>>> format, output rate and ratio modifier configuration.
> >>>>> ASRC_OUTPUT_FORMAT 0x80000001
> >>>>> ASRC_OUTPUT_RATE   0x80000002
> >>>>> ASRC_RATIO_MOD     0x80000003
> >>>>
> >>>> Can the output format/rate change at run-time?
> >>>
> >>> Seldom I think.
> >>>
> >>>>
> >>>> If no, then these parameters should be moved somewhere else - e.g.
> >>>> hw_params or something.
> >>>
> >>> This means I will do some changes in compress_params.h, add
> >>> output format and output rate definition, follow Jaroslav's example
> >>> right?
> >>
> >> yes, having parameters for the PCM case would make sense.
> >>
> >>>> I am still not very clear on the expanding the SET_METADATA ioctl to
> >>>> deal with the ratio changes. This isn't linked to the control layer =
as
> >>>> suggested before, and there's no precedent of calling it multiple ti=
mes
> >>>> during streaming.
> >>>
> >>> Which control layer? if you means the snd_kcontrol_new?  it is bound
> >>> with sound card,  but in my case,  I need to the control bind with
> >>> the snd_compr_stream to support multi streams/instances.
> >>
> >> I can only quote Jaroslav's previous answer:
> >>
> >> "
> >> This argument is not valid. The controls are bound to the card, but th=
e
> >> element identifiers have already iface (interface), device and subdevi=
ce
> >> numbers. We are using controls for PCM devices for example. The bindin=
g
> >> is straight.
> >>
> >> Just add SNDRV_CTL_ELEM_IFACE_COMPRESS define and specify the compress
> >> device number in the 'struct snd_ctl_elem_id'.
> >> "
> >
> > I don't think it is doable,  or at least I don't know how to do it.
> >
> > My case is just one card/one device/one subdevice.  can't use it to
> > distinguish multi streams.
>
> I already wrote that the compress core code should be extended to support
> subdevices like other ALSA APIs. I'll work on it. For now, just add suppo=
rt
> for one converter.

Thanks.

What does this subdevices mean?  Is it equal to the compress streams?

When I call snd_compr_ops.open(),  it means to create an instance, the inst=
ance
is created at runtime (call open()), not created when the sound card is cre=
ated.

Best regards
Shengjiu Wang




>
>                                         Jaroslav
>
> --
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
>

