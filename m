Return-Path: <linux-kernel+bounces-354647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F0E994090
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F902880C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B272202F6A;
	Tue,  8 Oct 2024 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Moo/USya"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3F202F63
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728371868; cv=none; b=FfIdt80T2reyl8WMmFVrQoeKIRTAyUZMzLBiIEee2XYu714jwlV0rTwpgVIzaz2LrYH4bYphUP8XHvMcspz3Yi+BJHwm7cd4gnH+YOywfgLU7kI7Ir0j/IOxPlk0xjH7tv9YvNNOX9pst5MEV7gdPwZ5d4pAaSIi6CvVKVxvIfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728371868; c=relaxed/simple;
	bh=Rq6+m+u9kiTX6UlYFssr6a4bxGKClS9bkgRqg/QrNy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN1/8RKalad9KL5YuXg7ufnqQ1QVlNL/xSIWJF3iE4v/unPewtJyX9UYvMyq1Xsh6vsRDvdywm6wstvG0xj6JtP2OPee0rlvRTAK+DcRx9537XLpya26rJLxrFTtqIbtpBrRebwnByj7w0NZc4KkiW/QD9LKMLocKAYObmj+Uj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Moo/USya; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5399675e14cso6031293e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728371864; x=1728976664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF+C/VS/RV7lpIbJDSd0LEsAmluU6E4geD/jADMASpk=;
        b=Moo/USyaD6LF2Xd6G7nUhcUF9wjn19Su7rsngh1Hj9FLPFaXKiufRmUnGPSlQ/mU4H
         VQAqvVhGf43Ysi8WMnb/weoTnUx9U7Ixis3i2r+XCw0TTPg+ewjoWctS/XNu5XTyF0RX
         swe06D011cvHT/UimFjvY1/4YHvpI3Aua3KQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728371864; x=1728976664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF+C/VS/RV7lpIbJDSd0LEsAmluU6E4geD/jADMASpk=;
        b=RO+AzvmQ5uixk+MTLS6pGT7kBfJT1ObwLysfkQjyxCUVfc7cQcNthMObIfmYRw1MUB
         hYPpdTLRKzBjtgV3EOe4wffDVyjoI5Tuf62ezI6//+tbiRlZ3ex5wTUxILuIJ8eeLYy1
         mJjybRcAOVXtlvdQzo42OiAswymD/dTksUkG0k40yM//AXcMAAkjFYjmOqKg7h/b6U0v
         b6sAPYkAHIe/Dj1Xjxpr6KjTk08BIaSN2aodja+hGMoGUN9FUlhEjkShKOq0O4IO+Auw
         UXHrpCFWJfO+acHKUnEwYv/+s25/bZ46TGN0f5uXatjbqezpa9ua12LBFKiBAbz0mNkO
         Nb+A==
X-Forwarded-Encrypted: i=1; AJvYcCWQA2YGjrdwF2CQQjfvh/VS0nTWT80f7q8xJqWfH4FhndDEAsG/wkqUhRc9r4Yd3rRVwm6CGTUJcELppbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4WeYw68XoANYKY1t4K60TQ7PVXWhGH7darH/04rbBMbY7q2g
	MrSGZJw6NPaDXxKrTT+7FhV+RgQ11Dz1Ko52pJm4f5XDLlYT8gupLGdyk21F6jt10IADpUCPxjx
	z04DRkaQ4BYv1Q0PDeYKn572mpdhsd13w/aAf
X-Google-Smtp-Source: AGHT+IGJdYFdMr2wNoGuz1+xxfBC2TiAmu1OrSreQ10rgif0gERGJQsWqZVudZnKhPo9WSkHp9cPdJ5LNcY3ltFTmbI=
X-Received: by 2002:a05:6512:104b:b0:530:aa3e:f3c with SMTP id
 2adb3069b0e04-539ab87476dmr7294478e87.14.1728371863854; Tue, 08 Oct 2024
 00:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008064716.14670-1-jason-jh.lin@mediatek.com>
 <CAGb2v67qnJ=ZNYziKe_4WU9KeMUpWLsOn2uoze1FLq4mH8m7Rw@mail.gmail.com> <6d5e9a84a3b91c82a8f16965872f7485236cd3f2.camel@mediatek.com>
In-Reply-To: <6d5e9a84a3b91c82a8f16965872f7485236cd3f2.camel@mediatek.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Oct 2024 15:17:32 +0800
Message-ID: <CAGXv+5EAoNdwsma_5C0q1gXs2B4Zcz8nAuwYFcvtDPPBs6tFow@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Fix degradation problem of alpha blending series
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "wens@kernel.org" <wens@kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, 
	=?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>, 
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, 
	=?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>, 
	=?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>, 
	"yassine.oudjana@gmail.com" <yassine.oudjana@gmail.com>, "me@adamthiede.com" <me@adamthiede.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:07=E2=80=AFPM Jason-JH Lin (=E6=9E=97=E7=9D=BF=E7=
=A5=A5)
<Jason-JH.Lin@mediatek.com> wrote:
>
> On Tue, 2024-10-08 at 14:52 +0800, Chen-Yu Tsai wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  On Tue, Oct 8, 2024 at 2:47=E2=80=AFPM Jason-JH.Lin <
> > jason-jh.lin@mediatek.com> wrote:
> > >
> > > Some SoCs do not support the ignore_pixl_alpha flag, which breaks
> > the
> > > XRGB8888 format. Some SoCs do not support pre-multiplied pixel
> > formats
> > > and extending configuration of OVL pre-multiplied color formats,
> > > such as MT8173.
> > >
> > > Fix the SoC degradation problem by this sreies.
> >
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > > ---
> > >
> > > Change in v10:
> > > 1. Fix the commit message and comment for OVL_CON_AEN
> >
> > Please carry tested-by tags from people for cosmetic changes such as
> > this.
> >
> OK, I'm sorry about that.
>
> I thought the cover letter won't exist when the whole series go into
> the Linux mainline tree.
>
> But it still can be seen on the patchwork.

Yes. It's simply because people are lazy and don't want to reply to every
patch. Then I guess the tools were changed to support this behavior. :D

> So I'll remember to do this next time. Thanks again!
>
> Regards,
> Jason-JH.Lin
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

