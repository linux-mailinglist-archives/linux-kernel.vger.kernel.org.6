Return-Path: <linux-kernel+bounces-573996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63905A6DF63
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6648E16F75F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42F22627E1;
	Mon, 24 Mar 2025 16:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ez+DjuDo"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6562620F7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832865; cv=none; b=mESKpRqm1K2fPJRmbwKxMxK8Y7IVJI2Gp/kEKCPjJIFpaMksOqyI6xdOVfLLIeQ97CNkgKo5ctnCoIbGA+Q2UFkfZ4oalUY9W2SfBQUR+JHHgL1INJfjsm0shRqmLJYfZU50bL07+CRW1nZ/ZeyBlEF8sQ3MMYb/IorEV1vZQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832865; c=relaxed/simple;
	bh=OVx5qEzHDwHumfbtV5HYHgl6QC/zhZ7PJD7CJVooSts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX7kpD3tIyjwdmbQNC7JXHxe++ryYBSsgaRaRy/yfSyl2y8sP+z7rriILVEj4v7QhvuAShuZTwxslyzMw6QZ6YpUEIfTv5TyoOiCfdKofQSOT2Y1ESEFPqXiDRLq13aJJzPBtm6RbKwudsqPAbuuzbUosUcQQfPXCuKvMN09cvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=ez+DjuDo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BBC7E3F6B3
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742832853;
	bh=vrCEXjms1HEeHeCcBRgtI9vYOaSHDCJqhJDM0xoNcLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=ez+DjuDozZbB4k1BxvxPDwDjluwmaYtoRIUuhGkVbqXes1HPgU7D/Z8QYzdIbgoax
	 MAOpjqGLXjG/lCcG7mRgiV3G9IKhbBBL6YPQFe62xqFUUugiRCipmDCAlDBUyTgjqZ
	 IDLZhcKTpHvCinR/lj0z0aw43KZ7Xu3r8hVrceuINhu6cJ75NFiyA61pVXVcosMgO0
	 H/b5Z42gE+6YHZ1PCvwTZEgWXC0pDkrUzkw8D7zsUEDE/2cZ5xdvC/7HigWfO8q2g1
	 2QI+i61uI7lH4hgYuI2yRhVOe+mbuo1DxV1bu8ikTW+YLVDwfsICmPw5P9FBSNeANK
	 yMh/CJyhyozow==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac3c16d6199so406702466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 09:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742832852; x=1743437652;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrCEXjms1HEeHeCcBRgtI9vYOaSHDCJqhJDM0xoNcLM=;
        b=OcjEg47brU2Ss8Fo6rwbg6zG9DfH9Q6KrXAxO2rJmfNpAayLVl6HFtAvDhhSAgq9Og
         BwTF1rkhrKPUGBMjJiBcH4HflPynQvnggO0FFUI9IFSobW3lTcRsL1XuEOCVVsYudbdV
         t4Cvtr/d1advxjNn+eIURRg3VbLflR/bK0PGHei4tgr/IRbRm+uXCJ+bl0XMIjc31EV4
         HVnw4udSOhCAfPj7BU61Fn+ll84kNTRLa2jL8g5r6t6TvDHQovIc0Rr+f97xMKColaU+
         LB8GjQ4Y16wticdUbq7ErIJAEaVQVLz19dU2uFAp+OsS3EDc8WZ2t2Hcz/MeJJNLp/4J
         R47Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKq+06o9PEoGH+VjBY6iIkFaWHR7gSfnSHG09x5SfiwqKAE7SRBwS551oHB9PRW6h/F9r4EBnck3ozB8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8pqtSNx77dRn7agkbsjtNsRAErEBrseAM8x3kDmO4olRXBoxO
	JrliFOx5CSeveefWSAAfAfw4cSOZK9vA4XNWq1z4DRm445d0dDSr/0I1vTThl2RUJdoeK+BAvpp
	wOr8bARekA396DTkr1wSomzFBGN1oh+Pfs7WttjJl+OnMnkZsHl/9e4XeSqjvZK91we9foLd8ag
	QkH+XJig7GwsdpxITCqQ==
X-Gm-Gg: ASbGncv1cQp8+h+A2P/fWFOQf16K39ppkvqC7+bqCWuh686gnKhEL9q5S5qWET6ItlU
	k687f8rehvIN3LdRoMb5DHcx4hB/UCSUhKIupj+qSZMK9VVWff8Y3BCaZqhQ7YrNSkp1lqZil81
	1ZKFsLMiPqRhW2I1heeQIPae2uWWCianlv2cMY7YC4WX7h3l1y4kqeQXkS4fagUG4k1xqY3Qwo7
	e5FGzo2qvXYlgTzLei8z58KgjjZakgb5pa83pEMb893cAfqfNib20kr6FIGs5q7KBq377IAnX6U
	915uJAw6LZXiB0PSATU=
X-Received: by 2002:a17:907:d58c:b0:ac3:c05d:3083 with SMTP id a640c23a62f3a-ac3f24d6f4cmr1390896466b.35.1742832852503;
        Mon, 24 Mar 2025 09:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBoAqH0NuQib7zD9bnBjLQS0nzGw/Lcb59ZJ35t8yUAZYJ88GwfFPzoOrDGVL+L95eR27PQg==
X-Received: by 2002:a17:907:d58c:b0:ac3:c05d:3083 with SMTP id a640c23a62f3a-ac3f24d6f4cmr1390893966b.35.1742832852056;
        Mon, 24 Mar 2025 09:14:12 -0700 (PDT)
Received: from localhost ([176.88.101.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd24f6esm694852166b.154.2025.03.24.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:14:11 -0700 (PDT)
Date: Mon, 24 Mar 2025 19:14:07 +0300
From: Cengiz Can <cengiz.can@canonical.com>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Vasiliy Kovalev <kovalev@altlinux.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-patches@linuxtesting.org, dutyrok@altlinux.org, 
	gerben@altlinux.org, syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key
Message-ID: <d4mpuomgxqi7xppaewlpey6thec7h2fk4sm2iktqsx6bhwu5ph@ctkjksxmkgne>
References: <20241019191303.24048-1-kovalev@altlinux.org>
 <Z9xsx-w4YCBuYjx5@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z9xsx-w4YCBuYjx5@eldamar.lan>
User-Agent: NeoMutt/20231103

On 20-03-25 20:30:15, Salvatore Bonaccorso wrote:
> Hi
> 

Hello Salvatore,

> On Sat, Oct 19, 2024 at 10:13:03PM +0300, Vasiliy Kovalev wrote:
> > Syzbot reported an issue in hfs subsystem:
> > 
> > BUG: KASAN: slab-out-of-bounds in memcpy_from_page include/linux/highmem.h:423 [inline]
> > BUG: KASAN: slab-out-of-bounds in hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> > BUG: KASAN: slab-out-of-bounds in hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> > Write of size 94 at addr ffff8880123cd100 by task syz-executor237/5102
> > 
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:377 [inline]
> >  print_report+0x169/0x550 mm/kasan/report.c:488
> >  kasan_report+0x143/0x180 mm/kasan/report.c:601
> >  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
> >  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
> >  memcpy_from_page include/linux/highmem.h:423 [inline]
> >  hfs_bnode_read fs/hfs/bnode.c:35 [inline]
> >  hfs_bnode_read_key+0x314/0x450 fs/hfs/bnode.c:70
> >  hfs_brec_insert+0x7f3/0xbd0 fs/hfs/brec.c:159
> >  hfs_cat_create+0x41d/0xa50 fs/hfs/catalog.c:118
> >  hfs_mkdir+0x6c/0xe0 fs/hfs/dir.c:232
> >  vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
> >  do_mkdirat+0x264/0x3a0 fs/namei.c:4280
> >  __do_sys_mkdir fs/namei.c:4300 [inline]
> >  __se_sys_mkdir fs/namei.c:4298 [inline]
> >  __x64_sys_mkdir+0x6c/0x80 fs/namei.c:4298
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fbdd6057a99
> > 
> > Add a check for key length in hfs_bnode_read_key to prevent
> > out-of-bounds memory access. If the key length is invalid, the
> > key buffer is cleared, improving stability and reliability.
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: syzbot+5f3a973ed3dfb85a6683@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=5f3a973ed3dfb85a6683
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
> > ---
> >  fs/hfs/bnode.c     | 6 ++++++
> >  fs/hfsplus/bnode.c | 6 ++++++
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> > index 6add6ebfef8967..cb823a8a6ba960 100644
> > --- a/fs/hfs/bnode.c
> > +++ b/fs/hfs/bnode.c
> > @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
> >  	else
> >  		key_len = tree->max_key_len + 1;
> >  
> > +	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
> > +		memset(key, 0, sizeof(hfs_btree_key));
> > +		pr_err("hfs: Invalid key length: %d\n", key_len);
> > +		return;
> > +	}
> > +
> >  	hfs_bnode_read(node, key, off, key_len);
> >  }

Simpler the better. 

Our fix was released back in February. (There are other issues in our attempt I
admit).

https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/jammy/commit/?id=2e8d8dffa2e0b5291522548309ec70428be7cf5a

If someone can pick this submission, I will be happy to replace our version.

> >  
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 87974d5e679156..079ea80534f7de 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -67,6 +67,12 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
> >  	else
> >  		key_len = tree->max_key_len + 2;
> >  
> > +	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> > +		memset(key, 0, sizeof(hfsplus_btree_key));
> > +		pr_err("hfsplus: Invalid key length: %d\n", key_len);
> > +		return;
> > +	}
> > +
> >  	hfs_bnode_read(node, key, off, key_len);
> >  }
> >  
> > -- 
> > 2.33.8

Reviewed-by: Cengiz Can <cengiz.can@canonical.com>

> 
> I do realize that the HFS filesystem is "Orphan". But in the light of
> the disclosure in
> https://ssd-disclosure.com/ssd-advisory-linux-kernel-hfsplus-slab-out-of-bounds-write/
> is there still something which needs to be done here?
> 
> Does the above needs to be picked in mainline and then propagated to
> the supported stable versions?
> 
> Regards,
> Salvatore
> 

