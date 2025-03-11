Return-Path: <linux-kernel+bounces-555763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEAFA5BC7A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8131897ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1B22D4FE;
	Tue, 11 Mar 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6Q5ovYJ"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58922B590
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686119; cv=none; b=L9gSZmcSXY9+FhV4DT1cDTUy+GAx6sEcLcguycj+eF8VXxyT0Q4dujGXAEiOcOobGuVCa9Kkw9QSEDptOerCMR0OQCndEXI8OM49WMt8+DAX8Qs72J1mCuKFy2SqYEHX15WQNmRuZiBnZW9p0DlKfnd3UzDu3CmY3TVvVVuBceY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686119; c=relaxed/simple;
	bh=03Gv4s873UjI+xmcPzGntYsW1I0NmUQapHmHTtq49bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EcROcIj10o+iHeqiZXfCAD9o+j06+qWldgmHECQscHCvcvmA0bjx/bna+CRzUTiWd+CSvmA33dxD9423IvcKqC4dQVeWWNeG8MNPP4qzPqwZardTOe8SklUeLUAOHTwp50Ajy0dpVoj6cwtrKL0T95r1BwFbwfSal1wCpFoi2yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v6Q5ovYJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so9637295e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741686116; x=1742290916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FLzoATiFKr1B8iCGXJt123FaClKzJD6A9v143qispxo=;
        b=v6Q5ovYJzPunj8VY7wwMWFl8qhj/RaI4OuoDQg9mfPiIHThZgkRU6NB1HMmhsx5E5i
         lFsQRp45fFGyQDvo8zrrpjlsNB9wbTaoeE0kPWefw5CpkZFiAjorwSmx1YEVqT31zjYp
         Z9VyxR14DoYH+dfJJe8lg0yuGVZQKpTQhS7nNB+m9TcxBcDc+KfYymka5QNS0nLI4THl
         +MfzZkczQHCwpK2aqk2J+tMJvVXM81aCCEOtk3rE0YqfjV9lTXuRdARSSf7k7uF4tIiS
         bB/+/7S5QKh/uM16F6gAQYAC3GeMmFWnJ3ZDN+hXYxZ6RTAF51XraOCVhpsL1nMbpxKi
         IS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686116; x=1742290916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLzoATiFKr1B8iCGXJt123FaClKzJD6A9v143qispxo=;
        b=VaEw7roGE/B18Nt4UHz50qq1UGZeivl0NfqwEvQi2HfXlpQcQKBUZ98vGVb0cJ2NE8
         uw33ugWuuBUu6wHt1/lYPE0UwAjQKHrkMiFO2s7cy3H3rkAOlVUTgjClwPCXQxrNvk/+
         75yHyjDkI0ETaAybAT9XGzbb9TTc80vKral/tcalUnbyag/E2RVTMZFEyl0+QI1C4fYr
         INzSWDd8Esyl/FMZkY8pSti5wVqauWeB2KjNm+vfp9Jrdpjrz+ulD/gNCIiOnDnIpEra
         y7dDMS8fz1+W0HbxS6/XlKzduNb7e3jFbeUzXNSDlgAVq0YMyj+FdkkAiA4i/sIAVdEQ
         quWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyxTEi02jW/Yc+JZejp8oW/mLSrZHT++te5tbbQ6bhrQZBdP09t/kPfk2eyc6DBdbfaJSz6NnuK7PVVsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQu1K0q9wFgi+SVGDNvD5LRGPzW7Gm8zhNgcGu6mIf5mvX7zz
	uOpkbEHse3Vzlr5AhSlrX9300GKM7qKvkVd5nhri+Qvskr7FrDwVREa8rJdfihI=
X-Gm-Gg: ASbGnctirNvM1Z6oPjbRywzvafxBvXHznLczp/uD7zQGkvwd6pXE5WdJOaO2t6Q+A4J
	qodub7vsgG40hUvxDAFEz7xcAQoh4LIHzRBKdAaXBXzOqMY9CWIJSoRRdQWDbRd4EewWQWfpROh
	pDtYM+0G0+Cu9LGWBqKfrluu9fvo4L22ldRuGg+lo4RLfyaX17Vl4ZexfZ4ExYmLw5w5WNGX8FY
	5T+kQ/uQi77juKYb5TGzkOCZvlWK15KIYPoVVQxjl7K/UsuPc87CU4sNU8G1JbxIAaSy8DtIEKL
	QTON/t1GG8NSbPAO/0hA79ER/2MgNMWdS196jUN4dBk=
X-Google-Smtp-Source: AGHT+IEdiLqVceheU3laOr68GSrQpdRVp3WLSzOWbWgbN9P+MXJtFbu6q15juGPjGglXL1E+FUFlQQ==
X-Received: by 2002:a05:6000:2c7:b0:38f:451b:653c with SMTP id ffacd0b85a97d-39132d77a3bmr10037297f8f.7.1741686116146;
        Tue, 11 Mar 2025 02:41:56 -0700 (PDT)
Received: from hackbox.lan ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdb9sm17427957f8f.27.2025.03.11.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:41:55 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.15
Date: Tue, 11 Mar 2025 11:41:40 +0200
Message-Id: <20250311094140.722154-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.15

for you to fetch changes up to 06a61b5cb6a8638fa8823cd09b17233b29696fa2:

  clk: imx8mp: inform CCF of maximum frequency of clocks (2025-03-03 19:02:15 +0200)

----------------------------------------------------------------
i.MX clock changes for 6.15

- Add missing AXI clock to the i.MX8MP AUDIOMIX in dt-bindings schema.
- Fix DSP and OCRAM_A parent clocks in i.MX8MP AUDIOMIX clock provider.
- Document vendor specific operating-mode property in i.MX8M clock
  provider dt-bindings schema.
- Apply overdrive/nominal constraints based on DT property in i.MX8MP
  clock provider.

----------------------------------------------------------------
Ahmad Fatoum (2):
      dt-bindings: clock: imx8m: document nominal/overdrive properties
      clk: imx8mp: inform CCF of maximum frequency of clocks

Laurentiu Mihalcea (2):
      dt-bindings: clock: imx8mp: add axi clock
      clk: clk-imx8mp-audiomix: fix dsp/ocram_a clock parents

 .../devicetree/bindings/clock/imx8m-clock.yaml     |   8 ++
 .../devicetree/bindings/clock/imx8mp-audiomix.yaml |  10 +-
 drivers/clk/imx/clk-imx8mp-audiomix.c              |   6 +-
 drivers/clk/imx/clk-imx8mp.c                       | 151 +++++++++++++++++++++
 4 files changed, 168 insertions(+), 7 deletions(-)

