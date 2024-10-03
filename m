Return-Path: <linux-kernel+bounces-349173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6132798F218
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5AB1F220B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F751A0708;
	Thu,  3 Oct 2024 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RvkhoumK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4qS8sEJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RvkhoumK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4qS8sEJ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACDB1A00CB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727967960; cv=none; b=XfIgbKNFgsGtgRJeGQuaaKPc/oGEkDJ+8e1QoymaZCJo62+WUrl1RWHCFZdUyvJNHlo0OnMY/RFthGckfQpClDGzmvqhqm5Z+Udf+e3rFGCkTO+6M0qcsNL+umPMqTM6u8Z+aGEJqQa+3gfK0qot6L5pV8/mGfxSHcLbfslJpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727967960; c=relaxed/simple;
	bh=kUo1PvQStY/oO/bLcb2nOWtk1Wn0PhCnbB+s/6e0Wsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CGlrgEbjbcxPqwdur+l46KHJiKDm/ylGEdVpw2SMuqCobiutCBrEUYYFGSv+VlK694NSwrg1mOtfWRctxOqmyDlscN+Uk7CE/XzQSzl+jMwuk5UUtYva3E2XCrjH3M+2oz1yI4PR0g4XBm6RUr0q2+8xswV5NnetNLCtPOMyPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RvkhoumK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4qS8sEJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RvkhoumK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4qS8sEJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1DAF1FDFB;
	Thu,  3 Oct 2024 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727967956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeWRFgru9DivNlXfB9ZI8MQYM76wmNOHFzUCPG8dxOY=;
	b=RvkhoumK4z9XOB2d5wiTB6Yf+r3ph75/5MU09W8i02gBrfKlPntvJeDHBx8IwpOSuePZZu
	aVjJszNWfCFcbkslFjmcdFsfN1CH768CGDlfDob1bPMsWWT0p5v9A59y+vvOwLPBlWLrj2
	00DDH0mxG3I6hLqB8M7pWuHFUINAatU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727967956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeWRFgru9DivNlXfB9ZI8MQYM76wmNOHFzUCPG8dxOY=;
	b=m4qS8sEJhtEpE9HmTP8w95cEWNfseGB8jQbKyaXVZ3yC9tDVG0iDBuxFwUhICTAByFU+39
	kWZ+TAd8apB9H0Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RvkhoumK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m4qS8sEJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727967956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeWRFgru9DivNlXfB9ZI8MQYM76wmNOHFzUCPG8dxOY=;
	b=RvkhoumK4z9XOB2d5wiTB6Yf+r3ph75/5MU09W8i02gBrfKlPntvJeDHBx8IwpOSuePZZu
	aVjJszNWfCFcbkslFjmcdFsfN1CH768CGDlfDob1bPMsWWT0p5v9A59y+vvOwLPBlWLrj2
	00DDH0mxG3I6hLqB8M7pWuHFUINAatU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727967956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WeWRFgru9DivNlXfB9ZI8MQYM76wmNOHFzUCPG8dxOY=;
	b=m4qS8sEJhtEpE9HmTP8w95cEWNfseGB8jQbKyaXVZ3yC9tDVG0iDBuxFwUhICTAByFU+39
	kWZ+TAd8apB9H0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 901CC139CE;
	Thu,  3 Oct 2024 15:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EGRsItSy/mb9WQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 03 Oct 2024 15:05:56 +0000
Message-ID: <5aeca051-594c-44a9-be27-129ea2d53677@suse.cz>
Date: Thu, 3 Oct 2024 17:05:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] 6.10.10: Bad page state in process xyz
Content-Language: en-US
To: thomas <thomas@m3y3r.de>, akpm@linux-foundation.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <ypeffrq2306w.fsf@maria>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <ypeffrq2306w.fsf@maria>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1DAF1FDFB
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 9/14/24 14:10, thomas wrote:
> Hi,
> 
> in 6.10.10 kernel on x86 I see those BUGs:
> 
> [   19.131851] BUG: Bad page state in process update-exim4.co  pfn:06dd0
> [   19.136660] page: refcount:0 mapcount:-1 mapping:00000000 index:0x0 pfn:0x6dd0
> [   19.136672] flags: 0x40000014(referenced|dirty|zone=1)
> [   19.136686] raw: 40000014 00000000 00000122 00000000 00000000 00000000 fffffffe 00000000
> [   19.136691] raw: 00000000 00000000
> [   19.136694] page dumped because: nonzero mapcount
> [   19.136697] Modules linked in: btusb btrtl btintel btbcm btmtk bluetooth ecdh_generic ecc hid_appleir input_leds af_packet mousedev hid_apple hid_generic usbmouse usbkbd usbhid appletouch joydev sr_mod cfg80211 cdrom rfkill snd_hda_codec_idt snd_hda_codec_generic radeon snd_hda_intel drm_suballoc_helper i2c_algo_bit snd_intel_dspcfg drm_ttm_helper ttm snd_hda_codec snd_hwdep snd_hda_core drm_display_helper snd_pcm i2c_i801 applesmc acpi_cpufreq i2c_smbus ata_piix rng_core drm_kms_helper ehci_pci snd_timer snd soundcore sky2 uhci_hcd ehci_hcd rtc_cmos apple_bl video wmi mac_hid sg binfmt_script binfmt_misc fuse drm dm_mod configfs efivarfs ip_tables ipv6 autofs4
> [   19.136862] CPU: 1 PID: 1747 Comm: update-exim4.co Tainted: G        W          6.10.10+ #1

IIRC W means there was a warning before the BUG. Got any?

Is 6.11 also affected? I'd suggest bisection if possible.

Thanks
Vlastimil

> [   19.136870] Hardware name: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
> [   19.136875] Call Trace:
> [   19.136880]  ? dump_stack_lvl+0x51/0x60
> [   19.136896]  ? dump_stack+0xa/0xc
> [   19.136904]  ? bad_page+0x5f/0xf0
> [   19.136915]  ? free_unref_folios+0x24b/0x5a0
> [   19.136926]  ? folios_put_refs+0x108/0x14c
> [   19.136936]  ? free_pages_and_swap_cache+0x130/0x138
> [   19.136953]  ? tlb_batch_pages_flush+0xb6/0xf0
> [   19.136960]  ? unmap_page_range+0xaec/0x1214
> [   19.136973]  ? do_wp_page+0x6d5/0xf38
> [   19.136983]  ? unmap_vmas+0x74/0xf0
> [   19.136993]  ? exit_mmap+0x94/0x1f8
> [   19.137004]  ? __mmput+0x31/0xec
> [   19.137012]  ? do_exit+0x2a8/0x900
> [   19.137022]  ? do_group_exit+0x21/0x68
> [   19.137031]  ? __ia32_sys_exit_group+0xd/0x10
> [   19.137040]  ? ia32_sys_call+0x211a/0x222c
> [   19.137047]  ? __do_fast_syscall_32+0x50/0xd0
> [   19.137057]  ? do_fast_syscall_32+0x26/0x58
> [   19.137065]  ? entry_SYSENTER_32+0x98/0xf8
> [   19.137077] Disabling lock debugging due to kernel taint
> [   19.137315] BUG: Bad rss-counter state mm:696603f8 type:MM_FILEPAGES val:-1
> 
> In my previous kernel I didn't see such BUGs, besides thisWARNING:
> 
> Sep 12 10:31:54 maria kernel: ------------[ cut here ]------------
> Sep 12 10:31:54 maria kernel: DEBUG_LOCKS_WARN_ON(val > preempt_count())
> Sep 12 10:31:54 maria kernel: WARNING: CPU: 0 PID: 2894 at preempt_count_sub+0x56/0x90
> Sep 12 10:31:54 maria kernel: Modules linked in: crypto_simd cryptd xts dm_crypt rfcomm bnep btusb btrtl btintel btbcm btmtk bluetooth ecdh_generic ecc hid_appleir input_leds hid_apple mousedev hid_generic usbkbd usbmouse af_packet appletouch usbhid cfg80211 rfkill joydev sr_mod cdrom snd_hda_codec_idt snd_hda_codec_generic ledtrig_audio radeon snd_hda_intel drm_suballoc_helper snd_intel_dspcfg i2c_algo_bit snd_hda_codec drm_ttm_helper snd_hwdep snd_hda_core ttm i2c_i801 applesmc snd_pcm drm_display_helper snd_timer acpi_cpufreq i2c_smbus ata_piix drm_kms_helper rng_core sky2 snd ehci_pci rtc_cmos soundcore apple_bl uhci_hcd video ehci_hcd wmi mac_hid sg binfmt_script binfmt_misc fuse drm dm_mod configfs efivarfs ip_tables ipv6 autofs4
> Sep 12 10:31:54 maria kernel: CPU: 0 PID: 2894 Comm: kworker/0:0 Tainted: G        W          6.7.12+ #2
> Sep 12 10:31:54 maria kernel: Hardware name: Apple Computer, Inc. MacBookPro1,1/Mac-F425BEC8, BIOS    MBP11.88Z.0055.B08.0610121325 10/12/06
> Sep 12 10:31:54 maria kernel: Workqueue: events ata_scsi_dev_rescan
> Sep 12 10:31:54 maria kernel: EIP: preempt_count_sub+0x56/0x90
> Sep 12 10:31:54 maria kernel: Code: 9b c3 8d b6 00 00 00 00 e8 4b 12 34 00 85 c0 74 f0 8b 0d 40 e3 3f 9b 85 c9 75 e6 68 7b cb 22 9b 68 cd e7 21 9b e8 6a 9c fd ff <0f> 0b 58 5a c3 8d b4 26 00 00 00 00 66 90 84 d2 75 bc e8 17 12 34
> Sep 12 10:31:54 maria kernel: EAX: 0000002a EBX: 81d9da40 ECX: 00000002 EDX: 80000002
> Sep 12 10:31:54 maria kernel: ESI: 81d9eddc EDI: 81d9ee1c EBP: 00400000 ESP: a4043f08
> Sep 12 10:31:54 maria kernel: DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010286
> Sep 12 10:31:54 maria kernel: CR0: 80050033 CR2: 77e42868 CR3: 1b4ce000 CR4: 000006f0
> Sep 12 10:31:54 maria kernel: Call Trace:
> Sep 12 10:31:54 maria kernel:  ? show_regs+0x54/0x58
> Sep 12 10:31:54 maria kernel:  ? __warn+0x6b/0xd4
> Sep 12 10:31:54 maria kernel:  ? preempt_count_sub+0x56/0x90
> Sep 12 10:31:54 maria kernel:  ? report_bug+0x103/0x158
> Sep 12 10:31:54 maria kernel:  ? exc_overflow+0x30/0x30
> Sep 12 10:31:54 maria kernel:  ? handle_bug+0x20/0x48
> Sep 12 10:31:54 maria kernel:  ? exc_invalid_op+0x18/0x54
> Sep 12 10:31:54 maria kernel:  ? handle_exception+0xf9/0xf9
> Sep 12 10:31:54 maria kernel:  ? exc_overflow+0x30/0x30
> Sep 12 10:31:54 maria kernel:  ? preempt_count_sub+0x56/0x90
> Sep 12 10:31:54 maria kernel:  ? exc_overflow+0x30/0x30
> Sep 12 10:31:54 maria kernel:  ? preempt_count_sub+0x56/0x90
> Sep 12 10:31:54 maria kernel:  ? _raw_spin_unlock_irqrestore+0x13/0x30
> Sep 12 10:31:54 maria kernel:  ? ata_scsi_dev_rescan+0x13f/0x16c
> Sep 12 10:31:54 maria kernel:  ? process_one_work+0xf6/0x204
> Sep 12 10:31:54 maria kernel:  ? worker_thread+0x2b8/0x3ac
> Sep 12 10:31:54 maria kernel:  ? preempt_count_add+0x59/0x88
> Sep 12 10:31:54 maria kernel:  ? _raw_spin_lock_irqsave+0x11/0x38
> Sep 12 10:31:54 maria kernel:  ? kthread+0xd8/0x100
> Sep 12 10:31:54 maria kernel:  ? mod_delayed_work_on+0x74/0x74
> Sep 12 10:31:54 maria kernel:  ? kthread_complete_and_exit+0x14/0x14
> Sep 12 10:31:54 maria kernel:  ? ret_from_fork+0x27/0x38
> Sep 12 10:31:54 maria kernel:  ? kthread_complete_and_exit+0x14/0x14
> Sep 12 10:31:54 maria kernel:  ? ret_from_fork_asm+0xf/0x14
> Sep 12 10:31:54 maria kernel:  ? entry_INT80_32+0xf0/0xf0
> Sep 12 10:31:54 maria kernel: ---[ end trace 0000000000000000 ]---
> 
> Any help appreciated!
> 
> mfg
> thomas
> 


