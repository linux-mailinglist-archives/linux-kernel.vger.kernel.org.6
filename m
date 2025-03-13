Return-Path: <linux-kernel+bounces-559066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4C1A5EF13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33ACF19C08F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334A8264608;
	Thu, 13 Mar 2025 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgzPQA3h"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AED2641E5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856913; cv=none; b=cusgGzkkyMkPH0cHvzcmZ766YwwQX4n/+uKU873WoBpC5AWLi9hKMdqQ0EgOJVN2FNGfXTnbTyeqrZ8GPD/0HHiNDmZ+ZYWTvTww9VAk2uY11GUtzahHh+c5yqH5kmlkwxY9y+Wt3uilIPKejoiQLlrWMbFv4k3ABgwZgPkOoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856913; c=relaxed/simple;
	bh=PbxNz4j52RrqJPz3GT+LV4bF8qpe/4u+tr9NI95kvIA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WHohFMeJrJkzbec442fOC751p1ZQw8EMjMtm4Pz9JPyzaAfourcOB9yshOmeIuEnYXrS4UffwuCTvyKFTVcRmqRVZ7LxrIt8BFk53ydQAvDjmFzsk1lIQYNrWXoOQNsaiABMKL+fc12dPUpxjTFLKGQYdLaUSdH3XjgtfyHOAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgzPQA3h; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3912b75c0f2so31399f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741856909; x=1742461709; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zn1R+ATmllHTaRGwoGw1k9ifxjjFI13zCAnW3ZbN+Lc=;
        b=wgzPQA3hc7pjyxw1zYkpD0WCSoapMWYjrJBI+Y6WI/k9X5V1VJStS7kv7NaI9W8Ekv
         fURVQiK2LWNI/OKQOs9fi1B3iUDP8udB1oJvnWbfdta+5h3upi4nWt2t4Kz7WMDaOGJu
         S8LF3IGdS+84C7zU5QREFduh2DU5cjgDa9NEVYRNBypnUEspBndLe/jMm53DZdZDFZCu
         UvE4Q9GujOjFOTZjiZpjzPtOVEAzqzZ6dD5vPJVNnVN0a81JQRHGwagMOtCzLJbVar1/
         41qaa8aUB37TspDzOaQAUgb5R6v4fE4r/1rUoBwtL6yM3lGN6NCh8JYnDc4kLMmSic/X
         oFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741856909; x=1742461709;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zn1R+ATmllHTaRGwoGw1k9ifxjjFI13zCAnW3ZbN+Lc=;
        b=qxxVOXzB6l/G4joOr0QkCctumU/sUxCMz6wZDEfszhArhREuaPNqsdM40jzuryf2Xq
         SJgf7Yx0RJ1DNXfaUHEFjiIoow94nWB4pPRLywSHfjy9rCgX/OtAC6mQNx/T3sYGWE3G
         0Faxv1/1NSYLbG5vx1bTfXs0R2JujerTNIxOl2Or0kazjE/SK1X215YmepCIrM2aXziQ
         kUn3oTIzFbfqJQDDoZht1B/7y7+aqLae6rzeaQJXofijYT689hoGXrlNRrZ81aEGKvS5
         6/NQow6zPHLjqLbA8if8YpxRohE6bOhedXJqy2nVLcgL91nGiYfe88PmSqlpyeNwxH5n
         o/zg==
X-Forwarded-Encrypted: i=1; AJvYcCVvibpa2/G9WN3d8nPpPkZ/OnBD9Q+qzRIQQj1dMJoTS+kNDcGrWqPzYcz7SBLfmlSL7X4P4ESuAzEcE7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1ROolhPha5nYOhjbGMVEbpA+X4Vg4lgAbwM7nP3fWxmrV3HI
	9Ruwe8f2i1f3OZNf9CUvXLO5oLK+m3W0fmtibqxkf9D191ToiQfThnMPrehfl50=
X-Gm-Gg: ASbGncvUQL8WOknAacdxskTuvusSbGYU5AVf/Gtd03nrw78g7adlq+x69DdOeE1+OlW
	L4KlETBqiy9+GlfA6tNdF0S2tY3HbPuGOYg0zE7K7iLwIM0dBe7MruvsiJ9n0zFgrR7vTIbul2Q
	LX2WVbANTsgJ866squcGgCwIg+x77onVqoNqLjrsuQhXMQBWrbD//2M3NLMXcTsRmpw5dCDRhN6
	zZEzxUeuE2mKarDvadsGpMshb7fz5k64PxBbDbn8C/3X8NL1AZI0rgsjx9jQ0Dhn/bwJIutUhID
	PKfUDI/eQDlUUJcwA6ITvePgqO5TGpXCZbvm8oBEYvpJLoF2sVhWee7MOOhakkGqGgUqvw==
X-Google-Smtp-Source: AGHT+IFoNWWC1jaAyf8PqpUOd5VBK1Mdfej/CVTPRp+XRscWnB9HJyYphIssmDKBjrAxKD2HrwinzA==
X-Received: by 2002:a05:6000:1b92:b0:394:d0c3:da7a with SMTP id ffacd0b85a97d-394d0c3dbb3mr897240f8f.3.1741856909510;
        Thu, 13 Mar 2025 02:08:29 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm1414706f8f.78.2025.03.13.02.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:08:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] dt-bindings: cpufreq: cpufreq-qcom-hw: Few
 improvements
Date: Thu, 13 Mar 2025 10:08:19 +0100
Message-Id: <20250313-dt-bindings-cpufreq-qcom-epss-v1-0-62b0f96ba888@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOg0mcC/x3MwQ5EMBAA0F+ROZuEsg1+Rfag7ZQ5qOpYkYh/1
 +zxXd4NQolJYChuSHSy8BYy6rIAu0xhJmSXDapSn6qpG3QHGg6Owyxo488n2nG324oURbCfjG5
 75zutNOQjJvJ8/f/x+zwvNdUxpW8AAAA=
X-Change-ID: 20250313-dt-bindings-cpufreq-qcom-epss-9ab649df8626
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=715;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=PbxNz4j52RrqJPz3GT+LV4bF8qpe/4u+tr9NI95kvIA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0qCFReYcPk/t6a0zPxCQJuEofxDw8vS8HVb04
 QGJW9zcSYqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9KghQAKCRDBN2bmhouD
 17erD/wOx59i1A3edFPIxjPPHYLwR/Vtp9fBve6w0yseMAocRe42ct5wCLh1k4HtdrULcR3xdEi
 uqGSa02il4AVPSxVi/WxvCMdWZW2UIiRCuH6XYcuvnZZM1udPnjj91QAuha0bFauMmDOhGQJVm3
 Ral9PO/KYPjVZStmnPnI49VMe2kps5IT7OiPNly5kNSAepnqICdj9EWbXnsQi+kD3O4jBYUddhq
 dYKp22qs12FdwG9TuwCq3dg7UTkfbrCQ5W0/ihIJxt9uay2xMsuiwjXAsWMrmvIcduTL7qb5Qlq
 fTz02MaujkQ5hNSUQwQ4yUELRlal6G1NUAZZFZnRUJEPWCCpRd6JTfWb31TIzHzThGSsoZdf0Mu
 K5F4Jop2GxaNis2Zgq0bn6DNr8mUyCN0dQRlsoN9yxVfHcOtF5DfyZUfOifszYM6/XwDlOOn1Oz
 +4+JFZk3DfzqRzdssywzs1M7GvrkEQCW7dBwgOzhD9BZb/BEtvwKdqSDwOkiFhhcqwXz62xYVkj
 CCS8JgGJhZlT67Vx1wpE6z5xfIX+laI22v2ZJZDol49PhC0h4/QqfMTVpSxR2dD0AVniMUgbPLr
 BxKVrKHeGoXMxwO3dHktPn3OJkIFRe1jXVP5K0m5pLrCFKq76m5wS9cmDHKqDMW3CVbXs+oJrTF
 1M2nQ5tKlgFk3XA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Make the cpufreq-epss/hw schema a bit stricter for each variant.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      dt-bindings: cpufreq: cpufreq-qcom-hw: Add missing constraint for interrupt-names
      dt-bindings: cpufreq: cpufreq-qcom-hw: Drop redundant minItems:1
      dt-bindings: cpufreq: cpufreq-qcom-hw: Narrow properties on SDX75, SA8775p and SM8650

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 33 +++++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)
---
base-commit: eea255893718268e1ab852fb52f70c613d109b99
change-id: 20250313-dt-bindings-cpufreq-qcom-epss-9ab649df8626

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


