Return-Path: <linux-kernel+bounces-386869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAA49B48D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43024281BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA76A205AA4;
	Tue, 29 Oct 2024 12:01:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65F2010E0
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203267; cv=none; b=BTgwMjvB9Aj5FA50WidmLXcxoevG0P5Vkh5pjn9RM3hQk+JbOKHaFSauppEMy7L9GaEOG0qQc0ua/9/qawhUEkUIxOCtUflDC/ngCgkfWx6ynyNVbxb3AmAhxBdutCcoVMTI7slJ0O3Gn5Mpaye/2UkA0d60HJLLXNj3xGWl5PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203267; c=relaxed/simple;
	bh=Awp8WP8YK8//JD8KIqDDEcMc/QLUqHZ79NHNdLQv3cc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OkM7j1AogI4GIF2cAGolovtyEx+zWTKlgW0YbPeVqdrZPZO810ocTjfCo5VWB8zE051VXvCF8DgBErFFyXg2bJ0ZKn1IAgBpmBLZBR40p5L5vtR6lTPTlHYl6HlMubausP7crw34G4XZJjcCXbaHMIuu1e98W7E4KZ5TBzfck8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83aa904b231so506318939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203263; x=1730808063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXeGWYQhIn2DlGpfWwfazH0xzMvBnWNWzL+SQslnEZc=;
        b=g555C9y7dO9+Rh+3nUCb0gTVfv/YkEIiwI8fw2OAvnT3MHav/smeTBp9+07wBEHC6B
         qJ2ChSYA0deTidDfv8hIHkDXzoOHy+YW7WwHV0hUas5xcQF+At7kOojWPEZBC7h0g7Co
         npT4OmGOdooyW+9mdkt7DUXclmBH9nVvX+7f+lKfZDMaXX6dR0oS+qcjwJrwB+A2Jtqq
         cuMM2qfRG8q7eJ4Qz7qyytxqW/m+33tdzMhcbO0C2oLR/sHv9g7DD4WArNOHiOltppnn
         XZa1doGm5iuJBD0NbRfJRC5WLqB2ZFHGofoxz0qgo8csTQO1v4+5lw0w5bFVqeCRNLdE
         6gHw==
X-Forwarded-Encrypted: i=1; AJvYcCXKKgtr72aHAKewVfSlLZhoAA3X3FwNOWZSeBAopHhuiojVcfYp2KmGm061wJoRxNwu2WYUNjg33YIFweo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXbp3ndGuNWXfw0BLjIUcvpR8Apsus1Y7Q84fBOFYc5bgAgQm
	4E9LwrndaxuL7KbGY4eh7L0PFKyKG872dv9+i0L8wce7TY80rVTgC6y5GvVx+QQhLWLRvKjPXLP
	kSovbzc2UHfAEwjzA48h7tSc7tpdGAJbIcL6dqtV2CMZmMYP2dCZF1rM=
X-Google-Smtp-Source: AGHT+IGPQY8kxUqMvSJ3/4geValkMBfATzBcJltBfmgLz8uEKx9YG3cfjGTozwP6HOueuimewK28tH3YfqIi3HZtqLl1TbDLELqK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ac:b0:3a1:a293:4349 with SMTP id
 e9e14a558f8ab-3a4ed2fbabemr102499015ab.18.1730203262942; Tue, 29 Oct 2024
 05:01:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 05:01:02 -0700
In-Reply-To: <20241029112046.2492-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720ce7e.050a0220.4735a.025b.GAE@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release (2)
From: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com
Tested-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com

Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12784540580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4340261e4e9f37fc
dashboard link: https://syzkaller.appspot.com/bug?extid=dee8aa54cb2f5a150f9e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14904540580000

Note: testing is done by a robot and is best-effort only.

