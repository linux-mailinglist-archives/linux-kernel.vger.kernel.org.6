Return-Path: <linux-kernel+bounces-243917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCCD929C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1F8B20F42
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EC817583;
	Mon,  8 Jul 2024 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6XsnBZQ"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A1410953
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720420977; cv=none; b=me1nBpUfInfvqYOt3x5LAcOlbhz9mHHiNT/x73llfo8LuiE8c1UZcaOK679SGAFBwXR0Mr2I1+DcVWNKMCX7IAm6TfQXsxOAIHkdGvK09PEDvdOXQG//kShrPjRejHNDxNr1WnN2oGTWJToyaJUSXaRKH/Pt3HVLtNlmmk1XA0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720420977; c=relaxed/simple;
	bh=XDCXukSSG5eu7Enir6B20Xw7BTHGqHHg5Qjp0HFF7D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzhWtyHtwMb5kmdvlBplCjkK7m9kicJ+HXt133K2MLQ6ZvKayAVZQ35fVPsXSr1O/wTU+hkG5NrEbR0nEA7YssYQksfI7V3Q3ONIVfN6EzobFWUkRtPwrPxMPUA26M1gmnfzCivXVXIj+7M9e7iM+HxkrYcCs813raIf4xTRzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j6XsnBZQ; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c66ffadb7aso526778eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720420975; x=1721025775; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1FcWtX9vaZBCwduln3dpe45i1fpCK57rnuMSwlu6aWA=;
        b=j6XsnBZQ+KLh0p6v2x9lK//D99xqJ2pfrdVgZvmSuyl8Ep17Ci66hOgGaD2tt+Cb4Z
         h1wW8r+7qEXsI2LkIrvoCEy4PF+IG/efjJe6xAaWcdVfH76bjDsWp5ebdbj/4klDai5y
         5CkZU2vVuPZJTbda6ttRb3xM7/QAPjRStFHY2RCZ/ZaDqX7kRsy8mzYxNaquflqaklET
         VH9dL6E2hjBfx5xMKngMeXF4TfO4rRgMlQGa8qAdZOhI50IjJGmQ9rtJ0d1g7pdRmoJJ
         sjdascT11jiNSFTXsWap467yXHVHJ4UimXgri637BIDEZOK+VXuw1wOvmN2rHXw680oR
         o6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720420975; x=1721025775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FcWtX9vaZBCwduln3dpe45i1fpCK57rnuMSwlu6aWA=;
        b=DwQMylTC99fz9ZpfqknF1RMPwnHZ5crHVGqqUxD1EpDHy3/IuY4coKDNJiLOW9JJQw
         djWWunWdeYgUh25HwCeVtJrzjSPPnW4jIKMEI+f4IfaOUdUOn/JcBHebCECMWs+LP6au
         Y9j93Q9+Mqd67+KTK/CmUsB2+LTZHMKmPuOkULNfJ18miNY1M0DMLYMA1MPgZGdfBgBz
         MNAfiNwh/YarAqciJP2FV56bvV0rS+I+oaEQod/4fPUWfmGiL5Gtt/fkR4MHEwUluR9G
         sPR3E/NGpJKLZJFb0hIxd31Rw47PaNeaigdjICXE/B6hFszvrxKRblHqXHC5I2qE3SIz
         VViw==
X-Forwarded-Encrypted: i=1; AJvYcCUle7wdb1SKbXoGkji3XtovCU06A3nNhQuvTNgcDK8o4ubtRRLSmpDutR6xgdMUfCGEd2U/h94XYIkjiX0IRQ/+lM8aEFHqpDyLpYsS
X-Gm-Message-State: AOJu0YzAVK+tyI4DoRJZgxiF2ZdEI5ilKyE4Bh+Y9KzECerW7jLYdKwk
	sni9I0jdSHxBnX/dm/+VKt3JG6Ul3xXTu2xfMJ6N+eAePU3oqmcKTGIFAe11TbI=
X-Google-Smtp-Source: AGHT+IEpqAis6dJIEMNcexBdNxU9+uzyMP+q55/0m9GwePwrj4Gs0P9PuuQDc9r/zZs34DMwLSdBrg==
X-Received: by 2002:a05:6871:688:b0:25e:14f0:62c3 with SMTP id 586e51a60fabf-25e2bd878b7mr9528568fac.33.1720420974988;
        Sun, 07 Jul 2024 23:42:54 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b116e43f0sm5260455b3a.101.2024.07.07.23.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 23:42:54 -0700 (PDT)
Date: Mon, 8 Jul 2024 12:12:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
Message-ID: <20240708064252.sydvhfnmx3akafql@vireshk-i7>
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
 <20240702055703.obendyy2ykbbutrz@vireshk-i7>
 <aa6e93bd-aba2-4e4d-bce9-04e818ac25ed@collabora.com>
 <20240702084307.wwvl5dchxa4frif3@vireshk-i7>
 <8602bf12-1b8d-4249-8814-52ecaa29d0ec@notapiano>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8602bf12-1b8d-4249-8814-52ecaa29d0ec@notapiano>

On 05-07-24, 11:13, Nícolas F. R. A. Prado wrote:
> That would only run once during boot and only in the error path...
> I'm confident in saying this won't amount to any real performance gain. So the
> usage of dev_err_probe() everywhere for log and source code standardization is
> well worth it.

Hmm. Fair enough.

-- 
viresh

