Return-Path: <linux-kernel+bounces-192686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF778D20B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19BA0282EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2624317083D;
	Tue, 28 May 2024 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qabe9H+l"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8EC10A2A
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716911154; cv=none; b=ltahXG4sDFR+fjLCX3K/3ybmvVaxCq+NPnF2EH3mTH09iGqn275f/J+1P6FBtXtsF8gatW/jgt2YlXFmIxSlfQX+fvMM4rc63UblQmkHPpFlupeuw1nCj4cPT1O+4Afe/qzpQnLeeWy2l6kxObbXEIUwDkBdXTjisKIvfxFnmKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716911154; c=relaxed/simple;
	bh=q1MfIh6grn0AbMqh8NZCYzVnQZtoO53qklXU8iwv/n0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZrQwBD/Ux4CvPalxqta/t3mT00FNyaqy3tUTTAowuMcpSnECJoqzlYkHiIizLwlc2/0OXAXT6CYWZDxigx21Sw935mKItNJeyV6Bm5nuGpUGIADQ4mihcXM/m4mQS680nqvFLT6cErNS2YjPClxbvr8o9aqARSZUDiqqMYTm4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qabe9H+l; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-529614b8c29so1698264e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716911151; x=1717515951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFmMUOqq/DxjQLGDn1p9OXuxdtzNvobZTao/Pq5+Wh0=;
        b=Qabe9H+l8FP+tY5BltxXqGX4OEKn6zVfE9UXd0vtVSdsJo7Gn7EcGL33X7xyXW1bbd
         VeS85XjOInh8qxHBdPQQLiYhN/UnKRVYFk4FyKwzt6dMN30yj24Tn0oVYs39sffUttOn
         ZuIfgHM9o1EkNawSkze0oUvgZeHRJrC2T/EruCUfCGab2VJ0VVGem36C4KG0uGbwOIHN
         c4kyhLHO4+pWwTnk2nver4Mxscc1vyfQadO0cQPvvodoJvLIrYwcxaD9YVBkIJT0AcSD
         tN33i3AZtOSoBmDYyc+pwUsbl7Xh3vFVzBantmGAPO1vxuvLIDUMydiUp0aU+qPcRa9v
         iBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716911151; x=1717515951;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFmMUOqq/DxjQLGDn1p9OXuxdtzNvobZTao/Pq5+Wh0=;
        b=ASO+cViJSXyZcro3yqgZNvfgrh82VK47KYo8jU/SC2lNSjmByf/iavKi0E/QxqR5iS
         nEQw65DI+q/Zt1u+nRr6c1YRSBQ15gNt+Iq8EiV0SlAWJMAiVLa8c7zoJ/IbXjuXwNIj
         +n1BeTx96maEWY8IjOiVeeqtmPiR25PvQdwVlJ9poKd3XnSszE6DFywdgYG36Zn+kEhO
         VqTnt7ufXdnoS1eR/NvpvOi8pLfhxgC8/VMFRhyXSFeM3Ht3Qm/8jy294zrQDe2CT+xL
         ZE+ssYd258bQSp9oEvmqEL1yTVeqUqHwQcVwncuou2Z3nwK6v50jdWNtDEDKUO7Bitn1
         McIw==
X-Gm-Message-State: AOJu0YzwL5gMv0YQSYrwkvJKmnZMgFJ6kCrPZF0c2oLBUyuNI2aTvGh2
	w1xUEsKhbsxjTe05DXRMdFbV/sviMVijKYu6dNBFaE5RthGJXNacx8RWdbBCkp0=
X-Google-Smtp-Source: AGHT+IFyd+K6kPVnJWxj/zgHmtriMwtlD95kXeyD2gmOf8sEQnrtsEeBok9X8nSc0c7CY2/uKzFc2Q==
X-Received: by 2002:a05:6512:34c2:b0:51d:d630:365c with SMTP id 2adb3069b0e04-52965290455mr8728002e87.4.1716911150920;
        Tue, 28 May 2024 08:45:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a634a082b62sm71166566b.208.2024.05.28.08.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 08:45:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240527134946.338398-2-thorsten.blum@toblux.com>
References: <20240527134946.338398-2-thorsten.blum@toblux.com>
Subject: Re: [PATCH v2] w1: Drop allocation error message
Message-Id: <171691115003.217970.5074030398112131426.b4-ty@linaro.org>
Date: Tue, 28 May 2024 17:45:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 27 May 2024 15:49:47 +0200, Thorsten Blum wrote:
> Drop the custom error message because kzalloc() already prints
> allocation failures.
> 
> 

Applied, thanks!

[1/1] w1: Drop allocation error message
      https://git.kernel.org/krzk/linux-w1/c/26bf5fc86033162dbd2d5759094cbd724313d55b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


