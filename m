Return-Path: <linux-kernel+bounces-354114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B669937F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F56B283D6D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3181865FC;
	Mon,  7 Oct 2024 20:08:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982251DE3C5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331686; cv=none; b=MuQbY6rRR9f9dXuLlfutz6a4YVTApMBsOG8c62IAs9FXmDUCKf1uECF88Bb4sjL4uVgJSdpk8YDFiRMbOcCbDsrD4HtvwMj+7VUY09sKivZA8tPaCaIzRW/6nsAGqrp78mojIGOAzUDtf5+4EdennpCAzXk4ux1MT2VHcLtTN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331686; c=relaxed/simple;
	bh=BHrZlnUbGrHG6pxGbYaSK0SkFXNjMQoGKM/YpgaNnL0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FkyFq3Azstxt7RSnntObEDPPeqI0icEH2b+FZ4qTGcRb04ZZNOtyuZqRPo7qNQPGc6fn6A3s2bLhnpmnY+Hp3fuqwKGaTwO/G/YInvkc9mkh9p/uyfmT7x8NhO70ulzcQzdQT2SNZpp1NGxVFNEUKLRyAuZ4s1H+vL6X4sRNrho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cedb7a183so401793039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 13:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728331685; x=1728936485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BHrZlnUbGrHG6pxGbYaSK0SkFXNjMQoGKM/YpgaNnL0=;
        b=tzdL7RX1dylR/pLxF6Yo+3VytIgHXgFNGW+wovWaQ6qzYdgHEUbs0VZ/BtyxmH4VWw
         yDVmgrSqjDVKdGyD3WgQWLPmB9JDvW8r/j8yoNqSOjCz/GPKgzyKtbvezKBR7yuFyOgJ
         i8IKPj+RFocImih3xaMGiY5qFlm3fIeI/gkugAM+VqpRiglUhiAeQyyEQjWg+9oMP6/R
         zAkSQHzipCAv2L48H7rBRe5UaQTBmWwNIKfqXTZnV6VHjer+5zxY5qD2fKnMcLekrbcz
         sNbHkp2Qda8eoctBLufPZ3pfFyh9OhfRr8VVbmRS3IPp1fCKGmuoaiYdbOb521Zj8lxv
         7eTA==
X-Gm-Message-State: AOJu0Ywe9F0E7GRRebJgZxMc8BF+9tEOOAA5PKqTFC0Yz+7yZ2H8QFdq
	+TliV/cH62UGy0vSxeRrlbb0jKUYJJmIGpDCB7drEbeRTcpF7EDySJzT9gkkSnJ+UDcenVRUfzz
	VGgfcufjB50E0cCiWAmoDDI1hSuhO4nHXHVsqNxzXv6I5ZLX2aFbnLpE=
X-Google-Smtp-Source: AGHT+IEkS14wUAb4O89S7SchQ/pXu/S8l653aokyKbUJJH7VI6TBCH0X5JewX7cc/z4QXAPUDgIQNwUp4B+amoVO7+0yKD4a64Xf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6301:b0:834:f79e:7324 with SMTP id
 ca18e2360f4ac-834f7a94df5mr1199549039f.0.1728331684737; Mon, 07 Oct 2024
 13:08:04 -0700 (PDT)
Date: Mon, 07 Oct 2024 13:08:04 -0700
In-Reply-To: <66fed783.050a0220.9ec68.0051.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67043fa4.050a0220.49194.0518.GAE@google.com>
Subject: Re: [syzbot] possible deadlock in bch2_replicas_entry_validate
From: syzbot <syzbot+4d24267b490e2b68a5fa@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: possible deadlock in bch2_replicas_entry_validate
Author: pz010001011111@proton.me

#syz test

