Return-Path: <linux-kernel+bounces-198149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597838D741B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 09:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE18281C3E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 07:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14FC1CAA6;
	Sun,  2 Jun 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpCpTc20"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD1639
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717313145; cv=none; b=ZZJCnAzEe2+X24oxjaoDoggR6EIq3GjaTlWMqtg3w4reI164/JIJDFRmMMcFxmjSaSfG22jR/jyZBpTYcCDj/1SdjJgSO+Bl3tMqTWXOsQliQu+s9FLJ3LKlfQQLnUTZW7ycOPdpZEU9IoZa+q1/0wDxaEQnuTqXLuTiaPhMSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717313145; c=relaxed/simple;
	bh=7WD64i0+k7wzrdv9SPMsVhhFAKaO8wTNQRFiydpM9fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s+yDvh35oWTrcs5QvHI1pnhOZ/Z7fxAWgKaWsBmbZcWXK9Mv3Ho8pY/068b8qMxf2zEvbiE4GUUYQF6Z2fUJvTF2KL6rQJEC03HAdC0Q9K5g3C7J4habWazkAp1aYlyw47w2MC3nlTJ9SoCU2oOFgG7hiP+QJhoX4OPlABACNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpCpTc20; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dca73095aso2751705f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717313142; x=1717917942; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TsxbkRuE7YlKGK2F3uej8fyXODYWogpkK3Wcg5zOdFg=;
        b=DpCpTc207MJQsp9K0ueRGlXxK9g+gmQbqbXuzIZTPnIBretI9nQlhugC0mA2cyHgYs
         /070a4mcNq86f3oLwT2Bl5CXUsUp/5DBaJg5Qi9aWzFn1UjrRqtJUZqXwi3+yXnyVztr
         d26Qd/yIYa47vHowjGjDwXMJLfEVuWCSeEfMAazhqyVGFVVfNoYemv6BQ2elWgByccXu
         yPsFdBsJtdO/3tjBm1vfIKfNDqXd9JkPwZAgQ/a09Q30z9o2o06eAwqdRFx+j6QZCJ0A
         rWr6ecsWjmyIxX0qSyfEJ8lOIX6exvsi6YdROBmnvb315zd3omKnv4Q2pjOsUyCSG5ja
         WFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717313142; x=1717917942;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsxbkRuE7YlKGK2F3uej8fyXODYWogpkK3Wcg5zOdFg=;
        b=q7I7N9X2EyiL25qmmxgi+c04HEjt6km6Oa2C7nZvCuXHLfzkOGmps3rW7mH3oBBlG7
         hxzzMPJKdTb1gcWTpQrRCHYAgTYpfoxeKZo0T4TNvWTo+Ck8AA2gcPom3JAOW/sZSxsC
         w268dZer/jUHypf/FPbnvRPXI8SubevfAMLvKAB7gSTknoMslTchV/8jeDGuNYOKOxeq
         pFVrEyzSvBKrW5gE5fSVH03KRdB8nt9L8EsfBmxmteGCt2E2sNJ718t99QuvssMQ0kSq
         p4vpONDIqpFUxJZ8YVLngKXfxm2KXxIUdpdQ+u0Nac7p3+YdgULMQhfGQ2eyu+QgB/E0
         G0uA==
X-Gm-Message-State: AOJu0YwM9snMP72PUZa5YwCo9LurfVuqo6zPliMMFZsYXWk/PnH7sXD5
	/NpXyD0SeT7zWKBkZav2T2UHiRU+m8ps+7YWY1W2kVdXocz/NWY9wOocFAJg
X-Google-Smtp-Source: AGHT+IFhUpGIPRd3SXMt8YOo1Kvp53eGm1+ZjDx4jo55/5hYb+udokLxjTdLFs3G98LpIAJuooygxQ==
X-Received: by 2002:adf:ef11:0:b0:357:39e7:33a2 with SMTP id ffacd0b85a97d-35e0f27276emr4215784f8f.21.1717313141485;
        Sun, 02 Jun 2024 00:25:41 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42133227f8asm55626315e9.19.2024.06.02.00.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 00:25:40 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 2 Jun 2024 09:25:38 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [GIT PULL] x86 fixes
Message-ID: <ZlweciPk77ra9W7H@gmail.com>
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

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2024-06-02

   # HEAD: 0c2f6d04619ec2b53ad4b0b591eafc9389786e86 x86/topology/intel: Unlock CPUID before evaluating anything

Miscellaneous topology parsing fixes:

 - Fix topology parsing regression on older CPUs in the
   new AMD/Hygon parser

 - Fix boot crash on odd Intel Quark and similar CPUs that
   do not fill out cpuinfo_x86::x86_clflush_size and zero out
   cpuinfo_x86::x86_cache_alignment as a result. Provide
   32 bytes as a general fallback value.

 - Fix topology enumeration on certain rare CPUs where the
   BIOS locks certain CPUID leaves and the kernel unlocked
   them late, which broke with the new topology parsing code.
   Factor out this unlocking logic and move it earlier
   in the parsing sequence.

 Thanks,

	Ingo

------------------>
Dave Hansen (1):
      x86/cpu: Provide default cache line size if not enumerated

Thomas Gleixner (2):
      x86/topology/amd: Evaluate SMT in CPUID leaf 0x8000001e only on family 0x17 and greater
      x86/topology/intel: Unlock CPUID before evaluating anything


 arch/x86/kernel/cpu/common.c       |  7 ++++++-
 arch/x86/kernel/cpu/cpu.h          |  2 ++
 arch/x86/kernel/cpu/intel.c        | 25 ++++++++++++++++---------
 arch/x86/kernel/cpu/topology_amd.c |  4 ++--
 4 files changed, 26 insertions(+), 12 deletions(-)

