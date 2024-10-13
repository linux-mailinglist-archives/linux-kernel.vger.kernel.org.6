Return-Path: <linux-kernel+bounces-362782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2099B93A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC49B281B1B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C951A13D53A;
	Sun, 13 Oct 2024 11:44:57 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6301E495
	for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728819897; cv=none; b=oRGJRQaT5QdX3On1m0dprfkTAkGqJQI2nZhSr0GJ4iVxTNMVkBoo3gELRQTNywcmorgQzhqcj5UsE8m38276RQ1W9h0xxrCO0ghR2JpzT3Fwbi2h0vz9jXP8FWMlZVy4bx5ZBlaQvAcdtn7LbG3V221ndMnMFN0/6uzRT6Nirzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728819897; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BcfB6xapsFRqGPkCp82JMxXuAGYjCG38/SVJHMJ3fA5tuSY9U609UgqLVqelbxSJNoLb6qtnEnWPo2ubbfj3GVcUokjO/LOHNFOL0Hc0dUDn+iE17gpapvvSPY8p3XU7B4YED+MBcO+I6cGZMbP+rr3usqYdLsOzpYfmsUlec/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3b9c5bcd8so9376515ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 04:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728819895; x=1729424695;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=Y1TcsG1Rvz+R2StZ2U4Ib2QNOIwKjYbQyhdu0DpkkS6N0JPMmpA2mxQxoYynBu4eJ4
         rGg7b3Qd2DZ4FjxHhc0gavpoZ2MsSkqnT4uPFP4CDF8D/rQwP3iekG0Ur4wRYoYdjcyk
         t3CqAJFrtxGSOPpgVlmODaOdLtd6qDuGshpIbFJpUE47hGul7e2XdYEfazgZLi7zh0AI
         2GoQ/cs+WIoSakzlPlyCuzmc54PsCimY8saPOyQsWsmoqSNcGUplJBteYjwphx2NtcOF
         TYrxmz7gA9fynKb7fvuyiyhTVDuWli4SCJyOreOs7cFkj9jm84SWVMigM8JeKXIyzYya
         OFLw==
X-Gm-Message-State: AOJu0YzarTIYtAiMJWXaHCBRHa1scJ/67qFC9AkNgY37nsxjXfR6qQnn
	RkAYg+d73+cauz2Fy47MK25OtukrOn41326mcpRpZ/udLFvcb06qarbzn7iXGH6rmSogigA+kgu
	yL/Z1m6Uz/yXjBx3ByazdRtsFU8t5tXVvBZpvaGxSVn5fJouyEdwMkbA=
X-Google-Smtp-Source: AGHT+IHDnZy573VMABAtTOJF2H/Wq3YRhdru80lZlCKtYAhiDkgFk0RbLqkg/bITWubNCL77+XNg803PAXFY3Bj+ibQQ/xgPTeQU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1548:b0:3a0:a26f:7669 with SMTP id
 e9e14a558f8ab-3a3b5f28e2bmr62801025ab.7.1728819895308; Sun, 13 Oct 2024
 04:44:55 -0700 (PDT)
Date: Sun, 13 Oct 2024 04:44:55 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670bb2b7.050a0220.4cbc0.002f.GAE@google.com>
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

