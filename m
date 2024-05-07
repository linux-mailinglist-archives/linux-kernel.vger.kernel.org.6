Return-Path: <linux-kernel+bounces-170612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED58BD9B5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 05:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF6B237C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98483FBA2;
	Tue,  7 May 2024 03:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYwa9sLS"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C8C4C94;
	Tue,  7 May 2024 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715052498; cv=none; b=oUHssI82dNwPIfwNn/d+RMBxxTo6ExE4zTgLJtHpBekiE8NcZuDqPX7piJ67YDbouKZHeOMC4i9rD+zT46eYlxUUUaOzdL1svvtq+bJeLtGkHYH1aB8Ml+UN6CPL6klo3TjR6VrUN9V0ZROp9ldjWqyWdiN6cgSVwh4wu4ZsHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715052498; c=relaxed/simple;
	bh=oFI7tm++PMwnpezXZl6+RVdttyuxeXzDX3sJCx+Aak0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oEJa28YVE8+VNnUfd5+q8jJ8/oJ3N3KG6SAMOrFZo/hr3D7lp40WMsnCIU4iODRPZy12fVZqZpBTaPL8jg6HXhCPqUYptvNebmM/E6CYf15MI0JhOw8G7cLC70PfTfpr8e1Kw09lo55AZ74Noezuv0UEfMuBS1M4e0bzYQm94iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYwa9sLS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f457853950so1679565b3a.0;
        Mon, 06 May 2024 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715052496; x=1715657296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yG0hyI/fiqqTDu9hk0CUtBDwmucjumAbk3/rvFBap28=;
        b=KYwa9sLSXcn+NCJnGyeLhjD/tgCat5GQegioFbSBlGBjPXiQ2BoO5sIkd4Y2kThUuy
         MoaZ/MzBs0OwxDWiJ1fRYRo61OpL/f62miUwwiUalY7McLwCYaOx72hh9Hmzom+zdpk2
         A55E01C9B+ike+WEuWu18ujwJKbjR2/vFy9pgXEBlAQzNBcQQm7vqe648cEHn/ElepYJ
         N0htIxc9KOCju+q5sMkkfUYV4D6fQPggzP85t/FHZBXSLMtQyzTOK2B08l3SH2qfpnpY
         j/tfiy1Ud2UY35HpQ7xJ2D9NBQXQM4Hs/vp+2jT9aAN6QAYsaYyYNruao0JwdegkvZ7p
         GP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715052496; x=1715657296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yG0hyI/fiqqTDu9hk0CUtBDwmucjumAbk3/rvFBap28=;
        b=QPZteD9g1gclYg8sc+AYd2+DR7cMph7fJszicZ2RvnT07/HWB/grnGB53m4DsSH7lz
         Wgx4QGeoh+64Df+hoJBkQES+1CW5J/wkARnOHSMf8tftRPForyJ88nq9/AgDPhvF0dTj
         J8r+aIj3L3gp/j09VMY+9snVcVLRsU1fTRH+bYquA8Z7kWE3EYs6KlyzxFPZAbfVIKCF
         vWvc0bBZaBZxj6csUKOllGUVNkspI/MaAhbxKwYBGyN/6zX32KTnvLCSiYCs1jPl6+9z
         AQrd15HDAeJpNwW7dZ1mNw18yJU5vH6kBMBiNRDxkOXjYNRi9ktwhJeQAp/339uQ2ZEF
         l5Ug==
X-Forwarded-Encrypted: i=1; AJvYcCVL/g9CZnNwRLGdioQO8TUiVx5H+tF4jq9/UujnS+FH0Gfl+AhzCc9HD28cYhAbbRC6loCD6jFnDvxc2SZzVBzHoUQI0Oy5hgdW0kLswmlBCdRi8sAGJAndCUDC2z9zbvQQ3DLGGgfrysviSHW4tlZlLHpmI3PLmPLmQ/wp70vQrHH2
X-Gm-Message-State: AOJu0Yy8FMp0q9JyPBKUgxHQHaAtc+9lk74EBg8fYhg3oNZZGfdDion8
	T0dCanFQ3tpxMZqYnx+1pSr/Z+Jzxm0deDGYVZ3n5TI5gi8IyP2r
X-Google-Smtp-Source: AGHT+IHQGrM3apVuTaRp7pOKdv1cKN0aYiJobTHZXaiaDf5r+6av+oBOFd+j2BhjsX3MB0aaP8V7tA==
X-Received: by 2002:a17:902:e891:b0:1e2:58f:7ed4 with SMTP id w17-20020a170902e89100b001e2058f7ed4mr2443528plg.5.1715052495885;
        Mon, 06 May 2024 20:28:15 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902ebd000b001ebd7bdaaffsm8988409plg.288.2024.05.06.20.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 20:28:15 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org
Subject: [PATCH v7 0/2] codingstyle: avoid unused parameters for a function-like macro
Date: Tue,  7 May 2024 15:27:55 +1200
Message-Id: <20240507032757.146386-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v7:
 * collect ack of Joe for checkpatch.pl, thanks!
 * fixed an indentation per Joe

-v6:
 * collect ack of Joe, thanks!
 * refine docs according to Jonathan, thanks!
 * add checkpatch doc according to Joe, thanks!
 v6 link:
 https://lore.kernel.org/lkml/20240506014606.8638-1-21cnbao@gmail.com/

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


