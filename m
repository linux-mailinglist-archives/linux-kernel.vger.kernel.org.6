Return-Path: <linux-kernel+bounces-446244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A79F21A5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 01:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3D45165505
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 00:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E4453A7;
	Sun, 15 Dec 2024 00:59:22 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8F4C62
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734224362; cv=none; b=oLZyq7OJKfnTpHqAyx029zYcNetTMzzkYZ75Xff6Z67Ukk7qntpDb8VM7F3n4wqKUjsVgg9L1JQ7q5ZOxT1pcYGsuDbcAMknCZ9gXXm1PDuQfmy7BmWBNl8thNkn2JZ924AflxEcoENy44Db+xksmK0lRujwr7m3aa+oLXTqdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734224362; c=relaxed/simple;
	bh=mMVV0bFu5oJNqOWQIFrVjdomcj6Zxi+vTq9VfsPOT8A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CNE8USAEp6LUBK4ap7YldHEZ6uGloCSTRXfLpyOqx4FuhA7W3hnq0iU3UaIXC3cpm5Zs/tfkTq8nW+wjk8/7rQjd945GSarpTni7MmPnVfq2rtyuBUPtyptaDJfP62ZkE58JYtYCqP3ZKCMX6oJhVuNnnO44LXgmRWUip4hL+d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so53946345ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 16:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734224359; x=1734829159;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMVV0bFu5oJNqOWQIFrVjdomcj6Zxi+vTq9VfsPOT8A=;
        b=PavQOyzzaTaJwW50x7+kUh0wrpgEZBBzNwakLF3tahKJgJFoq2wdjkUim6Eh+iA5Rm
         L/GJk2yiYY6mF6BmdTzfSbFeMUC9gBOdYdD8PkusT9C9c4ZbOa+MFONGLlUmKa39eFfL
         sZxbvz9EIPirZWgVHiCeMwNRtCOkqw9tsAL1tDYMN3AgxTSPz5dCudEmp21q5CZKWmmN
         9rAkdjezcyHkWPA8uQUZINtVk+1eVOXR65BlThNlrSDwYutqwEU4rDRUy0pCoV4XgtZ/
         W6DltMXmUGNoSMhI64W7Y+TXOMKfOOdGTDZbJDtC8Be3ONJKwVJ/FHAvZhit9BeN34mF
         EWCg==
X-Gm-Message-State: AOJu0YzeYURI2VvAyB0YWevXBQRE37PSe2Bnd0bchFTrgPOJ7W81HoQu
	IeXgfOHhrPk46W+Q4O4smYVqnOnbzKc7cahcwAf+ZoFaIR5PWxmkNePiGwifZLlYt6cZ1+JnIAf
	qUaiCoDljj4EbpDDy4cg7E54Lx0ffVyPrw6oFyxUD4EkC+v7ZBoYnnqg=
X-Google-Smtp-Source: AGHT+IG8v0wK+GvRAVNQ2uC2i5CCNk0XPEUdS3uEHYb/bLPCiqBIEOPRiNdZjIuIE8NNVYiRzbTVxbtWSDV1unsLbfhgDktV7+nk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:174e:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3aff6020017mr75418845ab.9.1734224359698; Sat, 14 Dec 2024
 16:59:19 -0800 (PST)
Date: Sat, 14 Dec 2024 16:59:19 -0800
In-Reply-To: <674f4e42.050a0220.17bd51.004c.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675e29e7.050a0220.37aaf.00e0.GAE@google.com>
Subject: Re: [syzbot] uninit-value in LZ4_decompress_safe_partial fix test
From: syzbot <syzbot+3c88ea590c13f5f92152@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: uninit-value in LZ4_decompress_safe_partial fix test
Author: qasdev00@gmail.com

#syz test

