Return-Path: <linux-kernel+bounces-180516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D38C6F87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 02:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650341F21109
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454B510F1;
	Thu, 16 May 2024 00:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V326Vpyr"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6E620
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715819512; cv=none; b=SWijWmpvtYkriV98hDz4VU+QelwXsItPZEuC9vHlUlhJDQh4KmdRvc1P5ENO1/zNDyk1v6EK385p75F7IXRd73TChPis8BELIQIyGeEOIJT5sJK/7BgKWxyY5Hou9wJpQDesPq+nvxbsYn5g4ZK3idL4a45fLV4TaPsjhtl6aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715819512; c=relaxed/simple;
	bh=jEyumzpkWwYSzcvpMppl0gq1MCtH5yDL7td38D8uy+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBEPwJE0m31bCFI0d2p6ui/YUyZ4xt9rzPp2MEuZH6t3w7EYUnuRNVEUfzcrK+IUAAYIShYvCYmwVHbWpFIdvkqR0YSh13yI6rTfOpNtI+vrZKWTlEkXLX1djBykBiJRMEh/YUwHWpM/AfbCmsGUkY9Y7ia6nhwnLW/BS8dAk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V326Vpyr; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so5007508a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715819509; x=1716424309; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1ZOEzEyRsWPFtMmIxhfNXeTL3zlVab8wCdGYOykNMk=;
        b=V326Vpyr8xGzhaikT0A2VYvzhUGEBmSG3NV41xOHu6vmtEMVDJNVE+uEGh5JPee554
         WM6jv61P0vmsSzXmkm6bUZvve4EQ2x9o8fp5FLRcdhbnrYRsAdPckwhKNYHyrwB6mDE4
         8VtPwtEEwj19sshjVnXFfn63OzYq52eypm3ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715819509; x=1716424309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1ZOEzEyRsWPFtMmIxhfNXeTL3zlVab8wCdGYOykNMk=;
        b=JOFnKu7b08aL0YFp/QNgZOzsi1nagoSd9wnqaE7H4kg05JqiPVkXya71Im8JRGf0aq
         bVTSs6a/dDpOlXE9AN+oGFZm72sLolXpc9lxi4FPnvPo5ATWWFQLCFyafsOS11nR4Uxh
         NSTrWgIlbBlclaUgoTxsRPg/FGBkZ4dPra6xbFnCpoVw3995eYgi7QV0cl3lwXWFTSW1
         taAnBeU5OH6GdnlJ9Q31JQo6n7jYBx9gVC0kpc6wFEM6ONuXQW8jxRJOntRrBkMYB17v
         eL6syx0KvZdFOxLgqAGwvG1lA0+yfxrM3vWemQ2nI5gu1PKNGaFx0R0mcXQAWcWBKd5P
         VqEg==
X-Forwarded-Encrypted: i=1; AJvYcCVs9LHa5aqMy5d/fA2gbs9sNIJQpPXIgWvvJUBfM/74TMut4lxJUHfh3iSGXh8EVTzEdlqeU90MAS8BKvpG+6Ta7i8gDImnv1eY5IRi
X-Gm-Message-State: AOJu0YwgIELvdh4mWE2y3sUQGWezJr3Y+m/0l2Sp3K4ajsaA4H7S3RWb
	xAEa3XW450w5PM65xDSDZkYcFhtsiDWyvTCjj0GUCVleRC7kkuvLqj3fiPE/wqGuBsXJTHdeWht
	0mErJ3A==
X-Google-Smtp-Source: AGHT+IGG6D+PytE2U/HoOAHnXbqsbYt1nvZlhw6+TXR+xlNg8medCyEF7l37aAAwClvPY7vC8ryNLw==
X-Received: by 2002:aa7:c712:0:b0:574:ea0b:c1a3 with SMTP id 4fb4d7f45d1cf-574ea0bc231mr4630813a12.1.1715819508620;
        Wed, 15 May 2024 17:31:48 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57421480d99sm7840548a12.8.2024.05.15.17.31.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 17:31:48 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so2386525a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 17:31:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkQ/Lk9z9j9Je2RKjL8XiYK7h1yrgcfk1RC+NW6nsB1hfk0/kXUo+7NTB/iofMitezUFZz+lR0SaMsPE8TmA0XCWG8bxM7ctkQX9or
X-Received: by 2002:a17:906:f582:b0:a5a:66a7:47f3 with SMTP id
 a640c23a62f3a-a5a66a74d79mr966476866b.35.1715819507655; Wed, 15 May 2024
 17:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715616501.git.dsterba@suse.com>
In-Reply-To: <cover.1715616501.git.dsterba@suse.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 17:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
Message-ID: <CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com>
Subject: Re: [GIT PULL] Btrfs updates for 6.10
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 May 2024 at 09:28, David Sterba <dsterba@suse.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git tags/for-6.10-tag

So I initially blamed a GPU driver for the following problem, but Dave
Airlie seems to think it's unlikely that problem would cause this kind
of corruption, so now it looks like it might just be btrfs itself:

  BUG: Bad page state in process kworker/u261:13  pfn:31fb9a
  page: refcount:0 mapcount:0 mapping:00000000ff0b239e index:0x37ce8
pfn:0x31fb9a
  aops:btree_aops ino:1
  flags: 0x2fffc600000020c(referenced|uptodate|workingset|node=0|zone=2|lastcpupid=0x3fff)
  page_type: 0xffffffff()
  raw: 02fffc600000020c dead000000000100 dead000000000122 ffff9b191efb0338
  raw: 0000000000037ce8 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: non-NULL mapping
  CPU: 18 PID: 141351 Comm: kworker/u261:13 Tainted: G        W
  6.9.0-07381-g3860ca371740 #60
  Workqueue: btrfs-delayed-meta btrfs_work_helper
  Call Trace:
   bad_page+0xe0/0xf0
   free_unref_page_prepare+0x363/0x380
   ? __count_memcg_events+0x63/0xd0
   free_unref_page+0x33/0x1f0
   ? __mem_cgroup_uncharge+0x80/0xb0
   __folio_put+0x62/0x80
   release_extent_buffer+0xad/0x110
   btrfs_force_cow_block+0x68f/0x890
   btrfs_cow_block+0xe5/0x240
   btrfs_search_slot+0x30e/0x9f0
   btrfs_lookup_inode+0x31/0xb0
   __btrfs_update_delayed_inode+0x5c/0x350
   ? kfree+0x80/0x250
   __btrfs_commit_inode_delayed_items+0x7a1/0x7d0
   btrfs_async_run_delayed_root+0xf7/0x1b0
   btrfs_work_helper+0xc0/0x320
   process_scheduled_works+0x196/0x360
   worker_thread+0x2b8/0x370
   ? pr_cont_work+0x190/0x190
   kthread+0x111/0x120
   ? kthread_blkcg+0x30/0x30
   ret_from_fork+0x30/0x40
   ? kthread_blkcg+0x30/0x30
   ret_from_fork_asm+0x11/0x20

Note the line

    page dumped because: non-NULL mapping

but the actual mapping pointer isn't a valid kernel pointer. I suspect
that may be due to pointer hashing, though. I'm not convinced that's a
great idea for this case, but hey, here we are. Sometimes those "don't
leak kernel pointers" things cause problems for debugging.

Anyway, it looks like the btrfs_cow_block -> btrfs_force_cow_block ->
release_extent_buffer -> __folio_put path might be releasing a page
that is still attached to a mapping. Perhaps some page counting
imbalance?

This all happened under fairly normal - for me - workstation loads. I
was (of course) doing an allmodconfig kernel build after a pull, and I
had a handful of terminals and the web browser open. Nothing
particularly interesting or odd.

Does the above make any btrfs people go "Ahh, I see how that would be
a problem"?

            Linus

