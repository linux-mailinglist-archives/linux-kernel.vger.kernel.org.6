Return-Path: <linux-kernel+bounces-354456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A0A993DB0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C32E1C23CBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D8A55E53;
	Tue,  8 Oct 2024 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCpvyWzE"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9A2481C4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359575; cv=none; b=I5VF6LmgYRTQdpi/CVrHARIE9ZJML/DihWl1xB1VWEFv6JVmy3+SlgEt19xkeKJCKEgI+4P5JOA3JAyDUxFaRWw1kcH78qrPLcAZ7GrVXp0R/frcW+iUEsoc6oSNvUdpZjiR1Aekdq252LQbk77qkAQgerPLR+UsJyl6RX1MVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359575; c=relaxed/simple;
	bh=hCLWlw0j3aBtBWIKToAqdb5t72nChThzzCfqeoBaQ1w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Skw+sqnn+nnUdPTkQo6xoAtDiOztrBBu4c4Oo3adLnB/CDIjvCVIekA6bYU1KQ0mPh8jDGM4cFt5wTEQgHmLsFhT1KOORjdN2u/+U4be2f3J/I1qa89fECwraazLrs6tX2DW+dwXAKTjZAFI6SyScAJ48S9Njko10OjhxVf+lQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bCpvyWzE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37cd1ccaf71so3387561f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 20:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728359572; x=1728964372; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElqD9Hm+WZEodZrxK7bnkSFLALYB9eCjiPyOgKg3kGo=;
        b=bCpvyWzEP5LSnVcRqcNWjCHuHeJjxXZHv/OwcJjS8n5mEO722I+wvpJc42/vds/7fA
         A9R98j4/SXT8nDLRZ9d+jJCwRw9vHRbPxomkltbQxZTELx92nJEHfJpouraiZvXkyKdY
         HfS5495e6Ws8OUPSkuWY2sPr2B4gU2H+85q2EUcC5o03bV/fdBA+Z1o3PFzNEtGJxrH0
         C24bWz0100aegzcPlqIGLkaXA4BprKXzoKdlzckASB2nnOrzmOuMfuNC6ePXbOX0QV8M
         DOWdzcUYDGydX4QTTxm/XJrqtC7vF8H/Yi2PcGrKjMB1OrjRGHB954O8RM64n+5Re/4p
         F30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728359572; x=1728964372;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ElqD9Hm+WZEodZrxK7bnkSFLALYB9eCjiPyOgKg3kGo=;
        b=u8QaKaaqT2XqVg+J88mClJXmLA/s7XF09ozE+Ja8r4o3pjWPUwUIzYdk951/Pn6gAW
         o9QNed7t8mA2UkcUAVMCyy31twIhigUMycIT4KzgWBwAZvDbKzNahWSkFTjyzv1HQH89
         aQicgwoXJdC7n1QccghXGJQmmVFxlh+mQFj9XaJJJahVbti3GaBOvWA3eHT0QoItX+/o
         SZ/kUIXhM15ul9tDFElz+HJR30UyCaRQ6wCY6i278XmJ8ri+VmUpqEMQBXchuHzLfFR7
         JgOVBMe4SrYgTElXjk2UejV4P427RbMoM9LGH/vVtjLhI9pZqrd54fx1d7v6xHrS4Ebn
         pJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3WUQxtqR/lTdRFiacOwYEf4EKptrTd4HESjhsm12lz1XulxqDCg/jZuO1S94tv80/CRDSNN0GkTtw3T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZOHkuEz62BAmRXHLdrcZynaRgZMDQk4+jRWxpNnPkRW4FQyf
	ELYRWBWM+yS6ZsTUVcG3HPxBFTzRNSj9vsP1eQCmClUpJNj7KL+rc9vv9QNrW90=
X-Google-Smtp-Source: AGHT+IG0BGCL/uld55vxEnmyp6p8cfwtL2b0uOPAyw08t7e4tq0ydjKfo3AyQfjiW9owlo+MdBT4cQ==
X-Received: by 2002:a5d:5105:0:b0:374:d130:a43b with SMTP id ffacd0b85a97d-37d291a9ccdmr959081f8f.4.1728359571913;
        Mon, 07 Oct 2024 20:52:51 -0700 (PDT)
Received: from localhost ([2.125.184.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972b97sm6973289f8f.99.2024.10.07.20.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 20:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 04:52:50 +0100
Message-Id: <D4Q4C17E1A8J.3O1CD1PDP51HH@linaro.org>
Cc: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
 <kernel@quicinc.com>, "Rohit kumar" <quic_rohkumar@quicinc.com>
Subject: Re: [PATCH v1] ASoC: codecs: lpass-macro: Add support for channel
 map mixer control
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mohammad Rafi Shaik" <quic_mohs@quicinc.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Jaroslav Kysela"
 <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>, "Srinivas Kandagatla"
 <srinivas.kandagatla@linaro.org>
X-Mailer: aerc 0.18.2
References: <20240930053111.3986838-1-quic_mohs@quicinc.com>
In-Reply-To: <20240930053111.3986838-1-quic_mohs@quicinc.com>

On Mon Sep 30, 2024 at 6:31 AM BST, Mohammad Rafi Shaik wrote:
> From: Rohit kumar <quic_rohkumar@quicinc.com>
>
> Add channel map mixer control for lpass macro codec DAIs.
>
> Signed-off-by: Rohit kumar <quic_rohkumar@quicinc.com>
> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> ---

IIUC there was off-the-list discussion about why it is needed.
Could you please elaborate a bit more in the commit message?

> --- a/sound/soc/codecs/lpass-macro-common.c
> +++ b/sound/soc/codecs/lpass-macro-common.c
> @@ -8,12 +8,67 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> +#include <sound/control.h>
> +#include <sound/pcm.h>
> +#include <sound/soc.h>
> =20
>  #include "lpass-macro-common.h"
> =20
>  static DEFINE_MUTEX(lpass_codec_mutex);
>  static enum lpass_codec_version lpass_codec_version;
> =20
> +static int lpass_macro_chmap_ctl_get(struct snd_kcontrol *kcontrol,
> +				     struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_pcm_chmap *info =3D snd_kcontrol_chip(kcontrol);
> +	struct snd_soc_dai *dai =3D info->private_data;
> +	u32 *chmap_data =3D NULL;

You don't really need to set chmap_data to NULL if you're going to overwrit=
e
it with a kzalloc() call a couple of lines below.

> +	u32 rx_ch_cnt =3D 0;
> +	u32 tx_ch_cnt =3D 0;
> +	u32 rx_ch, tx_ch;
> +
> +	chmap_data =3D kzalloc(sizeof(u32) * 2, GFP_KERNEL);
> +	if (!chmap_data)
> +		return -ENOMEM;
> +

[...]

Thanks,
Alexey



