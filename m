Return-Path: <linux-kernel+bounces-511098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 070AAA325D5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B44F11689A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3D20766F;
	Wed, 12 Feb 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyJcMOXB"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4D2046BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 12:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739363177; cv=none; b=ikFjAcur1NNoBa2ovEfzdHQoWE0ovyyxNyjwKcrK+VeUWRNIR7orrm4R8M9IPUGGABF80RC4/nCP1TXEFx0epFL44nrOIu64uLH+0I0QCWuVQUeaq+w/gTt38ipIYU6ASX06NTlXoWD92YzHLoMJOzqqNNOzHtTzdXY/ZPAOf3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739363177; c=relaxed/simple;
	bh=nq8Gpy/+Xqn4Zptu93g/1bnbhcwcFsdUiUkBb+2IJ4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7UDWUAZz7OHIuXWbAeVR4NiOjoeJ3n3Lcvgf2r8sUhbl2nMrKf8NCUAUzlPaf6BKdApKA+ARaiFA60QaZ0QRzkzQuzle+/XGQRw6JMbmBtY7uuXg+G6T96FhtUgN3CbOYhgPYv2bSgNPdo0SNtiLHFbuSVtD2MW7IJq4WSJ+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TyJcMOXB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6715734d9so59037047b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 04:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739363174; x=1739967974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46uMxi16ondgGccvYcEvXMpewkDX4CAYjnXalJ8+Fuk=;
        b=TyJcMOXBXJR2W3Nhvs2n/KeKd3yemLN0MhVPlBFS2SWvTLp5Iv8W03Nt23rNh264Eg
         LvA0T3TRW6V6iSGzzdDosabDxb6k6YyjAqi8csDztQOvNC1EfiyMbeN3B1OEOOyAdQv2
         q5KQVg2cisCWMXktBXzpIIfovOIV+3AuNU4JKM/6lkQJ1fIOYiXfvZ27M2/gcpCbJm3j
         +5z8FSERkk44ga3ad3cVlzyqNKiVKLuiRHAJmgPcDT5P8KfFkTp7s/EHxROyhIkAx+65
         eBmNNtEiwUgrn7xw44TGV5kcbP6gkBY0zO4QuoYlpVzuIqfWJyOQTD4uNz+yQ3vYNLvE
         +BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739363174; x=1739967974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46uMxi16ondgGccvYcEvXMpewkDX4CAYjnXalJ8+Fuk=;
        b=JfG4AKzShmwF1zGy3Kcf+4pMaHYdzYgdd16ChRC/P/FTN0tgzXhgcDmG6sygJRPJEU
         a05U0RUrM+++UWTd6vzowOXKKuiE2wJEJ9O1QYoSoU5HicRtwqYOfLi8w/xJGT+2W0dp
         xNMD48L9J7XvJ+/rQEwmxPgqoHBAq1nO6RZUf0SHMp8+/UUHxz2YhBueOheOj4WnmxRk
         P7WqMv7AZMuVvSY1CWeuogeATI3NLyd/5zmrN4nFuJdxcQ7hpVvYvTDbn1C5D5mQTt8v
         wXTaxjmRgtnSodo1sYgSmrnxk4uVVAyra6YndRLIxUa83tA8iz86rTRYog+IKLv6ftji
         eC2g==
X-Forwarded-Encrypted: i=1; AJvYcCXKCxXqofjbIM08+2KvJcqrYQ7pXnaIX8Hng9kH2vH6HvkqdrFGc5YzAW3xCf4b0zoENR6UL4622YsH3tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERDXYSV1Qjf/homxVUhf6kuRF+gFejmjcg9UXWk8/SakCe4vc
	JdSKsBDeNMwqM9vUzLm8h4URQ23O0toYdDqCVTJTqWgtcoUaTXbIvp523sgKU0X7L0m6ILGT+ah
	p55Irnt3Dy6zqmtsr9L/RZwTr3tum9Tw5P8EBCQ==
X-Gm-Gg: ASbGncssrJbdNsXfgIA9w+WNWzlACnGI4jwYJwEg5zCtS7ME3CXRGE0uc8SbWCzKF5Q
	E+OhpTXQ1Y4yLUT+G2H6ig4wkwL/M3YrDFb3YfWhcsQs8JREuQw4/jV/10fGatNKLwss0ghMhL8
	SxKY8omVXH5/hhqO1MFSZLpa/yX2NL
X-Google-Smtp-Source: AGHT+IFO8HryvH361AtBzukKXHNwFD8iGdVHudVfUR5kStssIhbXkwBCk3h98SYdV45gucw51GK8rpDo/H/XBl0oEtA=
X-Received: by 2002:a05:690c:3687:b0:6f9:50ed:e6eb with SMTP id
 00721157ae682-6fb1f27c541mr33742567b3.27.1739363174466; Wed, 12 Feb 2025
 04:26:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-mst_qcs8300-v1-0-38a8aa08394b@quicinc.com>
 <20250212-mst_qcs8300-v1-1-38a8aa08394b@quicinc.com> <wyd7i47pkafa7n2yjohuvlh4btasxle4rw5xm55h4bhv24yvah@pfo224xz4xfl>
 <b4008932-ce56-4cc0-9b53-2253051514da@kernel.org>
In-Reply-To: <b4008932-ce56-4cc0-9b53-2253051514da@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 12 Feb 2025 14:26:02 +0200
X-Gm-Features: AWEUYZlVhAIT2AG6Qef-78nrtu6QQCvgOuZCQwLtZcDIi0z3rm5hNqs2iPwtYUM
Message-ID: <CAA8EJpoowyKcwDQgbWy4xGHzngNQOcWt_z_Xc49GFB1qYjYO6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: display/msm: Redocument the
 dp-controller for QCS8300
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yongxing Mou <quic_yongmou@quicinc.com>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 12:54, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/02/2025 11:41, Dmitry Baryshkov wrote:
> > On Wed, Feb 12, 2025 at 03:12:24PM +0800, Yongxing Mou wrote:
> >> We need to enable mst for qcs8300, dp0 controller will support 2 streams
> >> output. So not reuse sm8650 dp controller driver and will add a new driver
> >> patch for qcs8300 mst feature. Modify the corresponding dt-bingding file
> >> to compatible with the qcs8300-dp.
> >
> > NAK for a different reason: QCS8300 is still compatible with SM8650.
> > Enable features instead of randomly reshuffle compats. In this case,
> > enable MST for both architectures.
> >
> So the original patch was probably correct...

I have no idea. I'd let Yongxing Mou to comment on this. It would be
nice  instead of getting a lengthy explanation of obvious items to get
an answer to an actual question: is QCS8300 compatible with SM8650 or
not. In other words whether they can support the same number of MST
streams on each controller or not.

-- 
With best wishes
Dmitry

