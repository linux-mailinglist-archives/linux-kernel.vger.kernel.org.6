Return-Path: <linux-kernel+bounces-339085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DBF986029
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629C71F265DB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC22A1862BB;
	Wed, 25 Sep 2024 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQFotCNI"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19961865E2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727268085; cv=none; b=Dj60CL+PoJEL0r7KAAca1ZxW/Fjoag/SPaLBRwXV0zmjl26XwmlwlSB+lKM2Pl9I1zGBcc33g+klk2KjwNK2JSmpecQCDzgxES87MTwaTPi2TsAWzZzlQXHQlEEpPlNBApXugSmxRFrPL6x0tjMCQoqFdyAmopnxc1WisZ4EsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727268085; c=relaxed/simple;
	bh=YhBxDPpYQH4YqwY+Xz5yX4fHNoiBzWpOpC0HAJ/BbGk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=LFkL7OLx2J0A53qLDqdjXYnSY/NcTnyiYnUJqIv3Vn373tlZXnFAKrbRMR9qMoIa089nQkYeQPXHu2WrLx2kHxfIhX0rgzaVaJuyPB9iltwUdIbtAwaIGz9QlF8E4KUcCuLT09mxACJJKKNpMoSvNxCxZP1t6xS8iv0D/tSHD8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQFotCNI; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbe0so7745054a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727268082; x=1727872882; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izurz+PMZmOHAHw9NMc4dqCu2H1VhQy7BJX6+wDdt9M=;
        b=DQFotCNIt4fwuRs9KULT/DBg+n0AwQoywoUipZtw3TLpQIUBa8t156Hscy0gbLplGO
         HeH5kaHPPr9Ba2K5nc3YTD1du7ezVFjJHHN/qU3qt49/TPfh5GGonPVZmGFmkzGzkQ8T
         /oYwJELE0kSxtpC6OjbUZhRx/kjExaFwtrsdZB5qgtVrt6wEfO0glyDi9IPcKFdSmGSG
         MgFnkCqbV4h1k4hXGC2Ox3JGI0KaxiIG2SMtOwm6vEisFalQkn6TeK+aO72yzt2qPHFs
         ITcsxnS1yOJR1coJPFsXgN6fdiMYXzH0/H0zE8Yjh0azmQmlxXjg+Ots4llYx7kGrisp
         z18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727268082; x=1727872882;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Izurz+PMZmOHAHw9NMc4dqCu2H1VhQy7BJX6+wDdt9M=;
        b=sRoDtvzlPln6Yxn8nd3t0niarjAP1EgbuArYo11pl2OHUXI6fTqFQcsqNIHHpCpgMr
         A7LEIHgB2vHCwAsVLMhDI7fEeeg7pxVoWNRJdzqt2OTty8J+k3vY8RMFjmoCH/1uswty
         VrJWFBDp7wtZmfn1FoIldZe59s7d1gtdIqvJBSse/bxwY0lgegBq0ThXaBbC4ATtpWPl
         ysuobaTkDecM9y6p85176rdhydYEkygG3FBr02tvDnU5/fcgTwxkotsOqQsqlkqWgoGf
         EfS3q6baOsK4pGC5xde/FryRYWus5lhPYBNquhNjI244FI4B5PkUKn5Qtx54qu0vdty6
         MswA==
X-Forwarded-Encrypted: i=1; AJvYcCV5pIr4T/zdGy5zhJZT5HY2bSDAJp7o2RvLSCRo7FA+mpo7dNm6LlyNlXR0GayJ0vyCbz4jC2ma4Zmjw/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzNbVvbY6WwErza4DSe8lZo+BMsXbnubY4bY94FjIEdzumFPVa
	enzQGb0xjWVFXSanpChtWNgnbj26F1CLQmMkfE0J62Eb6k6b6bG4OGnzYU8kx3o=
X-Google-Smtp-Source: AGHT+IGWq/qS81LG8YAeWtGigBWFGSY2KUCD3wh8z6b4HsLNJ/KmQuRXg4EvkhlOqLo8SJiXSmkn7w==
X-Received: by 2002:a17:907:94cc:b0:a86:8f8f:4761 with SMTP id a640c23a62f3a-a93a035ff85mr249552166b.25.1727268081819;
        Wed, 25 Sep 2024 05:41:21 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cae0fsm204615666b.120.2024.09.25.05.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 05:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Sep 2024 13:41:20 +0100
Message-Id: <D4FDFLNQVSLD.3GSWD0IK7Q4FK@linaro.org>
Cc: <srinivas.kandagatla@linaro.org>, <a39.skl@gmail.com>,
 <linux-sound@vger.kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
 <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <krzysztof.kozlowski@linaro.org>, <vkoul@kernel.org>,
 <klimov.linux@gmail.com>
Subject: Re: [PATCH REVIEW 1/2] ASoC: codecs: lpass-rx-macro: fix RXn(rx,n)
 macro for DSM_CTL and SEC7 regs
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Mark Brown" <broonie@kernel.org>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>
X-Mailer: aerc 0.18.2
References: <20240925043823.520218-1-alexey.klimov@linaro.org>
 <czlx4thp7thnb6jrauilpbtzgbq637rmnwlpifxq5b5jfa3lqm@toyy3b2viscr>
 <ZvPPpfobvDmmTCfi@finisterre.sirena.org.uk>
In-Reply-To: <ZvPPpfobvDmmTCfi@finisterre.sirena.org.uk>

On Wed Sep 25, 2024 at 9:53 AM BST, Mark Brown wrote:
> On Wed, Sep 25, 2024 at 11:27:54AM +0300, Dmitry Baryshkov wrote:
> > On Wed, Sep 25, 2024 at 05:38:22AM GMT, Alexey Klimov wrote:
>
> > > +#define CDC_RX_RXn_RX_PATH_SEC7(rx, n)		\
> > > +	(0x0434 + rx->rxn_reg_stride * n + n * (n - 1) * rx->rxn_reg_stride=
2)
>
> > This is a nice hack to rule out n=3D0 and n=3D1, but maybe we can be mo=
re
> > obvious here:
>
> > (0x0434 + stride * n + (n > 2) ? stride2 : 0)
>
> Yes.  We could also use some brackets to make the + and * precedence
> obvious.

Yeah, sure. If this approach with stride2 works then I can update to:
(0x0434 + (rx->rxn_reg_stride * n) + ((n > 1) ? rx->rxn_reg_stride2 : 0))
and update stride2 to 0xc.

Looks like I can also remove:
	if (j =3D=3D INTERP_AUX)
		dsm_reg =3D CDC_RX_RXn_RX_PATH_DSM_CTL(rx, 2);
from rx_macro_digital_mute() since INTERP_AUX =3D 2 and this if-check was t=
here
to handle special offset of DSM_CTL for RX2. If RXn() will generate correct
addresses then this no longer needed. Or such kind of clean-up should go
into separate patch.

BR,
Alexey

