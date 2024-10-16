Return-Path: <linux-kernel+bounces-367267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5B69A0053
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E4E1F22757
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EAE187872;
	Wed, 16 Oct 2024 04:53:33 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A321E3BA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054413; cv=none; b=g34FAgoKts1AWTmTCIcZEwUGK23vHY7P18uBNa+UX3YLdu9qShQ9elWbuYNi1MHNVhK8Bb88ZrTR7+5gR5iZgRJaEyAPtCXIWmM4PSl6j3XamSmMNLLyTCzOBC/43HN2oxChU6dLyEEogQ0HN6nHdVa9VrQvyqN75ohl0RFWygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054413; c=relaxed/simple;
	bh=Rb+TVTNxVLBWa5duZt4P51Lz0F7zU95S++O7DA6hr30=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kCzvBd9GIZJ+8VrPyup3kOP4i/nMX/gHjz06hFdGDrHJIbHE2AEJ6avJLhfAP3TdU1vFztLH4ompNLWJYZMnTQLJ1IwCi1ZgmBkAXp9QK1WN/qaYT3YZQ+mDM19Y+5hVG3D/f6R7WA1/aDIvnQp5fMWoNIdDpFJ5YlDjZxFQkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3c24f3111so30683865ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729054411; x=1729659211;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb+TVTNxVLBWa5duZt4P51Lz0F7zU95S++O7DA6hr30=;
        b=AVnoqDFAy5AtSXZ3A88R+xWlSnbx1YiW93uDvg4gb9JN+Q35T/VeDZQU4AMfQeiBYL
         85WK1qm/KcR6v0E365+4Vv6woFhuE0pyXYG3WY2tnMBXp1OUMHtvZHmy9u0MeO63Z8u0
         t7/ivxNtmg3vuwfhP8S3bvEvMNbQjZAf5fsQlTxBWbxmCObEdqM029tshKVpfiAY3Xvm
         sYTUdo11rIlEEXOGPfBNmTQmwnz0AR4s6QHF7V8T0nP+UOs/rTnelu29+0BUZgsMBiqO
         2+x/CSW24q97/qZ1ZeqY53ETCsyIK62snsUvJeaobYjqRS58XmduNL9yYoinZA3GUay9
         BUBA==
X-Gm-Message-State: AOJu0YwYRgg0FV7lyXxVTThaL88bDweUB2qCl3PGMacoMLqBYOiXrWgZ
	had1WUt4v7KkCCiLALP47FABi/TCCW2KshN6NK7Kk9yu6jiJ7Uv5tar1Qo7ggL3YwA1F8FMvc7d
	dPFkim871XA6Pd929a04NJFls/43W8Uy5X3oNdOzOijV/E6nE3bwZ6mU=
X-Google-Smtp-Source: AGHT+IF3Gh8kQnBo9vdOq9ccT6egTKRYrcz5zXbWtw94i2xgW+oMypvZEMQgaDxfA1u83UaSCvPqvxWxEiH46G7Id4J405wbkeIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a3b5f6b26bmr158817815ab.10.1729054411107; Tue, 15 Oct 2024
 21:53:31 -0700 (PDT)
Date: Tue, 15 Oct 2024 21:53:31 -0700
In-Reply-To: <66f057eb.050a0220.a27de.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670f46cb.050a0220.d5849.0010.GAE@google.com>
Subject: Re: [syzbot] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: kernel-infoleak in move_addr_to_user (7)
Author: danielyangkang@gmail.com

#syz test

