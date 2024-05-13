Return-Path: <linux-kernel+bounces-177229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAEF8C3BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33F71C21029
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 06:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB358146A6A;
	Mon, 13 May 2024 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDBWccOC"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B20146A64
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583305; cv=none; b=Ba1ABIuNkw6+uUlBayStaqlEZxk8GW7BFrmVIrk/A+xuDnk+JgQjevOKnXx2I7PajMdd8Vhc6IjMD+D9QZOBkl3FpeakD1FpcbFwz9Kkw2O5HIUbKNKNxWCpQCF732annTgqnh/o3xgPj3rEvWJknVeUH8tPP3KUAgro/oULwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583305; c=relaxed/simple;
	bh=OPV3LeJAcJNEdwd/2kpXC2jiPe1JFgVP60n8ju3dq6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DwcwZGOLe7zwemuG4VVlimfAQN602TYCA2XUOfV5h4l5HoPJrxKsBT/DHpuQJHqoPaYdsWblle2bd1HKzp6yohmCpvM8dCkOmM24WtttRaTK8f23UQeIdpHETE8K7D667lTNE8GDwU7FqfdoesFykoXso+VkJRCrmgkRIJqQC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDBWccOC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso5268217e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715583301; x=1716188101; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UYPQd20pjU8qkU8e2+mIVu+x6nOqYhAEz9O7Pru6GZ8=;
        b=eDBWccOC0RFRdwoToqJxbjLRYjieW0ZEOfqKFe5mbRjpDYnEe9gKEk/+AlEvG3iqs7
         qbndHO9w2YeYEnM1gisNNhqnACBw4bnOcSo4T4oU2yY/uK7spudkBizQ1tiSZDVYIpwG
         YTLHrs4XUyFYl3JL4UZyqjqnYQ1fQ/4hnqQqFWWmA1nP40lfHJes8c/Ca5UhskdptXSQ
         Z2zdEvtqivlb420VY/I92VKGojBM+HzlMvhwLkcKHvGJNYTKsCSQkPTyWHruTHgYIjCQ
         vh2cRfLxMO1t41orNNOnram03Y4jViMh4tyy7ckX2xmZ8KmoKvkb/pG1Qfu2D9xfBRxI
         mBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715583301; x=1716188101;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYPQd20pjU8qkU8e2+mIVu+x6nOqYhAEz9O7Pru6GZ8=;
        b=Z0o6J/GgDgJ7YDcPSDNYwmDWBPqIwhkeRqlMUoOIoIXjI4Q+/gn0bsWDMa6mFOw+S7
         WNGCIxhVtHDVZFh1XKN9qSKrGHUISbKO8ThvDS3IspTxI+0RsEhdny0UpHeo9KYZHcl+
         5kPeXYIByw/mVDPFXZvt9modcgrAdsJGMip1SFIZ6fGz5ADan85CeIRBUb2qcQGDy+UC
         crs9se26fszWHKjEKSIj2OIMWPc9+17+rHs4Am6hjhmuFtpWWYnb/HGaxDIH0F/X4ZwT
         RjOv4ZZqPNZryIm0Da2H7NOw5dez8s/0b8/RDypo1sryRfJHJxGOpBvQuAn0wru2Sz8/
         KSSQ==
X-Gm-Message-State: AOJu0Yx0l1Qo48zLl6OAbIh6rjY/fTdbl5kRX/cbn5UrTD6pVx5xJplP
	K5NMEdifWOa14nV4VYCjBrRbD2v9vO1ggy5U6u2T0KHOyhavsJ8HUknSlM/t
X-Google-Smtp-Source: AGHT+IE4zzpksE1AoVovk87d1eecoazHnHwRAAx9DBnlOuf4RyCCdb4BvCytOPT0ia7g5HCaJOElmA==
X-Received: by 2002:ac2:58c5:0:b0:520:7a44:3f30 with SMTP id 2adb3069b0e04-5220fb6ab92mr5798631e87.16.1715583300882;
        Sun, 12 May 2024 23:55:00 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2b8f7fsm5706351a12.66.2024.05.12.23.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:55:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:54:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>
Subject: [GIT PULL] x86/bugs change for v6.10
Message-ID: <ZkG5QsQkiVNojJU6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest x86/bugs Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-bugs-2024-05-13

   # HEAD: f9f62a877da1e6f6e9d58bd779c1c77052eb04ab x86/dumpstack: Use uniform "Oops: " prefix for die() messages

Use uniform "Oops: " prefix for die() messages.

 Thanks,

	Ingo

------------------>
Alex Shi (1):
      x86/dumpstack: Use uniform "Oops: " prefix for die() messages


 arch/x86/kernel/dumpstack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 44a91ef5a23b..a7d562697e50 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -405,8 +405,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
 		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	printk(KERN_DEFAULT
-	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
-	       pr,
+	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
+	       ++die_counter, pr,
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",

