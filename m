Return-Path: <linux-kernel+bounces-215768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B239096CF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AECB1F22616
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5418638;
	Sat, 15 Jun 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI4UeK4X"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C2182B3
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718439206; cv=none; b=NjyfbBL0PB9sA7q9sOJKcBxhGgfyPBcoAUVUVjhmZG08Kl90s1uw/hBJgOx1fTkBPpcyahDS7YS/uB6lTtAppMv6ISSYQdTmis+M2JPFV6IYQTw3S9T90c4Hy/74bAR+Vmr5agjsD47/YRwbjKeNO9o2/z+vOU6ykJu7vLGFcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718439206; c=relaxed/simple;
	bh=GGCaA42EiIwjy3YNfQifHUsKQiQSrZ5gY8S5cI9Q0fk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HljHlkVdHCwfLEoFxI5zoUllgQvzP7T4TjWBY9pOEqCo00bHjHvOc6M4SJLexY/uLnPjzrGY4PZBm0jirFApCCiohct7IFGbCQF10JQJ9+z5BZjPrcHoCQjl9LIkhiB7Z3ikkLQqm3VfWRitS3KSvqiXAIWDWO7WL0UfOi7Dmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI4UeK4X; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a63359aaacaso442945666b.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 01:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718439203; x=1719044003; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9V3+R/Ia5LFb2+SINpw7/x0qRaxOV/1HB5xxocu0jaw=;
        b=SI4UeK4XhuPwrS5gq0R7otnEbjx7x3b59BCREJ/s2iQirX7vAR8SxUm4BzRABmnHhK
         WYJHTza/LBQs8IzKzd4yXdDGPGkx4KYONjmf9NxhqMGC09xFlw1E7yztrpXMlqI18BMh
         vDNz2MIYpZPTcfOjnLThPp9VDPBzKagfX54PHsurY9e0YJnB/RSwlFed984zhD/6GSmc
         RTpR23kRRLVB0j72pD50u3OPlFagrPQc7h/G2Qhn5CZONaySXpHSS6EfCP5nNPWH6gbZ
         S0iocNGQgZoCMRc7dcUEHG1ZOhuoR5eojX7y9OMQVXJERx8ux3mp1TGc2Yfq9/MOuKFy
         YDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718439203; x=1719044003;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9V3+R/Ia5LFb2+SINpw7/x0qRaxOV/1HB5xxocu0jaw=;
        b=YW1WpUv5cVtpa95vUUhyeLSeSZpflC3VpFuijeHZIxgJCholdz3ZcgbelZF4+HGerZ
         Rb7h3KOizzIF9PXg3nx04pOWLMFd4stV6EeSwPWvnTzUmpGBNj+qyn9MdzDpbIH8zX3y
         eLh0MGdhaNV87r5uTLr1lkTUmhlDhgeFTJxvPXkd2agHm4CgA/tTn25yhZmyquQvZVFz
         xPqwjRLgQA2c40te13ZcO9WIXV8IHthkLzhi5SWoyKmT9mIPvoBvWrZhKNM+64fm/olX
         SUn4S4x0o/Htlf+tYxytzMaKryM+ekVOzywF+RljzGbV1cefpyOhKn+yMEe9JpqBalP+
         qTrA==
X-Gm-Message-State: AOJu0YzbtUWbAnHIFldTnPQC0BsFf36AZWwIKVcIZvcVcifTFfLlY0So
	79PUOmAov0eIVJ+eWWXeyfnqSelh/iAHIjkxnsoYqciCTxt20TqR
X-Google-Smtp-Source: AGHT+IFVuDfL0BD+8VrP1BenY6h+wVs79NY3IEY1g6vqp810eFkN9pe4cQ9IpFc54TwnF4TrTiGqUA==
X-Received: by 2002:a17:906:3bd1:b0:a6f:ea6:9534 with SMTP id a640c23a62f3a-a6f60deb626mr305178666b.76.1718439202733;
        Sat, 15 Jun 2024 01:13:22 -0700 (PDT)
Received: from gmail.com (1F2EF7F9.nat.pool.telekom.hu. [31.46.247.249])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f42d25sm274821266b.174.2024.06.15.01.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 01:13:22 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 15 Jun 2024 10:13:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <Zm1NIOnj0NR3U8om@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-15

   # HEAD: b2747f108b8034271fd5289bd8f3a7003e0775a3 x86/boot: Don't add the EFI stub to targets, again

Misc fixes:

 - Fix the 8 bytes get_user() logic on x86-32

 - Fix build bug that creates weird & mistaken target directory under arch/x86/

 Thanks,

	Ingo

------------------>
Benjamin Segall (1):
      x86/boot: Don't add the EFI stub to targets, again

Kees Cook (1):
      x86/uaccess: Fix missed zeroing of ia32 u64 get_user() range checking


 arch/x86/boot/compressed/Makefile | 4 ++--
 arch/x86/include/asm/uaccess.h    | 4 ++--
 arch/x86/lib/getuser.S            | 6 +++++-
 3 files changed, 9 insertions(+), 5 deletions(-)

