Return-Path: <linux-kernel+bounces-231809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8D919E72
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 481671C22F21
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DDA1C2AD;
	Thu, 27 Jun 2024 04:59:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A511B949
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719464344; cv=none; b=K/6s0PTGJqXWo9nEhRa0IS2xVkPRkPEdYwjKwmkTqAZxBSwkd3rJMuosWu39/MjOETHgP7RmCjWPWRVgcMeP3309vxLz5cAXU6et0+Ux6SZhk63lH3prd4v4JPfefxlaKmAF/Ju3q4MKo/hBZH1l8ykoBMXLZI4hPMQY2mstyR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719464344; c=relaxed/simple;
	bh=IkQsrKKUn8XRTQXTllxQe4gYZgzHBsRviOw2r7w+Krc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jLKeoCWX/8joDSysqKvQ/dg/RXugJVt9NxcYdXmce0hpl4wY9opM975DWdweSk4uWb2wPhHoic3dufJg5tm7gchI/jZRt5IJzR/eL/xGPJwQ6um9uHg2zEAJsEJZ75Utjfe41i+mG94AaM39CrcgGzJs1fJmV/1tRFy3OHH62ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-37715aeede6so36883755ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719464342; x=1720069142;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VsPizNXofWfwb6ytZE6j9YZ3mxWUXsZqX+k1ZKLAz0=;
        b=wVZ4Q5vcX/f85YJnT9PPFsQJ6naCXi0Urs96/SOG1OvokfhSoiUfNXySvXkdglE7mp
         KL8+mEE1j4j35t3PIs3yoGYytnrxG8PRCedLjuY5v8VBFQG4B5zTWq54sU/Pltn+01yq
         zdhYPUPqSFBohpJ4YC1K1EymG1VcV5uEl2DDLuEe2qnZSGcLbjx5XwG5uoR0G/fk6UaX
         hyoQXb3c3dNxEolILSPnY/pggPJM/Ww9qyQy803rj+4X/HF8FE0+PkduEJKkwCXeeUG6
         UrboeMV3KTzHlaKtWG4HNopckYNcCOQJEDFS+itPauDXp/peiT5hzjAOsIvU1kw4lnUL
         HYBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXn6a0Rlad8WZSOSn4x4pzCRrfIkxtnInhMrO5M/1zBYnBgEx8Fj+4ihfBfInuXhONxlODkvYDNauN7Fc5YAFX4Gwf5LuxIv4BPR+7E
X-Gm-Message-State: AOJu0Yx8kYAP6diMM3kWrZvM5LN4mbk1rCv+UhIgAh6HWI9eMSZkW1q7
	d1/TeWo+oKelmpxWAZL5PfSWKu305Pt6A41ikVBpP0FXqmgwcCKzm+aNpWLR48crkzbxkdugzWs
	cyoaNOuUXgoJG/8GyAKF/9MmU+tQ1NCjtOZ90gQPyvksg5uQGBLb+Q94=
X-Google-Smtp-Source: AGHT+IHTP9IvArud6LUgveR74LtuG4oMDICVLPPXWnHbW3sLJ/xx54WkI0jfqyPCq8oqZx96CD1XBK9MWwBFCOLfAWpwaE9vRkKL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c5:b0:375:da97:f21a with SMTP id
 e9e14a558f8ab-3763f6e1665mr12436205ab.3.1719464342366; Wed, 26 Jun 2024
 21:59:02 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:59:02 -0700
In-Reply-To: <0000000000006293f0061bca5cea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054b7cc061bd7fdeb@google.com>
Subject: Re: [syzbot] [net?] general protection fault in coalesce_fill_reply
From: syzbot <syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com>
To: brett.creeley@amd.com, davem@davemloft.net, drivers@pensando.io, 
	edumazet@google.com, hengqi@linux.alibaba.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, shannon.nelson@amd.com, 
	syzkaller-bugs@googlegroups.com, vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 55a3982ec721dabd5a4c2f16bfb03deb032e45c2
Author: Shannon Nelson <shannon.nelson@amd.com>
Date:   Wed Jun 19 00:32:55 2024 +0000

    ionic: check for queue deadline in doorbell_napi_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc181a980000
start commit:   50b70845fc5c Merge branch 'add-ethernet-driver-for-tehuti-..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc181a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=e77327e34cdc8c36b7d3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599901a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1429e301980000

Reported-by: syzbot+e77327e34cdc8c36b7d3@syzkaller.appspotmail.com
Fixes: 55a3982ec721 ("ionic: check for queue deadline in doorbell_napi_work")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

