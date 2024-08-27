Return-Path: <linux-kernel+bounces-302864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC2596046A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BE27B22595
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F06156F28;
	Tue, 27 Aug 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dgKgZQe9"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE3131182
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747428; cv=none; b=BeCWPzjmD/kq6JFuxbpT6FNVhLafTaTcuvoxcBgej53rSqa3I7AYIHuVRRbwyzsNXg8/Mu4vEy5TxafLltwh/44DYbW53VF9nOVkbCPC0rctL7DIw4y0OPgG6oIFO/dV4b3YKv1oZhYbNYn+lkQtpbLGQmVEl02flbcI9eAfqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747428; c=relaxed/simple;
	bh=/ybs2KnV3+jGgzd+z7IQzZDEcwA6FR9efiI7qbXcTBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FuFZykcdtcQbSVraw1ZXlkBf0id95Xta9p8WyxexoyTU+aUSKImFXGXrjiUnULDR0VYhP3MKSiVehD7v8GYSnn9zq8FJvB92016V8Xsd1ruImyQTZADemgc4xbIGJ2kQIsX0+ZNsVd8Gp1SsgngJWk7ty58bdPXoYt2mm1/7yLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dgKgZQe9; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71431524f33so4387014b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724747426; x=1725352226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEyn9jUT2FpyLYAjHKFMVWeuGnjVkiqgrAa0Pe7cY0I=;
        b=dgKgZQe9htOVuTI1X6WNu9yyaM9Wy5ErCNH37RNE7ciCN/Cwr8McstJJN4lCahUAHW
         O6HfLURtlBrpf5Y+2D/tAR8pfh+V3B8TifVO8zQDKSBHufogxnp74YE8OpxWnn4/e/Zg
         3uf+/3inIt2EfHmLb1qef2PggBi6FKovJ0yis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747426; x=1725352226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEyn9jUT2FpyLYAjHKFMVWeuGnjVkiqgrAa0Pe7cY0I=;
        b=UcxfBVp8Tm1J3INbKayXHzi0+R1+l+iI6GvkdqXkOYV3KZNYAwvHbkKcLNzu/N2Aw4
         OkhL8BkDrG/MGRtVVWL2147LOukOluWrsVYD4ZG0xFo4MbXXpcuBzuuRjtq/dS/JAhLX
         M1Xun9dlpg7avKiuzw11pjoIj6yKrVcmWqiy0+sd6MLnDWq6gCbEyb/ibed61XaE7Uki
         lU/J5sAd9mt2zg8JnY6wUETlQ6Q7sznAbtuDaZWLFfSBsX4qfTOfakLDLTlRLXzBTdCf
         y14mQa5GwJGFZySsbQpSum7esMrG+s9i2zs0A1U1ldv18ECGxQbKOiUuyzcK2ZkpMMjD
         C4qA==
X-Forwarded-Encrypted: i=1; AJvYcCWfU/cx3I3lzjpKquPdt6KDQJ2nvUwCGht8fDk0haxsVJ/ZHsWnMocMMu0dnomhA58fxe+1iGGMK4sP09c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweq8THvmgebJeL20RaT4eHB0+orcanw70J0YIsnQy6IczsXVXO
	l209YEbOgjVzfegis+r8Y6gA1aFqifh1dBDBiDu2Kb2BVNCpa5uRRdP2yAhISgOcsl9//gD086o
	=
X-Google-Smtp-Source: AGHT+IHLxDiKzVtQ+/lkOIiIpV2lHVc1jZlqCUmbhyI2hlryaxYSval91OKZZd7SBCdl1tsUGdTkXQ==
X-Received: by 2002:a05:6a20:2d0c:b0:1ca:cbf5:593 with SMTP id adf61e73a8af0-1ccc086bc46mr2567946637.20.1724747426441;
        Tue, 27 Aug 2024 01:30:26 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a5c550sm11462060a91.30.2024.08.27.01.30.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:30:25 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d1fa104851so1421947a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:30:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgVCy0bFaiE8ZbbUbEwYNc5EtSVzMiDDQ08XXljq9URKDYFAT+8+XS9xEjSpII3fA7WzOTSkwCu1Vvwb8=@vger.kernel.org
X-Received: by 2002:a17:90b:4a42:b0:2c9:6d8:d823 with SMTP id
 98e67ed59e1d1-2d8257c5a7bmr2583148a91.1.1724747424097; Tue, 27 Aug 2024
 01:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823094839.3142472-1-yuehaibing@huawei.com>
In-Reply-To: <20240823094839.3142472-1-yuehaibing@huawei.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 27 Aug 2024 10:30:10 +0200
X-Gmail-Original-Message-ID: <CANiDSCtKMyRoTt7-DVGeKqjh-0R_xB7G7qAAFfCPNcSV-DOnTQ@mail.gmail.com>
Message-ID: <CANiDSCtKMyRoTt7-DVGeKqjh-0R_xB7G7qAAFfCPNcSV-DOnTQ@mail.gmail.com>
Subject: Re: [PATCH -next] media: siano: Remove unused declarations
To: Yue Haibing <yuehaibing@huawei.com>
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 11:51, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> There is no caller and implementation in tree, so can remove them.
>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/media/common/siano/smscoreapi.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/media/common/siano/smscoreapi.h b/drivers/media/common/siano/smscoreapi.h
> index 3c15082ce0e3..d945a2d6d624 100644
> --- a/drivers/media/common/siano/smscoreapi.h
> +++ b/drivers/media/common/siano/smscoreapi.h
> @@ -1115,12 +1115,6 @@ extern int smsclient_sendrequest(struct smscore_client_t *client,
>  extern void smscore_onresponse(struct smscore_device_t *coredev,
>                                struct smscore_buffer_t *cb);
>
> -extern int smscore_get_common_buffer_size(struct smscore_device_t *coredev);
> -extern int smscore_map_common_buffer(struct smscore_device_t *coredev,
> -                                     struct vm_area_struct *vma);
> -extern int smscore_send_fw_file(struct smscore_device_t *coredev,
> -                               u8 *ufwbuf, int size);
> -
>  extern
>  struct smscore_buffer_t *smscore_getbuffer(struct smscore_device_t *coredev);
>  extern void smscore_putbuffer(struct smscore_device_t *coredev,
> --
> 2.34.1
>


-- 
Ricardo Ribalda

