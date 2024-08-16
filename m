Return-Path: <linux-kernel+bounces-288807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592A3953EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFD01C22513
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC212B9C6;
	Fri, 16 Aug 2024 01:39:54 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CE629408
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772393; cv=none; b=UdS/MNxXgJcExOpB0JVEOJMZb+J/SgxjL255ikNSSvLwYALy/J8gzEu/Xt0xPp/3uPPyytUpD/T7nd9G5p4vQnQObsQhfBzoD2UvF0ENXjMbxf1cZ/t7x2fApLQ4wAniW9FNJ4QfXbh6Q+IJ2TkTXx+CQ6JIjW2bcfQZkrf4KxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772393; c=relaxed/simple;
	bh=0WmrG3qaWmTF1jIsNuK+nXeko/G3CtlMDvPl4ax5BMY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AaSsZQL9tJJvd4vLab77hoLCgMQ4DrZIx4R8GIbTrkj7xxmeztHa09WzLF2bsOskxxgJgY9/W59PrBpL6CwGav7LaydVHOsHGy6rXnKpwsyoeFztgDAP4rNkP4aUm08MLVkBDujww3wvgG4O2mxp7wvBLMP+u7REPbBigh5VQHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso158102539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 18:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723772391; x=1724377191;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WmrG3qaWmTF1jIsNuK+nXeko/G3CtlMDvPl4ax5BMY=;
        b=fP/QokYDqCHOHU9DdcA8LfL5tcSCISc5fNDDKNrZ+i6Yo69VEnYxbuprYmWUzk91IA
         qVH3lOT3UfUoaA7Fjn2Qz0yHc9C0cw+ae2m4NWv3lN6O4CXwzLjJ3rvWJ35If7gI9hhk
         IbeirIakMK5K96cYCUOtoVW/FqVInVGHlmGty5YDFRY5RFsmmGx1SWde14jVbVifCY3o
         /5HTLwwWcX+gA0Kl0hv7vSmbSZ40LRs0ubvQTgsgdx0yYudJ6kCjc75GV7xVn2D77Q4Y
         42ddrWaURxsMr11up/QvYHZCxbehyuapcw4FexqEvloateoOjjde/HgVRW2R5gIxi60+
         wzIA==
X-Gm-Message-State: AOJu0Yw+I9T0RC3qecod/TmmoKBmvzSjEWloZEJkj23FOsUl7LypBxs1
	5aQWpCpuIJfdeKs9raBKqDukuqlqJUvmzfONBDAIDC+h9cj7mKuQr9HH8z8ZVw22JwDUSGE62jz
	IM5bDbeyBdHZZ4PrmQDchRUSF/hLkntVGdIRLSB25vk/eXnmWzi0ILP4=
X-Google-Smtp-Source: AGHT+IGgqqgUMhP/730cFBMuVkh66GRDrSC2+Dn+tSxKMaGtumK3EcH/7KjOWxqzKVR6M3AjqKj47zjcexELAT7ffNRLnXshYZkX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1541:b0:7f9:3fd9:ccf with SMTP id
 ca18e2360f4ac-824f26fb839mr3616139f.2.1723772391396; Thu, 15 Aug 2024
 18:39:51 -0700 (PDT)
Date: Thu, 15 Aug 2024 18:39:51 -0700
In-Reply-To: <000000000000e64ead061fb68def@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102921061fc309c3@google.com>
Subject: Re: [syzbot] [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()
From: syzbot <syzbot+f3fff775402751ebb471@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] ocfs2: Fix shift-out-of-bounds UBSAN bug in ocfs2_verify_volume()
Author: qasdev00@gmail.com

#syz test

