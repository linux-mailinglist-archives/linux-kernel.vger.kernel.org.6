Return-Path: <linux-kernel+bounces-191000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 022D08D0558
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4E91F21111
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07C273469;
	Mon, 27 May 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhb1+Scy"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197B1E880
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 14:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821145; cv=none; b=nPCDGC1gdqXnYJ8+DNpZe5EJuMoi6bM9Vm3AQnPKq9HanVQUORLDn+bvIxlrfIr/tTVnOJlqhM0QBXnkuLIYWsUbAvAxvfUzLnJZAGmTL81DgUEMdsTehB8OFKX9kxfRDYVfnO74/TMaeSPO3UuR87tY2Ulka7/7f+zP/lCvrjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821145; c=relaxed/simple;
	bh=7Gmig81o8VCtO+jw8ZG0v3vKCZkx6IgJP+6S9UFxNjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rwSF4p4J9P3gmJJMsiTt0EOYnR1rU1qWAkcZQc4VsiGR4JtL3MPActEDSf8WTJVKKFZtUPktGi6OSVm3KjMXgLOniojswVqOSGh/bSEXeIFMVF6ZlJvBOgYoXtLj0Vx9wKf7y+POMUNmAvDidyksnDznQXaJRERkC4vjNQvDYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zhb1+Scy; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso115471411fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716821141; x=1717425941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E0zp8EmCNFr7PZtWolAKP7vPxVa4oV0/0CpIkN5A1xM=;
        b=zhb1+ScyJTSS4FBTYI4INJd/fZjQaZdkv+B6306eEuwKDo2q7tj1WsIUCjbGCNckao
         Afm52lzF2jVO0o7mkpxscJXZ+/rff6tRpirJUaYSqlxEgpfYOhZSEKrYQe7pYlmImiKI
         wlcae/b5tqHfwuoYwFBcRv4l5P5lBFUxF+6ojYCS1psjTmHUuGfeEU1MJ/QwfoVT3Nwf
         R+6/7QwHCtQQHWJ5QXPI8MVNQW6fh9UVuJg3SK0uRf/8hkEsiAzIybkdLt+OTB5RVcmr
         LzGYSQO5eHYeFCm4fVwuxAfM+ra+57ybx6D8EfFL2rop3b6QTHQ8bJdVn9eVNN2NJmtO
         97uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716821141; x=1717425941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0zp8EmCNFr7PZtWolAKP7vPxVa4oV0/0CpIkN5A1xM=;
        b=uOH2JlG0QKLcgwVkw6RkWCUPLnTa4n4J5c3H4GGcHjD94caibIra+a4Bn5xMk6ALsb
         M/kY0CytPUl2vwJe2vK9FtXkX21NTA4EikE4m8E6h9tR8KI9uOORqz2P2tp3WTlUVvh+
         ftBumlzsPYFXdr0HHsdOZOnX1uLl0jkCj0Rsw6gYfhRrmWAUgeU0bpTdSaoWMBwc9+UX
         GaNRybvxMAAOlgAY7cph1SG1cgQy/o4DMI0nHgIGl4CGyncHqcC9ngXpHBM+7NDeAT4W
         /T24fuEg4Hib4Lxy1AC4pLyUCXh/Ehhs4BuVQ8t0nvNVPzKwnAkx3OF3KsBuSkf7/+9a
         l4cA==
X-Forwarded-Encrypted: i=1; AJvYcCVb6Eo1xUmEg5aeB2Cnv4BStz0zhmAbKviL6sSsENeqTxh0Q+BaqKYkCZ6oUGknNdkeLFED7G+sA0NSwKhEudWLeL7PtMeQsuQPRWqa
X-Gm-Message-State: AOJu0YypV8awLs4tp18K+TyT8Lb7hyMs/BcU2tqdvkm0W5+9xVMCt9Kf
	xVGVSRLPgYWePd4devdIi7qT7RXG9tGldQWIzoe8dQQdAtSWIm+0IsNzA8FvDBs=
X-Google-Smtp-Source: AGHT+IGFJ8k0xWDQVcil8mB8eiFAQ8o0MJDi9mGfT1OCI0XAbK25IWHMiAlNTsDqUatDQdXfJTqNUA==
X-Received: by 2002:a2e:700c:0:b0:2e9:5380:615c with SMTP id 38308e7fff4ca-2e95b099b5emr56591841fa.12.1716821141510;
        Mon, 27 May 2024 07:45:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bf2866dsm19350491fa.139.2024.05.27.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:45:41 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.10-rc2
Date: Mon, 27 May 2024 16:45:40 +0200
Message-Id: <20240527144540.323019-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a pmdomain fix intended for v6.10-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 8f6a15f095a63a83b096d9b29aaff4f0fbe6f6e6:

  Merge tag 'cocci-for-6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/jlawall/linux (2024-05-20 16:00:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.10-rc1

for you to fetch changes up to e8dc41afca161b988e6d462f4d0803d247e22250:

  pmdomain: imx: gpcv2: Add delay after power up handshake (2024-05-21 12:21:01 +0200)

----------------------------------------------------------------
pmdomain providers:
 - Fix regression in gpcv2 PM domain for i.MX8

----------------------------------------------------------------
Shengjiu Wang (1):
      pmdomain: imx: gpcv2: Add delay after power up handshake

 drivers/pmdomain/imx/gpcv2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

