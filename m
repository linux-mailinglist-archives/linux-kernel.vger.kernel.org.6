Return-Path: <linux-kernel+bounces-246933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E592C909
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 05:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222221C2236E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 03:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FBE2A8D0;
	Wed, 10 Jul 2024 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwSUMkic"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1317756
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720581386; cv=none; b=uHhlMOstRDAF0in0utYXFpuSDJhJGGegosrKifGWkB/V5O3CueG+dEVE+HQDBUY8JmSOinN31NYYjpg9t2DwDVdqRSkS8osqLlcfBUiw0OClGYckaV1vCdxj3ZjfsVRQ4RIbHysRGdzLzZyHEcCva8VQ7d0cF+b6kL9ilvav6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720581386; c=relaxed/simple;
	bh=KH+zFSlz82FWmMATspapEt8JjHOn0ZPGE5MuO0ZOWfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RkC1rQuL5yQyEGfRLeDkQ/Sc3rmaiJBrS2cpzoiBLNL8Y4E8dgG1z2hO/1QzLGV0GBH51CG0Sp4qVIfnM05zLq53RYbPvCrfvmANbeaMhiwIdJkBVisLlymZrFEg2TVMA3qMajLclcQW3H9dbdx2GxWc4mmUQgyGvIwZ6PrlJbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwSUMkic; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb4a332622so23058795ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 20:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720581385; x=1721186185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOn0nNGwyICF+4LqjztD1biSMwmWZXfSkdW3laYh9NM=;
        b=iwSUMkiczegTayfY20RhERE8ojNBznA2igoAVM0UMxbjRgAKDWu2XD8v6QZAd4HOcJ
         FeU93pmfNqj7RKCXQdBVIK9RYUDlqGHMRIeeo+IU+fCBtDgfNLAaG/sxw8ppBOwO4qOb
         PqfBX9hzXs31uTrydN683EN7hR/jcSSnHHq+iPKPl6xa4nDAGoN1T8sohBU6ApC98N0c
         A/5CQAr+NX0yP8Rg29YE8/JnQZOyjWTeBDpsL0y27H7yUwhBhTapu8xpQ0ObC7QA7QW7
         ODJfeAa4OYGdv1QOnOayL0PCrHwRshxXTjuM2A18ZJUF2tWNmJ3SgedaEaHMMxiCjw2x
         tVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720581385; x=1721186185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOn0nNGwyICF+4LqjztD1biSMwmWZXfSkdW3laYh9NM=;
        b=jQLFFcSqiiczDbfDiewM6IZ6UCQlV7iKrKLI8B2iJI4R9gfuCrh+D04E1GwtMJ7rA8
         CZNPKqTmLmmNEU7sM+Uw4klayxTiHWFUH2TarzDMEiL3g5SKnyl0T/VA4WcimAmdgDIB
         juJInqX4bbREhLzVvERGMvr24JUHr3OqRU5DuwjK9cChBlRAD0TPH3qsdEogIfqQSjuE
         bF3wssZOvA/CTzMgdEea0lMiPrv0ADuZD9RE1S0in3LiF3454pfIluh0Ys9uedqDydob
         IhvroLAlVMEiIjwN38bXAtCVRFyph/z6Opvj+7Kc8etHI0Aq3ouCRy4lQ/BZkBwtCS4m
         eCNA==
X-Gm-Message-State: AOJu0Yy4M/0BnaGuqGNVzoFfPFDk36DUjvQDGsqityWdb+faykKQVTpq
	FE2XQocIa3MUVBgPnoSbz6H3z1OskzAE7gw64ozaBvMd8OLhecVk
X-Google-Smtp-Source: AGHT+IE6zhOZD5BRcy/yslpciQCPU64Yckd/Mwqrw39YPSMt88Biox5JzVU4VG9UT+VnsdIKtDW9VA==
X-Received: by 2002:a17:903:1207:b0:1fb:38c0:172a with SMTP id d9443c01a7336-1fbb6d25258mr37824285ad.1.1720581384529;
        Tue, 09 Jul 2024 20:16:24 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab6e35sm22891905ad.131.2024.07.09.20.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:16:24 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+621fd56ba002faba6392@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] [s390?] possible deadlock in smc_release
Date: Wed, 10 Jul 2024 12:16:20 +0900
Message-Id: <20240710031620.58099-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000031c6c50610660f17@google.com>
References: <00000000000031c6c50610660f17@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index c5f98c6b2561..e7ec066b0d6a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -294,6 +294,8 @@ static int __smc_release(struct smc_sock *smc)
 
 	sk->sk_prot->unhash(sk);
 
+	barrier();
+
 	if (sk->sk_state == SMC_CLOSED) {
 		if (smc->clcsock) {
 			release_sock(sk);
--

