Return-Path: <linux-kernel+bounces-220558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4326390E3A3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 560741C23D19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99B66F306;
	Wed, 19 Jun 2024 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HkQIOB33"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E726F2F1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718779259; cv=none; b=BfQwljPwYs/tjLQbu7vLyoq6tv5xJz+HzB3TJRecQww2EMq79wSAXEJ47fyddlhnGe8k+8AbQLqEZ2ynHcfc9fdPgny6T2RgQUlHDItFc6xNy4GA4ufRVTC4DjjPrQpRHrYEkF46gV0PTYGzmK7GfrPHu9ZrdTiiAOZYtoX9Y40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718779259; c=relaxed/simple;
	bh=Amm5o9HpN/p9e2dXb3SmI0c+zPL4yvUSzbUR12Jkknw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kp0KheTCWbfCYIgGbO7BTCZ28Wdx5NL4u2fxXqBJqrb+Gz1q4ZXV+7TUuzZHdESo5+X8fOKMrkUz7116elaF3+W32yWK71AlhvRNGygijtbrQ/66+GYKZEegiASw3LSoVpEcbVxC9sH+iYkt7EDE/qc4JlnEzkd5T2QQGzX/bHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HkQIOB33; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c819f6146so8194673e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718779255; x=1719384055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xWG25TSy/I1an8iywuQb5G515alr24rVW8FaitaN0eE=;
        b=HkQIOB33cdCGu/K9qfu6OK/B55xzQhzAzj10NG6Z2Jof5H1DTZ5hwXzEwdZUXgAgi7
         /KNVYKvpP5RJTGZVkj0fSNIzF3kYRdtpIwa87Zr2SEgTIDP2JKGmZqrKMNTCgGr+tpeO
         7/y2VHitLADDcOk8quzzt+yuuvgMBndV1aBfFHJzNpnpvfCbzsEMQ08NlDYi4BREcAAz
         b3Xra271LiJcFcEV/Q1xl2qkR4sGfZonEo+LT0xn6JuwAW79xwZ9UqbkJiWWyGV/Waay
         aVk3QgFrdn4aAbHT+nBoJqIalFMkmD03jYlVY2aVbJ20Jw2UiODlnJ+yglKQIO6mVlKN
         O5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718779255; x=1719384055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWG25TSy/I1an8iywuQb5G515alr24rVW8FaitaN0eE=;
        b=YAO2c8UvdoWOdkkYP0eCM4L8xcn4G6X/h/VBt4CJO6iv3WVQfYyx5Xo200aH1i7oxt
         MUE5fbOyI6fGJVkpJvNmLV8aZ1N3CmtlHY5jun8MmDLev2vture67G+vezWYm+NCK4VY
         FWFD9PslU7n0AohgsnunQ1j2XL3F8ZSqlbpwI6x3yBITBveV+9ORuSQr7eWJ4XdY7D1V
         bTpWzebXlM6B3Z+tbOVzp66FDH6XLom1s0qezWZCTH/2D9uxAuUpgYnpRrsIpApgCTCA
         w+kzsTbZkDpTv0Qd+39aPy95Z9RmHqzYhKObQ14HfW5ReSyhOSKHyrVJAIM4fue9aDmr
         tqrg==
X-Forwarded-Encrypted: i=1; AJvYcCVKfm/AX16AAQxoBkAB5ifPKWCSr8x6nl45b2Fgmr+ih7miJ/WgJhzXGFeasrOg5QEE2TA4oyWLiTU9c6oxkKE3KOR2Guxw1M2Dqo/0
X-Gm-Message-State: AOJu0YwFwLheIgMrJh5zcOH53FgVeIOjTaw/gkxieoyf4Ih3qx/lxRK5
	tHkdrSQoUi2X+I8r3TroBHuwoshzUDobLTJnoVUMsFPnv2TzEcCKR6TQ0XLnWkE=
X-Google-Smtp-Source: AGHT+IGk6IXrWafiMpJhwJp502XVXsfcrZRSyivv/fv5wSqT4lGqJPeuk+T7bbUxsXGwqLVteywdtQ==
X-Received: by 2002:a19:ca55:0:b0:52c:b239:5719 with SMTP id 2adb3069b0e04-52ccaa6284cmr1005490e87.33.1718779254701;
        Tue, 18 Jun 2024 23:40:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282dd55sm1730660e87.65.2024.06.18.23.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 23:40:54 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:40:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 00/10] media: Fix the last set of coccinelle warnings
Message-ID: <4fsxowdpaeaxcnu7aewif6yqqk3jdgsjtksbznv2arnmmtiaq6@ibzf2qcel5lc>
References: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618-cocci-flexarray-v5-0-6a8294942f48@chromium.org>

On Tue, Jun 18, 2024 at 01:37:43PM GMT, Ricardo Ribalda wrote:
> With this set we are done with all the cocci warning/errors.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> Changes in v5: Thanks Vikash
> - Remove patches already merged
> - Fix typos and remove hfi_resource_ocmem_requirement
> - Link to v4: https://lore.kernel.org/r/20240606-cocci-flexarray-v4-0-3379ee5eed28@chromium.org
> 

Just for the clarfification: does the driver build without errors
if only a part of the patchset is applied? I have the feeling that first
patches introduce a build error which is fixed in a later patch. If
that's the case, it's a no-go.

-- 
With best wishes
Dmitry

