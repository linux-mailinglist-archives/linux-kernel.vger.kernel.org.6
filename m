Return-Path: <linux-kernel+bounces-371502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 372999A3BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC0DD1F224C6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ABD2010F2;
	Fri, 18 Oct 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/3WFK1n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239082010EC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248532; cv=none; b=a3TXVXm7Ay8+X3+3IJkjpInK9lfIrVlyg89gdlddyEASZAhihCDqKxnAt3SLJUVdIAHDSxYIca91JxnmoNYXeMB8TcIFeT1OX2sqN7QJbws4zDW8GdNPnuFNuKEdx7VwjMIj7+44+GyD6Y7xwWcyBbrpybhdD1qWWty/Vg1It04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248532; c=relaxed/simple;
	bh=XUYrslqyT1lb7iK5Zh5MlselU43iOSG6q/31y1AoM68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYZNp5Kp0jPuz0VPmCNho/xTb+PBGEKVIjN8xeKmP3JN1KvwgD+F+gG2wRjtOF2ZeIh2QMPm1w/xMciFQMFUuXP7faxOlVX7oapiaUw/jZN/YYtAkWNjxqPti4fcbPFzNU2iO5eRIDRoIPThvNAyHO8/FFz3wJ8NNK1ToGy9rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/3WFK1n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729248529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XUqEuzdzAkLg1MOntc74EbWQTqKkWCM/kL+EA1zzWWw=;
	b=K/3WFK1njxS9jdpfn6bKqRyqn3eSOiGvLxc/Ssk4MS65/8lVDfeOivlowgmtEUwOg3YH5e
	vJ63fi0mY6A/gVWngmaAvkAc6dH60eWxVg1813cHWzO4NGB4S09EzXVl+0rPPFCJ9ZfhKE
	BS+1f0aQ73f2WzvirlTtN1BaPQdwtyU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-CRwinvCTMTykgxUS1vkYsQ-1; Fri, 18 Oct 2024 06:48:47 -0400
X-MC-Unique: CRwinvCTMTykgxUS1vkYsQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4315544642eso14375295e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 03:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248526; x=1729853326;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUqEuzdzAkLg1MOntc74EbWQTqKkWCM/kL+EA1zzWWw=;
        b=QCZItwjmnxGL10W9FoAcWEs03YMyexAyT5H3lF6WpBaKNtXWHrhSQKGW49bjBmly8w
         iufNJW2Oa33IDECcs2w5vTbZwS/uiIZ/pvE+e8K6dzpEz4nn67K7nZvYRbQrJQgykwrW
         y1IL7tgrcVQu1KBrxWWR1Oa1zKBoZg2STgnxC0Tjhlfa8XktA9bziIsQvyVHOtIinit7
         3Vk2Cly9FP7XREiWQIL0TuAUH7HaK9475Pgh/nzpeOeVFE1B3jduX+FR4Y+izDPJxFb2
         S/XBokaYoDYjcAzismoZwUO9L6Rm4hCCRTBJSgjuwaG+3vqTpehh7/YonX6QAPnrjBaG
         vRfw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ1nyOAzmGErGzaVjSohActy8LmpX5C4mEvUJ68xrrV0hbifYWiaPSj6AJO8W3TWDjQQk7zum6yGe/55g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsfK1wCUbmwoVW3JFvrKV4rD6HV3xOt+sk1aOnkmNVmfj4iiCb
	QpYjX465MJKLV0tuh9OpZa2SY6hOwNzz/mgsnRtM8z67mLfXxoLvOu86OIZjL7e0yO/gKcXwdhu
	gAMMDAg+8PZt2P6dbGn76sDVEwAhDAAqH4p9dZ4CeHcEd8uel+Tt9of3Aqy3ZtQ==
X-Received: by 2002:a05:600c:46c6:b0:42c:b220:4778 with SMTP id 5b1f17b1804b1-4316169127dmr14947075e9.33.1729248526514;
        Fri, 18 Oct 2024 03:48:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHjiFkGVYHKHxpGPhEt6T84T6mqE/HCEHt1K650uYWpNdZcywQl07vhCq3z1xJHAMi2ifeSg==
X-Received: by 2002:a05:600c:46c6:b0:42c:b220:4778 with SMTP id 5b1f17b1804b1-4316169127dmr14946845e9.33.1729248526052;
        Fri, 18 Oct 2024 03:48:46 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:2400:68a3:92e0:906f:b69d? (p200300cbc707240068a392e0906fb69d.dip0.t-ipconnect.de. [2003:cb:c707:2400:68a3:92e0:906f:b69d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e0a908sm20760875e9.24.2024.10.18.03.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 03:48:45 -0700 (PDT)
Message-ID: <5b742ff6-2b7f-4071-b471-80d27c1f09af@redhat.com>
Date: Fri, 18 Oct 2024 12:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in get_pat_info
To: Peter Xu <peterx@redhat.com>
Cc: lee bruce <xrivendell7@gmail.com>, dave.hansen@linux.intel.com,
 linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
 bp@alien8.de, hpa@zytor.com, mingo@redhat.com,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 wang1315768607@163.com, syzkaller@googlegroups.com
References: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
 <9babc9ff-00f0-44c7-a2fe-8aeadfefe75a@redhat.com> <ZxGOzE50OpzI3GaY@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZxGOzE50OpzI3GaY@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.10.24 00:25, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 09:27:35PM +0200, David Hildenbrand wrote:
>> On 16.08.24 11:44, lee bruce wrote:
>>> Hello, I found a bug titled "WARNING in get_pat_info" with modified
>>> syzkaller in the lasted upstream and lasted mm branches.
>>
>> Below report is from 6.10.0, which is not precisely "latest upstream", but I
>> assume you have similar reports on upstream?
>>
>> commit 04c35ab3bdae7fefbd7c7a7355f29fa03a035221
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Wed Apr 3 23:21:30 2024 +0200
>>
>>      x86/mm/pat: fix VM_PAT handling in COW mappings
>>
>> Was part of v6.9, but this is a different issue.
>>
>>>
>>> If you fix this issue, please add the following tag to the commit:
>>> Reported-by: xingwei lee <xrivendell7@gmail.com>
>>> Reported-by: yuxin wang <wang1315768607@163.com>
>>>
>>> TITLE: WARNING in get_pat_info
>>> ------------[ cut here ]------------
>>> WARNING: CPU: 2 PID: 12458 at arch/x86/mm/pat/memtype.c:1002
>>> get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002
>>
>> This is the WARN_ON_ONCE(1) in get_pat_info(). We don't find any page in the
>> mapping, so it vanished already.
>>
>> I thought we discovered that already recently and discussed it here:
>>
>> https://lore.kernel.org/all/20240712144244.3090089-1-peterx@redhat.com/T/#u
>>
>> Which was supposed to fix this problem IIRC.
>>
>> That patch result in other issues, and my analysis about them is here:
>>
>> https://lore.kernel.org/all/8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com/
>>
>> We didn't have a report from an in-tree driver, so we decided to "not care"
>> about these reports:
>>
>> https://lore.kernel.org/all/116ca902-103d-47cb-baf0-905983baf9bb@redhat.com/
>>
>>
>> But I don't see Peter's patch upstream.
>>
>> Peter, do you recall what the conclusion on that was?
> 
> I don't.. and yes I think that patch isn't merged and should still be valid
> on its own.
> 
> Said that, this seems to be a different issue, even if still relevant for
> PAT.  The important part of trace dump is:
> 
>          ...
>          __mmput+0x122/0x4b0 kernel/fork.c:1126
>          mmput+0x58/0x60 kernel/fork.c:1147
>          dup_mm kernel/fork.c:1481 [inline]
>          copy_mm kernel/fork.c:1517 [inline]
>          ...
> 
> So I think Dave's analysis is spot on here, that we're trying to fork but
> failed:
> 
> https://lore.kernel.org/all/f02a96a2-9f3a-4bed-90a5-b3309eb91d94@intel.com/
> 

Ah, I missed that subthread, thanks!

> The PFNMAP vma is going to be destroyed even if, I believe, nothing is
> mapped.  I said that because we do pte copy in sequence, and the only way
> get_pat_info() can fail in this case is the lookup of the 1st pfnmap
> failed.
> 
> Instead of questioning why the dup_mm() failed, if we can find a similar
> way that pfnmap vma can remember the start PFN somehow (just like for COW
> memories there.. in vm_pgoff, but again that currently might be used by
> drivers), then it'll also work, so that get_pat_info() shouldn't need to
> rely on pgtables for VM_SHARED.

I think vm_pgoff is a dead end, too many drivers that use it in some weird way.

Last time I looked at it, I didn't really find a way to handle it without increasing VMA size. I had an implementation to achieve that, though. I'm afraid I threw all that away after the fix landed, though :(
I have to dig on some test machines if I can still find a tree.

> 
> That issue was on my todo for a long time, but there's always things
> preempt me from that, not sure whether anyone would like to tackle that
> even earlier.. or I can find another time to try, by boosting my todo's
> priority.  In short, IMO we should allow dup_mm() to fail in this case no
> matter why that happened, while maintaining PFN mapping info in pgtable is
> always tricky to me (e.g., it's against VM_SHARED PFNMAP to support fault()
> and page zappings when needed).


Trying to understand the issue ...

copy_page_range() first calls track_pfn_copy(). Then it tries to copy the page tables.

If copying page tables fails, we call untrack_pfn_clear() and effectively clear VM_PAT.

So likely the problem is that we have a VMA that has VM_PAT set although the page tables were not copied and even the actual reservation was never copied.

Likely VM_PAT handling here is to blame: it should not be set when duplicating the VMA.

The following is completely untested:


 From 0a9222c63ded87cb94fa0a7ceb8ce5254745e0af Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Oct 2024 12:44:59 +0200
Subject: [PATCH] x86/mm/pat: fix VM_PAT handling during failed fork()

If fork() fails, we might end up having VM_PAT set on a VMA even though
the page tables were not copied yet. Consequently, we might end up
trying to clean up VM_PAT but are unable to obtain the information we
need from the page tables.

Fix it by cleaning up the handling, and simply relying on the src VMA
instead.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
  arch/x86/mm/pat/memtype.c | 66 +++++++++++++++++++++++++--------------
  include/linux/pgtable.h   | 28 +++++++++++++----
  kernel/fork.c             |  4 +++
  mm/memory.c               |  9 ++----
  4 files changed, 71 insertions(+), 36 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index feb8cc6a12bf..bd70ad7639f0 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -984,27 +984,54 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
  	return -EINVAL;
  }
  
-/*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
- *
- * If the vma has a linear pfn mapping for the entire range, we get the prot
- * from pte and reserve the entire vma range with single reserve_pfn_range call.
- */
-int track_pfn_copy(struct vm_area_struct *vma)
+int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
  {
+	const unsigned long vma_size = src_vma->vm_end - src_vma->vm_start;
  	resource_size_t paddr;
-	unsigned long vma_size = vma->vm_end - vma->vm_start;
  	pgprot_t pgprot;
+	int rc;
  
-	if (vma->vm_flags & VM_PAT) {
-		if (get_pat_info(vma, &paddr, &pgprot))
-			return -EINVAL;
-		/* reserve the whole chunk covered by vma. */
-		return reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (!(src_vma->vm_flags & VM_PAT))
+		return 0;
+
+	/*
+	 * Duplicate the PAT information for the dst VMA based on the src
+	 * VMA.
+	 */
+	if (get_pat_info(src_vma, &paddr, &pgprot))
+		return -EINVAL;
+	rc = reserve_pfn_range(paddr, vma_size, &pgprot, 1);
+	if (!rc)
+		/* Reservation for the destination VMA succeed. */
+		vm_flags_set(dst_vma, VM_PAT);
+	return rc;
+}
+
+void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
+{
+	resource_size_t paddr;
+	unsigned long size;
+
+	if (!(dst_vma->vm_flags & VM_PAT))
+		return;
+
+	/*
+	 * As the page tables might not have been copied yet, the PAT
+	 * information is obtained from the src VMA, just like during
+	 * track_pfn_copy().
+	 */
+	if (get_pat_info(src_vma, &paddr, NULL)) {
+		size = src_vma->vm_end - src_vma->vm_start;
+		free_pfn_range(paddr, size);
  	}
  
-	return 0;
+	/*
+	 * Reservation was freed, any copied page tables will get cleaned
+	 * up later, but without getting PAT involved again.
+	 */
+	vm_flags_clear(dst_vma, VM_PAT);
  }
  
  /*
@@ -1095,15 +1122,6 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
  	}
  }
  
-/*
- * untrack_pfn_clear is called if the following situation fits:
- *
- * 1) while mremapping a pfnmap for a new region,  with the old vma after
- * its pfnmap page table has been removed.  The new vma has a new pfnmap
- * to the same pfn & cache type with VM_PAT set.
- * 2) while duplicating vm area, the new vma fails to copy the pgtable from
- * old vma.
- */
  void untrack_pfn_clear(struct vm_area_struct *vma)
  {
  	vm_flags_clear(vma, VM_PAT);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e8b2ac6bd2ae..baeb15c9e8a1 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1518,10 +1518,21 @@ static inline void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
  }
  
  /*
- * track_pfn_copy is called when vma that is covering the pfnmap gets
- * copied through copy_page_range().
+ * track_pfn_copy is called when a VM_PFNMAP VMA is about to get the page
+ * tables copied during copy_page_range().
   */
-static inline int track_pfn_copy(struct vm_area_struct *vma)
+static inline int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
+{
+	return 0;
+}
+
+/*
+ * untrack_pfn_copy is called when a VM_PFNMAP VMA failed to copy during
+ * copy_page_range(), but after track_pfn_copy() was already called.
+ */
+static inline void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma)
  {
  	return 0;
  }
@@ -1538,8 +1549,10 @@ static inline void untrack_pfn(struct vm_area_struct *vma,
  }
  
  /*
- * untrack_pfn_clear is called while mremapping a pfnmap for a new region
- * or fails to copy pgtable during duplicate vm area.
+ * untrack_pfn_clear is called in the following cases on a VM_PFNMAP VMA:
+ *
+ * 1) During mremap() on the src VM after the page tables were moved.
+ * 2) During fork() on the dst_vma, immediately after duplicating the src VMA.
   */
  static inline void untrack_pfn_clear(struct vm_area_struct *vma)
  {
@@ -1550,7 +1563,10 @@ extern int track_pfn_remap(struct vm_area_struct *vma, pgprot_t *prot,
  			   unsigned long size);
  extern void track_pfn_insert(struct vm_area_struct *vma, pgprot_t *prot,
  			     pfn_t pfn);
-extern int track_pfn_copy(struct vm_area_struct *vma);
+extern int track_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma);
+extern void untrack_pfn_copy(struct vm_area_struct *dst_vma,
+		struct vm_area_struct *src_vma);
  extern void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
  			unsigned long size, bool mm_wr_locked);
  extern void untrack_pfn_clear(struct vm_area_struct *vma);
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af2..02a7a8b44107 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -504,6 +504,10 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
  	vma_numab_state_init(new);
  	dup_anon_vma_name(orig, new);
  
+	/* track_pfn_copy() will later take care of copying internal state. */
+	if (unlikely(new->vm_flags & VM_PFNMAP))
+		untrack_pfn_clear(new);
+
  	return new;
  }
  
diff --git a/mm/memory.c b/mm/memory.c
index 2366578015ad..c677e1ab345a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1372,11 +1372,7 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  		return copy_hugetlb_page_range(dst_mm, src_mm, dst_vma, src_vma);
  
  	if (unlikely(src_vma->vm_flags & VM_PFNMAP)) {
-		/*
-		 * We do not free on error cases below as remove_vma
-		 * gets called on error from higher level routine
-		 */
-		ret = track_pfn_copy(src_vma);
+		ret = track_pfn_copy(dst_vma, src_vma);
  		if (ret)
  			return ret;
  	}
@@ -1413,7 +1409,6 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  			continue;
  		if (unlikely(copy_p4d_range(dst_vma, src_vma, dst_pgd, src_pgd,
  					    addr, next))) {
-			untrack_pfn_clear(dst_vma);
  			ret = -ENOMEM;
  			break;
  		}
@@ -1423,6 +1418,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
  		raw_write_seqcount_end(&src_mm->write_protect_seq);
  		mmu_notifier_invalidate_range_end(&range);
  	}
+	if (ret && unlikely(src_vma->vm_flags & VM_PFNMAP))
+		untrack_pfn_copy(dst_vma, src_vma);
  	return ret;
  }
  
-- 
2.46.1





-- 
Cheers,

David / dhildenb


