Return-Path: <linux-kernel+bounces-318687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7615E96F1A6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD401F24016
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDBD1C9ECA;
	Fri,  6 Sep 2024 10:38:36 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCB81C8FC7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 10:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725619116; cv=none; b=EtFd1KaEVUFeAS3LQ94CBLDNrC6Mj+Vy0Jvj1HA3lTk15Ed47M8VketIctridYApPbycQ8XA3OAWoC7V5bErzj3A3VPsPiPBWzNrt0xoRV3cOa5xCG0CPSp0hwCQNnIW99g9fJhxVeogcsfU5D7to2lT0FPC/Kr7Ob6Q1CJL16Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725619116; c=relaxed/simple;
	bh=44RPfV1AG+CRlolW33BYa6Ykb6TrFQnmmkbIjKCIpns=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZG74ywLyEmVGongCZoY5+i7aRvY0zGwddMhXdGG7bhhadVMLbmcMS5Ns74RiuxdJwZGFYeKNIHDxRbzNH4dMKTFCKh/HuXVlOkFfeYSu+k2XI5XCmKri7XUzaFdUi1ylovjJauriHm9SszFFFp0tmg/a+FQ/opvnYKwFuzxD0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a1c57f4dcso452942439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 03:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725619114; x=1726223914;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85dhWDZWhfBo77QIsh1QwcrLtkFyzmmAhsVan3y62x4=;
        b=ojzP0Vt8SLQqzGwkGmYw+3LYDIJQ4Rob17SjlzBr8J61JFymv14oqksqlO3Eqf10Cs
         sUTsE1iji/EmIo2z3fp4Ue8gvlaLNRGlMdysfF4ZR0qiZ2Mwqqn2WX+NXoysknblct5f
         5Tl3/PtXDzxvn3SvFCIjl1Rl3rpmzKzHeVVTO7HoHJyaVXRJZ+gypLqJDyNjhYJG4Las
         FQoe94cKspexuUEfyugwP8T6nLtKkEeN027h+wYjGRD0KoEYhPwFL85X1oTShp4oaFyW
         pMOQAGRMQBVv9iBqLkZzs+XTzElQ3feLXuO5LNnRuUDYFvbWblNmiMfwrB6a8TpDkGeI
         YYVQ==
X-Gm-Message-State: AOJu0YyhQtUOXdntwTmGsna7F/49oHMDz8NTr3BNJtN26bjX36DsYFXE
	Bz8EUuUGQTJ014450dOjeWKZWHNiPIeAfZlkeRu3z+1yEAVJ2ASN8aiJWzjQ2cQ3XFTIBjs2jvo
	IZkRsqYqUd76yslFeKAMVoiM6TC4WF6/XSOC+3V9/kBs2fNpPNox9HC8=
X-Google-Smtp-Source: AGHT+IGoHClPX/hA0BNATNUv5s+/vwN8qYu0KexGoXn660cASCGMMZjlw7elpPxc5iB//u5vgRbsTbvqFgkhq+51f1TMgU2lDVtJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4122:b0:4b9:6637:4913 with SMTP id
 8926c6da1cb9f-4d084f961b4mr108661173.3.1725619114121; Fri, 06 Sep 2024
 03:38:34 -0700 (PDT)
Date: Fri, 06 Sep 2024 03:38:34 -0700
In-Reply-To: <0000000000004b632f0607d07fb0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000050a7fb06217102cb@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+3908cdfd655fd839c82f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: nogikh@google.com

#syz invalid

Repro triggers a different kind of an issue

