Return-Path: <linux-kernel+bounces-391531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CAC9B884E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8501282A37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3AD5C603;
	Fri,  1 Nov 2024 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BbF74Irk"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0402837A
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 01:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424178; cv=none; b=CqavebiXU3agKN0QwU35y5tnxu2+02T3R254TgwvEMLzrsOVobLfmrf89yBIHBX+fzPshhiMeT1qe+h4pr0XeaZoxvpB8gLTNrbuhzz5uJkdgboFIScd/BqQA28hAhRzaMhRbGloOb3nQIumGKvGo65sUWpmd9t5HkzI1F5W5YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424178; c=relaxed/simple;
	bh=y3W0QlF0pHUhgxWrrr5HTFUY6Bau3zJlqfQaSdHHzJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SeHy6Gtz0Kh8tNsXOBgpIcKgQrklU2fEAaydeLWm1Up1skylobjqbXrofDt4MXKlVx0S93AQnmWn4vIdFbYjall3kFfThhBbp7/v8ICnrus3qVu3ZSlRr5+wO5XtQRMI+ruAmtE2ZMs0FsTE4I/yHZccaeT80lIfbDxKY/fcDtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BbF74Irk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so16314535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730424169; x=1731028969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rn4kry6m/4mklH5IfU4CmPkq9g/NGwiE8SJ27fMIJ2k=;
        b=BbF74IrkReJAHDw/0zZBwj8V17ANBg4V7puDhrKw7i3LaTQ0zasANVfFYNPvqyY7Dm
         86qmFC3qn6Z0NPKE+wsELDnvz+Cip3HzhT/9XXIYoXJ1cxEOf6Kluq0a+vW/oHCYS9Pj
         j1WwobR664sztxNx2uhKxfczJ1csVKyEx3/afYCxX0PQ1HLuIz7rhuOabwtNcpRMfDD2
         F6zbP5YvQ0pLgoRbMrWrGeACmkm13ENrfi2Uvd9HbWnfPg90a6pqZKSkvH/MOdl3akRW
         JLLXvWM70bU8Lumz9LqmQdLXsIh7YWF6dyAXkAJqd2V0ZmJTA/LjzAdOqnt5E095maJc
         IzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730424169; x=1731028969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rn4kry6m/4mklH5IfU4CmPkq9g/NGwiE8SJ27fMIJ2k=;
        b=rRLt/Fmzdz4IEjdWsL/ZVdEukXNlbjQb+WHJOTplBL3dFuejRl6n4xiHQWPq7cQpr5
         wAA9IjcIFheQIQxacx1UQlPmLJIVyRcJeflmic5uBzaGc+7qBYQPWbPcOWPS2pGRmQR0
         uHibmYk52WKu9lxLZdt0INbMj+PHr7aEdNLc6Zg2fzteyKfnsXgaic8+Ddty3kUYjZgH
         07i0D8GVCItrfEN1QeRN3hlN1YT3CNtVFdslCPbiajwRdCVJbTjguSffMEcQzKUntSJh
         cJhp5pVxmf6Rxj/21ydm0pzrFlB4g22IYsurj8ly0a8mj6xpGYr9Cy9TYcD0kSi1A/r+
         RWtg==
X-Forwarded-Encrypted: i=1; AJvYcCXOmWt7y4vcI7Tke5vWuJMwtps1F+umXedF8+o1gJidxO6tQDBtXfxlP8YOEf8Xhcwn/sjj3NUw6vhxX/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy89JOjAGe0TQaxCHKKIH1k7EqeIxbJRlH3O2lFb06GUcqRUimd
	f/YLo53GBQb/46VhkfyE+nNwMftjf1Vcy2VNggFER9XaUEHDde498h1QRH9zdKU=
X-Google-Smtp-Source: AGHT+IEd3p8ING9n6nUBlO8Ke9VQAg3GlSiKlwo36+DVc7pK/fktIh4uuK1JDCaWsyMf+QwtDc/8UA==
X-Received: by 2002:a05:600c:5121:b0:431:4f29:9539 with SMTP id 5b1f17b1804b1-43283295905mr16252715e9.32.1730424169610;
        Thu, 31 Oct 2024 18:22:49 -0700 (PDT)
Received: from localhost.localdomain ([2.222.231.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad3fsm3501622f8f.95.2024.10.31.18.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 18:22:48 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: konradybcio@kernel.org,
	konrad.dybcio@oss.qualcomm.com,
	andersson@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	conor+dt@kernel.org,
	srinivas.kandagatla@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v2 0/2] Qualcomm sm6115 LPASS clock controller
Date: Fri,  1 Nov 2024 01:22:45 +0000
Message-ID: <20241101012247.216825-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is one of the required dependencies for audio support on sm6115 and
its derivatives SoCs. This was written by Konrad Dybcio, however his linaro
email is already invalid. Konrad suggested sending it as-is and keeping
him in c/c. Some updates may be still required, for instance the
maintainers line in DT bindings file.

This was tested on QRB4210 (Qualcomm RB2 board). The only changes from my
side were fixing compilation errors and small changes in commit messages.

This is second attempt and v2 as suggested.

Changes in v2:
 -- added Reviewed-by tag to first patch;
 -- removed the second example as suggested by Krzysztof in the first patch;
 -- dropped patch "clk: qcom: reset: Increase max reset delay", the change
 already landed.

URL to initial series by Konrad:
https://lore.kernel.org/linux-clk/20230825-topic-6115_lpasscc-v1-0-d4857be298e3@linaro.org/
URL to failed attempt to send it recently:
https://lore.kernel.org/linux-clk/20241017005800.1175419-1-alexey.klimov@linaro.org/

Konrad Dybcio (2):
  dt-bindings: clock: Add Qualcomm SM6115 LPASS clock controller
  clk: qcom: Add SM6115 LPASSCC

 .../bindings/clock/qcom,sm6115-lpasscc.yaml   | 46 ++++++++++
 drivers/clk/qcom/Kconfig                      |  9 ++
 drivers/clk/qcom/Makefile                     |  1 +
 drivers/clk/qcom/lpasscc-sm6115.c             | 85 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sm6115-lpasscc.h   | 15 ++++
 5 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml
 create mode 100644 drivers/clk/qcom/lpasscc-sm6115.c
 create mode 100644 include/dt-bindings/clock/qcom,sm6115-lpasscc.h

-- 
2.45.2


