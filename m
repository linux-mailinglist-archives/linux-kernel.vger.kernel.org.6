Return-Path: <linux-kernel+bounces-297749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8095BD16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC7651F234A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BF1CEAC6;
	Thu, 22 Aug 2024 17:25:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D2F1CE71E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347506; cv=none; b=uM6cDziOnXyHuq/3watOLutYD0fcaGI7OMYjAagLQaQ2kNi5vTufMULC4lS8nZLGIjPyPI7DhKPRfeWJkCMhq1KfVDSiQ53ipFZ8hVdykXPLFecfEe+6WtytNaYIzRFLUtJYK7vakgx4daDfn11BI+sVd+r+FC48AfKgNihXMd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347506; c=relaxed/simple;
	bh=z8aZsxpqoaAxlknW4G613SmjoRW3PhZn3pSJY8tRyp0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GrsnmcvSaKq9Fwh9lenkFNCSBZSAjL00xj5zdYEDi2I9lU0Qy0EMKBoFHCESlopPulgjOCPKcXwtt7F2tXNWrcxEoY0PVbYlK1ym2ltzwayClgH9XVrIpMdMFmZdiz4txYmatu3bOEopP/EdWgJdk0Uygj4kuBbKb6WFqqZpKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8489097eso102007639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724347504; x=1724952304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8aZsxpqoaAxlknW4G613SmjoRW3PhZn3pSJY8tRyp0=;
        b=p7YKrZWn3ABuasoFuazNjRa/YalJgsVe+7QTtO/cydU4gRUl7XfBPO/Fp7XhAZe7bp
         f5ICHEgAQ1/0HTyi/m03JdC5HgMFNpcFmoEfKVAYnPf/Xq11oIupyt8Qg+YY+X+UvMxC
         bUCqQy55dBCtUPsCzN6CKu5Lv1o/q7hAwBuH8qjiVCzdcfnkeQpuJTusGsW6hGur8gXQ
         xvKuuXGehOvY3svpvoE71Ujrm94a0IqoxD2dEUnT46QOUjki2ahomX16XbqPb1g+vlLX
         3la/5t5Wkvg5xLulQXFW/m4LdFST7c5sNID2pfRnwUMAonjyGH96sLTHdJA2FTYSDCbH
         +jLA==
X-Gm-Message-State: AOJu0YzoWFECE+aaB7SlbgfUi2gLav+GHYhBDA8V5MnPDoKsXT3ucndg
	0/jYyqB90E9N3FclLGSJm3FVN3Zl4t0yt94nfCsypQmZILSz91Vgsmz+7FPDzaMAWSm5Oodq7Go
	KakBIxPW8AYfKN7t7gnv/Ifip0T/6MFNVxix+CBx/Pd9rdczR1+RSaOM=
X-Google-Smtp-Source: AGHT+IHp9qNrY3y97CkkFOzLwfG5bKJCl5OkqsjHtAzLbcm62JrGKo417p/8isEiCvPoGcRBGOVzqingMVoSB9/Y3uRihQ20b0vv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8717:b0:4c0:ac4e:3295 with SMTP id
 8926c6da1cb9f-4ce7f610065mr21051173.6.1724347503863; Thu, 22 Aug 2024
 10:25:03 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:25:03 -0700
In-Reply-To: <000000000000ef1901061ad898e7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ffadb062048f0ad@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_readdir
From: syzbot <syzbot+b6e671a90975c257b802@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: KMSAN: uninit-value in bch2_readdir
Author: kent.overstreet@linux.dev

#syz invalid

