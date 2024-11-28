Return-Path: <linux-kernel+bounces-424209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 353599DB1A4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84266B21D20
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426194F21D;
	Thu, 28 Nov 2024 03:00:34 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAD73232
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732762833; cv=none; b=PmkYJJ32KnQieATx8nlvOLQYeZ+VxowzU7uIBc+k1slxD8wjjude/Jg+gmSMyrKvQ17/G5ZOSWOy6HD4F8GrclmxOtp6oPNOfmk6uYF3jxDZmWamWmtdaX1IN5oJpzgBMEvmN3VxKXUuPD7ldxM8BW4H/unTuAAVMqpZbVRRfnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732762833; c=relaxed/simple;
	bh=hb2PBBvwufkpWR9fveOWwse8C73X3fPGYWIm3h+Z4Zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kUNuv0j6FgwE9qJeVTvKqUkfhVkWifmaMakhghZJ4Qv2sTNXFCpXBF1XSzzaa+CKUk/cA/Q5piHBFiyQvhK1ImZnDmX9uMiK1cQueq7Qf+A3+qjnAZryKSLyBJya1cptyHfCYqTR8eoAPdtNcEweJwqh1Mf3JGrWrVAacpxTaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7c8259214so4094765ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:00:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732762831; x=1733367631;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5OfYs7iW05qw4f6R/a4MpnNi731f3XkcedW7Ckf6N0=;
        b=wsQdFMHR+5ZULzIEYVAhecpQOg3szIZc/igME70JexiNSCoYIvI3kYXVPCFBfQiRlE
         ikPT9RSsgouGkRIQ4Mp1xxhSGeehlCDvLua0luRR4wDcbno3DhU+fxHv92Jm+X/T+v2y
         aobKXOAw3VHAa1xXDbCDELdlox8ePFCX5UZUxWu0nBSLAhyvPvk4oBh9MDPsujey6YKI
         7aahQnuQJJ4SSYtF2NS7N3Q5V7Y45QEzTUaBY5z8KFSN+FkYdFTj3dLKM/5xhJrZPfGt
         869nIzIdeIhghy4LGfehXv3ma/JZwi1wAorP2xjMZr66K7llLulxjHt4wgrAl4hTyQD9
         XsUA==
X-Gm-Message-State: AOJu0YwrGeoeQp7sDAfaDTWj7z/5ZfuTVEZvtgFnUuaXvWJSiyZvup3W
	fmHy461remAcPYFA6WqJJ+yNaeeQVV1eKwF63ZU+p5CncJIA0mNC6c3Zks52yvpoVM8u+IeRr6M
	G/l/wYVHInCoOjJvML0kyDZcafwf3erH5QwCPWdr88QXXLg43BOJMVMI=
X-Google-Smtp-Source: AGHT+IGuNNOHk2zwO92ee4kvWfbPizH6XxIXVHxgieDbUEF41XVULXA81qUN9Rj6MrzFGGR+tHg6Os5wY7rhISmfrWZWupTUkhVi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0f:0:b0:3a7:98c4:86a9 with SMTP id
 e9e14a558f8ab-3a7c55ec83amr64389375ab.20.1732762831511; Wed, 27 Nov 2024
 19:00:31 -0800 (PST)
Date: Wed, 27 Nov 2024 19:00:31 -0800
In-Reply-To: <6743ea99.050a0220.1cc393.0057.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747dccf.050a0220.253251.0067.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+73ed43fbe826227bd4e0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Guard against journal seq overflow

