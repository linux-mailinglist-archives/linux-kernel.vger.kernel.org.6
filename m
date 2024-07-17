Return-Path: <linux-kernel+bounces-255012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C72933A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 11:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722F61F22F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945D17E901;
	Wed, 17 Jul 2024 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XFkpyIjh"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F136134
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210249; cv=none; b=eOE3o8+DCp8iO9Nm8r18CWzzXZDLWR42xd34DLc1c3QRR/f6aJ1Y8La1WsIujVWFSlO0EJIEyDUprKVu/+e2vPg8t5XXsSr801gDDY8dOXm2mUDSmoGOVQIQP8tgoXpq7tVt9M8okKkIupj009v2bSQSEmhJ4UVEr2oEs1NCLpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210249; c=relaxed/simple;
	bh=fqxfcncuoVyG5zBE1jUrZj6vrQV7HQXkXa1mScfaPzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knu0uMhx3XxOXyfJDHN65xVJGK5aIiqjjxeb1wdZ1hpfibKPqNCsZLFWhr/M3HbyUtBUIsOmdA5WKes8oanYMFJU9wI7actfW8msr1ux8i7KswDBpy88WvVEJMSIFhCwwANrAm+DlQfnyg4mJmnBZbcifUnB5n4fxcrd6quiokM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XFkpyIjh; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-664b4589b1aso4888597b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 02:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210246; x=1721815046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a62po2BtA0hzd5JP2PG8oZzkmEFrZ/nHtjZ0FdMaodg=;
        b=XFkpyIjhg2yAWY0j8Xn8N3wsXWlnwXDNk6MAyLXG0jXDSFjxagnQ2vSejp2H8hjHaa
         ghszo/7Mgx2E+p7a5neG6CTrQmju3sAZKAlqW+4vEIGBOw1Pw+HAGfI3x/faAFz33nez
         eOweBl8lqaRF/TPRYofioKeLEsCYX1/5k5Cm1KndnR0PlFte7xsXkdiFnZZavCEf2iko
         LFtjmafHkQco24lTMrdyrSm8/eyXmfgDviHvn8aiKqGEwXCbd17LUz4H6gAfR4haJdXW
         oC4m8xkpHbZbRmgrHWtTAEVmZz7fcSbw06Hf4WLDmjoPL7P8kYjYCHHi/SbOMmWYCgaT
         LmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210246; x=1721815046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a62po2BtA0hzd5JP2PG8oZzkmEFrZ/nHtjZ0FdMaodg=;
        b=V6K7BH7Bu8b9P59dNkevB3fvdcyUjdP9KPvEWA8S5df7PXjnu7U9ha03O5CD9poRB8
         hYgtSiEMy/drNkdLPZ3FbyKyge1ouWsxLJXi1osw5MFeNUK7FbuSXvSUJkTDL3GJVG/Q
         P5xL8tHvP59lBbFG7oJNd4j0rl43lmSg+xsRbKPqxGeRM+N1OYd7mucUA+0ePyiMvLA+
         FrkA02q+6TdpfANcNxcdDjj9a1xo0fXMVDL8ZXm6FnYl0dvIpMuktVUlsiFWEnkKZSh9
         PvJhCrv0gQDdfx6BGwn0Ku4qbPL/9dIEFJFUlTOQLyBHaROuGBeBC3hiVtcB3zzZH1u6
         q6xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnYpLQ3Ej16bESHYi4VEC3DnLD8yVth67sGI0R6a8uVLAF+mFTJVS035u49zUjETnmui06mDFrKsru2XvjeksRmLk9kRbxqJJDH3oH
X-Gm-Message-State: AOJu0YyN/BXgPgaxWPikwui0uYD5aYFOAFdXBEm4HkTjSQooGDZqvz8Y
	kU30rwoRaZ7Q3E1l43X43FaPKiq9qgOBtrwSmLjiS+MuuQ53dlJWpc5TMwfIZhxTPPn7eztrwFq
	VzLdQYlXihqQ86g6ivv7Pneqg0ftj8Mxem4w1yg==
X-Google-Smtp-Source: AGHT+IHzTQpJ68K42DfjaQMfYKjGlmh51aQyUTqPRdFPAL4KBvPzNvYYSONr3c7gGTRhUJVpLXX+ieYbx0ICXs3aqfc=
X-Received: by 2002:a05:690c:90a:b0:664:56a2:1376 with SMTP id
 00721157ae682-66507077491mr8518247b3.21.1721210245684; Wed, 17 Jul 2024
 02:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716-topic-sm8650-upstream-fix-dispcc-v3-0-5bfd56c899da@linaro.org>
 <20240716-topic-sm8650-upstream-fix-dispcc-v3-2-5bfd56c899da@linaro.org>
 <dccttz5b44bl3lwmcaqz6wjx3n4sv3eq4yh6276vzwrtkcvqcw@qxhbo7bylnsg>
 <9ad10d92-d755-4fae-b206-6e8648be6d48@linaro.org> <CAA8EJpr9L+AKDhuHfQa=Nco7fvG9vLH3a+gxVhENrhz12b3n=Q@mail.gmail.com>
 <278354ec-532b-48de-8ee1-5477ddb4a285@linaro.org> <kxrhhb3vdojbnqfbwks2qmob55fwm3onleood73qfk6esl7g2c@q66kw5am4emc>
 <94e48e19-781e-4de3-a4e6-da8e923a1294@linaro.org> <CAA8EJpomVKiVrRxSEJmjvNXLGGKVvcr2wGWtE129eUoUfgYC4g@mail.gmail.com>
 <43d6523e-d6b7-4fda-92bb-a52fcad2fdba@linaro.org>
In-Reply-To: <43d6523e-d6b7-4fda-92bb-a52fcad2fdba@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 17 Jul 2024 12:57:14 +0300
Message-ID: <CAA8EJpoCCCAUv8PSDOEFoHhZZoEjCAOBGkhjpmrrYum=ejOvDQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clk: qcom: dispcc-sm8650: add missing
 CLK_SET_RATE_PARENT flag
To: neil.armstrong@linaro.org
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Jul 2024 at 12:53, <neil.armstrong@linaro.org> wrote:
>
> On 17/07/2024 11:49, Dmitry Baryshkov wrote:
> > On Wed, 17 Jul 2024 at 12:47, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >> On 16.07.2024 6:46 PM, Dmitry Baryshkov wrote:
> >>> On Tue, Jul 16, 2024 at 03:46:24PM GMT, neil.armstrong@linaro.org wrote:
> >>>> On 16/07/2024 15:44, Dmitry Baryshkov wrote:
> >>>>> On Tue, 16 Jul 2024 at 15:32, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>>>>>
> >>>>>> On 16/07/2024 13:20, Dmitry Baryshkov wrote:
> >>>>>>> On Tue, Jul 16, 2024 at 11:05:22AM GMT, Neil Armstrong wrote:
> >>>>>>>> Add the missing CLK_SET_RATE_PARENT for the byte0_div_clk_src
> >>>>>>>> and byte1_div_clk_src, the clock rate should propagate to
> >>>>>>>> the corresponding _clk_src.
> >>>>>>>>
> >>>>>>>> Fixes: 9e939f008338 ("clk: qcom: add the SM8650 Display Clock Controller driver")
> >>>>>>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>>>>>> ---
> >>>>>>>>     drivers/clk/qcom/dispcc-sm8650.c | 2 ++
> >>>>>>>>     1 file changed, 2 insertions(+)
> >>>>>>>
> >>>>>>> This doesn't seem correct, the byte1_div_clk_src is a divisor, so the
> >>>>>>> rate should not be propagated. Other platforms don't set this flag.
> >>>>>>>
> >>>>>>
> >>>>>> Why not ? the disp_cc_mdss_byte1_clk_src has CLK_SET_RATE_PARENT and a div_table,
> >>>>>> and we only pass DISP_CC_MDSS_BYTE1_CLK to the dsi controller.
> >>>>>
> >>>>> Yes, the driver sets byte_clk with the proper rate, then it sets
> >>>>> byte_intf_clk, which results in a proper divisor.
> >>>>> If we have CLK_SET_RATE_PARENT for byte1_div_clk_src, then setting
> >>>>> byte_intf_clk rate will also result in a rate change for the byte_clk
> >>>>> rate.
> >>>>>
> >>>>> Note, all other platforms don't set that flag for this reason (I think
> >>>>> I had to remove it during sm8450 development for this reason).
> >>>>>
> >>>>
> >>>> Ack, I think this deserves a comment explaining this, I'll add it.
> >>>
> >>> But where to place it? This applies to _all_ dispcc controllers.
> >>
> >> Commit message
> >
> > It is already committed.
> >
>
> The thing we keep adding new clock drivers based on previous ones that uses
> specific ops and flags with no documented reasons except in commit messages,
> but it's often buried into multiple cleanup changes.
>
> So at some point we should add simple comments before each special clock
> explaining what we're doing here, a good example is the clk_regmap_phy_mux_ops,
> where I had to dig into commit logs and understand why we handle it differently
> from downstream.

Yeah, regmap_phy_mux_ops is a nasty one.

Or the whole story about converting flags from vendor DT to upstream
driver code.

Probably it's worth specifying everything somewhere under
Documentation/. Or in drivers/clk/qcom/common.h  Or a wiki page
somewhere (though my preference is towards the in-kernel docs).

-- 
With best wishes
Dmitry

