Return-Path: <linux-kernel+bounces-386670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8FD9B46AC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10831F23F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771AD20494D;
	Tue, 29 Oct 2024 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jXezlqQM"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5487204940
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730197373; cv=none; b=C3g1tl1l52ssfrDptig1vHjJf8QMs0JkWhH3YjNhVu2Xj4By2P+5+lzdyt8IVRdzRTdrDunx+tcuX+qIcH4P013+CrtlkE054e6qfbeeo4X44/I1vIyCWiOjhi8Ep7dWSlmKcckSCrkA5ulcoZW0JOPmziBK4pcM3TMaPUwxWbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730197373; c=relaxed/simple;
	bh=NClCEWAbIaB97jE5fBeq2TT2+qZkg9zuHJmvLo/j5xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqgpTCvS51LBNxoLbPZ4AljsSsi9rBM+m21JwLZ4DGgNcTpRELVj5wAkVbSEPQdTLquKN0wePXzm74sd7wH2sQ6yM+DjgD1VpFm26EI4XQ3TEGAv4CFyMXDqrSDOuo1ZqbgfKkAkrOLQF+Lq+EwMRUDs8WzKnD2rr0bV/CYEHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jXezlqQM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a16b310f5so818587566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730197370; x=1730802170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OpoGu220G+I2JHmMdH/oGpp5x5wmIi+eCNknBPJ0niQ=;
        b=jXezlqQMugzj9YeuOaH4bpm7t31Z9rqgZhZgsT0oN5acSCZf0tAu/no7pshUPYt8CY
         fqgh2ecn7nIpLUiZewavywcz5K4AtH0BvzZz+X1/qogy6bpfq0EV646OwVw4f0Ip1rvj
         NHFt2qYJuoE8RB0AIUSBrbl6WYQf5qSy6SAeoYCiAUPHJBjvt/DChdLhduKFtZRC5Bzm
         OYPIGCbT3/uQze/Z6+5ZkzhPs2/Qil/6kQkyKw/tNFs8Mg1p/LI+2emYdptz2MCXyPTp
         wem3E0ECWTvFea6rIkOOSHcl/2PLCHrV45IKZnO7ajK/UK1IuqiM7BmkunOA4+e54xv2
         sHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730197370; x=1730802170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpoGu220G+I2JHmMdH/oGpp5x5wmIi+eCNknBPJ0niQ=;
        b=textO/jjCTx/q15IjkXVDkKfuSZK9s/vWqC+IkV76m+v67Oo17wHAVk1lO/ZDL+ydI
         9wfEn5VjxBzpAOFh6BIcDwPF8mMbOJqjGNFZc5lacuFSHBF1+LvRnWs5srrkqk0aULPI
         XTWQYNO3jipLAYdmB+pp/E4+mm45565HgI4BFUOsJdbq6FpW0m5kt5CDH8p3E8sSfMAl
         CfgmQPd2VKaozo8T2TCVcbMzvx/aR/L6DDG1jPSzQmngpkDJcz+3ypmapl/VjW5/1vH8
         QhA6Na50Nm9wBbf9S6+L0LN8uK2aNmCuPXq/EYBFML5b+v01tZ/To5Xo7vAer8K1fdz7
         mW1A==
X-Forwarded-Encrypted: i=1; AJvYcCXm/SB0ZTtM3MlHTyaklDEfZTy2uwwl9KmWRnxdrD0BL5B7VoVI4+aPsiW7Nbi4HjCDcUTGmbb3Iqr7BR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfaxUjaRe9dwPDBynEN2tpCTVjhLqXrn4Dx9iMKmLLsk+f0+T
	vCFlg2htRqF0U0FWYcevVmIfz+ZzAEMxHw7RC++oqJlItT52WuT4OGWdF53KYieds32SSfrHyTG
	yubxy/62IswLxTzjrYAKJNBg0ngJ2IQ4IxpGLzw==
X-Google-Smtp-Source: AGHT+IFwYSWi04yLig8BPjAEmb/KEwa+yXShIueQnJ+VdE3pSaqui1FH3sSzNX1eqK6Zn5jcZyfPrVapC20OfiZLOpI=
X-Received: by 2002:a17:907:980e:b0:a9a:7f34:351b with SMTP id
 a640c23a62f3a-a9de5cfd5d1mr1021253466b.3.1730197369900; Tue, 29 Oct 2024
 03:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029073857.753782-1-ahaslam@baylibre.com> <20241029073857.753782-2-ahaslam@baylibre.com>
 <6ec5ea74-8d2b-442e-9bde-c2ce6802dc8a@linaro.org>
In-Reply-To: <6ec5ea74-8d2b-442e-9bde-c2ce6802dc8a@linaro.org>
From: Axel Haslam <ahaslam@baylibre.com>
Date: Tue, 29 Oct 2024 11:22:13 +0100
Message-ID: <CAKXjFTOMpGpxCcFCL5GjeAgJVJpK7Y56dcsfMkRvFPQnrTbTnQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: iio: dac: ad5791: Add optional reset,
 clr and ldac gpios
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 10:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/10/2024 08:38, ahaslam@baylibre.com wrote:
> > From: Axel Haslam <ahaslam@baylibre.com>
> >
> > Depending on board layout, the ad57xx may need control of reset, clear,
> > and ldac pins by the host driver. Add optional bindings for these gpios.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> I don't get how v1 could get my review. I never give reviews out of
> mailing lists.

I  forgot to mark this as v2 with the subject prefix. :(
this should be v2, same for the other patches. ill resend.

>
> Best regards,
> Krzysztof
>

