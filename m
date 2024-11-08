Return-Path: <linux-kernel+bounces-400858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297C9C1348
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520D01C219DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E47B672;
	Fri,  8 Nov 2024 00:49:00 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5148F54
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026940; cv=none; b=gA+PKU9eiCFhloaoTGf0YRGLLAdMU83tYsFXNsNE7J4HCYm79YTl/FCHHA/9O1Ss6LBUnzMNddR27fthR0LmzbtCRWet5tTlA8R3huRPF2Q2lVsAH4ByHjRkJ4jsgOl1kWby7zluomk7R6HcNLzN4sdCUxpe2sVYRDq6JEFLhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026940; c=relaxed/simple;
	bh=A9zNv8qz6wr7fMW/HEpdP0sCmiMGkOQKP8ncxxdGIIU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DAnMa9RhiMs95+ZfZ3+F3WmSbuE2KZngCZyEsZjIwYP3+vP/ZHXUf+M/Rs/mf+w82/gIIanhY6sUGK45Vrrs6T6QrNHxljDD0Zvb/ILI1WUbuYIVRz5f835vpc1tK+KiJpPv5aJzQZkk+1sJDSeV+qytcGpwyi7rUE/CovVJ2B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abf9b6bfaso171546139f.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731026937; x=1731631737;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jX/NlJUkmVIY3yDW/lKHmthg3M7tOxdpNe2FvU1vYBc=;
        b=PmcB4ni4i19zG+jqKBAjmSqotGrwVeWVjGWvtbVeKcEbZR7J2W+w6i9nMgBOYSoG5k
         jerX9donAqxXZ9PPbJaJcuMYn3eng+0RAlhfpb3IX6tcarmYnYDSwRDz1TL5EUWPUXlv
         vxOE6hvYIMggNG68AkrOtqrZyWn37dflcnoBY8mgjYiitFE5vdDpbmNEWRc6iLndKyHJ
         07CirHGbGcqzqcrPnlEmuHyczCRy4rsjIXQOw6eTeUWGiQrakpnkarT8WRjJl6OL+m/I
         rQ17e80fjhQZ6lyfR1GaqrTxCCWKz4h82Q9+KifVv2j9F0tcqLvvIB+CRWRgc6qts068
         h3Cg==
X-Gm-Message-State: AOJu0Yz6BDxl4OI2N/Mnksu6CchNSWC2oLqoxWseyRFCzsfMP0ddOe7T
	/I8AUuKkJW87oBtWKDXXTSgcLvV8thMqvFEuUNHDQ2hJ0AY+9/lEtTFy/4yjVB3agGP6YXZKJsb
	Z3L1VvnnS4jAn17Gr+Bnvl4KPEpuMCZkCyra/xw895UgRtTIrsPh9Kr4=
X-Google-Smtp-Source: AGHT+IENqUk3PiQzL5US/TzQZpmK/x/IVeY7N+pEsRxlKrxLqUcrEHtIlTqRVLJqW9ccr9MNelc7xSfljvq43Zasf1bNdyiApTJe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2165:b0:3a6:ad61:8006 with SMTP id
 e9e14a558f8ab-3a6f1a6ec5amr14367275ab.15.1731026937687; Thu, 07 Nov 2024
 16:48:57 -0800 (PST)
Date: Thu, 07 Nov 2024 16:48:57 -0800
In-Reply-To: <671db974.050a0220.2b8c0f.01c0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d5ff9.050a0220.15a23d.01a7.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Change OPT_STR max to be 1 less than the size of choices array

