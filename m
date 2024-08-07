Return-Path: <linux-kernel+bounces-277681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A53594A4B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E50B24914
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211151D1737;
	Wed,  7 Aug 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U/JRDVL9"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C847B1C6899
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024177; cv=none; b=XPqLJdEJ9csqT54NlJcln7G4UffdCN7LJvtmsgAcrzfa7MeGD2MrnU9XmMXzWbYbp6WFcup3HVXo+jyupv4FiiVviDzCmTu7dPiJLFLruq3TUXn8He8n1/xKHXjNR2o0Wk5o4gpKtgjgNPu9gLIz/3YzZ9ZC4R1jUMTTAjrbv0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024177; c=relaxed/simple;
	bh=p8oOle8j0YyFB8aei5q+8ZxQH0nnNcOH9u81uVEH3kQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tAPiqN2pwadE3qF+Y/VD5t0BfH2bEa/ApJk53meEcugurcVlXjaxk4IygOrFTK+W220OLkObDLh9pmqD8/6CLwJZwLeXIugJ0HyJUQOJjVjZSSgXqlln2NVU49JryTZTZg3StwZ/Yj03Z63W9Gj+Xd1XKmQIhH46V+unvviii+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U/JRDVL9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3686b285969so810086f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723024174; x=1723628974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pc/1iktJr3p9PLDHAKJFkcEhANCClecq2itvdxpvggU=;
        b=U/JRDVL9/aejtlmKGZiVJc2g2hJLNssl+dieRDEFJ4fJJmj8eA7wZ8X+GhFwz7Laf9
         1p/65uTxuyKkmCgM2UOw0dBEhx/aPLouPj4p+yt6hnruAu8i9W9NTymWEg007t5EQfvj
         bCD9ncZBrncK2lY/ysBDOspCH7m8t7Cjvgev3CbEXEALMCK+kV9En1Si8IXoX493bYqL
         RzUho7anmN+6xZ9hAJoZv6fWZsM48fDvHYx8yrQTlFcpvZZxL1RSQ1+zZfL/enEw72bO
         IIEp0QQspvGv+6/rGISowKiQs79ltoO6MwynxsOIWG7rssY3ojvBLue9HKFmcnad7uPN
         aXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024174; x=1723628974;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pc/1iktJr3p9PLDHAKJFkcEhANCClecq2itvdxpvggU=;
        b=NEzk+BGe8PFET90j/54WWCiK/WhvzGRfbIYeqCc98xp0BIMm+Zz7P/w4mCXa4wouev
         oUZlmc1Go907MCuwuElUTwDV19ULplwwwLcaAv5HJUPO92QHchn0H4CxESet2DD4uqC6
         HBjGqDF3gRyg4q8LlEHXoU2hneyohV0nmZN90gwNAUfWn9qNYfxY1udrmLNhs7PzzFgA
         NDdBjbDLGWMB+y5IHHuhfhakcHn/kgVxIX/qFz9R0Rm6qIvcay7oMs7O6UwRAVQYHkQs
         7XtS5w6pvG5j/DTZQV6PVGAkyWr1AP+FDaPYYedb4RHxC6udTjPVm7VI0Azz4HR6dinO
         dW0A==
X-Forwarded-Encrypted: i=1; AJvYcCVm9j1AkxchbKgV/YRdZkz9G3lG0QUleeBryin8/fjbg/q5OZfqX9ZzjQiLh+HtuQpkwZyy9j40sXlCrrtDQSqnNRNFmwJmwNYDJcCG
X-Gm-Message-State: AOJu0YyQN/GPQlttwt+ENBBJjSFzGVoi4JX8sxt/A6pDyZeJ7hHAw+nN
	dk5DbHfFi+t4zoK8yanLA7IIjIkg0L1wPJPlIpbvVAXFcX7jLFL5bA698K5V010=
X-Google-Smtp-Source: AGHT+IG7C+gyfAmIU5emdVImNYDBwmPpefND5NNGBZ5h26Nijfjr5hlnMITUlNJ6c7ynyH03xWfJyA==
X-Received: by 2002:a5d:4ac7:0:b0:367:9237:611d with SMTP id ffacd0b85a97d-36bbc17bfebmr11861794f8f.60.1723024174050;
        Wed, 07 Aug 2024 02:49:34 -0700 (PDT)
Received: from [192.168.68.116] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd05982bsm15530967f8f.86.2024.08.07.02.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:49:33 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
References: <20240228081355.1627744-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: support i.MX95
Message-Id: <172302417240.381927.16775224846160228092.b4-ty@linaro.org>
Date: Wed, 07 Aug 2024 10:49:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 28 Feb 2024 16:13:54 +0800, Peng Fan (OSS) wrote:
> Add i.MX95 ocotp compatible string
> 
> 

Applied, thanks!

[1/2] dt-bindings: nvmem: imx-ocotp: support i.MX95
      commit: 62e39987d3d5f27e2c074398805d101d7b9abaf4
[2/2] nvmem: imx-ocotp-ele: support i.MX95
      commit: 04d372dd5562ed8aed4cdbb1004fe33a3bc4fa24

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


