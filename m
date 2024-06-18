Return-Path: <linux-kernel+bounces-219255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E765490CC05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A8F281DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF913C697;
	Tue, 18 Jun 2024 12:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oSJuvqIN"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388E158A05
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714209; cv=none; b=pEu+VrDL+50ZLEXO+DLGle2WxkXi1eZmIbvPOa0FGOAy1t3IYN9smFG8NuKsDY6Qo4olWBRc2jafsloUxH/9uDgqWQEHNXhoV/YLHMKFikDZ0tb+AaRoNcfRKnWfty11BV/Hm1YBV2TeTLdc6Q4GdiRhXQaUbNZFftvg9TEHChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714209; c=relaxed/simple;
	bh=wc3nxRp/zEr6rzxbLlYJyj2e4UgxApK3/epeyKCpZJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqcvkJjy/Kj2F2OVAsps1YcqFC6/TfaAcuIgL2EQ5sIn29SKSUgRXFqZiVzktj+EjIgP5YJpHpUAhHQvfDiAV0A8lmlkBOShKXyowDqkHD1Qg71H0CAJBk0E9e2KEIkMnvWjxo/LtkyE6MPdssMHSkB7rRytQ/3s4CVshKOKJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oSJuvqIN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c9034860dso6787860e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718714205; x=1719319005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NTiN80rKMTOzOqZ3XNmwbttNTimI7k+ulamUrzc9SmI=;
        b=oSJuvqIN8dssT/cy0Sh4t/Svml0TiJg6LZU/pzyXG3cepAPspJp0oCpAHpDROucCfj
         ZmQYgial3+/eiZzFljZam8No/zka8nUnIYTQyGPhVVrSwRkYF+fm1cXh9fCyZ3+DsPJR
         wpk+sVgOV/rtNdkZvmYvcoLZ3i2rQc30rAgmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718714205; x=1719319005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NTiN80rKMTOzOqZ3XNmwbttNTimI7k+ulamUrzc9SmI=;
        b=Qdwk0mgwwTwVPWXbmT/ByHmt4vGTQjb2/P9JzSQn0FejEVb70SrNzCVzloTQBNpk3L
         jEY2cSCco8PWxedLDgSNJMHPtdZeVP8vY/bcWKhUnPyGKxUX0f8N2rIevY3g8e+dD+Fc
         YfBS2RkAEJZnTFT+DaVCY75A79BmHdNquQI3SRkPP3GFZpOcChvL3ZfLZInee1wtvuzP
         v6ZMW+Nso3EYt0gjHv/LgENdkrRXgXMUerXUVd3W1wVN1d2lXFuxGUX1SR9tAKNnPfrZ
         X8Vtla1WHj5g7KW0ZK2uodG+o0Ajt/cni3P0V47TPdyoy7X7b+TAM0rTo16fpWDjz109
         voHg==
X-Forwarded-Encrypted: i=1; AJvYcCUo+R/Jwd7BH8TCWwmsznfpFH1ypM7LHAExkKzQuc7Fg5yJpv5trO0k2kJmMc4lhO8hEN8jN8pdi8QJUhm4taBHcoF+TIIM1nMTEkko
X-Gm-Message-State: AOJu0YwqwXLyizzZuas02sO2vaX14H95jKmhIGJFg9dbq4nQn8xgC7Pa
	8Fb9ucgJB+qmGp2PGucb3TVtU6PcY/9IifKKGug91BTjOh1g+jWuMaKaCQ355yYS6Wm14EWE2lG
	7wg==
X-Google-Smtp-Source: AGHT+IGVz912/IwOeoIITQuGSbM03qtKkKaFyrCDsxrI2IBqa5vH5+mLb26Fl6cCMP4FI80HcMppLQ==
X-Received: by 2002:ac2:532a:0:b0:52c:8075:4f3 with SMTP id 2adb3069b0e04-52ca6e6e9c6mr8607639e87.36.1718714203628;
        Tue, 18 Jun 2024 05:36:43 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca288e6dfsm1504844e87.307.2024.06.18.05.36.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 05:36:42 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ec17eb4493so63336661fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 05:36:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGZb3ygwqPKvGqZNNzmGkUkm0d7TYBqXLSaRXEl4pnaqcRsJpXUqEwnShla0WSOF7BT/rH1fMFxlbJ7GaWJ5yUGeNULuffLivJpNl8
X-Received: by 2002:a05:6512:3e25:b0:52c:8b03:99d1 with SMTP id
 2adb3069b0e04-52ca6e92adcmr12517058e87.48.1718714202517; Tue, 18 Jun 2024
 05:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-cocci-flexarray-v3-0-cda09c535816@chromium.org> <3f7baafb-82c7-3955-e871-687fafe8048c@quicinc.com>
In-Reply-To: <3f7baafb-82c7-3955-e871-687fafe8048c@quicinc.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 18 Jun 2024 14:36:27 +0200
X-Gmail-Original-Message-ID: <CANiDSCszoUyZW85qaCrkkfNR73dXBrAURayWD8_jpV6Er6fOsg@mail.gmail.com>
Message-ID: <CANiDSCszoUyZW85qaCrkkfNR73dXBrAURayWD8_jpV6Er6fOsg@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] media: Fix the last set of coccinelle warnings
To: Vikash Garodia <quic_vgarodia@quicinc.com>
Cc: Michael Tretter <m.tretter@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Andy Walls <awalls@md.metrocast.net>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Vikash

On Tue, 18 Jun 2024 at 14:34, Vikash Garodia <quic_vgarodia@quicinc.com> wrote:
>
> Hi Ricardo,
>
> On 5/28/2024 2:38 AM, Ricardo Ribalda wrote:
> > With this set we are done with all the cocci warning/errors.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > Changes in v3:
> > - Do not rename structure fields. (Thanks Bryan)
> > - Link to v2: https://lore.kernel.org/r/20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org
> >
> > Changes in v2:
> > - allegro: Replace hard coded 1 with a define. (Thanks Michael)
> > - Link to v1: https://lore.kernel.org/r/20240507-cocci-flexarray-v1-0-4a421c21fd06@chromium.org
> >
> > ---
> > Ricardo Ribalda (18):
> >       media: allegro: nal-hevc: Replace array[1] with arrray[N]
> >       media: xilinx: Refactor struct xvip_dma
> >       media: dvb-frontend/mxl5xx: Refactor struct MBIN_FILE_T
> >       media: dvb-frontend/mxl5xx: Use flex array for MBIN_SEGMENT_T
> >       media: pci: cx18: Use flex arrays for struct cx18_scb
> >       media: siano: Refactor struct sms_msg_data
> >       media: siano: Remove unused structures
> >       media: siano: Use flex arrays for sms_firmware
> >       media: venus: Remove unused structs
> >       media: venus: Use flex array for hfi_session_release_buffer_pkt
> >       media: venus: Refactor struct hfi_uncompressed_plane_info
> >       media: venus: Refactor struct hfi_session_get_property_pkt
> >       media: venus: Refactor struct hfi_uncompressed_format_supported
> >       media: venus: Refactor hfi_session_empty_buffer_uncompressed_plane0_pkt
> >       media: venus: Refactor hfi_session_empty_buffer_compressed_pkt
> >       media: venus: Refactor hfi_sys_get_property_pkt
> >       media: venus: Refactor hfi_session_fill_buffer_pkt
> >       media: venus: Refactor hfi_buffer_alloc_mode_supported
> >
> >  drivers/media/common/siano/smscoreapi.c        | 10 +++---
> >  drivers/media/common/siano/smscoreapi.h        | 18 ++---------
> >  drivers/media/common/siano/smsdvb-main.c       |  4 +--
> >  drivers/media/common/siano/smsendian.c         |  8 +++--
> >  drivers/media/dvb-frontends/mxl5xx.c           |  2 +-
> >  drivers/media/dvb-frontends/mxl5xx_defs.h      |  4 +--
> >  drivers/media/pci/cx18/cx18-scb.h              |  2 +-
> >  drivers/media/platform/allegro-dvt/nal-hevc.h  |  7 ++--
> >  drivers/media/platform/qcom/venus/hfi_cmds.c   |  8 ++---
> >  drivers/media/platform/qcom/venus/hfi_cmds.h   | 38 ++++------------------
> >  drivers/media/platform/qcom/venus/hfi_helper.h | 45 ++------------------------
> >  drivers/media/platform/qcom/venus/hfi_parser.c |  2 +-
> >  drivers/media/platform/xilinx/xilinx-dma.c     |  4 +--
> >  drivers/media/platform/xilinx/xilinx-dma.h     |  2 +-
> >  14 files changed, 39 insertions(+), 115 deletions(-)
> > ---
> > base-commit: 48259b90973718d2277db27b5e510f0fe957eaa0
> > change-id: 20240507-cocci-flexarray-9a807a8e108e
> >
> > Best regards,
>
> Could you also mention if you have run any video usecase on any of the boards
> with these changes ?

I have only compile tested this series. If you have access to any of
the hardware it would be great if you could test it out :)

Regards!

>
> Regards,
> Vikash



-- 
Ricardo Ribalda

