Return-Path: <linux-kernel+bounces-343221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8ED3989850
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 00:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90227283171
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 22:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6156C17A924;
	Sun, 29 Sep 2024 22:29:58 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901DC36AEC
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727648998; cv=none; b=nRH0bzBTQTJqWnlqhNJwQjU0pxXbdicSCsHxTJZfU4utNHycEHKQiGmtTECZHfmwmrlcj0EHEDpLkThpfr1rxbkdQkDyxEa9XexE25MMp780HdEDF9cksSf7KK9W5GtiDOjqsIJlfKbjjzFeYzSOGkJXcjFQX9RmiD3tCJITKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727648998; c=relaxed/simple;
	bh=7TtOXOPSu6nV32xDCAJBuJ+KF8BXvFyZhrqufcxxO0M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XGYVv1b0jG3SjO7FMo3MvymDe93BCTd7nAxUAbamv1JewSDFi1OVG8TdvQxyuNc6fTRU4YWZsEM3BLKMDbAG6nF0dLd/CZHk4fUX5d24zs4FLUWhBnH0uVtj8HcqZNl2hRKMNg3lCWXOoAcIlpuGz4YoG/8J2fo0TqQ5LU6/3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3496b480dso21443755ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 15:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727648995; x=1728253795;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TtOXOPSu6nV32xDCAJBuJ+KF8BXvFyZhrqufcxxO0M=;
        b=E+elAdZyFIz7yeu/wZVvXHLBhRaMS2mZ6jBJt300MQo2psjBkpHhdUGUHDVe/8kviU
         +EGhLjz1BFO7Xaxf5j0bbetha7i2WU3DOu9g6cdjKbYdrrywJ0n2Hw7TLGrfKyanhjWh
         S52NIWXhD4juS7Ybzhe74toeBUhpietmA/ay573hXB8ifTDqq4JbhW450V8dBV+8ocQv
         1FdLfNMSTnWE/+lE+taIELuc19q2A2xL2KqZ3+1v2sQuQ/s5w2DwZ89grn+14bp67nfn
         v2xfgT+cWpCSA7OxUMEjoL5K84KZL98szO4HurIw6askyCgOdfziwR4RYwftE8k831jr
         7peQ==
X-Gm-Message-State: AOJu0Yx9L0VSrAsu9f4wvsYYOzZI3X+egBmvyf2L2vqlm34WhmZFCqOm
	OXjCOetr1ZBL0bEN2AAT6K5ZW+ZOTTuS3jSHOX+SpGmjdjqOi4p562WwQdE/uHINfMjnRTe0zzq
	CHrMOZaqbzlzXBy8AwXGosXlytW3bd8EBmZ7+CmNmz4nqsE5GYLBogS0=
X-Google-Smtp-Source: AGHT+IEjXb+BolTBA2DeFX/SEj7uqYddi2jtmBwX3Jd0KdG69fDl847ErugHqTxqS+lyKacONj880hHe80rMIq2xMKAKNz+Wvta7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a3452bb9a8mr82899145ab.24.1727648995610; Sun, 29 Sep 2024
 15:29:55 -0700 (PDT)
Date: Sun, 29 Sep 2024 15:29:55 -0700
In-Reply-To: <66f574eb.050a0220.211276.0076.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f9d4e3.050a0220.6bad9.002b.GAE@google.com>
Subject: Re: [syzbot] Fix NULL pointer dereference in read_cache_folio
From: syzbot <syzbot+4089e577072948ac5531@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Fix NULL pointer dereference in read_cache_folio
Author: gianf.trad@gmail.com

#syz test

