Return-Path: <linux-kernel+bounces-563129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD9A6374F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 20:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A5B3ACDA9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9911E1DE4;
	Sun, 16 Mar 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa9csliM"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC41A32
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742155100; cv=none; b=E1LNgcCkoNAkY9RTj4OA0xZKx8Wwz6IR+BIM5DVGIPgMTiCTAq9VS4RfAhNyS4TM41OUUFvlea2zZYLIpefIocNkZrqCkeLwXPr6gw2ylZSXzG8vLeymhmFIGXgu2KvgfgphbX+I41UUPS3vwetOnich2+n02ANIAIR/pR53baY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742155100; c=relaxed/simple;
	bh=d9h8ZDgTx+QXpfobmc75oATgIFSX8tIHUXyndWxSxHw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L8q/va3LxQzhIOHsW92NdRUcT+UhPIFDH1w4YaBRCySQaRdtUcL6MC7jBr6tnLf8WyDwgJd4qJRahyunIyVx2VDIuBP16lO/EfaVJgICRW0tkhDnvr9R7jxAaeMl6i4NgeNWEivMNgQ3MPC/6bpVX8WzmjkUVrkMRapT0vFUO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa9csliM; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3061513d353so46037981fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742155097; x=1742759897; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPylbQjp2yy0BGqionSx3Sw1ls1WZbx3kMeDWbWBa9E=;
        b=Aa9csliMRFAKe3WHVyjEhgA8oNhV85okk2JIA/1EM7pa62ihObOJmgtec6LZV1yEOq
         qsDrzr+XiokvG/4b9sOPg5wKUxrWM5UFI08MPv1GFKZqO6mb6h/KXB1PAEtWku91kn/K
         nTC6t0wtn+hX3T7pi+bzTVh6gLBoQZwZIC29SoPg5P32OMrA/pK7VJpVIVXuEHcCPQFp
         DpHfYT/UkkcngHCdjooH6THJf6glk4CUOLpnUBe455QKnjpnidH8YYql2+9UO62SCG/r
         B2Zrj+j5C+gm+dF2jRhTSN6NvNQRpMf/JFU6km83fe7C1ppTt8ZvyPurJTI5U2b07mdL
         ugxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742155097; x=1742759897;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPylbQjp2yy0BGqionSx3Sw1ls1WZbx3kMeDWbWBa9E=;
        b=dIzkBrwNjMnEzxUjomFAqnOYq7v4fekdeY6Q1eWp5tXjJy2Lz5RPqzV2TjaPXbFVY8
         GOnUpyqRVQ44urO7TmawUbwEukLZIaxGNkhIcARbnIpeqiFuWWZg1SxLD55NOHSCNsEq
         05Ds94U6UBBBL275KfAk2vRyjrRt4Q0ug5475UoaYX/KdRomcmz4LDUnQoLpnCDc5aZE
         N3X/EeoZ15XXLI8S2+OTBLgKjebk27y6YdGbQdKZQy7Ca1dE0EFoEje4Z4Uf5BPOY/L2
         ct/YQThCZSjuvLPYewyjwir7NDsaLxZsW93H8F1W6PflJKGzsQf7ZXyv5hU1l6kw3+4C
         8BUQ==
X-Gm-Message-State: AOJu0YwqgYtxqp1m4I2kr2xom/Mgw5fe1aEwVkFod9rC/d4klCZVnha5
	IcCnPfvMMIuuInttGo8JQ59q7e9AvEKOaIr4FTNrYSrYEe99zgeawADn/lPW
X-Gm-Gg: ASbGncvSbwuTxvPgslxDmuFf4Ebrc5yhVUaI7mNeiw00xh5dYs0j3yZ+Jo/nEhcIZD1
	WEnTaZ048qsMG82rRgwu5i2RNBD6NwKePgLuJ4uz8AvJx4LUcqhHVLIFHhzND7HeDNEOAKw6wuO
	/5Y0YKu0N/crOSDKiIpFWNWk7TCLE1FGhZ9rtAkLQLNtbuLvOkyAB4YhgMWsKda3n1A44bZZ7JQ
	CYXlP/PIRM/GGB5f4KGpXumy4qcqF2ddSnPvKWql5S0xq8mQmklzYiruS0stmSCoBynhJ80QV1r
	OVjUmKr7otVRo6iXB1n5ijI2XfiP7GGBYID8GTk+W3wDrA==
X-Google-Smtp-Source: AGHT+IGmR+wtQZHtwLz66f8aLMUG6t0BhsyqX/k1siO17BEko0ui15DfcMy4WFqIxnePyxDRUkhPHQ==
X-Received: by 2002:a05:6512:3ba5:b0:549:8f4a:6baa with SMTP id 2adb3069b0e04-549c390b19amr4896921e87.27.1742155096562;
        Sun, 16 Mar 2025 12:58:16 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba7c2558sm1157267e87.94.2025.03.16.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 12:58:16 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 8F97C5A002E; Sun, 16 Mar 2025 22:58:15 +0300 (MSK)
Date: Sun, 16 Mar 2025 22:58:15 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] posix-timers: Drop redundant memset call
Message-ID: <Z9ctVxwaYOV4A2g4@grain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.14 (2025-02-20)

Initially in the commit 6891c4509c79 memset call has been
needed to clear the memory allocated on a stack, then in the
commit 2482097c6c0f memset call occasionally sneaked in regardless
the fact that we're using kmem_cache_zalloc to allocate a new timer,
lets save a few cycles dropping this call.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 kernel/time/posix-timers.c |    1 -
 1 file changed, 1 deletion(-)

Index: linux-tip.git/kernel/time/posix-timers.c
===================================================================
--- linux-tip.git.orig/kernel/time/posix-timers.c
+++ linux-tip.git/kernel/time/posix-timers.c
@@ -526,7 +526,6 @@ static int do_timer_create(clockid_t whi
 	} else {
 		new_timer->it_sigev_notify     = SIGEV_SIGNAL;
 		new_timer->sigq.info.si_signo = SIGALRM;
-		memset(&new_timer->sigq.info.si_value, 0, sizeof(sigval_t));
 		new_timer->sigq.info.si_value.sival_int = new_timer->it_id;
 		new_timer->it_pid = get_pid(task_tgid(current));
 	}

