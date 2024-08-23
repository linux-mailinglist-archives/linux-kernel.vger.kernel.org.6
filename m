Return-Path: <linux-kernel+bounces-298537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF30795C885
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A925284CED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D512149C40;
	Fri, 23 Aug 2024 08:56:46 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC35142E9D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403406; cv=none; b=SfN9VwrhnzwLf5ct18ibMxP0rqjda7iqJgFGNETo/vLDc+qQBxMx89M67/nhaQZiNsOkhEdPS3ppS1oPdBLVKY/JXRaP1twX1qPDckhdWyDWrRn6814QiKAeZx/pwqgUfdFwzUeAC3qIjHj1N2yyWRUEM6g0QquWO17Yxc7bvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403406; c=relaxed/simple;
	bh=RKOQr1DPn4xAPKfBCs/8ajUtyNcBbiFozfRf8hWrO9A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SbQvGBqIlCopO9tfGJSTUokFFrSIiMNyzg4rv2YtRKT4TRlqw+gNAYxvxo06ThNygsalgZNEmxZu6p/aGtQoxEbCw1DcBNjOsAgw0DKs7X1Xo1nrsshTWkyfouU8gwjGMKkkD5Jrn84LaZoXZ76UZpHDnu47FmF0L926FrNilZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39d2dee9722so19142045ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403404; x=1725008204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKOQr1DPn4xAPKfBCs/8ajUtyNcBbiFozfRf8hWrO9A=;
        b=HwBZil9iVS+h1cLE5359U3sxqFQDsFrMDbtFRkqEDzPGdb7kAi5x+Cbq/OwQHJiUnq
         0+X/P41lT5o3o5nGIgXuar/arN2BcCnmpuOKVexnSeVgFt2utUswTpGEV55eecyt7yno
         HJwXasmVyByPf4uZ5eRHy54KXhqb6bBULzEwyKDuB83C6wkyI1XmdpRtl4o0REGwvefk
         PBy+XTlw9CWkWFGeoXScPc/p7buDT+HO8cTgZUf4QA/F+pIht8znNsl8K69u2vQtcXFd
         d1aT58e/WW5xE90s+7v3z7g1GaQyDDdfcgMdTqRB2OdNACsZEsdk+EVfOkkozcqxNi5t
         DCHQ==
X-Gm-Message-State: AOJu0YyV7Op7q4liNFaU1KdmcwPg6jPVgqzZ7LwOiGSFiqTdBLGErut2
	HrxNyxECC/T9YOJc5Phqe6Q6EMcq43AKOAuxcVLa+BC6e+6YkzqLHM2rDVZqnbeEb/P4JSJUN+Z
	CptqolVNHisjYhnVmti5PvnviK0HGEc3eIhHa2UbEg/1/shgkTd9Ky6E=
X-Google-Smtp-Source: AGHT+IEWId/xB45vGQgvi3l5lko+8yEaC43LZzbPLpNAG+jrHaAN/VYy7Q9+75dhQNMqGmA3zZyI9epi577Vd2uOlvJR6eDlI0vt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13a1:b0:39a:ea21:1202 with SMTP id
 e9e14a558f8ab-39e3ca01fc6mr836725ab.5.1724403404024; Fri, 23 Aug 2024
 01:56:44 -0700 (PDT)
Date: Fri, 23 Aug 2024 01:56:44 -0700
In-Reply-To: <000000000000998cff06113e1d91@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058b9b7062055f471@google.com>
Subject: Re: [syzbot] possible deadlock in ntfs_set_state (linux-ntfs3.git/master)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: possible deadlock in ntfs_set_state (linux-ntfs3.git/master)
Author: almaz.alexandrovich@paragon-software.com

#syz test: https://github.com/Paragon-Software-Group/linux-ntfs3.git master



