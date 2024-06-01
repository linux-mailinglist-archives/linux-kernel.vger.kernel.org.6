Return-Path: <linux-kernel+bounces-197661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DD8D6D96
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EBB1C2139F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9806FBE;
	Sat,  1 Jun 2024 02:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyFyonTs"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6759DDB8
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 02:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717210640; cv=none; b=RPi13Di3FuoRzHvtda7ZqIo+2SIoLCEqPo4uFOfgnZKojZv1/F4+MfOKdYhdHh9Dcm8t5EX887E5iNMKWPqaA1O0h32aF4HvulGc/olgXv22ingJi7jvTvOGZLWBjPYK6gGdbXeFZRz5qy2XshrSMX0lvKw8kSgA/YoePJnUsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717210640; c=relaxed/simple;
	bh=W66ss44jfXYw49cQTw3aqHq6yM0zLeS4PO8jf+eIcX0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qhvg6aO4muPTuMuhbk9/OwMVw+/t6TsJbRrYgv0AGBWKg4Gk6Kp/cco3dJVew+/AuE5a64TyYC0Vqq3dQVLYF0tDCh/cbyNJ5/LFXDsedHKX/BNffziRMGk2kSyzyfm2u/crf0gtvVkklgHjTAnPY32OrwZ0KPleXbthz12DDAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyFyonTs; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-24ca21014ccso1364270fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717210637; x=1717815437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6g0RzMq72+EjgwD7VB3pJoWW1gkEWDC8hXVu7dCphXQ=;
        b=TyFyonTsHnAs26YeThZrPR2OvUqL61psKfZKPzyaDJBYWfSaIyD8loiD+0pg2gx7Ib
         Rzf1zvM/GWKys29CquLBgbpzzMoEHZNNeIrgUQ6icbksN3gYAKDROVukjhRKo+b/M17s
         nMmmi+Y4lPfzNbmfDLukdo+hOV8/hOPPEtvDK3Asb3OLNdXl7pp36+6jDI1SoRr60sGC
         iNwiefvEKIVDBjtvwjXkTZ3vh86lunMBWbu8fyYeNWzwhCtSEcBkpZXsvrwy5RcNAvxZ
         ROD+7TPT85mSXIsdpiRwaREXqEiTidRooVMITp1irIKQj+0BO2MjD9Svleh9XGlv7SqT
         Rt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717210637; x=1717815437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6g0RzMq72+EjgwD7VB3pJoWW1gkEWDC8hXVu7dCphXQ=;
        b=RQ+zKRE8U+lr8swJVzjf0W4ccwHm2BKl87TCj+FBKocGCicdNBU2lbwX5yK/Ydtjdi
         a4yLnPrU7Gib9mptKQwSDWfHhQqM2HDnamgRI5HrjYCJFNzMVgmNC620vz4xF40Nr2mQ
         72rtrSeM205RiDK83fMWWjla/M00EYg3M6zQgeyjesYDx96Uz0fhsh8GEojKqU2lzGQ8
         WbTBLm/pQD8SGnAY652KX5lM7k6NLDZnJn42A1zpIRTFSePsHNCEOZ1gPflnCc+5NPyU
         hXvU/YWlfAIbI7aha8KLtd0U/8l+fhw7oQT0rqwOWC4JxT8YD53JzuYQ/C79oqbgWISt
         lOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG0XpF0LaDoV3dNf+JA7lmAHRFCDbh/zTryYeISgqYac1dXSXxBcpF/6Dnf7lakuhojg1l8QI5U8yX3nA46M630/vPLaUfLCxL6c8Q
X-Gm-Message-State: AOJu0Yzq+fH2WumUOyHqmEoBxh80LuV2yquwf3+VPNT5Y04wrSGLx8NI
	AUowu/Sw6x8RCbxLap04z5bpM6IXRjrhoJyZzwptB+4ydEoUlBen
X-Google-Smtp-Source: AGHT+IGAZS0BCANLIKut5FzDyIGtcZaKcQ5YilJ7KyLkjBQmdPnJI/dVBGizPg/F+4WeIJEri8LItw==
X-Received: by 2002:a05:6870:82a9:b0:24f:eebc:64f1 with SMTP id 586e51a60fabf-2508c118a9bmr4053088fac.40.1717210637444;
        Fri, 31 May 2024 19:57:17 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b300ddsm2047503b3a.191.2024.05.31.19.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 19:57:17 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: darklight2357@gmail.com
Cc: aha310510@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+13e8cd4926977f8337b6@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in extAlloc (2)
Date: Sat,  1 Jun 2024 11:56:07 +0900
Message-Id: <20240601025607.22180-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJDnv3bHUUPT10O6_M64vNXXKuvAQMGEpzQs1XQvEHpGXS0zCQ@mail.gmail.com>
References: <CAJDnv3bHUUPT10O6_M64vNXXKuvAQMGEpzQs1XQvEHpGXS0zCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks to the points you pointed out, I was able to confirm that there
was a rudimentary mistake in my patch. And as you suggested, I think
it would be a good idea to handle the two situations separately.

However, if you only check when there is a value of sizeof(s64) * 8 or
more in bmp->db_maxfreebud, the value will change to a negative number
when bmp->db_maxfreebud is 63 because max is an s64 data type. 
Therefore, I think it is right to slightly modify the conditions.

Regards.

---
 fs/jfs/jfs_extent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 63d21822d309..3d1273d35b13 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -316,6 +316,9 @@ extBalloc(struct inode *ip, s64 hint, s64 * nblocks, s64 * blkno)
        if (bmp->db_maxfreebud == -1)
                return -ENOSPC;
 
+       if (bmp->db_maxfreebud >= sizeof(s64) * 8 - 1)
+               return -EINVAL;
+
        max = (s64) 1 << bmp->db_maxfreebud;
        if (*nblocks >= max && *nblocks > nbperpage)
                nb = nblks = (max > nbperpage) ? max : nbperpage;
-- 
2.34.1

