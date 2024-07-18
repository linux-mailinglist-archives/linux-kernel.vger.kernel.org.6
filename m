Return-Path: <linux-kernel+bounces-256446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F79934E99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594231F225B1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104EE13FD84;
	Thu, 18 Jul 2024 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OfHdyYKq"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D913DDCE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310969; cv=none; b=FssTEYjtLIUmvuU+Qm0efmYM5Xte6ZB9I6KNj+050dqZ8KfOxJjvpKtphIbTDD2NPi/2/aC+OYZX6YRh5vrOg+nGgs9XaiUOM4S7iRDkmceHkWZ7zi6NUj7nM02xrnUh+jDW5kSA+B8AnTnEhD47CECsC6XcwYEGQYEKZU/MfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310969; c=relaxed/simple;
	bh=kiAtcefpFbn8MafkCqnU2MkhxG+KwWmc6iZ6+xlp1nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jDANaSEcG5ywxsnl6i2S2zhG2DPqCctksJV4Ux0mnjk8F2jsKxSLGfU2tgu3+Z016kvtGWP6YRcutF5vy92owazpiIlwhrta9mzTikcN40YcdM0QN0GmWoj00cLjvUahIN5VT1QPjEfPkjJQEADs7xmaOTSuEsUUnEzrVassvR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OfHdyYKq; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-825a23c5e4cso55818241.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721310965; x=1721915765; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hjaqbuLagF0JEEpk29ZLJev6JqAlNKRQML8PETlv7eA=;
        b=OfHdyYKq7o7lqK/nLHAGVDdXH7M/OJqFFzo98Lzrur11bYi1qyKa3Xo6F53GQSqIOn
         1gljjfKi3GOXIgdzqofKIcp8MF2SadnUZurJU3ca1VCfVtfzLrHS4n0JTW5c6yDfY/CR
         Mxn7Cw4NMJalariRzZ+ILcOMTKIKsk4sv3ETDHrbHq38e7dFij/t3yis33JPIkILRfv4
         f+9NnDNebTXY/HiHMvYvD6XjVT8+S2li4WETnunAhB+UaTqGteMv4MSXZx4EqC9VuETi
         1MoL8z9iUXOeCxVrrYDVQEbxXuSxn7fl1ggOFQ9RQp/86UBbZpoul0rvPfQ7J8c5joLj
         pQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721310965; x=1721915765;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjaqbuLagF0JEEpk29ZLJev6JqAlNKRQML8PETlv7eA=;
        b=fNH4VsX0vlQm20vc71Q/CwDzTCrUn8JR+KeIyC70lgBFdVU5EaYIfvQQKU4X9lTc6Q
         EQicZUgW4q4UN4/qQ+KVX55qaXvYcy/0HGg/dsctYP7R9a/4N8LXyc8xq1c9TRk1HCrm
         +XwWzazRyKfaWeBR/jiklAlY9ypAvxZ4KsbnDGQwtzfnqzurITflhihOHHl+Vq7axeQf
         ctGw1QCpzvUN/n+PXz9umwb0XyHAO3+bya41TobFc8+nZarSelYalf6G5DmEQgSz+hjZ
         dbVd7aUGeNYgjPXFbEzODVHY2DRBOwjHet1tEDntUdu5kWuRFajsHioXv+Bd5i78c6H8
         2yPA==
X-Forwarded-Encrypted: i=1; AJvYcCXCDZxAab/PaLW811X3vfeISPAk3gATquHHjbc4chDpaEhUj0YxodfkT/8IqWbtYD392nJZaR5d39JEo+zboKyMDl9XTdHEK269/irH
X-Gm-Message-State: AOJu0Yx9CZ5E0YydGUufPe2sEVyz0g3QauCtj1QQKyTIhi9a+i100wBc
	LzXfj/Gmo1yiv4U0OeRmTByNWr/BR1Ujp7oLX3+lKpT0ABRcHPtmpFGgt9ANR43O7Iw1aw2EmxQ
	eAnDY2q+1vUSU/Zke5aLaJG7YArlTWMNWwyeKeg==
X-Google-Smtp-Source: AGHT+IEBao5ItMP4QyT2LAfmrmibbMJ/4flzNcciYnrIbz6h5/cn5rBOA5b/EI/enk/7jAbX+4iFkPp6JDuYiX+Ou7I=
X-Received: by 2002:a05:6102:2b83:b0:48c:44c4:75bb with SMTP id
 ada2fe7eead31-491598fda1bmr5399521137.21.1721310964320; Thu, 18 Jul 2024
 06:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718125545.2238857-1-amit.pundir@linaro.org> <qitt2j5hw6pax7yekdooutxebhkznhdv3aafnhkysr5fjcbmd7@xqbp7h3ld4gs>
In-Reply-To: <qitt2j5hw6pax7yekdooutxebhkznhdv3aafnhkysr5fjcbmd7@xqbp7h3ld4gs>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Thu, 18 Jul 2024 19:25:28 +0530
Message-ID: <CAMi1Hd1wzvzStEv2zoNocvYBkJDis27vzCDcBtMruQQ5TdOkDw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-hdk: add the Wifi node
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dt <devicetree@vger.kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 18:36, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, Jul 18, 2024 at 06:25:45PM GMT, Amit Pundir wrote:
> > Describe the ath12k WLAN on-board the WCN7850 module present on the
> > board.
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> > v2: Changes suggested by Neil
>
> Which changes?

Neil suggested a few changes to enable 'bt-enable-gpios' in
sm8550-hdk, now that the hci_qca driver uses the power sequencer for
wcn7850 https://lore.kernel.org/lkml/d3416be5-b97f-4db6-a779-9c436e41dd72@linaro.org/

Similar to this sm8650-qrd change
https://lore.kernel.org/all/20240709-hci_qca_refactor-v3-6-5f48ca001fed@linaro.org/

>
> >
> > v1: Kanged verbatim from 490812872449 ("arm64: dts: qcom: sm8550-qrd: add the Wifi node").
> > Link: https://lore.kernel.org/lkml/20240702091655.278974-1-amit.pundir@linaro.org/T/#u
> >
> >  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 113 +++++++++++++++++++++---
> >  1 file changed, 101 insertions(+), 12 deletions(-)
> >
>
>
> --
> With best wishes
> Dmitry

