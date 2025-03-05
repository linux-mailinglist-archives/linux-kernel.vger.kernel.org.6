Return-Path: <linux-kernel+bounces-547611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9824A50B96
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B001B7A9428
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38E8253F1A;
	Wed,  5 Mar 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoQ6tZn9"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057D23027C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203388; cv=none; b=KDZ2jo8e9bf1BEDXThpFOi9cC3QK7dpMy5g/TpB5k3ARUMZ1XMmbW+H1lnjj5Y2SkSfW5DX1clvTf1Vic1xmE+JSdGWtCAxmuf4UVGbHLFi0p/T0QL6lOfhJ9iTka0wFBkWBGf6bQ2iZdHq/MCoFTsYvyryt/2AZjAxN8Tvgx8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203388; c=relaxed/simple;
	bh=Ks8X7EPJ54VCXSHM7sl3Hrc7gHBCTE9UxNQ0VdzAcDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjWAmRxO5E/TyHAwAYr2NqQkn4LiFnu7KGg02vQkKqGAUoOqbX2ECH0SqInN2v3IbboZGVTKbAi7S0hrWVCljCten3Iw/kHC15g39Q+Gj933P74ts1zY8geRLLlkBPYN1JSz6G0vc8eUQ2dpY7Y0B7iDl3my0i2jmHijgq/g4WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoQ6tZn9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fe82430bb4so1882064a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203386; x=1741808186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BX6Xw+vu38MTqxN013edOzT70ivLZgV/Gxi462fO01Y=;
        b=DoQ6tZn9NTCGbL5WNVD/lwVpJSW4Rjdo7aRzQKqu0EpFQCIqkooFhoo4m8pF7wWYcQ
         rzm/pyNeL/yzUOsjbE5qS9JamFMmLsCIvZtKyJkxh/MsINowD9HMNP+1soUrsW38qgMJ
         YSIeXpkfCxWOZ6NtFq6EIRUqlGF2GEzT4FRVBSfVwEj8OTOqw7K/BBQJo7rCdM0PvSWy
         kZvbn/cLi2kBzlPhpfRKqjhLrDGtw+cOnxPcwamIMQSzlMi9NmFmdTSfdLzU1r1Do65l
         Za/+WwOsoHYdsIEdPYkcHmbR2ZQEkTnLz1SFFmkhnT8lAHd/8XTgPqzTWBLuLsZrb5/Z
         CROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203386; x=1741808186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BX6Xw+vu38MTqxN013edOzT70ivLZgV/Gxi462fO01Y=;
        b=Ir56cXuaZQzGEnbS2bIAu61qzDKVEGM6jzdguFafRe//7KhYt4V0IYuBG+x3uBUCQs
         R5FanDUwoe8DY3iy3DXQmEhuen6K7U7ynAyDPK79pPwjj+zYP361YysU7T+uxipoD60f
         tZ1CqBvgJO4U0bfDjZl7qHjwGivaLe1akXmlClDlTOx8UzWFNefhHqo4QaqSCsM+aMJV
         W6U4NlvG2XEqR3klMJU2qgNHs2ZNcjRg7LbJsK6o3kdnnqGq9AVQhgZkdYP6Qe9bXFtB
         vnvkCDf53ltMboqtS7GS8HyJ/7Ghk0qUwrim0ZIsVgYscehGFH0/bmsixTQ16EILCfB7
         YIVg==
X-Forwarded-Encrypted: i=1; AJvYcCVN63+MkcCPffD1l17yQNkxCBzMc2oOPwuEl21HPVcVqww2Lf5VuxqwJCFB6REkvYgsWePbA4AMlwgzhvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg+T4L5n8I0a03cGqVUBcVrwI5lul/nm69kLRRcrJmgRMwCrbt
	oqla43XYZaNWyk7qyLjf5HSU0AJXIIks0xNuBU+vrC0u32WFo4+b
X-Gm-Gg: ASbGncu4OB7s+mY/LTkpaR3kC8SK53LJiHHJ8VdYkM2iJkvYDw4JkNMkFNjXQqMrZKx
	ZPXdzPxaHsCaMlhoDUf7tVAzDhq5lUKy+UkY00HfMNzxvfyArqdcDIUcUkE4zS6ZMQ+P8tHqK/2
	ONHWsoY4gmnebXdfs0PquoGuiPs7/xvRkiDmsleR5nIQlnfj1iFVlevNseQlhgKilEGZtJOpopU
	U+WU9PW+POf1RpJKtX8M+LDEMdt/Cl2GH/Sj3SmkNKwo0aGXgx0fB2eiZH7RwBdr/nVRqTE0Cwv
	D1UiL96KAQRrNfSHMDfaLk6FzVgLIdkRDO9oTI6hz3q8ktgEX0zsjViROz8H
X-Google-Smtp-Source: AGHT+IEkUCi8wPyvxb82rYx6xJGYrqZ1lV9KvMi9G2GkzNJ99fuVhxFU500SJah2gefci1i/MU3RIw==
X-Received: by 2002:a17:90b:3b8f:b0:2fe:9730:8e42 with SMTP id 98e67ed59e1d1-2ff497a62femr2867938a91.3.1741203385976;
        Wed, 05 Mar 2025 11:36:25 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7a2bbesm1898148a91.37.2025.03.05.11.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:36:25 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH v2 0/4] staging: gpib: some cleanups in lpvo_usb_gpib.c
Date: Wed,  5 Mar 2025 16:32:14 -0300
Message-ID: <20250305193614.39604-1-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series comprises three kernel-doc comments fixes and one commented-out code
cleanup.

v1 -> v2: remove extra blank line in patch 3: 'staging: gpib: fix kernel-doc
section for usb_gpib_line_status() function'

Gaston Gonzalez (4):
  staging: gpib: fix kernel-doc section for write_loop() function
  staging: gpib: fix kernel-doc section for function
    usb_gpib_interface_clear()
  staging: gpib: fix kernel-doc section for usb_gpib_line_status()
    function
  staging: gpib: remove commented-out lines

 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

-- 
2.49.0.rc0


