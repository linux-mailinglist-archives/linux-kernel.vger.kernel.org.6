Return-Path: <linux-kernel+bounces-375218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BA9A933F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE6C1F22D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02A71FCC7F;
	Mon, 21 Oct 2024 22:25:56 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD31E2839
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549556; cv=none; b=A4hiZRugMAy5Cm8EV5V8RU3UmJ9eCnaBpLgQnhVRoPy6IFqzMcAbKlVLn58eGITgoqV0pKUBWgQbFsE9HAq2iHZqTq+HfdgASMNLGXnJjQMW88yhHrCMXlyp5OCADT5Q8mIDFp2DfNMOeZ6Dr3jHpovy7rasIfl9eE2y6RLXJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549556; c=relaxed/simple;
	bh=2v1KH2bWtDWEr2n/QvnL6K9QK2FAhlzSD9sDb1LQOMs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AYaYJvY3Sku5J58f0X8EQzYBrzHk2aAF+V1M5G6MAnar10z4YAWjbuqN4msrxavq6pMbb+bfm0I9f1rjtg5HMCjehsIXGZsaqYEN8j52wpasL4H5PI9beQt1Zl0RuFtQrcczeN7Y32fTYikRZvq8vSMrjH/ZkQrpPyS5Ev9dzXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so36135975ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 15:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549554; x=1730154354;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2v1KH2bWtDWEr2n/QvnL6K9QK2FAhlzSD9sDb1LQOMs=;
        b=gaWNqzURJQ5KlyeCGDn2kkSmwhgmUebrmjMw98Fyt/ikDGzqCoHQ7V3b5rJg9X3Gea
         Ff4B/4P4UpJIBBZOyjA8rh+0imA8jMXvfXNUKNfgc2RYjkPbXyovy2b9iB1OHt0w/ndL
         TFyfluab0NK1SLfX31za1H7lRdgDj/B909mzKVdCkRwBpN8LQDnE4GzgC3EILmriK8ZT
         NXCWu0Qi8SZZnFKOnKyD65N26u+OxyjUqfxchMe2ERUxImJtXH56pnehrQyQLZCL93yb
         BZH6ct/n14Y/IyUj3aMbEc0riutYBlm8H9Mu/vE1mMIYDcza8uTW3mTLoIH2esydRAvF
         hoIA==
X-Gm-Message-State: AOJu0YxfhIOM2OjObmi6jMrg+JyZLVlIA+f2yGYzXD9woHzou6MTIa7F
	JT5/+fseT5bNxISv3MyFZZOdOenqfPjz8AchM4QLK6jtt4Fln/dAN1Mqh9ggvPq7+705AuisJWR
	twvUYpo5A3wbbceAtK63Qoei13fKIFyMct7tYzUQaPQszIHxGhM44G2s=
X-Google-Smtp-Source: AGHT+IFontqY/o9kF4Umas2KaV0Qk1I68BFaUuSbrVZlKVmdJEz/PT3rbSGKmcwPPDtrNPT5I2oRXl5pRtVPDDCxx9Zr0B/g0Wvp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ed:b0:3a3:a639:a594 with SMTP id
 e9e14a558f8ab-3a4cc0342b4mr9583805ab.4.1729549554087; Mon, 21 Oct 2024
 15:25:54 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:25:54 -0700
In-Reply-To: <6716521b.050a0220.1e4b4d.0059.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716d4f2.050a0220.10f4f4.00bb.GAE@google.com>
Subject: Re: [syzbot] kernel BUG in bch2_journal_key_insert_take
From: syzbot <syzbot+47f334396d741f9cb1ce@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: kernel BUG in bch2_journal_key_insert_take
Author: pz010001011111@proton.me

#syz test

