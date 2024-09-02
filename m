Return-Path: <linux-kernel+bounces-310801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A33F968166
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AEB81C21D09
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 08:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44869181B82;
	Mon,  2 Sep 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+i0/ZK+"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B017C9A3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264652; cv=none; b=XOdiHfLXm2D+kJRpV+rZgH4MRvevSpVcDb/CxIxN7SWbtbCn1zvtNiI9mJZdicYjas97Y+oqe38RvMT7H4+T5I+1pkq/RzMQyM9kTuCjSf/I/Ra3qLfkHpRtiuAXb+hHa7VTYvh6Nm0Ku6iwPvyz9/CZS7nIjmQxK6vPCHA0XQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264652; c=relaxed/simple;
	bh=AdsGMr7gxqPB4h3d+Dvjk+7Zml3v1WnZHyQAGbwqVVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ho8buqrOGzvdQxpfiejy623Qj2j1GgUZ0jT8933S6rR7YJp3kQwCy6YDT9zHd0PLHYnU/y5bghYuWXfMZNZv36CM9micSSC7J5pygtDlX/MZHFEwx0DlPm/I6t5DskZzOf+wE9gAc+3DmM1yPX2dy7CZ/uw/5tPKyJuabZc1mGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+i0/ZK+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso40694151fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 01:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725264648; x=1725869448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdsGMr7gxqPB4h3d+Dvjk+7Zml3v1WnZHyQAGbwqVVo=;
        b=d+i0/ZK+WkyyHU9yrrkbqK+Sn1sCmkkgKZn4+qr0dY+AC6lJq3sKEpkItEmL0Z99+h
         SqY7QNHzgP7uK/4pGPmtL3zyK7U8h3BS5dS/hN38IxZoGCpiokUQydNbIVVrmXxk1bnQ
         YRrNfI4tQ6b6p+BOmY0HkG99NJT1SLLMpeVzW6qwcahOzligZd/OMV0qOitlWh3jGRs3
         BukSTUS3a0CYNZV8gyUf+utOuKHV9vGxCGWvHyXbsXPkA6q7CxoQe75jd2Mv3D1uv8k+
         htjlM3SNxixrwZAjoq7zb3tLbGnofmZMQt/kTg1x6bsVnc27O2utChlQ/71QFSgegMOH
         wIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725264648; x=1725869448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AdsGMr7gxqPB4h3d+Dvjk+7Zml3v1WnZHyQAGbwqVVo=;
        b=jiLjXQ5LBSSprWXnt32+X98WC0GE8oWPbJoU+FljE2wwIoNB6KBuzSchMkxA1W/LW4
         WEUTlXhWZc8kQd5QGunzFyuYgKZuFUi/5tMvwZl/mlAdVM4R6nM8jM9BGcM7b5CKuhLr
         wOChVtrCG2YtQ0HVhP4yTTl3ZnUbAgh/4W6e/Ik792eQ4X+PwzlQKbJyzMKXVTbp78R7
         OTB1laXSwys7RuKXY6GHZve3TJmyDxOr9xGGacqeOr2zMPRQjTzmc7+AumDa/YcRCbAb
         tLbBq/MN9z1EPWY39q1b1NhcdArsAZG8+RoRSCZVXzWBndLVFzg+NbyKEUQMUJh4QCj+
         wLKw==
X-Forwarded-Encrypted: i=1; AJvYcCVk3eMvqeECvk18EfMuxgV9445Q4thp9OCwh89ZSdVNu9PgFJt3hP+YLVwX3ORXLUOM4zg5SbKnqUVKKJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFPlk5UGpQk/joendyP0PiwCuMSBWPLBQGzW+W+CtDG8YKTxe
	6n8TjobwTlzAWJZuCg5bNc2LIhpvZis3vFBHiuYvDrb8om0LR30fhUe6Rrng8lvW116BHgI6Pqz
	efKV3TPIle+2cM7RYb+jH1myg6zrRWzo5wtHwEQ==
X-Google-Smtp-Source: AGHT+IHFRswwBMRfpnSBGjnL8qraQNOUMmO123dAIdL8GyErVz0HZLjtXlarmVP+fTTg0i2Hc4w+tCUT7lTtDEx5+pA=
X-Received: by 2002:a2e:b8c4:0:b0:2f0:1d51:a8fa with SMTP id
 38308e7fff4ca-2f610891549mr93093651fa.30.1725264647333; Mon, 02 Sep 2024
 01:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829064823.19808-1-wangjianzheng@vivo.com>
In-Reply-To: <20240829064823.19808-1-wangjianzheng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 2 Sep 2024 10:10:35 +0200
Message-ID: <CACRpkdah_8UAFiyz_CtoQgFKmxvJVb3tr+O3si1g4o0Mpfj6gw@mail.gmail.com>
Subject: Re: [PATCH 2/5] pinctrl: mvebu: Fix devinit_dove_pinctrl_probe function
To: Wang Jianzheng <wangjianzheng@vivo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>, 
	"moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,..." <linux-arm-kernel@lists.infradead.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:48=E2=80=AFAM Wang Jianzheng <wangjianzheng@vivo.=
com> wrote:

> When an eroor occurs during the execution of the function
> __devinit_dove_pinctrl_probe, the clk is not properly disabled.
>
> Fix this by calling clk_disable_unprepare before return.
>
> Fixes: ba607b6238a1 ("pinctrl: mvebu: make pdma clock on dove mandatory")
> Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>

Fixed the spelling error in the commit message and applied.

The remaining three patches didn't make it through to the
mailing list! (3,4,5)

Can you resend these three? I bet they are good patches too.

Yours,
Linus Walleij

