Return-Path: <linux-kernel+bounces-429747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF989E2AD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEBA2BA7F59
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739E1F76AD;
	Tue,  3 Dec 2024 15:28:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95B71F76A8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 15:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239699; cv=none; b=lvgAfDGfOuvDv8hxER2hr7jns2orq1kcjr0bt+zzwQZuc7apuRTKdobYfehxU9Ycc1psncBJTKj2N5NfNyE3O3G5NNe+qwoXfAuLEzmGdlqqe3IW8gTZVClSnWh7aPwV4f+q9c5Z2QNqkFiux9S0M2wsQVGZWWxM3+4buG0QC4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239699; c=relaxed/simple;
	bh=KKArLD2PtA+0fQiwv05bnHE0KuyHHIErcEbFZSDiyew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bz9r9BZHE0orp8YbPLcShc1jYU+SYHDtuH6itfGF6Jv5vpmm3hXrBjxvinS1rh08TeFshKjEnfkyeiovXchFxGWKyDhuE1OiqpFmUJ6J1Yz59/xJnwpHpYh+9nLLv+lSx3sR234bQ6cJeal4bipVo1+GAK0/DJSmCeZudaBZD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7c729bfbaso60249705ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 07:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733239696; x=1733844496;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szv38NxdIHplzP9jE1syYGjbmBichZ65BAZ5VuKYs4c=;
        b=QHYGikyYheWXlMELe87wIJli2C+Y/i5LNTe+1+5Ebl1zfCGZIOTSO48yJgLbR3vLfP
         dHl5Hw85TmVges0CGewVMPeGlMPFITFPJuNBxW3U9sRKBZuX1L6XVtU3Awezlbmcf5yS
         2eEVY5BHOBlVn/bbtYTK0glWSZ1TV3kypQnw643IOu/VcxcklHddTJ5IOlgE19y5orti
         RgE5awEB6W5G7aLcCdUL9HHmrXoQZ9pX1xkGpMDoF2aMsaL5EyRw/N5DIzAKOL467S1K
         iemV5arHAaQX2sdisB9oIgTIhB/OKlCl+qg/shsLHIS8ghvcSBS3Tm9Snpwv5b7H154N
         p/AQ==
X-Gm-Message-State: AOJu0Yx+nOH2E0Z8saO6OZGuUFzkOxCM9bjofcpTC1M0cM5MX7UXGrx/
	7gDNTM6lhEYd8lDr4ej9HbYhWY2Q5957P156u77WmBXZMIco8Zv9wnPSlrr0SSZVCsXsxnrKuvv
	ii13XAZhCiHEZabElc+XSlCeniUpTsMdkobSWpVaBXF29rm29rg5lqmQ=
X-Google-Smtp-Source: AGHT+IGGghU1f+T3bgD6X4cCYNtk//AHyzTcS3oLLJ6CAUMiYKa64MMjFBqCEQb4cTBH34ACZAlLv/Cya8tuXSJ3YSBOqDc/YJzI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a7:7811:1101 with SMTP id
 e9e14a558f8ab-3a7f9aa4753mr41859905ab.20.1733239696142; Tue, 03 Dec 2024
 07:28:16 -0800 (PST)
Date: Tue, 03 Dec 2024 07:28:16 -0800
In-Reply-To: <67409854.050a0220.363a1b.013f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f2390.050a0220.17bd51.0047.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in ip6table_mangle_hook()
From: syzbot <syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in ip6table_mangle_hook()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cdd30ebb1b9f36159d66f088b61aee264e649d7a

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 48fd53b98972..0d4a213ce145 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1098,7 +1098,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	unsigned int max_headroom = psh_hlen;
 	__be16 payload_protocol;
 	bool use_cache = false;
-	u8 hop_limit;
+	u8 hop_limit = 0;
 	int err = -1;
 
 	payload_protocol = skb_protocol(skb, true);

