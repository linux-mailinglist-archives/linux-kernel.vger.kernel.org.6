Return-Path: <linux-kernel+bounces-248149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C4E92D8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9754C1F26BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6EB195FE0;
	Wed, 10 Jul 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6++THaz"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC771194C73
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639044; cv=none; b=EbyfxkbsKhnUcpYtWrw0Cto4ZGfvK68Bi0VUJfb0r7WjBq0nH9ZXHrLPfKM9vKnJ4JfJrm1bTgFYYey576w+1hxVGvOHWvRtuqI6Wjw8rEOKnj3l7wfVv0JPcCnFPcSyHGjNlGSRGbTrvcxA31usoAuKJHSdBDFTR7esuiv9HTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639044; c=relaxed/simple;
	bh=eble5/KJqCeozSW1njrXYIJ6tIyz2Xy8oZVn7c8VBIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or5Ei3qVleTSkbcZIcGiEyAHWc2a78cyy2pVZNSMIUlmpElFaZDwonYaN8533B68nt9rVdABlgosCB855LC0hPPLt6q1p+gZaY8KBcGtoY4m/BjhjqB5yc/uzZ8IEUNEnLGKzr8oazvTvanIotBPKbL9pNMyR/w7PriZPSUGAZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H6++THaz; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-447f2f5891cso543881cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720639038; x=1721243838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eble5/KJqCeozSW1njrXYIJ6tIyz2Xy8oZVn7c8VBIg=;
        b=H6++THaz80pYUZMuW0FKOqPOVWXfisGAWx6D5hTtaeN9CpkpxGBF6ZO37DJXy95o3n
         vHw17H3FJdadQpmECropjF0/ZqM2ig0GziHuyFQ0qArEZ3Zt5sQEonMdA0pUEzcrKZRb
         TQbmZmJwMpYUQn4U332kmV4GDQ9tj7VmOrxxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720639038; x=1721243838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eble5/KJqCeozSW1njrXYIJ6tIyz2Xy8oZVn7c8VBIg=;
        b=xPa+bwJFERMuOOvogNBQs+h/kJMZuXJzZntPrnA6X6A6fKUwmA/dxGrdPU2ydjO9ic
         sMXodWWpEwegnL03EvI4WeBpWmkfSf5NwwCweMx/NV+MczVvgZarhalB+V6xsCEE7San
         OJN3nI5EUOmvR9iGS6pIar5shEWJc2f2i0TXyWsJQGU2cBgO4SseR8aMXyZR7synivgX
         5DvD6BpWmVbEdQbru34ZUhz147GHTZE1DmkxE2xpqp/pX+lW1S0ckp0rFEeRqqayw6bk
         27F8DSG7RVOJ5w619jFEdzkl3J0pZ9h5x5/hE4NQlWQW4j6ve9qmp1GGHA4CHi/uB8KV
         +KEw==
X-Forwarded-Encrypted: i=1; AJvYcCVvrhZHGYLa5LSjnntVy5f7AWWeA8CPC94yi/zVaphOlr52gjr0vzNILaRmMwfYc8IYmLTRFEI42R9lymMD/ZWawuhtXD6ID6285NLL
X-Gm-Message-State: AOJu0YzWIruppO61BhqJVSrajtpw1cDiaabq5AMdt/AFfnm2toIucXqg
	ZRddriL93OpCBpb2AAwHhck703ng6nK+0PX2EUeKRuA8wNkiwWSsfxYohTYxv9Yd2fq/ptY2xQ5
	pFQ==
X-Google-Smtp-Source: AGHT+IEBq4/d1bhLAox5LKzOIAdrLQ6QTSGXc2nqKgl3FpUAdR5pTHUPBKv6mIGd7shoUgrfvlnhCw==
X-Received: by 2002:ac8:7f14:0:b0:447:e896:a3f9 with SMTP id d75a77b69052e-447fa825540mr96362441cf.7.1720639037847;
        Wed, 10 Jul 2024 12:17:17 -0700 (PDT)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com. [209.85.160.182])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b269b8sm23039211cf.5.2024.07.10.12.17.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:17:17 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-447f8aa87bfso85741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:17:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIyR9Uy2eC8sRrze9WZt8bveKZP8hDpWO9b5gc6OTQmKWYNz2VcP8CCnjWXl+XXrslA2cn4w0QpwwGKHKLhz68UzT+fCHq/mW2TjHr
X-Received: by 2002:a05:622a:4cd:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-44d0d631091mr605041cf.1.1720639034173; Wed, 10 Jul 2024
 12:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710-x1e80100-crd-backlight-v1-0-eb242311a23e@linaro.org>
 <20240710-x1e80100-crd-backlight-v1-1-eb242311a23e@linaro.org>
 <CAD=FV=XJuV12mStW3eUm5MHG8BA9W_fn0skN=BrtmqC+fnCZig@mail.gmail.com> <Zo7a6qso7RZ2pkmb@linaro.org>
In-Reply-To: <Zo7a6qso7RZ2pkmb@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 12:16:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U_knZPsM3jnpUOqK7rcBjJeqPAHDG9QRgWhLVeKGZwGg@mail.gmail.com>
Message-ID: <CAD=FV=U_knZPsM3jnpUOqK7rcBjJeqPAHDG9QRgWhLVeKGZwGg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA45AF01
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 12:03=E2=80=AFPM Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> > 2. In theory you could make your compatible look like this:
> >
> > compatible =3D "samsung,atna45af01", "samsung,atna33xc20"
> >
> > ...which would say "I have a 45af01 but if the OS doesn't have
> > anything special to do that it would be fine to use the 33xc20
> > driver". That would allow device trees to work without the kernel
> > changes and would allow you to land the DT changes in parallel with
> > the driver changes and things would keep working.
> >
> > ...and, in fact, that would mean you _didn't_ need to add the new
> > compatible string to the driver, which is nice.
> >
>
> Yeah, I considered this. I mentioned the reason why I decided against
> this in patch 2:
>
> > While ATNA45AF01 would also work with "samsung,atna33xc20" as a fallbac=
k
> > compatible, the original submission of the compatible in commit
> > 4bfe6c8f7c23 ("drm/panel-simple: Add Samsung ATNA33XC20") had the timin=
gs
> > and resolution hardcoded. These would not work for ATNA45AF01.
>
> Basically, it works with the current driver. But if you would run the
> kernel at the state of the original submission then it would behave
> incorrectly. This is why I considered the resolution and timings to be
> part of the "samsung,atna33xc20" "ABI". The new panel would not be
> compatible with that.

Ah, oops. My eyes totally glazed over the description since the patch
was so simple. :-P Sorry about that.

IMO I'd still prefer using the fallback compatible, but happy to hear
other opinions. In the original commit things were pretty broken still
(sorta like how it's broken for you using "edp-panel") and the
resolution hasn't been hardcoded for a long while...

