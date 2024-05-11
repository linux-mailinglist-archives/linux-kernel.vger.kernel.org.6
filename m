Return-Path: <linux-kernel+bounces-176546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0382D8C3171
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C341C20A51
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C575028B;
	Sat, 11 May 2024 13:00:10 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6AE50267
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432409; cv=none; b=iAmoXqdsPcbbOL6s5QDT91p6RZTnEIsXNQralTBJaxdWFS0nhpHhjrbvaD0PdxtKSq2Ur3NF7v85lpyKERNxQEGWn+SfILdp2oTsGy39FN+Gdk1ogkIb+U4l099qLtnK00io4b1DcaHaukDF/emRQDIgaOiY7WpmI0PDz7yf35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432409; c=relaxed/simple;
	bh=cJNnrBvhQhCn54k9WSkt7txsXGoxKzwyeDesonlcFBA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KgJUES1Cs7xJwX5WtehZ2qlor2VfoFkZ/9v6hQJFdQI9gqICZQBO7EdBB06u693ggMhjFT5P8EMPCcXuObbY9tlO/INtQEuVGD9OirEPXCt8w+maSMh8LaNqRxJ0bH6tnOeqThPsBi5CURo1lLeumHopkYlvSsJ0lQ1s53ZW4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ddf08e17e4so244436939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 06:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715432407; x=1716037207;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tYpl1GB+i++ozmm7DOHgb8qgYnR+fc1u86B88XYzD8=;
        b=jyAgcEWnfeM8D+E1o5NKHnkYj0SkwIqu8Jwl61NKFSwGK5/xv1cSkqI0TVZLyVjaZx
         b8FpxYPVP1QvdHq1D/EVc4Vf2D9mZ/M3CMM/19Kxl9iEqzhTB4hRvCsHqg6OQlpZcqpL
         Gmy/CoxcgW8fYcaCQn/2ii4AxD8z0mkYFszaK9u+mllZxR+o3EnBmOe4gOQDgCnpkxr8
         DZIeb5+KgJbVMN9t6z+hC05bqZJZqnLvIiUCTWPeU9YFhQGw6KdZOjqaw2EWJ85sUINT
         C0SpHlA4Sp36lhh+/BQgdWKJbdbHigFFXVWJMbSo19NaIRBZStEcPj6Awy5px25+SWIB
         f/uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz1ely3Fd2AR6oIQYC0u2LGSFekvPPAeRBLJgTs98yEEUFtb4n8h6k0fXrUDQIK/MoqXdguK0CxEIh8SaMGiLN7LmoVd/VcXKj3MBY
X-Gm-Message-State: AOJu0YwtwGxX5poRTb5a9xcvW/nCL/tJ/ojjtL+bJUY5T16rvhSWqLF2
	WMcrf+OmwoenPm9RdkMyFn3Dke6dD1z/Moi7pU3rqAC2czOanD1epX3GFwJmSxAbOC/vjlqgyy4
	a7bnnkYcc0EOUrOVapNEBl1DA5GEZM9YpNKzPhjpQXEC9yuCYDb579RA=
X-Google-Smtp-Source: AGHT+IFOEoFTqyoyApbGxBkkoFtYS95bfhcK7rTS+uulMWdwFvTgBtDqqFq+LhEUXjmUft8YU1VWqHpNbWz+4ozR4siXgHte3PQw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b02:b0:7d9:b860:3e54 with SMTP id
 ca18e2360f4ac-7e1b52080cdmr34895739f.2.1715432405967; Sat, 11 May 2024
 06:00:05 -0700 (PDT)
Date: Sat, 11 May 2024 06:00:05 -0700
In-Reply-To: <20240511123655.2700-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031b7fe06182d3bc1@google.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end
From: syzbot <syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+da4ed53f6a834e1bf57f@syzkaller.appspotmail.com

Tested on:

commit:         dccb07f2 Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15865b70980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d14c12b661fb43
dashboard link: https://syzkaller.appspot.com/bug?extid=da4ed53f6a834e1bf57f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1475125c980000

Note: testing is done by a robot and is best-effort only.

