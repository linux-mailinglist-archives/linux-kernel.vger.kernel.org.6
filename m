Return-Path: <linux-kernel+bounces-204202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1868FE5BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39252B23185
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21066194AF1;
	Thu,  6 Jun 2024 11:47:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBC139FEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674425; cv=none; b=pHcXcC5ojkOblJwjbh+mXytbVhKegbCeqZz0oNH6JJ+wcLiGa/TZi6nKpLVALVBhKbRKiR0XQ6yWC5kOoZbZF9jhnaT22GFSnhVZlj9Ap3f99OuBrruFRvMOzltF86YSjOCCf7yrykwInCc6T8AlL7LAC/vXCVMfE70WJMhuYiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674425; c=relaxed/simple;
	bh=cb87yepL3NLm7aE+xMtGHRSskVryxcWtSReO5YFMHTY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YndGLj7T3E6HMQVfjnKIWMt8hHkvQs0+RoRAV9We3fTpIWxy/LrwKg4zujJD/Fe0uyLkt8LkgEaA4i7PhVe1Ee3UPEWf64hWQhXkdWxgTsgZkAaEZ/ZnQUWLofTiGKyxDVywQ9C7TcYx99RxUTaBkTOkgZvVmJtUI+3R0cmO7eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7eb5518702bso3857039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 04:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717674423; x=1718279223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IYshJJq9VYculDPy1bKsqpBojSxQszJDU8nyNlYmFVI=;
        b=Hc2DEIPPvIl8upra1NYG+KPdTWPdak+u9XVWJKXO3bQL7HlKTmlgwpNU8RfuOwZZxw
         W/p3ieo0QeL3Bk5KLvCzGht1wR4pg1pFrIuJ8eD1n3TAaRDiFdUW4J5E7nUH0A0m94/Y
         vhhpvta3inDFMVAWVqwjvLOrUwQlpwDTxUlDmQIWvVio5sQbOa1ToW+chG+MOyaqGjs9
         4PmQqDS2UaSCDyLqB9ilAgz3tDxHrZ9wJZqEowk8zkDjQMxt9bHNKkjnAEnKV/XliNxf
         3Sf2au6FgpB9SjKEdA6+fVEkgqiEzYBdgX9fFm/gNvP4y3FfNBqeuTE3/0cgHmn8o/dm
         q6KQ==
X-Gm-Message-State: AOJu0YzWS7YSjPX+Wf4vBTiYMtmrXvjr60v8IJgu+WXjNMIEsULJmdeF
	W40ii3uFpS4Oi/50DQh+rc5rcJ/cMt4+S2/tF2Pry+pnYgN7CeUBsc59VsQ+SI8EyED8ggl3MFH
	i6XXlM+I20uDx4rWKWV8A0NXVeodTh/Op6vsotrXus0jnKe5KjmiWL2E=
X-Google-Smtp-Source: AGHT+IETATgPmWsnB0sqEkIT6z0JgSr5O9cbQI9hN6EksOcPWBTF7EnLdgUvi8wjKsGe+h7nPuOpIYwIMTs8fZJHXxXkmlLOZahh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:374:4edd:1fd4 with SMTP id
 e9e14a558f8ab-374b1e13425mr3227535ab.0.1717674423523; Thu, 06 Jun 2024
 04:47:03 -0700 (PDT)
Date: Thu, 06 Jun 2024 04:47:03 -0700
In-Reply-To: <PN2PR01MB48911035081582F4B9893F9FFCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dab083061a373d97@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/trace/bpf_trace.c
patch: **** malformed patch at line 7: diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c




Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=119fb274980000


