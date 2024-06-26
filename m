Return-Path: <linux-kernel+bounces-230253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2EB917A66
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46961F23639
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89EE15F330;
	Wed, 26 Jun 2024 08:03:43 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2E01B950
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719389023; cv=none; b=M5OLDF6UgN7GRp4PiFeMUzmxKjoBDIUxPKKYuP31wMOC/Cm6C1RD1F2SN2h4SvipwhzyEF4/3iIN0YaPT4AF7eID9Jp7sm1XXtmS23VV5S/mOcjodRmLx2VMIOMFR3+eOYPrQJJnn7rSn0DxFeN+sdp33Z7PsrwnNCz1MXyECjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719389023; c=relaxed/simple;
	bh=0Iq2PyMNAL6c74zqNAICpmgyaVdJPHONyIbCIxKpaI8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OfnZCMxmK9HBWTE1F+QGtczdDMi4wnh+swedyz7uYWFFsE5TRe39roBIS9XkIFHy4NIZ89GJjGlTYpp9rdqMB5k8Z6JKAicRP/ZTuhkWv/NTUBFRhT9dIn70DCDPfjJQknbnjwoPg3iNLlcp5dtxKh4+GC6kklGXP8b+lUKnTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-375df29cb12so80098645ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 01:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719389021; x=1719993821;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Iq2PyMNAL6c74zqNAICpmgyaVdJPHONyIbCIxKpaI8=;
        b=tWYzz0PgFEOhESedVUynJIKlaYX0NUgEecT7UzPtMB7zvPKLtqMBHuF+GuWuDHLViD
         kTvpp2Jr3VckDHD4SeKNrtuXel8I+FHZ5+VNcyG6SU8n3fPcgP/ohfJ49/lqRCdXITx0
         Bmb6HgvBbfT93It6r7udmqInKLe4vXRjhAuLrHSnYvsFDddykTxcQyl6XHnBtKzib+UJ
         Te/0WF/wcxX1UnhEOQh5x2XYukcU9PZMe1mIVLKx30jxxJBCNGVm92SYBIUaP7Uw6KL+
         o8MS8rwxq02Y1i7nZOrAnbNOkA4QjW6pxJ8h4oFUfLOaQZffFnpEDhoV25TRWWEfQK+n
         tiJQ==
X-Gm-Message-State: AOJu0Yx3aE610WA2lobJdOxWFyjIdASZGbhW6aF/gwcVKGCpaUN9Qa0x
	DvfLClVLfDjWkSLEPV5YnAZlkZhGnH0nuXta56gxmfA9CzjOUs4u3NDqyF82MgI0nIMuCUx8g9O
	Uxg6g+PoRN0LSNQf0RpZ3ZibkLkF4ViIGCNHxz83U/VIFZ6yTOWRRBLk=
X-Google-Smtp-Source: AGHT+IGLYVygi7QGxO+mGVuxc8cbxoI7aAmsIqPN1xaP0SeJqW9w0aPP8NkFIw1byyl/vfUsqVg2NRCydLOnlj5ZBr9UKAjotlnn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c268:0:b0:375:8a85:eacd with SMTP id
 e9e14a558f8ab-3763f6c7aabmr8690575ab.3.1719389021245; Wed, 26 Jun 2024
 01:03:41 -0700 (PDT)
Date: Wed, 26 Jun 2024 01:03:41 -0700
In-Reply-To: <000000000000aaf7ec06186a8d13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d79eee061bc67335@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __ext4_check_dir_entry (2)
From: syzbot <syzbot+11af34d3c0711f233fd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KASAN: use-after-free Read in __ext4_check_dir_entry (2)
Author: norbert.kaminski@infogain.com

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e40ff213898502d299351cc2fe1e350cd186f0d3

