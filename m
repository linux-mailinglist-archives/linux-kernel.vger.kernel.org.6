Return-Path: <linux-kernel+bounces-355557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 903D4995408
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 369B1B275B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4410F1E0DBA;
	Tue,  8 Oct 2024 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OVYWUZxQ"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830541E498
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403667; cv=none; b=cFVIT2IiGJjF6By5Qq35KtOKEKY/btgvkRFyg3ojnTmMQwdSXJsMo42eYJtIVNNlSSXWouh9JfohtjmCog4dVdWN9z/TXwznmvo1LkXMzSxSQk02Qx7sqwpZ517i4LTsF0fXkAb9XPNblsSXPw74eTdMy++tV1dlQOqMYKOOp4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403667; c=relaxed/simple;
	bh=HsTOSIK/odOyYphBR7X1b8LMZGDxnmRN7+lB2onYqL8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jfnbs182EeFLcYUXhP2c6hn4ncSgSJGSwZUgxVCcuNQXIiAgl46jT9D7tkgxIMjdoLhBarjWlhKyf5ZnZsBEoyEXs1KebVd7WBARBuHCpxLRuj/ftACk39ggKN5UbHzKGB0L12Ag5e5k7d+n31IDnzhbuy495HB2rQM2Ml0RjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OVYWUZxQ; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53993c115cfso7454449e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728403663; x=1729008463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fVGwQKIR7NIn0aG677PEyJuXc/Br5JQMXmCP2obFSoA=;
        b=OVYWUZxQOy511w2dTxHT+/pzORJm/VdK0OMLcKobI5LgCsqZHnmUWLeVBnCOKUxASJ
         ClEmhcfVIE/49ZzHLRKqeZK/dsfPxougcPJ6rAeBrH17soLyXcWXLAOE/Ao+E2pOMuCa
         nPylbY5xAIPdx4obTYbRpY9rQ3K2YHauoz2fGcCwEtdCLVO8V/PTSn1KisnRZlispX+5
         ZTQ/4oMfFrHSHuFzF3ze689yAodhINadKIJWrrp4It4qrOGpkmTfun8HSHKDSw15zvap
         nNqurFpT+eKh8HCpYNAeL5f/D/HYZN+DkHppdPqESpp3dyvJeeyMj06aj7jTfLbeRway
         0A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728403663; x=1729008463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVGwQKIR7NIn0aG677PEyJuXc/Br5JQMXmCP2obFSoA=;
        b=AkCZHxhCCGB1Q4zPO+lIOEjJ5K8FHQmiGdLNJp2w6084TU6EwjMQQ9dX+UgE6PHWoJ
         ZTtIz6OD0BfBVkGlSoHchYplSKMuMw5N0FqLJ+6C7k8VLJUv0hbrqPpDvjZqrh+FyKP7
         82sOE3nc5nErzUlKvMRKvr3CF2fu9Ec/s65+95JlPSmGNeeXAIJE4XbURdVPR4c4hzll
         bVvTFX5TDtSDFc0sL3XYjmSj45nXXrZSnUqTwd1ISkXlFsJlslduG3+r4ilTG4fIa5D7
         n/Y2/zWJeTF0uNjFXblWkETu4+vnFz/g9gmnidv1UOjSZnQNO1Xa4My7AaqcfwyNvMvL
         VyXg==
X-Gm-Message-State: AOJu0YymWbIAqJpVTgTSgjbOhIgtLzG6GMDSgjeJ0JWs1PY3+rXnI9Xj
	sOzpW+kMKVkcL4as/LAExypbQTG0QFhfBqo4jJaL5r6gtXNrYCmRFSOqMlNjo5o=
X-Google-Smtp-Source: AGHT+IEKHiWOG9TYpuxlTyAsU1vZ/7ludIsmOcxtcWDNemjOM0oCDhSLKrsoTDfY9L7B4O9XIGLUJQ==
X-Received: by 2002:a05:6512:3049:b0:539:9867:eec6 with SMTP id 2adb3069b0e04-539ab9ec4admr8874440e87.54.1728403662468;
        Tue, 08 Oct 2024 09:07:42 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:41f2:4244:ce34:c273])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f86a20537sm131509375e9.15.2024.10.08.09.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 09:07:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] regulator: init_data handling update
Date: Tue, 08 Oct 2024 18:07:00 +0200
Message-Id: <20241008-regulator-ignored-data-v2-0-d1251e0ee507@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKRYBWcC/4WNQQ6CMBBFr0Jm7Zi2gqAr72FYTGGASZCaKRIJ4
 e5WL+Dy/eS9v0FkFY5wzTZQXiRKmBK4QwbNQFPPKG1icMbl5uIMKvevkeagKP0UlFtsaSYsKy6
 pKopzfmJI8lO5k/cvfK8TDxKTs/5+Fvtd/yYXixZLppx8x9YbunlaR/HKxyY8oN73/QMynXHqv
 wAAAA==
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=HsTOSIK/odOyYphBR7X1b8LMZGDxnmRN7+lB2onYqL8=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBnBVjK0Smi4Ei4Kxn7rnqHWwUR2MGoo5nr9ZMzQ
 hrFYFfAI/KJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZwVYygAKCRDm/A8cN/La
 hV9SD/4yZ7kT80FtWO72WIgYpWVvRiUOKA0PErpCEG5KGb0Rhb8jp31f+pKER8+VSRbqtUfedJv
 HedBnCJrwWmv3eEawwZ2gbbz/FIycznnfQ0j4iIqRtSiPtYTqLZU+Ipxid39UU5F0nMphjl0I8M
 mSjDX1eh6b220EqZV2Vg2VMB0eVT/dWeyf/XWNhw63vQkaoOoSvCs9viot+tMP58hqfNW1tKlhr
 SVXNixAB9+qEqCHCs8GveJAo5v5E7zHmovr0H1UD3FbNdgPah08AlHUfLCfbAHUO7qUm9rZgcLL
 JaIhxsjzBqdwdbr1ENwyUtNxgUZS4tpapRPoACPU6EktTwghOaqMEwN3soJhnkaytDNecOOENEV
 Kp0BOLU4vkXwv8DOeSM6JZ7Gt8NtE40Fvms09stedvg6Nd63Qg29hEWBYHLE8g39Z3PYM24oqpq
 8GA624jK2boM/df2IBRvl/FQ00R5MJPTx6qA/E+Wg972AG4wFwj/cudY9cPK9VqE9wJOvGebL7v
 FFWGwLJUwZREFvTawGVudq27VlNE4Qzj7ikifly/D9OXFtD6/B000VLF6ruCatP69eKM5eqZmHv
 1SJUvYC4qtzweTpRAgOYQN/KXaVeVaw6+Go2W/Lo9zFEqg4ZZe6huyyyD6lXmaGtpnbewzx7Hq1
 HR2H9Kr3owBmRVQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset groups the regulator patches around the init_data topic
discussed on pmbus write protect patchset [1]

[1]: https://lore.kernel.org/r/20240920-pmbus-wp-v1-0-d679ef31c483@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Add warning if both init_data and of_match are set.
- Add init_data patches discussed on pmbus patchset
- Link to v1: https://lore.kernel.org/r/20240920-regulator-ignored-data-v1-1-7ea4abfe1b0a@baylibre.com

---
Jerome Brunet (3):
      regulator: core: do not silently ignore provided init_data
      regulator: core: add callback to perform runtime init
      regulator: core: remove machine init callback from config

 drivers/regulator/core.c          | 70 ++++++++++++++++++++++-----------------
 include/linux/regulator/driver.h  |  2 ++
 include/linux/regulator/machine.h |  3 +-
 3 files changed, 43 insertions(+), 32 deletions(-)
---
base-commit: 206f8bf25befe4b591a47868937ef888d916d8ba
change-id: 20240920-regulator-ignored-data-78e7a855643e

Best regards,
-- 
Jerome


