Return-Path: <linux-kernel+bounces-334749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F35B797DBA9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 06:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49913B219F4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 04:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0617C61;
	Sat, 21 Sep 2024 04:32:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F59517555
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726893124; cv=none; b=en+qDKQ9oo4DpHbpO7p+drFutqOe+gcaX0i5+jVI/31310RjK6QW+Wv73+7DAg153pXqc2YIr/UZ/28eZ5uI3oB9SJJzo9ilFdeZLfU22EGbtCvwQBxmlFEj0TaMtcrg3JJq4e8d+yOujR3VPsA68oLLN0k6P6P0QcTyUVUwTyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726893124; c=relaxed/simple;
	bh=dEJRLbwriepgA8+heAwnMgcv4g/JJ4a4/mj1GxmJHRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IjRxSXbamrTi1FR6rfx0uk/AmgEwGOfeI6HQW+7m6/xQVBt3+2F8Au2svv9be4Fxhr3NWu4LWAuky+9DOA0yVftZdTXF+YWebqXqcLRUF7RlVf5UZqANhuJK8KrRfr880ZjfUbKbyDEK7l4VMYMfE2VjytyaoJ7rbMg8gVAVyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a0a08aa0f1so32480965ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 21:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726893122; x=1727497922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuNcgYuN5DBSEVplwSPWmZCV6DyfXmkHpp3huHRYLW8=;
        b=s6GiMfS4qNxZeuCzoFLSR2ugfXoQBEOKi6j4A0bN2bxp5qoGI9tFeQyvom7SSvqNM1
         1q23M7NME9uN4ghuf2DoHRDzNe2f35VXNujUOWr8/ytRJsrQAewg+Pbb+wlu3qcVmjIr
         nBEhNjFP8chnloAJSCExgRuZhezHMNvN7UNPyQpRHQ3pkj0krM0E19JQw6ZSJgamoi6M
         KfcRt2rsHFGgVOTpOS1Z0b9FbHV7tYAtdv/rHUIzFf8rJrtEenjQuTZNy6GWUS759TI7
         AwihSAQpGBFTfDDiyU/wtlJG556WlN7qII9ZCOhWfBOWFhohufpp9RkjFXjVZrWuX3mF
         ue2g==
X-Forwarded-Encrypted: i=1; AJvYcCVmgyNOtPOTjd5pELXHbfMNUnAmEJU4B115MrseQtzMP2eInDZVNnClidAgSTHAUhyuU9F6WFQexhzXcUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHScMOVJeWOdNahA3XjQgDFU0zvS/qE4Q1NwJBMQnE3iJjzRe
	d2+zdZCwIEspystIi2FhyeGTxROxyQISxr5X0s4s1ktE/amskSKRddzCQgGCPD2nXWab39EJLHF
	gfYrufR0tOMGaZVzPIJV3LvIhpgtmRDZyJsn8AKndMNombBAtQ5f8q6Y=
X-Google-Smtp-Source: AGHT+IEulUQBpl4tL0SqCT1/1/6jseazyTqTRbHZh6NpB8nmbgYhVnxlc8yT+zTDXNyXaNSC+Dg4EMhbqT3YK41tClxIk4Rkja50
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a85:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a0c8c6b184mr57606895ab.3.1726893122095; Fri, 20 Sep 2024
 21:32:02 -0700 (PDT)
Date: Fri, 20 Sep 2024 21:32:02 -0700
In-Reply-To: <tencent_E64425D6BAF8BBC833499EEE1BDC4BD41B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee4c42.050a0220.3195df.002d.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in from_kuid (2)
From: syzbot <syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com>
To: eadavis@qq.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com
Tested-by: syzbot+6c55f725d1bdc8c52058@syzkaller.appspotmail.com

Tested on:

commit:         1868f9d0 Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1152ee9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=acaa65be5f19fc5a
dashboard link: https://syzkaller.appspot.com/bug?extid=6c55f725d1bdc8c52058
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=136b7607980000

Note: testing is done by a robot and is best-effort only.

