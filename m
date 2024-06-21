Return-Path: <linux-kernel+bounces-225206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1B7912D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662A2283C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959D717B419;
	Fri, 21 Jun 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcQASuxR"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505A58C1E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996095; cv=none; b=VUM2fP6U/m0gWDu5C/lOwmkJUliYlIQPB1MSQDz/0cda44QCptjJ7sZSJb7j4CY8zlBkctrPi/30TSPQJjleRLYRFYL1DcOdOXBbgQmewrX6osgMHZrBxyKRxQ98EGDfkqCGzHv0b/ERo1NCmk8RAEe0mJ7An5m5dYx8d7uufeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996095; c=relaxed/simple;
	bh=ivX5fX2p85CKHxclx7krXad6/Q3yxNvxuPpBL9QM+aY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aWgLSDxmElsIagsU0xVHnoFJh6rZZoDk8ceTZhrWlE76wR5ebjSQ6Bog07z/SK/p7iK2F6dFjWH3JdOMVlBhajZ9IhwLZbk1WRQpoGmx+jKDO8uIW5wzFkfU8Rzs2Mujh39ohdIiyQ9YCy+X2rgC6oj267tnU+EFRieD1aTg2ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcQASuxR; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cd8897c73so997651e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718996092; x=1719600892; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lyqC06Vh0EYg26nHAQaeApBBTUbal6sAGqlLXIIM1Eo=;
        b=hcQASuxRYxpsmvLgKvMHv86u7sOTi07J+dd2vcAfoGvBj/L+QcDqVCsyhnhdQKXocx
         DUXjBOkCrrIO+hD4JfJy2dcs15Qzd7Ok908pZ2OL5dQUdF1qz5J7cJzMii9nmylAz+5q
         k1y3CreHDW6AYJi2rYT0v1qOPuaogyT2FI9OjwH+NKo+zEseISaI+uNaPb0BiC0v6jX5
         r27aasJqpiNOESH+8pU/QjzL++zyvK3rJO/ZSVC2p1/q+YtC+Mk3WYMK9pI0a6NG0xIs
         OISNCtVsSHQ6QILB+PohULmvMR3JgBiaJoxDTUuzECIskNJMiCCZ204FSUJZ5s/6/jtm
         jLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718996092; x=1719600892;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyqC06Vh0EYg26nHAQaeApBBTUbal6sAGqlLXIIM1Eo=;
        b=HXcMu18WG6lWoi/xaVMEmQwme4mxu10du08nHRlU/UIROqDEpqo0pXfaBJqe2qL+Cf
         rdkBl48gXocUb7OskyqQk+N4jMts+tNqcIj19Qn5DH8zaKUz7P6MdRqSUrXRSI+Oz5Du
         bZhIuebyqczbYB+a3fsnmAADT0XK722x0YJqMf+zaxfNOzwXvj/oCniOpzSNtEf63bKF
         9IQC/FYyB0CwMiNcWyL1wtB+ls/RPQD4lyyMJ9q35BhY9caww1Jz1MgT8EmCHqYLzokW
         n7oKSMLx3aIzygfzS0m0I3GRHoPsdsQdKrgEv5E+oEwsKfWO1F0kaqqdyarrKg34f8yA
         BTkA==
X-Gm-Message-State: AOJu0YyQ0KGiI0pDbwYiJzMpCxutcOLRu1QXuBlVzjbZIxELRM6dJD2F
	Ui6dvz5nuZ8/jKNQZTIeNpfCKtsA2RN1/X4r9oUoT/w51EGM9oLZhwI+
X-Google-Smtp-Source: AGHT+IGO3w51n4SoCZschdybkDyWkJJCUQM2g9kbc3Bm5J+AUw9OWnStcrfbSd+cBj6Bp0jMK5cUSA==
X-Received: by 2002:a05:6512:3441:b0:52c:dc70:ebf8 with SMTP id 2adb3069b0e04-52cdc70ef1emr503637e87.19.1718996092259;
        Fri, 21 Jun 2024 11:54:52 -0700 (PDT)
Received: from p183 ([46.53.254.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d303da3cbsm1277429a12.16.2024.06.21.11.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 11:54:51 -0700 (PDT)
Date: Fri, 21 Jun 2024 21:54:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org
Subject: [PATCH] ELF: fix kernel.randomize_va_space double read
Message-ID: <3329905c-7eb8-400a-8f0a-d87cff979b5b@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

ELF loader uses "randomize_va_space" twice. It is sysctl and can change
at any moment, so 2 loads could see 2 different values in theory with
unpredictable consequences. 

Issue exactly one load for consistent value across one exec.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1003,7 +1003,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
-	if (!(current->personality & ADDR_NO_RANDOMIZE) && randomize_va_space)
+	const int snapshot_randomize_va_space = READ_ONCE(randomize_va_space);
+	if (!(current->personality & ADDR_NO_RANDOMIZE) && snapshot_randomize_va_space)
 		current->flags |= PF_RANDOMIZE;
 
 	setup_new_exec(bprm);
@@ -1251,7 +1252,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	mm->end_data = end_data;
 	mm->start_stack = bprm->p;
 
-	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
+	if ((current->flags & PF_RANDOMIZE) && (snapshot_randomize_va_space > 1)) {
 		/*
 		 * For architectures with ELF randomization, when executing
 		 * a loader directly (i.e. no interpreter listed in ELF

