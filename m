Return-Path: <linux-kernel+bounces-250772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66892FCA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567D01F21B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F39171E49;
	Fri, 12 Jul 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uhpt83GZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD89E16D4C0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720794846; cv=none; b=C+y3AiBd74rxFoAYmsxfKxbUYbeZbPV96pqbd4ClTTVXZ5z/O6OlMCOfA85GtxNmA+bH2zuexLxW8uiEijgXOQ4Xdt+aZdSYlk4T7AgRo6AG2uOcc8D3PiHgmOXUwaeSiP4w49i2zzmiwHrrKtyBr8pZnh8ctSw+9aFh2NEruEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720794846; c=relaxed/simple;
	bh=A8JyB70BTgHceWvqnOatyR97YW19SBU/k6G+VoPrhuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTq02vpkrT6tFz/qn12B7LBu9aUnjreFfNXpzJ3RXvdrztpST4i+4XY5fmUyi35fPRYR8FHwbf3GBId5oGykC1GBwlxDZmnXNYN7Lp8s/74Tw7229JZU6MScnwtmbB84ItaBCGIS8EX+RC+R8+ccCzEgL8xDHZXBaFZYUCHRF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uhpt83GZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720794843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0DLwaSRoDde6WZrgZ+yrZtXJoG5Gh87TSS23CjKmFiE=;
	b=Uhpt83GZQCl7mt356vbDFvavDu/Cg1/nZz/PRMkrR/c/m8mfYeLuyz++NKehB3rdfvT50X
	4iCZ/X7ixLsSf0MMqLEvrfpkG6RmnOSWXB+7OqOQf/9RwYj7GtxI2Zd7+TQoxW4OeyTPQ6
	zBNLnUxZEWjlXDD0WTtwixfXf1EHraA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-Jq9UzzbTMa-5ceh0_XrWgg-1; Fri, 12 Jul 2024 10:34:02 -0400
X-MC-Unique: Jq9UzzbTMa-5ceh0_XrWgg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-44aeacbf2baso1755321cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720794842; x=1721399642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DLwaSRoDde6WZrgZ+yrZtXJoG5Gh87TSS23CjKmFiE=;
        b=l+w9ik1c3Yxap3eCN/1c/7VsI0wQfYRtuxi45Dvh+tNA2QTUHK8Q7RPQ4ovFR9e+Tv
         bVco4gWDBgzKnGiUiEt/xry8I35QTBNCt1ufNQbmKD+zt3dIUXrQxqiRUQ2wQfnZb99v
         0HJXTz/aW0W+MsCGj5ctFVrzKuFLmXPNhALLHDBiM0HgnEpjs1VpkxuUPo+b3S/pGDjF
         7in5ziZB30+LPDepTDcz68g5Se2QRc6vT6gyigKUuU4AtwbUiitRCDENPuLwEd/pmtMx
         ylVoxyluYvLdHiQ/fuOUk3zB11wesovbUpG5rTcmDMRBKT0q5i9o+mPQ4cnEytSGf6dX
         /vaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt3ZC5PmJIogTVRuFeFhrQQLMQz3UoK071n80rcK94+Sf7MImxwzlMdUz77/cwCt9SAnCjkwntEoiwXCJ9LYLNkqfkfg3IDiChBvs8
X-Gm-Message-State: AOJu0Yxn5q0GLwdAG09rghhTDWdNBQWnvskoWPkHzIEFqgJ4SiwqkxHq
	9+8vdIlvnMzkbN35JUIcRWu5iJPhIFA1fFu6Le3bWMm0uC6U0PylOOUePanTsnNyIfd+FOBLhxt
	K/tI+Q+yxL1tb+jafndl9Q1IryOKxhjPJOpMkwGIYohGPiWHX65fCrWG39lLd3w==
X-Received: by 2002:ac8:4a10:0:b0:44e:cff7:6261 with SMTP id d75a77b69052e-44ecff7639emr12121761cf.9.1720794841879;
        Fri, 12 Jul 2024 07:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEld3Uv1U8nPh3+YCPklOwBx/ZeFSFfiIed8XQn011EvrY+rsoTGjsfqfObI0oTFmuVGQkJUw==
X-Received: by 2002:ac8:4a10:0:b0:44e:cff7:6261 with SMTP id d75a77b69052e-44ecff7639emr12121541cf.9.1720794841546;
        Fri, 12 Jul 2024 07:34:01 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b2818esm41025581cf.10.2024.07.12.07.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:34:01 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:33:58 -0400
From: Peter Xu <peterx@redhat.com>
To: David Wang <00107082@163.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	peili.dev@gmail.com, skhan@linuxfoundation.org,
	syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
Message-ID: <ZpE-1nBtaxuSAiqD@x1n>
References: <ZpBhCHsG39wIVnQN@x1n>
 <20240712131931.20207-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240712131931.20207-1-00107082@163.com>

On Fri, Jul 12, 2024 at 09:19:31PM +0800, David Wang wrote:
> Hi,
> 
> > Ah yes, I had one rfc patch for that, I temporarily put that aside as it
> > seemed nobody cared except myself.. it's here:
> > 
> > https://lore.kernel.org/all/20240523223745.395337-2-peterx@redhat.com
> > 
> > I didn't know it can already cause real trouble.  It looks like that patch
> > should fix this.
> > 
> > Thanks,
> > 
> > -- 
> > Peter Xu
> 
> Just add another user scenario concering this kernel warning.
> Ever since 6.10-rc1, when I suspend my system via `systemctl suspend`, nvidia gpu driver would trigger a warning:
> 
>              	 Call Trace:
>              	  <TASK>
>              	  ? __warn+0x7c/0x120
>              	  ? follow_pte+0x15b/0x170
>              	  ? report_bug+0x18d/0x1c0
>              	  ? handle_bug+0x3c/0x80
>              	  ? exc_invalid_op+0x13/0x60
>              	  ? asm_exc_invalid_op+0x16/0x20
>              	  ? follow_pte+0x15b/0x170
>              	  follow_phys+0x3a/0xf0
>              	  untrack_pfn+0x53/0x120
>              	  unmap_single_vma+0xa6/0xe0
>              	  zap_page_range_single+0xe4/0x190
>              	  ? _nv002569kms+0x17b/0x210 [nvidia_modeset]
>              	  ? srso_return_thunk+0x5/0x5f
>              	  ? kfree+0x257/0x290
>              	  unmap_mapping_range+0x10d/0x130
>              	  nv_revoke_gpu_mappings_locked+0x43/0x70 [nvidia]
>              	  nv_set_system_power_state+0x1c9/0x470 [nvidia]
>              	  nv_procfs_write_suspend+0xd3/0x140 [nvidia]
>              	  proc_reg_write+0x58/0xa0
>              	  ? srso_return_thunk+0x5/0x5f
>              	  vfs_write+0xf6/0x440
>              	  ? __count_memcg_events+0x73/0x110
>              	  ? srso_return_thunk+0x5/0x5f
>              	  ? count_memcg_events.constprop.0+0x1a/0x30
>              	  ? srso_return_thunk+0x5/0x5f
>              	  ? handle_mm_fault+0xa9/0x2d0
>              	  ? srso_return_thunk+0x5/0x5f
>              	  ? preempt_count_add+0x47/0xa0
>              	  ksys_write+0x63/0xe0
>              	  do_syscall_64+0x4b/0x110
>              	  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>              	 RIP: 0033:0x7f34a3914240
>              	 Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
>              	 RSP: 002b:00007ffca2aa2688 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
>              	 RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f34a3914240
>              	 RDX: 0000000000000008 RSI: 000055a02968ed80 RDI: 0000000000000001
>              	 RBP: 000055a02968ed80 R08: 00007f34a39eecd0 R09: 00007f34a39eecd0
>              	 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
>              	 R13: 00007f34a39ef760 R14: 0000000000000008 R15: 00007f34a39ea9e0
>              	  </TASK>
>              	 ---[ end trace 0000000000000000 ]---
>              	 PM: suspend entry (deep)
> 
> Considering out-of-tree nature of nvidia gpu driver, and nobody reported this kernel warning before with in-trees,
>  I had almost convinced myself that nvidia driver may need "big" rework to live with those "PTE" changes.
> So glad to see this thread of discussion/issue/fix now, I have been patching my system manually ever since 6.10-rc1,
> hope things got fixed soon...

Yep this is a similar file truncation path.  I'll repost my previous rfc
patch separately soon.

Thanks,

-- 
Peter Xu


