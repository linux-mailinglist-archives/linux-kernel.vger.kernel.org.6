Return-Path: <linux-kernel+bounces-267335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5B4941066
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BADE41F23428
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E1719DF43;
	Tue, 30 Jul 2024 11:23:39 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E2618C336
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722338618; cv=none; b=L7KTqaSPclRXDV61NAGDUvmfKWwC5XyQtlSpYf4wsROR1lCHzNfsf0B3tgMPuiZDPQPp2POEPkDpL60Q9LhEMfUUPEJupTTZWJywfL61n1mLCR3vdhx+Xgy2ICJw25EMQ+eLSMuf+9JVakeiP8QQYVSkzfo1on1dIlQtuGFKRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722338618; c=relaxed/simple;
	bh=Ej5uzk3D0EAq8Mpz6kkzdrp+Vof8ovVDZkBAk2ZVwOI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RQ4T4txGbtWkun65N5Sd1/+2oE2fH/upCg90gR2QPlxs0PvOGJYl1cxhLvvjo/watJf57CSyCttfnecgkhuhy6Cq/MwE39EBR9eeJ+28S6R7LZB/qDpw5DbO7IOQA8PJoNZ65IZU81RG/z+0e9eaqMhMuL3RrsxLCM2LSc6zc/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39835205d20so95854165ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 04:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722338616; x=1722943416;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej5uzk3D0EAq8Mpz6kkzdrp+Vof8ovVDZkBAk2ZVwOI=;
        b=LWPYkLfudnvdv/nQOOOSDwCU5wyM/YEEQ7IkGteUaPhS96IN8T2QgxLeWgegy6kTtW
         GDoUqo0p9rB+I1JsTLFYC4kky5sxhp0tQhiOBGzqHOeR7y/d+G10+vytYU+2Hk/Vfpwl
         cwfdVkwTqFtGIFwAMm6YeOpwpNtTorV3weTD6nffbJ73a951O0bpEVhJ3T9v6HplkOou
         Sduz/HJgtR/TVpzMLwdEBFsbDQ7O41eFWvATChCnlOszbEqqZ7A5EQT9fDU3VFDndvh6
         cs6dqeLzwnV0/B8LLVLqkyTa/NqzgkpCMZzoC7H/BRo5Io1UC4bXXSgIiO9nTLcYcW41
         2Dsw==
X-Gm-Message-State: AOJu0YzGdYpPK0+5k2FcjV/OonkwB9mwO7d9DNpSGQYhBSVImJ8vBdML
	qs4QtfHDses13mzdo3ZgqIP/vZJBHDb0rP6rzQjh7Pcwx+w8XS38JqCvuHoMIMwiGG58+oWV0FP
	fcxJCu2X/na0y6lVGGarAE3Zdw6a38JU9rnhr7eoFAXTRNDOEyC0fH1Q=
X-Google-Smtp-Source: AGHT+IH74o+X9yrrI4JXETW16RItZTD8fa25UXyeZ9VpiKjDiaR/i+u4bxRictT3HsFGSG9cb1e2XtQYhTl0DZ3/pwHFyqqBvM/D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a05:b0:39a:ea86:12f2 with SMTP id
 e9e14a558f8ab-39aec45be5amr10454635ab.6.1722338616331; Tue, 30 Jul 2024
 04:23:36 -0700 (PDT)
Date: Tue, 30 Jul 2024 04:23:36 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068e215061e7535ad@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in
 team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

