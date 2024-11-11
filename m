Return-Path: <linux-kernel+bounces-403414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63D09C3560
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 01:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06F61C2151C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9C028EC;
	Mon, 11 Nov 2024 00:31:37 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFE2F2A
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731285097; cv=none; b=JQ+ZbKx0qepY1brmH0FXqMvc7jnSlY0g4jFInOamTyEDb/BJ7WqZ4MXUBIHP4PeCRO3biNplGhylB//351fS/ZIRoNEq0oTUSDBrR0EiKV7yY5xalq+u9PZT5x9Sk5RvzZlXHKwGTv1uWUtWuJJ2T57gQQ/hs5Kek89XcBf7PPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731285097; c=relaxed/simple;
	bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nV8upqNKUVib7Iaqn4GKwtvgWjQ2QwS6pjyRunybNhw846Og5oyWftiROP6bi2bl2Nw+PAOSGvk8JD61HBPU78tQyN1fuRs/IQKyD51U644ncFVQ0AWNcieVnGx556jNCCKdFmnI6PA4elYSctx6Sv2kc6/jYkWn6R39soai/s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a6b37c6dd4so46675095ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 16:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731285095; x=1731889895;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hbIpnS+URpvAyTJ1xTBqOdFUnKaXpRqxrapc6IgmV04=;
        b=R1yFd7LAMtAKf1wNZ60geNTclJRomrK9mkZtPA8dyZLKngeYobn7V8HSjApGAPV01X
         Ge/H5Ei1WN45ZoiNkfHVIvGERg2YZCGWJ6Dj231H/kySqeWf17OCp2Ux9ox0bMYpB4U9
         3lu5ff2eEd4C/nqdvMhJ1kQKU3Etg5qWlfmTrSsxnESjp1+M0wQxPwrbfnSgY/QulVVh
         c93kEEPO3FMJ33E4zpt512n7R9bOgqtSy0/xlD7aagyYi1P38+3cvUAmmHu1bFSoLu+J
         YCqfxg4/5oOfDcmunLVEJJhqdcHnxQUuVhCfmdezdbe+OYHiMiwgtbc3SHxSmq3snp0/
         q8JA==
X-Gm-Message-State: AOJu0YxMLh6o2tSkarqaeqMs1xXdOUisEM0x8inS6xV/7+WUPB/MkqWy
	aWDklCtYnuXDhDpJ4MSh56WeUnh2KvFnhqPIdzy0Op6Q5dk8bjk8RoEmrjQP2CZe2y8cTRGwL/T
	eraDVgOaMnAaHsfVMR3wdflB/DhzWm09/gg0eBjJA1jNFFKTTQbPy/Kg=
X-Google-Smtp-Source: AGHT+IHL+4tEMCDqb0xy5lrxDK7EjZJJStstXyzniBkFzbI2EKyHGw1rbx6Ck+NsEotZwHfWQ8sGIfl7hyuk8aQoyUZoWALWosiU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1608:b0:3a6:ab13:2b7d with SMTP id
 e9e14a558f8ab-3a6f1a48de7mr120701985ab.15.1731285095324; Sun, 10 Nov 2024
 16:31:35 -0800 (PST)
Date: Sun, 10 Nov 2024 16:31:35 -0800
In-Reply-To: <672ecc13.050a0220.138bd5.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67315067.050a0220.138bd5.0058.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in bch2_copygc
From: syzbot <syzbot+8689d10f1894eedf774d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in bch2_copygc
Author: gianf.trad@gmail.com

#syz test

