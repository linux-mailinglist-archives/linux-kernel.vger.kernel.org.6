Return-Path: <linux-kernel+bounces-360635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B5F999D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990CB1F245AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D279E209F28;
	Fri, 11 Oct 2024 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0x1e1kR"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95022209670
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728630743; cv=none; b=NOX+BwZL/2GFLSaMXrp0ey2iS5Qg7J/drYR0uKVsu7Bc667rr2K2dENjUwA1ILe1CG1xPui7MIz3ffPOKkVgcfsHA6XoLwDTXZehQiK6MCUtz52FSqAukK2fzmH69CBVLOh2RObn54d4hwjY8hsGQOZgpllvPRfSbb4tkJqDRSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728630743; c=relaxed/simple;
	bh=3AVJyo12Ve+6A82IWaIO7NadBi/9RQgmTTK+0kxZyzQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DURNTOTTV/JFD8Lx45D0XfokVI8uYFDmbeCmcs1PDvXfx0yQZTXLqF3f5ZfMvOwgz1rYiyv9IUGuD9sQiUAcBjHpkhokhmHr4Bsk1s+HyrSQwDfqCQS7Z1JmxFAdvH+DPwGLLWUbi+rm9y1+M9wbBtLhRvDEijYcpZs5aVAYBfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0x1e1kR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e291f1d659aso260336276.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728630740; x=1729235540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xgcOrkc/CHV46Z1pT/xJregzk7daXRNi2aeBdgcogtY=;
        b=C0x1e1kRBMeEIeqy5EKNJygKDGvOUOyzkLf094qWeZcpFv1WyRMh6YdrYEhNz5Uy3/
         GHPCHsZgSAMjUxv5bd2pBUGq+a/Siri/RhtMqLdOo6z9mAZld6SS6qYtPuz9PIMOYyBl
         P9jAAigFqxPXWSBXw3cHHvB3o2Vhi1o2iN5kl0vzSx8XMpJEJmqdSHfXD9yyjHuBnlkX
         23NQf/2sXKtUy83RfZQv1SyZUiDHSnZQjjh5I/qNQ1JMYcje8nvmwbvFzZpLy01fQUe4
         llxSSmF4XWpmOxncgBMQQ8G2mDrZH6u7+DM5Kud57DBT8IpoePC5pMV47TG5lzZfNQPi
         BhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728630740; x=1729235540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgcOrkc/CHV46Z1pT/xJregzk7daXRNi2aeBdgcogtY=;
        b=r6iVWtOdrRPWEmQ85TXeBmiF/W7OI231S3VTiIflwUzzyZFBF5cIkH1cGZKsfJPmyE
         POaEz0OXYaSgy7g+2L3CnSIBH+ndUo+nUS2hgNwMZWPXcvcTs5TLv1syAQF/PF3uhWm1
         kNr4XhNRG0Mva4dTNkd/7Qos8xqmP/tYi9lvBz8lODHSMm0+EAhPOO4xWeldF+IZvWRr
         u0+cMWKQLGlaNXumZiOB0Uvptvv6bBXrDlbVi39HQqkzv7eoAGBFC+IC0jdpymHPcdoI
         s6M1EivpsVRsEsy+m8moGXQ3LGccGCG5KpwYLG2HoJ+yOVYrfPUByWcwYZ3rgwF6oQJC
         fH7g==
X-Forwarded-Encrypted: i=1; AJvYcCVpXpxcp8/Ub9zqRmrBEqizWV+IaWwA5ir9hHNV7nw6IcWc57cw9B5hcQV01LMjA/UOwhqvXPCp3r6hlYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvO6XeT0/gYR6j5ovP6REDUNI/gDpxgJX3A3v+9uvyjuKSdZc+
	XmBngD6z3HF1rt1CdkfkrQI06zUEQYeMhEDfRgu+nenVizolbmIXKb9iDa71AWkX03IZoeuvN31
	29fizX0rKALJOlH96sbcrhZ3yhhI+T5rvK4h0Sw==
X-Google-Smtp-Source: AGHT+IHQG8l6UHRzN1wsbVY4M2CWkOHXKbtAOXGSyOLlWLYYXf/uM9zypwkfp44BmhMWcJT07IKvd5b7H8NXWT6tyMc=
X-Received: by 2002:a05:690c:660b:b0:6e3:1537:3d54 with SMTP id
 00721157ae682-6e347c8dda1mr9701717b3.45.1728630740667; Fri, 11 Oct 2024
 00:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004212359.2263502-1-quic_mojha@quicinc.com>
 <20241004212359.2263502-7-quic_mojha@quicinc.com> <9eb910d4-e521-4c14-8e73-8fd3d5ff9573@linaro.org>
 <ZwP1t45ni/gk754B@hu-mojha-hyd.qualcomm.com> <ZwTPghV36CSIpkE4@hu-mojha-hyd.qualcomm.com>
 <dfe46653-5243-47c8-8de9-17a38d13da53@linaro.org> <20241011050518.GJ1421305@hu-shashim-hyd.qualcomm.com>
 <rbek5diyuwhquhbhk6pukzv474xug3pupcqqc2svrceyodvem5@obah2ahgmcox> <20241011070907.GK1421305@hu-shashim-hyd.qualcomm.com>
In-Reply-To: <20241011070907.GK1421305@hu-shashim-hyd.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 11 Oct 2024 10:12:09 +0300
Message-ID: <CAA8EJpr7KmTXv8WyxuhAprHoPku_YCt0fz74gd+44OeOT0uKqg@mail.gmail.com>
Subject: Re: [PATCH 6/6] remoteproc: qcom: Enable map/unmap and SHM bridge support
To: Shiraz Hashim <quic_shashim@quicinc.com>
Cc: neil.armstrong@linaro.org, Mukesh Ojha <quic_mojha@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 11 Oct 2024 at 10:09, Shiraz Hashim <quic_shashim@quicinc.com> wrote:
>
> On Fri, Oct 11, 2024 at 09:23:05AM +0300, Dmitry Baryshkov wrote:
> > On Fri, Oct 11, 2024 at 10:35:18AM GMT, Shiraz Hashim wrote:
> > > On Thu, Oct 10, 2024 at 08:57:56AM +0200, neil.armstrong@linaro.org wrote:
> > > > On 08/10/2024 08:21, Mukesh Ojha wrote:
> > > > > On Mon, Oct 07, 2024 at 08:22:39PM +0530, Mukesh Ojha wrote:
> > > > > > On Mon, Oct 07, 2024 at 10:05:08AM +0200, neil.armstrong@linaro.org wrote:
> > > > > > > On 04/10/2024 23:23, Mukesh Ojha wrote:
> > > > > > > > For Qualcomm SoCs runnning with Qualcomm EL2 hypervisor(QHEE), IOMMU
> > > > > > > > translation for remote processors is managed by QHEE and if the same SoC
> > > > > > > > run under KVM, remoteproc carveout and devmem region should be IOMMU
> > > > > > > > mapped from Linux PAS driver before remoteproc is brought up and
> > > > > > > > unmapped once it is tear down and apart from this, SHM bridge also need
> > > > > > > > to set up to enable memory protection on both remoteproc meta data
> > > > > > > > memory as well as for the carveout region.
> > > > > > > >
> > > > > > > > Enable the support required to run Qualcomm remoteprocs on non-QHEE
> > > > > > > > hypervisors.
> > > > > > > >
> > > > > > > > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > > > > > > > ---
> > > > > > > >    drivers/remoteproc/qcom_q6v5_pas.c | 41 +++++++++++++++++++++++++++++-
> > > > > > > >    1 file changed, 40 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> > > > > > > > index ac339145e072..13bd13f1b989 100644
> > > > > > > > --- a/drivers/remoteproc/qcom_q6v5_pas.c
> > > > > > > > +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> > >
> > > <snip>
> > >
> > > > > > > > +         struct of_phandle_args args;
> > > > > > > > +
> > > > > > > > +         ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus", "#iommu-cells", 0, &args);
> > > > > > > > +         if (ret < 0)
> > > > > > > > +                 return ret;
> > > > > > > > +
> > > > > > > > +         rproc->has_iommu = true;
> > > > > > > > +         adsp->sid = args.args[0];
> > > > > > > > +         of_node_put(args.np);
> > > > > > > > +         ret = adsp_devmem_init(adsp);
> > > > > > > > +         if (ret)
> > > > > > > > +                 return ret;
> > > > > > >
> > > > > > > Why don't you get this table from the firmware like presumably
> > > > > > > QHEE does ?
> > > > > >
> > > > > > Well, AFAIK, QHEE(EL2) has this information statically present
> > > > > > and does not get it from anywhere., but will confirm this
> > > > > > twice..
> > > > >
> > > > > Double confirmed, device memory region required by remoteproc is
> > > > > statically present with QHEE.
> > > >
> > > > Right, in this case why those tables can't be embedded in the elf
> > > > .resource_table like it's done with qcom_q6v5_adsp.c by calling
> > > > rproc_elf_load_rsc_table() and let the remoteproc framework load the
> > > > resource table and setup the devmem ssmu_map ?
> > >
> > > Mainly for two reasons -
> > >
> > > firmware images on platforms where we like to bring additional no-qhee
> > > support do not have resource table.
> > >
> > > QCOM PAS implementation for secure remoteproc supports single TZ call
> > > of auth_and_rest that authenticates and brings remoteproc out of
> > > reset. And we don't have provision to authenticate resource table
> > > before it is used for devmem/iommu setup.
> >
> > So normally TZ / QHEE have the platform-specific resource table? Isn't
> > it tied to the firmware binary?
>
> Yes this table is with QHEE and not firmware binary. Now with no-qhee
> case, this patch series is proposing to get it from device tree.

If it is platform-specific (rather than being device-specific), then
it should go to the driver, not the DT.

-- 
With best wishes
Dmitry

