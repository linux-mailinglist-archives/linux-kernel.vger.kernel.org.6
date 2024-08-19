Return-Path: <linux-kernel+bounces-291370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4895614D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE881C2122A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77813B592;
	Mon, 19 Aug 2024 03:02:46 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C822F19
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036565; cv=none; b=O2jEbJEOvnView1kFdoZSU/dbJXQ9Qc1KuPEwqScj1bRuQPVNrZxtDADe6C27wciL19f8W4uzNWLIVsCZsdW+G8m4BrfrZ1xKPMzc0z+iHhfRMiB9ap4K13xnBUOyHxHpeaFBiDl7EDOylLqZzo9CnmSWtZ8eVsExOdELMDqkHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036565; c=relaxed/simple;
	bh=r3MbekM3wcfA1PBqfbF4lNo2IATfLOkWUoBlXVc2dE0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SQkgNa7Hj+lQRaPsw2lvRK/Spg6VlL8cDTq4bNhePko4vA5wPe+xWLuN2MblbOzgai4GeNXsdLcrcMxRS4rBjp84GshwaqAaPa3ONyNCJSu5HjLc1xmE/E1XAh8MSo6TPcfCY/BxflV6MmozTbjUsr+y06GFvd1gfXkDqc71eG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f897b8b56so284895639f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 20:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724036563; x=1724641363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIfCr4cLmitBFPapBJ35vlc74kM0hZ8Gj3XMtxUkiVQ=;
        b=W6qSXV4k/GMTYTiP8Bb37ExtJWajiFSz3T6RWfXKna6Q6AeQiAPCo8m7xrklFnlEWt
         oNcTZxocd66DzKn8g9hyvOpotpaEoJ/mHRjGyfIAvFP4EzAuNeo8yI1lAW62wMjp7+Hr
         +XoM1vVCEXDz614Cm58ZTso1SXKS4sTRVecPY1G3q7J/wbDRXTfzftY4OBVSMSDZftC7
         EbQmcHr7fo+wLyBJOgUm/aP11z6DqiX4H+0VdDYfLweZJ//J52ytYKV06fg6tns9xpN0
         aIZ5LohnjcVyJPiqucL49Kwwrr1N46IhZw05ahKDeaujZT1cRRc6vGsEWBUd7JAnc4TT
         vKtg==
X-Gm-Message-State: AOJu0YzB+466KXuMFFgbHQLQ6uVrN3CkZo2wn39lZHu5oBLWYPweSuLR
	IStcFRbekU2ql5RvISMlSgrxVo2eYWSTyhJYfBqzmwmfO7vMY5dXceibPj7gfWcxFzLOhkEbm+3
	yPw9jwC9fTLoqhRf6UQ30VDjl2mZGtmv2mySyHNfcALRGRKPqvnmMkQo=
X-Google-Smtp-Source: AGHT+IHASWaXyFyYnLKxePKf/+lCefGjRSImdbkpHKX+fJp8m/bDyxzH8uJOTjUAzQGaGuXroQvZ1Xh0F+bwhkxyyuq9TGhUOwba
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6415:b0:805:e4ad:66d6 with SMTP id
 ca18e2360f4ac-824f341ec01mr43190539f.0.1724036563523; Sun, 18 Aug 2024
 20:02:43 -0700 (PDT)
Date: Sun, 18 Aug 2024 20:02:43 -0700
In-Reply-To: <00000000000071b7c5061ff83639@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2f6290620008a5b@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write
 in bch2_dev_journal_init
From: syzbot <syzbot+47ecc948aadfb2ab3efc@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Write in bch2_dev_journal_init
Author: lizhi.xu@windriver.com

unsigned may overflow

#syz test: upstream c3f2d783a459

diff --git a/fs/bcachefs/journal_types.h b/fs/bcachefs/journal_types.h
index 19183fcf7ad7..311a62a0f6c1 100644
--- a/fs/bcachefs/journal_types.h
+++ b/fs/bcachefs/journal_types.h
@@ -323,7 +323,7 @@ struct journal_device {
 	unsigned		dirty_idx_ondisk;
 	unsigned		dirty_idx;
 	unsigned		cur_idx;		/* Journal bucket we're currently writing to */
-	unsigned		nr;
+	u64			nr;
 
 	u64			*buckets;
 

