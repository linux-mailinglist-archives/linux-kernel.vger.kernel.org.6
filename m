Return-Path: <linux-kernel+bounces-367602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD89A0449
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEAC1C21AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3B1F818D;
	Wed, 16 Oct 2024 08:31:53 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A51F80D7;
	Wed, 16 Oct 2024 08:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067513; cv=none; b=K/YHo4v5CkPY6Oi48eJXGNV9D5xaoihwBpOLAbO8f9nsOnWw4GYa2EmfkVoVtYeBkfxssK0IKTKB9hTfk1AdpSofCEe8AruD7AnibBTQexOywu5d+QC3qVBUXkWUanirO9lN+53eh1fQWju9p6sfssZN7j19yvEkyGQKw7dOTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067513; c=relaxed/simple;
	bh=gH36MejQIuCpvU9xjWwmyZj0bQEl+DEW+9pMFF/kM2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gssWnQvgvzRjMgLfNfxGnK68TMeRbED5mzZjTc7bIe/e4JUlW6L4ADimuTlX4bLH0Ags6MY4AE95sW6InX4PFg5SRaUaLskIK/v0PUB2jOK61sz3sK6ira40c4RKDItAa0knlQlZTbDcSH1cm8AhHmwBXXkPluppTYLJwIpDIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 49G8UdxY028008;
	Wed, 16 Oct 2024 17:30:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 49G8Ud72028002
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 16 Oct 2024 17:30:39 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a0f21b01-3937-41e5-846d-340df0239e87@I-love.SAKURA.ne.jp>
Date: Wed, 16 Oct 2024 17:30:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [input?] [usb?] [mm?] INFO: rcu detected stall in
 vma_link_file
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: syzbot <syzbot+ce483fd06e2061f44f5d@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, liam.howlett@oracle.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>
References: <ji3zt22xdnr2wieepeudioxg6uqthwxtbut6w2ec55lmnnzghv@c4jwoow5u2gg>
 <670ed017.050a0220.d9b66.0156.GAE@google.com>
 <bacc4301-be1a-4f3f-9da3-1543cbf9874c@lucifer.local>
 <2024101602-skintight-crawfish-ebab@gregkh>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <2024101602-skintight-crawfish-ebab@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean

On 2024/10/16 16:14, Greg Kroah-Hartman wrote:
> On Wed, Oct 16, 2024 at 08:06:20AM +0100, Lorenzo Stoakes wrote:
>> + some people from USB/HID subsystem.
>>
>> This is really not looking mm-related, as for a second time we've asked
>> syzbot to re-run and for a second time it's not hit any mm-specific code -
>> I think this is misattributed - could somebody from the USB/HID side take a
>> look?
>>
>> It looks to be something that isn't reproduced by a specific C program but
>> by a syzkaller USB configuration [0]?
> 
> There's a lot of odd usb syzbot issues right now dealing with the dummy
> hcd controller, so maybe this is another one of them...

This is a printk() flooding stall triggered by SysRq-t.

 sched_show_task+0x3f0/0x5f0 kernel/sched/core.c:7557
 show_state_filter+0xee/0x320 kernel/sched/core.c:7627
 k_spec drivers/tty/vt/keyboard.c:667 [inline]
 k_spec+0xed/0x150 drivers/tty/vt/keyboard.c:656
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0xcbd/0x17a0 drivers/tty/vt/keyboard.c:1541


