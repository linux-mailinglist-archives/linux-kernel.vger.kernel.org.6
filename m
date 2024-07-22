Return-Path: <linux-kernel+bounces-258760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8001E938C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2847A1F23BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B23C16CD03;
	Mon, 22 Jul 2024 09:44:29 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001C161314
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641468; cv=none; b=YpmFN1+bg/bK+7alkjzSzJzqIk3kVnM14Z6Fa8ymO86+yxfZOS3cRyPc8HnhQZedF3qfKqRcAhdVUyDGjzemhlMzFJsHTHg4Q/xl5PLdFzC6O/hamjqAm/ZI4K6m5eWCVpskYPeykn+pfThyV4HHsnyJx6y05Df+gOhaxc/ZtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641468; c=relaxed/simple;
	bh=+UemyPcrn1k4F5pCbjelPj0vMl2rApSZCGGX13vszYQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uAZELDrPiTdTxAYSn86dh/Q4+fZDEu4eIr0xie+yyUnERyqQJPqnqK4NBzuNrgtTcswPhZo5mS0EYjmbJPzwFNshkUupMQTxNwJsFaa67fCEHfCjpJtxB1krhxiR7igvkCG+32LHQcmwQQGoEmO2RX4TJn6QkrkVhnrcdMclYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3971269bf67so67336985ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721641465; x=1722246265;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UemyPcrn1k4F5pCbjelPj0vMl2rApSZCGGX13vszYQ=;
        b=PCiErE0DmVluyXXY2E1X4NVPhm7rrt/ZD9c15WNBqbv3ZQQsj/pP8KoGTGLrSaPH9/
         Os6meehl1Qf2c1Gkt9GBO/1uyzjWuCJeMOuI7w5czl/QwgqCnon1J3d8SGtXshfdx/4h
         T6wgbdq2hQYYJoezuY7tKMcPhWU3AVp68bCUL4AOg8HDzr9sWZh9zk42e6mIlOXZQsi0
         ZRxCEYeAe/9DkxatxuB9zzxabVwr8LSlYrqzQ3vWzPzlFHUdX8SxyOz6J8s0GWN5ee+V
         J58ABMbl2cn7ahj2nXOD1Exyk5NcXw1reVbYm+HZVYPnQZKHtEaHGERiqPW4iYt/IN8l
         y9MQ==
X-Gm-Message-State: AOJu0YxOJjrco+hCJvPAFuyUFvd4WpSBrwzer3qIf0z7lCDsj5JhIC5i
	YpinvxbDzW6qu1ibMEtmVJgd5nCOf4+R4z3s1AYS/CfrptIs+Hehd/+ZRu4RRpmtLpj5MhG7PRy
	wlnu9N/LUZBT4LTgGeoC+7U63E+M4zFhhX0Fyhv8ZnU6ZtuLDOH5CHZU=
X-Google-Smtp-Source: AGHT+IGYSJ9NeB7HttUZ/D1CGOTJvV0mC4tJ39eIPW2kL0OSd4ohUvy2Ntz9h9GYqS3pdqHxJufpFZPDka6fN0xKk7u7c1TBspyn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9b:b0:397:2946:c83c with SMTP id
 e9e14a558f8ab-398e7351f93mr6808305ab.4.1721641465661; Mon, 22 Jul 2024
 02:44:25 -0700 (PDT)
Date: Mon, 22 Jul 2024 02:44:25 -0700
In-Reply-To: <000000000000943e1c061d92bdd6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fddb9e061dd2e3b8@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free
 Read in bq_xmit_all
From: syzbot <syzbot+707d98c8649695eaf329@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [bpf?] [net?] KASAN: slab-use-after-free Read in bq_xmit_all
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fecef4cd42c689a200bdd39e6fffa71475904bc1

