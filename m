Return-Path: <linux-kernel+bounces-360162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1080D999551
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412131C2173E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A761E8829;
	Thu, 10 Oct 2024 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5v+C3bF"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BC91E7C35
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599823; cv=none; b=MKp5gpEUVZXcxe+bNqAcRkWxIOsSMltKlrDMmVorQzTLJJkf9RaGzXcWSzqoW4vvODJq7gcB6ZAXIwXxVCTOdfrXggMUd/kznZSlLkCy9N09p1yFRlcHXLzyEEeaUKGQ18VxAAfoi+CNSrrZZYiIjhQ32nY9h8GLzhfBKxrSJks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599823; c=relaxed/simple;
	bh=ELTIZpa/nLA7FG1SYG2wR8cL7xe3VKiueavOjWMz2Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZL8Iy7ZiPox9y+maHwIgi7vjzHTsz1eA67Hf/nq4SMNKTXD410+66WCKB+JIbmcnJO+LbUKCkKH7/WOPEyuagiEi5JAQNGh+UbJixySTzuOo4IGvYIPaZnHwERodVzsmJVU/XRy619iumHq7Yd4gjct9XuLKr5hQ9UFN0mGDnMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l5v+C3bF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fabfc06de3so16085681fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599819; x=1729204619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otakXsanXUr8ItyEhwzCKI/sGAGwRsLWsuVYvQjRYBk=;
        b=l5v+C3bFFbbTIfTum+xLlonRWPHEWLB+De1cGtkdEak5P4Y2+S3bkUzik1Lglrwtvg
         48/sAq3s/I7aLZcd4kSBrEVTQv5Iph0D/8E/+H8NVNjsNjLjExrl+7iLeUnKjCABCVA+
         dKmISEKLSr1GZQIqZMGx/Dw34T/uUOYogELjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599819; x=1729204619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otakXsanXUr8ItyEhwzCKI/sGAGwRsLWsuVYvQjRYBk=;
        b=BvuhEPUMXQP6hHOQ5GYG/k8XPIXmHa7AvabKDTEDtRSct4/2ES8+sFj5k/6UWIcUr1
         SQJcL4n97qGFkkYrtSH6KSpuTxy6ZPqk/u9l0CaVNFFEqIRGo8xZJ1eqRlrXeZUAPr8P
         5wMcA0C5D86yDEQb9iI7pqbajVUoYSXfkaZ81JYY3OhmkRhnHu7eXMjo4spmPIRJxYF9
         UbWzkbjBTizSn1W6HKLX+OiJdMKaGHXwdFGUadJV2uQmJkpLEJPR2eSEhyGqyGTDHAQ4
         EQ1Tjxe3qIYe42rLWKL3GJGI+pLYL9TngY564CKGudyBdUCBWLkPPsobklAT4w1YSG8G
         D+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUPi8rYEfXzr6c4gVTBdD9uUjqbd0xvXr1aAy22yj5nS0xr1QxLw5g2S4jHafrBMPdPmgZHG2KcMymaML4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2PcgkNz5ceXMcf0tWxt0gOZo1qcZ4bnBK4VN/qyjlQ/kSZsd
	Iqjk8Nq6U9Q3eDvLLIjs+/vSU9sGHSCEOBK35+5Sgnc3vG28MlKLWU+WfhxKRCHrG6/YxHBMEdX
	SpeKn
X-Google-Smtp-Source: AGHT+IFC0DCdG+qXg9YY3ZV2vueDY2+wXc4bnqwFHPx1mgKyE7sBLZS1nwvRDScCIL3Fgj0sjzJexw==
X-Received: by 2002:a05:651c:551:b0:2fb:30d5:669f with SMTP id 38308e7fff4ca-2fb326f69ffmr1826641fa.7.1728599819275;
        Thu, 10 Oct 2024 15:36:59 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24706329sm3313361fa.90.2024.10.10.15.36.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:56 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fac787f39fso15977251fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVcfcIwKXbaUAzXxPa93oxtdQg6m/YZxFuBCIOb98gReyA8+p8s8TDIpU8tmDbOQ/Xj2EuiiBMSEf/jzE=@vger.kernel.org
X-Received: by 2002:a05:651c:221b:b0:2f7:663c:48d7 with SMTP id
 38308e7fff4ca-2fb329b2a84mr1316951fa.39.1728599816013; Thu, 10 Oct 2024
 15:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-10-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-10-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDjZWLDt=1rJWvwt=QWNWhJeNYAfhgDmLBiH0xiq+FjA@mail.gmail.com>
Message-ID: <CAD=FV=VDjZWLDt=1rJWvwt=QWNWhJeNYAfhgDmLBiH0xiq+FjA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] serial: qcom-geni: rename suspend functions
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Drop the unnecessary "_sys" infix from the suspend PM ops.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

