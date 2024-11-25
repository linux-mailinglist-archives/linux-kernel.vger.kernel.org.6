Return-Path: <linux-kernel+bounces-421134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EFA9D87AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 407DEB33AF9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B394B1AE003;
	Mon, 25 Nov 2024 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uFLw37HD"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719419993F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 13:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542934; cv=none; b=GRvZJGJXHpFfZIsK63uJ7pbeA8VOmtSSSnLR2Rh3iCwsmHvhxo1xJYsa6IDLMecAXC1bJL2qlJsTBF6OWj1Eib+RMRFntOAhYp3Y+SYP2kRPvwWzZnq8Nr/KqLqV0+TpuFKAmdHhKtVHqEdzWzSiS/RqyV6kUeGgU7QYk/1aMuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542934; c=relaxed/simple;
	bh=c68pDtpQmnz8Qz1FkmFGGGSFTXaBKhvzAv9vwHt9tNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ3hcpx7Ibp71VNwZi1PuQnWEy6XamRzwmPu6CACV8uSzxoZCwO8Ia52YcHHhRaq31Hbx5Tkw2hPIBuBAtllLeeQ44+s5vbzbvkZN/IQDJruz1BrZIFdI/QjhlKXWECy35bPG2k3wOjnU7DaTfX8L0I0AcuLlytxA3Jd5M8GySo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uFLw37HD; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e38938a55e7so4011660276.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 05:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732542930; x=1733147730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7VmKDzCTkltKUjIPNueUVhqkcuFjEc3Za/mVfqbya8k=;
        b=uFLw37HDURWp/29GvX9l4cs3BlPD7CrxVjTZO17I5OgIjyT50wyOBKrBfu+XmaD8G9
         4iyYEaeLnRVGDUROg970SHq4SyLoaIkUHI1kPHAVTT5QxJ+T+Mycr5MpML78I+bGbRHf
         eo0w77SsJROYTwjxglvvsj2jBov4h4IRrVBrv+kP516rMASYnEtG+W/34Y1l7zE8hk+z
         H5rzE5ZWCOUYSP5uCaQg3cdfZcgQyBEmwft5zChiXk1T4Z1ryhBVNtGWmahKe3cOQUgi
         vpzV3ZQF+M9qJIop5LVFlxTiA88qx2cWqSHC3W9dxUiwcqxniTpCfOTrM1F6VXQNZIo1
         cbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732542930; x=1733147730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7VmKDzCTkltKUjIPNueUVhqkcuFjEc3Za/mVfqbya8k=;
        b=g86fklZDM8jsE/2dZJAfOtbCoJVvnHWu6Qf7PwSsaojN5maCCwon9tEK8voHR54/1k
         1h4vmsfD3+oHyQ743NClGuDvPFbyfFiU79ZnycMIhQFA5pHlsizcZJmHpdQNPDAquSOS
         /iF3Okk1mSbf1csb8L1mZTlH1RRyEJQNYjKsKjOZdjBZFRg2F/R6y5y59214VNqG5Rna
         vsXkQbLcjQD4TDowFGrxDS4h2voLZLeeUlv8tGKvyEFpQgeisGl7cP3cCtGi7/RWKu83
         OuFl+kNbf2jNUAU4eqsuy+bYX6zftK9JSw6+ROhSxFWVGPKz7Gwq86M7PhQCMN523ie3
         39jw==
X-Forwarded-Encrypted: i=1; AJvYcCVr/NcWGwjzAZvDU4sEHoZMu5D0qCRg/8rgUGxi9nmiDH3XQgzQPApn2H9fNez5jMxo37rf/kLM3zy38Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYwV4EW9K7sthFampA9WtcQiWK0m/rXNU0I95WEuMCEAM+F5i
	yn88LApJdrJ6/6NVmlhTeD6ztHCYV08fktGHcPkSfG+C8a2b0uUSsiemEisqjQQvOdDQiKfuQCq
	1YXpW9jZpnGFJrzCwBPwAiUxQe2ZB//XA+BTet+ZL7SwGWzFbCUg=
X-Gm-Gg: ASbGnctpz4ggVsdrn+qz2Ffbxo/v3m3L4pRCk1lBnLNBZLKL3nu5jUFIcNgmj1AO95/
	AyfW4TABv900yvhoeXkKpT/hKmKou5O7FFqGuqW5qyvinj1Do9yaTyE4GpmqMK5o=
X-Google-Smtp-Source: AGHT+IGhYldzrLXU1z5DyslvotkWdyomSc+OiyQ5LS6CzUSESd40sDqPgmBZIVdsFWN82ZsZOAGDbACG04OQXC2VNAY=
X-Received: by 2002:a05:6902:2292:b0:e30:d289:49d2 with SMTP id
 3f1490d57ef6-e38f8b1f688mr11832723276.17.1732542930263; Mon, 25 Nov 2024
 05:55:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
 <20241122-switch_gdsc_mode-v1-1-365f097ecbb0@quicinc.com> <zhco37pigrp4fh5alqx4xfxx3xhjitqlgw552vwiijka22bt4u@sl4ngzypwh4x>
 <1d9aa2e7-d402-42dc-baa6-155f01b132ca@quicinc.com> <23ho25gl3iwyi2jspb6a2x5bv76fco5pkg2x5ct4gu3c44dbiq@yec6evx5sihm>
 <eec92088-edfb-4d0c-b81d-9d4f1d968b20@linaro.org> <b411489f9f2441f7a0f936127678e36b@quicinc.com>
In-Reply-To: <b411489f9f2441f7a0f936127678e36b@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 25 Nov 2024 15:55:19 +0200
Message-ID: <CAA8EJpqYSujKXPFkdWcqRpOKZ+dJHQDkYM33Mt5JxuA=Mfs+WQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: qcom: videocc: Use HW_CTRL_TRIGGER flag for
 video GDSC's
To: "Renjiang Han (QUIC)" <quic_renjiang@quicinc.com>
Cc: "bryan.odonoghue@linaro.org" <bryan.odonoghue@linaro.org>, "Taniya Das (QUIC)" <quic_tdas@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	"Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Nov 2024 at 07:31, Renjiang Han (QUIC)
<quic_renjiang@quicinc.com> wrote:
> On Saturday, November 23, 2024 8:17 AM, Bryan O'Donoghue wrote:
> > On 23/11/2024 00:05, Dmitry Baryshkov wrote:
> > > This leaves sm7150, sm8150 and sm8450 untouched. Don't they also need
> > > to use HW_CTRL_TRIGGER?
>
> > I believe the correct list here is anything that is HFI_VERSION_4XX in
>
> > You can't apply the second patch in this series without ensuring the clock controllers for sdm845 and sm7180
>
> > grep HFI_VERSION_4XX drivers/media/platform/qcom/venus/core.c
>
> > drivers/clk/qcom/videocc-sdm845.c
> > drivers/clk/qcom/videocc-sc7180.c
>
> > Hmm.. that's what this patch does, to be fair my other email was flippant.
>
> > This is fine in general, once we can get some Tested-by: for it.
>
> > That's my question - what platforms has this change been tested on ?
>
> > I can do sdm845 but, we'll need to find someone with 7180 to verify IMO.
>
> Thanks for your comment. We have run video case with these two patches on sc7180. The result is fine.

A single case, a thorough tests, a mixture of suspend&resume while
playing video cases?

Also, can I please reiterate my question: sm7150, sm8150 and sm8450 ?
Should they also be changed to use HW_CTRL_TRIGGER?
Next question, sdm660, msm8996, msm8998: do they support HW_CTRL_TRIGGER?

-- 
With best wishes
Dmitry

