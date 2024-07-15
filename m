Return-Path: <linux-kernel+bounces-252428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB069312EF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A35E281512
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3A16CD36;
	Mon, 15 Jul 2024 11:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVnXAzCs"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05A1F608
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042280; cv=none; b=Fof1XI2gXAEaNCGE0iJ5tlGkOPCTYTHNCBhR0p1LVg/haDmiu9oNr0c72ACbqQ8Za++MhQ7YHQiJcd4OpIr3t75MkTZfVKJSBL6XQJmw4ufeAY0RNwlaQeGMgKM1/Is8AclxED47QUC3lQgtEQ2Ml6Uzc9La3arQ6/gdHEXi7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042280; c=relaxed/simple;
	bh=F6nPlNFjvSL5hHKaGrRmsMQTJQxHkN7LmQRO1aSkssc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/FdOS+PNDX/ut2noXw7gu2jYtPx4nnY2ggVo+TQAyPwDvcyptzqjhTjR7QL7CJb8yWogpo1eDNvngacbAzVxtM84yf9rr6vCZCJyFol9poCoq6srs+PLzb4bGl3W7Ik45x7vvOeFFWN9DncVT4F7Qgm5zmunYZE8WTeZKAjIn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVnXAzCs; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e0354459844so4199292276.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 04:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721042278; x=1721647078; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0nsMHYvyytvB0GcQcRWQhieGQMx8L/l5mGgk1F9IiI=;
        b=MVnXAzCsfhZEPtwFLcMjltELzRMY6ApC2/zYeBWgQikVmyAgeNjO2NdYGynJ5zSkrL
         RunPhGA7Xw4F3hlby5PHbTSXEDypY+ehP4qzEuoBrza3UdA8+6acQyY/sjxMVdTGtNw+
         Oq5SlKdBfqK657Q0s0F9u1QItDvMDAMTS5pTnB3O1CDfdvzGtlytVtQpyvaJfsyuaWiX
         jf8IKo/ALPOKnFOpiW6UIpV8A7/Zj+kzRa9Zg7EVmPWO1axcg3dqZD2QUovC7mpdihME
         foGJ3LYKAq2UAJBqHae4oZpWDAVSMPQYueO9OgAVVK0wXpt2J54XEEhAKiBHBhCqvf27
         sXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042278; x=1721647078;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0nsMHYvyytvB0GcQcRWQhieGQMx8L/l5mGgk1F9IiI=;
        b=ffLeQbuoSS9m7/9Kcv4CqEGTAG5T/q7AbrqybzmwOmfzT2L3dagWuWb4EVJrWj3cR6
         rmIlwznjcyXucKSsL03ldTqfYqo64TOyGIf0ZoZpBMQh7iW5re8ft15RGdFLu0N6uPw9
         bmCBoqIl+GyNPoVJ5NdiUQs0hUNZaZzwuCgGxCi/a0mq+cUQo4LKtrUny4EwmHWoN9mc
         I+Dnv57plqjgWXGMY/Ab4nBbVvNKVsPXF+wKXKsj5qZfdYJPa38Qehr5W7KKeMAoiL0Y
         ITN0katizBzH+uuEUm9AeaygZvWpJOVp4d7RMcWvg2aAhBM5+Bq72Tw5MY92uNkcFV5g
         jE/g==
X-Forwarded-Encrypted: i=1; AJvYcCVAimcbI+bjHWhvzIkM8pNOZ6tP3A0iEqGiN24qtEJXoaCemUPnEgi64PejJLNv33s584Ax4v9F6CcDjzUq0PbPZqCTjfWZ9hgPVVmQ
X-Gm-Message-State: AOJu0Yx3WZ2KxJxxPpr/VAzhlV6FCk/5T17Mqyc8fJj8TQJ+0HB5BTeM
	rnxAIv+klXOAllJNzFWx2WuAyI8r3BdMbH2DxwWHsSt1Kx1HbmwPhwR0wB4vGlxRdY07AukpuNw
	3JIc3LsDjmzl9hWYUwON0LDbTG3rRwD7CNohMaA==
X-Google-Smtp-Source: AGHT+IGLXkpZxf5SwZRwilp0h5f1EqxnZ58jIcQl/Dg8fhJhziq7OC9pG7TnHNdfC3tUtLirO7j3kKAjrv2vNsA4rao=
X-Received: by 2002:a25:7408:0:b0:e03:34ec:16b2 with SMTP id
 3f1490d57ef6-e041b11d31amr20722985276.42.1721042278123; Mon, 15 Jul 2024
 04:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
In-Reply-To: <1720763312-13018-1-git-send-email-quic_dikshita@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Jul 2024 13:17:22 +0200
Message-ID: <CAPDyKFosMMAWfiEvpaXHn5X+fEL=Asi=o-YEa9Hj5AYzyoRcHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] add device managed version of dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jul 2024 at 07:49, Dikshita Agarwal
<quic_dikshita@quicinc.com> wrote:
>
> These patches add the devres-enabled version of dev_pm_domain_attach|detach_list
> in pm domain framework and use the same APIs in venus driver.
> If any client drivers use devm_pm_domain_attach_list() to attach the PM domains,
> devm_pm_domain_detach_list() will be invoked implicitly during remove phase.
>
> Dikshita Agarwal (2):
>   PM: domains: add device managed version of
>     dev_pm_domain_attach|detach_list()
>   media: venus: use device managed APIs for power domains
>
>  drivers/base/power/common.c                    | 41 ++++++++++++++++++++++++++
>  drivers/media/platform/qcom/venus/pm_helpers.c |  5 +---
>  include/linux/pm_domain.h                      |  4 +++
>  3 files changed, 46 insertions(+), 4 deletions(-)
>

This ended up being a little bit late for v6.11, please re-post a new
version when rc-1 is out.

Kind regards
Uffe

