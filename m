Return-Path: <linux-kernel+bounces-231806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBD919E52
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 06:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6A01F25EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 04:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8611BDDB;
	Thu, 27 Jun 2024 04:45:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767D51B949
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719463508; cv=none; b=VYQlQ31Y4I1IIjF/wtqdbf/SGik6TExhwgjKJMFBmqRlwXxDovNyEmlGLlJVUt4M2Awew+6KCAfg/096S9nRWGGNeXUudi4XrSMeKRbu4RA/Syr2YmyZnOT9kNvDffoBH/S4my5qYDYjA2Prmh22UDq0tV84ldwlyLNEIIwoHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719463508; c=relaxed/simple;
	bh=2P9ciSlu7Ek9y6TGFOI752MUh8bHFPb7DN1jU8pmlJ8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=d3WmfgJFuNAclD+YhRHjLShSJo0pHjfzuIZyjyTIligRBuSLccplBVy+R1SaxlK9GuZPKELgaDFNSciFs2pvnYjEhjtlI3f2NpI9o656ZJO66hsHqZ/iSU8T4ggBBLjmDKodVI1f6Ck8B4NgYSOYA1GCOqema+uvtgZ40RwLdro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f4e272a9dcso17650739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719463506; x=1720068306;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2P9ciSlu7Ek9y6TGFOI752MUh8bHFPb7DN1jU8pmlJ8=;
        b=Ir/zCffwawrm3GZGmsXECLM0fK4J3BiU/GPj3GmeuYYG8Se9okkExEsnLA5hJ7PA5W
         UNyJyORGFr0t/+t1B42nyhSl8+gQh0haWHX59Y/zFmxXaZm2IrVp/z79uBhvIUuLqILg
         0a7ccy6Um5bdfeYvNv+bMk8fQLb5yt+uhAXxh+Dd/GHDaG3rOj1hVB1MVy138ZBqrTG1
         +1zCHBi8W3N0jbnec9uUi80tziFc2GEDJ/aOY3FQu/IwtyUr5GV5z/csQ9EoQbLv7d+/
         avrnzVk37GPDzZueNSwTJB4/cFmFARHgjYAq8G05FTTekUJ5OM8wwdiSd07egMYfVh+c
         JBBg==
X-Gm-Message-State: AOJu0YwGPSNxmRbjfhzkfQ63khPjPk9p9RPhTJVomCgeSj1FuBMuUvEi
	gCHrHqlrlFILzBYFMnuzLd5pig9C7eoebsQ+wIZ3aBY7V9nHRBWM+ml4b0eV6xBG+WGR/F8X9fd
	CSz8CUUdifD14vXyG3fUZrZSdqCbSYeFZR5zh3KOmO/mY6UudDZZ4EB4=
X-Google-Smtp-Source: AGHT+IEXtPKOziJrsWXMppsenRdsE3h+RrjXzT/MovRwYaYYxRF70R/kp0YpKWrjmafVKeq/ZEY6CS1IJFdnIVoAHVJ3rbuBTnDC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:376:2246:3b4b with SMTP id
 e9e14a558f8ab-3794d28e58emr1230865ab.1.1719463506601; Wed, 26 Jun 2024
 21:45:06 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:45:06 -0700
In-Reply-To: <00000000000085bb82061984e155@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083fcb7061bd7cbce@google.com>
Subject: Re: [syzbot] WARNING in __kvm_gpc_refresh (2)
From: syzbot <syzbot+fd555292a1da3180fc82@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in __kvm_gpc_refresh (2)
Author: peili.dev@gmail.com

#syz test

