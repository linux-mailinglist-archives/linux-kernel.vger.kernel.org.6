Return-Path: <linux-kernel+bounces-271664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC594514D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419D41F241A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EA51B3736;
	Thu,  1 Aug 2024 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FxvQlV/3"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21433A1DA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722532128; cv=none; b=oVN3mxsjJ7tIXe5AuoSejBwBzZAP8J1iBXGYhM/+z/LvdH1QJ2NAjBTAL8VeqL/kPlX88SZ41P0IlaL2zHLtl27oDesgffI+i56BlzZRDfD71ZUuzQeozCmthC1MHHcks3ui0N6tDuWYI/ITtjhf4NdF6Zn+ss3QTP4Qu8pnbQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722532128; c=relaxed/simple;
	bh=AoFiuopbph19kR7z3M8weDATeo87g6unPaMHwvwxKVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qSLw2emaAXQqnbKyimG8hpFeqFbbJbcb3ETZt+W7ptQvXtRhYTkBxDur6z7y4qfppZl9U2NcNvaMuI/Q08qgZqjY6ntzueF6Nf2BtmwRm+Kfl49FVd1anFY5AvoPXzE2N2FsaHl/YxS+t1oaWWzF6APWnv+yBsJNYI61E3PmzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FxvQlV/3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d2ae44790so5195753b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722532126; x=1723136926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2AgtxsASzuesMwzhZyhyOQc/xVilmb27Zrh8mxKKU/k=;
        b=FxvQlV/3aSJz7VFF2y+lDHU2phlc+VDZNVOh1IYgQfRbRQCDKvHtdslb5srOCOqJkY
         9K1WbFfRSByTIYJ6xVmyXoHF7OaXM+Xy5x2b39RuPBTIrFMhU7dXQyLkFxFJ5YcQJprG
         mPlBjt6y42zKaQgjoWcsYAXqoAz9VWapPmvTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722532126; x=1723136926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AgtxsASzuesMwzhZyhyOQc/xVilmb27Zrh8mxKKU/k=;
        b=M2SETy/25twJFRKtIkZiIf60D0VBEv8F9G8g/nPbG+HvBevMHdf7gqhdP+Nd/P5Arp
         s7jxCKb8o80XM+5d1+gQL/97bNPuXcBgf3sZ6EFnpnjreZdsOwetnI6S8m1KSEfJvtdw
         C7hBViC01YN/rURU1moAHXYK4milphx+ZcajkmEsHttdHvv7LCmvloo4zv9+FTP6DQK6
         nRty0vD5dBYdBek4qDc/xvwDdpLguvirqqDERaBCukYuOV4SespTYPeSA4PTm1Rp8e7D
         1jNU2yFQVz+bM1MU514lydAfxDcRofdLfqYVGBPqIRqeVYgT6gTZuxCbcNm7ztvA9KRd
         4mPw==
X-Gm-Message-State: AOJu0YxqUbQgtaJs+NO4xmJbTdb9AXDp+6ST6Y+4gbGqrTx1TyHV4GX+
	q3PE1jvsc6pl4b8oOORiIWhhryB8yWtMi3QZJC41Kw9IAHaiFsf5ZGTWC42KgA==
X-Google-Smtp-Source: AGHT+IHMo7aSYZtzoq8B3sm5uUid+/iPV/ZLqe860tbXT7GJBuzYVH8fFwPDZAUFhwmG7PWcHVTMDA==
X-Received: by 2002:a05:6a20:3d85:b0:1c0:ef24:4125 with SMTP id adf61e73a8af0-1c699560912mr1207360637.26.1722532125792;
        Thu, 01 Aug 2024 10:08:45 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7106ec49486sm69042b3a.55.2024.08.01.10.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:08:45 -0700 (PDT)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 0/1] binfmt_elf: seal address zero
Date: Thu,  1 Aug 2024 17:08:32 +0000
Message-ID: <20240801170838.356177-1-jeffxu@google.com>
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

Sealing this is probably safe, the comment doesn’t say 
the app ever wanting to change the mapping to rwx. Sealing
also ensures that never happens.

[1] https://lore.kernel.org/lkml/CAHk-=whVa=nm_GW=NVfPHqcxDbWt4JjjK1YWb0cLjO4ZSGyiDA@mail.gmail.com/

Jeff Xu (1):
  binfmt_elf: mseal address zero

 fs/binfmt_elf.c    | 4 ++++
 include/linux/mm.h | 4 ++++
 mm/mseal.c         | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.46.0.rc1.232.g9752f9e123-goog


