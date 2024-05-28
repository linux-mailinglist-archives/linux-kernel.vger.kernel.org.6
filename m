Return-Path: <linux-kernel+bounces-192034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5068D178B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853F2286D8B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CBF169AC9;
	Tue, 28 May 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S8LWQ/1Z"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE1D17E8F4
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889975; cv=none; b=cqCRQpMFix3N94KMEZ6fcFw6DHU9temhm3MkZNGuXhk014ozpUePptgpsW/7epjDP0wOgOZrxOMGGye47cp5bRip0dVbgeeeJam29MqB0588fHRlAiPM6zaNHKYmXvV85DcCOfysMPBgVm8KwRu7VlzSEB1vcp63LBxMCammCfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889975; c=relaxed/simple;
	bh=q97qnp9lq8ia1znYl0ISjRC8hSlbhCAofPKSEaHvOa8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd5GgmqvO8KKq1ryFSEqDtVMpSq/16xSNCOSthKRgLq4lJUQv831W1dCGcFC2XpcyzZhUNYVrZckTAnrBfWbizE+4fuR66+WGXkVTB2NKlg9Hmlw3LgSnD2Oz6LuLu+OXmG9Ob155TKITXj8hsMsgqSN+Dy2O8dFLRsLGbrqcAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S8LWQ/1Z; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-354be94c874so490334f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 02:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716889971; x=1717494771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+mVKdg2AFecQuEqldAMrWKghy13Qjqb7Tk5N56y3jw=;
        b=S8LWQ/1ZoqxZDrmflT8lFTzx4df8vbNAvqmSjs31ZI4jmAZUKBFP8N0ISaUOuyUksv
         VJUzn1AYIbGZiaSiPnOKcjOzAaj1i7e47o6WwqaE5BMJoqtiSMKquBECuwPyU4kQnKT0
         +GLUH9AGc/KpJmUL/rFO4rjg1YClf4Gxh52Z7WfbpAPWF4xQfO+vGN8L/8Zz2t2zktX9
         7EYcyOHtDpN0849WcY5lBINdsfIZV3o1i5uNAB02Sj6ACAwiBPcAdXtRzRHHUBg2ZbYh
         2z6+04j7YFT9pgI/EypgjWjLa5BkEVBjKZMCfYs3hY8l5w+qQ/ePg3pNF2HC61GuNhYG
         ZRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716889971; x=1717494771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q+mVKdg2AFecQuEqldAMrWKghy13Qjqb7Tk5N56y3jw=;
        b=sEW4QZCSl2HxqSOvbpox2UMq9+LvHmtzFJFOMeSuOewxVQZndJyjLQTBA0358wp/Gd
         Qvv4n4NQl9qW68PBYMnp32KFWQShWu0blpZRJFOcuJCEfdWGcZaqGXGEPOMUGLrd1Ifc
         C+r3+bWu34B3DhMDtOo2wXLYJ3TKCCo3NF0h9Yk2sGnJplsvZFgrh3bb0fobXv+09hUq
         AAN1DRBbhKFwyd+7oOMc/JSjnxvamvTTvvOjh8rPx5LD+uEFZUMFWboJGd7RQ24FGrxf
         Hnv0GV9VHCNbEjTnXAngPUbubQXcERsX+af2Ux7NmaN7cdAOuyOvP+Rai2/we8Z0J7oO
         4H2w==
X-Forwarded-Encrypted: i=1; AJvYcCXXG3MyOORRF8Z3NitZjvyRZxl7fMxRuRy23Vjjh2D9Ve/JHcDlbD7mB4Zfg/a902wQUJNVax34Pa8v2PjpR4PxE9AzrYS9ap4sqOZf
X-Gm-Message-State: AOJu0Yy0JMpG9XAGpJUqFkm8JIADVni79CwEmS/HEzDQOzhKgwHxtpnE
	Xto/5Bo7yLx3dNgn11WI2gpX38uwcIVqd8P7/CXsqpr6LyWx/+F8NlQbyLzl9LM=
X-Google-Smtp-Source: AGHT+IFFgfOggTy6K9t1qMtirB5JoqMlGKYjXa/5C7rUCh5C0JyPMjhDdLpJE+rXjTtO1gM+idSb5w==
X-Received: by 2002:adf:f80e:0:b0:355:465:1445 with SMTP id ffacd0b85a97d-35526c37f5bmr9461325f8f.28.1716889971354;
        Tue, 28 May 2024 02:52:51 -0700 (PDT)
Received: from localhost.localdomain (62.83.84.125.dyn.user.ono.com. [62.83.84.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35607bcdf26sm11128404f8f.99.2024.05.28.02.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 02:52:50 -0700 (PDT)
From: Oscar Salvador <osalvador@suse.com>
X-Google-Original-From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 11:52:48 +0200
To: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
Message-ID: <ZlWpcP-6ntXSBRad@localhost.localdomain>
References: <0000000000004096100617c58d54@google.com>
 <000000000000f9561b06196ef5b3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="27vzgg1kwDHqn/88"
Content-Disposition: inline
In-Reply-To: <000000000000f9561b06196ef5b3@google.com>


--27vzgg1kwDHqn/88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 27, 2024 at 05:50:24AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    66ad4829ddd0 Merge tag 'net-6.10-rc1' of git://git.kernel...
> git tree:       net-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=15c114aa980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
> dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17770d72980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10db1592980000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/05c6f2231ef8/disk-66ad4829.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5f4fc63b22e3/vmlinux-66ad4829.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67f5c4c88729/bzImage-66ad4829.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com

And let us have it here as well


-- 
Oscar Salvador
SUSE Labs

--27vzgg1kwDHqn/88
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-hugetlb-Do-not-call-vma_add_reservation-upon-ENOM.patch"

From 917fa54481422c650425c8b0330439f8a3308479 Mon Sep 17 00:00:00 2001
From: Oscar Salvador <osalvador@suse.de>
Date: Tue, 28 May 2024 10:43:14 +0200
Subject: [PATCH] mm/hugetlb: Do not call vma_add_reservation upon ENOMEM

sysbot reported a splat [1] on __unmap_hugepage_range().
This is because vma_needs_reservation() can return -ENOMEM if
allocate_file_region_entries() fails to allocate the file_region struct for
the reservation.
Check for that and do not call vma_add_reservation() if that is the case,
otherwise region_abort() and region_del() will see that we do not have any
file_regions.

If we detect that vma_needs_reservation returned -ENOMEM, we clear the
hugetlb_restore_reserve flag as if this reservation was still consumed,
so free_huge_folio will not increment the resv count.

[1] https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/T/#ma5983bc1ab18a54910da83416b3f89f3c7ee43aa

Reported-by: syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-mm/0000000000004096100617c58d54@google.com/
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/hugetlb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6be78e7d4f6e..a178e4bcca1b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5768,8 +5768,20 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * do_exit() will not see it, and will keep the reservation
 		 * forever.
 		 */
-		if (adjust_reservation && vma_needs_reservation(h, vma, address))
-			vma_add_reservation(h, vma, address);
+		if (adjust_reservation) {
+			int rc = vma_needs_reservation(h, vma, address)
+
+			if (rc < 0)
+				/* Pressumably allocate_file_region_entries failed
+				 * to allocate a file_region struct. Clear
+				 * hugetlb_restore_reserve so that global reserve
+				 * count will not be incremented by free_huge_folio.
+				 * Act as if we consumed the reservation.
+				 */
+				folio_clear_hugetlb_restore_reserve(folio);
+			else if (rc)
+				vma_add_reservation(h, vma, address);
+		}
 
 		tlb_remove_page_size(tlb, page, huge_page_size(h));
 		/*
-- 
2.45.1


--27vzgg1kwDHqn/88--

