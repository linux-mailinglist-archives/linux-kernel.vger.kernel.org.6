Return-Path: <linux-kernel+bounces-198510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5EA8D7970
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E47281047
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 00:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9F7139F;
	Mon,  3 Jun 2024 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2HZ8DmOr"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B2D10E6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 00:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717375917; cv=none; b=oUsqugvytEcHrFMQzOd93mdHEBWsNoVQGjIi7oItjGzcm69aP95lSwQwCGgTyhKdzurmhkBRpV/NCe8qel+gP5Q/cY33ZjiY2uuTVDZfyr7ZNNbL4iBo5WuzuVT4YAIttwWhh+HFr2bboAAZ6ac5Yyp46H/e60ShsCghtatZ8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717375917; c=relaxed/simple;
	bh=nOnKphG+s8GmbnfYIh0J5Nzy3CPVTV4gUd1McKQE08k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cG2v61LTh/oEyi6+/hO+/2xj/SdTvxI6ZF2SatcQOwASObir7TXdMP7niAtVL89ZPtRAWE2IoLkHZqtWLTETi9Wb3Hz33FtZwPy0e/ijOclg/gxO8tpyACJy37pLDrb4u35KSORmlBy12Xgapiu4EVr9A7U7C39mrWs2zs3NY0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2HZ8DmOr; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6c53a315c6eso1743988a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 17:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717375915; x=1717980715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fzMv1Ni5JoEuOE3KgrB+yNCr0HPWvf5mR/j14LdrI4=;
        b=2HZ8DmOroXtkYjw5f0ZvcuFpp9Q7jUqhceH5Hv6clhGeqAmX6PYEZppD/syR7EzUkP
         pgN9f2h/WVLeDgEEpjEDYYHk+0vTE3CEwVANHSAZFNZwysW6hEXs7Dh6QK1xmhmw9iYE
         XtvZMH2lVF1/SrlSYTTzfKnZjTKPbAFNWbzqoDqoH6+4B7n/me/3HcXyWtnzAnK1GU4c
         sRiTM5jNQjrR2QzWus7vyhGo8UnD5aM1WWpeV5B4vmA/3V5ywtqwokl2nJTwTcMDNEvI
         XSHorKJNm5E4xoNtzQMrsLAfW9DdqqezZVW0L6Qp0SE/1bxmBUFD+JppKp8vitgsP5ZR
         st/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717375915; x=1717980715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fzMv1Ni5JoEuOE3KgrB+yNCr0HPWvf5mR/j14LdrI4=;
        b=lfhV/RCLQpvDx5wqJ2tVAj7LBbT+LetRDjdCdkduDoNegQ3BjiKrxpDqO4N1Vbn7g6
         FVvIavns4uMOFlqeA3LbuG51uB8pEd4PlQGCYWsjE1SjTkYA7dqW8K0AVACb3tAOUqKp
         yzP3icF5PZS1CACrgBvKqy9WMZLinJBo/Du62Y1KDhh7NyTeSraKfv7VKnLCjM742HFp
         iYYhHT1G8PB5AmMaxPdCEUNzmNacQbbmS8DU8IJIxlmx5tTKI2cxnH0sm0nLMleEpinL
         Bbnc+cn0MGHeDovAmtMxQ5t7DcpY0XRKIzIrt5p7uo0xTRp9qpUPOwFMsNaKcixd86Bp
         QtSA==
X-Forwarded-Encrypted: i=1; AJvYcCX9papukzNeIMj7nuqe95biVv3CKOpiv2O1U9B7XFJwWml2VVvUg1w494XEtXI3QgVP/dKvKwuOGqSdbGck+Rqe16zFrEZe71BEnnIS
X-Gm-Message-State: AOJu0YxrBtC0uj73k8jSVnqn9qvx/pZAddBTRGf47RP7arNbtwwgQ+GS
	Sc1VF9237ZpwyJnX9sEzmI6jCPvneG6I2zzJ8709DuOOjrjTYLSLBmJ5FThQ4ek=
X-Google-Smtp-Source: AGHT+IFywXNmp1o7InQ0du69GGCZdjOOZ7w20apQhpauieDi8nn5/WHsHTQ6ALEh/aAJR+TYrsiYpQ==
X-Received: by 2002:a05:6a21:3393:b0:1b0:106e:89c3 with SMTP id adf61e73a8af0-1b26f17bdd3mr8635719637.9.1717375914428;
        Sun, 02 Jun 2024 17:51:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232dcdbsm53094095ad.4.2024.06.02.17.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 17:51:54 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sDvvT-002HjI-0e;
	Mon, 03 Jun 2024 10:51:51 +1000
Date: Mon, 3 Jun 2024 10:51:51 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev, roman.gushchin@linux.dev,
	syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com
Subject: Re: [syzbot] [mm?] UBSAN: shift-out-of-bounds in do_shrink_slab
Message-ID: <Zl0Tp/1PYaIAgJJz@dread.disaster.area>
References: <0000000000003051770619cec4f8@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003051770619cec4f8@google.com>

On Sat, Jun 01, 2024 at 12:08:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    6dc544b66971 Add linux-next specific files for 20240528
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14c7f806980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6a363b35598e573d
> dashboard link: https://syzkaller.appspot.com/bug?extid=981b8efffb3d71c46bef
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/334699ab67f8/disk-6dc544b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/4ca32b2218ce/vmlinux-6dc544b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/400bc5f019b3/bzImage-6dc544b6.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+981b8efffb3d71c46bef@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in mm/shrinker.c:406:18
> shift exponent -1 is negative
> CPU: 0 PID: 5278 Comm: syz-executor.1 Not tainted 6.10.0-rc1-next-20240528-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  ubsan_epilogue lib/ubsan.c:231 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x3c8/0x420 lib/ubsan.c:468
>  do_shrink_slab+0xe26/0x1160 mm/shrinker.c:406

	total_scan = nr >> priority;

Ok, that means the shrinker has been passed a priority of -1 from
the core memory reclaim code. That means it is more likely that
something has gone wrong with the higher level struct scan_control
sc->priority handling, not something in teh shrinker code itself.

>  shrink_slab_memcg mm/shrinker.c:548 [inline]
>  shrink_slab+0x87c/0x14d0 mm/shrinker.c:626
>  shrink_node_memcgs mm/vmscan.c:5923 [inline]
>  shrink_node+0xb82/0x4150 mm/vmscan.c:5961
>  shrink_zones mm/vmscan.c:6205 [inline]
>  do_try_to_free_pages+0x789/0x1cb0 mm/vmscan.c:6267

This has a loop that does:

	do {
	.....
		shrink_zones(zonelist, sc);
	.....
	} while (--sc->priority >= 0);

and all the callers initialise sc->priority to DEF_PRIORITY.  Hence
I can't see how we get shrink_zones() gets called with sc->priority
== -1 from here or anywhere else that decrements sc->priority. This
needs someone with more core mm reclaim expertise than I have to
triage this further.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

