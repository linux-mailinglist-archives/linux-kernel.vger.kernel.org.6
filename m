Return-Path: <linux-kernel+bounces-231216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0889187C6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6431E28B99F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28618FC9F;
	Wed, 26 Jun 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4hoGwXy"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624818FC94
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420312; cv=none; b=P4DC4SvADNqb+d21kBbc6NBOukrgVGyNFLryAxdZeWn0Xvl/HpkuwftkSNAsou+7Vm20kkSuS+moXpmaipPNkkJxQPltap6poI+rhyK0Qe5P910UN2uOIC1B/SU6CNUOeUbXxZKY3XOSrnIq4SPMGCaqS6ETREf04/MSx3SH48Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420312; c=relaxed/simple;
	bh=/XTlK8CNVzTiVxxB1xDjgvENhRkAWNqgof0AvwLMnTA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f/k+89s0oEQhkAYagh3gHolNQmiiuUeiPJMuqy1pdypKUskYdNMEIlO4C6uP8GrFDAGXCnrvc0i0+jGk5hRdTyj2BOiv6FabKgk4ncze3MlvkLBWZKJ609kn8JU/Ma7JyMEg6fpX6/njUYkTj8uF+K0fSvP23Srm/wrZu+eks8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R4hoGwXy; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48f463dbbd2so1698592137.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719420309; x=1720025109; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AkHDlUR7ZAep2s6CTxvJnI8Ne4BYMt6q67j2gv0FYCk=;
        b=R4hoGwXyGB4S5wLzn0sAbeo3I4uUd2z0CegGtQ1hEAEiHTZVJKzWu0iNmkMiJTICNR
         lKRlmQetAi6yPzob6hqgUi2Sw3zmmAilq+Lwg+MQ74BxjjpsG+4S0lwfCr/u16KH9vBX
         UJjvR8PuM2Zj5MHAK8cJjDP7D/cInWQPronpnIITR/1ItxThwR9cXBbzmmf3eoUxiRWR
         S6PFPPSBy4l5Pn4n9ymxkg34g1tSMNv1AtQnmtr3JaX06MrxiTN+9/SVmCB8hWyvkrvP
         TbCiqFaKmbge/3LiXdFv4FlfVBPoMEXQZOFArMp+1EVVX08dqMXmL8OiZ1jUT2KiSs6G
         XXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420309; x=1720025109;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AkHDlUR7ZAep2s6CTxvJnI8Ne4BYMt6q67j2gv0FYCk=;
        b=EKd3/pcBBDMxEPnEhbiIeM7yb8+2Du29POnJhUxIjsUwe6CpMv2/UUZyk3SY57dU7J
         YFebFAQZXV1In6Iwr3aC6LP/3aPc2qGwpaUWNtYn8CHWOHKHov0x34pdOweMsInoCLn+
         EIEGxlyv3kONYkGL3CXgme4hU7orqrHPPYp1FA4y553B1PCKA9F6GqE+7P2NurI1iLmN
         iLfGdCDHpTH0mRNuKWg5R8l6GgU8XSaUyCf+ROc1BFnkl3yYlMjQW+bHsio6fs0q8qe3
         kKsyrij+vKUV1ygHKIdGMnZnZhJvEqvhfHI/izOyhjUHYiYIEIwO9hxzbIk5wIRINkhX
         1ENA==
X-Gm-Message-State: AOJu0Yx92iEUc1ScQxwUB0X3q6l4wjXcbbSQsmdNCjo1HJVQ8h1epFzK
	CAvf6GBoRAHhMmdctRfRMOgNA6lJpLbo3FZDXROsnn3i1fkCj3KmD4RgT0LhcCTTOaDH6JhKvrT
	nwVDB+nCCad7hC2dpvqsmkp2/0dWv+8NBAF+iZkhJte22im8D77sZ7A==
X-Google-Smtp-Source: AGHT+IERDTeo9SUWlwbISbmX+LCiLsiuQ1dzl43YSoAXQ8Dz2vixJVMLChWoKkQj5/ZsdWmFforvxh7nXH2rV/z1Zg4=
X-Received: by 2002:ac5:cb4c:0:b0:4ef:668f:2438 with SMTP id
 71dfb90a1353d-4ef668f245fmr8617396e0c.0.1719420308489; Wed, 26 Jun 2024
 09:45:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 26 Jun 2024 22:14:56 +0530
Message-ID: <CA+G9fYv-rWNXZ9JxA19qSP0r+jhPDaMJejKbckN72kT1UpQ3QA@mail.gmail.com>
Subject: mm: huge_memory.c:2736:31: error: variable 'page' is uninitialized
 when used here [-Werror,-Wuninitialized]
To: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	lkft-triage@lists.linaro.org, clang-built-linux <llvm@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Lance Yang <ioworker0@gmail.com>
Content-Type: text/plain; charset="UTF-8"

The x86_64 clang builds failed on Linux next due to these warnings / errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
------
mm/huge_memory.c:2736:31: error: variable 'page' is uninitialized when
used here [-Werror,-Wuninitialized]
 2736 |         folio_remove_rmap_pmd(folio, page, vma);
      |                                      ^~~~
/builds/linux/mm/huge_memory.c:2700:19: note: initialize the variable
'page' to silence this warning
 2700 |         struct page *page;
      |                          ^
      |                           = NULL
1 error generated.

patch that is causing this build failures,
  mm/vmscan: avoid split lazyfree THP during shrink_folio_list()

metadata:

--
  git_describe: next-20240625
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_short_log: 0fc4bfab2cd4 ("Add linux-next specific files for 20240625")
  arch: x86_64
  toolchain: clang-18

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2iNfPlsMdxsqZTOC14r1xZZxq8X/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240625/testrun/24448204/suite/build/test/clang-18-lkftconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

