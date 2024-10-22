Return-Path: <linux-kernel+bounces-375352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB79A94EB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C1B23191
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 00:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845A013DBB1;
	Tue, 22 Oct 2024 00:23:15 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30244A35
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729556595; cv=none; b=je616v2kJHH0LDc6kCelLOrfT7V8pm4Ju2msJoHywU4E3+pQvq6jWuqnaJZvZDBSI/HFfM0jVO0z7QFd/k0ahm3swiyX9cKB1B4NpqBBvUqb+a0LgqHNASPrKD4cjyOcjcsu9g/DOUjhmlzH0cdzosO8CuxAj+Lg+f4aPEnAqRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729556595; c=relaxed/simple;
	bh=UOqfWUTn34eNKXi1hPfBxZjlJmY3enN1sAMptB+wrqU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WKaqTcBaguLTYK04ArBIPNrWieVDU2OguS9B71rTtqJ59sbEbVsqL9k0IA8WNAnZ4eoc+MdAFwrTBsIP/QOVtYipcWz776OvedwltLBjL2cUiYQpHpFXuckm9mnu6gMpjT2317SYlxNwExMS9mmBoFuQY21w/aCdKhfnYjuc8Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3cb771556so55630225ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729556593; x=1730161393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOqfWUTn34eNKXi1hPfBxZjlJmY3enN1sAMptB+wrqU=;
        b=rIfa6XSRo3KTYdUlTZtGAmSHMpuBug25t9UMmg9v13XpPl4Qg1UOfAphPCJ7YA7QXl
         /7+dvi4CkrkAgaYdJpkdFw38XNwOt2zdej+4nNIcQ2/Sbzw5EgoM5PE7Uj2dyQABAgqg
         8x8qRo927Vk81wkYvB1VJimb44dvC6pKOXKPbu/KAr7CtzK1Ig2jqFZyu6ogSaM+8kop
         TnGL27cGAk8tdWPmTMmSj+TLJ9uuz24TyHxIujda0XkXHDvlH74XQOn/lNoypIVLaiBO
         pm49m2gTMsosPP5vqdbCx3Y4PVMg08d/i8HP5uOgKX/oOtl+dhwNBw7WEwQYr+DgxDUK
         8pHA==
X-Gm-Message-State: AOJu0YxPIrSgJjZs/xT8aYFmJ8CqLVwZrFFQgw61pHQzGoGDwO/v1aGB
	QivEepkekVuDQuv4pLgXv4P4K8YQuvxzYRdIDicRtc98XpMY1/hZeMpbIPyWmBFgCZAfsShP8AS
	MVwJ6vhudelYG17USzqW18xdLeaEh3Trtskhanz2sABfuipF4N3CpXEQ=
X-Google-Smtp-Source: AGHT+IGk6voB8u564+22vSRenR4zvtC6JxTF5f6G9j76RBqbEjt1GmWVFRa6syKyjQsGsIcnZoi3VkhIkIw/71JctW4wLEyOelV6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4f:0:b0:3a0:909c:812d with SMTP id
 e9e14a558f8ab-3a3f406242fmr119475405ab.11.1729556593001; Mon, 21 Oct 2024
 17:23:13 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:23:12 -0700
In-Reply-To: <0000000000003e572006202cb2ce@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6716f070.050a0220.10f4f4.00e1.GAE@google.com>
Subject: Re: [syzbot] test repro if bug still valid
From: syzbot <syzbot+8743fca924afed42f93e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: test repro if bug still valid
Author: gianf.trad@gmail.com

#syz test

