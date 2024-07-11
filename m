Return-Path: <linux-kernel+bounces-248565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F8A92DF0F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1625228471B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 04:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29034249FF;
	Thu, 11 Jul 2024 04:13:00 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C39D1366
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720671179; cv=none; b=Hm2gsxxZtyqOj4vwGJ7DvInf0+jAlCT7JKyJhAj/n1KoVz70Otb52Jvj8Qt1NLl1jqxQiqzOJAmbOCfINeide4khHMVdrVYZwXxwrS+/Ies9VfHXgsMAqz9NRMdvBnAA+djvgwEsoJPRR9Iog618jv30V2PTVkUZABujPiFlDeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720671179; c=relaxed/simple;
	bh=u6GqJUo8TvFPGcIwxVFtRbuJyDMkSW4jcL0sfv+Rog4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jVLZvfxqNi6iWUQz4Cu7f2W4s1sGEnWP6EIBKfp32ZwCA63FPmcLVJntPliDE3CsUsPIDeef+nsi8DMLqJ2WuR//YrNVK6fkIVhBPJaNe0JghKhY+Tolx6zKCkYcWQDiufO8qZAc13P0fyfK1VwkG7k90y6WcitdwFCb/pgJM6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-37613924eefso5873035ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720671177; x=1721275977;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6GqJUo8TvFPGcIwxVFtRbuJyDMkSW4jcL0sfv+Rog4=;
        b=U24IXJsphuQB79WBrjgK+OJkCvjScczVLBNlpVJBG7oDg6nOmpIF85daNaFN5aGxF0
         u8E05YubLSmkmUTgdzKkqTACQPG4DSjmDvQg9UDL0hHQC6g6Hr8ONSOMFEPNDyrXdgNk
         vXgJWxW21G6rbf2KKc3rwvn6qiKXVE9ei9bz/QeStdQTJiAO+seVqe/6Im2TlXhPaxEM
         BUgbSs1eVRXN1YSUepkKRx+vP6dIRaq8iB0a6bkV9nEw8A85JG6+Ag1j0KvQPHgY7BtZ
         npg876/L6QZ6ROGqpD8qrPtqDjhgx5c6N2BjpmWzzNlIFvv6rKkpS+oA5Pz3TBI56dqn
         5l/g==
X-Gm-Message-State: AOJu0YyoxDVZrJ0+dKc5MVJIEc3aEx66Fa36/+fuhvHL+6+jT8s1wDs5
	P3sNcep9TyeuNUaKqpZ5A289Dsu5jSIQh1H0mfOR8cYHCHcxLb/+VB0YINhUPc4TrBLFKGLPr0F
	s0aiPQTALKoNTVIjxJSdCoFzuZRr6sJWzzvbzUX+WYfu1V9u6//RLY/E=
X-Google-Smtp-Source: AGHT+IHPzmw6pqpwlmVjAggaPmsjAiemE3mHN1VwxpiO3Ai9ADYApPjOEiMDeRYnoG9LkldPoPjgGklXwE8KPNTPoqwTvMN+2NuO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2486:b0:4be:d44b:de24 with SMTP id
 8926c6da1cb9f-4c0b2999752mr499165173.2.1720671177552; Wed, 10 Jul 2024
 21:12:57 -0700 (PDT)
Date: Wed, 10 Jul 2024 21:12:57 -0700
In-Reply-To: <00000000000047cef3061c5be92d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000504513061cf0faf3@google.com>
Subject: Re: [syzbot] WARNING in follow_pte
From: syzbot <syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in follow_pte
Author: peili.dev@gmail.com

#syz test

