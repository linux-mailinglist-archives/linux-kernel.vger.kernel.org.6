Return-Path: <linux-kernel+bounces-169238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 719FE8BC58B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 03:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248421F21A73
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB983C6A6;
	Mon,  6 May 2024 01:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY25Wczd"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F5381AA;
	Mon,  6 May 2024 01:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714959986; cv=none; b=mzSnMoWhPkLT2rFEGd3XFAO4qT9BdUkC7Gptj0MEhRf7VCUWMZafLUtE6JQLAegwsCm5vA0LAZXiOsdvxJ2HPjBbcfqjx+lja5ZSVajBjpFraxvCY1fP95P2KXgxsaq0qNX34jan5Z+fcv611g/t+6btd/KnJZPdSu7Z2xBPHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714959986; c=relaxed/simple;
	bh=i83YdIPPx0R/zg6nAIJzCB1vAwrQ7TEYddQ6IihpENM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K2x0V6NpDxBOnX+tkLHoWG0cQ8+1njRg1MlebHNeOMTVjOsHzktTVPuF+bqqr9ZAgNsu6ut0M0ZtthFul1vWNSQUV5KTkUCmQyUhb1rO/6T1hwTppvGUHOEZhLeAzNqu9x/a2/lex52yVvxyMnLRLk5XS3hAjZ1NM5ZbSklFCac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jY25Wczd; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23d39e4c0d9so997693fac.0;
        Sun, 05 May 2024 18:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714959984; x=1715564784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1/DXUBEvuqpvW9vgHBUj1lOdo7CYu69Q0rcw2cg02+k=;
        b=jY25WczdF/oAYSkYHCpQku3c5Ka5ydOcD9AajdHBFzKl97RaNMFlCpIy2dDdwI38vV
         XSXBZpkhp/9h2iXV6qg9Doe1m1oumFaeLJoyJnu3RPp48dD2/oadqPih7HIN3wwvftf2
         GqzJmDwRFIaNAipSIW2br8tfIdk32oFMX8EnN+6sjYZim5Uochb6oVDVaQgcp7bjz2H/
         wT128sHsVJRf1d0AFxPHLJ+sXeyUKcq2A/8IN6lhBAOXP+2YrRRI/kCsoGMy9GqaWRfd
         0rWzeaiSMEGGOEcpuxuS6VPxHm7AzvqzgSuXrlrSTQDr6ErHOsBWzuuTE5Ea8/EMGO00
         NKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714959984; x=1715564784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1/DXUBEvuqpvW9vgHBUj1lOdo7CYu69Q0rcw2cg02+k=;
        b=hjkMirOGI57MI7YOD5SlJPcForR5lkagHt5x0Vcm/mzkgdT777gjOnWMTvt3H2F9zF
         +rlJgcE1YGxqb+K+MJx+IY2bHI4EQq9oGhunicHTvOzrqO5Do93HttoneMqbntbTDiNx
         8K8uOv7IJsazDi1OhhLlzNwgMMtYyRIv8c3l3mY/2K07IOyICSTuvlTylY1c01vQHA3k
         S6Xa2VJ45pDfC5Mk3eW1zDSQXYskrY2O0CqoLNy1hIgVB5UqymJSa9MPf8x9Jj6uvym0
         bq9UHnabLvGD8nxln9A4j54MDXHkAQ4f3be42212M16EZMzjxXUupjXJ35zHfTwx7VTT
         wcKw==
X-Forwarded-Encrypted: i=1; AJvYcCWKgR6nYCHECiYcFfyAAcaaLrN/Kzm1lf5BFqqCNaMDGeaIqMcU7Ybd4BKP9ixiSRHRSReA4RmdFkUvtzKjuypUAxEk6COtOu6DBpCLE/lYAZ48aoppFwk0aP2NMIs/YjByhf2dgj7mhIos/u7LTbkZIkvf0z6WpwEphibeKSPm8nFv
X-Gm-Message-State: AOJu0YwTJtDzGobasQwLY2pKUChsIL9sGaEXEjK5IM/KmXkQYywux5KR
	MX7/b7O7AaKrU1WeG5iQSSZGGoNlSLjIoBbeDBndF939RyNSlqkR
X-Google-Smtp-Source: AGHT+IHNV4KkyMkXtQ78NzO1JrnRuS5z5CKcjhAO9LaYdx7XXRsGvLPio/POxvAR/SbsMpqw3RPNZA==
X-Received: by 2002:a05:6870:2486:b0:23d:4997:7692 with SMTP id s6-20020a056870248600b0023d49977692mr11375763oaq.1.1714959984129;
        Sun, 05 May 2024 18:46:24 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id fj30-20020a056a003a1e00b006eac4297ed3sm6608511pfb.20.2024.05.05.18.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:46:23 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	joe@perches.com,
	linux-doc@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org
Subject: [PATCH RESEND v6 0/2] codingstyle: avoid unused parameters for a function-like macro
Date: Mon,  6 May 2024 13:46:04 +1200
Message-Id: <20240506014606.8638-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v6:
 * collect ack of Joe, thanks!
 * refine docs according to Jonathan, thanks!
 * add checkpatch doc according to Joe, thanks!

-v5:
 * Simplify the code for Patch 2 according to Joe's suggestions.
 * add s-o-b of Barry according to Jeff Johnson
 v5 link:
 https://lore.kernel.org/all/20240401012120.6052-1-21cnbao@gmail.com/

-v4:
 * fix Xining's email address, s/ma.xxn@outlook.com/mac.xxn@outlook.com/g
 * fix some false positives of checkpatch.pl
 * downgrade from ERROR to WARN in checkpatch.pl

 Thanks for Joe's comments!

 v4 link: https://lore.kernel.org/all/20240328022136.5789-1-21cnbao@gmail.com/

-v3:
 https://lore.kernel.org/all/20240322084937.66018-1-21cnbao@gmail.com/

A function-like macro could result in build warnings such as
"unused variable." This patchset updates the guidance to
recommend always using a static inline function instead
and also provides checkpatch support for this new rule.

Barry Song (1):
  Documentation: coding-style: ask function-like macros to evaluate
    parameters

Xining Xu (1):
  scripts: checkpatch: check unused parameters for function-like macro

 Documentation/dev-tools/checkpatch.rst | 14 ++++++++++++++
 Documentation/process/coding-style.rst | 23 +++++++++++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 3 files changed, 43 insertions(+)

-- 
2.34.1


