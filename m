Return-Path: <linux-kernel+bounces-213226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D954907217
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B241F24F96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF70A142E9D;
	Thu, 13 Jun 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ll5DUe6M"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2161428E9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282615; cv=none; b=IIisNn+Mgrb7McXUdQwIetClYQU6nWvBl5Mlq7YXV0yjeacioyMcv8RPcrqZAgE5X06G5GM7kIKukDzzqTCD3dkQK4e6yx3JS5H0jXemc2XW6s7iB+I+5czcqyYqLoMpTZXeVIzFzHE9zsAPwUXko0p/rDuFSv7wc6XxKA+pvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282615; c=relaxed/simple;
	bh=9vhByrYTddCz5w69wCkBjEj1ybXh+NO+Xa1LhTP6Elw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cYtrM4qm9ebfxpLNZpUUopp0AkPq3QD6zvYyteQyK5vJDiVILJ22jloVLZZPAd8HNDBoAWbc7BIAlCTDR6kcOH35fN/Q+HOieA80fMJxdz8I205VWIUTBRd7VotH5akPj/JvphiEuNtCyMr0fVSRrATSq7Htk0KRdUB6lfSJcA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ll5DUe6M; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso280054e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718282612; x=1718887412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r/LfTxCOrGd7G5G1GEt1IaEmUTPInNVaJpu9fMewn5A=;
        b=Ll5DUe6MN7P4yLs1QZzhOxztqFOVQM40/5lizAQUek/Ezd+cDlgKHePTLX3fqv9DiG
         0MWrZ1eP63zDmj09yD/1UogpH98VzY10NgLf4DCeWAwe80GfsUw8mjjtsIyTkbd9IMJY
         1nUv3jN+u8Y0THdJ3xyZNstynLlELoMwSilp/D5TaRBDxr3jAKKb249nngpZeVxRD0wS
         iFFkB+/X7mUy5TrfhpJafQjOwXO+yDPn5j/+GytzFocACjZ7gTO/TT+fJsJZxLg3Iw1I
         f1EKAPm+bffRhcc6LAWsbqP/1sAmXFzSm30wlBzKAU1Yb7Dj8YTzvl2sSXSjer0dFWUe
         Y1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718282612; x=1718887412;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r/LfTxCOrGd7G5G1GEt1IaEmUTPInNVaJpu9fMewn5A=;
        b=FwxU3e07JcXC5xzGZ2+UQ9iqJ1UzCGaIwNj4OEd7yqsjIe1zRaoiGgB4Rp778T36a2
         kl6C27iIlNjhLcbCMq+VzijGExwLFruQdpc/6zG1Xcx3Lh2DaDPNTKLq2wvpQjrO6Sy5
         foxRJMGA0gRbLE7wIrrsIERZJgupDYGLv6NdM5pGaiBr5+rrh+g/hHXBNf5moAZkkUBL
         CyrbIyKcBUrfkWipQ5W5XFpttHVszcBJzmTYqFOaiXZcESAahJ/7b3B9ScsL2Fu+ZMam
         nWPh/8mcXS1jB4J6XJvF6Laimgxf0mvA68uvajRSBcyDapOuPpZ1zAtiBZWjBPRDh0WK
         lZeg==
X-Gm-Message-State: AOJu0YwnrIbLH/0biPyx6VpTZ1qYxBNw32zJ2zRBUiTRXLzsepnEBWju
	dpklT+ML6dhSiOGTUsAMKNx1HgYftWipqSN38R7LNWWJ+kLbTpsajD/v95uNnX9rO0kMkkKiSK7
	9+V6z/o5ETQvfaPgaRTwN8WTKVLsLuUap25pXkCcNchV1wQ6odvE=
X-Google-Smtp-Source: AGHT+IE1yzoIiBI1Uass7Fh36Cfm7FBqITloTOhLEjBJOxttNrRWFltwQCAkGGTWxxFwSvpyp4qmtBdDb528xiWr3+U=
X-Received: by 2002:a05:6122:324:b0:4ec:f175:8703 with SMTP id
 71dfb90a1353d-4ed077296c4mr4733182e0c.0.1718282610792; Thu, 13 Jun 2024
 05:43:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 13 Jun 2024 18:13:18 +0530
Message-ID: <CA+G9fYvWXuWyd3NiX3WwRyorRiDRbxGmRW_7aVnBVKUVA_TaGg@mail.gmail.com>
Subject: security: ima_policy.c:427:17: error: too many arguments to function 'ima_filter_rule_init'
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Paul Moore <paul@paul-moore.com>, GUO Zihua <guozihua@huawei.com>, 
	John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"

The arm and arm64 kselftests builds started failing on Linux next-20240613 tag.
Please find the build log and related links below.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
--------
security/integrity/ima/ima_policy.c: In function 'ima_lsm_copy_rule':
security/integrity/ima/ima_policy.c:427:17: error: too many arguments
to function 'ima_filter_rule_init'
  427 |                 ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
      |                 ^~~~~~~~~~~~~~~~~~~~

metadata:
------
  git_describe: next-20240613
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git_sha: 6906a84c482f098d31486df8dc98cead21cce2d0
  git_short_log: 6906a84c482f ("Add linux-next specific files for 20240613")
  arch: arm and arm64
  config: kselftest merge
  build_name: gcc-13-lkftconfig-kselftest
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2hoLwDXEx5rCFxECYqQmkKEEurs/config
  toolchain: gcc-13

Build log:
---------
  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2hoLwDXEx5rCFxECYqQmkKEEurs/
  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240613/testrun/24303459/suite/build/test/gcc-13-lkftconfig-kselftest/details/

--
Linaro LKFT
https://lkft.linaro.org

