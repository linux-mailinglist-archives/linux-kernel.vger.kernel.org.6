Return-Path: <linux-kernel+bounces-213145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDCD906D03
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6AC1F27495
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF6914A4C6;
	Thu, 13 Jun 2024 11:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nG3ZGyzs"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7E144D1A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279506; cv=none; b=rUT8PXzn0PgKQXGjG7K3386wOpsaAYijIRF4LL34IRB07HLP7gXoUL2WK4U5xGCyZR0Re/3U/GyoL7pE5TRCu+n3NKek/UqdivgT4Qzv+nVWOHUTvUCa3wst+qJEax1J1pFusFCh4f9Uk32OInahRko7CDPyjF3YO6B92lmu71U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279506; c=relaxed/simple;
	bh=sZEKZfHubIqep01PYDDOG2DiKYyzvbmcvlOdh30m7Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC7jw8f/z4LuCqUsq/WDdbIJFo//cLVpjxG7WaG6/YKT60ndy0594D7BSTdzAdcV8Rv2W8zBUzuZmWwoGMtXhAFlxUje54j8nngdjhbeTQIrBotxtevL/o0KpWVMyG+4rl6Z8W3BLy9w8x8BAgVde2/GaFcqWV5MPdCnOSRKro4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nG3ZGyzs; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a2424ed00so11755597b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718279504; x=1718884304; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YRvIRe1C8JF7J2k72Eq1IoWCS+jAa2AM8+ph/DDThXs=;
        b=nG3ZGyzs0+FGeRWMyFqTafgjocV1ZCf4AZaydmP1Gn5Aw47SfjbW9cs6LMFL9Uz4nT
         8HdsLKEc4nONPnRJ7XrCGPpNLpX5iSySpz9aFPXdO5oNWbfrHTQHaZKoBz1zCYscjoVu
         s/URdGDMaVoGA0E8+QIE2IG0MAIvVGbTC5dVdJ7mFpycHwdIn54UtMeO4SNHA8ODWoVN
         qyoKIgQl+4wXQxkwunl64Ep8/WoGjzv+12IUaZVK3JUfBskRaEtUUW9a8OPARY8mh0XF
         4fV3FsknDPTcjrifA5j3C2nQehltVk4hTM21XtcPxXc4yl6VFEHqTSKgqEHdnEgE7TOi
         5Klg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279504; x=1718884304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRvIRe1C8JF7J2k72Eq1IoWCS+jAa2AM8+ph/DDThXs=;
        b=J/qpfsO+0aDTcCWsO+rnqG9BbEO1g2S8kNAcVkUuMur8pnNwo+D33ZsINfPQVgMCam
         7GWWq7GwidUiT8d1Knf6iAQw8Pc3kPrsui9K29+fEktAaHpK3mCIZ1rPA89OFyHhkdkw
         mjLO8b7IsOHXkKeQ0p8XD+cUUq6HL7Z3ZrrpswDvYosgu1Eqx+6gyUkYdVTzD0mF+iXU
         QFfiGEWow3VKyiMNnCqxeqq3avqDklEBiVcTnn0wuyrkkYDY3pMyv6/e2OMhJHgdw0at
         s0xLHc0ndw1pFeKeyAM0NozpS8Ol9B49WoIc2a5nTKiiM8uHXwGquA7xm9/nwL/EuTAT
         LUGg==
X-Forwarded-Encrypted: i=1; AJvYcCVuiv6cgc2pWQNYN7v5VjQQ4BdxPGEkG96mh92Y4LEVCWB6ubBcEUcmHls6tRIGRqkdkgaReQUlWu48ZP7UlWAIFzwAFs3ghYtoYSEA
X-Gm-Message-State: AOJu0YwEz5cb+HJRkKH1Gz5PHRH3HC9JcDj5sd+yJ4evt0x2dp1F6k3P
	2CapsuvxmdJCtEEiaMVvsksenaHNw34VNcE0xIJjDKMJz3ZI5w9ZVVuUl7hR+gEHKwc/7GipxPK
	XL1rJ7jv/y41Jp7RBJlhkOu1zLfpRfKnzm2rZdQ==
X-Google-Smtp-Source: AGHT+IHsbTNLvjN8WuDB84rv+zysR6fpgX/dxzhUTfN9xcKd94L2FQdMlBq8iWThBr9t45yXD5czpiz8aOD25S8hU38=
X-Received: by 2002:a0d:dc84:0:b0:62a:259f:74d1 with SMTP id
 00721157ae682-62fb847d3a1mr45680067b3.5.1718279503794; Thu, 13 Jun 2024
 04:51:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524082236.24112-1-quic_kbajaj@quicinc.com>
 <CAA8EJpp9U-ucMAiNmVvWDuupd=OR_fLK9fQ+n21SVmktWMxhmA@mail.gmail.com> <ae289c19-2701-d00f-3f6f-5e87ec37e475@quicinc.com>
In-Reply-To: <ae289c19-2701-d00f-3f6f-5e87ec37e475@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 13 Jun 2024 14:51:32 +0300
Message-ID: <CAA8EJpo4v1sfjo2nUEj0-kZ_0rrMh07s67LzhBs8POjkN2Nybg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: qdu/qru1000-idp: Fix the voltage setting
To: Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Melody Olvera <quic_molvera@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 14:43, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
>
>
> On 5/24/2024 2:59 PM, Dmitry Baryshkov wrote:
> > On Fri, 24 May 2024 at 11:23, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
> >>
> >> While adding the USB support, it was found that the configuration
> >> for regulator smps5 was incorrectly set. Upon cross verifying for
> >> all the regulators, found that smps4, smps6 and smps8 are also
> >> incorrectly configured. This patch fixes the same.
> >
> > Nit: see Documentation/process/submitting-patches.rst, "This patch..."
>
> Will update the commit message.
>
> >
> >> In particular -
> >> - smps4 is 1.574V min and 2.04V max
> >> - smps5 is 1.2V min and 1.4V max
> >> - smps6 is 0.382V min and 1.12V max
> >
> > Just for my understanding, will anything further constraint these values?
>
> As far as i know, this is going to be final.

Ack

> currently, usb device is not working without this min/max change.

-- 
With best wishes
Dmitry

