Return-Path: <linux-kernel+bounces-324885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C9B975217
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FA11F23132
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C381F199948;
	Wed, 11 Sep 2024 12:27:59 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D9192D66
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057679; cv=none; b=icA+T2pAUuCgXpN/hEccw7fgC43bf6KZZmMMqjJJtUnkQObg0cuPgH1/om1DMDQYs/thQ3kRYbsSeiIrQOkXet+8VutpfcUMR7sikJ6rqly23g3elSGpbcwFBcB1M41LojGzCgKPIq4k+FxYhIR2GVC0LQocsIJPOijEnqoCkRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057679; c=relaxed/simple;
	bh=IzlrtpBuUEkl2AS/wbJLfkdZ5Y9XzjMa60wQk2jqqfM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uEgXke4Ht5mU6pNShHb15aTjN80EKcJUwlv6wkEg1T0C+XHybl3HxKMx+4uXpR3PZclQuagb7ENBcxcSxKOaYr7kiOda4a94guRP0GSD/EEfIdSNOWj8+EI11WM3YUcqmn9rijsQ7PoahD4IUSHyp0JJpi1+RKuc0X1kFXTdEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39fe9710b7fso126093735ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726057676; x=1726662476;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzlrtpBuUEkl2AS/wbJLfkdZ5Y9XzjMa60wQk2jqqfM=;
        b=i2uDazTww3Ue4ZK36ZOlgoTFgP7m3B//xqYdY2T2NWyEJlN1NZdC7xAknFRaBumNPJ
         vrAmZGXmdwDAmEdMGJTWs8jjW7rG0wIC+gBH+5UnPrVcmxEd6m4NJr2S2ySgdddUAdN+
         sihSVVudPaHWF0xnMbE+KhWtoSXi6NSVrgTQrk8iulFL8P1VcQ4jBeUJojBtp3xzIJfa
         lJMLRMOrendp7IG1G9Wd4uyVsPjHAC7PZP47IIBSAkS8UKkE/KYEgMMOatI1G7Zbb3Om
         UEAbD/30ePPUbSCdN9tHo6Qp3P7zCeFXOVBMsJ0sCJm+GYwYrwnI8PiKhCwWCGnMnM6D
         lvww==
X-Gm-Message-State: AOJu0YxADxWZIHaWno0M2eAX2Dg/E8dKg/PMOgEDbd3nFW+mJEtQHhaD
	4Oa5bFVvLtpzS+h7yEES3J52InazCTRscJ4JFbOeWuu9F2rRAUS8lqyFd3FUmV8SxSlElf7xsSw
	G8v8EWwULUxQA+dH8Ns7udVa+huIwWm2y5XQe1fswePzJhi20d5OrKVE=
X-Google-Smtp-Source: AGHT+IFMZkCrVMOd7BzX3ng/7DCa3afbgnZoYPifmZWoi1S5vKSHGGwboAcfxkGlx3jpFQlKBVfN6U3zdpSXLhhwMEBgVyCAaJTj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c9:b0:39d:24db:d50d with SMTP id
 e9e14a558f8ab-3a04f069c65mr203471905ab.1.1726057676675; Wed, 11 Sep 2024
 05:27:56 -0700 (PDT)
Date: Wed, 11 Sep 2024 05:27:56 -0700
In-Reply-To: <0000000000000311430620013217@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae2b0a0621d71ef2@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
Author: alibuda@linux.alibaba.com


#syz test

