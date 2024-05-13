Return-Path: <linux-kernel+bounces-177438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D178C3E90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157611F22997
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1C149C4B;
	Mon, 13 May 2024 10:04:55 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651012E3E0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715594694; cv=none; b=mtZLc+Er2MouR7fo61DOqyk3WYd/O/IIA3ZQEaTmY2ukH1TMlXIhH6sVSqn5IbfXBj3oGjCq7qC0RKzxaIffElsn992Gbpt43ET/3t0GRb0DjnWcT7dosoQ/mFeSxOJvFedqhDZ8lENzM1FGORrZtaZeFCClRPgK/wvSB/nm4BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715594694; c=relaxed/simple;
	bh=953fQ5AM6sKoEetlGTaWf5vNccul2NWGvW/ohI85PlU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CBhjymKCUck4Bf0cwqk4Hl43/Z8k0kM/D1IJyeBb07jfcv1SvVZpNZTPgftz7BtNDY/g2ItHs7gdc4cZwC9W7zyheCcKez7OFP4Jp0mY1UE4wAhGfdtdyhc2gYvAVSqWcoHwhsgnw9gxM4YUu02Ja8RmuTXbCdjMeFhh/dH9/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e1d807cfbaso172492539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 03:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715594692; x=1716199492;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=953fQ5AM6sKoEetlGTaWf5vNccul2NWGvW/ohI85PlU=;
        b=wmteAkNijQFipOfk2AJcvjJv3uHaH4kjWFSrnBJ3eL8V1eyf9j4OyzrnI6uY+m5UWj
         TCdkozK9dO2Ejvw6ga2451E7Ub+WJ2pC8Dkq2q9wr1UmG1rPHBb5TeKwcoIv5yxCE6ZO
         LeJmh094JRIkxMlLOpxyzTc+t1XiaI9mlRD4dV219VpFFO0ZGG+OGY6VUlCWdNHrCqzl
         wXmsutOFoF3LDWJa35ul67yp+K/UR4O7hyy+LBbj2Kokn1vzXcUcU4qIy9rEtkpwZrlx
         ysSXFQ/8L7Bc88TShXUom6YADQ7xklpnsW2aI/kyEqvZk/RlVNTlOpalYL66J2JncbHu
         LzVQ==
X-Gm-Message-State: AOJu0Yy3TQoCiQBjwq3y9Af39gGiQn6ZoeCMrlQF9YFVpYeupHPUE1MN
	xoqbifvMlchHfidAogxPCmST0aDhFuhDEWXq/PY66sJ96qNJjfiSTywUnBkVOxF336t3LgKzMId
	waqSYXLL0JCmKHXa3qq74ys6VqRLHmphKdv+B96bi76eAaiADM3aTvsQ=
X-Google-Smtp-Source: AGHT+IGrU37wkl/WF2dmvhllDsW+1dhc+9wL2xhAQOaVGOnlb4cHGO6nZKB38JfAudv1qFj9K9j+kECacbROhFAtKU/y+5qvrUoi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b82:b0:7de:d6a0:dbe1 with SMTP id
 ca18e2360f4ac-7e1b51fdb00mr47943439f.2.1715594692588; Mon, 13 May 2024
 03:04:52 -0700 (PDT)
Date: Mon, 13 May 2024 03:04:52 -0700
In-Reply-To: <00000000000075b694061852136a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b06f70618530414@google.com>
Subject: Re: [syzbot] Re: [syzbot] [netfilter?] general protection fault in nf_tproxy_laddr4
From: syzbot <syzbot+b94a6818504ea90d7661@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] general protection fault in nf_tproxy_laddr4
Author: fw@strlen.de

syzbot <syzbot+b94a6818504ea90d7661@syzkaller.appspotmail.com> wrote:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/fwestphal/nf.git syz_b94a6818504ea90d7661

