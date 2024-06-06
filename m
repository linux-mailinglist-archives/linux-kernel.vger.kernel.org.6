Return-Path: <linux-kernel+bounces-204131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5B8FE496
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55CEB27414
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A916195387;
	Thu,  6 Jun 2024 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vfh5Pdtk"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1BE1850BC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670970; cv=none; b=baQwaX+kX7lVliCY8TKpNlVOO1O2QFZFxmDqi413BtUnoyqaBqlsgSUxIzVOAif2O5OjC2iT7P3kQDUAP0FdeLkdpj737PX+5nVG1dtiNaQrLS89Wa/IQeDt74HWlnNNgznUuDDNsbrajww2MNXnLJintu67VjEs19OnPYrW/lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670970; c=relaxed/simple;
	bh=5sqXMbgp87TUZS+KiEhVpCzUEdrJagyCA7cGsBXyg1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jbv0e/24fuHR9CiurmD4qePdOXMgPIOI+zSg7A/GbMVQNrRyxfYR4f106Zme5gKevE6gjG0KT/maG/hg5UCrcxRY7u9grIZ6LZenSTB/OoGBN69uG665ioVLTbjRJ8DA9er+LynK8ns+wPYZbXmbShWimenp5QeZLEydRahDhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vfh5Pdtk; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354f3f6c3b1so707219f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 03:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717670968; x=1718275768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgAcBiI1rApSk5wB4cicRls24AWPm1guQUgQIJo65g4=;
        b=Vfh5Pdtk/uREhDeUlN2QXG/0kDL4Eft+BXbGQl1FvZxRdHPXPIpmuKEWKeNjFTdK6I
         8JuZFSIaHb5S1+RpyxzGScqP+cqwWXzb2lQS9lAaR7GhBUCCWu/cHcYgfo2I1J2Bk292
         Qc5JT0v5BNKA8+An0UYqYMIPI9LytMwE7hiMODvuGVC/TjnlZ++5AyrgknAgHtm5Ofs5
         6Z96kef2daEkb4mS+r6V9kpF5kxFRMxbiamXhqbFSzEHAA/eC5suEh5sRZ5GvGBQA+ns
         3jvQxamxKHrJz0TY6U2Thdn5c/8Ozq2al6IwJLmsnTea9CkwOS9adtPEecVVV6gL1t0Q
         Wp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717670968; x=1718275768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgAcBiI1rApSk5wB4cicRls24AWPm1guQUgQIJo65g4=;
        b=k5bq3hCpBYD/KfWkZFA6VPowuz0+koLYM/GnnRsVA3kYq2RahNiQIe5o/BW9gbYz/s
         8N+FqMME95uK8AI7sS61+pdaCZ/Q/Z/Xf3CQSVYArbatQG5ZH1yHcA1mGctna+4TDwh4
         D81Jl7ozd0NNKuQWgi7fhetN7VqpGxs2ztcl861a0ImLvqKN+hTyWpv10NwS7FRLZkTt
         ObL0tsbbOC6+OlS16T3q+9k1W9J19CeC5a9yJcwfkO+m9GbtsU5u3P7ebynuVdsF26yf
         edTs/WbFxPZRI0sh4CWoM2HzzR3OsiJ74YFSPOOg7s5Yv6Bh0zM8ILu2zuXn/AhgdCjn
         jIOw==
X-Forwarded-Encrypted: i=1; AJvYcCW14uI/5JYsypq5MkURwJNTAJcHzfPfG/iLOCuh/uxJoXVF4Zrce552D7B8aMsDYtmACBE7NE2sjH7sARKKlFn8Zxw5n1li97F4CqnS
X-Gm-Message-State: AOJu0YzB8qXq3BIiaFjYuUJpSdDIyrNKxSFoM8DzRl/0r3TIUm02ckhb
	uairidjIwmmvB0Mt0V+5XlIxwCtbuyWLsjn8bd9Z152LJVXia0xwv+GbubM24PU=
X-Google-Smtp-Source: AGHT+IFaryK3mjyXjlJVsWarwsyBufsRG+cV4YXwa/jhBl7EAaSNLS0WI69IAsI5o0+qgRxH3p06Mg==
X-Received: by 2002:adf:f1cb:0:b0:354:f489:fb8 with SMTP id ffacd0b85a97d-35e8405dda2mr3428133f8f.14.1717670967744;
        Thu, 06 Jun 2024 03:49:27 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e95bcesm1223185f8f.77.2024.06.06.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 03:49:27 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	krzk+dt@kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/4] ASoC: qcom: display port changes
Date: Thu,  6 Jun 2024 11:49:18 +0100
Message-Id: <20240606104922.114229-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=V+TPRmmiWc+mre/0sOEkQxm+yPOkfr5f+zVyqVvdeQQ=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmYZQxJZ1iKUgJogCV+Vj1OVZWTYbfNSsPZeHqj UbTKjDERryJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZmGUMQAKCRB6of1ZxzRV N8LFB/9yID8KvMbyXNOsSi+iTJ0AUSAOp1J0CQrasOSgiS8RxV7/ndoMh2HjiVymFKV89NzNxP3 0tPSoeFHkAX77byYhzBAPOx0MzpDer38eH6ht+fgcNvZB406HnrmuPBhZ2XQ6TSiIYp/s7utpSM VIhMETNIIFFI6SqHJe849vtnPDvMBfqnWVZoMUfcd7JYiahEh2WJBE6C+pABKrvBH1FntSxKvlK S486Pa8FD6vvv+VejeyfFRr7G2vQu8LwCUP4MwuB31uTvjfbFWAwApVlpNgYv4DxMGAnTBfPriV BrSrsAXuBhKePzVIc17Henlt02RrcUOrLRpxn+i5x37CmaTA
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds support for.
	1. parse Display Port module tokens from ASoC topology
	2. add support to DP/HDMI Jack events.
	3. fixes a typo in function name in sm8250

Verified these patches on X13s along with changes to tplg in 
https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/tree/topic/x13s-dp?ref_type=heads
and ucm changes from https://github.com/Srinivas-Kandagatla/alsa-ucm-conf/tree/topic/x13s-dp

x1e80100 is verified by Krzysztof with his changes in tplg 

https://git.codelinaro.org/linaro/qcomlt/audioreach-topology/-/merge_requests/7/commits

Thanks,
Srini

Changes since v2:
 - remove hdmi references.
 - added more DP jacks
 - added some comments in code
 - added x1e80100 patch to this series

Krzysztof Kozlowski (1):
  ASoC: qcom: x1e80100: Add USB DisplayPort plug support

Srinivas Kandagatla (3):
  ASoC: qcom: q6dsp: parse Display port tokens
  ASoC: qcom: common: add Display port Jack function
  ASoC: qcom: sc8280xp: add Display port Jack

 sound/soc/qcom/common.c         | 35 +++++++++++++++++++++++++++++++++
 sound/soc/qcom/common.h         |  3 +++
 sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++
 sound/soc/qcom/sc8280xp.c       | 15 ++++++++++++++
 sound/soc/qcom/x1e80100.c       | 20 +++++++++++++++++++
 5 files changed, 99 insertions(+)

-- 
2.43.0


