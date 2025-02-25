Return-Path: <linux-kernel+bounces-530830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB30A438ED
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B4B3ABB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D0266EF5;
	Tue, 25 Feb 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5dcfnXh"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701111482E1
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474346; cv=none; b=crJ7r5SmZn/3BhUGAHHlBpxlyjd4LdODdKRXYG5Y8ZnnZCdh37ScTe0EudKBgW3FnY6Q3Z3aFpnH8i6OEydL7s/Z5VhaEgYj6pDIdUop7PH6RYZa2yed6xmTqZZAvA+wiol6cq6o4DTXT6SW2r+Fleo2Pl2wkm1DPzcUfqLlU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474346; c=relaxed/simple;
	bh=YEERJeZoPF997TVwE+PlqQLy35gdriCa6KvLbtYzMiM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OV3A6JLNrkyYwvVfrvdhcp2QdV2IFLW90OQjYYjTqgF5B5wDRgFWLCjjDYVm6ZYNDjsE1Atpx9oUcfOwz+u//8NzQ+BiazzonnFiSfCrB2zi9vfvYbkXo8GhDCiYNiD8TMa+rqDC3xMVps333R2XfJ9cRztmq2gsTcHreiD4tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e5dcfnXh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7d8953b48so85574966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740474343; x=1741079143; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pUUlyd7n/V07DcfsSYjPFFab+d4+yvvoCEwUK+Z2ilg=;
        b=e5dcfnXhSFDiEY8vlKvmqvIz98C7LVqD9zXKbnTcO15G6jMlSlio8Jhzb5qigVRYgN
         +GksHNbKmoz793O2fFc2sCIyRrfq7uko4rJM+eChSb1kjR+jwW1TUnrJhJEsH/4ynHkb
         +HKlFNWzhwj1HAd0CUyGbTLX9hsDgc5qXN/byJnWzEW1VE7tvdq+MTa70kqsrWOI2lV7
         ghqTHpJTY6rtv4L+BvacDrdGbgWpNe89mx2Z0e0NVo7FUvkXbOvm7yv3wZmhvkVoSnyY
         FTq/EZUFmmYISOZy/hDc+B5XqJhgdI+D9OZEGJXkcISC4GPZ6FgXGid/ru3g1fKSnii0
         yUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740474343; x=1741079143;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pUUlyd7n/V07DcfsSYjPFFab+d4+yvvoCEwUK+Z2ilg=;
        b=bB0na5P5O6JJ76ooMB42KBhYwUDON1kXA/X+OKu/O5vr6jTeldYhs+NpL1WdZjAT/q
         ZK83DzqB86zNUsvktsM4bEbstaXc1Nhj9zTRx8sYLgg2mtJC7DlXxZd0ylQ5a1QXH4zu
         BUwP1bJQxVxRMvFA+vC9bJ9R4Ft7y8jBBpYMxIk7hZOWL8iayCz0JZ0zcxNbQn3Cpbxs
         4wAecxj54WhfyoOoZFSsqPX8cGzcxaPifIpQZYfcZzYQACpw9Ppz0dlls8S4+dGRBVc4
         iYFoFu3+cLlua+VLZ2ZjXEL9PqB32wtWVe2B4JvjPftX0GVcX02ylAnmv6ZSe5oeX8Wq
         TY1g==
X-Forwarded-Encrypted: i=1; AJvYcCWlueCEBF9ImosrOMnmTx93NDDxWZcny0PNzNLxDX/aA9EYjIHyRX7HOH/CtaJ8aK5I4jpqR6Y5wyWktbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2ws8cUW3iiH7QdOcEZeKwGatD75XB1SZd02x8Zpz9KQMxEQ7
	k4FZJRwxIDbzlWGLnkTIC/0q/ckuYNLjLXpgykUPbvyPSizMxSRd+meCgVJ9FZw=
X-Gm-Gg: ASbGncsrj6dVABHzEoeAS9adbb2DBc7+T75ZHxZK5JsJsp3/hUwCWDnZWOVshozKJ8q
	aGwZIF5h2+4yvZI/m9pZYKDsAaxRytza+IdVejPJgFZMNforwWC1vGl2US2hjjWTAOeetqxtXTX
	4z/lT4rjVgg44WZIaf0uK70vzh4X8cvIIJv8sNx0bmEh/mTZv7EKNx8r8fNa6ju+Wf/mR1l5/85
	U5eVklwqLU+xHj3ExQPYLXwIubqBSo/0MAdbf9MslJjYE8Xe66deeEArNq+PjIX9U8IdfodiXe+
	dVDDsXAYZdHfscMJdMLgQ0/9TIlkpiXazyGQfJKVzP7sXQB1quGLMQTN2Y1BxN/I4ykYsUvucwN
	C
X-Google-Smtp-Source: AGHT+IGeX5QyzoBAu4IpQoqciAgBU5d16IJe/4mHV6mquagEmf3K6CXUzjJ3IjzzzFJVhCmX/1OpWw==
X-Received: by 2002:a17:906:4fd0:b0:aae:e684:cc75 with SMTP id a640c23a62f3a-abc09e5e43emr589617266b.13.1740474342685;
        Tue, 25 Feb 2025 01:05:42 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d58sm106681566b.148.2025.02.25.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:05:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] wifi: ath10k/ath11k/ath12k: Strip device prefix from
 calibration properties
Date: Tue, 25 Feb 2025 10:05:31 +0100
Message-Id: <20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89c53@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANuHvWcC/x2NQQqDQAwAvyI5N7ANbCF+pfQQ19gG6tpmRQXx7
 y4e5zAzOxR10wJts4PrYsWmXOF+ayB9JL8Vra8MFCgGoogdrjYY/tM0YpKvdS5zdXARN8kzMkk
 g5qjMD6iVn+tg23V4vo7jBHe5XeRxAAAA
X-Change-ID: 20250225-b-wifi-qcom-calibration-variant-92a02995e996
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YEERJeZoPF997TVwE+PlqQLy35gdriCa6KvLbtYzMiM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvYfd8TmILlw+MFwINOy/nLQUmg2zl8km+Ln7c
 J3+lOtybQCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72H3QAKCRDBN2bmhouD
 1zsnD/44e3cUCbRaHwvp+ij8S6BrUfCtAMxyq3lq23DWCpFKr+HPO8RmeoZqRn/0w7dPIkv9Y9s
 ywZHeRGxqbGMzGv5zUzMzY04LiLnD1IhQpp6LPojhMARGGu4tDCdegip8Ut8LbEbQezpcMferxi
 z7eZVy73tmFcV/SFF1nhsRPnRPTaETfiWCiy93zDtQKJtcJd2O1OrLZsY0zohJz3nuY3jj3f0CD
 Bf3RvMIyuw6SZDEY2NsnT2ax67OpG8KWIXW3vKqxwNqolqYU7LLnXvmoK8BMls/FJ5YKcYCR3BO
 zotiCPXpnaIYJfe/kkYNdF7Bq8kZ1qFMrFVOMN+YRd+MB1iYt6n/WeY16EusBHJulhCdvkkTCVe
 D29D30MSi7QTx/dSphQ5W/xyvqtKu21tHN4Xo0fCOuhitHEsxZ49QvNuvTcUpJ09+UeG0duKJLB
 bIDX7T8qwfUtU/HoJ2+dVjWFugek1Z4YTuPYEiFI/yNn58rUWmWmtX9p3Df1YSKMa8+QWHyggTi
 lDWC18zd4lzUlLQW/ERgTR7PreqjqopNrkgnPY71ylb4k9YhJaSXy1sorvI+enukYvIe25iMFDV
 xW55Ao+KZwoQ7pwiG1ZMgpmslqXlK5rrZLH39Es5y27stOf4FRovJvA3BAqWnOjxdG7KCK7Ash/
 1duSTx28oN/UydQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Devicetree properties describing exactly the same thing should be
reusable between device bindings.  All Qualcomm Atheros WiFi chips needs
certain calibration data, so properties should not be prefixed with
device family (ath10k).

Deprecate qcom,ath10k-calibration-variant and alike, so we gradually
switch to a common property.  This will also allow moving these
properties to common schema, if desired.

Why? Because people add qcom,ath12k-calibration-data and probably they
will add qcom,ath13k-calibration-data, qcom,ath14k-calibration-data and
so on.

I will fix DTS in separate series.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      dt-bindings: wireless: ath10k: Strip ath10k prefix from calibration properties
      dt-bindings: wireless: ath11k: Strip ath11k prefix from calibration property
      dt-bindings: wireless: ath12k: Strip ath12k prefix from calibration property
      wifi: ath10k: Deprecate qcom,ath10k-calibration-variant properties
      wifi: ath11k: Deprecate qcom,ath11k-calibration-variant properties

 .../bindings/net/wireless/qcom,ath10k.yaml         | 25 ++++++++++++++++++++--
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  9 +++++++-
 .../bindings/net/wireless/qcom,ath11k.yaml         |  7 ++++++
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     | 13 ++++++++---
 drivers/net/wireless/ath/ath10k/core.c             | 13 ++++++++---
 drivers/net/wireless/ath/ath11k/core.c             |  5 ++++-
 6 files changed, 62 insertions(+), 10 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250225-b-wifi-qcom-calibration-variant-92a02995e996

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


