Return-Path: <linux-kernel+bounces-327579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143939777FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D065F287174
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9D1C2DC1;
	Fri, 13 Sep 2024 04:33:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5B18953E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201985; cv=none; b=UhmHlMVGxc/8Ynxjo2Zcsa+bi5eknMuRgjBR8s6zSkuETdtnvcWgeStuTeM3jIgOLylJEwGe6cvehdRQHxheN2YLBazJHcvmFOPbqazYm3hc9rdSGvFOPJOKBLzyNvNRD2N3HZ+ja2tSHVQS9iYYYyvvl69qyn5saTwTo3yZ9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201985; c=relaxed/simple;
	bh=2H6qRDsFZ6gQVwZL1U420zXElg82kq3v4kT6C8EJJ1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hhlCAZOe8XbYYY74jVe2J53NCofQ6vW66QgDkev/BAISUs8AVIqxM3daJ/DnKW4ancLyTC9hQl8rcl+sPI6mkPqPMMc0csKqSctAmF0rvKj0DJ8WlGH2uMmt7Ywer5gr+THZbX6YqGrxDkRZKO4JNokUwtbtfgTNFnPhsnLpRDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82cdd759b8cso174921739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726201983; x=1726806783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrpnmf/E8ZHo59qK33wU7D6XTmgLd3Vx0rgzOckSBrs=;
        b=MGuHNfLtpJKiB+zLASfNLFlY0lTOIgoEvB1N0lSH9jl0bAEEsrQs06LAx1wMIERiVu
         wPZUXDflcn0Ctnq+gtWwIU9scXR34R6l3suG9TZyhnQn+8Azl6mZuxRQ2FOTIQ4Wa3NM
         KHKeZDBEts0t1VRrElZlLYlD57Bs1FCGo+/kv7OyDTKZYQ5vhoTc940hTK9p02PfO3D+
         PfCri7gLASK31yZaU3LYq8/0RoRzTnAO6v1cuZjV3b+V7x6ppGoOHNrRWdIlrmhh0hGm
         eBo5y3RnYdpyg8wxyQgVrdfpOpUKSIqXGqk2E3Raxy6nD1oTLiGcQFzTGq3hFHKtu7Q2
         UlKA==
X-Gm-Message-State: AOJu0YxC5Q6lF66AY+HuD3XRb/ycjPA4ve5jN7M5vOU8TLOx9o4QoaPi
	g4aVfj+j1vK5sm8TZ3W/k7F/lFzgXuCHlWWxky4RzzjIVOi+bOrV/3PKm98BPg6exQUtt8A9bja
	7yZ6OdNcAmHZWtlDWymxj0eP5tOKVxVAqqRT8211UzD9KVUpCLqFvtno=
X-Google-Smtp-Source: AGHT+IHjKRgFZkrGYS+lf6mFhO8mzMCO2izXnV1p+OdTZHxxIy8wIo3OyE8ONRQcncykko5nheKg6Af4hL/TUoigj+yabvtebeYL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dd1:b0:82a:185f:5940 with SMTP id
 ca18e2360f4ac-82d20731b9amr427730039f.7.1726201983464; Thu, 12 Sep 2024
 21:33:03 -0700 (PDT)
Date: Thu, 12 Sep 2024 21:33:03 -0700
In-Reply-To: <20240913015151.1862817-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009095b0621f8b896@google.com>
Subject: Re: [syzbot] [net?] WARNING: refcount bug in ethnl_phy_done
From: syzbot <syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Tested-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com

Tested on:

commit:         b523f23f Merge branch 'mlx5-updates-2024-09-11'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=168cb807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e10d80c64e440c0
dashboard link: https://syzkaller.appspot.com/bug?extid=e9ed4e4368d450c8f9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bdaa8b980000

Note: testing is done by a robot and is best-effort only.

