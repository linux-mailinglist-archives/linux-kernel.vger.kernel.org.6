Return-Path: <linux-kernel+bounces-253805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B00993273E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDA22808FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8899199E9F;
	Tue, 16 Jul 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PMXN53hx"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF017CA05
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135719; cv=none; b=p30QMFg1TK5km9QTo5EK54oLIm9DJkQPWE5AZ8RdgEgqY9bYDDk0PSncpnE4Xw8Jaw3B7IA5hYu+7eE/89imEZDw/laliZieYbm9MCyWHfSYDaoflnJW8Oufq6phB7pu1fTnxbMy+OD7dX3KKz3sVRIduA28zwP0COefiIAljYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135719; c=relaxed/simple;
	bh=d6tVEyM4+zfsQ3f/Lp21lCQNFXCnL5duwmm+qOIsJ4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0ZuWqQCansycdFFRs7F2+GR90xfxB++M8JjAHnlkqidxrpzq2FK+P+8nKqMsBHIdfbt2LdRqZESB4w8jPIe9eq/kyqsxD/SnXf+DMZ9rkJf60KFeLdV9dwcNGjUIm16WVL8nPmYy0NluNgbE0eTH6r4y45fP+VZKfCx9kQ4jbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PMXN53hx; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0365588ab8so4824256276.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 06:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721135716; x=1721740516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nsbTKT2fsyn57FNCsAGBNDGfhW5cbmqj9qjWElmr/2o=;
        b=PMXN53hx9J8Cw2qI6JKeCaYmjC7ohmVmzHbF5QHVGPGrpSg0vOi+qLBZ/LsKnSRVlf
         SwYhn3ODIUC0CNMZd6/tPf+h9TsXYSpr/ZTD6sOd1szdU4l64dV0LCb31CC/qnSoCCaR
         JNV8O+4HMC+PituhtGeybvQd6+evGPlLl/FL8NcRNZtjtiD1fvjxyrDXVNXO6p6bQtaj
         v5Rj5Se4bwvuZ//xoMwijwNSQ9wBHFK2fkueskiTHPda8/0nqXyulYskXk4xwkLgcumO
         DJfK7g2nB7VwXiPYq8BkekLmsyINFkfQEOLOrCJQXCLWSx9WmSTWKlqxQvhf/puNBBtm
         tF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721135716; x=1721740516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsbTKT2fsyn57FNCsAGBNDGfhW5cbmqj9qjWElmr/2o=;
        b=ciQY9rwHU+FBEKaeIAK5xpBUpyd4jHkMgNpYQU4uecNg8DK4zaYTJL2jp3sbmoAa9s
         6iYsFfvOzoNB0q7bnt3eEfWXL4qoL5XBhUO8eAX2cm7LTLjc9aPBov1Bo4WocFN5ofZe
         4UlA8fSMnjPQsdr7CIEUhMa1AxJFraEw6qeNc5eshOfyk1/R3D3yDkf5FHWd+wb+0ykC
         tKAAInzaSstw2nVYyPN/yowDrRCOFOGP9I23R73wwqTmBE7MSn2gO9MBK7+83wYzHVZR
         3GVwBMNI5fkXdh/7cuj6QxP/Fkmuu1p10YRwLOjqg9INSJIr3Squ4juWk6kD+kohIuRF
         1N6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeUrV+ADINUSK5MwTfqCx7OnkkdemM/jWwSNiNPk6od2kgEBd4N4ZGO1a7oYFYg4GAEp8cz0JBBJlMy1MLAYbB6UXq+dL4ncpOgLRR
X-Gm-Message-State: AOJu0Yz1oTx2PawR6gW2gkiylOhajQjGCFOechoQACNzeZFxXSYXFxGL
	+fetJ42LNfMhT63IEN/tTsY5DIIxEFXVWg/nqhGq/pfA6U6/XUsGWvbOm+ty6LHxS7iYT6SQxnE
	IFx+3YKVFONPGUogD802OFIYItvI28hDVSpn7Ow==
X-Google-Smtp-Source: AGHT+IEwvdUN5GYHZf+oYL2BhSIhMj4XizKcfWTfNboHzaZQRsgNKDXEA+WWZyOEhNMgMjD9xNvIqRmYe8MWm5x6WVI=
X-Received: by 2002:a05:6902:2211:b0:dfb:d50:a761 with SMTP id
 3f1490d57ef6-e05d5d8b07emr2822669276.14.1721135716388; Tue, 16 Jul 2024
 06:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <74947f7f132a811cc951749907b01bd25dcf23e6.1721135509.git.geert+renesas@glider.be>
In-Reply-To: <74947f7f132a811cc951749907b01bd25dcf23e6.1721135509.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 16 Jul 2024 15:15:05 +0200
Message-ID: <CACMJSevi+U81ASqG-DCSxcuW4C4hPRt-_nYgmnpaMXF_7Ozw-g@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: QCOM_TZMEM_* should depend on QCOM_TZMEM
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 15:12, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The Qualcomm TrustZone interface memory allocator is specific to
> Qualcomm firmware.  Hence add a dependency on QCOM_TZMEM, to prevent
> asking the user about these options when configuring a kernel without
> Qualcomm firmware support.  Various Qualcomm drivers already select the
> main QCOM_SCM gatekeeper symbol, which in turn selects QCOM_TZMEM, so it
> is auto-enabled when needed.
>
> While at it, add "Qualcomm" to the one-line summary for the choice
> option, to make it clear this is not related to generic TrustZone
> support.
>
> Fixes: 84f5a7b67b61bfeb ("firmware: qcom: add a dedicated TrustZone buffer allocator")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/firmware/qcom/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
> index 7f6eb41747346a4f..c607574397e9a7e7 100644
> --- a/drivers/firmware/qcom/Kconfig
> +++ b/drivers/firmware/qcom/Kconfig
> @@ -15,7 +15,8 @@ config QCOM_TZMEM
>         select GENERIC_ALLOCATOR
>
>  choice
> -       prompt "TrustZone interface memory allocator mode"
> +       prompt "Qualcomm TrustZone interface memory allocator mode"
> +       depends on QCOM_TZMEM
>         default QCOM_TZMEM_MODE_GENERIC
>         help
>           Selects the mode of the memory allocator providing memory buffers of
> --
> 2.34.1
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

