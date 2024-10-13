Return-Path: <linux-kernel+bounces-362779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AC599B935
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9BF281E9D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9113D50A;
	Sun, 13 Oct 2024 11:29:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4512C54D
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728818947; cv=none; b=MXCaqbbXksj/LPP0cL6TeAs0U2ANUBvJr0NPvUvrlo4zXjDXGQhWWd9yeir2uWp10IWfhnttd+1yPYpW2A/BzmQsaZTCFrRXJ/wodg9/mBkdx+tlzb2cpQcrkKa6PwuNesEK+7wiXoGkjpLifxjxv1LT/gAgHCJNcPxNDBlrnfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728818947; c=relaxed/simple;
	bh=q5D27+PQ5Xr7kDgYqT6MXacyBy+lN2JJUiMC4pKC6xc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CVSA0j1/q6BCungPgI9tosS7iHfJp9En+zaouXJBTWrAEaIAUldMeFAhPxmQfEChRN+cGgOa6echOgAGAhbFSzd0Weh5uBsygnuLsRR++4R8Ba05WZgcl44DSYeB/4cuHDeptML4opdem5Vk/dbX5+652TwgAm+E1DLuUUqknKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso19004245ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 04:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728818945; x=1729423745;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djz9nv65ykHTvVn/h40fceG0zy2B8YxvLP8jP1RyeMc=;
        b=Q/iuvWScDXC8XcIIqsaxT037JLlcLbvvN+b9Aft3eNGMVlIAaZl7e6HjOCkJUsZGHH
         hwx6euT/8+CCpGWZlND/VZ3G3iUvbCLAaq5raIa4k2BCysfd94WH/1WkCoB5EDwxG5ff
         rgJXiuYHZuhzOxjA+4EAEfq4kI1vV2R6X98mhV+gAOSA2sKRrWcoxX+kUsPWZappcQgx
         eNLa286Hi9U59WV8AcN/sPW7d7ouX6Kf0mMHaw1kTBsk6CSJjjNJkTiljVMd1u1YWZwg
         oyRrPyVGHP4AFRLfLrrPbUmyq9S//xMbcH2EAJry7PJJvsSQuLE5rnmynUQdGgOVCG/f
         LnGA==
X-Forwarded-Encrypted: i=1; AJvYcCXCxYBiCV4z7knHYFT1x7+Np/zrw0awulEfSAzkm3mwbPox2JwLOOWIh2Ezj1CjeqQr3mSESf5sqtZ3vaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfbKhFjABWp7l8cf5lYbaceCbh+Ub5/xvifxczhKZnTfnGNvcE
	4krt9UXYX7h82/JFWcnrh6TFQv9j+XKaTZ9rBi7a3XGvhJY3rWBfRhpuZ+NCF17/3KnrLkpXhJa
	sJh/hk+KrQs4h636AJAliD02SYhJmmiDR7sbEvCl58+rPFMmMRx543u0=
X-Google-Smtp-Source: AGHT+IG62+TItTLPr2vlpo1EBf1AL3FlWXPK1UofEJpKh6XjfgIJXE2nwiULRN1gNPcTxqhVl1J7g2e1+psK0kEOrYlaDEgO6wbx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:3a3:449b:5989 with SMTP id
 e9e14a558f8ab-3a3b5fc38a0mr52856265ab.21.1728818945375; Sun, 13 Oct 2024
 04:29:05 -0700 (PDT)
Date: Sun, 13 Oct 2024 04:29:05 -0700
In-Reply-To: <68d66e2d-78f8-4a7c-890e-ca81af38984a@nvidia.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670baf01.050a0220.3e960.003b.GAE@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: cmeiohas@nvidia.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for ipvlan1 to become free. Usage count = 2


Tested on:

commit:         615b9474 RDMA/hns: Disassociate mmap pages for all uct..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16bb0727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=5fe14f2ff4ccbace9a26
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d30727980000


