Return-Path: <linux-kernel+bounces-310984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0534E968395
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A104B1F2029E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FF187329;
	Mon,  2 Sep 2024 09:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tleLBvQA"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F317A5B4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270567; cv=none; b=r2xdiM0yPzQk/aAg2XvJuBxAt37h34nxFqXC77ggV9IgruhDDlr+vQ3tdhNCMthzZMp2mOa3OtOHr9OVGCbCTwH4rw6TP3RS5Mwo3/4WX8R8f7PGSY3n6p6G7dOuVQdLFZFVnC55/wK6lQXPRwLq1ED9iWfVkHXJfjbSckbweaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270567; c=relaxed/simple;
	bh=5pbRVwtopQ6d3wAPmWATKqqvjPzTOivIPDWsPsi2O8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQP7/1ckUo6jPXlQ9Drof3kmwYt5rDbUpBGpkYclvixNv5liYdK8d2gV4QUA3LWSgy5uuQNBwrEpEcMhNw8+efQfObOCYcQ0IW0H0ZZSum3DPC6js3cOCXeF0XngT3Ovd4ggMeoryNvbzy2FY6ToXpHdyLS5hRhkvOkHRpELSwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tleLBvQA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so17090835e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725270564; x=1725875364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZJOnRKxxutEChlIW+5PAtmNmotUPz7eaFOc9n7zpMA=;
        b=tleLBvQAsPSRdsh5JmgS619e+ITiQMFIFL6RTyMMXJxQ+pxI8HPgecO7zIAqvhBvbJ
         xaQW5GoqJKquXKpcYKwqvb8Yeb4+JmTgYj6Fr5fHoD7cZoFa/VLVxV7BqcrU9QjkkZFT
         rCiN3S+AZPf6AzcX41OTjl7UkHY+jZ+UfCLEpyCvJZ+vTWjGfT6jF36uGRn9t8u7wF6o
         9ZCu8vNqforrKnENJeKxggP8bgSkA+sOPbcYVwv7N96aPN6BrBkuzzV6PU1Wz5sB+oAE
         8/hf33TxF+qnvWDAkw8A3LeqHr2D7emNlK0pLTgolt7LFprqmXR8EjNxTrmy4/l9KMxU
         Af1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270564; x=1725875364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oZJOnRKxxutEChlIW+5PAtmNmotUPz7eaFOc9n7zpMA=;
        b=IGECwTAvTZkDVAsbr705OiLr6QzMXdhn6SYRziZVGGGWPk4/3MTcdaaBnAIvrn45Rw
         lpLzPUnwzheV9Ay+ujIk2T/4s9fqbuCz6HYTRyQHHo/OsUQ3max/3KiEn+XiUJuIagFr
         clplSI/cHcNBPgx1K++Hg0pVVsS5j+cTtRkxEcy9S5FR2xMZGLQfjFqQyIJXorozyJ5b
         ir2W+yzI7TIdCgsmoxg1vMouVJPHUokCYU2zW/z2342qniw3jJmmg7+tULJ6DwDspx/y
         YlrOysR1Crbms9kzK5JVidDIz66wddIGC7HZZ6kxd9at8RXWR/e23ZEC5OO4iunAlFdl
         DVYw==
X-Forwarded-Encrypted: i=1; AJvYcCX/ODIP0V1WP57zQR7ApW955C/3bTYd2rZeHMOEJS6KQuZ2s+ZJYMCd+DoVOYkzXaJK+u6QocMhSo9tA7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6n50ocAysmwpIRER1m1Ii6qyjeqaxnbVL3PTUGcVk/loJXJhc
	mq3ldBtNu33ZR5BKJL+4ty2kcvYKm4tRBey1ki6r0DQ9TpznUf6tQ+rqbMVheVk=
X-Google-Smtp-Source: AGHT+IFPE9DrSMLqeufhX66yLGT0OKavBe2zcsQBz4ANdf9tEN6d/UmYFJCTb/y4f/xkAno+0UHlVA==
X-Received: by 2002:a05:600c:1548:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-42bb01b9302mr119554325e9.13.1725270563591;
        Mon, 02 Sep 2024 02:49:23 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b496:9e67:73c9:9f5a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df795asm131691865e9.21.2024.09.02.02.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:49:23 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] dt-bindings: gpio: simplify GPIO hog nodes schema
Date: Mon,  2 Sep 2024 11:49:21 +0200
Message-ID: <172527055993.21602.6768562114748623429.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828-dt-bindings-gpio-hog-v1-3-63b83e47d804@linaro.org>
References: <20240828-dt-bindings-gpio-hog-v1-0-63b83e47d804@linaro.org> <20240828-dt-bindings-gpio-hog-v1-3-63b83e47d804@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 28 Aug 2024 11:35:59 +0200, Krzysztof Kozlowski wrote:
> The core schema in dtschema already strictly defines contents of nodes
> with "gpio-hog" property (with additionalProperties: false), thus the
> only thing device schema should do is: define "type: object" and
> required "gpio-hog".  Make the code a bit simpler by removing redundant
> parts.
> 
> 
> [...]

Applied, thanks!

[3/3] dt-bindings: gpio: simplify GPIO hog nodes schema
      commit: 98db29d1b4b7b1fe9b54d11e66a396fc37a73c57

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

