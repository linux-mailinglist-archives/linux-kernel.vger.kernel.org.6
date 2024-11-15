Return-Path: <linux-kernel+bounces-411115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD509CF38D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3BB1B3313E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1A1D63F7;
	Fri, 15 Nov 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="QQBeKkAr"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538F1A3035
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692909; cv=none; b=STpknayMtTVtHBjQV/JIza6J199ziQxa3HbLv0q/AQ4HghnOzICmJjsJrNRpfeYtIeGUz7rKW9Ht9MnT4e/DU1UceUsxyxEbEWMxtXswCUm0rSfZxBvKRS+ZgaNNkD6ecN1qUXBInLlwrcCun9UFF7VVaXzl1FP3hM9wDiriOEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692909; c=relaxed/simple;
	bh=nvmT+3K0LsnoLH8DW9urbKB/s3MZsBucjWWx++pMtUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcesjVEGVYA2srAa6YyYCpwY2Mt7XUJ3pLDpph2ZxaTxB4LELHitOfgif04WPt+x7AnwqzKCuKaJRlapkvasBz4kCGyix/sTBXvmGsv5iZ37yH02uVobHIMeNO4QpvKTnkAfTDrtfImkZzZFuY2K0hX/MYvJ6qe/UoVfjvwJ8p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=QQBeKkAr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b155da5b0cso135955885a.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1731692905; x=1732297705; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r80U9a3N+Gcy1kzPeL8Qy1bUTpyxaoug1EvE/UJz4zM=;
        b=QQBeKkArFIMlbzcvnS9XzdT82pcJFSw8lH8KPDzJ86IlWA00WsS8FJVaJXxqugd2Zs
         me1qA4hZkLt1NT9Z1wsHvOsabJlmCCeaQgNJ/yKgr4LzjeHFmSlWGTB02jBS9GrV8PxW
         xq7WsBUK0idFD6GRNpKPJRZwq+mUQ67AZgPFrhYyJfupNSyYm+qUeKZCqKCQJRQbrIGP
         taaOtMeMUsgkklkAMPZ9GnwUn3uuZ2otkTo5NyDilwOoFzGeW7jSCrCxVItPWGRB3V/Q
         XRcBxwQFmPaXC5qXAsFbeXwCi72yeod5c75bsiXkVA1Z9Mr+6VHqK15WkJjLerYXyo3X
         fAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731692905; x=1732297705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r80U9a3N+Gcy1kzPeL8Qy1bUTpyxaoug1EvE/UJz4zM=;
        b=PhC8VkjFYrsPPv5bU0Cfzub4N9FCya+Yj5g3U7xO56wUBcHsmTOvR/AX62/MV/4e21
         G80+bsTMeCqk4oz5N71e0Y7iOpl4+n7JeNdu2pvI00gw5EHbctyapWgV6wtJm9mFcLQi
         HpCyKbepBKiXi9xiVfN/fRxuk7yylT/gtQ9NYLlEUIH5jEYHL5NayQWUy6OEHB6CE4Qe
         mkWGAwansqxYFjvBYmruHsM23vIeUWw4kY57kzUIw3T8g4TyhubammcnHSNliB0fUxTB
         rmtNqMjG8rncswGzOad1CCwXkVsqqdLsvd8XYHFVs+P4HRfS0xMZctt/r4joDAVdkyEb
         iUXg==
X-Forwarded-Encrypted: i=1; AJvYcCUHIPg2uBo+2sNH+I7CoTA/a96uPccRk8e0p9loluiFVjUenJe6dORQXV+Vv2J4HXVEMmjiULrZR4REpsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzogOLC+MjWF6m/mmqW4NEbzfmZh7tLngAnUDV3N9mIAcJU4ge
	TToLgccDRTSFETow4UCvGYY3TxRaQkItidXiu0vGNVJAKx4jokJeW9qP/rWDsA==
X-Google-Smtp-Source: AGHT+IE8O0QAu8GlbaYXOlBUtc2EBhnFRVZHs+CnC0NtgIziKGMzGgCEU+LDunjz55eqqQN+/h6ZYA==
X-Received: by 2002:a05:620a:2982:b0:7b1:4605:29be with SMTP id af79cd13be357-7b3623134c6mr481256585a.47.1731692905171;
        Fri, 15 Nov 2024 09:48:25 -0800 (PST)
Received: from rowland.harvard.edu (nat-65-112-8-56.harvard-secure.wrls.harvard.edu. [65.112.8.56])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35ca4dce7sm178969685a.97.2024.11.15.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 09:48:24 -0800 (PST)
Date: Fri, 15 Nov 2024 12:48:22 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+e8e879922808870c3437@syzkaller.appspotmail.com>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Read in ld_usb_release
Message-ID: <efc7e41c-b4a3-469a-983a-24b167b944e3@rowland.harvard.edu>
References: <6731d32b.050a0220.1fb99c.014d.GAE@google.com>
 <1af819ae-cd88-4db0-af6e-02064489ebb2@rowland.harvard.edu>
 <CANp29Y7RA00bKOinkjSDBchbkx3RDvWXGs4hr0PrPKyqSEC-_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANp29Y7RA00bKOinkjSDBchbkx3RDvWXGs4hr0PrPKyqSEC-_g@mail.gmail.com>

On Wed, Nov 13, 2024 at 11:46:00AM +0100, Aleksandr Nogikh wrote:
> Hi Alan,
> 
> On Mon, Nov 11, 2024 at 4:45 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Mon, Nov 11, 2024 at 01:49:31AM -0800, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    2e1b3cc9d7f7 Merge tag 'arm-fixes-6.12-2' of git://git.ker..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1650d6a7980000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b77c8a55ccf1d9e2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e8e879922808870c3437
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > userspace arch: i386
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Question for the syzbot people:
> >
> > If I have a patch which I think will cause the issue to become
> > reproducible, is there any way to ask syzbot to apply the same test that
> > failed here to a kernel including my patch?
> 
> No, that's unfortunately not supported.
> 
> In this particular case, it's at least evident from `Comm: ` which
> exact program was being executed when the kernel crashed:
> 
> [  178.539707][ T8305] BUG: KASAN: slab-use-after-free in
> do_raw_spin_lock+0x271/0x2c0
> [  178.542477][ T8305] Read of size 4 at addr ffff888022387c0c by task
> syz.3.600/8305
> [  178.546823][ T8305]
> [  178.548202][ T8305] CPU: 3 UID: 0 PID: 8305 Comm: syz.3.600 Not
> tainted 6.12.0-rc6-syzkaller-00077-g2e1b3cc9d7f7 #0
> 
> syz.3.600 means procid=3 and id=600, so it's the program that comes
> after the following line in
> https://syzkaller.appspot.com/x/log.txt?x=1650d6a7980000:
> 
> 551.627007ms ago: executing program 3 (id=600):
> <...>
> 
> You may try to treat that program as a normal syz reproducer and run
> it against your patched kernel locally, that should be quite
> straightforward to do (just several commands). See e.g. the
> instructions here:
> https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md#run-a-syz-reproducer-directly

One of the beauties of syzbot is that it will run potential reproducers 
and test patches for us with very little effort on our part.

Can I request an enhancement of the "#syz test:" email command?  It 
would be great if it would be willing to run a test even if the test 
program isn't considered a bona fide reproducer.

I don't really need it for this particular bug report; the underlying 
cause of the problem in this case is pretty clear.  But having this 
capability in the future could be a big help.

Alan Stern

