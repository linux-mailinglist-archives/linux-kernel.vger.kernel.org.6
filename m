Return-Path: <linux-kernel+bounces-176913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632A18C36F5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689691C2089C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA639AF9;
	Sun, 12 May 2024 15:21:16 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB71E488
	for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527276; cv=none; b=b18b2/qHU0YRcgcYm0wFzcL/ZhexSiGlz2TazKesSTKhLI+nMolErFqS9tOIndhPJQvwfWz9zKHdj7SvXL6/ukV7mBQwa3rZymnB6Qk3LAFCR/KRTlvhf6cJ/JI9vgpSy/3Y54qFuXYA1cQdQMKVoSQCukTyD/+vnILtupqR6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527276; c=relaxed/simple;
	bh=elmrxKgW0hKaxkMC0fP+b+IajaE8KGVrpSPp05jxx2I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rlepk/krsRY111KY+e3oITHExCb8hPMUtT0zzjeh5QzxQ6DKbkVHhJ9PEgNRW6qokl2XeDZZRkFjdznOUFGNWGdpewYAHbxuQqxuZf8ETG/v+TN3pXTesDGLWJtNybcM7hLqRQNTcjISC48kBAR//Q4Dnbn3dJ1qgzDI5SyhZbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d9fde69c43so414598139f.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715527274; x=1716132074;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoS4jnpTBQZakglqbSVS4edXPZosbzQzuVKYSBONQRc=;
        b=GQsLAjbRGMk5yiIhfKXu8MslXRlS7DoYTuI2UT2ySDA7jc2/sVUmlL7chNf1p+sCFp
         rzpmDaR1gcGVjgA4pap2eV20/BiKMAGizzECV8Hocqf0527SJJ+dy+fVNPchk/d4udif
         7WRV54OK8a4HMbi4UNojbrEYmFPWWui7KgGCmKhFaRXQqPuL8Vzu6IaGPtUeh9806sgU
         ET11pi29an0T6umknLL5vGRt2hcY+aj7ESizpTSAI0+OsHIgc0kCKiREOkFbr0cPSu/z
         3+zfit65jiuFrFRpA+cO5Xqwf6co6iU3Bas4NcZhGY9R1bOl7e+rthbEoZwhsRd/+LjX
         S0GQ==
X-Gm-Message-State: AOJu0YynZVj1XAqqppGoCs1cLRsuYY9MSaLpZB4m7fvp1ObaITQ8OmXb
	XE4TGlC+UwIsO3PfYiM8LIXGdIt/pAw/sjEJtaZw4CrvM6Y7rj541Hrxei7B3567PIWDaSu9ClJ
	CV5ZUr13fQfoljSoBn7hu/b9UCVkEqadJRgCdSSooKST6DhbWfHTCp6Q=
X-Google-Smtp-Source: AGHT+IFS+nZOZ4a1iPKBwKvPMi9y6R6UKo3ShCBqMvOtCA+x03FKCadtRtgRGfbeMzy6n8GiPlPCo0AGdbNEM7V4uOmpPv9/4JZM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b8e:b0:7de:e16b:4b81 with SMTP id
 ca18e2360f4ac-7e1b5209a83mr74857739f.2.1715527273867; Sun, 12 May 2024
 08:21:13 -0700 (PDT)
Date: Sun, 12 May 2024 08:21:13 -0700
In-Reply-To: <0000000000007e4a2e0616fdde23@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2fd68061843519d@google.com>
Subject: Re: [syzbot] Test for 5681e40d297b30f5b513
From: syzbot <syzbot+5681e40d297b30f5b513@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 5681e40d297b30f5b513
Author: syoshida@redhat.com

#syz test

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index a6fb89fa6278..df01628c6509 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -344,6 +344,9 @@ int j1939_send_one(struct j1939_priv *priv, struct sk_buff *skb)
 	/* make it a full can frame again */
 	skb_put(skb, J1939_CAN_FTR + (8 - dlc));
 
+	/* initialize unused data  */
+	memset(cf->data + dlc, 0, 8 - dlc);
+
 	canid = CAN_EFF_FLAG |
 		(skcb->priority << 26) |
 		(skcb->addr.pgn << 8) |


