Return-Path: <linux-kernel+bounces-258692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4651938BB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D202817C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F2A167DB8;
	Mon, 22 Jul 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dPDLY4QL"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C27A523A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721639227; cv=none; b=WCFPrbKfnhb2PhVqZ4CzwobEXp/yp5Ny9z02pCLVyNt3UgIxZkJQXJ2roDIMoaBQ1JogXmnA/qK/XKXyOUTNLiysEgXs8BGHUoC9efTk6BC7fJlNyWZuvzY+V2z1GeCH/ryB6kg1sN04I5OBlyEXIPags3s9Wb3VnzBq+VmYSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721639227; c=relaxed/simple;
	bh=MlDwDQRKF9twVEG79iWcfbddm9tGGXPNnP1U28eThpY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HJx0a3jNEWqmlg54p3oWgg9rZYv9/kyEPJrq94i9wMsn+iSj5xZeO4rM4gTAaU3z2Jf5SdzJf5atEaWkSfu3TWDF6l28XIbps9QCmkjTHyZGjWI+j88H3Y5kg0QS8Kmv8/ifryzI8YzP9FoLt6SAWRxyGgJG4KW7AUwKXmPjdSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dPDLY4QL; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef2d7d8854so9257891fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721639223; x=1722244023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6KDeZL1mIopzYRyhCPAZSAzBi25x25dsv53MOad9y0=;
        b=dPDLY4QLD5+hC+fvnpHrdsKwQuZs+SaQMBzaHV/fHFbxAQb7vOp/WfkOsVg+/fHoMb
         yD/X5C4coTC/Dh+zAFHAUkV04JgGjAzKYhL0mrLA320LcKdPdbAoWlOSmnxxJ2Vfubps
         BsZOHHwbqcbfW3/aQkL/jT/CsO4xhCw6C8sXUu09gH+sU4ZcEhq3uv+pcZ1nFtGf+BV8
         Qi/gvoEd5uv3qDuIbWT5cFFCGLjy5CYpGjkROwhLt2Thcw3ErQOT19s2mftxJAPsuR+c
         LteVK+z3MguTzwR8Mqi0zQlMhR5mKZy8NbNptoTo8/QX+M9zGChWAd7ooGD5gIm7tSx9
         4Onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721639223; x=1722244023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6KDeZL1mIopzYRyhCPAZSAzBi25x25dsv53MOad9y0=;
        b=vWX5CInGLaJHKZVbIR7+kN/wMNPRGpITNb7hCi7yu0jUqGe1znCYhS4qvfoqFfIMyE
         ESv6Vkb1r2qFlzWDMS3K6fHcwtBAPjzWNPtN8gqZkFP62RU+Jfue6poBc6gRNMhKa8R3
         6bnZm7vmafIJt3dB1E2X6eowLCgR4XVzMxLeRibMJHtPVL7AuUq0m1CHukedkPNFEEeA
         dy043xW3OXkFchGRikAh7m+zMrWwoVdPT06Lp5+7x8Aw0qGfqqoa0/yn4Yy7jcQG6C2e
         QAjobxAaMMEMaN+0YtXR6GBqNLVym/7+olaeeUFuhvBY6l8Wqr8Qtx5l25R/fVtwNl8g
         AJVg==
X-Forwarded-Encrypted: i=1; AJvYcCU40aXo9QMGtbQtpWJEnGwG/6cPttPr4MO364YgIHxpScaxBRjWQPe6Z4MGiZa9YrmStOwMXOUIq3TxJPNelv4jZo2ciyizmCcKeXqQ
X-Gm-Message-State: AOJu0YwDGnUnAejkonhdUZHpqSA58UgiDhzUI4eCXhun9JlUPLuCrT7x
	ANEkG2AgISRUj61ri4Bp8rC4CNook88pzdfw4q6Phnz7fcY8PO7GUjEJZt3kgzs=
X-Google-Smtp-Source: AGHT+IHFXv/AlJ5AFRio6/mnRlwfA1+SuMUPkn58Vp4I8PzI9zyHIY0SW3KIC6yxvKFubCQIIg2inQ==
X-Received: by 2002:a05:651c:503:b0:2ef:2dfe:f058 with SMTP id 38308e7fff4ca-2ef2dfef4ccmr23347061fa.42.1721639223527;
        Mon, 22 Jul 2024 02:07:03 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7753abeasm7534290a91.48.2024.07.22.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 02:07:03 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] module: Split modules_install compression and in-kernel decompression
Date: Mon, 22 Jul 2024 11:06:20 +0200
Message-Id: <20240722090622.16524-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow enabling the in-kernel module decompression support separately,
without requiring to enable also the automatic compression during
'make modules_install'.

Petr Pavlu (2):
  module: Split modules_install compression and in-kernel decompression
  module: Clean up the description of MODULE_SIG_<type>

 kernel/module/Kconfig    | 77 ++++++++++++++++++++--------------------
 scripts/Makefile.modinst |  2 ++
 2 files changed, 41 insertions(+), 38 deletions(-)


base-commit: 933069701c1b507825b514317d4edd5d3fd9d417
-- 
2.35.3


