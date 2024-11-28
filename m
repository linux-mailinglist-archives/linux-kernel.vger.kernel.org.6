Return-Path: <linux-kernel+bounces-424698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A4C9DB83A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24BEB20D57
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50519F41A;
	Thu, 28 Nov 2024 13:04:08 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE63147C71
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799048; cv=none; b=LUifdG7v/gzRpTMiAjdru1/R7MkjA/UPOxVDI1jXIUvh4FqfIvclsJm1ElojJazXlFOaI5juD7tCKmHkSPQ/AB28Z80Qkr/FZLzwBokVwLE3neFlhgPDYKltxrm/+qQ8EmgXkZ0AmMm3kTEgOUbqh3r8uHdq/jRA31RipJov9Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799048; c=relaxed/simple;
	bh=bO/vK/PpCD8mlpQfULfdeT+GJT1IowQHf+SdJwvJEI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaZlx3PjZDjqqTmgClOkIf1tF8KfCPmdbcd2+WBrYmfg4KeONxWWkHC/TygE5hN7SpU0V2IPDOU3Jgg8p+dlfwgnwIkFii16Mt+BLEe2/PDVGFBGlkjK+jw8Hg4navCZWXeOCYp7TtHvlWRtYtz0E2lbFI5jlBs8trN3dGVcXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.49])
	by sina.com (10.185.250.22) with ESMTP
	id 67486A3600004A4D; Thu, 28 Nov 2024 21:03:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5706967602503
X-SMAIL-UIID: 5D97697DF1B74808ADCBCF78563DC6EB-20241128-210355-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9f9a7f73fb079b2387a6@syzkaller.appspotmail.com>
Cc: David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] [mm?] kernel BUG in const_folio_flags (2)
Date: Thu, 28 Nov 2024 21:03:40 +0800
Message-Id: <20241128130340.2021-1-hdanton@sina.com>
In-Reply-To: <27bc1008-dce1-4fad-9142-0b74069da4d9@redhat.com>
References: <674184c9.050a0220.1cc393.0001.GAE@google.com> <20241128114249.1903-1-hdanton@sina.com> <1176656f-96a8-4e99-a4c2-7354b7cfd03c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 28 Nov 2024 13:23:15 +0100 David Hildenbrand <david@redhat.com>
> 
> Ah, now I get it; at the point int time we check it actually isn't in 
> the pagecache anymore. We perform a folio_test_locked() check before the 
> folio_try_get(), which is wrong as the folio can get freed+reallocated 
> in the meantime.
> 
> The easy fix would be:

#syz test

--- x/mm/filemap.c
+++ y/mm/filemap.c
@@ -3502,10 +3502,10 @@ static struct folio *next_uptodate_folio
 			continue;
 		if (xa_is_value(folio))
 			continue;
-		if (folio_test_locked(folio))
-			continue;
 		if (!folio_try_get(folio))
 			continue;
+		if (folio_test_locked(folio))
+			goto skip;
 		/* Has the page moved or been split? */
 		if (unlikely(folio != xas_reload(xas)))
 			goto skip;
--

