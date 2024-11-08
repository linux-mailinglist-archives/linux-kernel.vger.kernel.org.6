Return-Path: <linux-kernel+bounces-400853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8809C1339
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0E11F23309
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B54A23AD;
	Fri,  8 Nov 2024 00:34:45 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75454629
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731026084; cv=none; b=mpHUoasA1AL86b2qAoZZWGDPwN4xv7S9oSZW82Cg6OTuxEF1PRFH9RUEioJxxejpphPwgPbaYkczsduLBs/trTWnOZisowt2zrtg0z49JNmtuLcysNAJrODoX32V3q7Eqzv7Yjkd5+MDAhMmJkEXNGm0+IaVeur7FbIYEJSb7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731026084; c=relaxed/simple;
	bh=j1Fyy4Z5N55BrgODQnd0muGSDN1TWBtSjjd+yA66Nsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iXoiP7J1zv+PW//oynYHO6YUrr99slCiEYT0yOPf7h0taPVUn/xtkXHINQur+rjLc9I//Sm0XkpHntP/WxFK7EluoNCtsRE5vDv5YDj69OosKwSLRBWqYV9fylwZnFyj9JA0BbnV3TyrnwkLNTCf3RDTqiPKCQpjNNPq6Woo7hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6b563871eso18370005ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731026082; x=1731630882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yASy1ICFXFB6xe4BEfgK/VGwEyPEhbq0PHEPSX7hYGc=;
        b=nQ7WttqhRtgyqrpL8iF7/vdCWJJsbZXOmeYm7Rf4tMms7RT+/1FpFZWrqPlOTZVohu
         epZmAic81pGN5lv92FkGEoTOIafSEd4HdtW59G4aBgDi0tdOMkhhD+n043Lh3eajXU4L
         ZIFyzkISy/P/YGnbPpvzqfJlYBD3rXRlwThpvK5fhlY0EMbfCyMcHlKhLf5W9Hszd/9L
         wctDn0AaudarOX26cA3/BP2E4VYbyFDnpCkSDWUbQ7/2o6MCrddIQXim5s6TwoUKDUYg
         8OmeG+188ZEld8fqt+8X30eEVMqeUBjBB7bv2oCUYLtXhvPplE1k/BcRMxywvbk0Xbel
         SVNQ==
X-Gm-Message-State: AOJu0YxwkodBH7I0xsatqaYCNzE/oZFL7x+Q/I9nPrQa/1VNJeb+tvgg
	ZCROo16dxAbI++Zbob5G7htZACNrqWuEK/XuQx6XWHaua9tD6pu+aj90VNDizDig95EcuBBnQOD
	1r3zBP/oWT3qkRX+57+sjZ9OFPzbZmhKbmBGG73NJtKG8Xv8aDCwfpu4=
X-Google-Smtp-Source: AGHT+IHVo/N5mLN3dmELr1eg/p4g9w3P1NL6Q7FKjajVnUTpjnzZNF4jvb2vt1SJzzfMd0ub3/BQFw7eryYxdR6V5eYfm/LkAwwx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:3a6:b258:fcf with SMTP id
 e9e14a558f8ab-3a6f19a0126mr17214995ab.2.1731026082678; Thu, 07 Nov 2024
 16:34:42 -0800 (PST)
Date: Thu, 07 Nov 2024 16:34:42 -0800
In-Reply-To: <671b3f75.050a0220.2eb763.00d6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d5ca2.050a0220.15a23d.01a5.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+8761afeaaf2249358b14@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Ancient versions with bad bkey_formats are no longer supported

