Return-Path: <linux-kernel+bounces-276968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E63E6949A82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 232F91C219B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927716D33D;
	Tue,  6 Aug 2024 21:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h20FpcxD"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424992AF12
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722980978; cv=none; b=WYSv3jTgkZ2RgSn84FG+br7yh/gthYtopkrholQVsYIBybuLwyvJynVe56AmV3jIHlwOsgaroYs5V16czjqZtct9ogRN62lGYw8Lxr/qJrjQDtAcm14yNpRjRL+d6LxtqHe00wyWd8ar1PYKJjPPSPodgb4ZEo54YQPX98TECqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722980978; c=relaxed/simple;
	bh=AybM4sqB6S/QPEz2V/rcKyCotd4jaW03IK6nNX3w91U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XT1sNK6/rUDCyfTR5wJ0O+Q2PubAN80t9n87s8MIlhFHH6BrBpcpDFXrFlektJf7QAqwr9QNaFX9EUW/1Uj3DInQ9ulPuErf3qEzWwuqJmPfi/CWH91TsDh1eaCSAWhNunG1gWodeFJEwpHzzUs1QwcoxWQcCTAHPbmJiusS0gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h20FpcxD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd78c165eeso9189865ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722980976; x=1723585776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+tIcIGLCcXtrMQFuAghyCnh7JsC5dCfIsg6M2Zg+Ug=;
        b=h20FpcxDRUWkSl23N+Ew8+HJgLK7eCdVx3rtGDDQznw40eiDTatOdNu2vucjb76bM0
         DC0Jkgz7u+HKIz8sZDVefExSozpQUEghYaaT1XPNVNsqIl8Uz54d2fM7lkgU60mTPL9L
         PIyVY0t3i/IYdMdIIsrhwit+4brtDwzGPTbG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722980976; x=1723585776;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+tIcIGLCcXtrMQFuAghyCnh7JsC5dCfIsg6M2Zg+Ug=;
        b=ksUNGYfUNVIHAG3ypXNl2gqXLl8x7HM+GoSAeGpaWQOENTZfRu+4hEYjxq5erJGYBt
         qTXNqLR1CnoiNL96zcDD0ULKM6VM/wO9n46yZ9ndO1zbhuI9YPS8xTx8cCtwFFxA289w
         +HFH1Kq5jvCvQb4U0EEgrwkxM5pP505lLd5P7Rn/OjVJRps9Y0RLCYpKyA3WULfq1xqV
         Ol4DTtWLk0qhBm41mrLNwsRFfxJ3B7D+d6EjLLveT7xDkYUeRunZiOrHcrkXbjkSksJl
         7emcnerIPnwmq3Uu0TsNC9RjMLfbvytmU2a79PZNYYJztSxrd0KYZiDiM5KepZxu5AfY
         yhjQ==
X-Gm-Message-State: AOJu0YzxX2xYa5qwmjN3DfnEXu3Zy1FKq6iC/dfHDHi/JX0IrXrhKr2W
	pMzGYPweGYzAu0gj8+fXq+A5CVd1yiBDlsZghQw/QgCy2MExyVIF4DJzWgK+7w==
X-Google-Smtp-Source: AGHT+IGyIjjt8acKHrnSgbUkg5U6IiM6X7okFU45wSk883WeJscUQ1vOvzczB8Acmy52SDsQZqj6Eg==
X-Received: by 2002:a17:903:290:b0:1fc:4a88:fe53 with SMTP id d9443c01a7336-1ff57457388mr204617975ad.51.1722980976430;
        Tue, 06 Aug 2024 14:49:36 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff58f6093fsm92767575ad.114.2024.08.06.14.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 14:49:36 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	adhemerval.zanella@linaro.org,
	ojeda@kernel.org,
	adobriyan@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	linux-hardening@vger.kernel.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] binfmt_elf: seal address zero
Date: Tue,  6 Aug 2024 21:49:26 +0000
Message-ID: <20240806214931.2198172-1-jeffxu@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

In load_elf_binary as part of the execve(),  when the current
task’s personality has MMAP_PAGE_ZERO set, the kernel allocates
one page at address 0. According to the comment:

/* Why this, you ask???  Well SVr4 maps page 0 as read-only,
    and some applications "depend" upon this behavior.
    Since we do not have the power to recompile these, we
     emulate the SVr4 behavior. Sigh. */

At one point, Linus suggested removing this [1].

Code search in debian didn't see much use of MMAP_PAGE_ZERO [2],
it exists in util and test (rr).

Sealing this is probably safe, the comment doesn’t say 
the app ever wanting to change the mapping to rwx. Sealing
also ensures that never happens.

[1] https://lore.kernel.org/lkml/CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com/
[2] https://codesearch.debian.net/search?q=MMAP_PAGE_ZERO&literal=1&perpkg=1&page=1

Jeff Xu (1):
  binfmt_elf: mseal address zero

 fs/binfmt_elf.c    |  5 +++++
 include/linux/mm.h | 10 ++++++++++
 mm/mseal.c         |  2 +-
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.46.0.rc2.264.g509ed76dc8-goog


