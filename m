Return-Path: <linux-kernel+bounces-312914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D85969DA4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0856284ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025B71A42B5;
	Tue,  3 Sep 2024 12:32:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4631B12F1
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725366724; cv=none; b=IWt8iuBKiFuzeGN5jBkVXU+OlUnxqLy8HVVV1xw89DqgW9iZUzcD1kFrzLOVT93EhqSNEi8V/7xmDsdHLF902ZyIaCjQ9qjnXW1o7FpxbI0GBIgI217nulDkzahRd8sO1h2jHBwNWO5AJZeIqyVyfHfr5ro6rgXgCSgpAjVYwio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725366724; c=relaxed/simple;
	bh=wJvkkAwFqkh9LG7i3tDrwGeYoqWiVtR0TR3aaaHgIaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=flGNncRR2SC+u2S/XdJ6piL25YVZVSVusxixSn0hGYJw0jSgelvbqrihEcviXkNHXkmnXgE6lrGx+bvm7a4oeuf6y31irMW98BMaDEsKphH0ufNuX6mbzjBL8SIejezGygIh3Ify8Ro1ToxoY7/pKd1uSV6SARjZ4pRudDDyEA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f53125f4eso24621845ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 05:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725366722; x=1725971522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73CfKD8IJsXt8neaGQU7/N60BW2ml7fVPqmUt7/0+Ic=;
        b=rRBVLbo2FkGVjIv1vo6f0iA2GOyDVmsRmj7410Bqj+DDnkUj4i/KDq7M+YgQnTkj0U
         rnpN0NJ/a49TqwBfi7S0WWHHtNDy14RGQ6xatbLsojrA4h++CnfCmQJs0GlmoFP7sD14
         /V+RnofkzXnlDiCE0UNoGXo6iXdfQfsbhUP/7Hi7UIkBRLu/+Vv4+qu/tyIffRHyegMG
         bBInuVCRYH0ElnHjLbYU+dl+e03qT/GLrIluYa7XK4XJo35iPrxmKCtyjVU9+FN3qE0A
         Bx6HulxN8OyUfMmSgHDfa1p0cRgeKOlM4R0QVMnp1viNQjZ0omjEzxB/tEwLy2tLGe/r
         uWLw==
X-Forwarded-Encrypted: i=1; AJvYcCUXZ4D9RIDxOJDdSFqqcmDQDCTYGsAKTOf4CJP6z6zocRLVEMsExwYLYv29nAAWl7RoRXOe96adbJhgosY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6mYHKShc8Il3JvE8kIdh1t3Mg86DT0uQCTCBKRHuaB7/toQcm
	+gYFHIuVewo6ODYmiTOuwym+89qbMzYSZartqHFOHlQ0O49xc98S0E9OKjq4xutQHhzvhiN8dT3
	Xuw8IL4cCLvToNnqHQdcak39zbAIkpK9zU9/iR7sy+DzmQN7STO/anro=
X-Google-Smtp-Source: AGHT+IFDB08SISapjhDvQRPxgF7T0pDDXhwUAoTPI+gGkKaLPrbec4TrE0dajdrtP1KE7sZilxfNk6WkGc7voOecMi/GmpU/X059
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6c:b0:380:f12f:30de with SMTP id
 e9e14a558f8ab-39f40f03924mr7659335ab.2.1725366722399; Tue, 03 Sep 2024
 05:32:02 -0700 (PDT)
Date: Tue, 03 Sep 2024 05:32:02 -0700
In-Reply-To: <b9efefaf-76ea-4ffb-8601-ad83b593ef7a@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098a0df0621363e09@google.com>
Subject: Re: [syzbot] [ocfs2?] WARNING: ODEBUG bug in ocfs2_local_read_info
From: syzbot <syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com
Tested-by: syzbot+f7af59df5d6b25f0febd@syzkaller.appspotmail.com

Tested on:

commit:         8efd4bbd Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10dbfb47980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d29b390765df150d
dashboard link: https://syzkaller.appspot.com/bug?extid=f7af59df5d6b25f0febd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12198963980000

Note: testing is done by a robot and is best-effort only.

