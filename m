Return-Path: <linux-kernel+bounces-298530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311A095C873
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01901F21DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718AB1494D0;
	Fri, 23 Aug 2024 08:54:18 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7144C76
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403258; cv=none; b=Pv1ht31KC8B3Zc4U4IRx++/OTdID8+3v7NbaBQzoCci7d4LRrJv7+jx7Qg16A3HJhkMc7p/3mRPMh8nIUDa9zoNQVKjgwTOzdQYkU7hUmcSL0LPlZkJTLqpsrPuqkDiP08k/7MR7SPSujJkkV3cWdRp/K6YKo8mNGO8wLBB6kus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403258; c=relaxed/simple;
	bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KabivoNuhKdlCkBjBLpUYVwqxPGaxruqO/zKtYbl718c4o2xPNsLLG8WxS+qxJiR71J+6S4HbFdJpYvc4p7kFrvZvgqNGuvj/D5qv3UJhk0mmOYteZFVyNc4XQ82wXXjlwYtfAXjUiPIu4HHVne1Rn3PzSuFSLu+I6Yk5gzVk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d415635e6so19248315ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403256; x=1725008056;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhC5ISVNW0c95Dp8v4Y5XXSGKXsDIbg+03MjLXbTZug=;
        b=Cir3q2badG6W6tQn1lj0QRy17m2fo7Yu543EJlEf6cMMiwMg4L6IcDqaJ7f1vljtgr
         RuRpiSGdwuV5mLJQs/j8u5+9765sHYx/SfTbYS5zvEkO9F/rTvd+GM65+ieHfSTZv7A9
         1SxoaKkqBsfdlWo43pvks7wuM/pTe95pmOXWbZVzVoAquSaaE+sOsURVtKFKIkGtuZSL
         3w/khH1hjmygpyxjG8RslCRgLtJQbX32HiwgahswSrkcPw1suQHKNEx0wVULkCZtd6Yj
         fNPOGJFw6F8Kp1TzJNaPOhbWHklDUGv2N2CISNezlMb8U85ljbZ5cAf0vAT3Dn084fCf
         UE3w==
X-Forwarded-Encrypted: i=1; AJvYcCWcx5Yb0pNrQj6B7Yu1jiBbWBgup1dxHztYOc3VxcE1IA5Aqzfn+MWNDynre0ZA+m7kBgyxdLJ5WsSfYfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7nMja2jAgi0QjGhldhVp3O6tyB2bS19IEmtCw6r7NntvSNjs
	gaeON5svbySNu2wa9jL4xglE71j4hYTSPzho+oEcAFm9LgMJ4FloTY88gTCuKfV5FdsTzX9fV5P
	rda63E7uJcYGazF0T+I9Bp/0/V9q4KEaIlSWe3ffihFvY7XVZYbm5lX4=
X-Google-Smtp-Source: AGHT+IHgUcZKM3rpcUM8/ceNNcL0vuTo1lAjtIrKGb7u0mDsIS/pO5t1ZFHuY5xhtes49eANjgu9fg23n/Id2lKtjPVJTg09g1ib
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:39a:e9f5:5ed5 with SMTP id
 e9e14a558f8ab-39e3c8ee2eamr1227755ab.0.1724403255857; Fri, 23 Aug 2024
 01:54:15 -0700 (PDT)
Date: Fri, 23 Aug 2024 01:54:15 -0700
In-Reply-To: <b7a4c61e-ffa5-424d-854f-0d3352a4ce83@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083e567062055eb47@google.com>
Subject: Re: possible deadlock in ntfs_set_state (linux-ntfs3.git/master)
From: syzbot <syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:https://github.com/Paragon-Software-Group/linux-ntfs3.git master

unknown command "test:https://github.com/Paragon-Software-Group/linux-ntfs3.git"

>

