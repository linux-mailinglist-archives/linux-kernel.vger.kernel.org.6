Return-Path: <linux-kernel+bounces-341944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E09888AB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 18:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 232001F235EE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 16:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D15A1C1725;
	Fri, 27 Sep 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwq9bjBy"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EAC200A3
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727452946; cv=none; b=InSDTXG63/vZGb0zmZdk/3W79Eew7ZmAe9sgCDXldgCqb2BtIHJcZ6dFS6zxPh3MW3J1yWr4rLKihdtiAuxNkwdFYPF1Z2a2yyjzrSLITKpJIRhK62JUm6fJWZ3fZNS/9McpygGnKRxKA94KI55fdx2zCuc6V5XOeO++ag9Xod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727452946; c=relaxed/simple;
	bh=j8EKtiti6A+WnBNT10RaewPAngTEUNXpu20Lyhq973s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbFrb4f8OA7cbWDXaGN96hUa2TndMlKa/I8WDx1DFdZNzPV6lcpwixowswyoBdn5nh5Se3QGWSPJ8L5n6Urp6Owxa4czUbZSmokEHfgSiPb1ruqjDgmWvN4zTvxEu2yxl4XlUhvbxzzMCo4eB3RLPtoeRSE0WnUepROkCA2hMiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rwq9bjBy; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dbbe7e51bbso19532557b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727452944; x=1728057744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGIro/Gw+pG6C+1E3sPWUSd5s24w2G8NI6gHk8UMPKw=;
        b=rwq9bjByPwFN22KNJJR8pzRG4aSSA35BrjNnERmKZ4ATj1aTUWPPpiANEoCHdkPogW
         8wJOK6BBNLGDLLrUk1gKYRpRmpTF3yD4TDu58k3m+jsfRcjIAuHJ4C6EHIrmcXotNZKX
         q0KPxWUeUJUnW04dgzj3OW+f7ZM5qeIaJ7t7f+QK0QKjJTFFmyIcklOGOE3TTzfccTr1
         VUqha4gscggkvPgVOKCB/x63uLCc4QVg9e2oX8kp8kliBBYQMu8B1qM8m+NQWlEd2aFG
         Z+wYtPQZkYPVOGeDxZ1EbQgVknSEUn1lJUu9ae7Hx2hve2SQ6yqRglYsX6YLAHbghS5x
         M8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727452944; x=1728057744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGIro/Gw+pG6C+1E3sPWUSd5s24w2G8NI6gHk8UMPKw=;
        b=dKM9mE0ScpzxWn4RjvtOMIGCxuSUmg+0qFAceW/hO7kk5S3vcUoXUqmBwWPKjr/S0B
         al8iaHEXPUtvUGMZpRxgP4tzzkwiqmhhc5RrzOkIJQLkYoVIOR9FRSfCoCJ6xHYMOiom
         me1YJNJBgHMatnh4OLUim9eitkiaOIoJNFAr541oTAxHzxU7SWRl1wINbfMkbuY+lvw3
         SgSEdfTQQkCzDLclPjS1ZDDACfMqN7sGROmw12ELLeUgVd7vzR1yhlBfsoITsCBZQreO
         9fr5seyZmvtQY4qwWKWPc5iJ1saYeCcxruPU06W4focvoh04IuM8ynW0tNGDxmOh38jA
         qM4g==
X-Forwarded-Encrypted: i=1; AJvYcCXYFqB2udDMZSWfoNN+WcMcU+zYlcawwxfC+7Jq+103mHn2sZ7j20JRqQ36/blA8gzlOwYkIGuvihtJn1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKGH5gUbMHiVcI8F2OhvwZJhH83cmxQiUHekBfFs2krkMohvlJ
	RrRSO2VAioUZvDFlOzYmfqZm9Kk45Vw3x6XReDDU1rEEWqPz27b2VSY3FEq+//1u88/oLV9wqB+
	hjpGxvkEV5MPrylMI4yI1xYm+VNNhLA03LDncJA==
X-Google-Smtp-Source: AGHT+IFKb/vMmnggV56geE4/LB9PLjbBe1DnuIle3XzTmcqytPrRsrd/oj6ZHjXqBbLDkzsVtWhd/O27c6gwZgRbuEk=
X-Received: by 2002:a05:690c:f0e:b0:6dd:c768:e58c with SMTP id
 00721157ae682-6e2473b6783mr34335307b3.0.1727452944048; Fri, 27 Sep 2024
 09:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628-dpu-msm8953-msm8996-v1-0-a31c77248db7@mainlining.org>
 <zeek3j7skstysho5bduxn23xipz3fpqsfwggue66dlyozhepnn@4wnnd7q6xf22> <05c1f93940c38087e8d245d2b6bf90e0@mainlining.org>
In-Reply-To: <05c1f93940c38087e8d245d2b6bf90e0@mainlining.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 27 Sep 2024 18:02:13 +0200
Message-ID: <CAA8EJpr0C-gXDoJsStTxJzCMEkbZaPeEAcBES3GqZp1FcKb=4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add MSM8996/MSM8953 dpu catalog
To: barnabas.czeman@mainlining.org
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@somainline.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Sept 2024 at 17:39, <barnabas.czeman@mainlining.org> wrote:
>
> On 2024-08-01 21:25, Dmitry Baryshkov wrote:
> > On Fri, Jun 28, 2024 at 04:39:38PM GMT, Barnab=C3=A1s Cz=C3=A9m=C3=A1n =
wrote:
> >> This patch series add dpu support for MSM8996/MSM8953 devices.
> >>
> >> Note, by default these platforms are still handled by the MDP5 driver
> >> unless the `msm.prefer_mdp5=3Dfalse' parameter is provided.
> >
> > Could you please provide a summary of features actually tested with the
> > DPU driver? Have you tested YUV output? Have you tested RGB planes?
> I have checked all planes they are working fine.
>
> > Which LMs have you tested?
> I have done some more testing and msm8953 LMs are fine but i have found
> out
> on msmm8996 LM_3 and LM_4 is not working as i see in downstream sde code
> they are not exists.
> This kind of messages i got for LM_3 and LM_4
> [   34.751091] [drm:_dpu_rm_make_reservation] [dpu error]unable to find
> appropriate mixers
> [   34.751112] [drm:dpu_rm_reserve] [dpu error]failed to reserve hw
> resources: -119

I think LM_3 / LM_4 are WB-only, but I didn't have time to check that.
Maybe it's easier to omit them for now.

I hope to get back to those platforms during the forthcoming or the
next development cycle, after (hopefully) finishing the HDMI
conversion story.

--=20
With best wishes
Dmitry

