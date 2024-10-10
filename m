Return-Path: <linux-kernel+bounces-359156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF625998826
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA63728B5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C8F1C9ED1;
	Thu, 10 Oct 2024 13:46:23 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27AD1C9EB5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728567983; cv=none; b=IIQK/zg+ZsMFc9rz8yHdgJirXTnFUOl9CpVDRsMALWWUknfufs9gevBeUW2RcMjotMZ4Qw4/06ouAyxFatZ7fMYu/7SU2n4UIpXQO6btw0rMfKxuD34vhDsAzZ8blHz11lmGxizjwtNXT7/7qcebn74H7UPW20TXf0M63oDYBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728567983; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p5dgHEIj/bto8M46KuCbxAuqYDG/Vjvvhd6XN1tcgi7o30gIq88LeHYX9tR0LWd+g7Ke2n9b2Rnhue+EyeoBMg/TLftMfcdet6U+DLCQEFVagcgTJCuLqThWH9hhiVAIo3p+Z528mcXNxUx0V5LTD9GMMxog6zy/w7NbSKQROTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so7327265ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728567981; x=1729172781;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=vuVZH7kZFlaz8bOmR3kwDhRaCMcCNSXEFiFFmM9kRmpTiuNCIn5DJlCTY69s51ZdqX
         1yoyNyCfW6JvJEsBqnp5bbafZ5nrDbwCLMO9cJO3Y/VIPQl4WhP1ysrzNFL/aTUUUFpS
         zYAdlZf3pwNeQGsnBjId2AzArMI00wvLjszrF+VZ7owFr/Hh6DkGn5ivI0sK5kS4vwMa
         gOUaQJ12hWWNMKE9nyLXJQPoniW5lBfXm0b/3grLc9I5FQnBsw7LGPNBRGKxU2zZ4tWu
         kEiXFOgjFavz+9WIfEs43hPmWcxrongYTdmUAbxGcf72g3UfWmLHmdkPhmT8UtJTCGUI
         miug==
X-Gm-Message-State: AOJu0YwNSe7TFEeoLgyiD9pPEI5BpOZTmzl6JCtdtWmo1FVgbGbFfy8z
	4KLvjZovSzSoQOiNS7fYAJpytAPskbvawDO5DHnNDgwcwyfWxI7v/nFm/JUKb8PGui5xxnkyVtZ
	Fy32XJAQub+t+SzwFLlKigWSBHat6TjnsOPGyuhyMxlk18QQX+mIW3OY=
X-Google-Smtp-Source: AGHT+IGBlC6Y2UQsEwfDA57JKD4pHglmmmqBIvrxBzH7yvvCoYCOkibokaBzhQ0H82LbPFI6VU7u6+Vy6+qupuksR0kfTti7gs25
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26b:0:b0:3a0:a71b:75e5 with SMTP id
 e9e14a558f8ab-3a397cf6a12mr57290815ab.7.1728567980764; Thu, 10 Oct 2024
 06:46:20 -0700 (PDT)
Date: Thu, 10 Oct 2024 06:46:20 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6707daac.050a0220.8109b.000c.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
Author: cmeiohas@nvidia.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next

