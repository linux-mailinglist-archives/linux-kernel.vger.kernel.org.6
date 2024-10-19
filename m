Return-Path: <linux-kernel+bounces-372961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409209A4FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFD61C225D8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B18188CD8;
	Sat, 19 Oct 2024 17:04:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F742772A
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729357448; cv=none; b=Lcuzd9DgSu9LvUzNLSh6fw2M5SBsRMBUj4uSU6Jo4jRAI4B7lEniQHBhE5Qi0FEr4GwQdbqM8L4PoUcmMD3Ho8JatPJXHsZiYdG/VUsq+ocftT4loDu31RNsKi01A2Ij2mQ/nsggqgCeNEyydVbn6RSlmVQwnpM2HulvT2elFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729357448; c=relaxed/simple;
	bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LA0bTlPbrSIeO+pqNarG3zeZFCVG2OaK230dmvDwcrldPhRXd8osKpy2IP6wOxIUP5rfgO8eWJLlyXuDaFdOyILCgHInMJNfUVW0Pe/W2WsLwqO46z4GMcIOo0g6h3voBcz8iR5hGsJy6NlJi0dn9dTVEepxAHKMqPRiwj855Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c3ecaaabso33563605ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 10:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729357445; x=1729962245;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhXQFHs84V8s6kt/M2mBog53NsfNJ/wX6DTO1iRzP/c=;
        b=DylCH3+b1QPlT8jGdBCeuk71xHAyXlxzFzadvyWHOgOkyNXd0ix1JhLwCjgcMsuNcO
         QzjMZ3cfknC5amES+8RfBclHZy5qerMXFnp5W5GkTTEJlij/2dUuHWRJ1kfvBftxlVwp
         4Y4wUjapiTZo4PpbLyfw1o+wn/StcYhdlonKwOS9lhJ2EV8JbTs4nRu/csH/7ccumSfh
         A6TK9VkC+J9rV+WDldTB4R+HD9wk5YdoapXM9Fqi14B6HXd+CaXUDL/z8hhPrFsl2xma
         FJoHwTbDlZmKPnMgCTDyB5p0Y74dztdGG4/t9pqS9X5NAmNSVu9flLYBkoI6ptzyZgrb
         NiTA==
X-Gm-Message-State: AOJu0Yy2uYwEu6RssGNkfn0yFER++jlKuaOUiwbmveiGN+M4Knf8UXAR
	OoBEeEw/+FYFBVg+szTNYEPt3JcjlJmd/utxki8WpgIJ0qd+iuTbS5ZQAqx5cD+T9xiE1OC8Jbj
	SkBmDjLoWpVs87N2LzA13oqKgnyn360UdlaqBdSc+5cTHHFNcB9FFfvw=
X-Google-Smtp-Source: AGHT+IHyZbzJwvrgifDGKE++xXUmZE7AoolsCw3NAPp9YOo8WHkYaeA+XFHDVWRX8hYu1MZ6MTtrWqWaFqyV8ZhbtJm1Y3TUo5rn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8e:b0:39f:5efe:ae73 with SMTP id
 e9e14a558f8ab-3a3f40500a4mr60067635ab.5.1729357445564; Sat, 19 Oct 2024
 10:04:05 -0700 (PDT)
Date: Sat, 19 Oct 2024 10:04:05 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6713e685.050a0220.1e4b4d.002a.GAE@google.com>
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

