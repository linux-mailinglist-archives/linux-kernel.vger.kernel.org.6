Return-Path: <linux-kernel+bounces-447412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769DA9F31E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A9C1884DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A28B206263;
	Mon, 16 Dec 2024 13:43:18 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5E205E3E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356597; cv=none; b=Ubc8Xa/xGl8foO/wbW5iu5+cGFPJvvXuAvASpQD8WLhITneVcURnuOOCm/a9noSHmtLsyhZRwEEwTZEAKoiVT3EIv2uoZBzSLn13hny7KsssF13lIkqxNvPB7YNklgI5rRmjjXRAmL7jVX6xeJvrgU1Xq025tOahpGuvNhK9ako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356597; c=relaxed/simple;
	bh=oYT7G5BONpJvERakHOmHZ4HZht6N9fhZaFFGhwywG1k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FSUd5StD/hP4ZOFv5fLT5KtiRaVg7fG+Bb2g4ckifr6UgHdoY5VPpnngwrpYD5t1vn66R3hGv9FqXoN+jqAxBu5yqiSTzPL/BIFwwWvibS405pw8LfW9KbSLHURAmd+e2GQLE289ZK3xJwy7akuoxSOME2o4aHaoJg1CzTlhrrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so41727815ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 05:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734356594; x=1734961394;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYT7G5BONpJvERakHOmHZ4HZht6N9fhZaFFGhwywG1k=;
        b=Ko0njdtRSl9b//e8XTLgve3vn2pPLFPol1IsgQj0y/U4RUIeM90MUmUlgWDtUekd+1
         uITQ2yrx6215OtfuSrvZsoRWwLiHEgrKwKImnwPsB6Bjw4rrK4tP6vMemgpsCgW6FgDQ
         TedI7wYWq0iuZ4f/jP5m7V2VdaxeeZXd9fo9rig4PwlnHRHOYlv2EWkKi/jCYbV9vF/D
         yHipFYcmcavz18b03JCRbScdzKIbCgBfd+LDsfjGSIEmmHB8ya7XF+tfbr+EtNSv1H3f
         Acw0aUZFTfSPGrsyDNNAn3LMuRvGS7BIfd11GgBBygQI+doj/AT7XEh66ygUhWHkQcWc
         iXWg==
X-Forwarded-Encrypted: i=1; AJvYcCVKPEJjtgjOE/Opsk26nU4Ja1/vyeLVtKQEH5H3bCM9d4wonkMz5QjMD4EUGy6DzRLn5GKz1XYwufNw+GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOy9ysqgbmMc1ak0wGBHnMesy/b93l5+VpVbtzL8jjO0k7NVv
	MJ2ZhgBWG5EugZnttrBjhAWqel1xwG0gsiFVzt3o4REDcewm1OHRXVGjwDZL15lfv2r2yBYI9qW
	rlDedpD8pLrkysAyNqJNM9KrxlyiPsb6weBeUufULB7MlvAXW4T3Z+0Y=
X-Google-Smtp-Source: AGHT+IHaYTQS9iAV5uKjNTtWIU83QEl4IVxWeYby9YiJOUNAf7IZKPQz04aUhAu8hVH3P4x+3MPB3iSoevPLJyh2k4yT6UiQJCW/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c267:0:b0:3a7:e286:a572 with SMTP id
 e9e14a558f8ab-3afee9a63d0mr139641835ab.3.1734356594438; Mon, 16 Dec 2024
 05:43:14 -0800 (PST)
Date: Mon, 16 Dec 2024 05:43:14 -0800
In-Reply-To: <tencent_0C51664E3C61368097F836764B8274597609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67602e72.050a0220.37aaf.0130.GAE@google.com>
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Read in ring_buffer_map
From: syzbot <syzbot+345e4443a21200874b18@syzkaller.appspotmail.com>
To: eadavis@qq.com
Cc: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/ea1davis/linux.git kt/syz

unknown command "test:https://github.com/ea1davis/linux.git"

>
>

