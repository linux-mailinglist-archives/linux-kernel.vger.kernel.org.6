Return-Path: <linux-kernel+bounces-186251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2758CC1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4571F22567
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7A813DDC3;
	Wed, 22 May 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BTFGjbva"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757C182498
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383052; cv=none; b=N5LonId//Q33NoIdhiyzPts0pkzo918XwzoPLuzhjFsBV2/PG9/4B/JHA7qgcvd4mUO/GuXI0UPYKQRsh8hOprCUDy3pEsoKGZZFFn7XMtfKkfo4Kl2ig+Ef+BflZy/uCbxFMiab/3YlooJOXj1dkJLqIDy664WUsXQt22PqZSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383052; c=relaxed/simple;
	bh=uSAJP0Zr0QUNLHGB1PX4Nd6PdLnxLg1fQGgacyXnlco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g1lFrchiLykNw10Inj3JsdE0JVkHR1ClC/HHd9qOIvtw5gVMbnY34K1fHVcRlgi40uQh2ADpBHLzw+IMak0viPgWunyqzt0ShAQqabdzn/1qJFiEt3TjvbzePcojtQQq6Ciuu4yqPuLOqwFXBoNHLEh6z3TtA3ZaC46HPDz6zn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BTFGjbva; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6a919a4bb83so17858406d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716383049; x=1716987849; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06w4BMb4CS2JUIDxHHVDnPSYgc7Icb3wXH09Rj3AUZo=;
        b=BTFGjbvaxVfIY63EahsR6QyA8nQ7NLSp2WODHr52UZIeMJ+qADxQbJ2MGk6IUEzK2V
         ujuCBGcBwk6BgcXR0uDOX91aorygUFil89H+KNnAJE+YPU/LQoX8FrrTmGDlB17zMZbw
         uYEbjO6tWglobrtEK7wxjGngIp0a3W01rkQAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716383049; x=1716987849;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06w4BMb4CS2JUIDxHHVDnPSYgc7Icb3wXH09Rj3AUZo=;
        b=WOebLZ1RbxnpctIuRoCNC/Xd1y1xmsZPDFJWynR1sg4Xeb/JPsLo8Q/haXtbFKREg0
         iPzkO89vPh1ouGOQVhYAQzTPcWSlN6aZqtmBAcveQgz/9yx6fof5S3zb31WHIsIvZeEm
         s4a7kTexPQR02uBOe06ppwbaGZr88FjLUaITHnl4pZArliji7WnRTisX+VpxrcyhoSwQ
         C1MmrfMC0rK4xOGkAZfTx+kQaYmfW2YM8Qm80CMzKv/CAOTSyi8GcwKRpxTuoIlEKFRl
         cyenAD+sebmkZFuAwHm2GWleRwAgZd/8/ZKMqDd+QvSL17kgykMwWUcndsQS5UgRaGiS
         DT4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWagV1+1f9IVbKMUZ7BlpMo1+MjH4mqm3bnFmtyipE9QjulRpOgY7NiE9x/bjwYSx6lSedN6qBjvpdCIEzcNrrKTrx79zeQ7TFMF97Z
X-Gm-Message-State: AOJu0Yx0Le9X0WpY9Cq83BgSxRhZ/2nEW8T53DFEfGpnVvjBuff6lvfg
	dorTDILE0XzJdRorIclN+c7k9xFpB33i23f2g2ATvWNYZDIgLldGy5fry/Dq45IdBZBYvQINcd/
	3nQ==
X-Google-Smtp-Source: AGHT+IFrfO+6ZwpI5o8tNDWChoFMMHoIH6cTeCIy2QLDugSzmlXWuwm1J5qN0UZJB5x2RKna18RK5A==
X-Received: by 2002:a0c:9b01:0:b0:6ab:8315:4fa0 with SMTP id 6a1803df08f44-6ab83155408mr13434726d6.32.1716383049329;
        Wed, 22 May 2024 06:04:09 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab891a7697sm2910156d6.107.2024.05.22.06.04.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 06:04:08 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-792b934de39so94652285a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:04:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWI6wfy82c7WjqUv9mCpg+zqosvH8FneMq+RChLZINjnnl5/ZpPYqVeby3FdossSLpZDQZLMiXno7iaJytoItUtzGPhMmNfVFh2sVSV
X-Received: by 2002:a05:6214:3186:b0:6ab:701a:931f with SMTP id
 6a1803df08f44-6ab7f353255mr18891526d6.20.1716383046801; Wed, 22 May 2024
 06:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-18-7aea262cf065@chromium.org> <79b2ab52-392f-40f6-8208-6e10330c0f04@linaro.org>
In-Reply-To: <79b2ab52-392f-40f6-8208-6e10330c0f04@linaro.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 22 May 2024 15:03:53 +0200
X-Gmail-Original-Message-ID: <CANiDSCsq8AB-=y_DgPz6HF3qREv45jhqL==E3yQpWeppjuwKoQ@mail.gmail.com>
Message-ID: <CANiDSCsq8AB-=y_DgPz6HF3qREv45jhqL==E3yQpWeppjuwKoQ@mail.gmail.com>
Subject: Re: [PATCH v2 18/18] media: venus: Refactor hfi_buffer_alloc_mode_supported
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

On Fri, 10 May 2024 at 02:09, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 07/05/2024 17:27, Ricardo Ribalda wrote:
> > Replace the old style single element array at the end of the struct with
> > a flex array.
> >
> > The code does not allocate this structure, so the size change should not
> > be a problem.
> >
> > This fixes the following cocci warning:
> > drivers/media/platform/qcom/venus/hfi_helper.h:1233:5-9: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >   drivers/media/platform/qcom/venus/hfi_helper.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> > index dee439ea4d2e..9545c964a428 100644
> > --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> > +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> > @@ -1230,7 +1230,7 @@ struct hfi_interlace_format_supported {
> >   struct hfi_buffer_alloc_mode_supported {
> >       u32 buffer_type;
> >       u32 num_entries;
> > -     u32 data[1];
> > +     u32 data[];
> >   };
> >
> >   struct hfi_metadata_pass_through {
> >
>
> You have some fairly inconsistent fixes for this class.
>
> Please don't change the sizeof() any structures in your series, because
> the structure is unallocated changing the size is potentially insidious IMO.

If the array is a flex array we should convert it to a real flex
array. Abusing one element arrays is deprecated.

If the driver only accesses the first element of the array, I have
modified the code from data[1] to data, because, as you say, modifying
the struct size can have dangerous side effects.

But if the driver accesses more fields, then I have reviewed that
there are no allocations, or any calculations based on the structure
side, and convert them to a proper flex array.


Regards!
>
> data[1] -> data is perfectly fine in this case.

If you take a look at parse_alloc_mode() you will see that mode->data
is indeed an array, and it is used by the pointer type.

>
> ---
> bod



-- 
Ricardo Ribalda

