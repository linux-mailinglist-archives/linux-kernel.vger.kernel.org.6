Return-Path: <linux-kernel+bounces-360835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F3A99A05D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79ECA28305C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A9220C496;
	Fri, 11 Oct 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sOQlE3CM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NsyPkt5X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzjC3EbI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1PdmC6hk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404E01A3BAD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728640285; cv=none; b=r3g54t7gR1ceI+y1MSAne6c7lwAKckLW/159PzQD3A9gSoHBO/6yCwbwKhFU+SZwsjP5XQIOvAbvVEK035T5PFxqmlUBjEjAeYn+1vHPoVY7YgjVIW74M1JYRzM06MdCYxXqMcze68c9FN8Uf34i5FvQGmwbMlnJk5Y6Bod1brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728640285; c=relaxed/simple;
	bh=oo4X6H7JOcIQcAqJjmZbbDb+jEBNYczZVPQOZgpOMLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BP7Y1GItoLzidKgk1a9fOjYp/62OQrHtozWC0dFHLttUiJVcnpSU8+qCr655/GhDXyRmfo5Qdxo15EKZhRQwlWQrT+A8dkldm8gee96mBmSB9fx80BsgMYZqHnYVkIsW0FMVFWK5LvzOAtgvqGodqzmEIWTotW74Y8Zj5dzeAHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sOQlE3CM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NsyPkt5X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzjC3EbI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1PdmC6hk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF9921DB3;
	Fri, 11 Oct 2024 09:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728640281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3NVgG2SICKyUPtdW/rnnVkSJXEFp2qEVc5fEtUfRD8=;
	b=sOQlE3CMDRWErDnd7E8Qg6rpvUY2f7Le4XkhLZ9HbsNc+h10tdqS71TXRMeRWjgorfHhZ8
	Orf2ecdn6auJNGjfjBwtnV3AjjmnqFuOqO2RoIF9FM29HMOIkdhgtyOcOcJQ74+wYEKHsN
	qnZOkgBv2e9Yplul3LdS37yxc768pjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728640281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3NVgG2SICKyUPtdW/rnnVkSJXEFp2qEVc5fEtUfRD8=;
	b=NsyPkt5XGLfgzs1EOEYM0djdD/hCFzh3upWU2FZ0u0WucO/oLaUVPc3FIMqVnup7gAFJXK
	FFiJ2Jk/ISkszSDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pzjC3EbI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1PdmC6hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728640280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3NVgG2SICKyUPtdW/rnnVkSJXEFp2qEVc5fEtUfRD8=;
	b=pzjC3EbIn/6JVPttg43x+luFh4H+cf5/8XGTkZlPZpykoVAHu5oSFYRITIaV8GFM3tciMc
	Ey9sHrJzTLmbBGcRVzcCTThU42wu2koCZ3eyTsnyHmoZ19CVSL049GiCruR/hAePgJ9bHk
	m1d5PvEX928GoTXN57lumBeE8bcgUGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728640280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M3NVgG2SICKyUPtdW/rnnVkSJXEFp2qEVc5fEtUfRD8=;
	b=1PdmC6hkWbfvVgsDr8kaKkDPlm9l+pgrbj45BYHXnG7zmyFPXPYzuRF2uQFqxR0rZCYIm/
	y2AIBUwQSVga2aBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F88C1370C;
	Fri, 11 Oct 2024 09:51:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3go4Bxj1CGdxNgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Oct 2024 09:51:20 +0000
Message-ID: <c8dffa25-4fb4-486a-9587-1c7359457abc@suse.cz>
Date: Fri, 11 Oct 2024 11:54:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mm?] INFO: task hung in hugetlb_fault
To: syzbot <syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
 glider@google.com, kasan-dev@googlegroups.com, keescook@chromium.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mcgrof@kernel.org,
 mhiramat@kernel.org, mhocko@suse.com, mike.kravetz@oracle.com,
 muchun.song@linux.dev, syzkaller-bugs@googlegroups.com,
 torvalds@linux-foundation.org
References: <67084cfa.050a0220.3e960.0005.GAE@google.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <67084cfa.050a0220.3e960.0005.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4AF9921DB3
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[7bb5e48f6ead66c72906];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/10/24 11:54 PM, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 3db978d480e2843979a2b56f2f7da726f2b295b2
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Mon Jun 8 04:40:24 2020 +0000
> 
>     kernel/sysctl: support setting sysctl parameters from kernel command line

Hi, I see you have a number of sysctl options in CONFIG_CMDLINE
including  sysctl.vm.nr_hugepages=4 which seems necessary to get a
hugetlb_fault. And without the commit above, those sysctl boot options
are not applied. So you'd have to handle sysctl differently to test any
commits earlier than that one.

Thanks,
Vlastimil

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1499efd0580000
> start commit:   87d6aab2389e Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1699efd0580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1299efd0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fb6ea01107fa96bd
> dashboard link: https://syzkaller.appspot.com/bug?extid=7bb5e48f6ead66c72906
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dd6327980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d24f9f980000
> 
> Reported-by: syzbot+7bb5e48f6ead66c72906@syzkaller.appspotmail.com
> Fixes: 3db978d480e2 ("kernel/sysctl: support setting sysctl parameters from kernel command line")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

