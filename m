Return-Path: <linux-kernel+bounces-335553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5335397E759
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1548928166D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0F18C352;
	Mon, 23 Sep 2024 08:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PNWIq9Eh"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A218BBA8
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079367; cv=none; b=ttKHmWz0MvItVufojaS4Yb6AsSE3ZRKGCMn7CAGUrTv/10Lo0kYjFsIZAgxRfsxX21j5FweAsldLGZFEryYQ6mg3fxpVBa47DE51KkB9EoZOpPKd6NQnTT2gRB/2wKbw/h5YwyUYYjxkpDh+uQjCs3nJW0/NQb/XHjLw2oe/ZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079367; c=relaxed/simple;
	bh=nhyA89QWnnx2FmkbVTxycOy83Nv1/mW01Jb+W8K38Ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=rmataaKzMum3TuIgoGKiFBKBwQzW3fZFXU0iIL5H1cCegRMKEHmuRcASTvn35XmCgj2w2p1FYH5A/rRVh84/7lWDoiDHhOWbEsi1q5py7st/l+RHsQyqjMqFJWO8s/AbHnyt+cLhsPrE4JM3d8PJsYMBJAhiZ0tJYdwhg6mau6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PNWIq9Eh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ca4e0014dso5946775e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727079362; x=1727684162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWOcTPwwf7Z/BAt3ngEueyugAgcowiKUH3melF7Cxsg=;
        b=PNWIq9EhE7SpOnwod/fjYILymAiMp2j2IeR9lVjPaUw1NmmmwzYAlsKlTYv8KHvWBP
         eCAKetR/Jzd77QXAc8rhTgYlVYGWEPBEEwtfVOZCjE8yVdCpL1ALMuYt4fY/0osf61dP
         xHZwvY3SbLg5GCUWnBa85f6umJpbbduoCcQDTbkK8yh7uz5mO1MnseR6DeNvCPjMosHO
         uhaawHDKhLjpTq5DvxKK5cQm+oTWFpdgPbkrSH1pPZDGDvCH9lM0khf6h2f4iNl3nL/D
         oa3i6LM2i9wjvyNM+ClLzLauR/e6p062oRKR4o+giVQsEoxYeDOk9mtplvXX2oeoRG5g
         lpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727079362; x=1727684162;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWOcTPwwf7Z/BAt3ngEueyugAgcowiKUH3melF7Cxsg=;
        b=n4ltmEgb8/dWhemFkkMrYxjxn90PJmW44xT7j+XgCEgBWQFK0svrcVr87Obeyhccuh
         +WblS8cdhcQYOqclo1M5dnesSS+H9MUVlJkqtyhZ0R8NAA9Eh3zvcAUdFMSN+MMAk4aq
         C8dxVEJ3R5Jige1RdoMsmmxZMJKQ2e4UgKultz5Flyz83HAN8WVMaGCi7MCXakHVhcjP
         e1+ceQubM/P326mLnarNOeqvIIfrV2T6mKLBMzO9tAq6PkYQbVcgS6KFCq25HuOHTaHa
         lzkU+6uKCpYGQduaon/npSBhfEVRHtdKpF1baJZLoEhRWoFNAK/nVVUVM70y18V8I89A
         f9Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUulg3LZ1uVBbb21xQQZIWtEgOg3T1IJnpfC2SUySVJ1ChBt3ROK97bmanjlRyo124jTajFSHbj3j7EISg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtSTO4dnDsiIxZjHA7CUYY4xy36zokYr3fdlJWAD8qNzRr0OhT
	Rj4rkJ39eFY1ryE23Wl7+Y1xV9x1KhBQkcQ+GofHi3b8jhfCq0gEbyVMQ/qzsyY=
X-Google-Smtp-Source: AGHT+IHbdxRSD1sPI5JLKyTtMB4Ok5vqE859Zp3ofCigxPO4cBfVIBrjsI0N/b0/rh4D4OfFwNx4dg==
X-Received: by 2002:adf:ab12:0:b0:37b:8b7c:107a with SMTP id ffacd0b85a97d-37b8b7c120bmr17728f8f.8.1727079361625;
        Mon, 23 Sep 2024 01:16:01 -0700 (PDT)
Received: from ?IPV6:2408:8409:2440:c1a:5215:bb45:d9a6:6f23? ([2408:8409:2440:c1a:5215:bb45:d9a6:6f23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079473e8a2sm129039435ad.251.2024.09.23.01.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 01:16:01 -0700 (PDT)
Message-ID: <0a4b798a-db82-40da-9167-141b684f43fa@suse.com>
Date: Mon, 23 Sep 2024 16:15:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_write_cluster_by_desc
Content-Language: en-US
To: syzbot <syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com>
References: <0000000000005ef449062240d69c@google.com>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 ocfs2-devel@lists.linux.dev, Mohammed Anees <pvmohammedanees2003@gmail.com>,
 syzkaller-bugs@googlegroups.com
From: "heming.zhao@suse.com" <heming.zhao@suse.com>
In-Reply-To: <0000000000005ef449062240d69c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Regarding the mail thread: [PATCH 2/2] osfs2: Fix kernel BUG in ocfs2_write_cluster

Both ocfs2_search_chain and ocfs2_search_one_group call ocfs2_cluster_group_search to search for an extent cluster block. It seems that the ocfs2_cluster_group_search() sets wrong res->sr_bit_offset.

Just from the code logic, in ocfs2_block_group_find_clear_bits(), the ocfs2_find_next_zero_bit() returns ZERO which can trigger this bug. But in the real world, this function never return 0, because the 0-bit is always set to 1 for the cluster-group itself.

let's verify my thoughts.

#syz test

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index f7b483f0de2a..d4e563281c9e 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1346,13 +1346,17 @@ static int ocfs2_block_group_find_clear_bits(struct ocfs2_super *osb,
  
  	/* best_size will be allocated, we save prev_best_size */
  	res->sr_max_contig_bits = prev_best_size;
-	if (best_size) {
-		res->sr_bit_offset = best_offset;
-		res->sr_bits = best_size;
-	} else {
+	if (!best_size) {
  		status = -ENOSPC;
-		/* No error log here -- see the comment above
-		 * ocfs2_test_bg_bit_allocatable */
+	} else {
+		if (best_size) {
+			res->sr_bit_offset = best_offset;
+			res->sr_bits = best_size;
+		} else {
+			status = -ENOSPC;
+			/* No error log here -- see the comment above
+			 * ocfs2_test_bg_bit_allocatable */
+		}
  	}
  
  	return status;

