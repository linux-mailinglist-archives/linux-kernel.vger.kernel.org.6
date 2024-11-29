Return-Path: <linux-kernel+bounces-425738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 953119DEA05
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2437CB21522
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238CA14A0A3;
	Fri, 29 Nov 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqs6u0Rl"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C0913D619;
	Fri, 29 Nov 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732895938; cv=none; b=oyfdwHAkGdB0WBCft5oQk8RWFkWG5cn5kMn0U8AsvnIxx2JaFa6wHWhks/01ZxIW+PdBnd5D4o1T7PXwTAJ6BFO/KS+YP+CRAf74YAW3KQDrr4KvJC6dJcf/c+z5GKzkRKbbbJl1lO65fYdSc1gMJmshPRnHr01JnegP20H1Abo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732895938; c=relaxed/simple;
	bh=eJLi5IMpo5U7lUvO/Da+p7cHmcqlbrFLB0WgwCWrp9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suxxpt/NpmNzunsm954dRrHKe7SYVmRZoD85Mc8buAYgNA1szItt+d1xjbGOAg/WeYuLkd+7KkC6ZnWW6F0HYpXgTeF7ls1cfaehd/dMsXHIN+IKeULm44yUlGAk3llf9CemPpQzvWj3tlWwHlJVasZ+nHwM0GKwptbuhm7Uq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kqs6u0Rl; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5ee354637b4so1017199eaf.3;
        Fri, 29 Nov 2024 07:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732895934; x=1733500734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k2FOVB0GXQliDRP03CPsNHCQPmZy6uuoVei6lVPlppA=;
        b=Kqs6u0Rl+ZDTMTY7RSa0p/xU3L7NjcHQklzBk2BB1L7yRR8tJpSCajYRTRME4EWmIV
         RUX1G9J4FWfsjch/zYZevJa8wa9es9GLry8ZDMGPJmcxfwKX4W2MpFZpNa00iRIq9s3o
         5hHwDsiOaQhzvyenyTPrb1K1grk9zft5q6j9hMfoJvCw8iTYdt0ILua1XiubLVD3dpOp
         PwrgSXhwclFlaPZwjHXq/CYwxBBZ/pqkNEspnCi9Q2yyM2YnpAlDI3BM0vliRgqeuWkz
         LkxYOslrv8yeeExYyBFRMUgD4ZR7U9hbaDO8CEN9xKrCTWil2+HsbBq1fFW8fIPFmB8e
         vEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732895934; x=1733500734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2FOVB0GXQliDRP03CPsNHCQPmZy6uuoVei6lVPlppA=;
        b=fRlXVte5A3m5histodOXlL2Cdwk+PJfwN2VBnYc/BNZyFYxguMdzCAjnGwyt+TRqsi
         ozZPplp3s+MzMWlp2mAcg4flzhLYPN9rtyf8dCuZa5/j4uwodlcCaJuT163XWIOi03Xw
         Y2Bi+WWp7EGOCkiBuIW/AkVRCSF5Pr1x/81mymHwyYXcW8lr1FdHxJcJUCI14ZGcKwHY
         JRph9EHcoIUuy4FVQDX8C6TDInbFtKVGD+34yD0tTBfj4Olq09+TqxqpqBmzLzJ2HvSA
         h7nAglc2Kpi3UipsG0f/RgeQm+mgsuCfMzl/Y0OqKFp073uI9+jRgwj54tZsjObsNE6U
         l6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVYGV6mLJ/UFUwV7nMo2HeMZ5bCheOJUnZNIaO8519cvXBTPRf95GCqIfSxd6qZEwpZlK/P8YJ5hy355X8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimHHwrg6zRfPnP/djGNumZtlhplVxL5xF3WhSC+Kx5t5Y1/pS
	TNP7u3kXzGAUlEL3FKQJ0OceZALTwAmJH3sa6LGTJaRc3o1b1nBM
X-Gm-Gg: ASbGncuyBB9IkR6x2c5QUPAlhCdkEmbQ60121fY9JeXWxOftQ1I7oA8+3BcBXpyvft9
	GzpIaw3e94b5kiwsn+acpNj/06QlvEsapXPYxRWJLW+506itmqepg+JpIb5MqsnLznPfIIWGOGP
	wctTZTqfPZfoLfY2d7Xa5iX/zG3cNjcsvcc6mt6fwxbmcckqfbT87wBqlgiTi2pPOMt74Fkl5oC
	i1bQfLGw52di2MtFTV46/zeu2KtJ7q0NclWf0R1ecmacKkfggeTkTcOkT1KQtcfRmb6/OExfCMp
X-Google-Smtp-Source: AGHT+IGFtSiysmkAz+a219j5aJ972x70HC5bAdi71YSrNG788uDWAPWOmy7g16QIrwKEQO76gKAyaA==
X-Received: by 2002:a05:6830:6d89:b0:718:194d:8ab with SMTP id 46e09a7af769-71d65d051f3mr11456196a34.27.1732895934094;
        Fri, 29 Nov 2024 07:58:54 -0800 (PST)
Received: from pipaware.tx.rr.com ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d725f2251sm794385a34.68.2024.11.29.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 07:58:53 -0800 (PST)
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: corbet@lwn.net,
	avadhut.naik@amd.com,
	bilbao@vt.edu
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] docs/sp_SP: Translate development process into Spanish
Date: Fri, 29 Nov 2024 09:58:40 -0600
Message-ID: <20241129155851.1023884-1-carlos.bilbao.osdev@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Avadhut Naik <avadhut.naik@amd.com>

This patchset translates the remaining documents of development-process
into Spanish.

The first patch translates process/3.Early-stage into Spanish.

The second patch translates process/4.Coding into Spanish.

The third patch translates process/5.Posting into Spanish.

The fourth patch translates process/6.Followthrough into Spanish.

The fifth patch translates process/7.AdvancedTopics into Spanish.

The sixth patch translates process/8.Conclusion into Spanish.

The seventh patch moves development-process to the top of the index for
translated docs to match the layout in the main Documentation index.

Avadhut Naik (3):
  docs/sp_SP: Add translation of process/5.Posting.rst
  docs/sp_SP: Add translation of process/7.AdvancedTopics.rst
  docs/sp_SP: Add translation of process/8.Conclusion.rst

Carlos Bilbao (4):
  docs/sp_SP: Add translation of process/3.Early-stage.rst
  docs/sp_SP: Add translation of process/4.Coding.rst
  docs/sp_SP: Add translation of process/6.Followthrough.rst
  docs/sp_SP: Move development-process to top of index

 .../sp_SP/process/3.Early-stage.rst           | 234 ++++++++-
 .../translations/sp_SP/process/4.Coding.rst   | 463 +++++++++++++++++-
 .../translations/sp_SP/process/5.Posting.rst  | 388 ++++++++++++++-
 .../sp_SP/process/6.Followthrough.rst         | 223 ++++++++-
 .../sp_SP/process/7.AdvancedTopics.rst        | 207 +++++++-
 .../sp_SP/process/8.Conclusion.rst            |  75 ++-
 .../sp_SP/process/development-process.rst     |  21 +-
 .../translations/sp_SP/process/index.rst      |   2 +-
 8 files changed, 1590 insertions(+), 23 deletions(-)


base-commit: ed9a4ad6e5bd3a443e81446476718abebee47e82
-- 
2.43.0


