Return-Path: <linux-kernel+bounces-257679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F91937D65
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 22:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F12C1C214E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B352149C7E;
	Fri, 19 Jul 2024 20:40:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D95149C4D
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721421622; cv=none; b=KXD1NNMKXnP7xbEuZJmCBYDMaQJvs0qeCTkPZovVl0CX/9ZeyuKbhnRWBPJ+VbDdgY/7/mDiV0ht/vsfl8oIboVTaYDqWj+MSKo3fSRchRzNwWo1uaETeUCZa6lRDd5YUHpo4PYSHhYkoCWLGrcnuzR/CZK6x/4xNhG5TwsgU30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721421622; c=relaxed/simple;
	bh=E/jAWjA5xlQhhya/vJXnbBhM1C1m77mK60KiPS212Q8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eyzN0yjgziwZ4AeVLzMqJereu3IkqRD+FlUV2Fp796wJIm+gv/VvY5yrnpYPvHyxLiCZpjLjYkaXM6k0kYeIYTIdj1ThnUad/lAKifcg0R0zt2o1x00GtCEXstk33s1QgC34olG+3K9EqsULBsfw2FiVa8ijufaMngvPWPvn8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so366442539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 13:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721421620; x=1722026420;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URd4OeGeTmKbB0iE+yprGWl8brVQ35aC/METBWSlWbM=;
        b=XVeQWyMd5qvIBVKVApIfjvKRKUstHdgJoypfidvMW62xYfYdlc/Xu8E8DBVo0ZHUNR
         Uj28lBvKLSi/tp4mr50lq2/fUPptr839nf/8TRtiJkrNGqlfr5+e8wVFhmRovpVBzzIT
         cq1tsFqy9dVEy9dUSp0FwlpyOZ+aJjR4npy+4xWyBz+S0NxKUvQGdAMcL+JPB6rsrR5+
         3abctis3km8YusjzRlKydMr3saNymdL+D0AIeT5vEsYV0tFzFZ9bfGZOy0nz/PcV5IpV
         lX7lFZ6+4DHU92k1mN7Q5xZ4WEaxIQ2EH0eSxgM6KVQFXTRgqDA5wpkl1yNWwuAPT7aB
         17ig==
X-Gm-Message-State: AOJu0YwuipjKETYcqBMc+rJ2yeWA3jdIyyp6/GHTowrOapm8lzAWgGAP
	gG/sKpHJGKABs84A8IothCNCcVLSF4yImDQh/tMjdhw8C8T+imtSee9WKFm570jKHjqhaIYy1vE
	R0FXEBlpLhCyTNSgMGN1yeS5T5J6Kbp/G6gZEc3FoEH8e/Oqgb4bOJHo=
X-Google-Smtp-Source: AGHT+IHkfuAQGAsZO7oebKx4sXr/ONVtGxwFVOKTym8o7ezkVn1RDQOsfZ3jrYUe7uhWDpLE+wZcN+MjcZb7aDTmMgPnWnEfWieH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2492:b0:4b9:5d51:ff99 with SMTP id
 8926c6da1cb9f-4c23feea847mr36043173.5.1721421620450; Fri, 19 Jul 2024
 13:40:20 -0700 (PDT)
Date: Fri, 19 Jul 2024 13:40:20 -0700
In-Reply-To: <000000000000c396f805ef112fd3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000322a24061d9fb423@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hfsplus_delete_cat
From: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in hfsplus_delete_cat
Author: simeddon@gmail.com

#syz test

-- 
Siddharth M <simeddon@gmail.com>

