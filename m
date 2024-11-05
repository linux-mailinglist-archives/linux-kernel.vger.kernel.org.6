Return-Path: <linux-kernel+bounces-396148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828DE9BC886
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC592B224B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C251AC429;
	Tue,  5 Nov 2024 09:01:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA649210FB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797265; cv=none; b=MNIyhbebl6t17rmvahUvuQHpcD2GG1aa8tfP/SERHtqIaq0DVwYKJQDl4uTKRMZeNC3w44dHlc3x0tHmc9leGGoONFVadBagzlQDhPDLghlZcg8dzSXGg/loy6lbt8lfV5eD0tJbCrQvycrrDmyA+VsxbIRYJ4Pn9sRzWVpZWs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797265; c=relaxed/simple;
	bh=SUwYBAsMJdzMRcY4A/Cdrs5yKIp/KVIk1RrISLjzNMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QF9GfB5g9DUClEZxDsCeHUBCG2Yr77btFn2LG776jPgGJBWalHikl9DG2coHS7YD5CisiTSHfpG9c69HA8YSXbj5TIoTxUDt9/DIuLs4LmXXdCAzCbjoBCovx9CCkmf6/OnS+jgb13AJ7S3OGgCgKjG4HV6lhFMnJDGkW1Bm57Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so30157725ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 01:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730797263; x=1731402063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwaf+/hRm/5NZhSkjzM6GsN75XYs+6QFBAabkdy80w8=;
        b=VdSnS3RPq9f58zqg8RL5Mz4pIiCda5BiXnNPbI1urLpuxXQ1UIluxlbNkGx4Zo5eyU
         WCq8j4SuctzLWPBOg71zGs5GIvmUOFFkmo/+g/Ih8PXZC9uEnEIXsUKuLkCLyHdp3Bqo
         WZ0TPCvqQtnruANn0SdW9jb0x0pwX05tBZFrp9ZbCDtATjw+tnYNW+CaV9jIiMj9Zvg2
         oOTgcXT7sPDx0xkj5As4FlEFcSdYlYXZQ2xg000yLJwbJ4KRXq8z2AiTcxd3+RpiDQnE
         SvFHzhSiT4v4hs2CTF9dh2/TRtFFA1U3aMHXx+I3XVnRZfDcAPnsfa8xMDywUQHn7xaJ
         VzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiKFnS8eHUyMe4qvCbLDOQP2xYNMcdSKwNlEPlzfk5o8kl7AGa6EKlz+ADeCJSCx5PQYv/JdlUSJ7mx8k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rkHZDC3n2x0DXXmLEu3FE7sldtEKRZj+wIwZRCkvaWl/ii3g
	Y2MBa1cNH106fN3uz3O6e/bnAz4QFRMzt0CGsEBAmzABookH91I/MeHqInw2MZpmu5NE4BMHaqS
	g9SSBsDh+1+Qnzma90XXTViU5JLloRzymz7BvfGn7aZcNz3l2OpXaql8=
X-Google-Smtp-Source: AGHT+IGAwBGcpXB4arw/smUYOMAgFRHcsANn+rKyLJzajkWJtDYNBa6Balz+rL3y+yNi6AEpfwBbP+hegb56SjbW7uHfzjZpo24B
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c8:b0:3a3:b209:650d with SMTP id
 e9e14a558f8ab-3a4ed32a5efmr304101045ab.26.1730797262644; Tue, 05 Nov 2024
 01:01:02 -0800 (PST)
Date: Tue, 05 Nov 2024 01:01:02 -0800
In-Reply-To: <66ebefad.050a0220.92ef1.0019.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6729dece.050a0220.2edce.1507.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in
 ntfs3_setattr (2)
From: syzbot <syzbot+2e842ec1beb075a25865@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Aug 22 11:43:32 2024 +0000

    fs/ntfs3: Stale inode instead of bad

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122d3587980000
start commit:   0babf683783d Merge tag 'pinctrl-v6.11-4' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=2e842ec1beb075a25865
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b9b0a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155e9900580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Stale inode instead of bad

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

