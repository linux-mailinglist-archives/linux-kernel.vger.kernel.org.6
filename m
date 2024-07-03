Return-Path: <linux-kernel+bounces-239142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6073925716
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC521F21ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229AF13DBAA;
	Wed,  3 Jul 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/itL3Cl"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B513D617
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999778; cv=none; b=n+C4lmJesWTtv+f0k3mBWuQLuL7GCawIWlELTnfFGximhgS5aun14xc7i21z/3CtoekLQsISj1NE3EPxAgFQQeknYJYTugD1ROZXYH1F1JMow47T+qBvEZaL2eLW/qtoJyWmnfhMZBqd7yQzX3HAKLh0fWiKhsdM01xOkA5dBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999778; c=relaxed/simple;
	bh=GQN4rXHx2UG2oivNmrtAmX8dq+E7nruQfMN32eMd1eM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=b5hgxSF1IFPCL8tHBkk+S4PxmOYlC6wxXwMC9BEMmjhTFiwOZjzOR+XGz3wpJlY1N6+tjolxKfFPPFzl/nVkGYrAFngxNv/vKZUmQHMEzF8pmH34VR1x+wJav021spyqT5ubz6O9oeIyT8A28Byd2pUD7LuqKNkPStCmFVaZ13o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M/itL3Cl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ec5fad1984so70788031fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719999774; x=1720604574; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcmTclZ+42BPmUE7KTzQ7bpGml0JNnglidN9Azk6SEk=;
        b=M/itL3CllqLwJpZtavmrF91r02l456mxpNFzbkg6mmtNBFfSFK1VPLagZF0rROj65b
         CGBb414OQqYFzK0NgDJw9UOH7bg55gFSRpLQCcqjHK+LsXuw1FwgNWy9bh0liDuvIKHl
         At/3p/Jja9nskqXLknxMmbnziidOlvv8j6ahB+xEjPTPwULxWjyv/9xzr2zRVEWXpaiq
         MTiH5dRuqw6GhngPpfGdZI34ljRPKIwMOtMfr94mfvtMfQlqejG8DbjeVuBq8iJ6OlBV
         1tMTj8Q9GZuGdAXfsUdjyRge9WFMJtgXiWU0DK1UeP+UiDTQblEERpiSrjWBFOi0LV2F
         K2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719999774; x=1720604574;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcmTclZ+42BPmUE7KTzQ7bpGml0JNnglidN9Azk6SEk=;
        b=QR9m0oTetpXvSpf6l5UW8YavBifAUmFw6vMRKzi8862S/ZDFW+8SxWSW2fOVBcyIG+
         VlkoddAJusfB5i/CASFnTOtoVO+rrkeNGw6YHrGqX10pva1pI5850YoEZuvogrDuo/k3
         u77dmd8X+jCgNL2zgH+th8Iv8NwlJGuQWLkF1ubE/M/ArVPzBiaztx2AQoyxmOpx8YSO
         V8bfdREG9Ic82qas1zJUMRNc+Fjfgqsl5RP0ioPjx8UKAFZGi7ii/meMAr3fW7NWNVDK
         FaCSDqT8X+QTMl55A2ny8tAXU0slHMP7iJmiS06YEn9pL3TVx/jFE0LlZe8eaWx0CUQj
         pIsA==
X-Forwarded-Encrypted: i=1; AJvYcCWVlua02HUi4/KM8bNafmCRoelqhML2l6y1nm6nizcO6yrT/MrE/llRBqQUrW9UC+iaOdJWG9w5o+p2EKd94kH+59bZ1/0/bDEncD3V
X-Gm-Message-State: AOJu0Yxg5mtLAJKm2xIUQM4U8I4hsjfhyJ3PEfB2KSHzwF5FtXQysQpM
	nNlCApHIq7Ya+oyOF8WXriRJ3YxmKHdXFQDKbo0ec27zcDq5KChTu9s1znOM5NIiGJlsxU3qJrY
	UjdE=
X-Google-Smtp-Source: AGHT+IFnEkb03dKoaJAxJdhF12F8Nyu65FGLFVgQujGEPXwewpoF1sy+/o5+EWS5Ghm6mQEo6JZgfw==
X-Received: by 2002:a05:651c:a0b:b0:2ec:3e02:9737 with SMTP id 38308e7fff4ca-2ee5e3809d7mr100384011fa.2.1719999773268;
        Wed, 03 Jul 2024 02:42:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a1030dfsm15341394f8f.100.2024.07.03.02.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 02:42:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] soc: qcom: simplify with cleanup.h
Date: Wed, 03 Jul 2024 11:42:35 +0200
Message-Id: <20240703-thermal-const-v1-0-6e59e139c65d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAsdhWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDcwNj3ZKM1KLcxBzd5Py84hJd87Qki1RDc6NkQwtjJaCegqLUtMwKsHn
 RsbW1ANLT1MJfAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=944;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=GQN4rXHx2UG2oivNmrtAmX8dq+E7nruQfMN32eMd1eM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmhR0UZWMBNeWKODlZmQc61lqHBah8QITW6z6i2
 o6bK/gmFxaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZoUdFAAKCRDBN2bmhouD
 1/6xD/94mznz3vWsK0/dAbCAvZ1bIfoyk+3jf7gidJ59nflndcThT2WMijVuCsyP+7v/8LAV1HT
 w4vcuX/TQOkOWm2GIdNiXTw7f8csu18Gx6TB1iein2vqodCq3O2jO8YA2CvcLVLi2CquEx/5q5y
 xp9F/i9XOXwZJDdHaXJTI6K0EBxle6zZ+jxdpNZi4UKegymE2ojPCd7f0O10GKIL1XTjQn+Opk5
 mCbxxxi1tukUTcE6+mt/fLT/Tfww/MVb8bpFWvl9ifNXjeb6vsRx9pKscPkoBH/sY31TPbmjYVO
 XKgK7suDh/LJMNtUzfpAVXie1hy1lwQKnEoYJs3GIf/2mGCWgBhUcEBeJGwCIafrLYRzQCuTP6+
 Kov9HViUfmaxW3/J4L/e76thJwNqTO9NzhUmC2i4NBiyYWwW4+sm2ajAcENtAKQ9jBkjBmVQs9u
 ONS0Pk/V96IQnA47pORfvGEJjDww+AZOI7gkNaB9ROHs6mYA8YXk1Yddw7pY+B0jBTGbqFHUAQ5
 ILBu3AVX9Ywl0VO8iuHo647bmTefn+y+rpNVxwYGE1J7UZQqXJhtejg4wgkHV4lg4fJp4FQymqa
 VRWEI2ALINiCXG6jjK3BQpmGSpg/hCZMccD8YkhLAAtoy7qrHgFE5Eg5Og10+d2uwS5KuSwuG+E
 FmkSYx98BwNGZMQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Allocate the memory with scoped/cleanup.h to reduce error handling (less
error paths) and make the code a bit simpler.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      soc: qcom: llcc: simplify with cleanup.h
      soc: qcom: mdt_loader: simplify with cleanup.h
      soc: qcom: ocmem: simplify with cleanup.h
      soc: qcom: pdr: simplify with cleanup.h
      soc: qcom: wcnss: simplify with cleanup.h

 drivers/soc/qcom/llcc-qcom.c     |  6 ++----
 drivers/soc/qcom/mdt_loader.c    |  6 ++----
 drivers/soc/qcom/ocmem.c         | 10 ++++------
 drivers/soc/qcom/pdr_interface.c | 38 ++++++++++++++------------------------
 drivers/soc/qcom/wcnss_ctrl.c    | 11 +++++------
 5 files changed, 27 insertions(+), 44 deletions(-)
---
base-commit: eec3a8b019937cc4520772df2657a8a105250e04
change-id: 20240703-thermal-const-7fb8e172c183

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


