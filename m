Return-Path: <linux-kernel+bounces-314042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 346D696AE0A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE96028722C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E6FBF0;
	Wed,  4 Sep 2024 01:45:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A78479
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414304; cv=none; b=PYigWr1xAJREkk1lTXcacCibrlq4NZn8anMSfL9jirjQv5W5D3YlPH8I3i35gzhDKYFIFf1SeZSycAPNiZZ75/kqvO3yEPdrVtdnGlQB2BbAsX60ITBb11LD3Od9D1vpwdMBccPszA8JzIi2G6bBD8zLsUOOqYl8kxTKJOv76+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414304; c=relaxed/simple;
	bh=m1mXIEDr/IbwS9GlrrzzwAngVdTAdbhIZSYB8Z1CfG8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V3ffA0xGbg+T/UQX7+HdBBrX+ferMGF9uEGQ+NjCBQdaAwd07BdfbppHqHPWALcUeYISVRersFE2exb6NtRmMYlgmWw5qlptFgVVgUnjCmNWGTNAv/3+dKfxBIKEF6w7hIe0jbG74VNbbP/4L9FbnzRSCONBdOZhEScSO+egMag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a2723a5aeso616626839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 18:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725414302; x=1726019102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6pZoQfu8oqTiOj2fV5vz8MzHgkTCXFalaNffJTpuCLY=;
        b=F+2lVqJ0NFF4dXoaRCWmUJM4R0qdMDNSb2MiCl04x+4pyS7H0DOvghsRfBetERixJH
         j87ZAla+qRuyg+Ip07nnQzFz+uEArtDXK7HrZTuOS5pk+q0dS4RxGvTqz27+kaWcFzLg
         6MdlzLGzI9rXUyMqTi0KIEFijq88o4xgrrPNGrtPjjxPGTCf7i/cfvQStu0hduOryB/Z
         5RAis9t4Adf6GrDVMiBQcs3hz84amP9MUg1us+usc8iwqQNzPRUIgLmcYMZvJu7axPi1
         z80N4LGMitXZCEsvZjhFaL2G6JojGCFv+tVto2WAcax/myriO59VJQwFAjYjbhktF1Ev
         CnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlGsHcZnak2YAvWIE/5Y3aFfphHNHuh4ZtQQR/QALBWGvJY7OQEHDyUjCLZ6JH2K0xrOLiAIp9+hlQ+hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEuXupX4cd1OjZxbEYBtKwH6M4qVgYo9Q5Plb0xC210324BgaQ
	gZugxfj6sglLLU/vUgYJ3jEkQCRBI514ZMACYP2rqjLzA4RoOshyDANCpUiYXUQfr6yLJTCwIhe
	EZODDhSkBKxxhJUYpAU1ksmwVfIC0zESzQvpRRpQJmoa9wManlJSGCJQ=
X-Google-Smtp-Source: AGHT+IH/ht6BsylWpDgyQ95sEtKZSp9Xp6m0ldMmnCpQOByiFDTHr/A2/uC2Qd8O/uAKOr4m2k3PuEdRl/7RURLNcj0WMB6XHtRC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1549:b0:82a:4ec9:9b12 with SMTP id
 ca18e2360f4ac-82a4ec99e12mr61069039f.1.1725414302222; Tue, 03 Sep 2024
 18:45:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 18:45:02 -0700
In-Reply-To: <CAG-Bmoeb3T5h2oqUFkB2D-rZw--xG4gdg7BGWv0Ke_q261VbWA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009324720621415223@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/btrfs/ref-verify.c
Hunk #1 FAILED at 1002.
1 out of 1 hunk FAILED



Tested on:

commit:         88fac175 Merge tag 'fuse-fixes-6.11-rc7' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=9c3e0cdfbfe351b0bc0e
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=124b14ab980000


