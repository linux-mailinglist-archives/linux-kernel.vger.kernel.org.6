Return-Path: <linux-kernel+bounces-522273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A378A3C829
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9B93B521C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D609215072;
	Wed, 19 Feb 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CUveTSWS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6881E4AB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991543; cv=none; b=rIBgZqoLPs/Ie5w5Ird3JLmxVp1Z9DFV8glOeWwVQpM4o28RH1FnimosiIRI+OFtrlP+4BK6BOGTRV/w4sG305O4tFIHacHhIRJVy6HWdlFHQlThTQ3KsZxHFESHipnY2fCULTsBisDnG2+GTRYmdpI6utua3UBRWXBUfv2MECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991543; c=relaxed/simple;
	bh=oxIDr8H7+ynD5icMp1L0tohpWoDKxhs52fiB5mW6gUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q9gu/MPAruWjyPHNHQA4TZTfALXrXX5OaqM4XDbnyChH3/EdLZauDim+UkB1HsMCQ09w/AIEntWfirH4G9A3zZAYwpEGTAwKWFX66Ol5ZNvsthLrpRI5vF23RKpixMptcHCe4X4QPAfa8Bp7UaIGrpr3Uy+E3UoFu+ITf2ilDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CUveTSWS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so62862f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739991539; x=1740596339; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kygqAvSk2wzyJnjkj1tcZQhsJjKBlVF3GdzFiy8QNlA=;
        b=CUveTSWSQfDKbfE7CFbBg4jaImltj08rsgh1xhkDMJsEfCHk78JDS+kDqPf+/ZN81h
         i8HMQ+jefPyaxUjzx7cwztd0ndCeCBOCcxjg22gQq3bhooPUJRxmgwZYaVcnAcUpQqzi
         TgyznZrV4tiKIiaqt2uELRFbJv/Wz4U4kmOSBx35qiKqt8lDqjRmD+nsOK/e3BCSgPfH
         DD9gOx62gPXCm3nF1z0RQchQyqSJ0v1xvgP5pYUAWewjlGhNLu3V6lrDGNqw85jOg+qg
         ZfBQVS4fK/WSBw21iCEoxYGrxjvrZRAWRgjdTT8xYI1/+BdEDZ3dAE2PmePYcv62bpDY
         IVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991539; x=1740596339;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kygqAvSk2wzyJnjkj1tcZQhsJjKBlVF3GdzFiy8QNlA=;
        b=ekHphoBfh0aZDRg5rhBcZr2Y+I4Mvh1anj98asZjlz8BnqiThu6x1MoTF33lzO1pBM
         QPNnqxHyMrti7dtXmNnCvyZV7wE3+mtNgYoTJ4gNZ2OoU1JgVoNm1aKoZaQx6PyvCGzn
         mS5SPpgQPOaId5wSWzWuoIdIGaQ6C03+fPMNsJcXECtYCrUrB5Ldv+XSB0EqnqtFHw+M
         uZB1kYXHH30pumAjuesRW7iEhQbmDjj9qBcmPIAPb1+sw/NKyHfdqzS4vKyWE0e1JDzw
         XuuIemgOdRscMp+/c6Mc0IATpZavrbF19H/gllL9Cvnu11l6olN8jm5HTJ3Ede1P97TJ
         AOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOMxhUXMRaLG6wjNTE6ExHKgkKgYFt1l6Z/Vx5xYl+jo8hIi3sYy2EIPgwcTdJNTNVuHeLBxTPx+MTGYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJ3qoSw0vGVVu+CM6mZX5sKsoFe8ta8O9yNEZGYod+V5F2yNp
	Y0IQOs2sPCvXN+TP0mnq/xdxGQv8COpPqEog7/ActTqzuKZDjmX6bVoNjPN23Yw=
X-Gm-Gg: ASbGncsfUZelbghz27pZnSXxWSZ86Y+sNEnBKiEM3MJBBz54xw+HREKdYXEZtWfqFkg
	OCty4Bv5yhVFWbUaNwOV+wsQzwP2GlJLzLWU8VSgGReksUgX1sNPr+JFjN8aP5huXD7aC4n97bv
	9bERI1I0otbKhfmWEyhw/heGgPRzKKQIZSnmA2KlD9MY0CNz8OSA1c3iODiyWYKW78ASLOcIm7/
	IIftF9whMDIOOQybaDMpv4QeF8CL7oe5D0i02VCUgw8W+q3FvW884sK0RId5702nQoc0E6+6jv5
	s5YWKdgTFttKPm9LlAIAJx1TAYKho7Q7M9XX30AcO37XcUnF4tpyPMNEmHOXsA8=
X-Google-Smtp-Source: AGHT+IEnbJY/mIDaP2qtCLo05g9UW5rHHcHO+JXueHyKnlKuuX8Vac6lYcqM+/9ztHZ3NKRRxRGTAQ==
X-Received: by 2002:a5d:64e9:0:b0:38f:2c28:687c with SMTP id ffacd0b85a97d-38f5878c9cemr3941389f8f.15.1739991539353;
        Wed, 19 Feb 2025 10:58:59 -0800 (PST)
Received: from [127.0.1.1] (host-79-54-50-21.retail.telecomitalia.it. [79.54.50.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44b2sm18336665f8f.20.2025.02.19.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:58:58 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 19 Feb 2025 19:57:43 +0100
Subject: [PATCH] iio: dac: adi-axi-dac: add io_mode check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-wip-bl-axi-dac-add-enum-check-v1-1-8de9db0b3b1b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKYptmcC/x3MTQqDMBAG0KvIrPuBiVi1Vyku8jPVQU0loVUQ7
 25w+TbvoMRRONGrOCjyX5J8Q4Z6FORGEwaG+GzSpa5LrTpsssLOMLvAGwfjPTj8FriR3YTW2qd
 qdFs3XUX5WCN/ZL//d3+eF/ahDhtvAAAA
X-Change-ID: 20250219-wip-bl-axi-dac-add-enum-check-8bb617285793
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add safe check to the high bound of the enum values,

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 009fb987e1afd04c3dbc59a9742f7982744420c2..892d770aec69c4259de777058801c9ab33c79923 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -728,6 +728,9 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 	int ival, ret;
 
+	if (mode > AD3552R_IO_MODE_QSPI)
+		return -EINVAL;
+
 	guard(mutex)(&st->lock);
 
 	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,

---
base-commit: 4dd0ce442fa57f5274878c89223362344f28224c
change-id: 20250219-wip-bl-axi-dac-add-enum-check-8bb617285793

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>


