Return-Path: <linux-kernel+bounces-401140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A92E9C1668
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3741C22A80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67981D07A7;
	Fri,  8 Nov 2024 06:16:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEA1C4609
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731046564; cv=none; b=RBOGiD3fUOwNFxrRJ7lRT0rqzINBFnP/oAVteTWkNF+bVKFeYOIym+YjB3W+AZf6N7GHQ7DW6smevaYQm/ut5H4MndAj7YixYQ/Kvj+jEaspxspIkiTonPOKyeuwShYRszo9tasSyMNNfYl3ir/rtFLMKaK3/I1jglVKFqZWLzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731046564; c=relaxed/simple;
	bh=RqQv4WbQIDXLj2sNH9vALbQ1ytIJgGwZWi4pqnDoTb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YYijf6lo3JNhPOBTbMiCV4NamOFKRWruq3add0FNI0QahVFAdCQhqvbzcoeNoiNyrVNE4cGlpUjHs9UjYBDmDmA6ZLWpAjgSdQYKJ9v76MOkG5l1mC2gEAE+LuYvuEtq7BhjKmY0S46Oexn5Vk/gOBrsgqshFta/A1lC6aer25w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6bf539ceaso25528045ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 22:16:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731046562; x=1731651362;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1dkOBb3SQFXPdGZ4MSv67wsI4Fh7AbjyXh8AbjtZKa0=;
        b=vCbDmxkmjQ0SPT79FI+zODOxCMVXA2VQADa3/wAacrVPEVY1T54beOkicpS5lHKQBm
         To+cAw7QvKbEtnnzMuHJavpcyFgZWQaJudaxyQCTorClPrrfvVMRmOBmk0Oyi2zmCWi3
         O8o9iadmmhGa8+qWFR2YKlC1umbfrAcSHtM83SnbOr1aGgEYAE1U6mNHXYu1r+H0c/KM
         /VT4O+obQkwrAxyXLKJKdfR363H7ATekgIiOmB47YT1FdedXAOHi1Xbglvk+UFIpeZPq
         dJ58Lpo5D5+8IO+N0VX7thO16nFHpo4dN9rgOCO5TXCbc08zQ1EcwRIyhzz8uCtBcDpc
         YxVA==
X-Forwarded-Encrypted: i=1; AJvYcCUU24zr9rJlxZDSvjlI5Woq/KETG++AMw+ToznP6mlsCynuDWtistqQExP9ipuSmap/pMgQHFxLVmHBgYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrODRqAgDfGPmNC8SfWTVizRgHNE/M8arY25l4zFcZMilUM2uY
	ApPvCaKH+HoL1Zv1xN09+sVCuZ6LLtVWzlSNVBVFBy6WJUsNaDyNOLvp5l4ba0JGKwDhLhiTZcC
	OlyP4A0Zn11ZJjCjiGf3uESH3DZKd2eDDKtOrXK6mwFLS8e9w/d3QLZY=
X-Google-Smtp-Source: AGHT+IH7zdDwIblFzHkND/X2fTq2H+dE0aDfkmw2UPK2nlcDwZijZwh8JJxdtJ5qbwrVvbF3AnslsHUH7uN168EqXAwhEtJ/g/sC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca85:0:b0:3a6:bafd:5650 with SMTP id
 e9e14a558f8ab-3a6f11d49f5mr20784055ab.10.1731046561872; Thu, 07 Nov 2024
 22:16:01 -0800 (PST)
Date: Thu, 07 Nov 2024 22:16:01 -0800
In-Reply-To: <6706d42c.050a0220.1139e6.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672daca1.050a0220.0db4.01bf.GAE@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_threads_set_doit
From: syzbot <syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com>
To: Dai.Ngo@oracle.com, anna@kernel.org, chuck.lever@oracle.com, 
	dai.ngo@oracle.com, davem@davemloft.net, edumazet@google.com, 
	jlayton@kernel.org, kolga@netapp.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, neilb@suse.de, 
	netdev@vger.kernel.org, okorniev@redhat.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tom@talpey.com, trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b4d8f228915f98f09974ef84ec028cbfe7a84273
Author: Jeff Layton <jlayton@kernel.org>
Date:   Thu Jun 13 18:34:31 2024 +0000

    nfsd: make nfsd_svc take an array of thread counts

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b8c0c0580000
start commit:   5ccdcdf186ae net: xilinx: axienet: Enqueue Tx packets in d..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b8c0c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b8c0c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=672325e7ab17fdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e7baeb70aa00c22ed45e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13526d5f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1654a740580000

Reported-by: syzbot+e7baeb70aa00c22ed45e@syzkaller.appspotmail.com
Fixes: b4d8f228915f ("nfsd: make nfsd_svc take an array of thread counts")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

