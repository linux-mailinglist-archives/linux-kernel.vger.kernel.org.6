Return-Path: <linux-kernel+bounces-320026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC6D970529
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186A11F2206D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A444085D;
	Sun,  8 Sep 2024 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBXItw/b"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D944F481AB
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 06:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725775778; cv=none; b=sfEdoyXw4RqtDvcaw0+UP3U2NCImQ96O1Bk1l96bc9/BS+9mRpN3Rrd0FKfKhvPNxwGSaHByI5YKxJtmg33Sg9Y9KW/kC0cwPKVH2dvWT7KJhs8qIvgSZspSxV2KNIa2lj3RpqHLL8PI6ChPXBNCqIKv0SAHTjeoJYk62FVW3PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725775778; c=relaxed/simple;
	bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eWsM+nkBfRmF/WS+AgJ1BFQe79e2y3XL0s5kvxpNv1m4gZxwjz568jeLTNQk+1RyO3xnEbTEJQ+1g0uQA8FBmo4kPBm/WErKKAXaPu58lIuTO6KFLU1YxX1LgFD7w+bXU5VLvRrhsnhQaDN5kaU+IGIksyCAUKzpWGlUnjnnLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBXItw/b; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d89229ac81so2619927a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2024 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725775776; x=1726380576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=PBXItw/bbifzT2HpHo9oFzdeeuseLYdDybd4G85sU+DhF3QCm6acYOjvuvH6Tl7Aru
         RLvKMqrALFfg4l2Ap9OT2fWT3zM5ov59S39nhpcpa6ntiSMxod5rfIeY0pC2+45Xk3FK
         2EmArGF6WGb2VhzNgrtLgYfRUqOACTpWl/HwDLP7nGIx56KP26+wj5jajF8cwYB7fBzf
         yB8w6OJgATmfJtp1EXRs0x3ussa6SWcspClPnZYq8ByfMd/9cbQ592G3eP4AC6MRN7XL
         kq+5pLsoU98I9c4uJO5Lpf8oUu7WJ4zNf8Q+fSl2BfGVCosBjIG2NOjhYw+cBtmzUMgt
         2BtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725775776; x=1726380576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XRYe6k301hVMrjUu3bWA/ITB1UE99EqwDnjHlWIAJ5k=;
        b=pXvLXVEzJ4q6i+/2DvrAmrILGPMPucLw+a017O79KzPRy51dw0Ho7Yfs4yfSWwHdoy
         avn+pDlueBq2rhfnQdiurGLFqk8Iiuu+As1kl0rlljJllOs4dnfw4F39JIRR6R+2S+XB
         FUiHwlBJC/ncKrt2WeUZF+Z26eKKysM1vp1Yp0jjHcnYVonVvRedm5snVlnBhpN/GScx
         oDLA9MlrsP3Pal+8fSDWP34ibVfaXDOTAwt2HPsJ9xHFFZpmFr4mTJG1BA95VV5Fic0d
         SNWgpb0/Ge84T9wLP2af24USRs66QZeHnQO5FRRYjQ+mBXkBAK//IY1gd0ZrGoYMsEd2
         CSMQ==
X-Gm-Message-State: AOJu0Ywx2YKrj58yQ3VTlbg3E5m59cYyX1VaNFbZiuzAv14nCPHJxsTT
	49cP3OrkojtG6M/sH0Nrv+5Ee7NOluiPq9IU6jQznQx/keJiDMEe
X-Google-Smtp-Source: AGHT+IFcUzBqblBkFQTOyIbdsV1MRgVfAlZJNB5igX4QZWjg1U5j7gxkYzwGc0ChKWNNDCACtgrERw==
X-Received: by 2002:a17:90a:668b:b0:2c9:7ebd:b957 with SMTP id 98e67ed59e1d1-2dad4ef2364mr9905619a91.11.1725775776004;
        Sat, 07 Sep 2024 23:09:36 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db041a02c7sm2184525a91.19.2024.09.07.23.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 23:09:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in generic_fillattr / shmem_mknod (2)
Date: Sun,  8 Sep 2024 15:09:31 +0900
Message-Id: <20240908060931.7380-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

