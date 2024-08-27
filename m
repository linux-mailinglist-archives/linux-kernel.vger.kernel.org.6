Return-Path: <linux-kernel+bounces-303027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5C96065C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B388FB225BF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED819D8BE;
	Tue, 27 Aug 2024 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YqNNa0GW"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2371946CC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752560; cv=none; b=D1AA8mtJnRbBVsqMbjQka1L1cx3R4qqAVQvz073rLdxSMgxv2+J86N7lTsEg1vo2XYeKk3cEdPlwJXyjHJsYEhsBxGmGHgUm29U3/ivoYfjfiStsbykX+wGmrSg1YbL3j+ok5/G2cJagZZxli9C3TXsCIdNzD7oOUu17JsxDWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752560; c=relaxed/simple;
	bh=MjpQniktbmYtRpCcY6D3oyiCiHTmkm4NYiFQkRISeBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CZyuXaqtVutMQOOVx19Pi1b2h0oCu8NCs1yI24LkQOqUOzAy+bgKkW+815W/f8eTQKm1XIcEJLP9ziGlxDUqtM5eiTzDQniR8QQQx6fr6myx3rN4D4xS5zmtV37GpncSPcdJfMWj+SK6rgJB8Dlng77M1Z9vp0+daXZQDkMjZw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YqNNa0GW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71430e7eaf8so4166488b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724752558; x=1725357358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWyWMS4bQMMjiZgqIsOGZj62aUV29JVjiV75aLUP6TU=;
        b=YqNNa0GWDOVmZZyCsoOTYZ+RE+NEq824K0U36TosTXwn1VbKQSOmLstwVNwlxryxOX
         FMD5rhnPfWrpBFINgimZbB7dU59RL5pMhLBa5MRLobocUK2nZdNmHRW8QgQ2lJU0QxbZ
         7A+a8nboWDIG4lwSC0+piosHWLLnYSTU+4Jxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752558; x=1725357358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWyWMS4bQMMjiZgqIsOGZj62aUV29JVjiV75aLUP6TU=;
        b=EKgpZMAcqjIPSO3edATd5/hmXTJI5R1U4VgCOVIRBWoIg7gMoUdWmc4jl8MY8lc/TH
         sV/vW/Su2U8KFrYS7FyU6IPVGybqNc2EpLc55fG+JBBAxDFBN5mISgC6+1gwnmEy7kyn
         w1c3i+As38Lg3rXhH+15bfx2tCnQ2Y8A+vFL7KwvKU08ut36zk2xMKImw/vsj3VxanOB
         HanxXyfVHwPMi7ZH0GteobqveTx+3yh+VQYFVhMS2J99ufQTCYhgqyxvSKZmAz/I0GcT
         NIvMQ0T7TU79uHnBsr+67dCc+5ajvTO0v5wu+ANpbr++wfTe74pQbAx7/AWa1zO8XTh0
         9utA==
X-Forwarded-Encrypted: i=1; AJvYcCUo3oBt7lWcRRtrP7AMigRK+PvnIG6DqQucPs3aRpzzSmvQsvy2lg8P2g7eMtmTZR20hUFfLnQ6IgAmxas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQ0o621BDEO/g67v6Ms2qJcvoCuw67wtxxsVNL/igtKpYQbpL
	MAJ786UadFEBp2NeDuiessovmI0yZdUzTOALozhQ+SIuYJWFhCizYYlmnpIywQ==
X-Google-Smtp-Source: AGHT+IFBa9yFqwsm5uIj/y9e11VaShl5P9Ev1jbWDxZFp5m1LYz5F7uzySdXCkaqXIfI+yemICeHWA==
X-Received: by 2002:a05:6a21:8cc5:b0:1ca:cd6d:3a26 with SMTP id adf61e73a8af0-1cc89dbad3dmr12347890637.27.1724752557986;
        Tue, 27 Aug 2024 02:55:57 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:3102:657e:87f4:c646])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560c2basm80006775ad.222.2024.08.27.02.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 02:55:57 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/8] regulator: kerneldoc section fixes
Date: Tue, 27 Aug 2024 17:55:40 +0800
Message-ID: <20240827095550.675018-1-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here are a bunch of kerneldoc fixes for the regulator core. This sort of
came as a request from Andy to not move code that already had warnings
without fixing said warnings. So here I'm fixing them first.

The bulk of the fixes are in the regulator core and OF code, but I also
fixed up a few bits in common code that were missing "Return" sections.
These are purely kerneldoc fixes and don't touch any actual code. I left
the devres code and helpers alone for now.

Please merge if possible. I will rebase my I2C OF component prober
series [1] on top of them.

Thanks
ChenYu

[1] https://lore.kernel.org/all/20240822092006.3134096-1-wenst@chromium.org/


Chen-Yu Tsai (8):
  regulator: core: Fix short description for
    _regulator_check_status_enabled()
  regulator: core: Fix regulator_is_supported_voltage() kerneldoc return
    value
  regulator: core: Fix incorrectly formatted kerneldoc "Return" sections
  regulator: core: Add missing kerneldoc Return sections
  regulator: of: Fix incorrectly formatted kerneldoc "Return" sections
  regulator: fixed: Fix incorrectly formatted kerneldoc "Return" section
  regulator: fixed-helper: Add missing "Return" kerneldoc section
  regulator: irq_helpers: Add missing "Return" kerneldoc section

 drivers/regulator/core.c         | 175 ++++++++++++++++++++++---------
 drivers/regulator/fixed-helper.c |   2 +
 drivers/regulator/fixed.c        |   6 +-
 drivers/regulator/irq_helpers.c  |   4 +
 drivers/regulator/of_regulator.c |  14 +--
 5 files changed, 141 insertions(+), 60 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


