Return-Path: <linux-kernel+bounces-215593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068B19094BC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AC71C210AE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEA188CDE;
	Fri, 14 Jun 2024 23:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HD8mqMuW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F30187564
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718407221; cv=none; b=GGv7d+P5ptVuSB4N+vd0r4jH880BtnvsCelAnm96bvYcaO8uAzsRMa4PCwFq4XfHqtNfHcMpjtNBDBlgZSXx+skpfhyQtRifrwAfAPM6i3mtF4LF3RElboeD8NafxKlpwO7qsVSrk6rhV95fK2/OLNHMk1saSC1fbtAc16Ffc/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718407221; c=relaxed/simple;
	bh=fE+zch1A0fER//ZeqLa0FIQN/MTf/MxLy4tm3XMXweQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jcTxp8AAbixhOoyryqw7Sk3PoXVe3ixNlEp8ZuqE9lGZBPwL4y6pdvzyxVzc2ea0sFAiLsorpscY+N9AmtgVGe33qFsIUSmo6DXwPdTlKw6xHeY56ZnA2zfgCdhgsldYg2G3QvUyGYlGC8k0VJjEfW+qH0SIMW1Xz6zQLnQL3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HD8mqMuW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f7274a453bso24253595ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718407219; x=1719012019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y1jfDzVoRWL6KaPZWMODA9UkUSVpf2/HdHd6Xl6DV5k=;
        b=HD8mqMuWdYTpGuTQa+ubZGTNltZCuxHHSe7kOQ+kbkt74jRB4pIMdgyXF7YDvHjutO
         yAsqDMBmg5jq76Ue7/UkRvIviXbRNSQGcxfK4HlZDbHvuuMxtHmbThCw/XgoqGHz6n0l
         UPX/YNWgd4gOGET3RKldNrRUa/IdIuek0MdOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718407219; x=1719012019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1jfDzVoRWL6KaPZWMODA9UkUSVpf2/HdHd6Xl6DV5k=;
        b=HwyOo9/ywi8fsNadsaij8rxz1YJsdI6Vc6EjUFEbXWgyubtAFB8F6zp6UyBgznGQSU
         SEPV9dPKdz2/dMAi8F05Rpqecvxj7s9MYomBmt2NI+QZkVPot3F7CMglrkU7optVWIU0
         eNNd2IiiZshr2rje90bCIdjughzPHu1EFJsy2H5V5W+jZqPzS4Fd3p75osk4P8FV9slk
         4HBPMFPBQ03z3gRNYnC27UPUUTVkb+yS01ffr9Th0VWR5351usPYgNK096+MVaxSB7L6
         s1uQYYnXtjk8dhGK+fuU2Zoh4aY5tYa0DFSnLtXcBdQrzCGreztftiu11UKtkS50u9tt
         lsYg==
X-Gm-Message-State: AOJu0YyhqdSCSNLqlKhaH1uE/SqCdFrz+1VyJXj385AC+nssVi/TH9FH
	B5SxDcSYEM5wlWpnlc5ORen3Ch5BemAzQapbZF2yQbMdT5lK0+NQuocm14RZHw==
X-Google-Smtp-Source: AGHT+IERw4c7rhqKagYrT0QDL7TZXNuH6UtS6fzakLigo0kTD/Gdb3QvsSoQRs+yi1aji+repoo/uQ==
X-Received: by 2002:a17:902:ec8c:b0:1f6:ff48:1cd9 with SMTP id d9443c01a7336-1f862a19a0amr43837785ad.69.1718407218809;
        Fri, 14 Jun 2024 16:20:18 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f855e5bca2sm37983005ad.17.2024.06.14.16.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 16:20:18 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	jannh@google.com,
	sroettger@google.com,
	rdunlap@infradead.org,
	david@redhat.com,
	adhemerval.zanella@linaro.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2 0/1] add mseal to /proc/pid/smaps
Date: Fri, 14 Jun 2024 23:20:13 +0000
Message-ID: <20240614232014.806352-1-jeffxu@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add mseal information in /proc/pid/smaps to indicate the VMA is sealed.

I appreicate Adhemerval Zanella Netto to bring this to my attention. [1]

[1] https://public-inbox.org/libc-alpha/743ac2ce-817b-42ef-a0a1-7edf9a85d8e5@linaro.org/#t

History:

v2:
update from Jann Horn's comments:
- change 'sp' to 'sl'
- change 'sealed page' to 'sealed'
- move VM_SEALED define after VM_ALLOW_ANY_UNCACHED

v1:
https://lore.kernel.org/lkml/20240614182327.752156-1-jeffxu@google.com/

Jeff Xu (1):
  /proc/pid/smaps: add mseal info for vma

 Documentation/filesystems/proc.rst | 1 +
 fs/proc/task_mmu.c                 | 3 +++
 include/linux/mm.h                 | 5 +++++
 mm/internal.h                      | 5 -----
 4 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.45.2.627.g7a2c4fd464-goog


