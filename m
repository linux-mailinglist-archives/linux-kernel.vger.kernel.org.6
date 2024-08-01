Return-Path: <linux-kernel+bounces-270945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A482944770
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA2E282928
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938EC16E89C;
	Thu,  1 Aug 2024 09:07:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB98481DD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722503225; cv=none; b=UBYK20cTnbitRjwEEEfe/vmNmV38j9Dl3yVFD05C58DNI/LOvfYP6/HH+ELbTxUr9WDQTbRkto5JQ3ivDRZF/KCR3xU16/ZcTbN6kHC/YHYgB9OfXEg7yVdBqQt2cIFiM90pEWwc1c1NoIhuMyA8zGaVQXBmk+Nh2z5JKGR1L3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722503225; c=relaxed/simple;
	bh=Bka2MgsvDMXEH6a/ihmJ/MI5XdcmHXl1pCEmhX7lFic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JHzzc3K4Ke2LLFPC7zFyrj9TZOMOaLjiZAJICgMIcDSvdMOu8E4aQS5/nKThI0+NmEEd1/JVghMlb87mwgmKR5fnbtthvBPWr2cMkmRz2WqpukIJUAeaMSHvN+nIe7NEw9W2D6eORlDu9utXnZoC5x6JMkspfJBBYgoSY7OfuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f93601444so958551239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722503223; x=1723108023;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCbOBywQ/beDPX6EfmMM8UkUclL6iPr3Egvn3XiHWKA=;
        b=BJP3EEc87Aa6S1B633gSVYn4OYsIip86u4OGRkol1SFzOZGeXDAA8CB9EFV1urRETT
         PrE5F37gWdRwnUTHj7ulejYRWZBUgiRtpsWjTt0LQFbcWuiUgB6TvCcK9ZjvB/WdHNTP
         vju0kx9fJp8ZqokZQ/k1WLeP+YfnYTiVhYJEsDIiom5y1raktUFViD7bhxKrjfzoH3hY
         TDCYEIfBQUGbNS0V/HFeE5Vleu7nt1sD9DG7T3FACg3w9kLmH1W5HVqWJYktXhlXYNiW
         WTYCHrfuq44RtiLRTI8SYWA+FrYmKgO6C+uRXbtR60rMJExLqRfFdeIqHSGAFnGQ2GBv
         CsWQ==
X-Gm-Message-State: AOJu0YwQ0WYtxlmpBDQ0kYOtLPeNUj+XejEFCx+QhKNvrQufzqTVBNbR
	+nlcz02deLeay0b/OpzmSbOfMonH+qfVj7G+6dA5RIhPlSczA9J922yAoQJb89vIeo9XcG31FHO
	5dhXBuypv1r80CEJkLvIFNaRrfD9BSQ8pluSdyftml92dozkvwDSA+YA=
X-Google-Smtp-Source: AGHT+IFiuEJDndYVTfdC6gzH2BYR5SZLCMr7S16Sj6+OcO/WQE7P512YF/E7ZVNpSxTP6sqZy4O3JTTkl4WwGVxysYwFdChCGqmW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d19:b0:808:7e26:8454 with SMTP id
 ca18e2360f4ac-81fcc0ee904mr4446039f.1.1722503222934; Thu, 01 Aug 2024
 02:07:02 -0700 (PDT)
Date: Thu, 01 Aug 2024 02:07:02 -0700
In-Reply-To: <000000000000a90e8c061e86a76b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ba4cb6061e9b88f8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
Author: lizhi.xu@windriver.com

if alloc new folio for filemap, init mem to zero

#syz test: upstream 2f8c4f506285

diff --git a/mm/filemap.c b/mm/filemap.c
index 657bcd887fdb..8faa75f6923c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3754,11 +3754,15 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
+		printk("err: %d, folio: %p, in: %p, %s\n", err, folio, mapping->host, __func__);
 		if (unlikely(err)) {
 			folio_put(folio);
 			if (err == -EEXIST)
 				goto repeat;
 			/* Presumably ENOMEM for xarray node */
+			void *kaddr = kmap_local_folio(folio, 0);
+			memset(kaddr, 0, folio_size(folio));
+			kunmap_local(kaddr);
 			return ERR_PTR(err);
 		}
 

