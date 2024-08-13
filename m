Return-Path: <linux-kernel+bounces-285550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2160B950F85
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 00:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C251C21E4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC771A7059;
	Tue, 13 Aug 2024 22:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2BDpBb5"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C123E25776
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586636; cv=none; b=TaEPB9qhC/jOc96g2z9qrlAEEc1JWyNAyhR0Lf1mGHundP8F/wLWFZXBKFsINqDUBbG2jwSPK+i1Nw64WTly9bL3DWhuwa8JVbjDtLVIskXocMMeMH7xMzaBsqgGUErsZVTnVUbSa2LlGMGpe/hkv5W149Y7TbHJ0VOalQ5kuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586636; c=relaxed/simple;
	bh=aaU9ZsjvdCdHZPr5jWarSFsx8il8X6PLrkpR/K0E0ig=;
	h=From:Message-ID:Date:MIME-Version:To:Cc:Subject:Content-Type; b=HV2M4e35QFjkvUb+iaYbgOpN/FjMA/GvHakSzaGFfLRPz9OS6TswUa3SgVHKLqjxAgglxizdHSC+j64hbyhI2aXMwZ/kUcskGkRiKDOLFUOkru8NM2Dw1h4WeTemRsxaNxqMDOhwBgWS9C49XBaFZpDh6Nemc98L8ersfErjPdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2BDpBb5; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f01e9f53e3so92277851fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723586633; x=1724191433; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVYMxZiwTvGM+pR60d7nKimOWP6bFfK8SGTCENiivJw=;
        b=c2BDpBb5fse/6w50Va6bGC29stV7Fl86KvDEVVrblkeQXXs4/voFbh7qmDYwkvK+9/
         ei29dYuFbNcI8k4F8peFy/2ltkzLn7qD7FHrkY8bdZXHGz1pXwcWlyoUJNkkrcT0D2iy
         2KPdQKKdZB3J1oPM5SQD1+ff2ddgPSKtVN13zzwiiDCJJInwTAwDxqILsTMh9g7lNkL5
         x8Xi6CILnjSPVOi5Vgm6bxq8NWjdrEZgGhK4Un/pBofC0EqjqdZKqp7wsUZNMuxc6tVQ
         VLV3Ny24Y6lGGpC6Kni3QkoG8ubTiD5JUxX0Xk/MZOJFvH3uaUG/rPQ5pPx4PjKlzv6r
         M5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586633; x=1724191433;
        h=content-transfer-encoding:subject:cc:to:content-language:user-agent
         :mime-version:date:message-id:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVYMxZiwTvGM+pR60d7nKimOWP6bFfK8SGTCENiivJw=;
        b=GphTG7lc0TTFI+608W/Pq2MEXNENi0RI36qYfHQZ9Zs1zxwSRT3dol1uoh9bL9woun
         rd0/N0M3tllUKeeoWceXFFpmxSxTIaFzo43yapYH2trjXA5/NkjyQEcl1i7dzutSMbdR
         kJJErp+2X2jXeE/KlGnIZOiHsZGew9ny5hhtoCWNHMI2bNZTsLf4MrBdJdpMRt6r/qCu
         IGBuP/4jjpqpgs6b2PdDPPfP24dZYJyETzG2uVJxJgO+HkTw/jNMCtAbpg2DLHZAMIJF
         Om5J0WyB8PwbFLdZK/ZRBi8s4GBp3lKVKoI4AV0a9Tupa/GxeqB4xhJ2I8MVJP/Neei8
         QVuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1nQZ8RPlAi505KSp8/ibk22kva7nsKU0Drztek0h3na2JnwOhcF+SbqpOYt3OsreqAsJRV3dKNd96nGz5D4NpJz0nd3tsYZ2G1yc3
X-Gm-Message-State: AOJu0Ywn+sHxYRR+SbAJxKeSFeZs8WTzWf5xu15FcTED+niGsQQbKzvp
	x7JhDa9PLUfa39pXH3TvcNp0ZKpFLg8Uh4oq46ag/Y89wtnnAgOqOIJkmg==
X-Google-Smtp-Source: AGHT+IHAirJiRbuaKJfIaLcSMY0FQOkGvPpl0k+WL0+L5conBTKZH50c1yGMzrUTMRGtwAmCw8fwmw==
X-Received: by 2002:a05:651c:198d:b0:2f1:922f:8751 with SMTP id 38308e7fff4ca-2f3aa04e7a4mr6530531fa.0.1723586632258;
        Tue, 13 Aug 2024 15:03:52 -0700 (PDT)
Received: from [192.168.178.20] (dh207-40-227.xnet.hr. [88.207.40.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f411b506sm101763166b.136.2024.08.13.15.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 15:03:51 -0700 (PDT)
From: Mirsad Todorovac <mtodorovac69@gmail.com>
X-Google-Original-From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Message-ID: <b604b19d-c548-4795-adb7-3d0736b8b560@alu.unizg.hr>
Date: Wed, 14 Aug 2024 00:03:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: =?UTF-8?B?W1BST0JMRU1dIG1tL3Ztc3RhdC5jOjM0OjEyOiBlcnJvcjog4oCYdm1z?=
 =?UTF-8?Q?tat=5Flate=5Finit=5Fdone=E2=80=99_defined_but_not_used_=5B-Werror?=
 =?UTF-8?Q?=3Dunused-variable=5D?=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, all,

Now, the "randconfig" seed KCONFIG_SEED=0x44AB31A6 revealed another bug:

mm/vmstat.c:34:12: error: ‘vmstat_late_init_done’ defined but not used [-Werror=unused-variable]
   34 | static int vmstat_late_init_done;
      |            ^~~~~~~~~~~~~~~~~~~~~

Apparently, it is obviously wrong because it is used below:

Fixes: ef534a0d51984 ("mm/vmstat: defer the refresh_zone_stat_thresholds after all CPUs bringu")

#ifdef .. #endif forest might be better documented, but this small fix makes it running
again:

-----------------------------------------------------><----------------------------------
diff --git a/mm/vmstat.c b/mm/vmstat.c
index e361c2b3a8bc..85b3fc0084a8 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -31,7 +31,10 @@

 #include "internal.h"

+#ifdef CONFIG_SMP
 static int vmstat_late_init_done;
+#endif /* CONFIG_SMP */
+
 #ifdef CONFIG_NUMA
 int sysctl_vm_numa_stat = ENABLE_NUMA_STAT;

--

It eliminates -Werror=unused-variable and compile passes at least:

  CC      kernel/sys.o
  CC      mm/vmstat.o
  AR      init/built-in.a

Hope thi s helps.

Best regards,
Mirsad Todorovac

