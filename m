Return-Path: <linux-kernel+bounces-204386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D68FE80B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27712893FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB56196D81;
	Thu,  6 Jun 2024 13:39:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD22196C93
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681147; cv=none; b=SFeLps2a9j4kDwmHJjl9izMeLh6RGYsEEc44Vz3+rd+fl57kqe9t44jZTGFU3Vk2SIOtiZShrT3T1NOERO2Ne/GmDY12Ha0vYA/UsBZi8VGNSgkOHKNOlp8iYpc5u8SKj7BfN40GeCfoGCPrDR8bjBPyZxqMwTfgIpS+oeIxN58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681147; c=relaxed/simple;
	bh=JyMgzNiKFIOHa9rzxwXRL1N9TWgt8tmWq1KsLo6vJSg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=opyALY5A5bOZad9QchmmKmD0aYcEAPcTHprRPMpgrF6mzKQeFPmeN1OVUlIpLfrL6N8TzKPPR3S8Z6683BqT4G+o9pVkbqi8B26aHJxLqE2Skyfx0BhooVThFC2lrD8oUf21TP7PJpM3zmmt7pwbUlyJ+qWEsswD2SdI5XABaRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e1fe2ba2e1so106681039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717681145; x=1718285945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoeDV6DqEbQgwStT+gHqMyMJbB4i+m0tPBSg2IdiSA0=;
        b=ENb1ewlyGgyXVx/2D70FgN7Jt0FQX6YTcmpuBQ7i5VvsfWBPb7tPTyqo/Jw9H+P7F0
         4aVJ0+DMgYxGyw47AB3vmLIh3L52RgOVJfzQrM+Gq9o6l1hAZ1OR3RylNSpNxDKC8gkn
         wxha8jVq3K6nwWaE4RQe1+2LjUJ/DNJ3JIe74yxhU5a1bMJJG4pP/F68PSLZ8csKSIK6
         yQb116cxX90AsGkaDd5rWGKcMqDx8uEQw+kG5JGD3wUvt6LOL2SbdP2XOc2H9kns+TNI
         Aqkh2iLh2M/mDujie69iQcuRLxzy2L0ya/PW8fgy9MJLvI1Db/pef0QxM8OF+07v5vWE
         6QfA==
X-Gm-Message-State: AOJu0YyUh3Sm9urtpkjevMI40IP1ifUaGdzhHdHOIpRYaatoyZRALxAs
	nhKb0Vz4aS8LrFWmyDMYqlC4PleUH5j/k9dq+8Is2eEIveVBS63HmtMaaP6MTAkkpcydOddlijd
	e4i3sp0WrqQbpFajwqEcetWwzWEwLM3lazHGBF0hMRxlJi5D1ndRTbRM=
X-Google-Smtp-Source: AGHT+IE/JW+At9aSMNJUF/8bErEO1IDrDTcEF2rbo6KmjzBfImlnHYgdf6HQ6L9P+w80Yr/8HHPCcaZxQsaMXqiBXnxwa6a7R/0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:8811:0:b0:488:9082:8dd0 with SMTP id
 8926c6da1cb9f-4b6371e7b54mr89800173.0.1717681145699; Thu, 06 Jun 2024
 06:39:05 -0700 (PDT)
Date: Thu, 06 Jun 2024 06:39:05 -0700
In-Reply-To: <PN2PR01MB4891DFF0F26C14B0A7ED225EFCFA2@PN2PR01MB4891.INDPRD01.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086ef25061a38ceb2@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/trace/bpf_trace.c
patch: **** malformed patch at line 5: diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c




Tested on:

commit:         e377d803 kernel/trace: fix possible deadlock in trie_d..
git tree:       https://linux.googlesource.com/linux/kernel/git/torvalds/linux
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13052b4a980000


