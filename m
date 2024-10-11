Return-Path: <linux-kernel+bounces-361413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B7399A7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDB9B21791
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8111957FD;
	Fri, 11 Oct 2024 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G7vfvnhP"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A9E1974FE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728660768; cv=none; b=KftMfc9b9ebb96HXo+16YoejDesW0LRUe2xHJ6ZcsvVhVEir/xDU+cHmJWIFCkWFGiv6xGCBDNTxFzwYQY4T/VY3cn660MBRwBzwB+xjPTJUE/koqnGAB4bFRlzETlgNs91UXauXbcC6dQfuMiwY2vcxK/oNxMU2tEefGEpdP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728660768; c=relaxed/simple;
	bh=bRJ4Y1/jdFojuUij4IeYNNekIWbJ2nzLiEuafUuGJn8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cKp7VIMfbtOW7+2LsPwJB/xwIIf/nlt8AGGmECXa4zKe1kBYWxagVxRpOehZ9FjaKo7gnYlqeUpDS8Vtr720VQsYy5iIE4LSUBgceWTQBXQcLNSPiNFndOumQeVbMZz1QUqTWanpBvIp5CgmfPlJch/gD6qhZPm4Z+UrBaXXKH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G7vfvnhP; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c949d60d84so941788a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728660765; x=1729265565; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Rat4MPBAsLDnNiR+W9/KxSukyb9q48U+Dl9neWjYf0=;
        b=G7vfvnhPR+1WBPKyio3JrSyJ52wjfu/6z3FP2FHzp2HY+d5NdOIHgU6LhY+pFCMIM2
         jnrCRYSSolupvAOFRuULP5hp0SJt039ORqaiUloFg6wTRlUIIrr56cQ3DzkW6k/yYkT7
         NjnNalltEPMuonFbSm6+QXI0qofrBrfSQUhIn3+CmSZMwJG7QpK6yl56sTaJhoJaRaPz
         piy051V0uMa5MpYPD6r0oJ/pAUwOPcj5BXUpOvcrJjTg/dZiiOpiu4gYZGpwsKq3pcHE
         FuQ7kI9/DLbPPJ+Gdgvcu/k8OdDAILuADbVhd/zRqyDb+DuPmmZOuV0KbRTnrDn8H3Ux
         03Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728660765; x=1729265565;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Rat4MPBAsLDnNiR+W9/KxSukyb9q48U+Dl9neWjYf0=;
        b=MMxQkz5G49cazqxbQyLUR21dO71P7uU7gCIJVB3a78QDVJLFvRSMNklBojkXBFL4cj
         NHrpdYrn6zclLWTKBXrHl0IPMZ908P+FkSOuiejPEzNMeeqytaHxbZEkAQcV3GCmC2WM
         g6KycJKXU+jpktxp3n/UfICn9rZPXJpuceppNIhdQTQIYUnVgHftbc2AYVauK1+GEkYV
         3qzCxars+H10bZjdYGSJcE9JaUnnuZOEw54TYJbGw/gDw6Y77XtJXk2ce2LecNoWzbVC
         yVnu13NHb18vS4QpLeCn+fIUjSsb1Z7+IdewajkgPO9efNRC7dFpOcA0H8L3zZAB2v6O
         RYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOe5r04v+VeubBZsmkmvlKgdcIno9dQBw49Dt8mbw+DoRbSeAG8z+cUcLvcDcgNMc2M0YCJiPr42YhY3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwXBC++0hGBh8bgRtFAe227aTsj7wP3Gcc2uxpq7qx9m93bv9
	mnFlgcuE9/OTiiI/vrF/H1IA1qu8+vtymoGcLRogKxXtqmcszmkgoMfN/1mpJ+8=
X-Google-Smtp-Source: AGHT+IG2RSuYoUetJ32zLi/kp0cBZ33Kg6Bh/AWm4gP1CZLAPGxS//Bmvvsy9YjdHMWJKgnFnWy8sw==
X-Received: by 2002:a05:6402:348e:b0:5c8:8381:c308 with SMTP id 4fb4d7f45d1cf-5c948c8831fmr2027670a12.5.1728660764556;
        Fri, 11 Oct 2024 08:32:44 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c93711adacsm2049796a12.37.2024.10.11.08.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 08:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Oct 2024 16:32:42 +0100
Message-Id: <D4T33J6B5SPK.25S50D16VMDRI@linaro.org>
Cc: <linux-sound@vger.kernel.org>, <srinivas.kandagatla@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, <stable@vger.kernel.org>,
 <broonie@kernel.org>, <dmitry.baryshkov@linaro.org>,
 <krzysztof.kozlowski@linaro.org>, <pierre-louis.bossart@linux.intel.com>,
 <vkoul@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
 <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: qcom: sdm845: add missing soundwire runtime
 stream alloc
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Steev Klimaszewski" <steev@kali.org>
X-Mailer: aerc 0.18.2
References: <20241009213922.999355-1-alexey.klimov@linaro.org>
 <CAKXuJqiK3BHT-=3zyT1tbunpNF1b_gyZUAd4EE2FY2r7TbaXug@mail.gmail.com>
In-Reply-To: <CAKXuJqiK3BHT-=3zyT1tbunpNF1b_gyZUAd4EE2FY2r7TbaXug@mail.gmail.com>

Hi Steev,

On Thu Oct 10, 2024 at 1:33 AM BST, Steev Klimaszewski wrote:
> Hi Alexey,
>
> >
> Thank you so much for tracking this down!  Was experiencing the same
> thing on my Lenovo Yoga C630, and testing with this patch, I no longer
> see the null pointer and also have working audio.
>
> Tested-by: Steev Klimaszewski <steev@kali.org> # Lenovo Yoga C630

Thank you for testing! I didn't know that this affected more than one
board but I was told that it was long-standing bug.

Best regards,
Alexey

