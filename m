Return-Path: <linux-kernel+bounces-252574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997CA93155C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B8E284924
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A06718C35C;
	Mon, 15 Jul 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B7vHuuOE"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E1718732C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048952; cv=none; b=PPXIbeHe1SUrxX/r8ormJSUC6nLD2bF/Y4zWXHE9DLI2gttgU9szvGHLp84JMKuKm1jkIh0aKeSWaWR+bF0OZ8AV/UbG24v0Ipn9jOZ4njephPl4ZjpffzOJxuy1hivcly7mLHGKMpQCKZBpGJpsybcDDs4vLUg0JA4iqclPJt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048952; c=relaxed/simple;
	bh=IFLwMoxCunm3Ojw6v9lnBRc8Et8RQlpt+FsS2w6AuNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b1PdNQ3yXPinNfQFzDow0XaqnCjMWxCWsXQmRoxblo4nxG9kaV6PPHFd2BsyxjmSpQsJ+JmM+WoPePtpeed16Rr+G8VHlntw1aUn9QP+TYdBMPrgZX7AL5Ml+DBh3xFvnQQxwg87sa2dLT/zzySbxNhyv/Bur9eukIE2gFh2T30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B7vHuuOE; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-36786081ac8so2492663f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721048949; x=1721653749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4Cy762NHODqPEEZKK76RCvkyGJzJYGhxMZVjlQtC8w=;
        b=B7vHuuOEAaBkWUEivD94erhLWY02M6jAc+FW0McgNMOPw4E+KLSU0zKnYfum7kJcfU
         fqmkiWjGlyWIhsdxJCsq3y3kLbd3ktODg6EU+cD7Gsh/+sdIfq0DXCPoPbtC+CCLzS2K
         EFefwnGVykVVGVIU3MFdQru8M64VO4p8QN2g2WNWMpwsmPS9JVN6srgZXtox2rWjU1v4
         NTn9H9ebhiyY2UWwnY3Gb5Mphoh5gO4EijYCjOKHuJo8rT2wqP1yec69ZXWXDdvwEg3y
         zG9YVFQP/e7HuyR5MaAL4Dp/JDOpvocv5AWoiDTF6t2clAmHVd5zE1Za0Xn6zNXaYd9T
         rKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721048949; x=1721653749;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4Cy762NHODqPEEZKK76RCvkyGJzJYGhxMZVjlQtC8w=;
        b=gYAM6NMQc2dyv2W9XhwW46OdEnaeVrNec/tBq46frDfWBpi8dguPqRld+NaKmwKfbB
         8fN4Rvrc39lY5O/MXu6DCG2SyLsuOeWivJjhT3sNMNM1UfUcgEpbSq7SRZGKQFcN8Fuu
         zg8gvZO+VABShyv1Gj4tJnnK4wfIoXvD1OH5O1aw63VAlcSBark8eD5qWa2mI8r1R8A5
         w/F162Jr13lCNGGIcauA1tt/95wkyZBJuNqmzr7ZpE8jrTcq0XPQGxUrCIsSWHUapwLw
         UnL7jqEgR91gki5S4laGQU8jZIFRmw+8IeJOWRJlc61SbkC8ze9O5DIvkSls9h5egQZa
         8gbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6LlpF4LJS/91CD0kcX2Avs8sV8ugW35Nuj/C3y07o5lMjXoZ4g5a4QU16xY7oNCqsqEa5LmsobZB5g6LIadIB+3dxkYvRk6YpAys9
X-Gm-Message-State: AOJu0YxQ1YpTL+bcGKoazFi4PXdWUiXUJrXZBLD9pUfW1l2nZltsrxPY
	ut4OFXKqYbiVT4Sn3Gh3ADL2hfpnUShvcXAujEhVlykziJ44vCoXwwHUmLloQ6k=
X-Google-Smtp-Source: AGHT+IGKr51kKIeIqmt034nRc7HfCYRczHzCwLYmIb7rCOJa9a+MeLW5PmGUvpro7kxdQiOOqlQJyA==
X-Received: by 2002:adf:f348:0:b0:360:7887:31ae with SMTP id ffacd0b85a97d-367ceacb451mr12705003f8f.54.1721048949519;
        Mon, 15 Jul 2024 06:09:09 -0700 (PDT)
Received: from rayyan-pc.broadband ([2a0a:ef40:ee7:2401:197d:e048:a80f:bc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccdffsm6417766f8f.54.2024.07.15.06.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 06:09:09 -0700 (PDT)
From: Rayyan Ansari <rayyan.ansari@linaro.org>
To: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Cc: Rayyan Ansari <rayyan.ansari@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/2] Convert Qualcomm SATA PHY bindings to dtschema
Date: Mon, 15 Jul 2024 14:01:05 +0100
Message-ID: <20240715130854.53501-1-rayyan.ansari@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The following patches:
- Convert the old apq8064 and ipq806x text bindings, to a new unified
  qcom,sata-phy binding in yaml.
- Remove reg-names from the SATA PHY node in apq8064.dtsi to conform to
  the bindings

Thanks,
Rayyan

Rayyan Ansari (2):
  dt-bindings: phy: qcom,sata-phy: convert to dtschema
  ARM: dts: qcom: apq8064: drop reg-names on sata-phy node

 .../bindings/phy/qcom,sata-phy.yaml           | 55 +++++++++++++++++++
 .../bindings/phy/qcom-apq8064-sata-phy.txt    | 24 --------
 .../bindings/phy/qcom-ipq806x-sata-phy.txt    | 23 --------
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi      |  1 -
 4 files changed, 55 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,sata-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-apq8064-sata-phy.txt
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom-ipq806x-sata-phy.txt

-- 
2.45.2


