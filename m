Return-Path: <linux-kernel+bounces-337156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB880984609
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFCB23D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1AB1A7261;
	Tue, 24 Sep 2024 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9jBpMSm"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8DD2907
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181410; cv=none; b=kOO2cV9A9Oq7F+ZxPvmoyb3getkrPg7bwhcJZ1jFOnBFAb1Jqljwlh4Xnh+8lw+iiQ2TdD9V9ZRb3n7e2eZml85p42S+E6f2K9A6MjTZrk0GSKmjREF6hg3pjyL8d7tA93U8vpuqRO6mu5C19U4q1Kx7bJD/TAw1UkxDDgbUb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181410; c=relaxed/simple;
	bh=0tgYaNknECHGcREZzuh0GavXRA4JoNzrI0nt+ohvHAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLAJqK35NO6yaEgYTBtiU+o8zpywOsenhJhqg3BBzlT+YV+z6kxpn6hX0q1jpefmfh2X9WJxx5Mi7qQxw6rxuSwMIwPDbb1n7eJUXrBQ6IbWO3xS05zfbLjzdLLVU+ovN325EgqHK6M7CeZxWcl1FoHhRJzaUHJXzpxnr9a0RSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9jBpMSm; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6dbbe7e51bbso41533587b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727181406; x=1727786206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZclqvN8OWviCoeP7W2fOBR9cc4G4ZJZYXXNmxnjQMg0=;
        b=S9jBpMSm2q+HNAhhL9QgKFolkr2nCGbcDH64mL44hYiQzTMBehO8OrH1i9W2Nr+mXY
         etayHSzpH1zETTVB8yleWvza8EbkZbvwnB5fBpPjeDJQiGtiY8wO1Qq6Wy9v57knbNGm
         fXkvXWNBY4OWI3JTfMQorBt03b3/lm9h7S5iRZV39SH/MP/SmAp33xMRhr4j+BRjBs7w
         TSO7HwycuZpO+2CjIXRdROtNe8bH+E2DUzYXdh0L5m6yeFa8+c1KUP7ivpNEAUxsydMZ
         Hh9963QythiYyYBakmmYjLu3SMbn6+4kQ4faNDwjetJP8g6kzmgsS7BOvLZVqMtzGZMN
         gxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727181406; x=1727786206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZclqvN8OWviCoeP7W2fOBR9cc4G4ZJZYXXNmxnjQMg0=;
        b=S7NBKr8TB9wiaE2vhRDZS++Osm0jwJyToyfJNrr7Rm8nfGMyx8CPbCVxH2CgPy6C5s
         TsMwFxFJbxGTKoxbFFE7Ca+1o4Xx1ivA9mKMX5jffEdZbPJRbrPDALT1hHOVsoOYkLrU
         DVYNde/TwH3kP8N27HmObQzDvZyLAp68wgQQ17mMgeG1kwmm3gJO7kanNzDlcVJvr+j5
         15Ug5fete/YNf4A9UByXAM/D3f5qI4DhrX9iqa9p6k/1W5qFtut5U2rwdsFCF5DiDrYh
         XfAcPwof8pEdwFmU20jNxyVjqVWraJY5CDl/LEUmPQVIPuW/NtIh1+yTFDQ+u+KzLjlr
         FrPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZD67Kq1ry05mt0F4ld+sZT1gLqKx54axt0IRs2FARVo/yRIL1VDc9aNobObJpl94ChhyN7Ziz8TScaoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80PZda47btKt0+vu8w1C8svGXZDxESd/FtdU3FRo4XumOX0XU
	LhKUh6yPjvl472RGYg3GnJfZqNrxxcbdhwM6xBl8MtI/z3RVkIUpePDJDDQCYB+SHMBA/jwky6m
	HDjTkGzUeEMWw1zUCEQ8b3Yi1vByWBkP2UDC3/g==
X-Google-Smtp-Source: AGHT+IGYuEuHzLpsgKnYPKtlxcYnqyLY8yYJBAHJhgxQ8dv64VF7X1Tzkg40TcunXFxtwU+tj7usbv8oLmJYhPL74p4=
X-Received: by 2002:a05:690c:4443:b0:6e2:1062:9b90 with SMTP id
 00721157ae682-6e210629d20mr13188617b3.44.1727181406631; Tue, 24 Sep 2024
 05:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <20240912071437.1708969-5-quic_mahap@quicinc.com> <v4cnmso3nl5oi3scd2lkg6kepb52vjrzgoti42ikds3y2wq6aw@sbn2yu4xeiun>
 <9b47bd8e-6079-4285-a3d7-932178d5bdf2@quicinc.com> <rmndmhq67lajdmva6gt46rqtkvf6jh2afbqazafz6oxv7ep56j@bznopz3aexyt>
 <ba0bc896-41ad-4f1d-9218-fc5a44add422@quicinc.com>
In-Reply-To: <ba0bc896-41ad-4f1d-9218-fc5a44add422@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 14:36:35 +0200
Message-ID: <CAA8EJpqTuj2j4mTKCTGpOX6ZfgGLocmDdwX1BwqEp6OkBejnDg@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/msm/dpu: Add SA8775P support
To: Mahadevan P <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, 
	quic_vpolimer@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 14:31, Mahadevan P <quic_mahap@quicinc.com> wrote:
>
>
> On 9/24/2024 5:46 PM, Dmitry Baryshkov wrote:
> > On Tue, Sep 24, 2024 at 04:42:02PM GMT, Mahadevan P wrote:
> >> On 9/12/2024 1:34 PM, Dmitry Baryshkov wrote:
> >>> On Thu, Sep 12, 2024 at 12:44:36PM GMT, Mahadevan wrote:
> >>>> Add definitions for the display hardware used on the
> >>>> Qualcomm SA8775P platform.
> >>>>
> >>>> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> >>>> ---
> >>>>    .../msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h   | 485 ++++++++++++++++++
> >>>>    .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c    |   3 +-
> >>>>    .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |   3 +-
> >>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |   3 +-
> >>>>    4 files changed, 491 insertions(+), 3 deletions(-)
> >>>>    create mode 100644 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h
> >>>>
> > [...]
> >
> >>>> +static const struct dpu_intf_cfg sa8775p_intf[] = {
> >>>> +  {
> >>>> +          .name = "intf_0", .id = INTF_0,
> >>>> +          .base = 0x34000, .len = 0x280,
> >>>> +          .features = INTF_SC7280_MASK,
> >>>> +          .type = INTF_DP,
> >>>> +          .controller_id = MSM_DP_CONTROLLER_0,
> >>>> +          .prog_fetch_lines_worst_case = 24,
> >>>> +          .intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 24),
> >>>> +          .intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 25),
> >>>> +  }, {
> >>>> +          .name = "intf_1", .id = INTF_1,
> >>>> +          .base = 0x35000, .len = 0x300,
> >>>> +          .features = INTF_SC7280_MASK,
> >>>> +          .type = INTF_DSI,
> >>>> +          .controller_id = MSM_DSI_CONTROLLER_0,
> >>>> +          .prog_fetch_lines_worst_case = 24,
> >>>> +          .intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 26),
> >>>> +          .intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 27),
> >>>> +          .intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF1_TEAR_INTR, 2),
> >>>> +  }, {
> >>>> +          .name = "intf_2", .id = INTF_2,
> >>>> +          .base = 0x36000, .len = 0x300,
> >>>> +          .features = INTF_SC7280_MASK,
> >>>> +          .type = INTF_DSI,
> >>>> +          .controller_id = MSM_DSI_CONTROLLER_1,
> >>>> +          .prog_fetch_lines_worst_case = 24,
> >>>> +          .intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 28),
> >>>> +          .intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 29),
> >>>> +          .intr_tear_rd_ptr = DPU_IRQ_IDX(MDP_INTF2_TEAR_INTR, 2),
> >>>> +  }, {
> >>>> +          .name = "intf_3", .id = INTF_3,
> >>>> +          .base = 0x37000, .len = 0x280,
> >>>> +          .features = INTF_SC7280_MASK,
> >>>> +          .type = INTF_NONE,
> >>>> +          .controller_id = MSM_DP_CONTROLLER_0,   /* pair with intf_0 for DP MST */
> >>>> +          .prog_fetch_lines_worst_case = 24,
> >>>> +          .intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
> >>>> +          .intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
> >>>> +  }, {
> >>>> +          .name = "intf_4", .id = INTF_4,
> >>>> +          .base = 0x38000, .len = 0x280,
> >>>> +          .features = INTF_SC7280_MASK,
> >>>> +          .type = INTF_DP,
> >>>> +          .controller_id = MSM_DP_CONTROLLER_1,
> >>>> +          .prog_fetch_lines_worst_case = 24,
> >>>> +          .intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 20),
> >>>> +          .intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 21),
> >>>> +  }, {
> >>> Where is intf_5 ?
> >>
> >> intf_5 of base address 0x39000 is not supported on this target.
> > Not supported by whom?
>
>
> In sa8775p mdss architecture intf_5 is not present. So we are not adding
> in SW too.

ack, thanks for the explanation. It's better now.

-- 
With best wishes
Dmitry

