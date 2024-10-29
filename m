Return-Path: <linux-kernel+bounces-387717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F6A9B5534
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F08F01F23DD5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241FB20966E;
	Tue, 29 Oct 2024 21:40:39 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA921E1A2D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730238038; cv=none; b=ZclLDm1zJflhZEGUaDHErlMhKY/w4wqrdTufyvGQCnRUyZIaD0MNSTAZF9Pt8FykMWl+vPXH32lBHAq4kLTqHuyR+PJ7SPzR5i0LGsOykhFHB9YP0LEjA4a3HxMitt9Ua7UzUQk6bUG1OlmvFm8LEJEgyJLjTOdXfCxoyAkFxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730238038; c=relaxed/simple;
	bh=y92rByEFb/L+zq0E1oRnic//v8AunMoAfTCj/y1GA8A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CXHQO/q3h5Kr09uNBBhK0RR4vHscrdKm5nbYTCB0H8ZP9G/jAzu5PB2RK2t+eHRw6nRr9n/RMqLpjd4qmiaswe7fk6T6qoSYA6MXQ/H3gp4xLTjjOX58039T5R4OaVvoj7n+sa52YcZEdQZXoC3xU420J/Sb4mIgdc+BxJlyVRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aed4f24a9so576251639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730238036; x=1730842836;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qUsH1Cpw2JnOHdnJraAetSFw5hOPojXYgmMzcR7jCkE=;
        b=fmonYGHoJ1uyCAW13VAgWLezacU3veT9eeW6cQ3MTrSrezqiCguMl+5YtM1HI+3cbN
         SLSpcPggXYEsBjVQ6kQYxj78KeYXbDBbyXysImymDjVFSmlFA8MbbloOPJGRTLcaBUzj
         MbikgaLidmdxkwlEw0+fcz8Mfga1fg2aG9PkXd8poquRF5C5oujo9qJ3GsbeUdJFnQwS
         ky6YGiw/NPwHNNciU3XFopboYKv1yBpFNJAc72IjNFhp7Px47j6HH+TTEYTlMOSJ55LX
         pwG6xEE76Mlpj03J/DcABnJhlZVnwKav73UPtw4cDwgytnA1Uq5hHwQc1jMV9RRU3ME3
         ndXQ==
X-Gm-Message-State: AOJu0YyX3ZDV2/5ToRGgLDRwJNq1WcIqygzx8XvSOW6rlgva1N9It5c9
	wsBiE63NAI5wH7msJKSJz1GoMU7MsAWe7ecwj/deLYjuhNSp4UZFdnazO9k6Utw/OT2SM/18efA
	/cJ9nVPRulIzpOCbbn3hFVNDEHHRX3+Z1hAl/0l+dbajFq1LsPx/E6go=
X-Google-Smtp-Source: AGHT+IGC/lGXnOvPQTjx7b0uFXfhXagn/5/xY+bLSRZts+oZB6fh4OnoAu6hGU8vsmZRgdxY7EMdca6wVO1sMpxna5XP/93fiNIB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:3a3:76c3:fcb0 with SMTP id
 e9e14a558f8ab-3a4ed36b723mr119472875ab.26.1730238036190; Tue, 29 Oct 2024
 14:40:36 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:40:36 -0700
In-Reply-To: <671e13ab.050a0220.2b8c0f.01d0.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67215654.050a0220.4735a.0263.GAE@google.com>
Subject: Re: [syzbot] check ocfs2_xa_remove fix, please
From: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: check ocfs2_xa_remove fix, please
Author: andrew.kanner@gmail.com

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

-- 
Andrew Kanner

