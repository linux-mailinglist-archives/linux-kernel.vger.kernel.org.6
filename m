Return-Path: <linux-kernel+bounces-286373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40696951A34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA451F2218B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2E11B1431;
	Wed, 14 Aug 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b7Bm28IJ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0338A1B1408
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635652; cv=none; b=lq48oDkbVMdtvHEFi8TMw17NyI/GVC189qFkXBz9WKP3oCc6ggs7FoX96JGOES8lG1ItHZbJUCDRV4wE3R7AS+0dWVST4ZRcmJWneDwFlwcPip8ciDjT1T5P+/xhMrNGrXRA+iLzgPtaatgBoi5FsxMcuMgIbptlluLLtVlvz0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635652; c=relaxed/simple;
	bh=e8mXQbUqQCEEWGhTEMIaH+4giqzidvJR227tArHS/aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRinTg/kInODOIFlhEmpq/TyuZwE0KbfoFUjEwa5qwB8LKuqdKWobGf7TnuZUwSiI+wr+dvaUoZe9qZCBtxUzb4KS8lYp909Jz3Nz1XFV0pXdfz93nKAhL6lcMXcUmTXzGhIQI2Fb2ROyMmgzImIv7Jt1vSWUUN3rd6icL2WC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b7Bm28IJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so6817403a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723635649; x=1724240449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sbgxlrXHc3w9+156HZaTZfFlJWdnKYz3nijx1PbV2J8=;
        b=b7Bm28IJ8D0CMlSoe+g350Nv2fcWkkC2gP9KsZomO/vgoJ5C1RIGG+wRM6fM30E/8h
         yBKARWJZRwAT4mZRnlk9EySNAZFvqbhbM0B0NhAPsAaG2bA/Q88jJLxBoT1AXjLTyRf5
         I9wbWRaOBNtE2if6L9vwXex+okHQgIJC4OxMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635649; x=1724240449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbgxlrXHc3w9+156HZaTZfFlJWdnKYz3nijx1PbV2J8=;
        b=BcsWki6+YrzvAFMrnsz8xJr36oCYXJbd92eESFdbjWNa7tYFatmkIodLapHbySQc2J
         SofkM1lmLfA/MHMQlTprY+flKN+q4i5Lo9QWmqUI+ecr/y0cVXbIMS1r4s3455Sb7rLs
         6FY288Y6jVXGQb9Elhbzea2VNli2Pk1EMMk+sufw8f5OkVpxEEdg5HUVFZXLm/OKiTzM
         sbSuJN5wOY5rVHNd9ixlSE0Yp3j77mpgZBXv1mw6J9CxcFaWpVJajdc1DSnp2p6mL6UX
         8Gab/cRAoPKxKPAr3NFz1cZmwK6YlFLdbgQiNE1f4dQkvjS34rcWJYGb5SGlUTGjVryf
         PwIw==
X-Forwarded-Encrypted: i=1; AJvYcCU+GKgqDINxX8rfuczSvJ4bh9JCWXH9hQOZIc9EepTUPPGaI61J6wYjPV490qB3AfU6WsHIeTCU1hICU7it4RpVqf9UpldUL9OPa0hg
X-Gm-Message-State: AOJu0YyuUavxW8TRx0g3wGLbcnOPmjXoCTaVxn/+4Bs3Pmai1wQQpCSO
	jECI/Y5iPRbMoYeVZt/CURkbZ2+q8sP6dLqWr5dIciib7sF4ZPMJ+/eOM1lQYWrvMXlnFEetmYV
	RjLmg
X-Google-Smtp-Source: AGHT+IF7gHGaygN9TYs8Dv6m2d/Llgf4nL39SF/f9GuQb+ZkeEUL1IQOFowAhFa0AGDLTJc6e/VRiw==
X-Received: by 2002:a05:6402:1ecc:b0:5a2:8f7d:aff6 with SMTP id 4fb4d7f45d1cf-5bea1c80a84mr2096560a12.17.1723635648967;
        Wed, 14 Aug 2024 04:40:48 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd1a5e04e1sm3755594a12.77.2024.08.14.04.40.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 04:40:48 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7aa4bf4d1eso780039966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 04:40:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHc7KAi9QDRF9LNiDuqMs/lCytpHAGqbbqRk5b5h+PQSFsiYm49CGF+uhDpfSqRsluvhCveU4SfZv8cPJsGd2dExH6G5Stl443+cgA
X-Received: by 2002:a17:907:e285:b0:a7a:a06b:eebe with SMTP id
 a640c23a62f3a-a8366c1ef88mr189428466b.9.1723635646675; Wed, 14 Aug 2024
 04:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-cocci-flexarray-v6-0-de903fd8d988@chromium.org>
 <20240813-cocci-flexarray-v6-1-de903fd8d988@chromium.org> <3352aa92-6c50-45c6-b5a7-215e359bdf0c@suse.de>
In-Reply-To: <3352aa92-6c50-45c6-b5a7-215e359bdf0c@suse.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 13:40:31 +0200
X-Gmail-Original-Message-ID: <CANiDSCvpHoMb69=z8-Gbag+9EsO_KH5k8ickSL6NrTDy4DraAA@mail.gmail.com>
Message-ID: <CANiDSCvpHoMb69=z8-Gbag+9EsO_KH5k8ickSL6NrTDy4DraAA@mail.gmail.com>
Subject: Re: [PATCH v6 01/10] media: venus: Use flex array for hfi_session_release_buffer_pkt
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stan

On Tue, 13 Aug 2024 at 23:38, Stanimir Varbanov <svarbanov@suse.de> wrote:
>
> Hi Ricardo,
>
> On 8/13/24 15:31, Ricardo Ribalda wrote:
> > Replace the old style single element array with a flex array. We do not
> > allocate this structure, so the size change should not be an issue.
> >
> > This fixes the following cocci warning:
> > drivers/media/platform/qcom/venus/hfi_cmds.h:204:5-16: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Acked-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Could you inverse the order of the tags, please. "Signed-off-by" must be
> first and then the others.

Just sent a v7 taking care of this.

I am almost sure that I used b4 to import the tags.... Are we sure
that this is a policy that we should follow?

Regards!

>
> All patches in the series has this issue.
>
> ~Stan
>


-- 
Ricardo Ribalda

