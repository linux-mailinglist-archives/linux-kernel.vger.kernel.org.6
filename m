Return-Path: <linux-kernel+bounces-349520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 232EF98F76A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3A2A283CCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4691ACDE8;
	Thu,  3 Oct 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bIqTpKe4"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3BA1ABEBB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985361; cv=none; b=qxNYaKgjN5/0K3Vi/xm2+/1L4l93Huq4cfXW/DKKBOoMMFipzjja9ktB7HTYqUliMGta91zF9Y9L2uSSYOrDrzix2CFI4ygi86tgocjKTMXlKfuVQ1AirPOyp/diX4QdnTospBsTAMoJACOzfkHohX3V1+HGia7DSmuMaOqkKnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985361; c=relaxed/simple;
	bh=5EccGR70GSzvWHC68nC+X+tqsSbWiKZAhks9ypGfRZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/qNIgDjoRBjzxueb50iL6IoCUTowmMrJI/giFnbaMgPdbE3snEAqKFfMHzU3KWAVma5KyXhPTQdirIV0in37d3o8BWCpnTs4hfge287cJAnVnNDILnvBn1Hspdm/EWxtQCsHtCSsjHypv5rqwxrknVnvUdx6iXb7OStUMerANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bIqTpKe4; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac5eb10ceso13646101fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 12:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727985355; x=1728590155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9YMrf0Tzihdplb/RBKwiSK1PmhTX7h2pmpItk8J4v8=;
        b=bIqTpKe4iyhZq9xmUzl5zpJ4G6fRhduh0q3wJWuWhPRbQ8V7ZG2XgbBUYckU7d8esV
         OW8N6Ba9bL1VSaCVUiVLmhAe+p02FPJP7+id43p/HrpbSaPYuLl3t6DA2/4e+AX+4aiv
         rq1WE0f0FRxqzsO/nvvE1+GHW9QLQRoSJ8mjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727985355; x=1728590155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9YMrf0Tzihdplb/RBKwiSK1PmhTX7h2pmpItk8J4v8=;
        b=F1TYFoQZFvO17eT9JtffH5BBR9wPN2jAJj7vr7e7wA+8ywvz/RFDXYznYY+s+Od18e
         jqEStdFh4P5fGjFeQgk223V79um9RZ7Q1nWy55Y0jSVHV0wLWmQVLEkjuExAuYZ7HXPF
         N7y6ufTfHzGpUl0QJvg2GmvULH0o/C4xF3Ks1yQnSTZjQtsAuSPY0MljasMsbaeJ8CYv
         BItV8Nyoqe31D21f9QgYFZaeG1FgODQ8dX61XnmW7mCDJGaCyvTKGrU5h6c2B1N94HQb
         jPNAhYslcq3dFXLnLvj1B3V27JgYQawOckN2BydFwEY2IoNTmuCw5oWb1YlEzZozI/Lj
         kOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVieafQ8wPWOjvdrgRuELtK8ilGBiuJXoIsq1h7h0/fmu5+ch4xEtBuWJ4g5gubhJ2glKqNgMztnqztps0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcB2sIWVTV+ses12nImHgniYDh4f+PlngNHdB3yuUO8FiJgYuI
	/4lS9SgH/fODZYVRL6Qb7d9WvtEbiR+TP7eBfIrKTA536NO1yPCySqVOtIc//M+GC3N3IPXjvF6
	jD0az
X-Google-Smtp-Source: AGHT+IG3d9WSLT4xT9dhRVKAuYnY74Em7/zTicRlbltSXdwNl3PNjLy3S2gGYA/Dc3F1QL5v/lkxWg==
X-Received: by 2002:a05:651c:1546:b0:2f3:aac3:c2a5 with SMTP id 38308e7fff4ca-2faf39a01femr973701fa.17.1727985355212;
        Thu, 03 Oct 2024 12:55:55 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faecc11772sm2753011fa.62.2024.10.03.12.55.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 12:55:54 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so1442238e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 12:55:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7iWWErFtYZjYtZeHYr+MsR0o8hR+uL7u8lkLnVaxpjZPrecKGeItMrTsJmKLH/GlYvUf2IjjgcSDY4tQ=@vger.kernel.org
X-Received: by 2002:ac2:4e06:0:b0:539:9476:25a with SMTP id
 2adb3069b0e04-539a627ba0fmr1592030e87.21.1727985353524; Thu, 03 Oct 2024
 12:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-6-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 12:55:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V9FfwKREBfBbCRiqH3y2K=oTfQPj1Nx1paxrVwFD-efg@mail.gmail.com>
Message-ID: <CAD=FV=V9FfwKREBfBbCRiqH3y2K=oTfQPj1Nx1paxrVwFD-efg@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] serial: qcom-geni: fix rx cancel dma status bit
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Cancelling an rx command is signalled using bit 14 of the rx DMA status
> register and not bit 11.
>
> This bit is currently unused, but this error becomes apparent, for
> example, when tracing the status register when closing the port.
>
> Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  include/linux/soc/qcom/geni-se.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/soc/qcom/geni-se.h b/include/linux/soc/qcom/ge=
ni-se.h
> index c3bca9c0bf2c..2996a3c28ef3 100644
> --- a/include/linux/soc/qcom/geni-se.h
> +++ b/include/linux/soc/qcom/geni-se.h
> @@ -258,8 +258,8 @@ struct geni_se {
>  #define RX_DMA_PARITY_ERR              BIT(5)
>  #define RX_DMA_BREAK                   GENMASK(8, 7)
>  #define RX_GENI_GP_IRQ                 GENMASK(10, 5)
> -#define RX_GENI_CANCEL_IRQ             BIT(11)
>  #define RX_GENI_GP_IRQ_EXT             GENMASK(13, 12)
> +#define RX_GENI_CANCEL_IRQ             BIT(14)

This looks right, but do you want to fix all the rest of the wrong
bits in this list while you're at it? Things look OK up to the
"RX_FLUSH_DONE" and then they're wrong. Specifically:

* My datasheet doesn't have RX_DMA_PARITY_ERR. Unless maybe it's one
of the "GP" IRQs?

* My datassheet doesn't have RX_DMA_BREAK. Unless maybe it's one of
the "GP" IRQs (though why would it be two bits big?)

* RX_GENI_GP_IRQ is 12:5, not 10:5

* My datasheet has RX_GENI_CMD_FAILURE as BIT(15).

In any case, this does make it better so:

Reviewed-by: Douglas Anderson <dianders@chromium.org>


-Doug

