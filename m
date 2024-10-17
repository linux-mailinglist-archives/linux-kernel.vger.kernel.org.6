Return-Path: <linux-kernel+bounces-370682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D387B9A30AA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7D01F238F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 22:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FCB1D799E;
	Thu, 17 Oct 2024 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE+zA1Ny"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AA1C3034
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203925; cv=none; b=DvnZh4hR0LoEfheGEeKIuoRILfSIl0GevhGCqayrasiO0so/g5M4z9huGu3n3NOoie/esMcQEPLHruAmAd+7PtDFpbZcuPpL8A6QoURBd0+Jh2wLjmXCVJP0ASDTQGDCwtl+yvYQ9IvNHZ5CBmZkQSAYG8cg04atNjzeZMF+1OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203925; c=relaxed/simple;
	bh=Ov85Rp46Nt9OOKYhAf6gRtuUs6YmTU2PQwCVv7zM8Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4nzhKCthm/980Q4UZdSbXQmGNwOKlKtXUxP3XV7NcAj4lzU9vzZuiLTrPxF+OOL9YTmnxMHewMfG4mphPevoZhRv4aJArRw3gtxz1z2yLZnFra7Jc6IaDjJVkMb0XZcp16S4/4clBUGMlxh6WT0AdlhF/EQ9wPdRcumaRJkokQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IE+zA1Ny; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729203922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=58iMw+PAM7lTI21JsLhJRHGvlWvuIKTVdcdxGEn/4Eo=;
	b=IE+zA1NyzDjqj5RoaCNZnXP55Dtrc9/T4u0zuJ6/CcztzBAMpnlwESJQiTsMoIVetV+T+T
	yO1DuCKDM/rTJ2UUOk3WmaWozp+6YcXBSQw5ZBZd62kY1wiyVxCyCuXWrP5Aa6QAVG1/t9
	4tn2Ufhi3FjBPRXR8VPAF2W6Lj1ehqM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-AeJ_0qL0NBe1hKhxtmOApg-1; Thu, 17 Oct 2024 18:25:21 -0400
X-MC-Unique: AeJ_0qL0NBe1hKhxtmOApg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbf054c552so20563626d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:25:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729203921; x=1729808721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=58iMw+PAM7lTI21JsLhJRHGvlWvuIKTVdcdxGEn/4Eo=;
        b=mKPFnAPlaLn1Z3hGt3zdxeHRoXY/em9JcN8lfroIsK2dTMvQkJEzJGFKWeNlHYtSjr
         DWoa5XcuLYy/k5LzYvZGFwJPmQIjPEBEiRTdeKkG8GlZAh12gr+CGk1s2Sl7I0BuMZsh
         BXx4Q+1jEZgci6MvkksiyLoIdUpnjvOMATwbhOwzgivz7TWGDv+CjNGZp0ZReXezipSp
         czIZy6uTZMMfES7W9Tw7S99OhmINjNLUDV0xUIdR8mR+iU9wwTWXrCKQ8Ci8cJrSkGzd
         afzVVal2IhZVsttNLH2nH2Qz4koxwohxuGW8K5D4faaM+A35fThdFlfyZe/H6LGIpIIH
         Z4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV/ZxW6iToTh/isEhoqXt9Fto8LTxHklxwxwotQ9jQQ+kZic5ywLEDpfT35dPmK8AMVVpRq0rh+iQHL/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYaDf8OA3V1BykhbQ3CkZvetfIunWJJ6sKnUu2NkYMplfmE12
	SZ51OYwqZ1ZSiai1mr6XYyvcJGeVfe1k75DuWvMtEoejk3wGYb5zxWVngQrZII6duohDiYq+Hut
	gUtPt36UJasv3BsHl3CdOiaVriwwqcTIuDmzcsUZZKiu/fLyepxbEsIftDBsnjg==
X-Received: by 2002:a05:6214:4509:b0:6cb:f6de:3d11 with SMTP id 6a1803df08f44-6cde15f18eemr5703136d6.41.1729203921134;
        Thu, 17 Oct 2024 15:25:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp86CwtOfqRFnoTw8WiUC1eg5234GMLrAvB/G863IbvG3vbL9Ys/DJ2ZOUnvlRbeh8FILEYQ==
X-Received: by 2002:a05:6214:4509:b0:6cb:f6de:3d11 with SMTP id 6a1803df08f44-6cde15f18eemr5702746d6.41.1729203920734;
        Thu, 17 Oct 2024 15:25:20 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com. [99.254.114.190])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde136b322sm1018706d6.132.2024.10.17.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 15:25:19 -0700 (PDT)
Date: Thu, 17 Oct 2024 18:25:16 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: lee bruce <xrivendell7@gmail.com>, dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org, luto@kernel.org, peterz@infradead.org,
	bp@alien8.de, hpa@zytor.com, mingo@redhat.com,
	Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
	wang1315768607@163.com, syzkaller@googlegroups.com
Subject: Re: WARNING in get_pat_info
Message-ID: <ZxGOzE50OpzI3GaY@x1n>
References: <CABOYnLx_dnqzpCW99G81DmOr+2UzdmZMk=T3uxwNxwz+R1RAwg@mail.gmail.com>
 <9babc9ff-00f0-44c7-a2fe-8aeadfefe75a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9babc9ff-00f0-44c7-a2fe-8aeadfefe75a@redhat.com>

On Thu, Oct 17, 2024 at 09:27:35PM +0200, David Hildenbrand wrote:
> On 16.08.24 11:44, lee bruce wrote:
> > Hello, I found a bug titled "WARNING in get_pat_info" with modified
> > syzkaller in the lasted upstream and lasted mm branches.
> 
> Below report is from 6.10.0, which is not precisely "latest upstream", but I
> assume you have similar reports on upstream?
> 
> commit 04c35ab3bdae7fefbd7c7a7355f29fa03a035221
> Author: David Hildenbrand <david@redhat.com>
> Date:   Wed Apr 3 23:21:30 2024 +0200
> 
>     x86/mm/pat: fix VM_PAT handling in COW mappings
> 
> Was part of v6.9, but this is a different issue.
> 
> > 
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> > Reported-by: yuxin wang <wang1315768607@163.com>
> > 
> > TITLE: WARNING in get_pat_info
> > ------------[ cut here ]------------
> > WARNING: CPU: 2 PID: 12458 at arch/x86/mm/pat/memtype.c:1002
> > get_pat_info+0x4b6/0x5c0 arch/x86/mm/pat/memtype.c:1002
> 
> This is the WARN_ON_ONCE(1) in get_pat_info(). We don't find any page in the
> mapping, so it vanished already.
> 
> I thought we discovered that already recently and discussed it here:
> 
> https://lore.kernel.org/all/20240712144244.3090089-1-peterx@redhat.com/T/#u
> 
> Which was supposed to fix this problem IIRC.
> 
> That patch result in other issues, and my analysis about them is here:
> 
> https://lore.kernel.org/all/8da2b3bf-b9bf-44e3-88ff-750dc91c2388@redhat.com/
> 
> We didn't have a report from an in-tree driver, so we decided to "not care"
> about these reports:
> 
> https://lore.kernel.org/all/116ca902-103d-47cb-baf0-905983baf9bb@redhat.com/
> 
> 
> But I don't see Peter's patch upstream.
> 
> Peter, do you recall what the conclusion on that was?

I don't.. and yes I think that patch isn't merged and should still be valid
on its own.

Said that, this seems to be a different issue, even if still relevant for
PAT.  The important part of trace dump is:

        ...
        __mmput+0x122/0x4b0 kernel/fork.c:1126
        mmput+0x58/0x60 kernel/fork.c:1147
        dup_mm kernel/fork.c:1481 [inline]
        copy_mm kernel/fork.c:1517 [inline]
        ...

So I think Dave's analysis is spot on here, that we're trying to fork but
failed:

https://lore.kernel.org/all/f02a96a2-9f3a-4bed-90a5-b3309eb91d94@intel.com/

The PFNMAP vma is going to be destroyed even if, I believe, nothing is
mapped.  I said that because we do pte copy in sequence, and the only way
get_pat_info() can fail in this case is the lookup of the 1st pfnmap
failed.

Instead of questioning why the dup_mm() failed, if we can find a similar
way that pfnmap vma can remember the start PFN somehow (just like for COW
memories there.. in vm_pgoff, but again that currently might be used by
drivers), then it'll also work, so that get_pat_info() shouldn't need to
rely on pgtables for VM_SHARED.

That issue was on my todo for a long time, but there's always things
preempt me from that, not sure whether anyone would like to tackle that
even earlier.. or I can find another time to try, by boosting my todo's
priority.  In short, IMO we should allow dup_mm() to fail in this case no
matter why that happened, while maintaining PFN mapping info in pgtable is
always tricky to me (e.g., it's against VM_SHARED PFNMAP to support fault()
and page zappings when needed).

Thanks,

-- 
Peter Xu


