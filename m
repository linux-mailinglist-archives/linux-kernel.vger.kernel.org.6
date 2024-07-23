Return-Path: <linux-kernel+bounces-259796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E2939D54
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 11:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D1ED283452
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA1114D2A0;
	Tue, 23 Jul 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XKljCd7Q"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13C14BFB4
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721726085; cv=none; b=LyHEowwmGs+lnfOGl9nHoAYS45qm54TT4khur4qwl7tWQDaRkFXPEz9pG52/28CHAdCz7wv6KHETuJuQNRFj5TRxU+kN41f0mt9TonYaA7Bg9M/yLFWKeSVhzcra821W42dP/cez/tfoemf1txzgxvt00cG8Vo3/PMiphUjTWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721726085; c=relaxed/simple;
	bh=nUN3FWKPF4lxcMW0eNtynse9ROflNRGORRaQ45QqoqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lay07pG5SS/BngYoKOzlwLNmP1Pti+sF+Nd0moN0VT0g8xH7kKCqrqqbrlV9mEHwqbYb40yIQsjg/MFavuJtV2VJnHMdDemEs7/UQqWCEiKz2pKWiSEDaMUddt85t29bqqXpbBWW9L5y1RY1uP5iTqeNst0k/8uqIkXmjFC4xKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XKljCd7Q; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-66ca5e8cc51so23417247b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721726083; x=1722330883; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=do76fn9eVUpHN8Ddkeci0hwMk6DMn3ti88cC7rkfzQc=;
        b=XKljCd7QjGfKHnBgUEFsWG/hiYddjTvFPp8N8jPZMNd0GU6H8OUQZBRyspbCaiJe4n
         Hhmrd1/UaCJp4vyufJNTiwjgfAHk726xpgqr8s4ix3a+wF1qWbMqMCgOWqwnBEeS0lIn
         OE/pCbuu6+e8W9akhjGb2DtYG/xdm9jpHBXwyD0cDEmu2veuVMhKPwVP4tfs5E9TdLiv
         YOFRDE5cTFw941Mg6+nrSDGcDTIcRlYFk9UrKTA0uRbKZDchDGTxaQjA6shKl5qvlpVd
         yZuXWw7k4MQCP3RVsBH4Jlp0qfLoONp2cfkK6olNyoIgR5BXZB+/riBq0j2PJBRM3xQc
         LOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721726083; x=1722330883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=do76fn9eVUpHN8Ddkeci0hwMk6DMn3ti88cC7rkfzQc=;
        b=vVct7oQj62NPJsGvmI0nR0sGsCHeWi0uN3G3QMjo+Y20DwETETrg4zgh+R4gRkJtqf
         5sJLbBculAATWAKc4jyNRnPwAJMTyMNHJ2UgY9kTQ9iOvc4w4g40EN35v/PnK/vGoFVg
         AdGTJp2XM0QQgVadcbO8jKt9dQwGeYUtg9J2ZBj10jA2c/QVN86cj33uYjqIXZFd9YV/
         hO3Y/v0BCk+dbTgE6AbefouzlOLfMRbMXNwwRTxLYY4WWzPgl6ynjCWzNB0YoLMvlFsh
         yjGGjuQC2GMj/uSGLRIsDlXpt9KNqNUN2Y6enDyf/2GjdYRVD25ojWHlEwWLywxKZmJe
         IJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9WOAviUip95ip5++ED0015xMfIrjrocrfFToTaVkwIxi/iVtYLjIt+z6+Ixh1+VUP7VUT7/VyPrRvGPFGP8jkcEb6pfEDL26EwDib
X-Gm-Message-State: AOJu0Yx87M/G4cIQY94loIawhj1vccgHnUq+77sboOfP8HykCJhc71BQ
	0uZdJoiDzS/ac4h2mZlwSty5H+YU3f7S+S8vJCqI3reoRPOyTFvvrO5ZmdbpzJppvYYAoC3PmRz
	r8qUioGGkONT2SYQ4UN/TwnqOEfoZCXRpcmTPbA==
X-Google-Smtp-Source: AGHT+IGDii57wttIhsWjllJQ0f567FJtrDS2mTN6cewKhchy/2c2bk7UMoqEAJRDMLDDuOfO1ytaXqNPjebbxFrr08M=
X-Received: by 2002:a05:690c:288a:b0:627:a917:76b1 with SMTP id
 00721157ae682-66a65e652d0mr117703277b3.44.1721726082779; Tue, 23 Jul 2024
 02:14:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722080200.3530850-1-quic_ekangupt@quicinc.com>
 <20240722080200.3530850-3-quic_ekangupt@quicinc.com> <cr6xv4tsk23sjynnucve4366fwvffgq3rjnbkpxhzdfeiktwtr@ydrp3mduapui>
 <be9ffb28-3ad7-4537-bf80-45ea43f97374@quicinc.com>
In-Reply-To: <be9ffb28-3ad7-4537-bf80-45ea43f97374@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jul 2024 12:14:31 +0300
Message-ID: <CAA8EJpo=mXS43Mhp15Z6fRtLc+__+PmQ7yrOaOQKW-_R1sgbTQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] misc: fastrpc: Increase unsigned PD initmem size
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, 
	linux-kernel@vger.kernel.org, quic_chennak@quicinc.com, 
	dri-devel@lists.freedesktop.org, arnd@arndb.de, stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 07:36, Ekansh Gupta <quic_ekangupt@quicinc.com> wrote:
>
>
>
> On 7/22/2024 2:04 PM, Dmitry Baryshkov wrote:
> > On Mon, Jul 22, 2024 at 01:32:00PM GMT, Ekansh Gupta wrote:
> >> For unsigned PD offloading requirement, additional memory is required
> >> because of additional static heap initialization. Without this
> >> additional memory, PD initialization would fail. Increase the initmem
> >> size by 2MB for unsigned PD initmem buffer allocation. Any additional
> >> memory sent to DSP during PD init is used as the PD heap.
> > From the previous commit message I had the feeling that DSP can request
> > more memory if required. Currently you are stating that PD init would
> > fail if it doesn't have enough mem.
>
> DSP PD can request for memory only for PD heap and that too once the PD
> initialization is complete.

This should be a part of the (previous?) commit message.  Also what is
the difference between static heap vs PD heap?

>
> >
> >> Fixes: 7f1f481263c3 ("misc: fastrpc: check before loading process to the DSP")
> >> Cc: stable <stable@kernel.org>
> >> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> >> ---
> >>  drivers/misc/fastrpc.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
>


-- 
With best wishes
Dmitry

