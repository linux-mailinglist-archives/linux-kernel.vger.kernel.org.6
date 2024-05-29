Return-Path: <linux-kernel+bounces-193605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1B8D2E89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4549CB25624
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16459169360;
	Wed, 29 May 2024 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cXmzgQLN"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB4167D97
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968445; cv=none; b=sMlEQ8MIlMvjBN8UJS7vs8dDnbplv3xo+iFM4FoIWTETnyl1UEhyn4GgRsPI1/mS1+gPpI9602QuazXdgtVMQWxTG9NUf2Zy8wYfP/+E4VNu3lyZpv0cPhfXs15OYwnVepklq3jhbYmPZJ2FcNRxVy4yvu8fiVlMyLRlZXbiD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968445; c=relaxed/simple;
	bh=Kq75PX3R0lwU8jkUE+730+MzES2MK6LfrzI3HXbTdic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnZQTMBzLdiiQVKqBjvhv9jWOpcYmEintkULhJe3A1gedgWoj0Onb4QHhBD2A4kO4W2ws9AZpVokw2HNDdbXf3OLgzXnWrIfQxWxjuRqou9Qu+C9DKT4I46sQw9CnqgavZ621E05Uz19VXmHWp9XmygL6e3uQ7QUrHBbC53nm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cXmzgQLN; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dee72970df8so498909276.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716968443; x=1717573243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qi3rq/lKfkTKHCFllxIMfEiNIgwb77QXH8sn4XLhppg=;
        b=cXmzgQLN+TZjCNGfO3XylDs6ogpLcAFtR0AzNJ802+aOO5gSNJRNPDxrYnHgt0AVUN
         k+tLVxMhNpZft7XEjGw8X4hB1D/sf7D+C+eOvNp6il5ABnO6VMZkPH7hQ1yz+qGz76o8
         ajjLmm+SxjJRXcI0Y4tnylhTAB8xaE0Ia6JMf5UxA7Mj/NG74d0QlcUQxRVaOSMZ63Qy
         6s4FyVAAYhoE/2JcR9oJoi9yvLbVXTwf9gByKNcUeMXOiEZ9E5jj6oKqTsK9fvfGmRQT
         HW6trY4WKkFWG9zVhALnOCMH9nYl1AU1zxwX4bX6G/1CuoM788bQ0s9W4FHSfzze4emn
         pIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968443; x=1717573243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qi3rq/lKfkTKHCFllxIMfEiNIgwb77QXH8sn4XLhppg=;
        b=Uzb7Dkh3Ud1jzK+TcOicpsEBguAcuKJN3zT86yzyRp+9IaIGzbsXOIGJrGOTqACjHO
         IxYp6bMt4EJdT2zbHQ0rYNW8n064dW2H7qqqCP75yIyIJELxynsw3koDfjzStI5DUNPR
         71wcaACP/Wbw4CcEjXq3oAVZYLLz3Tefz9tgfxORhihZRfctB8NTC7RRIIwf0DtdTj5a
         TVHKh7NTRy9Vpy1ATQ4tYJkYTJ5qpQluw2A4REaXiK0mct06wJTHn3HeI6N3l61eLsc5
         ZAHI6PkrHE5JXnOZlgob11z/Z5BUSeNlEEr8dTVq+sffNjBaxhXoq/jaceR1/opzvPA7
         EcjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcrktA4R2BbiyfzKnVdA3ItPcJq2/40iOesFv0a+fS3OuV9KFt1N1sN6Vrk63viH/LOzbEpji+FCVXd8Go5jwOLtzHOtEvjkrCdB9B
X-Gm-Message-State: AOJu0YziFHLCI5y2FSKDAAWwC+hjaZJjjPwRv0nHw3fsEYDiiyh5Z9c6
	TBIbFNMC2O9Yp4gSQQ7B/n5dOo+vykmthukMgOEMzSepfzSm4eyeCzpLY4zrkGxnKKw7e5h+yiK
	StPLjpjrxerD23xoGvm8p6Q5XMCV29OCmIm//iQ==
X-Google-Smtp-Source: AGHT+IFvNvlDRb0RRyGJLPid0eBANNAt5GYyAHLtB+VTyIBGbkRANVmJBbGXYfdU28+FTfNGN7gmsi891v5NwqN4/Ys=
X-Received: by 2002:a25:4bc2:0:b0:de6:162f:c71c with SMTP id
 3f1490d57ef6-dfa4649391emr876301276.18.1716968442860; Wed, 29 May 2024
 00:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528-qcom-gdscs-v1-0-03cf1b102a4f@linaro.org>
 <20240528-qcom-gdscs-v1-5-03cf1b102a4f@linaro.org> <a893eb89-1956-4ba2-84cc-e9b64b87524a@kernel.org>
In-Reply-To: <a893eb89-1956-4ba2-84cc-e9b64b87524a@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 10:40:31 +0300
Message-ID: <CAA8EJprwQ0N_PfPjTHFppZ2SdQVCXxPrZmVZ0B8+gybm_75toA@mail.gmail.com>
Subject: Re: [PATCH 05/10] dt-bindings: clock: qcom,gcc-nopd.yaml: force node name
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, Robert Marko <robimarko@gmail.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 May 2024 at 10:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 28/05/2024 22:43, Dmitry Baryshkov wrote:
> > Force GCC device nodes to have the name 'clock-controller'. Several
> > platforms used 'gcc' here.
>
> Well, only ones coming from Qualcomm being downstream-based:
>
> Author: Varadarajan Narayanan <quic_varada@quicinc.com>
> Date:   Thu Jun 29 11:48:33 2017 +0530
>
> Author: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Date:   Sun Jan 19 18:43:20 2020 +0530
>
> (and there was also older with node name qcom,gcc, so clearly copy-paste
> from downstream sources)
>
> yet still we do not enforce names in individual schemas. You add it now
> and next month turns out there is a power-reset-clock-controller which
> could use gcc.yaml, but cannot because of node name enforcement.

Ok, please ignore this patch, I'll drop it from the next iteration

-- 
With best wishes
Dmitry

