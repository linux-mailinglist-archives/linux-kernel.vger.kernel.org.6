Return-Path: <linux-kernel+bounces-252389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7A93127E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D0B22917
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46B188CC3;
	Mon, 15 Jul 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gLXeLnOL"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F48188CAA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040201; cv=none; b=RPs9WncGKdA9+9Uri7RC+3SmcfOmwVAtK11ahaZwF9jlBAYBgOBWKSPgZN/LG/zhjzHEfTmu7OstPHAE5ow05Do0kTUFnQ0tE4DvePI9orXBrVbNOwxbJk+ilLKKpqbwYjGUf8qcH0cX2wlASA3+9Oj0XJn7a85OVNmGOEjhvKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040201; c=relaxed/simple;
	bh=0K4pca2vEBWU5NYBgV2Z87t7JJCI7Bs/YEhYZaDDJv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TijoAEvCauqqz6x/9q7WYhf25787H+r5vhB91MEUVefYXCfYcmNZ9XwRxy73vJRqhUyFJEPI/nJUyJD9EdtVudCs4804cYtmFMiJWG+gcLLu7mWRVZUIMuAHsCPTcle6aF63Cwk5gbMptOoz9WwHCu/B5vocx3yCENkd345Mf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gLXeLnOL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03a17a50a9so4211167276.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721040198; x=1721644998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aMIZ4x5GWNB/IuXvoPEkpFndIdHvoqjyuE6tlVNLnc8=;
        b=gLXeLnOLaOXFsWY9avX6P9S9zZrzdKkfrUb0nWUN8rqy5drcoVus6kXglfyAmI77qU
         AynI1cv2g3XDUcStuiYu1M1auSk9t5OpxnYfFdgJUfQXt6JalrZxY7lbvYiaEowStaLT
         w4RPuF9Pq47ToLVZ96ptiBmvZKS5JmAcbC5bSL1DTvZk0OKMUCZ9XJeP336a0zWbnBWO
         8WF0RrBdw8xZgeXj7wzg4s1Kt2hj3L0wC5eR2zim1OGROVsbf5hzW84wJdGHZg/Orqsp
         XjsOcooDvdrki/o5ZXxnUu7Kd1b+kuHgkwUjWWkaJmFmZiFxoGVzGbDg8y2mbL+XB632
         chjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721040198; x=1721644998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMIZ4x5GWNB/IuXvoPEkpFndIdHvoqjyuE6tlVNLnc8=;
        b=WQznM7NBXPEAn2xo4iolhklxLlH48AXNfsDBBRlMhXb2bHxODT7pwbD5g91hQO+Sbk
         QSM3sAJo8rv8BFIbR/E6CulmhLZcEOZzqnN+j+gmWMi+VMmXX2Lk2J81GpwPh8uGeCIv
         jj4yBM79XO9HnFBV+tPcIXJT529YwDvVIEoeM0SZ9USNunP/SXCEtW0T7wi+3Nrm1arR
         kBdTzgjJGqVDMb2Swxs6lr874KqevAKjkVdgs7fBnkqZdWlDoe82MAk10OC7qh6S8Vqo
         sEl6MrjnT872CKlIBt2z8+6IFYNDU/HRbR3AFP/wNEQem/gWmZUBUFTNC7Kejn3Xq1kL
         d/Qw==
X-Forwarded-Encrypted: i=1; AJvYcCW7LLzOREYFfp5Hdf4DPf+iD9edJG2jtiLGlerHOEV3FpIh+9QmpZ5uO8+RARvYW54eVQNZBj4iJ9TEY1+Ra8KcrmcQNN3zbqqJErog
X-Gm-Message-State: AOJu0YxXr3W9QqDxsdq1D5IGVCCMDeu1NfDqbCm9dHEv9Uc1KsJSkh/A
	Pi0vUALDCN7YJ/NAOSwdZgDEvEDWM1Z5cP6hJpEXiYg55zeltFnjEDn9UlRTtB/9n7/GdnZo06M
	twEaByIRhwEQgnM3gL53vIhZ7jjE5twq9CY34Hw==
X-Google-Smtp-Source: AGHT+IEdJmxITor4+DP0cXXm+G3r7fPKDye0hwA/RbHrnncDjlEqNpYlw08Ebcg/221VFbFOphKo44hUUhrhArDY/qc=
X-Received: by 2002:a25:84c7:0:b0:dff:1b37:8215 with SMTP id
 3f1490d57ef6-e041b07a0dbmr20274956276.36.1721040198288; Mon, 15 Jul 2024
 03:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709015818.110384-1-slark_xiao@163.com> <dduv77mdqe633m7amyljhqas7nomrtjrrimvmyqidymy3qjvfa@biepierrz5p3>
 <17f0f426.4faf.190b4edaadd.Coremail.slark_xiao@163.com> <CAA8EJpoiOLYMhxyJbdrgnMVfVggL9cOWtX8L__YKd=RPQWOcSg@mail.gmail.com>
 <7036d57d.5904.190b512d00b.Coremail.slark_xiao@163.com>
In-Reply-To: <7036d57d.5904.190b512d00b.Coremail.slark_xiao@163.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 15 Jul 2024 13:43:07 +0300
Message-ID: <CAA8EJprd8pqnw_jVd2u_Sdf1L=SPY3tYojHtN_de672F0vN7UQ@mail.gmail.com>
Subject: Re: Re: Re: [PATCH] bus: mhi: host: Add firehose support for Foxconn SDX24/SDX55/SDX65
To: Slark Xiao <slark_xiao@163.com>
Cc: manivannan.sadhasivam@linaro.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 09:27, Slark Xiao <slark_xiao@163.com> wrote:
>
>
> At 2024-07-15 14:16:57, "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> wrote:
> >On Mon, 15 Jul 2024 at 08:46, Slark Xiao <slark_xiao@163.com> wrote:
> >>
> >>
> >> At 2024-07-13 23:09:47, "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org> wrote:
> >> >On Tue, Jul 09, 2024 at 09:58:18AM GMT, Slark Xiao wrote:
> >> >> Since we implement the FIREHOSE channel support in foxconn mhi
> >> >> channels, that means each product which use this channel config
> >> >> would support FIREHOSE. But according to the trigger_edl feature,
> >> >> we need to enable it by adding '.edl_trigger = true' in device
> >> >> info struct.
> >> >> Also, we update all edl image path from 'qcom' to 'fox' in case of
> >> >> conflicting with other vendors.
> >> >
> >> >Separate patches please. Also don't use "we", just an imerative style:
> >> >do this and that.
> >> >
> >>
> >> Do you mean use 2 patches (1 for enabling trigger edl and 1 for
> >> modifying path)? Though these changes are aimed to make
> >> firehose download successfully.
> >
> >Yes. "Do this. Also do that" is usually a sign that the patch should be split.
>
> Will do a update in next version.
>
> >
> >>
> >> >>
> >> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> >> ---
> >> >>  drivers/bus/mhi/host/pci_generic.c | 20 ++++++++++++++------
> >> >>  1 file changed, 14 insertions(+), 6 deletions(-)
> >> >>
> >> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >> >> index 14a11880bcea..440609b81e57 100644
> >> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> >> @@ -433,8 +433,8 @@ static const struct mhi_controller_config modem_foxconn_sdx72_config = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> >> >>      .name = "foxconn-sdx55",
> >> >> -    .fw = "qcom/sdx55m/sbl1.mbn",
> >> >> -    .edl = "qcom/sdx55m/edl.mbn",
> >> >> +    .edl = "fox/sdx55m/prog_firehose_sdx55.mbn",
> >> >
> >> >qcom/sdx55m/foxconn/prog_firehose_sdx55.mbn
> >>
> >> what's your opinion?Mani
> >>
> >> >
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> @@ -444,8 +444,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
> >> >>      .name = "foxconn-t99w175",
> >> >> -    .fw = "qcom/sdx55m/sbl1.mbn",
> >> >> -    .edl = "qcom/sdx55m/edl.mbn",
> >> >> +    .edl = "fox/sdx55m/prog_firehose_sdx55.mbn",
> >> >
> >> >Is it the same file as the one mentioned in the previous chunk or is it
> >> >different?
> >> >
> >>
> >> They are same for same chip, though we have some variants.
> >
> >Please excuse me, I can't fully understand. So are the files the same or not?
> >
> >There is a simple mental experiment regarding the file names: you
> >should be able to have a single host rootfs, which supports working
> >with all of your modems at the same time, without modifications.
> >So if modem A and modem B might use file foo.bar and the file is the
> >same for all SDX55 modems, it's fine to have it in qcom/sdx55m/ or in
> >qcom/sdx55m/foxconn. If it is different depending on the end-device,
> >it should go to the qcom/sdx55m/foxconn/devname/ .
> >
> For all Foxconn devices designed based on same chip, they can use same
> edl file. This EDL file is a common image of whole FIREHOSE image package
> of difference variants. The difference of Foxconn SDX55 modem A and
> Foxconn SDX55 modem B is APPS image and Modem image. The EDL
> image is a file for putting device into EDL mode.
> So I prefer to use "qcom/sdx55m/foxconn" since Foxconn's device are
> different with other vendors which provide sdx55 devices as well.

If it's common, sounds good to me.

>
> >>
> >> >If they are different, then, please,
> >> >
> >> >qcom/sdx55m/foxconn/t99w175/prog_firehose_sdx55.mbn
> >> >
> >> >
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> @@ -455,8 +455,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
> >> >>      .name = "foxconn-dw5930e",
> >> >> -    .fw = "qcom/sdx55m/sbl1.mbn",
> >> >> -    .edl = "qcom/sdx55m/edl.mbn",
> >> >> +    .edl = "fox/sdx55m/prog_firehose_sdx55.mbn",
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> @@ -466,6 +466,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
> >> >>      .name = "foxconn-t99w368",
> >> >> +    .edl = "fox/sdx65m/prog_firehose_lite.elf",
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> @@ -475,6 +477,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
> >> >>      .name = "foxconn-t99w373",
> >> >> +    .edl = "fox/sdx65m/prog_firehose_lite.elf",
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> @@ -484,6 +488,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
> >> >>      .name = "foxconn-t99w510",
> >> >> +    .edl = "fox/sdx24m/prog_firehose_sdx24.mbn",
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> @@ -493,6 +499,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
> >> >>
> >> >>  static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
> >> >>      .name = "foxconn-dw5932e",
> >> >> +    .edl = "fox/sdx65m/prog_firehose_lite.elf",
> >> >> +    .edl_trigger = true,
> >> >>      .config = &modem_foxconn_sdx55_config,
> >> >>      .bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> >> >>      .dma_data_width = 32,
> >> >> --
> >> >> 2.25.1
> >> >>
> >> >
> >> >--
> >> >With best wishes
> >> >Dmitry
> >
> >
> >
> >--
> >With best wishes
> >Dmitry



-- 
With best wishes
Dmitry

