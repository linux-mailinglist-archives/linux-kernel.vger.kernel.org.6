Return-Path: <linux-kernel+bounces-416748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0059D4992
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15CBC1F21D73
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71D147C79;
	Thu, 21 Nov 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3PG1Gv4"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401311AA1E6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180160; cv=none; b=hFdb/8VkqvV20FX+xX4/CF2LBkYUYgFdJScPfZqm0UEZIqn4FV7ohTMbOELnASwNypGWSxeHjnTs9KnHAbRmMnxdTs87IRE3ortAXb8W4lCUIuvrqry013xhqLTu+Ly8Od/Ag/eRcCvKM/KyO/UAowXXrE5696X2MGPoUchvGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180160; c=relaxed/simple;
	bh=ZAyrck5tlQevYqpMXOTskbTcJyaWO8Hs8gXBxfr1uf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Adp29TdxCUMkIKcxo97JVEUzze4B90DSZfqgcWRph7rD/jYC9hsC+y2w2pmO+XX0hN2P9CQk24V7SW/7RjdyFdj1bR3XTGyuSwJd0dE0eKeUFZPuuK7oShI7Mf0vOpKO06W98VcIRJaTlpc+0Q+S3cpNt6eFD8lEtzrnsJAp4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3PG1Gv4; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2965e10da1bso376115fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732180158; x=1732784958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxHbi6ASfjiq8iEPoZc72oeQ6cf3BdSdOcjBRpGls9o=;
        b=X3PG1Gv4pozV9GCqt4ynVNV7RV23xK1HTQ777xWKR9yvvModLnnDVuf0T9zgxd+tXG
         sVSdH/RnLhRxpH7asqIrkyp77vkmK4WFlaaXJPhQ8bnXvINehE8LWIUIn2RyVriFE5bo
         lwvM/GvTcOMSYuf7kGgQJ02vEvnprNAGtD46DEeEEyE1/+sYYH7CGD8xOTFvgPXlPkl2
         0Is+I3emjxWcHOk32waqVSmF1AvOTwJ726UBECkqpjUDVAaQrDCZBzie+SR96eZxXf7Z
         BRZfnfwTDs264yEwoUoQM7LFtHbvvksevORwbEt0wqYpWurCEVEuQUSsyUCj46ld56Ll
         jlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180158; x=1732784958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxHbi6ASfjiq8iEPoZc72oeQ6cf3BdSdOcjBRpGls9o=;
        b=AnH48RCK5k+pzFDMjrUV6rEOqK7WF2vIuDgJlljqjuQyIhQoOUs1CCIbNakiGZFZmN
         QFXV8LNIYz1c2KNc/MTuB53vAiRv7mYjP7ZYhDqeWZnC6/0GaNyHlzIjR+ouFUoEvren
         xacn5LkDjTzPQv1lp+fZ/PZWBEaSxBxVWxWMNBcqY/Gw7J9yHCJqUcsHG0NPF62F+UVj
         Q7qIdNMy3KMLW8Y6x77xcVubHv5HAIYWU0SeDJ7i6RXfcggsT2y72jT4XK9ExtysxrOH
         cPCjMKzjfemfWehsyFdCNX67k/mrP10V7t3+BELo/LlGbdAx2QNPkOdLXI4BwH5ovrrr
         soxg==
X-Forwarded-Encrypted: i=1; AJvYcCX88QW1caOwFoMtHHRQFzA1FMLFJvT/tEnqau2c84qkWYWe2yI30V324BfzRv8IZDkh5aSPzXymuwk705g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH0NwfIjjJmE2x0uA89E0eI1C8A0EUxjOQcG3Zj3FuD7v/opzP
	dKG0BMqeIaYRduaKT6CH5+talkJasHfP4NhrxdYvqVhfwCcYRkZht0NNvIyCAuzPUBECPkt6L/h
	wc9YuE72kp9q1Oo87iTGPvhyvzJ9iTV/acRVx+Q==
X-Gm-Gg: ASbGncuX8zkgZ7O/xdXqKkqy5COJk5rJnkbqYna33npMpfTRTFZKZOTm+xXTqiBd59Y
	Y6xRvL8B0yJuLTHBZ86p+o771V+2Y/AyoUYlE1NgcGcAHTLjcEno+qFJ9Vl5oNw==
X-Google-Smtp-Source: AGHT+IGlBrhM1he89NTY6gbHyTFxW/0w/9MnZ6DHduJEKWDUclBwVD79cdcU9z96VzKNIRfTYH3d9MO2sG8QjenfPWw=
X-Received: by 2002:a05:6870:d914:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-296d9affe47mr5902908fac.7.1732180158357; Thu, 21 Nov 2024
 01:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
 <863ba24c-eca4-46e2-96ab-f7f995e75ad0@gmail.com> <fbb61e9f-ad1f-b56d-3322-b1bac5746c62@quicinc.com>
In-Reply-To: <fbb61e9f-ad1f-b56d-3322-b1bac5746c62@quicinc.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 21 Nov 2024 10:08:42 +0100
Message-ID: <CAMZdPi_FyvS8c2wA2oqLW5iVPXRrBhFtBU8HOqSdNo0O1+-GUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: wwan: Add WWAN sahara port type
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jerry Meng <jerry.meng.lk@quectel.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 22:48, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/20/2024 1:36 PM, Sergey Ryazanov wrote:
> > +Manivannan
> >
> > Hello Jerry,
> >
> > this version looks a way better, still there is one minor thing to
> > improve. See below.
> >
> > Manivannan, Loic, could you advice is it Ok to export that SAHARA port
> > as is?
>
> I'm against this.
>
> There is an in-kernel Sahara implementation, which is going to be used
> by QDU100.  If WWAN is going to own the "SAHARA" MHI channel name, then
> no one else can use it which will conflict with QDU100.
>
> I expect the in-kernel implementation can be leveraged for this.

Fair enough, actually the same change has already been discussed two
years ago, and we agreed that it should not be exposed as a WWAN
control port:
https://lore.kernel.org/netdev/CAMZdPi_7KGx69s5tFumkswVXiQSdxXZjDXT5f9njRnBNz1k-VA@mail.gmail.com/#t

Regards,
Loic

