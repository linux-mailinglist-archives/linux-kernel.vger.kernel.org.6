Return-Path: <linux-kernel+bounces-369940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ECF9A24A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBE57B21413
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E31DED57;
	Thu, 17 Oct 2024 14:11:56 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508F61DDA24
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729174315; cv=none; b=OesrVpek1LbaepcMyqKvqdHjXeKgCwXMgJ9bZpihblagNKrp7xvq/zc1M/wkcC4+mnryTuW9qAE/N5V82StMOlrSZVN12SD8K8wX2mMTnhokiWl8uxY4yCn69j54ZvI5POEeDSOImt5e0F/vjIayNxHL3CJkEABR8ljqQ3RWTOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729174315; c=relaxed/simple;
	bh=ixF1TF21hxMC+u+JqdNApQRX8Wujhr0utVvF+5GjhQ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CTS4qPwEK0d4d9fCoEt4PxHXmN+jti4gC7DnsJ1rZFL0JMWjs8/NZ+bp552eN5j2stBP0Z5fPIgBjbkjfCR7riiosUKI/CO+7kW6IrfJ98q1PruY2NE4ohLhazYJG6GHl2PViVk1OsAWOOpuyB35/tttl5sqQaryHdN0guqVD/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3a5f6cb13so8551085ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729174313; x=1729779113;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ixF1TF21hxMC+u+JqdNApQRX8Wujhr0utVvF+5GjhQ8=;
        b=Zh3AHaj1qH2T8pmoxpZJwF3MjMkWx72Vkk/fyVxVY14Ybn9HA2+X4KLoAYF+Sfx+XS
         1Fidg1Ck+ACiMdjQziTO+4cO0y0MdH457xulziBcGUCfCTFedcaN1KbJ4ugC3mmEm2pg
         FeA5F+R5dY/+s/gEFuXyFlTiLeH+P9RSCyKSK9VRfH8R1BzNMUpKgALG8M2YiB54gWLT
         fuAMPUbVKEs09y4oqbHjfc9F/1JtyRGsTO4Gs+2nk85rP3otduYLxXjOpg1mYk+SQ8Dq
         nVWZd2ZIJrc7vddTxeCiT6gYAumcbFP1eovl4fWEevrtMwIW/gXIqesLcGoZzFOH2yfc
         /FFA==
X-Gm-Message-State: AOJu0Yxkj6FleuPQhF4oUuR4sEOcO81wT948PfQxy3mfF+itLnm5KJbi
	cRHrxGjk6U0MF21V9MOUEIXT4ZiIxbaglV+a+MpjlT7iWWrRdg3LlepOslNmG1ziGG/pLqIPf4d
	BBETpKMG1A4Q1zGVShYQ51AzjhFTNXShcVi+1i7GaMp5xbl9V5lOeukg=
X-Google-Smtp-Source: AGHT+IEAADEp1WQG6MF4TfrL7mEKc6JrESABOBH1V4cFaDRjTy2RbdUsKanhZiFyHpG1V2opwOxB8D/u605Tdbjc7wsLQ+LFceAT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e1:b0:3a2:7651:9878 with SMTP id
 e9e14a558f8ab-3a3dc4b7010mr66266555ab.12.1729174313204; Thu, 17 Oct 2024
 07:11:53 -0700 (PDT)
Date: Thu, 17 Oct 2024 07:11:53 -0700
In-Reply-To: <66fcb7f9.050a0220.f28ec.04e8.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67111b29.050a0220.d5849.002a.GAE@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Read in drop_buffers (3)
From: syzbot <syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KASAN: null-ptr-deref Read in drop_buffers (3)
Author: sarvesh20123@gmail.com

#syz test

