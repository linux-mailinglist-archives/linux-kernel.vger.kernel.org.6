Return-Path: <linux-kernel+bounces-219116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B19A90CA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E501BB259D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F81591EC;
	Tue, 18 Jun 2024 11:10:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BC7158D95
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709005; cv=none; b=fFuF+/mtI3eu0/9t8cvJSdHo59tux93ttuydGtYQdzY0Y6BvdcwXSukYshMhSgBAWyYwNwq0gV2QY11uvHl+eXfuJE+8MTJbrhGX+gcMYxbzHeTJnR9unnYeMtSpYDcHouaJg6bYwVjnA8eQwHBOEQrzXrliFLAqQyy2TsI2hT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709005; c=relaxed/simple;
	bh=1/MQk7ZE2XEEToPTXr4LMRtvF2kFvK/pgFk0MjcX1wU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=r6kq9ZZVyx1AvouUa7dfQJ1V5jBEZ5A/UqLq6awVE1rTKEG/iq4Tn2+fIsRDEcQJ6M++kdRKGrEQLaixeFke92HkTf5CUJnHMbbWs5mzVvX2Zgf3GhlUUPdBHCsVH7szGg2jZwPFG2jjHZVoTXpDQ3Cf0huqYdrRYFUp21d6MKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e6e4a83282so697927239f.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709003; x=1719313803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO3dnMMbh2D5dFu4UAkQONcDb9duj6EbqDj+5Vy/uWs=;
        b=iT77tZ3yg8W794+OoL7udSQ2vZIa66bFug/zMJtkVYbCyFGmvJaIaGr7e7MFi6/THX
         +A66zSTmFSPse2v1tP/fZgu8JV9jgdxjlPmwxKzl61XCFyxBwgVe1mQcIVaeq0xzhxzv
         Y0m+54xglVQAOEw1ETjVEJNpqkiV0IGJdYCrFHk8b3lQbt+LpViJHW0THdGLC8Hql0ct
         hF4iS48V0Nzzbnjp+VRRlmrm5X0XlH9RMcF6UXc34Ys+RmazWfepek+2EdDXxsPOMkDF
         VVC8vs6JzDT96t/1/aYbaEhC6mLueHWeLQy7YnRf0ZZrCD/5ewNcCiYzl5WtOeOY58tS
         L1kA==
X-Forwarded-Encrypted: i=1; AJvYcCWOrFrFQa7ldkW06bGH9S4KZVMpkbUtwHZ5ecskFi7CUFz1NQWyc1iCaymuhnpQccbaLkrYx7OxzGpy5hcJagaluKWF/jZIDMGCKgWo
X-Gm-Message-State: AOJu0Yx6OzpT8qmZMoZ0wVPsjPuF6jv1I/6VS4DOG5X6kuvc2USd11bw
	AYlTRUW8tapsKq7wTMbv32nJzKWf8utdP8Gqx/XpsP2AZFq9RezLC+OrF6Y48dWVb/lQhpNpEk4
	uRefiawgsdZLeDpadwOntH+4TQWM0xUW+RYjKP4vAIp8vEQ6z6NiG5LQ=
X-Google-Smtp-Source: AGHT+IELjN/VIF4jggOglv/D4V4K1+RvL8546bdkNx/Sq+K7AkjC586SKthn+zqA5JxX/pVe2Q7VcRujZMPk4oePQtPLu+j+sRWa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164a:b0:7eb:9697:95c3 with SMTP id
 ca18e2360f4ac-7ebeb525dc6mr23300139f.2.1718709003576; Tue, 18 Jun 2024
 04:10:03 -0700 (PDT)
Date: Tue, 18 Jun 2024 04:10:03 -0700
In-Reply-To: <20240618104538.1648-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a17918061b281ffd@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_publish_rx_avail
From: syzbot <syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+49092daf3dd0a57f9e73@syzkaller.appspotmail.com

Tested on:

commit:         2ccbdf43 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15fc34fa980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8786f381e62940f
dashboard link: https://syzkaller.appspot.com/bug?extid=49092daf3dd0a57f9e73
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f4cca6980000

Note: testing is done by a robot and is best-effort only.

