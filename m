Return-Path: <linux-kernel+bounces-404647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 061A59C4630
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F96E1F22599
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB661AAE1B;
	Mon, 11 Nov 2024 19:53:29 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E0132103
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354809; cv=none; b=I1TwpCOCT3faaRf/5e3qY0Jlf8zXttgyGYKzCBfkw6L4qgt265V77RDURISGAZcNk1EcNakal5ThXFXcoIno14x/e0EYsc2luZcJHrdepbALhs1qUNND/E6hcju+5wUp7MgRDVUUz6eNTefpmP7IVx9L/rSZqltrKrqi4JW2TBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354809; c=relaxed/simple;
	bh=b91D0VtCE3kP5eIS4Y/nNQ7nHBy+Q5WAPkvpqIetcoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AOKDD3LNekd+bgPyQqJO1AhZN0D3K1bIhGjW9s54cLP9/qhKzyunXCQgNNzie7gSawJdu3BiRfgavZ8K4pi1qGt+DhTuj9xhtv5RTpEGcdNADNh5NkSe9YKHAYyR4N9/msed9BUCwwq6nrIaxwaHgSmFYFvwOtqp6yPdNw6eTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so57324135ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:53:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354807; x=1731959607;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b91D0VtCE3kP5eIS4Y/nNQ7nHBy+Q5WAPkvpqIetcoc=;
        b=hu9LeBIsSo3ugiXLgjO6f6fE4rXr+QY5ozVp2z6ie1ulqLtznVw5pG7Z/C7T3c+TOT
         cm1IkLhdMEqgA0sSxEokDMJYztgpnL378vJ/gnM+XTrL2J09Ac9PIyHVQMEKQg67N9m+
         Yvh+Ukmn4HN6AigsYESYY/3V+ib/G9bR5KrEbcyFd4pYwPDWaIHMlRZGrA8c9cdJUVHb
         6RD7BZa0hsY1nbBq4+qq8vW7zNm/N9GjDrviAoCSqAA2/cKKYpbsu005Y7bfP/3+HQ6Y
         LcXhlJV86P3LsCC9OmutHI21rgRARfFSl4lOFwmqQqizpogHNyebs+BOcczIRn1t6MDG
         hknA==
X-Gm-Message-State: AOJu0YyimIehn/RJ5vW+SwTaAB/DrNRS+Mn2MBB7ho3z8xWVUw2Ka/TI
	I/+trHPklBH1KMCLNCT8jOmM/tIAcufyTzs1MOCdBdao9tP3JnRaNlm7ouV3EsjdmHDdVsW44cI
	Ir0iXoRdIDIJH0loDh9Rf4qzYZ1JttSFpK9vMTclEqT/d76YhYRYiuqI=
X-Google-Smtp-Source: AGHT+IHVxmaWpf3wCpU+M7Hgr9xblzwd13cX+fVsCaJPOeJWNVePPq0K2ms95Y1WEnJrZY57cxkIxe3b02ABL5ye053gAKqF5pQI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:3a0:a070:b81 with SMTP id
 e9e14a558f8ab-3a6f1a59322mr127218605ab.23.1731354807239; Mon, 11 Nov 2024
 11:53:27 -0800 (PST)
Date: Mon, 11 Nov 2024 11:53:27 -0800
In-Reply-To: <00000000000005d7e10617c3a3f5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673260b7.050a0220.1fb99c.0154.GAE@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfs_free_fork
Author: gianf.trad@gmail.com

#syz test

