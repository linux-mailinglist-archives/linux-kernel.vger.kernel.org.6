Return-Path: <linux-kernel+bounces-256839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60706937115
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09ECA1F219C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4A6146A64;
	Thu, 18 Jul 2024 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTaNz2YH"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6239C80C07
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345053; cv=none; b=En5R4w4iAZakEPlt271a+jHzXJls0tJcq60AEuJDE+kUuIco+2xyz3N9xqVOdWTomcMDevfFiVEKQsCC5m95Dtyp7GwELG9ksVLfBQJ1fBb3tm1s1aAYhKWYHFiAkaJKXynYdEh5C8DW5eCa8YaFDRUwjvpb7Zz2xIq5wS1F7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345053; c=relaxed/simple;
	bh=9/PRQnT6m7ZKE4E0lTCWt3wr0JNjTQcZeKQYDcLzk1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m3dTaPOXOS72mU2Jk7JDXnt2Ep1aeQe3hpMw7DuNhz/iYWvIUa0YejmBh1OLPJSyTtlWVjKKHNrGv7S0ZBft3hnNWoeeEi5Fxm7Qje7wIOiLO/47cVTTtCkrM2JHucQ9ZwGbPzShd7c8Gpx1UucyPUHG+G7+ek/4umjIaQ3PRXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTaNz2YH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b0e7f6f8bso310916b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 16:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721345052; x=1721949852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7RzpzbytVKsMSo/gRdZ+hmuL1xtdjhM/yZEN5JcVuc=;
        b=LTaNz2YHimgA4mUd5c4rggKYGuqlLIC55pMpveUCIbu+3IphH9V5heDnWcI0g4TrfG
         TaO6zHaci7vkAG+Uon+zAxZD4vRNX6PWhI2taJlr8QgZekjThynZ9brcILSpI82SP6Z3
         DGgeSWR54n1Y0PtSAdFPp6aCN30b6pkoqni/rAmnqBQmXHJn6pYeELOUtJeiLwWqG+mN
         fv2rokqCwaEeTnNmJ+9+CUoPTOkmhB27mZ3ljDZUqOSGEJsjl/x/IXjiZSUJXoSEmyPJ
         wNq6ldO1bTt6zn0pt+QD4+ITKPJx1PZd9n2ZLhdhdLJrmTPJn6C8N1AKsYIjfztdPygM
         I1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721345052; x=1721949852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A7RzpzbytVKsMSo/gRdZ+hmuL1xtdjhM/yZEN5JcVuc=;
        b=lVeeBHwQ/ubczoPNkEcXkqE2goNXI9E4Hr1QufjX6OSIx/askeQNClOcS6pi9woI7i
         DIzAGBSoEm7RZ/J08zIy0uCUQfU9cHATxecmrPL6llDDOk5/6RJRhNLtRhwqyNyr1JHm
         G1sWwLX1f/3JPxSGxu0u3aicz2yzmNT+Cngl3U2iFKbX8TZdC40Jr2yhd8v8LnTFYLrj
         Xa491h+x31dBlzL5jpA0WDGlg6R/l/DFZvI3UoBxOZg1RWtcOkngLCitNN1VpHjmunyG
         akZiG0JvhuexdmhTawwOUbpy8cKOPm+8cuTY5BMKbrcvo09KeG70flxulrnDc094WcV9
         vHRQ==
X-Gm-Message-State: AOJu0Yy9a8GNC3AU4bRDf2kVc4+KjQDVXjWnyhVpaEby5Zff/5ApGCEO
	TRMWNUN5P30Kb5GN8RpWqOyfMYG9L1vJK/J1iiloexmusdGWEMbD
X-Google-Smtp-Source: AGHT+IFEZEJlZHQ6nRQ+rLXZagX9/cZasKpy2HZWh7ZN62fvMRuxwRlDLN+FQLs0/XvO+qXZInsn1A==
X-Received: by 2002:a05:6a00:b49:b0:705:951e:ed84 with SMTP id d2e1a72fcca58-70ce4fb0b69mr8517808b3a.15.1721345051527;
        Thu, 18 Jul 2024 16:24:11 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff49153csm84314b3a.16.2024.07.18.16.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:24:11 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
Date: Fri, 19 Jul 2024 08:24:07 +0900
Message-Id: <20240718232407.69028-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000004a86bf0616571fc7@google.com>
References: <0000000000004a86bf0616571fc7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index af474cc191d0..2088b566d10b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2895,7 +2895,7 @@ static int virtnet_open(struct net_device *dev)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (i < vi->curr_queue_pairs)
 			/* Make sure we have some buffers: if oom use wq. */
-			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
+			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL | __GFP_ZERO))
 				schedule_delayed_work(&vi->refill, 0);
 
 		err = virtnet_enable_queue_pair(vi, i);
--

