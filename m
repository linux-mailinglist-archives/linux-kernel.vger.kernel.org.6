Return-Path: <linux-kernel+bounces-355921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB2A9958F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 23:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BA21C2168C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF801FA257;
	Tue,  8 Oct 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PY5ekdy4"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427DC213ED6
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728421792; cv=none; b=saOJHVyZzAFsUIu2X27MVLm2xOy5jxpuofern8khTQOzH6AUPUjnM9JoLd/pzKKH3HIVFXT5c7aANCRgVWWz3NDXyWXwOhu+C87aA7I+WzjANzLQhm9Za9z3xB9193SqMnHzkZRz4BCNKIfKcxByuCDdhUTs0jWS9EUPqTDAWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728421792; c=relaxed/simple;
	bh=hyWIP5eJKGtUp3spZH1Jx+5Ok2/SdHxINGcAzxM1fEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HhawnlhgvYKwh/jYFtPgi9Od0nSzJhoaXEsHtY0JVKincKFDv/xry/RCtyVPQk8hCUkoOfyuSkHkUKFBXf9yLnWZsc70AmRB1Z+k+C+yG5ZhLScL/9aWyx0KGuzmWrXqbI5nrSQ+jH8itCTgG9/oMmMaTDwxhwDHhyyj1CumpNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PY5ekdy4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a994c322aefso39456866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 14:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728421789; x=1729026589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qxjO03/VKF1ZdXNHu0b4MwlOXd+MaamBCo+HahwR+pM=;
        b=PY5ekdy41T9aR9KQtUqBELBOi6WB8tSR6nNMmMnSu4/uzZABjxb3s9xtwndmrQxQGD
         YdIgvKqJppqPJCUwU+rKYozHpGEhO46JBbOKFpuLWRe2axEhWJ8GGxKNooxqn9SWaXE6
         iTQpv8QtLJf+MjAv2AQSJsZ6BgWDXmQlAx9a5sMpmyiTVAjRNq4G+j+woAQgXcQRugX0
         jTlgD7gsDWnnllGLnno1U+A0wrPyeglx7zt4Nam20k3nqKJ0HREwGmGra7jUNxMpeJxS
         iZqHgjqVipZ5r99ahcCyBdbfgb6qkqjuGi4Mdvz0aFTv00Mm2hnxSA+YK/nv21ySfR2W
         KUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728421789; x=1729026589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxjO03/VKF1ZdXNHu0b4MwlOXd+MaamBCo+HahwR+pM=;
        b=IZ0Nx0Texu438ZU18RXRC9Ru2znTItmTnyxm+hUObifKl2PQcBOE85QB0rK21sGg8F
         51bi2lFPUVWMrYB1ZFD4ZiBfopoYn7IvuQSmp4SfLdYFdwVR3nEY+EZvLiofgl6g+lJX
         a6ZxzHv1nyHP66VO5P5KTylJd8ffv16dUeeSqpVEmhIJolCMq/o3PzABNrsRJ+ZF4iKF
         TIpg5bGipTwuJZnYD2D+4jmyhkkFwE84dzw7TWyPwHXI/hACjAwcXHGNhNpEQ0XTN30A
         vf4srGADDwa59Eg+9w/hmB37B8Fyxzb0Fa/Z1t45rpZGuv28+IZsehPbZ5eWDiqx0WT9
         egWg==
X-Forwarded-Encrypted: i=1; AJvYcCX0qnMVgbomrrdlIpwZn8qzkDkZel8PGnJYm9Yo0frFzaZ02NStjhxqNFCW5NeR35psyKCYLWmbXgH0bIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdBtKtMkPtS9KqzdXwtbD/qyc9X5L9Ps5oWkLXqDv9Y7SJtvoI
	2bV+ORYsQGKvqpCbQ37dLuYqqOhOrQmrVZoolq5UaLrJWMi5A49RsohNknQ5YQk7ToQyrcze+Ja
	zGJHsBEbvBauP5L0oB3/UK50WHn27ezDp9xwoEg==
X-Google-Smtp-Source: AGHT+IHuRG726U2Y6ZtAy1CX+xs4xcXsSCC/YjD4M9T74lVo8+Q7BfO44Qpxr38KfN/hQc1yWSyhN88MwVK11A8TaW4=
X-Received: by 2002:a17:907:7e99:b0:a98:f44d:a198 with SMTP id
 a640c23a62f3a-a998b138451mr47590066b.1.1728421789412; Tue, 08 Oct 2024
 14:09:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003211139.9296-1-alex.vinarskis@gmail.com> <20241003211139.9296-4-alex.vinarskis@gmail.com>
In-Reply-To: <20241003211139.9296-4-alex.vinarskis@gmail.com>
From: Stefan Schmidt <stefan.schmidt@linaro.org>
Date: Tue, 8 Oct 2024 23:09:38 +0200
Message-ID: <CAEvtbuv1OUekj5=fzafJKby6jBiZ6BzgT4TrrihDNdiQQM_vQQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: dts: qcom: Add support for X1-based Dell
 XPS 13 9345
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, robdclark@gmail.com, 
	peterdekraker@umito.nl, Bryan.Kemp@dell.com, tudor.laurentiu.oss@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Aleksandrs,

[Again in plain text]

On Thu, 3 Oct 2024 at 23:13, Aleksandrs Vinarskis
<alex.vinarskis@gmail.com> wrote:
>
> Initial support for Dell XPS 9345 13" 2024 (Codenamed 'Tributo') based
> on X1E80100.
>
> Working:
> * Touchpad
> * Keyboard (only post suspend&resume, i2c-hid patch required [1])
> * Touchscreen
> * eDP (low-res IPS, OLED) with brightness control
> * NVME
> * USB Type-C ports in USB2/USB3 (one orientation)
> * WiFi
> * GPU/aDSP/cDSP firmware loading (requires binaries from Windows)
> * Lid switch
> * Sleep/suspend, nothing visibly broken on resume
>
> Not working:
> * Speakers (WIP, pin guessing, x4 WSA8845)
> * Microphones (WIP, pin guessing, dual array)
> * Fingerprint Reader (WIP, USB MP with ptn3222)
> * USB as DP/USB3 (WIP, PS8830 based)
> * Camera (Likely OV01A10)
> * EC over i2c
>
> Should be working, but cannot be tested due to lack of hw:
> * higher res IPS panel
>
> [1] https://lore.kernel.org/all/20240925100303.9112-1-alex.vinarskis@gmail.com/
>
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/x1e80100-dell-xps13-9345.dts     | 863 ++++++++++++++++++
>  2 files changed, 864 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts

Tested-by: Stefan Schmidt <stefan.schmidt@linaro.org>

regards
Stefan Schmidt

