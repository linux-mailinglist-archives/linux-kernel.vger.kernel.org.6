Return-Path: <linux-kernel+bounces-191869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC138D1556
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AB2A1C223C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470B773464;
	Tue, 28 May 2024 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nZNYbyvQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF77316E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716881192; cv=none; b=FXkmTK+iU/qKf5JrfaxM9WlzC9sxuXyKEGJ5qTV5DuBIqUBz8U8k2okvn7iSw+1Mjthe2cYccbhl9QlhLeVOIUCGpDp4BRzTT1cJuGjmWoqn6xvx62/hX4oE5RqwECl29sTVnYkMFeRJxDrZz0cc8fx1NSieJq4B8VzGuGMkQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716881192; c=relaxed/simple;
	bh=Wb7/vxmVn2sLhr5nQIemWiJRmtkq/q6L+aljI3e6J2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vi4ce0RG/EBl1F3JWDrwEQgTlWxNecj8Wj5Ee5RP6XAwTJ9qEut7BIW2C9gnDhVZrdVvsm9JgtsrSEKOQokG5UItVqFYuPaAGXAb5efNM8kpXLUxwhr/6/WEp6zAb1l2Ych8QUpm+U/I2AxsIsS2CkadpLd9dpQeuKIuQ9o4c/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nZNYbyvQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-523b20e2615so557138e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1716881189; x=1717485989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wb7/vxmVn2sLhr5nQIemWiJRmtkq/q6L+aljI3e6J2Y=;
        b=nZNYbyvQouo36WbOzltHwO2RGZZSFKaJqbl3qhxdfNjXXlovCDkO25r4k//d7AVgDB
         tR+h5zVO4C0IlFI1t7E374z4KcJfQ8qrhQXTtZ2cJuuiN0y2nAYHYJpC7f1nleWTdeiV
         4qN0yqnYrBGVdO9I9QK9HrfGSOiSXb0yuwECs1o8q51qbhYfQLToeh7zhGJZRRexp5pN
         9BIe7+oegzWVdpYDCRVxln9jxokQlnZ/VtEYveMCfJrK6pTXUgoftbokE2h8yhR1qVrp
         AE9doHCra7mR+vLLSW69mYezRiyro16h5JxvK6BgUhAda9aDkMn3DnijrslpneK4FgvJ
         jagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716881189; x=1717485989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wb7/vxmVn2sLhr5nQIemWiJRmtkq/q6L+aljI3e6J2Y=;
        b=TZtvIgmmKNO0sFmA8c3Z8/L91qTAaFUZohUV5XcNJqgZGED4Cv+2eNBfoyvn7ndlhU
         Z02u2f6rE2Qt8+qM2Wq4Hnr2podz/gnt03ejjPrlmBjElBQbyiSTrbnSwY1iVDrI0VFv
         5UOTan2PE7/lKrJWDpQh4ezWWQmHh70KAVQlNitQI3Y9WoJYaBeX6LwxjjzPiOqZgChV
         db/fQG9Z5SyY5TyaxxSvDCdwMdv8AdVwVDOkk+6soAGjTn+95Z4sSJQnO3CXeiKErUpr
         ddgGPa72gssix2y1sZRn5rs543oSH/w6UOXhypPZGGLbp7e7ArRMo37WkOjkJxgtH58+
         uSMg==
X-Forwarded-Encrypted: i=1; AJvYcCXaDVGCoC1DgAsOZ13lODTYfTSAc70kO9fyWEFMLpoHtRv3targ70j/K1Z46zAD6b3viY/tzG/tB7zwOLTq91qcQBzujZP8CBjUhrEP
X-Gm-Message-State: AOJu0YyQPtpOk3uJ/Vr9k1fqXOG0w85svRUh6qnjotXqFV8nti+KEqaJ
	d7gklkXQMol6bCUns02yeMuwHs4KwwilCUhIghiyRRExYuQPPxLmEz+FLmetkR4FDs1lgciV2U5
	5x+h+r5c38Uvxx8dWR8lgvkriRMK2tj2XZeJh+w==
X-Google-Smtp-Source: AGHT+IEqwG8lGB63TRtEHQ50qoCp6W8M3rlfT/je1S6Zp1mGlceEHeIquoczIa/UPZy5YbMAUDrdbQWUFj+EH+rU4f4=
X-Received: by 2002:a2e:83d6:0:b0:2e7:1b8:7b77 with SMTP id
 38308e7fff4ca-2e95b0c163cmr71809171fa.22.1716881189068; Tue, 28 May 2024
 00:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-topic-lemans-iot-remoteproc-v2-0-8d24e3409daf@linaro.org>
 <20240527-topic-lemans-iot-remoteproc-v2-1-8d24e3409daf@linaro.org> <ae768bb2-cb96-4a05-8752-66bc6bfdab1b@kernel.org>
In-Reply-To: <ae768bb2-cb96-4a05-8752-66bc6bfdab1b@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 May 2024 09:26:17 +0200
Message-ID: <CAMRc=Me9B3H9NM2VKrVSSce0-o=ZZuC2TQxt7eYLD5aWEKy+SA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: remoteproc: qcom,sa8775p-pas:
 Document the SA8775p ADSP, CDSP and GPDSP
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tengfei Fan <quic_tengfan@quicinc.com>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Alex Elder <elder@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:56=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 27/05/2024 10:43, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Document the components used to boot the ADSP, CDSP0, CDSP1, GPDSP0 and
> > GPDSP1 on the SA8775p SoC.
> >
> > Co-developed-by: Tengfei Fan <quic_tengfan@quicinc.com>
>
> Missing SoB.
>

Does it though? The patch never passed through Tengfei's hands, I just
wanted to give him credit for the work modifying the sm8550-pas
bindings.

Bart

