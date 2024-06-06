Return-Path: <linux-kernel+bounces-204494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CD8FF068
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669A5B2DFC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104519DF68;
	Thu,  6 Jun 2024 14:38:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127F41974FA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717684687; cv=none; b=HOGNAVYJFvuH1IVyUDp6phRKji6tBePr4NcbN5NlM2DgC76XTPO/mpX7gSfz9GhE6H5zdGSwOhLPUrO+yKMUGPal/zmLcvgxQErRdDH4DSb3Y7cguINhgsXwyszUd2WuzqZw0WuSScCc+OTL+AHjvzYE/jYWHLIz+p5E8PWn/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717684687; c=relaxed/simple;
	bh=GKSmEQQhWMULX/meKsTtsC0/Yt50KLAGPEr7AHZpt14=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q3ATaEo8fjTM8zlb063EzZFpcczJBauxPtv8ofneqsO4MyuPkTzX0egRSOHma7tOql/RDEd1pYOvQiJW3L3aYGIwsJT3UPKHb9f2RJSmqqfGN1/Fqzsi14TLBBR9SOgNlJp9H+TCiiVhUDvP4wfDZ4bivGL4HUatyq6kiPhvuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7ead7796052so111850639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 07:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717684685; x=1718289485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fLoaeyGFI7/ZIxhQjo4nBcAkpSxHGUV3XRWCyjIOHE=;
        b=lns0XgTFq/6lOyxuc34+imbWq2OFp5QEzesSOuAq+67TFkM20ZQY3IJh75btcg/2wG
         AGoEjmmELkBElSrSBqUgeYY6MeU/ZDeleFujxOJKy1erG6WyfDi0Mi3iLmNw2LghiSSE
         PNe6LioD9vmJgZ1Am9IOi592Z5Wq/Y8dIrRDFC35ZNmVMhpPj97UbhQLZEmcSytOJbMs
         Z4MFYSfApvhPmfrwTIbeiq1sWIhi0yRWHsuWNigGwvsCK/oN9Q/DiYaF597OcuSGrZGx
         wHebdBjOgNYTSyW0qcNImwzsrF2Q/NEtvMNqmJ+i4qKfkMM7XFrM1GNe3YYvo8T64GnR
         0m9A==
X-Gm-Message-State: AOJu0YwG+DNq1CSO1vLSY8hjY/9nlMCbme0jOy8Y7W4UzhdvAcoRuWcA
	+W6gRc9/db9FU0YNFU/vmY/f021tSXf5abKMl9NfDV7uBuzJsmaO8gWBUBpBo1YvwfXw9mktE4r
	QaFnYbDwRz3EOjYb8Q16REOKjqt6RPhW4HfxVgz/F1EHxh+rTgluON6U=
X-Google-Smtp-Source: AGHT+IH/RWfhFIJZdUsXH00+g69ohwgqn28xDhnGb04AViS7nzRcIfyUvLo9DBWtpXi2mCfaXfG4DS8XA68IkZY4Ahp1JFg7PZqf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c12:b0:7de:e175:fd2d with SMTP id
 ca18e2360f4ac-7eb3ca8dc06mr25678739f.3.1717684685333; Thu, 06 Jun 2024
 07:38:05 -0700 (PDT)
Date: Thu, 06 Jun 2024 07:38:05 -0700
In-Reply-To: <20240606141413.137516-1-norkam41@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081786e061a39a187@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, norkam41@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel/tracepoint.c:178:36: error: incomplete definition of type 'struct bpf_raw_tp_link'
kernel/tracepoint.c:182:9: error: incomplete definition of type 'struct bpf_raw_tp_link'


Tested on:

commit:         c3f38fa6 Linux 6.10-rc2
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bfdbc2980000


