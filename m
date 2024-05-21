Return-Path: <linux-kernel+bounces-184748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9524E8CAB66
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61A91C21A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01A6CDAF;
	Tue, 21 May 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RBwG+Be9"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37E74206E
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285702; cv=none; b=UyaIs6b5fAR9wbArkuyP+dy6ajHOVEP0PcFWqamifU/j1sOLGLN2PkmjIEDsRpQ+3f7C6frEDJcA8b0BKALE4qjFj4HA1n4rW7XnnVAqa6r5nG/w+waINYDUdZENLfGBH+4Y1+ec9L4J8nknnhXbMDrMb9GPPOIr3GETmleKMJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285702; c=relaxed/simple;
	bh=eSvaMBIbPocMUUAl2gCaybx5KCg+piZs3ZrESkEh/t4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuM6uGWsvS1uUltZorXJsGR4kr0KoByMjoaTwyl8l6jBQPYYek65HpRBQmjEj7VvT5gnoz6XpyE+fSAHxiYRPdgfg5mWDo6fkXvlLZEXQnC8telgjOVMDoRCAqXnBkJ9C/VkWEAGmPWzwl3tx0DQZTEvtvkfJOZGe56MemCh5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RBwG+Be9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-43f84f53f66so12730431cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716285699; x=1716890499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=05P/WlwWKKhut6I1eqLgXZLr7T/6QQDhvGE0vkqsqJo=;
        b=RBwG+Be9ISsaQ9wSEh5/7UhbNY26zueVmxaSRIwPcub+SFxb2Kpwc9C6GoYx4pUwHS
         IGvJk/ZQ7zrlTC0VhKbpd5/Akik4LiOOAl7XUH8xMq/GpERYeonlifxAGH2E+0HCkRVU
         9/YVsFB4kGs9prmVZREu5rViJ6Xp7axxWQnY9NL3Cxm3N02cqSJ6fVuhgJNPdko/H/eq
         DKVW7NTQ6MoPe1uZKfVulGfwDTgEPaebagIu7gIeyq2igu618c7vz9m9+8XVRuPLbTfu
         8MC8bdyQVQpWRFF+i1CaWLn/DDcDT4e3ZSU+10gkCLSLM8i2syOq7uz+NGuBYmaUyctx
         eTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285699; x=1716890499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05P/WlwWKKhut6I1eqLgXZLr7T/6QQDhvGE0vkqsqJo=;
        b=Iu+KrsNhzvDexxEw6LNkczESCrs49SgKFXeFTcn4fAjieOJ3IansIN2UoLm1hQOdS1
         KV7sxpZF6R2LPbnnGymf4dY9iRPNjRJcpWDJWdUq7Tnw0iwmw4IwkoiBCpWAhZzBoxir
         jWD7elBtZCKvC/NZjTiTiiWrlvMfj8M1x3rs+TfHDfWqbklR4x4EzvTA5xs5sHeoi8Xh
         UexwiUC/BHke6aOlK2je3uf8m9JVr9tsKPE7rs2VHmX/TGFUT3kx9xJo+s4fSqD6qemr
         7zuQR9LxtXQES0Hg17WjsSpSWJPZg/RZOiTCTVADnE3HPLBR3DFV4uQxfwu/9HC+8QXt
         rwKw==
X-Forwarded-Encrypted: i=1; AJvYcCVyFC3d2lvh9V0XB1lfmETysq7Qlfz2JcnyFtS+OWTqGENjosAMWSe4p7DceTOuSlNNQcgRZH17OZb3vJFXzoCBxXSf3ElMrQRugh6V
X-Gm-Message-State: AOJu0YyY4PiOJ2e2poiPQ4gdFrc0qvPAsd6erdZuOr5KJeH6HZQHI3Aa
	3Dvq4kqrMAbVjP2XQSwjbKjO3mxoh0Koxyz/aEAIwlO+mLZQHP7GHwS4cvO4rt2+RYrmbPJ0JSQ
	JL0jLdhbCfze1j6CRppN53sFXbQGyFA2muCu99tD/Ubw/6UtV8P4=
X-Google-Smtp-Source: AGHT+IHBg8oA+nkRXQ2kYvjQcVJRCg+dFqmIUTocHTkS2BlcGovr4ox8u9dBOyyUejfPP8YcSa3ykxFw12tBsBCGjcA=
X-Received: by 2002:a17:90b:4d8d:b0:2bd:69ce:1966 with SMTP id
 98e67ed59e1d1-2bd69ce2345mr5713134a91.29.1716285678586; Tue, 21 May 2024
 03:01:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
 <20240521-qcom-firmware-name-v1-6-99a6d32b1e5e@linaro.org> <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
In-Reply-To: <a314906d-b297-474d-910c-6634c8c23042@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 13:01:05 +0300
Message-ID: <CAA8EJppLtsQmjC93_zPSqeWAk9vM_ZVF96pcWLRHHpm4KrY2cg@mail.gmail.com>
Subject: Re: [PATCH 06/12] remoteproc: qcom_q6v5_pas: switch to mbn files by default
To: neil.armstrong@linaro.org
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, wcn36xx@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 12:49, <neil.armstrong@linaro.org> wrote:
>
> On 21/05/2024 11:45, Dmitry Baryshkov wrote:
> > We have been pushing userspace to use mbn files by default for ages.
> > As a preparation for making the firmware-name optional, make the driver
> > use .mbn instead of .mdt files by default.
>
> I think we should have a mechanism to fallback to .mdt since downstream
> uses split mdt on the devices filesystem.
>
> Perhaps only specify .firmware_name = "adsp" and add a list of allowed extension
> it will try in a loop ?

Such loops can cause unnecessary delays if the
CONFIG_FW_LOADER_USER_HELPER is enabled.
Since it is not possible to use vendor's firmware partition as is (you
have to either bind-mount a subdir or use a plenty of symlinks) one
might as well symlink .mbn to .mdt file.
Another option is to explicitly specify something like `firmware-name
= "./adsp.mdt";'

But yes, this whole series is a balance of pros and cons, as it was
discussed last week.

-- 
With best wishes
Dmitry

