Return-Path: <linux-kernel+bounces-421368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A059D8A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C54B2FEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAC1B4F08;
	Mon, 25 Nov 2024 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VlaKL87e"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860131B3943
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732552061; cv=none; b=Ky1944DzwzGx45oc1l63rdN+3z/rN5rUmeo3KNcN7geRAUOMPdikHtVLWmQoskEfSOKGH5nsIabLF7AFluFKQu0C9bdVIzf24LS++g9byYsVXn+ThR140DcjZSC4fIdoRdgZV5UMIYgZn7tnbL5g8PX/YEmpW3MAe+GZzJ1he2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732552061; c=relaxed/simple;
	bh=R0SfJyrw7C0KxLOqn1gC0wVxvdRJvYjZ2Aw3X8fWg2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5aMzO94XliV/Ps2rurW741Z3tRd9RhmbdenKBGzv+zMDxD+0fWCeUNirnDZiv6r0/g2dyZt15xRyraGz27UwXjGknBwD/RWGLG362XGQMHSwMngFU08x08CxsAeD/1QFwpufAFbAN6vtWlj32LMfsY/Lyajmu/QMr3DD5G/amY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VlaKL87e; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso42437131fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732552058; x=1733156858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yChQ+Bc3/hLFAIXQy5Qdf3pVGzUQXtJDQxX2P5y2ICQ=;
        b=VlaKL87ehHzpxul34gLSsW5ZTyFzGpS+H8arNwGCbjDtoYI1kd9VRs6G5d5joRZaQX
         xXB/COd+UFMIf5kSxolGyh7C8bFAuN3Qm62+Tp+kdhG5xaCwct9i9O5kh/XUUKOLXnzj
         wbrIgWJ27QZfjEAc15eELznwoogf9IxsoiumGvND/rpxB+zrkDdX08fVBHXdZ427JR1L
         IgSmYwdt491PETFW+jBXej9uEet+8NPfHDh9yK+b3NX8lymymd1By3BO4zAPXX7GdOUi
         Qgw+XpSqy1o+EyAjFn/jBYMqR3JRZH2POS4zhAXHiP6ZQRS7RTE8OfWx/VjHs/QqIe8w
         AXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732552058; x=1733156858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yChQ+Bc3/hLFAIXQy5Qdf3pVGzUQXtJDQxX2P5y2ICQ=;
        b=pbd5F7uUGacjv754rkoRN7Ttg8zTQ8IKN2AZ0rtvaRexoDUM8UdKZ8Byc8kjoKSZPe
         Z52LgRGc8gT5VTm7GABqV3Jdi3Lhp3ce3sdFEJ6D9gCLEXFwGzctISOrRbG/mZwMnuV2
         HF/h82501XEi6s34UNCTQeRHhIEBX4fOkQCx2C2eGVnyG6uzdujxSuy9HJpsJDmKKsjr
         sFegb3mEwQTwWK+Fuko4+ZZlcFbTAD9daKf+GMx1SWrpbTO77PBAhzfRjJq0XVtJjSHq
         KBD2Yp4861eZM1Grbr7gcX7wPURCVPq8ZcNOJglXrGsa7ARbwCkwwhXqAX/gFheJejX4
         OIhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHIRuOVFTzJCynvjh8/9qFPADyWpONicKrdiaLEomsr02nDR5VoHvIpzc1lnD4F6P7PfY3/GljrfVvKzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuCVgtIyzXRlow58fyE9J//e00BTWiWxIVyos0Ib1LmcKcDHTd
	b/UGqihupqk7oUD/vqhk8Ayf4l86CUveNqG9U8+SP8DGrJeHO3jp2IuGf25UY4w=
X-Gm-Gg: ASbGnctZE0Is5674QZX/fyAt15gKWZ19Z52FTo2Qt2VakVi+83P4bUsQDAuMNEifyD9
	YAC9pEfBKOwm06+xwQJh38pVoogGnmNX8n6YhbiFTaC/xRG3iEZURAL8TJdyxicfhb9CMfD76j9
	l3VKD9AQ0zYBaM1Qzb3+ktn8lL5YpGLAYcCCaxHcyIs+uZ/0YR+een3s6UtI2OPZVAz3o6LhEi1
	QkI/52q8LfGqhQUDVGPgo9ZME45kwN0n2taljbj7WVdeH93e/B+cztEcRkQsQsgolPw3Ytw6zxk
	0BaFZy1v/NQYrcjhCW/GMOVkF7sbiQ==
X-Google-Smtp-Source: AGHT+IEPzuV6qF3LRJebCgOSfgvwIUrR22q8orC9Jdgp0xsNFNCHkZEIt9rCIrv8k5TvvcNBZU9pkQ==
X-Received: by 2002:a2e:a9ab:0:b0:2fb:6057:e67e with SMTP id 38308e7fff4ca-2ffa71a7b0amr69362691fa.32.1732552057728;
        Mon, 25 Nov 2024 08:27:37 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d3ee22sm15745961fa.43.2024.11.25.08.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 08:27:36 -0800 (PST)
Date: Mon, 25 Nov 2024 18:27:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: "Renjiang Han (QUIC)" <quic_renjiang@quicinc.com>
Cc: "bryan.odonoghue@linaro.org" <bryan.odonoghue@linaro.org>, 
	"Taniya Das (QUIC)" <quic_tdas@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Subject: Re: [PATCH 1/2] clk: qcom: videocc: Use HW_CTRL_TRIGGER flag for
 video GDSC's
Message-ID: <rtmrsvtfukekss4cccnuxgzsm53er5mvgsfshx7xvdwn5vsio2@hgiowygrsmgd>
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
 <20241122-switch_gdsc_mode-v1-1-365f097ecbb0@quicinc.com>
 <zhco37pigrp4fh5alqx4xfxx3xhjitqlgw552vwiijka22bt4u@sl4ngzypwh4x>
 <1d9aa2e7-d402-42dc-baa6-155f01b132ca@quicinc.com>
 <23ho25gl3iwyi2jspb6a2x5bv76fco5pkg2x5ct4gu3c44dbiq@yec6evx5sihm>
 <eec92088-edfb-4d0c-b81d-9d4f1d968b20@linaro.org>
 <b411489f9f2441f7a0f936127678e36b@quicinc.com>
 <CAA8EJpqYSujKXPFkdWcqRpOKZ+dJHQDkYM33Mt5JxuA=Mfs+WQ@mail.gmail.com>
 <7765000a0f87447e98d827dee5977ca7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7765000a0f87447e98d827dee5977ca7@quicinc.com>

On Mon, Nov 25, 2024 at 03:14:27PM +0000, Renjiang Han (QUIC) wrote:
> On Monday, November 25, 2024 9:55 PM, Dmitry Baryshkov wrote:
> > On Mon, 25 Nov 2024 at 07:31, Renjiang Han (QUIC) <quic_renjiang@quicinc.com> wrote:
> > > On Saturday, November 23, 2024 8:17 AM, Bryan O'Donoghue wrote:
> > > > On 23/11/2024 00:05, Dmitry Baryshkov wrote:
> > > > > This leaves sm7150, sm8150 and sm8450 untouched. Don't they also 
> > > > > need to use HW_CTRL_TRIGGER?
> > >
> > > > I believe the correct list here is anything that is HFI_VERSION_4XX 
> > > > in
> > >
> > > > You can't apply the second patch in this series without ensuring the 
> > > > clock controllers for sdm845 and sm7180
> > >
> > > > grep HFI_VERSION_4XX drivers/media/platform/qcom/venus/core.c
> > >
> > > > drivers/clk/qcom/videocc-sdm845.c
> > > > drivers/clk/qcom/videocc-sc7180.c
> > >
> > > > Hmm.. that's what this patch does, to be fair my other email was flippant.
> > >
> > > > This is fine in general, once we can get some Tested-by: for it.
> > >
> > > > That's my question - what platforms has this change been tested on ?
> > >
> > > > I can do sdm845 but, we'll need to find someone with 7180 to verify IMO.
> > >
> > > Thanks for your comment. We have run video case with these two patches on sc7180. The result is fine.
> 
> > A single case, a thorough tests, a mixture of suspend&resume while playing video cases?
> 
> > Also, can I please reiterate my question: sm7150, sm8150 and sm8450 ?
> > Should they also be changed to use HW_CTRL_TRIGGER?
> > Next question, sdm660, msm8996, msm8998: do they support HW_CTRL_TRIGGER?
> 
> Thanks for your review. The video playback and recording cases include video
> pause and resume, and full video playback. The results are fine.
> Also, this change is only for v4 core (HFI_VERSION_4XX ). Therefore, we have only tested it
> on platforms using v4 core. We have not tried other platforms.
> sm7150, sm8150 and sm8450 should not use venus v4 core. So they needn't to use HW_CTRL_TRIGGER.

We don't have venus / iris support for those platforms at all.
This patch is not about venus, it is about the clock drivers. So
mentioning venus is quite useless here.
If these platforms will benefit from HW_CTRL_TRIGGER, then we should
change them at the same time, before somebody even gets venus/iris on
them.

-- 
With best wishes
Dmitry

