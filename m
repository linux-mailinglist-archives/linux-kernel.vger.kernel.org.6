Return-Path: <linux-kernel+bounces-233651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625CF91BB13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8432819C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BB115747B;
	Fri, 28 Jun 2024 09:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3bxE86B"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18EA1509AC
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565606; cv=none; b=HSrR8gyP16S83ozIgIHp8wvEHV8eHkiz+Q/XeusrmnhHzTFElJxQ1kVDVtWS8jJMk/QoBCMHaF7pPimTZlCZFHArUjYSv8pEspqZFXlKzVlHN9g7i6ob1v/FzhsQm4Q0ai621XRpXVvujDZA3VaKzU4l4G9AwWDBDQegwGGunHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565606; c=relaxed/simple;
	bh=VY0lA2N3xXkN3FgRjmo8QfmsPAIgTKrRJyOaq3UfEME=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XQMyxImb3+m2micDex0CITB4P6VLTNSzWbcbRWTZBJZzkLVeCW6Patc1F2e4OfjEolRhuUuO7EbCE1dZmIFOlG0/BunCX+OquXSr0Oea3LOQyQNwU+ziJKLi+gZwhru36X33zd1Ocpv0+H0VY8h8TD1VhCZmBO8M75iqozMb6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3bxE86B; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2c8dc2bcb78so280082a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719565604; x=1720170404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMRbTa4mkhpQwNvUErP7FXnZYX3oBnht6jeaJD/L0Tg=;
        b=J3bxE86BQNUO7awa2I/+z/YXt7nOW0ow7PjRTp1m43Y1VDrHBQfSRUxshvtgAf3mHk
         j+sSKZBbjGcU005cIryF0Jucvq8LT6kso+i0W0UqViNxs+C0yyZJk80v6mJjK9kDLRPQ
         8ovzf5G1ISbSpKn/gpZafClaCCthseWoGWD4qpiPF/Z9tRopigcxNeV7QG+stAIA6ZAW
         +5usc9zONQ0SfthmT5Zkv7L5aS0lyDbyFRLPkPIfNigVqbgHrZ+xam5fyYE0owrsyZV3
         iyY72vM6hA2tiky7HjC9AzEYux39OZ+BERTc3CgvYoRNg0zTLvMTQ5oc2ywykLjqqrkj
         JZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565604; x=1720170404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMRbTa4mkhpQwNvUErP7FXnZYX3oBnht6jeaJD/L0Tg=;
        b=CGlvrZmWsR6VKtXd45KQPSjQNaUge0i84HNLiF2tXjB15tCVdl305VO91mkVPO2uYw
         e9LERPl0wxrPmLkIxP6hBgUvYn0ezOLPQnxYlKYVqZi+MiqPJ3PKstTFweZ4pjhNmbzp
         gM0LnPPz1xIhGqm/VlNb5SRk3y+ywU3dkmaBYFGhTFEEby1PmSoKuVDxgxObBsM1M6ST
         YmZnhr8w4SF2PibnO8a2fYm+qX431lXhu2Dp8CWd4fw+8GPmhVFLYlJ9uOEObjSC9bnF
         2S5FJ6GAwZZlmo+HIaSUm+grQgTljzv/pF0VtPnImJb8fiIZAiOD8JbD9DAG9g7znQtv
         4oJw==
X-Forwarded-Encrypted: i=1; AJvYcCVjoXFzCmy9cyPJymTDm5JEC8rwanwW/Mb3IUvfPQ4UGyT2XdwNfJSxjT538DYlXV8zwClxAmuh/jivsS5fQHjlvL9+mygFIB2KhQGz
X-Gm-Message-State: AOJu0YyHBZn+eYqIRrYZY6dzv8Tcoyi0IEXsdilFvv6M1hBWtmXHZkr2
	8uxvObD4YszwSPXr88UH2gcGUS4s7OG06qhfACVN8D/s3hTu7WbQ+x06Og==
X-Google-Smtp-Source: AGHT+IGCwl2lcv0gINuTQm4J8J8ys73nnUpAwQMg4eW90iMo4mIH312Ju/HCw92LA6hR6FSB9a2Msw==
X-Received: by 2002:a17:90b:1904:b0:2c7:a907:b6bd with SMTP id 98e67ed59e1d1-2c86141e883mr13536376a91.49.1719565603970;
        Fri, 28 Jun 2024 02:06:43 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3ea485sm1120663a91.47.2024.06.28.02.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:06:43 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id B62258043C;
	Fri, 28 Jun 2024 17:08:58 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	vigneshr@ti.com
Cc: richard@nod.at,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 0/2] Add support for Macronix serial NAND flash
Date: Fri, 28 Jun 2024 16:54:42 +0800
Message-Id: <20240628085444.132714-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add Device ID 2 for Macronix serial NAND flash.
Add support for serial NAND flash with the postfix
of part number Z4I8.

Cheng Ming Lin (2):
  mtd: spinand: Support serial NAND for reading two bytes ID
  mtd: spinand: macronix: Add support for serial NAND flash

 drivers/mtd/nand/spi/macronix.c | 68 +++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 16 deletions(-)

-- 
2.25.1


