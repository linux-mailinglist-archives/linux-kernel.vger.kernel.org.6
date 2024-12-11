Return-Path: <linux-kernel+bounces-441255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F309ECBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04397162473
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02C225A46;
	Wed, 11 Dec 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAtUdlJg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1DE1C232D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919686; cv=none; b=APjXvv6zMsXUneqjeTo1TXlGiWnSf9Ka6790Wzv60TYpxJ5qqEcyJzHorVqmPX3WF2jcmJF5TYpl7O/xjdKOD70LfQAtoWMHgXTxlpor15RAiRMvigDcaTkkYqtjQgeLY7zBo11UuDASt9n15TfbqlOUNMejQQJEIbLhQwqnF5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919686; c=relaxed/simple;
	bh=WXDnwL2qDnZBgJlxAzxrz1+c0z0V1ZPWOHKYmI/sOgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Og97ZHQt/AXsQeaPU4TB3oyO5G9jqB4az9pCEChyOCf7aW2ZfldHSI2rD2FZU22gWLq6s2ghKhXK6XDYDCLDaJd6ha37zsR1LsxNHtO28cEWbaQb2X1qsw1W8ySkxdfCeWk2UPJbND9yzvsVlYUaE5FXfsarMFCH7t0BpboGvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAtUdlJg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso6855064a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733919683; x=1734524483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e/4csaBfXsFFTk2c3ItsNb2FKJCeqt2Yyf1A+buQb4o=;
        b=AAtUdlJgLO96fZaUkQcDo+xOyPA3nMqs82PLqQ8H3nZmj1GF5QvTbWlN/KHZi13cxC
         19JG4MBUH9VbV+Nyh3FRB40A3g1aa9CFA4qVUfhnNEiMq3jtKWjAON0frdR+yYSa/oHs
         CblhnEeEVvBMPpGenG+JoF+5mduGN8c3fKtTo5mq5T9Z6wN+LEt0if9+315uPZDYeWxp
         aMpzCBZDIWk06d52F7dgdprO7JOwHd63fM20D1PscyQEZNEuQfi+HFx8A2oScLIO1k4n
         YDeHbaGv66lZNmjVBe4Q/hnLK1vCFf/nRVjDgaKEJ294xycDhEtu4JpXhOHTqrI03YGB
         t0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733919683; x=1734524483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/4csaBfXsFFTk2c3ItsNb2FKJCeqt2Yyf1A+buQb4o=;
        b=ENep9URc+XaX+NfXYiZXnGrBJfRcwnIBwrIeIZF8ory7we6xTLo5vjuBEaGwatbKEI
         XLvhtj+d5EnkNBjLMXmhLPDvUQFjvCTkTxVOc5DyXyoCiGycGxToZqWX35pmHOf4hZ+z
         eLC4CQkq6NKVHapCcdrQhr6u/tmQ1qKx3jR5o9NMbsfhG6q4uWY8uZu12JCKNJKdURIH
         0ZruxS3ZBLOXy06naj0oXN/u6XgtZW/BE+DLKOw3JZTQPkSu54yGU6S5BZLCcWuQ3gSI
         F1OoN0fLOu7rfAvNPnbnmUqYRWKR+6UzVPKV1zHSGetnsPwtjr4UUpSeggLxninQ3Miw
         V3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCX8HyU9ookwKAdYsgbkDXbbU9F43pmETFXNFLa2ZyJ8UH0cZSLmogSTOO1v8dsHXR89Vv1l8fmub/HdCsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6J98YOCXwUxpuJ2AdQAMqfO9/EbZGlzi3vy/VEgbm8lefbSj
	N/yCmTHKb7xhm7R9PVBIPCBkyuDW3O3SKBMH6PycJd3w3q49NNYVloO1vNVmOHnQUoma4j3iPvG
	3sqFIDNkhRFSmbF5cf59m0trP4ezOvALNDm/mHw==
X-Gm-Gg: ASbGncvE/EaGMLjWAJItlDrNg39C4vVkdEK1gjXznLt9HLY098hFH8v9GXNwBjIUo9O
	QUgWvur8vmzOKTYeDlED79Rb4uNisddFt3LQ=
X-Google-Smtp-Source: AGHT+IGs5pqNqx/r0vQ03W2BhJ9I8iDEAIFgTx5jDKtPQBzfrnqdCIkUH/dpCpEDhV0b4X8UbGBZgwf+T1SDFb1nEUA=
X-Received: by 2002:a17:906:3ca9:b0:aa6:3f93:fb99 with SMTP id
 a640c23a62f3a-aa6b11f649bmr245079266b.36.1733919683159; Wed, 11 Dec 2024
 04:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210-qcom-video-iris-v8-0-42c5403cb1a3@quicinc.com>
 <20241210-qcom-video-iris-v8-16-42c5403cb1a3@quicinc.com> <CAEvtbuus3scTvcjMuxxrfcqnd61+vqM5G=os-aUuM3+SLp2abQ@mail.gmail.com>
 <27a2ca82-2e8c-8cf9-012c-602cd421bd66@quicinc.com>
In-Reply-To: <27a2ca82-2e8c-8cf9-012c-602cd421bd66@quicinc.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Wed, 11 Dec 2024 13:21:12 +0100
Message-ID: <CAEvtbusfHwPFRN=3t93McQ_5qD_apoiQyYb_9fFGe84E6AEs8w@mail.gmail.com>
Subject: Re: [PATCH v8 16/28] media: iris: implement vb2 streaming ops
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Fricke <sebastian.fricke@collabora.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Nicolas Dufresne <nicolas@ndufresne.ca>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jianhua Lu <lujianhua000@gmail.com>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Dikshita,

On Wed, 11 Dec 2024 at 10:34, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
>
>
> On 12/10/2024 6:20 PM, Stefan Schmidt wrote:
> > Hello Dikshita,
> >
> > On Tue, 10 Dec 2024 at 12:07, Dikshita Agarwal
> > <quic_dikshita@quicinc.com> wrote:
> >>
> >> +static int iris_hfi_gen1_session_stop(struct iris_inst *inst, u32 plane)
> >> +{
> >> +       struct hfi_session_flush_pkt flush_pkt;
> >> +       struct iris_core *core = inst->core;
> >> +       struct hfi_session_pkt pkt;
> >> +       u32 flush_type = 0;
> >> +       int ret = 0;
> >> +
> >> +       if ((V4L2_TYPE_IS_OUTPUT(plane) &&
> >> +            inst->state == IRIS_INST_INPUT_STREAMING) ||
> >> +           (V4L2_TYPE_IS_CAPTURE(plane) &&
> >> +            inst->state == IRIS_INST_OUTPUT_STREAMING) ||
> >> +           inst->state == IRIS_INST_ERROR) {
> >> +               reinit_completion(&inst->completion);
> >> +               iris_hfi_gen1_packet_session_cmd(inst, &pkt, HFI_CMD_SESSION_STOP);
> >> +               ret = iris_hfi_queue_cmd_write(core, &pkt, pkt.shdr.hdr.size);
> >> +               if (!ret)
> >> +                       ret = iris_wait_for_session_response(inst, false);
> >> +
> >> +               reinit_completion(&inst->completion);
> >> +               iris_hfi_gen1_packet_session_cmd(inst, &pkt, HFI_CMD_SESSION_RELEASE_RESOURCES);
> >> +               ret = iris_hfi_queue_cmd_write(core, &pkt, pkt.shdr.hdr.size);
> >> +               if (!ret)
> >> +                       ret = iris_wait_for_session_response(inst, false);
> >> +       } else if (inst->state == IRIS_INST_STREAMING) {
> >> +               if (V4L2_TYPE_IS_OUTPUT(plane))
> >> +                       flush_type = HFI_FLUSH_ALL;
> >> +               else if (V4L2_TYPE_IS_CAPTURE(plane))
> >> +                       flush_type = HFI_FLUSH_OUTPUT;
> >
> > Below there is also HFI_FLUSH_OUTPUT2 defined. Do we need to handle
> > this flush type here as well?
> The behavior for HFI_FLUSH_OUTPUT2 is same as HFI_FLUSH_OUTPUT so there is
> no need to add specific handling for HFI_FLUSH_OUTPUT2.

Thanks, in that case we are good.

regards
Stefan Schmidt

