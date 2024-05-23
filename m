Return-Path: <linux-kernel+bounces-188001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66838CDBB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 23:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5581C21BB7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 21:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EABA47F5D;
	Thu, 23 May 2024 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KGg3LKFg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZGp8CoY9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CVF5FJhU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SeLkmI5W"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF00127B77
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716498240; cv=none; b=ocwYznxwv62TduAOhLeqBfUDj18Y8mo8XQQLRjWBuNfQK2niED8mIFoXu0dKJk55oMLNnmfJQ5u+5Tbfnb6TPkgQMqfRk7TIojh58tF2ylskK8z7oSxLay9+o+I0ZJ5Qvb7OSpl2qIMA56wLcKoIszC5jhniUDLwg7Mc34Qhk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716498240; c=relaxed/simple;
	bh=azckzezRos8oz3jZHNHyPcrAxf6ls4F3/EmpRQlwN/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i7XC/BXLKYFagVjDV/HSxsDlC1jgW4qoTgyqR94IJ2lcAlbj/U4lun5RFhlmP/KuG+X+cHj5551McwpduhCghgPbGhFY6FEaAagILL2YxJ1Bl4fMFa/8orkW4wX2QFQzyKlDAN3Qr78gOGf/3ZVAcKDGb4hsPgrJUOKfs+I42hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KGg3LKFg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZGp8CoY9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CVF5FJhU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SeLkmI5W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C699D204E2;
	Thu, 23 May 2024 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716498234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6redKfgRnPKw7c3Sh6ig4XHO+OhkoDGLRIwudR8/TD4=;
	b=KGg3LKFgNhIiqs4Kmx+A43aYokmuNTkdfO8I1jvfYKHGVZScE0MGWhynmx21YG1GpFGlso
	1s8H/hNzxJVoXph5gA1HS+MJLRT177OJDrAlDpi/xLJ6QweAP83NwERjVGC9s+mw5uHYGd
	uWqx3YVArPI5k50erVma51BW2nZXVBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716498234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6redKfgRnPKw7c3Sh6ig4XHO+OhkoDGLRIwudR8/TD4=;
	b=ZGp8CoY94UcNe3/dAvYCccrRhXGICJvBLx5hPbzb+G2MKpBArQpCVyPfxkKe2lDaFckFz3
	qveAhVCGHI5CZyDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CVF5FJhU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SeLkmI5W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716498232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6redKfgRnPKw7c3Sh6ig4XHO+OhkoDGLRIwudR8/TD4=;
	b=CVF5FJhUnFqcZFnB4AhicEdHqG8Bj5atb2Y0YnDlVq1LJabh13ms0u/opHi2aBcGteTSbZ
	5+RzsaI+gM66e0Jh/oY0SgoR/VQ6Eu7ALwn4hIEQT3ekptZvCRGowLUuOki75NCzZNUWeI
	vnqtUJt+jUPzoaf7daURYJh8ZCKqa44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716498232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6redKfgRnPKw7c3Sh6ig4XHO+OhkoDGLRIwudR8/TD4=;
	b=SeLkmI5WMQtz3Qf+fwG4e2sstG2qMFsr3CXLxcosXyT/wTjX8kABtD6f4yuLy8+z0nKYcE
	9KKZhATKvAm2wfDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A986013A6B;
	Thu, 23 May 2024 21:03:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id akfdKDivT2YtMgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 May 2024 21:03:52 +0000
Message-ID: <2149ee23-5321-4422-808f-e6a9046662fc@suse.cz>
Date: Thu, 23 May 2024 23:03:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [kernel?] WARNING in flush_cpu_slab
To: Thomas Gleixner <tglx@linutronix.de>,
 syzbot <syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com>,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 linux-kernel@vger.kernel.org, mingo@redhat.com,
 syzkaller-bugs@googlegroups.com, x86@kernel.org, linux-mm@kvack.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo
 <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
References: <0000000000008c9d27061915ca9c@google.com> <87v834g6hn.ffs@tglx>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <87v834g6hn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[linutronix.de,syzkaller.appspotmail.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org,redhat.com,googlegroups.com,kernel.org,kvack.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,storage.googleapis.com:url,appspotmail.com:email,googlegroups.com:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[50e25cfa4f917d41749f];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C699D204E2
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.00

On 5/23/24 12:36 PM, Thomas Gleixner wrote:
> CC+: mm folks
> 
> On Wed, May 22 2024 at 19:27, syzbot wrote:
> 
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17d42b0a980000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
>> dashboard link: https://syzkaller.appspot.com/bug?extid=50e25cfa4f917d41749f
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+50e25cfa4f917d41749f@syzkaller.appspotmail.com
>>
>> ------------[ cut here ]------------
>> DEBUG_LOCKS_WARN_ON(l->owner)
>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_slab mm/slub.c:3088 [inline]
>> WARNING: CPU: 3 PID: 5221 at include/linux/local_lock_internal.h:30 flush_cpu_slab+0x37f/0x410 mm/slub.c:3146

I'm puzzled by this. We use local_lock_irqsave() on !PREEMPT_RT everywhere.
IIUC this warning says we did the irqsave() and then found out somebody else
already set the owner? But that means they also did that irqsave() and set
themselves as l->owner. Does that mey there would be a spurious irq enable
that didn't go through local_unlock_irqrestore()?

Also this particular stack is from the work, which is scheduled by
queue_work_on() in flush_all_cpus_locked(), which also has a
lockdep_assert_cpus_held() so it should fullfill the "the caller must ensure
the cpu doesn't go away" property. But I think even if this ended up on the
wrong cpu (for the full duration or migrated while processing the work item)
somehow, it wouldn't be able to cause such warning, but rather corrupt
something else

Also this code didn't change for a while.

>> Modules linked in:
>> CPU: 3 PID: 5221 Comm: kworker/3:3 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
>> Workqueue: slub_flushwq flush_cpu_slab
>> RIP: 0010:local_lock_acquire include/linux/local_lock_internal.h:30 [inline]
>> RIP: 0010:flush_slab mm/slub.c:3088 [inline]
>> RIP: 0010:flush_cpu_slab+0x37f/0x410 mm/slub.c:3146
>> Code: ff e8 e5 b2 fc 08 e9 25 ff ff ff e8 db b2 fc 08 e9 46 ff ff ff 90 48 c7 c6 7f 68 37 8d 48 c7 c7 b6 33 37 8d e8 72 88 6f ff 90 <0f> 0b 90 90 e9 dd fe ff ff 90 48 c7 c6 88 68 37 8d 48 c7 c7 b6 33
>> RSP: 0018:ffffc90002b57c98 EFLAGS: 00010086
>> RAX: 0000000000000000 RBX: ffffe8ffac1021b0 RCX: ffffffff81510229
>> RDX: ffff88801bb7c880 RSI: ffffffff81510236 RDI: 0000000000000001
>> RBP: ffff88802790b540 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: 000000002d2d2d2d R12: 0000000000000200
>> R13: ffffe8ffac1021d0 R14: 0000000000000000 R15: ffffc90002b57d80
>> FS:  0000000000000000(0000) GS:ffff88802c300000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00000000f73ffec2 CR3: 00000000268ca000 CR4: 0000000000350ef0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>  <TASK>
>>  process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
>>  process_scheduled_works kernel/workqueue.c:3312 [inline]
>>  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
>>  kthread+0x2c1/0x3a0 kernel/kthread.c:389
>>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>  </TASK>
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup


