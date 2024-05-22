Return-Path: <linux-kernel+bounces-186770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E338CC8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C005728263B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6615B146A6F;
	Wed, 22 May 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L5GcUjJr"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D3146A7E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716416000; cv=none; b=ItZ6WRhJasI1GjKnAEPQn1Co4iWSvrzNP31fzAaWmfCu72yroHYR3oma/S+ByOkDtTaIzfGp+TN+zayGhSJHQXVEKGKk2LsLfwo36erurySIOLy30ouxyiABx7NCkl3YmwPbzh0ZPuSSQhiMt7aXtGywNNfCypHkHZa4/5VVAG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716416000; c=relaxed/simple;
	bh=YOJPhPBNVLdaAo1qYLiUsZbTsEXU/hUCe/QbH6GPyik=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5f6r5YmJhkzOlDNnvV0do65g9aQTzIrROz3Z71Qeb52V17I7hXvIsYjy3+lGivKs0laX28Fg6cRT2PuHzXR/z46fj7oP6u7zJKhsYVigdNemzl6IImYplurOa0D1YzamN9mde97aa6NnLXQYjG09tQlwOUZutI9PKcB2/wX2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L5GcUjJr; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-792c031ffdeso470728985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716415998; x=1717020798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G0yw445eZNI0Ov1C5uvraWYm6H31vdS3UWaoIxWyhXI=;
        b=L5GcUjJrFeUdcxV4ha764df4rDhFOP/Zyn5OCkKUO/K9ZFWN+7MjaRv94T6wEphgaP
         /EeTtP5oeha0pfLS0niZ/sRO6SMgTwqrcATJhd9JyBq9rZmTJN5KbmE+RZFqIJKdD2zB
         JX29Yryf828EdBbgp14K2zR6ln1cRK0PKP6KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716415998; x=1717020798;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0yw445eZNI0Ov1C5uvraWYm6H31vdS3UWaoIxWyhXI=;
        b=eMWg4It3hxYuVE3FSBQ/zHvxm8DioofY0/THJy0WEtODeud3sK83qGe4GwTpIgiAta
         FgMT1q1yPyxsFxo8VxzgFdCuu4fBKfdDW44XTnArLTZbPxZTRFlY41xTaUWL3t1/TjZ9
         pjSZGZ+vn5NItPxOyoZ3ocV+mgm5ybahRwYS+9LSOWp6hadRM/luIifqJQQ1QZ/KmyH2
         WMkrq4Oxdh+Hta8BVChx+WvPlueZogowx4gM93MSpURTubXscSSMJBRpj6feZXsVWKUq
         DR7uVFoet0YhB0jfUBH+xVeTwPT4TALN64BJnHvI/e7ggnEilXNvCXZ/m9o1c4mM0jvr
         GvWA==
X-Forwarded-Encrypted: i=1; AJvYcCVAkIt7QFRBMLEjGGRD50tnctOCS3lhEvVofPfKL8pCNmpUQtDB93MsEOHj8Gi2TY7w5PqKuFY1GuApgnr3EPQq8PuerHJh+/TPs5w1
X-Gm-Message-State: AOJu0YyDDHX7O/uxUUrTsKyGP+QE3dInjA51Xnxe/ZUp1ofa+RvoBacI
	w67+4wnFryZWddbrj/CDf7eUSqUdArPpt0bEwE89bl+TIaac+QI2emUqCH0zjrGm1X6Uxi9MdCA
	Phe5nhnFIijM5rnvA3YtLdF8/dSiH4FOemzQ0
X-Google-Smtp-Source: AGHT+IGmjkCQXz+RTwsJXVyVlj1mN5OAUd57w+Ue3ubYg935P8+YuFTsLQDxZ8hiJZB/4tzj2HzSG+4eVqOwa3dZ3wg=
X-Received: by 2002:a05:620a:5648:b0:792:d51f:2d38 with SMTP id
 af79cd13be357-794994d058cmr317259785a.77.1716415998216; Wed, 22 May 2024
 15:13:18 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 May 2024 18:13:17 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
References: <20240517170246.1.Ia769fe5fbeaa6aca2edfb01b82eb7df0c6955459@changeid>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Wed, 22 May 2024 18:13:17 -0400
Message-ID: <CAE-0n50=p-XvueHV9m9c_1H-XwsJgEMTNNi1OFi=aUzNC-s65g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: If memdump doesn't work, re-enable IBS
To: Douglas Anderson <dianders@chromium.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: Guenter Roeck <groeck@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Sai Teja Aluvala <quic_saluvala@quicinc.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Douglas Anderson (2024-05-17 17:02:46)
> On systems in the field, we are seeing this sometimes in the kernel logs:
>   Bluetooth: qca_controller_memdump() hci0: hci_devcd_init Return:-95
>
> This means that _something_ decided that it wanted to get a memdump
> but then hci_devcd_init() returned -EOPNOTSUPP (AKA -95).
>
> The cleanup code in qca_controller_memdump() when we get back an error
> from hci_devcd_init() undoes most things but forgets to clear
> QCA_IBS_DISABLED. One side effect of this is that, during the next
> suspend, qca_suspend() will always get a timeout.
>
> Let's fix it so that we clear the bit.
>
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

