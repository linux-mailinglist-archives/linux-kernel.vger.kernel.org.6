Return-Path: <linux-kernel+bounces-412563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 795DC9D0AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316501F21C42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1EE17B502;
	Mon, 18 Nov 2024 08:17:41 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF61C170A11
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731917861; cv=none; b=JOClI7Dmspe53rRWNFreADBjWqdz1t89XtCvxHfCeCIYdvFpFyHIqP3nniN74mlbA0SAVULVX7U9MmIXrKjFulXHh55fSGoxkXt791ULP5mENMHNyQid4GjKp5N6ad6wicTPAeSO8UI4fpmOSBuyLF9GGP0iVo444wIJ/t0DopE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731917861; c=relaxed/simple;
	bh=u5RhTCXMLynqVSsvTrRysZOcrUWOJ3K+sfE2xOyauDQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ogQaLL9ksWvH4VJpsloF2ff4di90MoS20U7P8qdf7RVN2udfe25AQS6dRr81La00SJqsh41SOiwqH3iF/ug85WskTj9lijZ0/ud9piUcVPxLGDgBi2LLjD1XzwSFbhqzCCChFhpUI7uQ9YZyW9DSMuJ+/ZoN/kwhDztOJcEvGwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a75dd4b1f3so12651505ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 00:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731917859; x=1732522659;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5RhTCXMLynqVSsvTrRysZOcrUWOJ3K+sfE2xOyauDQ=;
        b=GcRSWXJvo9k3TnAZnoNsQA49fOoQxrbDCc2bsnzoY9VUxf20iWwvzwTyayY9HJSysn
         mh9ItONwd2KvH2QfuMXt5pv3t3iL1cDleWKwCGXgfq/GCNTldsuAGu3d7l/uI04+4KBE
         fUMZoQngzb5QgUVGBoSGzuO28ORvNqHCK7euiCtfUaMlFbNgfEzHQF8Mgv8tkLwgBUGF
         MUCefwxrwcauyIz4pQ22pTtph3RWhZDeAuSNM4bMlYDyqFHDHaO9MS7oIcOkP3z6bq0X
         QhPMGDlGDRZVJIv6gmHJ93wUXhRnp9g0yZowDcOib6bEzXeO80f8gPOqpTkr6VsUNLrL
         QI5w==
X-Forwarded-Encrypted: i=1; AJvYcCVfFQmku/L0cHhaKuGTZsiEAhqH8D+GW/Zyl/FBkODmwuQnQofw2zbLt4FYyFfzQrgykdTPC/g84jMetuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8KRkWSTBsuk45AAeCuIf3CKBIjk05T6uXgGYQS4aQYO+zHsp
	4tjkO96myqqqm9nhqnQ1h2cj+UdDMzNEAakyYoKbwMzqzfXRVfTpg2s/paXJKhLLlcbJGRLnZKm
	PECVI463Ads4eQn+F+qH/gsDHZ/PlmsP/yzKtBwVDPLXCVo4NVhOct00=
X-Google-Smtp-Source: AGHT+IE4690Te8WI2VGqmxrZL+FjUqEVNMfKaVQ4G2ZI6d68A89Ihkkp8OCFYbu4EiSjKAyFHZBbsnlGbGt65ndisksXJl15aII3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3a7:6c6a:e2a2 with SMTP id
 e9e14a558f8ab-3a76c6ae540mr12489965ab.9.1731917859223; Mon, 18 Nov 2024
 00:17:39 -0800 (PST)
Date: Mon, 18 Nov 2024 00:17:39 -0800
In-Reply-To: <CAKYAXd-T3gnugL4MyvArK5dONRJsyN3X6skbZWFR43V=h5bOzQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673af823.050a0220.87769.0026.GAE@google.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in exfat_iterate
From: syzbot <syzbot+84345a1b4057358168d9@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

> #syz test: git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git dev

This crash does not have a reproducer. I cannot test it.


