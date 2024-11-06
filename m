Return-Path: <linux-kernel+bounces-398510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB129BF230
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702901C26358
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5652064E3;
	Wed,  6 Nov 2024 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifpKDqTB"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9091204928
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730908152; cv=none; b=oxmLxUkPEpuxVP13x6wNMBFOjDXfUQ5qXiBVx8O7pCfSxP1hM6hqUni2EUKBTir3eTKpdiQfGmmjFNPhD/1kCKus+B3W1p9jSfNjGYdWdVpW8j7HXs73tM4IwJBaz54xA9AWIF3Mv5P7q7EDsoJKhGRfMWWnsUzsKRs78hbw6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730908152; c=relaxed/simple;
	bh=hVFUihgc6QnT1Xq1fEruAaXhETYPBpDfWfSixYIRYIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ppsy+QBnNokm/YLbhDD37QcJZlGKrrLJFOhUJSOCHX3PVCtHJ2azF7xKkqZVfHgwK/+Yar48dw6w2np1M7mCKbkvxf1qC3Rjw9uN5rdRLL0SDYJtZ2OH0dTH83+gSSew/lKiWHbEaPAc0LbbaRZGDiWxDW5JE9ZM8F/CFp3f7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ifpKDqTB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9e44654ae3so908908866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730908149; x=1731512949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPH4C+vsdNY0v9MzcBPeqyGD66BVdCTndzKOwNg3m20=;
        b=ifpKDqTBv18cn2nXsbM/siAChx4Zj95etoqs8AaaIJpwPzKesVtnyEIfLZR4GUlpbo
         Jg2nMLDMJ1JF7XD4Em1LIhbghG/V+tWqm0KjzUftEMuDvfpLoZzD79jGRy6TgyXJfJ1A
         2NUr5rRaWpck6l1PiLYAfliR+3m1X5U/AM8fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730908149; x=1731512949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPH4C+vsdNY0v9MzcBPeqyGD66BVdCTndzKOwNg3m20=;
        b=fgMaJ7nMXchQRw/Xasq+qOByhG72RJPABk2RalZAqwKVJOmw0OVLkoQCwtvNNlQkeN
         rnFXaavE75fFjWgTRwfD75BplPfL9Rb3dF0K1yD7jhTmFAFTAF4aFTRZrdjNdztMo6JL
         b379K7TsX8PxtZ+vFFLRxx3VAdp0qmDonAWaLi4YC/RRscJ/jQzMMPlpspHmGdxA2BEd
         DAavkx6gHFop5U8Ok7kc/jTqtZR2ymDe+W4teNTEj7YzjjGD5A3suUfge1AdWZO0HdsS
         TtUSjy2DZO3iM9/skFiXbFDwNRtheGoMRtRbVnaBZ7JKtqSeNO+KubE78A9fy8HbvLdY
         48tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVJ07CZfMk9Z0293X+t5OXPnIJtr1DdzlPdMR2z3Fko1PfGdAYwrlpDSXM7rGkbvdINrk7WRBd2A0nkK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWMDt3GUZ3s8OhbJvblJcKTZf/w/D1NS03IbxjsyAHOpoXtcEZ
	ECKKPKIXbijVgzHxdiNhUr4nSIG/62YuN1fnOdzbMzl+mKbak/I4+hhVSosaL3cGANX3PrW9iy4
	=
X-Google-Smtp-Source: AGHT+IHj7GccbFYqgJTtoaxBn6glMU8DqtX38Hr2bDUAylw0y1I62CucRXQcSaAGx7KyMfP6HQVQvw==
X-Received: by 2002:a17:907:318e:b0:a99:f4c3:580d with SMTP id a640c23a62f3a-a9e50b96b50mr2274274866b.42.1730908149166;
        Wed, 06 Nov 2024 07:49:09 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb17f6087sm298532666b.142.2024.11.06.07.49.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 07:49:07 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so13785a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 07:49:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPjARWIIYV6fwKwhgzuKFsGVxPU9s+p17TbP34MG+1rclGh+mBtPPRPD3g+l7qVr2b6XQ2dnCINKL7lC0=@vger.kernel.org
X-Received: by 2002:a05:6402:206c:b0:5c8:a0b1:9c4 with SMTP id
 4fb4d7f45d1cf-5cefbcb8e25mr22907a12.6.1730908147253; Wed, 06 Nov 2024
 07:49:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-submit-v5-0-552f0fec8cba@chromium.org>
In-Reply-To: <20241022-submit-v5-0-552f0fec8cba@chromium.org>
From: Fritz Koenig <frkoenig@chromium.org>
Date: Wed, 6 Nov 2024 07:48:54 -0800
X-Gmail-Original-Message-ID: <CAMfZQbx6-11k1eN1FC=_kRSgsh7FbTp2uvk3ufh+gOyhvxgEGw@mail.gmail.com>
Message-ID: <CAMfZQbx6-11k1eN1FC=_kRSgsh7FbTp2uvk3ufh+gOyhvxgEGw@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] media: venus: Add hierarchical h.264 controls
To: Fritz Koenig <frkoenig@chromium.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Nathan Hebert <nhebert@chromium.org>, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stanimir,

Would it be possible to get this in the 6.13 pull request?

Thanks.

On Tue, Oct 22, 2024 at 10:40=E2=80=AFAM Fritz Koenig <frkoenig@chromium.or=
g> wrote:
>
> v5:
> - fixed formatting
> - included reviwed by for patch 2
> - Link to v4: https://lore.kernel.org/r/20241017-submit-v4-0-d852bc7f7fdc=
@chromium.org
>
> v4:
> - addressed feedback from Dikshita
> - included reviewed by for patch 1
> - Link to v3: https://lore.kernel.org/r/20240814-submit-v3-0-f7d05e3e8560=
@chromium.org
>
> v3:
> - dropped reordering patch
> - updated cover letter
>
> v2:
> - cover letter
> - testing methodology
> - Signed-off-by
>
> V4L2 has support for encoding with hierarchical frames using the
> V4L2_CID_MPEG_VIDEO_H264_HIERARCHICAL_CODING* controls. This allows for
> specifing frame references needed for temporal scalability. Encoding a
> single stream with a single layer allows for the layer to be dropped and
> the stream to be decoded without artifacts.
>
> ChromeOS is planning to use this feature for the L1T2 web standard[1].
> This allows video conferencing apps to encode once for a clients with
> different performance/bandwidth capabilities. As the application is a
> real time encoder only P frame support is added.
>
> The ChromeOS test framework ("tast") was used to verify that no
> regressions are present. This was done on SC7180 ("trogdor"). These
> patches were also run on SC7280, but not with as an extensive test set.
>
> Verification of the added controls was done with a bitstream analyser to
> make sure that reference frame management is correct.
>
> [1]: https://www.w3.org/TR/webrtc-svc/#L1T2*
>
> Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> ---
> Fritz Koenig (2):
>       media: venus: Helper function for dynamically updating bitrate
>       media: venus: Enable h.264 hierarchical coding
>
>  drivers/media/platform/qcom/venus/core.h       |   4 +
>  drivers/media/platform/qcom/venus/venc.c       |  71 +++++++++-----
>  drivers/media/platform/qcom/venus/venc_ctrls.c | 126 +++++++++++++++++++=
+++---
>  3 files changed, 164 insertions(+), 37 deletions(-)
> ---
> base-commit: d07b43284ab356daf7ec5ae1858a16c1c7b6adab
> change-id: 20240814-submit-05880a074377
>
> Best regards,
> --
> Fritz Koenig <frkoenig@chromium.org>
>

