Return-Path: <linux-kernel+bounces-301474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CBE95F16B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3477828277F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7290170A11;
	Mon, 26 Aug 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNmcrSZi"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD922071
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724675833; cv=none; b=NKUhhwom0gY6yJk+uK3dkCavVBt9SSliBq9CQFlUZLoKucF4Fnl3EzpTOQHyjp7sA8Kz1h7t9WYb60sn8TCXTqg+LgU3JBmEn9iahmFC4aqcokcRZBt4TNv34drmqxqD9h9G8erlAni2VgEu4yMUAlh0D7A7/XIkPVyGc29X78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724675833; c=relaxed/simple;
	bh=tU+F06KD3SdlqkzAX+oRdzXbf4TrB4rlKRMryvYWuqg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=glI1fJsGLdYPoWDphvE6UmyxuQsagbCv2SQ3MNJIb5RNNzzNr0SltO4UzKkFDmNqrD4aje5Ng4OnWEBMb2XmUDQqbIjf4ypPDF7xtN90aPQl66ZLwS09qGuNtjUxIubZAWPK9RuerWw2ipxDZbUrnfeNkLGD9OP8LBzOgB0zRiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wNmcrSZi; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-498e1e3bee8so1335711137.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724675830; x=1725280630; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnaTwyls60538rF5sTUN3uFvzG458NrPK/zbgy32n6k=;
        b=wNmcrSZiY8DLCSmVrajEUTVqt7YPnRvyx7I11kkUt6BeY3vbrNZLB6is/LVAmT8lPk
         InzNMGvFMmhb672qNPF58KalS2ddbasby55GPRS81FvsFrTyhL2gqTGL0xRFmtTAtbAJ
         2iKrQz1PqcHgkbiy/9kY4hdxCWLy1CSdd9ufkbeXxhE+25InvSM7A9fQUhob/c+pfRVq
         eYVQxM3+d5fBwwHcNsQD/veaMzKSfiY/jeO/BXOpcSk0B96FMl0hqE2x20BLFQHu3TI4
         g7Urbj7/JMw2mWtuXHpq8QaeJq+0Ll7giLsuhz3FR9paIe0qkWOhSFZiqbd6lDdbdCKf
         BoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724675830; x=1725280630;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BnaTwyls60538rF5sTUN3uFvzG458NrPK/zbgy32n6k=;
        b=nnQY5RY0vE/D9Mhzk3xma10NYFiw5LQyX6+4daVpGreKO+ZpM2HaM3xYugU5I1O5aG
         eSR1d9AfHOYSmQMpOFf+IX2ZyDdPXAeT/4fRrP5HjQ15c0aJaOsI8bQghlwxui2dyRN6
         QO6yTkYnZfaDFDA3go+U/He7kCRSXKpoTU7N7pnKaYE1hJ+M2kGWK0z+Xd0x3ShsNNpM
         XAOO9sywAJdhD8OzlkP5x6Ya25pu5yQ3Eg4xOoCdMzID0gqQqdRK9E4kDRcnPiyLqdq2
         WUtCFxzIo1vquZ/OVjN5F4sEbMCLlEGXDDODbVOWOsoWir0jOyYRsWlfDF78khkATMG8
         JX6g==
X-Forwarded-Encrypted: i=1; AJvYcCUwDEjMfxn7HHY1iYGhZw/K7jc4YebkpYlG1BtWjeFfvw0TCnbFq88Fhpt1gmcivdJYoXPbsEKW2qCSygA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNKnZYn1vmv5tz/z+dth/NNKjQeRjZpx13SbyByW1IeUPicqlV
	/NM4pnjWvTGJljvVGulBp9bGZZtJXdLGfeneI+v/2amTuAuq6DzcxN150GrJx1rknWHiFmVDA+F
	4KA9Ma0lLcYjZIfRrcfGWvG+JzVtzJP904KupQg==
X-Google-Smtp-Source: AGHT+IHfFcwhCvcH2LPeasFnJgdBqYdbUpTxRYB0euddshiP0l4zYFF770aeqcEuWv3OaLuN0aR3utA/1FI7haQvsfw=
X-Received: by 2002:a05:6102:a46:b0:493:bcbd:4633 with SMTP id
 ada2fe7eead31-498f4513565mr7991472137.3.1724675830398; Mon, 26 Aug 2024
 05:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 26 Aug 2024 18:06:59 +0530
Message-ID: <CA+G9fYuTLbZ+UiONYVQbtREuOZXc3oWP5=x-qqDhmFRmFfPtHA@mail.gmail.com>
Subject: next-20240826: arm: tinyconfig: mm/vma.h:184:26: error:
 'USER_PGTABLES_CEILING' undeclared (first use in this function)
To: linux-mm <linux-mm@kvack.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

The arm tinyconfig and allnoconfig builds failed on today's Linux next-20240826
due to following build warnings / errors.

first seen on next-20240826.
  Good: next-20240823
  BAD:  next-20240826

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------

In file included from mm/internal.h:22,
                 from mm/filemap.c:52:
mm/vma.h: In function 'init_vma_munmap':
mm/vma.h:184:26: error: 'USER_PGTABLES_CEILING' undeclared (first use
in this function)
  184 |         vms->unmap_end = USER_PGTABLES_CEILING;
      |                          ^~~~~~~~~~~~~~~~~~~~~
mm/vma.h:184:26: note: each undeclared identifier is reported only
once for each function it appears in
make[4]: *** [scripts/Makefile.build:244: mm/filemap.o] Error 1
In file included from mm/internal.h:22,
                 from mm/oom_kill.c:50:
mm/vma.h: In function 'init_vma_munmap':
mm/vma.h:184:26: error: 'USER_PGTABLES_CEILING' undeclared (first use
in this function)
  184 |         vms->unmap_end = USER_PGTABLES_CEILING;
      |                          ^~~~~~~~~~~~~~~~~~~~~

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24951924/suite/build/test/gcc-13-tinyconfig/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24951940/suite/build/test/clang-18-tinyconfig/history/

metadata:
----
  git describe: next-20240826
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5HukjOlVYM52f7n4rm8EXOLG/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5HukjOlVYM52f7n4rm8EXOLG/
  toolchain: clang-18 and gcc-13
  config: tinyconfig and allnoconfig

Steps to reproduce:
---------
 - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

