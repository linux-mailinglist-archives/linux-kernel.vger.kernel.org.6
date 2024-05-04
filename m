Return-Path: <linux-kernel+bounces-168702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAC8BBC66
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 16:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBC31C20F4F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB723B7AC;
	Sat,  4 May 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQWX46Fx"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FAF3A268
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714832615; cv=none; b=pOQHK3qLOoI9wiTSWHrn/GSAX5CS/Me9xlc9Bob2HM9MLmagotMK59++Jomwe5XpHejqvCwUvak4nhKQjLwJE14eG99WixMX9uAyur+hfxFARMQKCNNoHqA4KRWmacEEeZnDlPjqy64WoHcmODQIIF7ErvDnxKisyQaAbz0/jUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714832615; c=relaxed/simple;
	bh=y75AN2Eb9Z43K8Zlq8B9sIRhxsU+B1oi120DXCdH5J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNGES7jn4nN2fEYc8kaKZ/Us2aOXBZJn30hwXKMC4NJ+WsBZ0na2+pBGMGun5hoce+fc4CiHflGwn7dH7ayt+7dfW6iig0b507hUcGEt6lvbTq3ta2/nWG/fScDY3BGSflk4EqZN43bjIaHKmYWNwG6vS+V6LM11efHqwo382fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qQWX46Fx; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de45dba157cso386208276.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714832612; x=1715437412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oYpgysV6C7z+41TaXZjrYbHNTUm3GaxC0myM0ir6p7A=;
        b=qQWX46Fxd12pqnMx9TAUZ0lqtfHGWQr91+q+Q92e5PNjgXI+Y2zgIXkJ0IVWCMq5mA
         XqZsj7KbMmrDCWLLh9MWgWIxC55VMFJeQW78BSV1+T429PcNPjN3kJwZ4Y+RTsFoG/cG
         FRIYvrUAAnvMgoprG9Nor6/uheC3zw3pFmStOOjRaqnobyN7j4+Ul5wdj38dMr5dtNcM
         v6DM20C1w7PzJZjs9VShEu8nPo87guzsh2953z2+f6HHOk7CcWy7kGVKdZv6PBku0AdU
         TPHtLcdWOm7sUmDwHSTBOi2JOZ7SjJGDM7tD/zFZXeqiOwtk0RKGq3Ls+iezLrYT3pNp
         h4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714832612; x=1715437412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYpgysV6C7z+41TaXZjrYbHNTUm3GaxC0myM0ir6p7A=;
        b=tmdwcV8uqeNcNCLzKgRtBNnhc1jr9nbjBME/nJzFUUMJx2PThkX6WymewYdIZJXSrx
         r84txn96kjKR7Om1Uosp+NpEpuqVBCORb2+kNZ+xMu/NH+jWbs3FvAVcUa0rfpPvg1h8
         Vr27apnq/aPHB+EBMQr4uQCfA4hoVKY6l9Sc8WMkBs6tS4hg9/hOJcIeqdjIjRIebADc
         0xJBn1d5vXRqmqTsVFXfp8CR5dQrf2VjLIn6yEDK+dNa+L6gcVigd6/okXuEbMSHc1Lu
         6oibs7zWbn5QtyDnKi6eMa4h5FSJlvTtYdaRfg2F6w0USTC5aXu+THXyZgJZs/bNLDuM
         kdmw==
X-Forwarded-Encrypted: i=1; AJvYcCVkBb7bd9RnDvpZTifYLqRbliXARkyutzBWOYZ96SuLCIeHv16vyAs36lGKY6EsNdgD5MzXVYueklOkvzj5Ysb9xJMV6Fmk8nMqYqHj
X-Gm-Message-State: AOJu0YzApm6Sxr5emJzvxT1IPa+AEtSO/B5RIt2h0EiEZQvTgGWy7VS7
	pkKbJ9aSVlNmDyS26Skmv0Fq94DUSx9ukNONEuFeqZdxHQy7NA/DQP9XLs2Gwe0PANTC4NMLZG9
	rxlpEf2LUjJgDqZ9bxjxfyLnyohT5dq3LKghBbA==
X-Google-Smtp-Source: AGHT+IFrVYg+j2KdRyjEFtu0OvJtTSoRRR8Jts+xFmvtlHeA50pHCZzmyrZuJce9b/rD/5DcCVrZMU3t1SQM6tGaKMs=
X-Received: by 2002:a81:ac60:0:b0:615:3332:f352 with SMTP id
 z32-20020a81ac60000000b006153332f352mr4719637ywj.52.1714832612476; Sat, 04
 May 2024 07:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>
In-Reply-To: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 4 May 2024 17:23:20 +0300
Message-ID: <CAA8EJppCxfrBcctaR2jOrwPuO8ZFQw9vmi-0CH_sSWBm3ts7JQ@mail.gmail.com>
Subject: Re: [PATCH v4] usb: typec: qcom-pmic-typec: split HPD bridge alloc
 and registration
To: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Caleb Connolly <caleb.connolly@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 05:16, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> If a probe function returns -EPROBE_DEFER after creating another device
> there is a change of ending up in a probe deferral loop, (see commit
> fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER"). In case
> of the qcom-pmic-typec driver the tcpm_register_port() function looks up
> external resources (USB role switch and inherently via called
> typec_register_port() USB-C muxes, switches and retimers).
>
> In order to prevent such probe-defer loops caused by qcom-pmic-typec
> driver, use the API added by Johan Hovold and move HPD bridge
> registration to the end of the probe function.
>
> The devm_drm_dp_hpd_bridge_add() is called at the end of the probe
> function after all TCPM start functions. This is done as a way to
> overcome a different problem, the DRM subsystem can not properly cope
> with the DRM bridges being destroyed once the bridge is attached. Having
> this function call at the end of the probe function prevents possible
> DRM bridge device creation followed by destruction in case one of the
> TCPM start functions returns an error.
>
> Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dependency: https://lore.kernel.org/lkml/20240418145730.4605-2-johan+linaro@kernel.org/
> ---
> Changes in v4:
> - Rebased on top of Johan's patches
> - Link to v3: https://lore.kernel.org/r/20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org
>
> Changes in v3:
> - Updated commit message to explain my decisions (Johan).
> - Link to v2: https://lore.kernel.org/r/20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org
>
> Changes in v2:
> - Fix commit message (Bryan)
> - Link to v1: https://lore.kernel.org/r/20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

A stupid gracious ping. It would be nice to fix the issue in 6.10

-- 
With best wishes
Dmitry

