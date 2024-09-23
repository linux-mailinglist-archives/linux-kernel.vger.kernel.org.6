Return-Path: <linux-kernel+bounces-335799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575797EAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFA22821E4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220F197A87;
	Mon, 23 Sep 2024 11:44:56 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A71193425
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727091896; cv=none; b=C38hZEc/jUM0DRAG/qCodQE4meKc25sCxXkiCL6BTR+3OFkOcdFCc64gWEQovW/TMJ3hCNrXNd1aa/O1monEnufiEYKqcXBjVWZdT0pINQ0dooD1RK9yh6jOus/dq0EslvgwhBevKQfuOuMqStsoUsGAhZU7AC55qFEF9FBON4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727091896; c=relaxed/simple;
	bh=m6B8vnH5tCa7D3W+888kwXIkV0BrfUZNvraNCsJwaMw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nXc4kUggNuza/zY6hw6viM9vA9k7WUtRu0lg1PgISmDRbdLQCZDw18bvqFfk62IVa3OxeHcaG0ZQ3TFDeWL4HG/ys2HqFyo3CRJ0t/+EOaXElu4QPbvAefD1wDq1Xvg+X+q111+zRt0FS5Qa3G5E7SI8K9+YhX2mHOlmFuepv/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f56ac8d88so63085985ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 04:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727091894; x=1727696694;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6B8vnH5tCa7D3W+888kwXIkV0BrfUZNvraNCsJwaMw=;
        b=mqOa1kA5ByUIkrGUFxBPcGUWtlqGFsvrzmgHyqJ/FaPUqmvUrkl+tux5mYPCFrSz6d
         KkuFxYcNNXInu09wkNj93wmyp0PvtfuX7XLspdTxMgRL4kWYq/mcwmbumybFJZzSlW9o
         ct5moYkh5c8jUVUfq7are/sZc15RMvtyuVisRTcE9rMwZbTBPNK+ju5YPiw8gkDM3nro
         p4vFBQMsFL9PP9XK3moxvKCRkvqAaiHP0sucJXnCoEqCWX9913v/7kycDHbH+Znrpr9I
         FxTM1uKt0GJnzlyPdbyqOSN2EuH/fEhGcorMwXyGVD5fBbUfo0OPYZuqUgCfDdAkyxr7
         uHDg==
X-Gm-Message-State: AOJu0YxjDQ0t6XZdMcmE74FLS97BOfVQ7vzSyfbuz/cUyiKsull+enRJ
	8hi8LPdtv3PZqIgqk3gBacqdfIOmqlZimE/zP83JJEcUDOby7pTRsk+CXOGVGaYeRP3thJLhAj9
	KCDNeU1OrPaizeXlMhX9fAP1J4seEQpooUAnF8/e81cf9Ntanfeufibs=
X-Google-Smtp-Source: AGHT+IG1nDnlWm3T4N4kaa55ia6pR0iSjO14NIOcWW5LPcq4sBXtPxbaRHQyawB8W0JqgbLmkM/PyuxjI4hCeP0kuI7JlHTnVmkk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:3a0:90c7:f0f with SMTP id
 e9e14a558f8ab-3a0c8cfcc16mr97532315ab.15.1727091894226; Mon, 23 Sep 2024
 04:44:54 -0700 (PDT)
Date: Mon, 23 Sep 2024 04:44:54 -0700
In-Reply-To: <66f11c57.050a0220.c23dd.000b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f154b6.050a0220.3eed3.000d.GAE@google.com>
Subject: Re: [syzbot] hfs: Fix uninitialized value issue in hfs_iget
From: syzbot <syzbot+18dd03a3fcf0ffe27da0@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: hfs: Fix uninitialized value issue in hfs_iget
Author: surajsonawane0215@gmail.com

#syz test

