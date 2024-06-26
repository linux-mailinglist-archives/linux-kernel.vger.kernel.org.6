Return-Path: <linux-kernel+bounces-229857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F991753C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 02:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE242844DD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8546125;
	Wed, 26 Jun 2024 00:32:53 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C76C20EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719361972; cv=none; b=CaPFm4o2CkuEM5X8+5DKwyw3d8LbSMVnpjobaNyV8PqYVj6PhtSljyZGvmN9Y646/lu8rsjz08xv9wNzxtRGbim1nYOdwVA7evzfxU182uDqJVVd5aOt93/9tvOzIeX0bAoJUcOVuQRucLCo01gB7AuWyeOKVYCcxEYTxXL5418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719361972; c=relaxed/simple;
	bh=+MXTEKHaxo+E3/xYjIEGTLf3CwXTfz/+hKUXW8/qCA0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=u6fwBk3ut4OB4r4ore9fFzEzzb/sdnsMJ2OM4rXLipWLx0DpeJIy9RjBfnaeiZDUIqIeeAdQosOwMyQBQwEJ1ZamF7rqCB8/1/hihAQR7yLnGUxw4W8tlBEfxjRFeZq6deazMJcwp6e9j0Ad7HMOUq1/KdEYmDOOqnZ3Q94f5YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so503992539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719361970; x=1719966770;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MXTEKHaxo+E3/xYjIEGTLf3CwXTfz/+hKUXW8/qCA0=;
        b=m6iCSj7MoPVCHZEpHTTTyI+aL13qszNSSotqtIKzNYpvWWOEjhuwfFSqAmJiYkdrSI
         gn1Hfzw9YU7KY2u/+XcMC9LWOOF1eBnRrgPGG2Qi6QHyUKZ54GDF/OR3bGgq0DVhEWru
         +KHrN9F9PNXVjjNxqm0D1qZK1blab2nW1uvRsrtLceSU6boRSEp5X9fZLepSVb8O+oLr
         3T/UlANRfcRocSDLSDNLiKwbjeo//OGFKZSTs6PHqtjjMGUgF70wMgRxiZnUVi4+Xw9W
         WVIJ/QEhqHwRpm9TTsJ0q4+0zTqTJc1LOn5F8IS7ZAuuyJhuf1cBGy1ILRErEfb3j4D0
         PhQA==
X-Gm-Message-State: AOJu0YysvnS+I2r5o0sipm9JI2paDXN30VgcwqS63ys+vBqiUR/B2LMo
	wM5LvYNi2sFfEkKG21GPylek5DXlXd9Uhw00wlS6mMq1jyOIrmkjd8uYd1lM/ScsnEvGfyIRa2+
	q8PdZ6MYADnhi+XJuBMxzkaxyGezlDrQ9mlV2DFd9ODpWfJPg1J19N6A=
X-Google-Smtp-Source: AGHT+IH3aYJzCferR0TjXaC+RPCTJ1Vm7/y4aKoBACmhlFBUmmG2Me1/HnEPxv8KQkHdp8hu7eTAMs000J7Nfr8FWQgUExPrbz2I
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:4b9:b122:d07d with SMTP id
 8926c6da1cb9f-4b9efc65427mr250896173.4.1719361970521; Tue, 25 Jun 2024
 17:32:50 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:32:50 -0700
In-Reply-To: <000000000000d4be14061bbf7229@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e5a26061bc02793@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in __brelse
From: syzbot <syzbot+8c750412421a6826fb6f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: BUG: unable to handle kernel paging request in __brelse
Author: peili.dev@gmail.com

#syz test

