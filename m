Return-Path: <linux-kernel+bounces-297736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6895BCE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0285A1F233CD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D681CDFCE;
	Thu, 22 Aug 2024 17:13:58 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D50D1CCB4B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724346837; cv=none; b=b5R7r0YRXANMp06edWZ0VBHBRKJlit2ESOvzfutoDQoFVXKpYYJonjF2h9X9cxO7vqqvLThdLXM4oYqlvcLWS3IufutHTO7GQTvGZvjVS5RfgmLCqUPPNkJLC1BwQT7bEqklVTivsWFqoFGTfFFu+bcWHwpWBSo3uLd37nKqZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724346837; c=relaxed/simple;
	bh=XxfQw7k9iN4403Scvjy/OjBhKaXVfuV/HBrdyRrjJjQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pVuA1sJ7NF+p7n8aVSRW8RCnByFjJ4u7sjVKePMsSgWzx1NKWYSZ9WrAQUbkOfn8tr9jOAskq3awi65eZfa9Z05tA3XYFrHxgVOY58rNjGW/YpGhBK7A9zAre0WdWOG3YKzVHWBCLJbqwBAbHg5VNNUAXyR+8Np/TC2/DkTnhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d17abca55so9967435ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 10:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724346835; x=1724951635;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XxfQw7k9iN4403Scvjy/OjBhKaXVfuV/HBrdyRrjJjQ=;
        b=IDdJNikXEuD+rYdMAQEMMOqoLS/g4cjq2HEZb2aQU3HRIbGy56mI4bmb4p8fgF8l+R
         7MSH7UlNPOQDJckGxXzfRwVcsWebkI3/za83o2ZOmFJGQEEReBFS9+tFXytVlY1wu3cg
         YrZEHYrq7YiYFAnk/zd7efILm5NAWr7z0ADDBwzEBGL4XhUcEp91RDekC+2Na70sDUd2
         +YBKYvr07Nra8u21VjHf9pkJsqSLe7BMIDI9l8LIIA99Q+MvPc3knAjg1EYXLTMTnKlJ
         QHg9FruTO8I+Ph7Nc3hRbnf1AIBocjqXbApyeKX4XxCtvcboHE7alzvnnQjkR/V603CZ
         hQPg==
X-Gm-Message-State: AOJu0YzEUd6vufXO3Yr73dFNxa4erXe+xtlALag7ldBM2o9cq8Q7rW8Q
	u4V+p1A2ECoAuX9CCHAvhHifxx79QTHWJN8qr+koFKEx3no5Nmge7zno7bfku6zibggBmv+CJUb
	eiB/uo749kcp1a2kTJH5mW8uXEfMbNNi5hP2HyFP128yrwh01lw8ggk4=
X-Google-Smtp-Source: AGHT+IElaEZG1lpo6MQT++LI+4S8oBsFOdWqtF1IPVyHWFCno8J+2cMasue1p+Lev19b6YwmC+zQ6yT3AmU+wBhMzJjubINP3aHr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1384:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39d6c350b30mr2868935ab.2.1724346835593; Thu, 22 Aug 2024
 10:13:55 -0700 (PDT)
Date: Thu, 22 Aug 2024 10:13:55 -0700
In-Reply-To: <0000000000003aacfb061aa140ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b0160062048c852@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bcachefs?] WARNING in bch2_fs_ioctl
From: syzbot <syzbot+9757fdbdabd69eae08ad@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_ioctl
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix shutdown ordering

