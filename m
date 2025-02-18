Return-Path: <linux-kernel+bounces-520179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F552A3A6AD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4032D3ACF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF291E5213;
	Tue, 18 Feb 2025 18:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZgA3qEvQ"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680E41E51EB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905191; cv=none; b=jKb5PlDovNkyLHsz3QUpYlpOsVpYAedZq+198VMKNdUPiEUKlchKVgUZjUXVmQcfN/f0Ou8lFm9J2mp3stuIWBNCLj0mIdqxsiQrUf0RH4/VS+NmdurEhd+NVxtdn0px2w7ycFLQkKABqKTaC+j5VyVTVp8uSQ6nydV452pUxBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905191; c=relaxed/simple;
	bh=sgcMCXHcqmLD2fAN4moy0mYEbl/nVo/5UuzQ5yvUtoE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VrFuqlMb83Fi5SYaOCQJr3jVPA70y6ne2Ff80Ke6+K9Wo1UFi1pFL/Zh5THHk569nWeUCSzpeJ0juJhCgLwmekh5F46JbUlur8oEnOK4lndvFK3r2PoQrqda9JttYULDiLri9dHqiSakarSUY8mKuKsowPjMqlJWQCpbE1qLMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZgA3qEvQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so41989955e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739905188; x=1740509988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uLokahsRp/1HhhIeL1ZdoIvCr2+1AW9MZ/zEnvPpzB0=;
        b=ZgA3qEvQsc/IqTB9qmckEKwZBrimrQqNVCszrAtvZuU/eVE6A83EpHQWBc3Ci2r0+0
         SRysxNK2fAD8Ff9D9ow2UytiYw+lIzQTACOmD0GsTNi4T9j/yxrWAgrjBkfUrO34eWLG
         lXiKrf0oC9p3+KM3p1QqqV2tdQv4S9dlzm2xUESjXY8Gf+gOenH3/0YssnyYWQf9enAP
         L6U+V78r23Gtz93AnAREcAcMZgOQDrPa7tzBsu+CVXIG600X4q12tGpbNW6Gs8W0b/Qy
         JMs4BNTUx7n6JpDLuwLsQADUr4/WezEtp9gRhOP2RALaZ6tXgUlN28Uihd6xLobNuUde
         Pubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905188; x=1740509988;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLokahsRp/1HhhIeL1ZdoIvCr2+1AW9MZ/zEnvPpzB0=;
        b=LqcHGbewek3+NEi1+oiqWvL5lp8umIEaKxIAR2WS8PcM3A/pCgExZCxgjTypae23NX
         secadPQifKYi3OkgAQhTcq5l1zta+m2o0uXGWxcxQUXBHsW2kHme2Ecv3gpkT8vsNHPe
         LMfN8ID5fDSvzXgAsP6hnhrSnc6YzV0dcKMwx6FbU7ewYr2kfEMtFhNHEXF8n5+l0lQX
         fJc3Bz5pHgSrQTxRo/866dgNfRSVDbNcRvCXn+Ppg+D5CNCNMtTtJH8QBwGn3uItP3Fk
         tt42QfN77dRisSprKetsHx4eKiVwyQ7LF6BbP6l0Cgz8jyqM3Ys909SOb6YfkXpjU7A2
         OD2A==
X-Forwarded-Encrypted: i=1; AJvYcCUbpZwwfhE44f1AStmexazAxMfJ9DCk3kCOuy4TFcWOyUvjPerEa2MDWNuOwdkdRxxh513HLNYIqyA7FL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmPgVgVgN/OuXy6QzmCE7LlrnLqoFtXl8ZiLBlneb+9IPHGrI
	S3iOHb0JVNxn8kfQRWQlm7hyp1w8O7myA4ArSL5G0iHKz2SP0i/Hp9hAd5zc82SoWzAolRegNR0
	TbjEkzriwrw==
X-Google-Smtp-Source: AGHT+IEdNjds1zwEO5M8N/CATJUdsJrMJ0qVNyBBx+DQb42yFggeDOcnhYT/2H2JfwJy3O1KbANvYtULINPbQA==
X-Received: from wmqe5.prod.google.com ([2002:a05:600c:4e45:b0:439:8333:1efb])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1b:b0:439:9595:c8e7 with SMTP id 5b1f17b1804b1-4399595cbb1mr41194365e9.0.1739905187848;
 Tue, 18 Feb 2025 10:59:47 -0800 (PST)
Date: Tue, 18 Feb 2025 18:59:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJrYtGcC/3WMQQ6CMBAAv0J6dk13ISKe/IfxUJa2NFFKWmk0h
 L9buBhNPM4kM7OIOjgdxamYRdDJReeHDOWuENyrwWpwXWZBkipEbMD4wBp4nKCdLDSVkkfVSio
 bI3IzBm3cc/tdrpl7Fx8+vLZ9wtX+OyUEBFKqRD4wMpuz9d7e9J79XayrRJ+cSP7mBBLqjmtsW dcVqa98WZY33aEwQeoAAAA=
X-Change-Id: 20241119-force-cpu-bug-94a08ab0239f
X-Mailer: b4 0.15-dev-42535
Message-ID: <20250218-force-cpu-bug-v3-0-da3df43d1936@google.com>
Subject: [PATCH v3 0/4] x86/cpu: Add facility to force-enable CPU caps and bugs
From: Brendan Jackman <jackmanb@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

For testing, development, and experimentation, add the ability to force
the kernel to behave as if the CPU has a bug, even if it doesn't, using
a command-line param.

Also do this in general for CPU flags, since:

 - The infrastructure is the same so there is almost no extra
   implementation complexity.

 - While setting random CPU flags is certain to break the kernel in
   mysterious and horrifying ways, this is not dramatically worse than
   setting CPU bugs. Although CPU bug mitigations don't have any very
   obvious ways to break the system if run on the wrong hardware, it's
   still very much an unsupported configuration, even beyond the
   security concern implied breaking mitigation logic.

   Since a taint and scary docs are necessary regardless, supporting
   arbitrary CPU flags doesn't add significant maintenance/support
   burden either.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v3:
- Added pre-patch to cleanup some unnecessary macro usage.
- More cleanups to commentary & commit messages.
- Link to v2: https://lore.kernel.org/r/20241220-force-cpu-bug-v2-0-7dc71bce742a@google.com

Changes in v2:
- Switched from a bugs-only force_cpu_bug= to a more general setcpuid=.
- Made it taint the kernel.
- Made docs sound scarier.
- Spellchecked and avoided new usage of personal pronouns.
- Link to v1: https://lore.kernel.org/r/20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com

---
Brendan Jackman (4):
      x86/cpu: Remove some macros about feature names
      x86/cpu: Create helper to parse clearcpuid param
      x86/cpu: Add setcpuid cmdline param
      x86/cpu: Enable modifying bug flags with {clear,set}cpuid

 arch/x86/include/asm/cpufeature.h |   6 +-
 arch/x86/kernel/cpu/common.c      | 147 +++++++++++++++++++++++---------------
 2 files changed, 91 insertions(+), 62 deletions(-)
---
base-commit: 83f8eec51fc484fe20f8d20171f6d450080c04ea
change-id: 20241119-force-cpu-bug-94a08ab0239f

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


