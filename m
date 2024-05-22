Return-Path: <linux-kernel+bounces-186244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881DE8CC1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42DD5283689
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9313D538;
	Wed, 22 May 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V3SDMK7H"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E608D17C9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716382506; cv=none; b=e/bB3NDxiOGpZktf7Fpn3bcsdt49cc8YGcTA2ZQwT9JO2R/7KOTzAyrWd3Q+GM4czlrorNi/cH+dKlkDIWvLJ1fnqz40Q7MublZMOYRgt9EdtEb1axJ29UPwlzqsEeXK5MpHCa+f3agoUIfHxbmR5+LlrhbC1SGyFhlJo4teL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716382506; c=relaxed/simple;
	bh=BinNhgcEH42gS3lWUSSUP7U6VJyoBPjo0uHCGJBaX60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVmlWxc7EqEu1/UNP8qvGEBprWihhEPnMrHbbdgm/QCj1VvOUqGpsBfdrHjdyCEwtKM7qU+HM1NMpIp0fhn8tMQtibm5cfSEOg2+D6eOpAIq8W/8JQsvhYSqMpxvbaNFUsPk2qaX/eBNckg6QOoid+OpMC7gCHsqkRHhXYZ3+zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V3SDMK7H; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43e06d21a06so7318181cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716382504; x=1716987304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qRSyPLhJtHsuvnS9t5bdddtQaBryY+zRRpKLYbkoicI=;
        b=V3SDMK7H0HgZdCRNVCpyafoAuNcPjYq42TfE+SiPJg+xx7XM+ol+uvVY+3Vsk0pfGG
         F4u8mZaXBePzVrFzYmx4FSUiE8l1iQsaPtT8SBblOAyyqpl0iXRzmDorl1Fze7GG34WX
         6QIjYKkgaarbi5UWlmFdqfl8ZyuIRHuSis8Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716382504; x=1716987304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRSyPLhJtHsuvnS9t5bdddtQaBryY+zRRpKLYbkoicI=;
        b=cE8mCETioryKOvT4Oe8GqBqXitzIGwMbpj9qrwdq8MpHqlpLkS8eInRziFTEOFm5Ae
         5v2FPyjZYesRvNvHkurNuksVCTpS703h9VNXUKcuuDKk47S8F4Z74Fuen4lhNDSuus19
         sap3UP6grXEQRPs6OIaiEpNxf9c42SYDPCzaj99coCOm5F/ShSKS8kVB4mN1VSEy3B9+
         V0k95kd9DqqEnNsqpbiJRoT7dqszB5fnQPt9aYKKdGl9xCKRI4ZImqINdEyvAry75Z5t
         Qdit0p+vBcY+Us3a1UuCTaqJo7CbYn2Hq8FNCMWtyDxHE0McJMTPaVhah0Sc6vxv+KVN
         4q0w==
X-Forwarded-Encrypted: i=1; AJvYcCXZfxmu4+/+96g9asQuOyO98NOC9Eq4KJ7jNyjdZc86djFGD0kSbpUaKCfLg2HR0/ntt+WAMM5TzFfCxtl5f2q7ndlelVjPEpPKl41e
X-Gm-Message-State: AOJu0YxK8YHK/fkSsAlAFz1Ka0iJrKhyLhZf4dfkTWt4PY0PayJaFrDS
	9hHX7wj9tDA2AoP3jogoDVZhoGKprjA6i6LiiXkteu++RnIp7C7xwG2VTK7XEon4R78ihOOEYyx
	x/A==
X-Google-Smtp-Source: AGHT+IGLMJObC8uUhbR6pecNcAPo6m+nUXq9nK63ytfqL6L/NE7ZPgbA1D9QmaE0Jhcg0Okr4bQ+uQ==
X-Received: by 2002:a05:622a:2d5:b0:43a:a4e9:6ca8 with SMTP id d75a77b69052e-43f9e1b4c66mr20291131cf.60.1716382503628;
        Wed, 22 May 2024 05:55:03 -0700 (PDT)
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com. [209.85.219.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e166e3755sm131233241cf.40.2024.05.22.05.55.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 05:55:02 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6a8691d724eso7788556d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:55:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrsP5qn9M2TKk40cG5BEUNWLdTds3MiYKgZHZeHO6x/Tk0SSq+WiZX68DVCS4iDmZkQ3D+ktBXEhjEgGTyHGwsM+UFn74yGdhSmpxt
X-Received: by 2002:a05:6214:3903:b0:6ab:6c2e:e425 with SMTP id
 6a1803df08f44-6ab7f356954mr17023246d6.24.1716382501399; Wed, 22 May 2024
 05:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-10-7aea262cf065@chromium.org>
 <284a3096-cc2d-45bf-9075-fcd1bc60a599@linaro.org> <96593105-0ca3-43c7-86da-7a059cad287f@linaro.org>
In-Reply-To: <96593105-0ca3-43c7-86da-7a059cad287f@linaro.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 May 2024 14:54:43 +0200
X-Gmail-Original-Message-ID: <CANiDSCtpSQWfe8Jj=L__kYJa74N7KnqMeaW0=cGzagMtBrHiUg@mail.gmail.com>
Message-ID: <CANiDSCtpSQWfe8Jj=L__kYJa74N7KnqMeaW0=cGzagMtBrHiUg@mail.gmail.com>
Subject: Re: [PATCH v2 10/18] media: venus: Use flex array for hfi_session_release_buffer_pkt
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc: Michael Tretter <m.tretter@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@amd.com>, 
	Andy Walls <awalls@md.metrocast.net>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"

Hi Bryan


On Fri, 10 May 2024 at 02:10, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 10/05/2024 00:37, Bryan O'Donoghue wrote:
> >> -    u32 buffer_info[1];
> >> +    u32 buffer_info[];
> >>   };
> >>   struct hfi_session_release_resources_pkt {
> >>
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>
> Oops no.
>
> Please don't change the size of the structure.

In this case buffer_info[] is a real flexible array, so there is not
much we can do.

The driver seems to only uses the structure to address memory. It is
not allocating the structure or doing any calculations based on its
size, so it should be fine (famous last words).

If anyone has access to the hardware it would be great if they tested it :)

>
> u32 buffer_info;
>
> ---
> bod



-- 
Ricardo Ribalda

