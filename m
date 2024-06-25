Return-Path: <linux-kernel+bounces-228749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6E9916662
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086CF1C211DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D5F14B965;
	Tue, 25 Jun 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Anx5CphT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E5A1494A0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719315781; cv=none; b=ZDdMauJReNEkLZIY/kinOopN5u4BQj4tELv+DHLD4gCCJQWUu8/iIjlZQKNiGDzEiv9jHGcvvxsZZH6VX1Whx0zbCzRlQ+ooe8MYtn2nteA2/jj0EuXqXV7ID1HQOYBjkYVyfrsgzjJppJOeEzIzMUIxaWcrVPM6OaGHDgLUGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719315781; c=relaxed/simple;
	bh=VY0xOCSo/+8mFrHhC7vwEWaHNe61uAa+8U2Nxb2i2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gwckUpV0vhJjKapphGNlT88trcOAeekpGC4XZqxJk/+efHZMMUEG+PxbVKCRMkky7eYArTp4lfACZNDXK9AgFRIfCzzdArdDLGaZC2gs5sGAoRMR3j/bxDdMULUF7EgZXkPWl33UeDuWgyn0txjZtbocy6Uqe+ncl3lwLK0gHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Anx5CphT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa0f143b85so21518765ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719315779; x=1719920579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8c0efz96cC1zCcHc+6MzHkLIN4hd25Mzk7x16AXwi8=;
        b=Anx5CphT3I8RU7/Gn96l3KdePakJ/LsEXgozSA/GqPdpksu51vMHHxxqiyqFon30sA
         ZhejVs4/jN0v0qxXSr6x1Z9TIwxHxzEmj8N3Hon5kEJKFzeYC0Chd49DmSG166bHMYgg
         a2BfyOY9ufJywsxxqSAvvWEDi8tj8JOrLcGDxYfARjMUjy3kFrwQ+Agp6szD/0qexvsm
         3Ejtgbi3w3P84XFySjh1beBfSeGU1R5tbTDxglWXPA50FVOQ80Rv6L6vy6euLXpG47Bf
         lu9ukdmzLAxqidE+R0O1bz75fKh3uCTBP3VZIE/IDcCEjZ3j+GtWnHJyQ185A5LTh6i9
         RNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719315779; x=1719920579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8c0efz96cC1zCcHc+6MzHkLIN4hd25Mzk7x16AXwi8=;
        b=cV0yupW6WDjKTblWs6xcMkj0IfMytsPtHKXMi21H+gYUG5+Rv48LEMS3GPHRSYSGqn
         XK0q2pKYxnG8gp3Jza8xYiqBEIdUOM25ROrVmZi7IBL3k0PFSux5VufJAKWIcsn2n5I9
         Mi/IHC5KwkLGqM53f9EAkmHChtbM2PvhdWbU3y121zz8ntw1Et3XbhBR6TK26w4ydajg
         GU3/xPvGFWqazLKNKEk52ki7TQZaCZFdetkr01KTPIEjHDPwyPuXd62wCQM/VIhkwSw/
         SY9XAF11DCViaQyvRExUDCdm/6PNx4c2E0iW+klz29gvloK2myJk4uH1+0H7LgryPs22
         kAMA==
X-Forwarded-Encrypted: i=1; AJvYcCUo6UQGTM6wIBY8kpMqZj5Ea31md/wQIfnHhD1oDgVPKOTQ4zkugYqsRc4+z79RKJCAcG4eSd18nscPx+bqcCqLm9gtBYkmEy2LIiHT
X-Gm-Message-State: AOJu0YyLT1Wf0jChTO5Z4dqujns1fEKXwMBxC9Oct4zf1aUgz+RwVNa0
	PiUHvVZtOS7+xK6ToyBEYGfSBxQ993cEKf5Lx/w6B7iCSKmy0eIs
X-Google-Smtp-Source: AGHT+IGdEosZwEgr9/N5++mzwwLZ7Qcna0OViFD+j2Se8BUb7cOhP3nMElOMpqXnmZpiC18fPlXDrQ==
X-Received: by 2002:a17:902:b207:b0:1fa:4999:c920 with SMTP id d9443c01a7336-1fa4999cdf2mr36478445ad.55.1719315779260;
        Tue, 25 Jun 2024 04:42:59 -0700 (PDT)
Received: from wheely.local0.net (118-211-5-80.tpgi.com.au. [118.211.5.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f028asm79638525ad.3.2024.06.25.04.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 04:42:58 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Fix scalability problem in workqueue watchdog touch caused by stop_machine
Date: Tue, 25 Jun 2024 21:42:43 +1000
Message-ID: <20240625114249.289014-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are a few patches to fix a lockup caused by very slow progress due
to a scalability problem in workqueue watchdog touch being hammered by
thousands of CPUs in multi_cpu_stop. Patch 2 is the fix.

I did notice when making a microbenchmark reproducer that the RCU call
was actually also causing slowdowns. Not nearly so bad as the workqueue
touch, but workqueue queueing of dummy jobs slowed down by a factor of
several times when lots of other CPUs were making
rcu_momentary_dyntick_idle() calls. So I did the stop_machine patches to
reduce that. So those patches 3,4 are independent of the first two and
can go in any order.

Thanks,
Nick

Nicholas Piggin (4):
  workqueue: wq_watchdog_touch is always called with valid CPU
  workqueue: Improve scalability of workqueue watchdog touch
  stop_machine: Rearrange multi_cpu_stop state machine loop
  stop_machine: Add a delay between multi_cpu_stop touching watchdogs

 kernel/stop_machine.c | 31 +++++++++++++++++++++++--------
 kernel/workqueue.c    | 12 ++++++++++--
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.45.1


