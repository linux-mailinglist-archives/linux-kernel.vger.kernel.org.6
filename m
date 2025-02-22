Return-Path: <linux-kernel+bounces-527365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB940A40A56
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D9B189F78E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C453D984;
	Sat, 22 Feb 2025 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwQxLk1w"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657D1487ED
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740243046; cv=none; b=Zvpahfv1JUryenUbDWQDSfrKUVGbGeDu6AOS2l+yaLb3WXQo1GeXlUEHkjaaZv0snOX6L1kWgQ47VpRshri+Ixv+w87HFHZSNrBZffBjwc7Xh0M79az129FY+tj6TnfFZA8pI5mkgkyJ0cZufVC98Pb2ZBapOWDeoqhBS29w+vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740243046; c=relaxed/simple;
	bh=/OChm8Qzq++h2Z0XzJa9A1Q8OC0xJGEjGJZCAa2C5lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfnsou+yZVKeKwVYWQRWHvhpJdzQ4ZxDtlNU2YeOuBeXUA+tMl8vhkT5kp4DmPXsxe4w3x1U+yadyXHzbJcP8iIpmMXqWYZXJoyQS7Qd6IfCpktv+OpmlL7AzoNLpwwcPz4zZzWha0xV024KRUd0EUP5x6qldkye2qSydmzy8oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwQxLk1w; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-221050f3f00so69970415ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 08:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740243044; x=1740847844; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nh3uPvkc34gfmbS9x9Jf9cyF6fwE3/AJhfsNKJ7Ug5s=;
        b=zwQxLk1wHPc+FGHKgpyd9Mqngre4hZA3l5IC6WkbMOzm7rqF6cegvD57PfKf8k1L/T
         4t7bZoVUKaeFLZQfsepgj0Fe5rVDtLOv2lzIQXsuNvaoSDAiv201gTdcAHgITHw5rkj9
         ypqa2UAHKo6B92bCG0nuCjD2nQ5HgfCvbkYdJ+cahdmys/9LbBGGl26AZsx1wjGxKHjN
         goEnh1Rajslt7LwQXA6OLXS/DUWtEkJR6MBlh/2voNStEyHRK2LQ0OTXPdYHTMOyFxag
         SIiyhWtBPtJPEni9kr5/NTimAl6mc54jLfPUZFPwa9aBm7nir8sQBeiYgTZdGuT0/iLn
         r38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740243044; x=1740847844;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nh3uPvkc34gfmbS9x9Jf9cyF6fwE3/AJhfsNKJ7Ug5s=;
        b=DV3NfRn3nBZ6A9Kr5HYhob/GuD9nyaooFSkU7S7th5aMOPgyvSNtA9oKyVpYPrFiI/
         gaQffbIO+tu8VtUgon/fz+WVFCJ768RtZ8EdxISWoKLKPmf8ONTXUYNfh9t3XHNyp36z
         ClGPSarRT0lnd09eJPG4aI0dAYZps24Zmmum+mHI9/mQ19uX4KUo2TqEEB9e0OEv7hIT
         1jsP3FkpKtSNG6Onp+Dl1ocId7hJbVj8IvJTYWIXqylq2DULzizEsvpciWisGH7iEzjr
         Xz1ur7t7JU9/7LPEme1ozrSaamN/R6Ba29KhqRKJ6IYGr+D8kJLpRF7jZLuEyA2HdxKP
         Ry/g==
X-Forwarded-Encrypted: i=1; AJvYcCWiF0DfTtE1700ZcA2V8G7Zpu5Gyw1dafvGtNHJeCyefqECt+58V3ynYoI1el1qXZNI9skW3Pgnt8biLv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj5HytbKoBL38LGIt81mPHQq+QYWS7slrIa8apuRWdQ8vVtudb
	hXbmF1EInGMlWR39TOxi+k2Vt9bCVhXwmjBxu8KmD4H2ryn7QOuy18ji92PRUg==
X-Gm-Gg: ASbGncvAVlkLXTjike4ypCQYx56D4pxssTBcKlwzRNtdY/FAkRgDp7BYQYNWMtXvzf6
	4A6NiTiuineuORo9hfC9zPakYVijRfui44GQXjqyyTRRVpbLR159a6ZpCrpQdmvoQrLiOa6L2su
	58+6Jf1hsK/Mq9l4GyTt+M95cTrUBF2lO2neSifKvp0whZRz6P12xfJhfHLmDG0s5vLxPdfjFam
	DlakmIjcDzrP7P+KGPvQRVU8JP5Vpd1+GwOTGJn98gJkPU2CCF0vTuyYPgYjJUS4Cj82gDYKqKH
	1GgusuisY4Wy3+OT57p+gqYIlilW4X24ROLrzg==
X-Google-Smtp-Source: AGHT+IE+8VM4q3PcS+7asdjIzH29CbmnLh7RVggUoKvA5I0EZzfah7IwjW111tGxF+X6VyOekWmPqA==
X-Received: by 2002:a17:902:ea08:b0:21f:988d:5756 with SMTP id d9443c01a7336-2219ffa35c2mr127317725ad.42.1740243044225;
        Sat, 22 Feb 2025 08:50:44 -0800 (PST)
Received: from thinkpad ([120.60.135.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53494cbsm153853295ad.43.2025.02.22.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 08:50:43 -0800 (PST)
Date: Sat, 22 Feb 2025 22:20:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] PCI: dwc: pcie-qcom-ep: enable EP support for
 SAR2130P
Message-ID: <20250222165038.eyausqiccrivkv5t@thinkpad>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
 <20250221-sar2130p-pci-v3-6-61a0fdfb75b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221-sar2130p-pci-v3-6-61a0fdfb75b4@linaro.org>

On Fri, Feb 21, 2025 at 05:52:04PM +0200, Dmitry Baryshkov wrote:
> Enable PCIe endpoint support for the Qualcomm SAR2130P platform. It is
> impossible to use fallback compatible to any other platform since
> SAR2130P uses slightly different set of clocks.
> 

Still, why do you want the compatible to be added to the driver? It shall be
defined in the binding with the respective clock difference. Driver should just
work with the fallback compatible.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

