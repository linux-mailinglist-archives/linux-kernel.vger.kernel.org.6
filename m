Return-Path: <linux-kernel+bounces-278759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBB594B464
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 03:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAAC1C21776
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 01:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876F4440C;
	Thu,  8 Aug 2024 01:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCxUfXc2"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D904BA2D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723079115; cv=none; b=kVB/mKGGRW7+GYL5f65LSpIbekXk99wGcYAv35vclEe9UbEiGFUM8asH7zL9bPX4E2D+kplpycNp2UCIZi0SpQUY6MHf5JjGokqqg5tE2kfXMLL4eWeS1JXt56pcvkLWnqQlsY16X6bl8KFMVzcfb7F89VL9/7puSS0FKL6e1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723079115; c=relaxed/simple;
	bh=sQnO83QTUaxNhTlQAOCumY+VBUV0Knu/tdzdrShQmh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxvI906xLNBx0FyfaoRlFvaHIvweD/tzBxN6Yh6YKnttcdEK8rt9QW5FiUa4wElvHKVo1//L7MYFvmgRXPY8jhCWfycnejqU2H/jrv1hUdTqlvnGh0/PzFThk60Kh52rIYxufii7Xv1U2QovKqor2SkSbUwOy/Xq45+dfhD2yyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCxUfXc2; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so387279a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723079114; x=1723683914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W7idl2PPuazA+0y4Dl4vUOdnEHCofalPcpzFXjUMbIE=;
        b=jCxUfXc2QO0jEh7DqrxT1Pi+S5Ol8n0ZaWwuS2rb6Txq3020yiUAY1iSrgXYkm/GZS
         HTA6kBiCus1YPLMcSOM6ldH+0yfH+oVOQshfXqsc3rjLm3y9w7uLQg3G7MMf+oAiu9Os
         bx6UZZwXRxYiP2pnjduhQ3lXCrGux44WCbEpEptEMiFOuAG9Ya3TjTWA9C76TsqP9BBm
         oJrGTUib5A8rgRdzI9aEPoVoYs6mT9qk1NhIkGrsggjH3N87hzsfMkZQQSHuYVIg3RPV
         0ZsWkOXi6/Bl1yhUaX/l9/9vLrONz4duYYhO+BxvA4WB7EPBI8ABPhCW01XrWTGlH5Ln
         k/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723079114; x=1723683914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7idl2PPuazA+0y4Dl4vUOdnEHCofalPcpzFXjUMbIE=;
        b=b3HtKq/M9+VGqY00ZBhHrLPa+d4K+32e2MzlOc830kFo1EkvBUfEFpyEbqLy7ZaS9+
         nrC2wHjQvIAPUCqlAkOorVjfYWhk4yinheq09k1cy4XacGzkEKLQ+CtNd4pRs3pnJl2/
         CCQbbSoLw+xjbYZQH/tQgZP+aeQbaOY2J939ey5nAe+RnMYZ6jwKNvo+8R0yicH/Gvlk
         aAdtKE5PFP1PjR6hRRU7MYkdBWNbrAVbLG3LapNWDsD0AdRwybEyQ90cF3lc1Z7+UNdB
         OlKGEoXDDhNZ4Z2j8DGKlMOClQ5rSzB8K3blRzxLywE0ph+PPH+HF4ogJJaXo1wKU6p8
         UXkA==
X-Forwarded-Encrypted: i=1; AJvYcCXk+9wQ6m7zC/oWu20EC1XLgk42O/RVQh+yFeDBpByDaJC3+LKRvE8opMM9lAhN1sO6amFj3FZNR8DugOpOayoap9Arw53pbecyxope
X-Gm-Message-State: AOJu0Yx8ee0h7R5Bh0SzKGwxU4POKQZJhVB6NKo81i9CcjYtAz/iRvuy
	DUozqTmcSRHxNEIt7acYcZSwgojab8vZS+Vatp5/wnVLfsJkWDl0
X-Google-Smtp-Source: AGHT+IFjna2nEKbX3ibdhC4UcDbKiyJ05BBFYZxuZuyFYjcOihkGk7YiwG1Rb6CwBeMPV3wRKUDaYQ==
X-Received: by 2002:a17:90a:4884:b0:2cd:3445:f87b with SMTP id 98e67ed59e1d1-2d1c347b36dmr380271a91.29.1723079113766;
        Wed, 07 Aug 2024 18:05:13 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b3a9cc5asm2234639a91.10.2024.08.07.18.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 18:05:13 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: chrisl@kernel.org,
	david@redhat.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	ryan.roberts@arm.com,
	ioworker0@gmail.com,
	baolin.wang@linux.alibaba.com,
	ziy@nvidia.com,
	hanchuanhua@oppo.com,
	Barry Song <v-songbaohua@oppo.com>
Subject: [PATCH RFC 0/2] mm: collect the number of anon mTHP
Date: Thu,  8 Aug 2024 13:04:55 +1200
Message-Id: <20240808010457.228753-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Knowing the number of anon mTHPs in the system is crucial for performance
analysis. It helps in understanding the ratio and distribution of
mTHPs versus small folios throughout the system.

Additionally, partial unmapping by userspace can lead to significant waste
of mTHPs over time and increase memory reclamation pressure. We need this
information for comprehensive system tuning.

Barry Song (2):
  mm: collect the number of anon large folios
  mm: collect the number of anon large folios partially unmapped

 Documentation/admin-guide/mm/transhuge.rst | 10 ++++++++++
 include/linux/huge_mm.h                    | 16 ++++++++++++++--
 mm/huge_memory.c                           |  8 ++++++++
 mm/rmap.c                                  |  3 +++
 4 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.34.1


