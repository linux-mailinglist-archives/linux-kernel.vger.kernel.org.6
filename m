Return-Path: <linux-kernel+bounces-376982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB129AB85D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75021C23AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54A61CCB4F;
	Tue, 22 Oct 2024 21:20:13 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E8130AF6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729632013; cv=none; b=bAEyDkF/MDUKZMTvpdejcDOzZTkh1skQ9MpwMsWbqunZfD40wOYH+oJmIoWoMPMv3xFDku1mYqOUWEbPjarz9V9z2G7K/idB5vOGf38R94G23EOp8a+c5LVawMn3Q8KoUAmAZyBZgYy8yyRH7SfMWo2ZOxJAI63s3af5IGk+SMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729632013; c=relaxed/simple;
	bh=hgoRgwn60d3VAzKBWFskiRRe2r5K270x6LmK8y4hdPY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=thrqWW6B/DOlRIClrqO7H9FzQ/I/zm8ARMmzURYkyvPlzuXSc59EFr3DhvTBbyRRJzYHEQfM/iEs1LkGgZrcI+5hwfyMEn+mhOrNk6Gr2XxSgjmCtFT+Ld6bkay95Jqc1ehfq7fCQdLxciEvggzNx+ND9BN5X+AL6mPScyg5zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4d630bac7so677045ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729632011; x=1730236811;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hgoRgwn60d3VAzKBWFskiRRe2r5K270x6LmK8y4hdPY=;
        b=CRRc0vxHhhkbvKswli2rnkCJ65/7ogLHJECLsGa2CoHsaHKc32NQ4NVDr1dW18svXt
         69l8Y/p/NP6UKaY2JGOQ+Z4Uj4NK/Rv/F+rBbvEtuGzBTeiDYVrTqj+Qs1xQscUmWB5g
         G3hGjB6/ZKSulp14OJ+vUgsVksEFF/8ntd9hp3JF+vpXYqHyOtoZuMgya2CSwAaHWZFx
         Ros7LrZPN9Y3pR2jh3QiQTrwEK27sppiqCFj3SXT0GKSCVW1epByIC3ztieAEZfn/2Eo
         xxnA00tmVHZQRfVMNL3tcdWbKjETXWAQVJGWG6YbFqjopSiJ2PchXePkKH8OsB+kECnD
         sICw==
X-Gm-Message-State: AOJu0Yynz+bH1kpIaB6s1yZA+eujXUJaQTqkXUUaZksszS3m8dneO1yE
	Hw+3QV1BZaxjodJpCYxMo1XF7r2iXeTmSPl5pDZOGZ3QevE2lt0bNV730mtc4MEL15wp27Jeriv
	A7PiucXQ1YVtP82lOTuv6ikUhvRu+1MU9NOmAJiohNmTBoGusSUt2fF8=
X-Google-Smtp-Source: AGHT+IFqE/b4oVo6kBJmXnFF8LS1CZVjM94RQ0ydBDZj8m7AuvRXQtsyozvwmoAmty/csneZKKN3L4MkJKtNQlzF6quTg7JBlfRy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a82:b0:3a0:ae35:f2eb with SMTP id
 e9e14a558f8ab-3a4d59cdc1cmr5627215ab.19.1729632011138; Tue, 22 Oct 2024
 14:20:11 -0700 (PDT)
Date: Tue, 22 Oct 2024 14:20:11 -0700
In-Reply-To: <66fa3eb3.050a0220.6bad9.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6718170b.050a0220.1e4b4d.0079.GAE@google.com>
Subject: Re: [syzbot] general protection fault in btree_node_iter_and_journal_peek
From: syzbot <syzbot+005ef9aa519f30d97657@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: general protection fault in btree_node_iter_and_journal_peek
Author: pz010001011111@proton.me

#syz test

