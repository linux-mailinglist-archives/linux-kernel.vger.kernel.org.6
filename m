Return-Path: <linux-kernel+bounces-433819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A86B49E5D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5254C1884634
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FB227B80;
	Thu,  5 Dec 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjAd+k/z"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15749224B04
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420503; cv=none; b=OFKvsQG3d8EuPn0m0pCB2s+ksXfLdm1ueCp9x5PQV9RZJZDdCqYyNOOXNMvapcJEWFS1+yTGleYHwyBugSAic84y7kVVuhBZbFQcgditiVY0T3Npijx6RFFjrHlouCwPJ7PIsYlqz5sivpnyfuLQjUUyRng08FuNS9K2E2PE8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420503; c=relaxed/simple;
	bh=w7e0/IyXpIggJ8VXljhBP/mmkdf4tDpn/Mub91QUKx0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mls7iLglrmL9KwkQFEvqrwoVlRqvb/pfwF0nMT/dZSBRas5lewQkBh/CHFLyjDjvxNt0LdS5WmF97IWFStZ9sA53Sgm+r0q3UGA735tq2+P+sMgPJgNlvLYcQ54KVNQTKEMpAJ1eb1zy7i8cFEraowul93DuOi1+K8w+dvPZw4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjAd+k/z; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385e25c5d75so719192f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733420500; x=1734025300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3MPhJwBD5oTf6iFoKflaMZpBPCePKADttJt9GkyJFE=;
        b=BjAd+k/zGtBX/rCrz61pDYfSHeVcLopqaIgoFkQjmI2hWJmVHb4cVeqzpHLDa9Pkij
         zyvO3Hatsq6pcQJXtFeZuN6JbiKjJ9brAHydK72cmjTHTrF2rNnIDVn5zTw8wl8OVOrD
         GR07sHC9xHryyUe/g1IdEZI5d/liZF/uJkze/q6SV63AWdgDHt0IoCxcI4m+isNos7xa
         I9TKt5ofuKYqEbY7VL3zTeYxVzLlOjdUk7ChmDhURMs6dEG+89tDX08fRF+lju/It9J3
         nQUg7P+ZCrYVj/vjdwmbexGHHnK2xoc0ZZBbg3/FKtTt+yyBg0xJ4sdz7TIe/8V9x97l
         L1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733420500; x=1734025300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3MPhJwBD5oTf6iFoKflaMZpBPCePKADttJt9GkyJFE=;
        b=sZqo410hWckuZxWGmyrDjWHqGY1h7DG039b3IC8HAJvQdKDl0GGVLWaHASX28azQ30
         f8uyjGLySml0TduXP734q1MkgGQdVloPpGzgaJiSfKFjv5a7ymuW2T3XZZ8QH2TZdMAR
         hJddvVK1bDEypqBDY3etgYFyKUMIyysHyLXFkOdKBIfS0qCauHPMkg52R7GV3P/TUFEy
         TeKmRla0E7z+40LCLNjyARZE0DWFmVsZLKfLToFFgPcK7WLEl3mFOjiThqlMxEIJjKT1
         DgkdxlUmHhTTEuQlVa++tqr7HwPrtq+hoRDAeCyFuqVm/z+6M1v+VVrTYkIMM39B+rrF
         1D2A==
X-Gm-Message-State: AOJu0Ywt8InVx1YUN0pTYgDUwjIqxBbpbj7B73ir78W/f5bns+7dnrrx
	tItmtXNMAwe++sR49WbSBDhdNkZsS1/qNTEx6vp06WMIMxwmrRia8M1ryjBfuwo=
X-Gm-Gg: ASbGnctRTpoMa2weMtM05wmQTzTquZlf3tW/uVh9VCl0XnBb/6fUQwcE0jE+GG5uzGz
	82GJrLpLIdiAFO2pHOX4Z7fQyqqarF52754Jf4oRc8siWprToWzNuKDL5j/n09VXQagNeJellHn
	aBVwVZo9u6gxFwX0zaS6lNgv+8SbKl90gL3RA6zNmwBcAm4W1ZsqLUzDdmEUCaGpXW62Lk+Ruug
	p/XuI/L87CfM1hOdK+m0RmiipzMYTliMgVtA0CyNdAtLEY5/aHAfVQA6rPQbLXP1Bk1+PQCphbD
	4wOrTIz98+cFYQhvWEk6AAKWn9kak4rv
X-Google-Smtp-Source: AGHT+IEBZW6n47Yt+s6/TKyzpIN2ITI79WuAEcEJdI/9mAZaVb2ao49SofvZn0pUcMMqVpV+pvnJ3A==
X-Received: by 2002:a5d:5f45:0:b0:385:f607:f18a with SMTP id ffacd0b85a97d-385fd435f13mr9178585f8f.55.1733420500330;
        Thu, 05 Dec 2024 09:41:40 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6961sm30318525e9.12.2024.12.05.09.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:41:39 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: jassisinghbrar@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v3 0/3] mailbox: add samsung exynos driver
Date: Thu,  5 Dec 2024 17:41:34 +0000
Message-ID: <20241205174137.190545-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The samsung exynos mailbox controller has 16 flag bits for hardware
interrupt generation and a shared register for passing mailbox messages.
When the controller is used by the ACPM protocol the shared register is
ignored and the mailbox controller acts as a doorbell. The controller
just raises the interrupt to APM after the ACPM protocol has written
the message to SRAM.

I mark this as v3 because it is a continuation of:
https://lore.kernel.org/linux-arm-kernel/20241017163649.3007062-1-tudor.ambarus@linaro.org/

Changes in v3:
- decouple the mailbox controller driver from the ACPM protocol driver
- address Krzysztof's eview comments 

Thanks,
ta

Tudor Ambarus (3):
  dt-bindings: mailbox: add bindings for samsung,exynos
  mailbox: add samsung exynos driver
  MAINTAINERS: add entry for samsung exynos mailbox driver

 .../bindings/mailbox/samsung,exynos.yaml      |  70 +++++++++
 MAINTAINERS                                   |   9 ++
 drivers/mailbox/Kconfig                       |  11 ++
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/exynos-mailbox.c              | 143 ++++++++++++++++++
 5 files changed, 235 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/samsung,exynos.yaml
 create mode 100644 drivers/mailbox/exynos-mailbox.c

-- 
2.47.0.338.g60cca15819-goog


