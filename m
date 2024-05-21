Return-Path: <linux-kernel+bounces-185087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BF8CB056
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C782814B6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F196912FF83;
	Tue, 21 May 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="g7tdXcB3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="M6Gna1Ii";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZahKT0ke";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+J9kbIcF"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0012FB35
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716301437; cv=none; b=cnDGlDTPFnmiZHfcL+d9EGAitqu9C0J7o9jVLivBPZ2s6vwnyTsLQP40khYtACzTOQs/1y7DcDv3lEa2q3lQZQryY4VrfzQ/TvCnGcXfW2jTQFk85EV6k/y+3Ud2Qndx9gPkUdGsMKci97kpQX8y0vFQ34nkjNfjFHLWB1I3XK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716301437; c=relaxed/simple;
	bh=rIDd75rbjRTrPL9hfPJp0QMBEv5zevUBhRcTS5dTPfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WBz+QPGMbjc+3demr6cs9+gvHl2+h38+Jw8YmALF9FmbtbgB8ncu7I808nxxGCPQYhc6S/sCAI+XwR55oU5YqHncIfWtLrz6v0JzxhR7/SYHBeFXYDFQ41eDTCKjiLco40QN5578aJvxIvS2M+SECCSuEwmpBem1GDbRyo5H+Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=g7tdXcB3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=M6Gna1Ii; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZahKT0ke; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+J9kbIcF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5DE621F30;
	Tue, 21 May 2024 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716301434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=g7tdXcB39KNS8WdFtJn52wuwAySC0q6KRg0Z/PrhvOFdsTTabEjtNeuvHi3WLJ94McQDuV
	/UGwLpGe0nENe50QVY4thYdEvHmZuyCS1C8DZMzz0TXsAEvPi04Xle3hrQ/1/clW093duo
	kHToGsjGAcd8aN2HROlgt87Em9yFCvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716301434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=M6Gna1IilS619jmNwu2oEwx2c6QG72sMUpeUhiG106lcQpEzkNHRpjXYesAmw/LNeVbBYN
	nPliXiL5N88kGSCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716301433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=ZahKT0keeWaUlD2YKQ9twPNc1vfZMhj5MMJXOL9esWEP9lA+M6N34/QkDDCjW93O6S89aV
	KZbm/fyiZE1FCPC2HgQwpx0EpjA+BlXNMjz3v93pPNt7uwyiR9AbUKQlVxeh7WaOTtJTQL
	yXsjsul3ZWyYAB31Xo1HyQ7qSZyU8CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716301433;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hwcDxOQ6pMSkl1QmM4849RB+YcZAC4TGgNQOUHZaoVk=;
	b=+J9kbIcF/fkeBDN03mRV9flYCB/1MNDJbNB9J3HgTS7ZBHjAvaLnXnbuleeoPUv9ja0ywr
	9KkDUCiol5/UnfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2C2B13A1E;
	Tue, 21 May 2024 14:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dP/lKnmuTGYdQAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 14:23:53 +0000
Message-ID: <872f0ebd-124e-4a39-987c-ef9c273f1957@suse.de>
Date: Tue, 21 May 2024 16:23:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
 <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On 5/21/24 15:58, John Meneghini wrote:
> On 5/21/24 02:46, Hannes Reinecke wrote:
>> On 5/20/24 22:20, John Meneghini wrote:
>>> From: "Ewan D. Milne" <emilne@redhat.com>
>>>
> ...
>>> Tested-by: Marco Patalano <mpatalan@redhat.com>
>>> Reviewed-by: Randy Jennings <randyj@redhat.com>
> 
> I need to fix this. Randy doesn't have a redhat.com email address... Cut 
> an paste error :-(
> 
>>> Tested-by: Jyoti Rani <jani@purestorage.com>
>>>
> ...
>>> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int 
>>> iopolicy)
>>> +{
>>> +    struct nvme_ctrl *ctrl;
>>> +    int old_iopolicy = READ_ONCE(subsys->iopolicy);
>>> +
>>> +    WRITE_ONCE(subsys->iopolicy, iopolicy);
>>> +
>>> +    mutex_lock(&nvme_subsystems_lock);
>>> +    list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
>>> +        atomic_set(&ctrl->nr_active, 0);
>>> +        nvme_mpath_clear_ctrl_paths(ctrl);
>>
>> You always reset the variables here, even if specified iopolicy is
>> the same than the currently active one.
>> I'd rather check if the iopolicy is different before changing the 
>> settings.
> 
> Yes, Keith pointed this out too.  This is actually a feature not a bug.  
> In situations were we want to "reset" the nr_active counters on all 
> controllers the user can simply set the queue-depth iopolicy a second 
> time.  I don't expect users to do this very often... they shouldn't be 
> changing IO policies back and forth too much... but the ability to 
> "reset" the nr_active counters during testing has been very helpful and 
> important to do.  So I'd like to keep this.  Moreover, this is NOT the 
> performance path. I don't see the point in making performance 
> optimizations in a code path that is run once a year.
> 
Please add a comment indicating that.
Just to make it clear that it's by design.

Cheers,

Hannes

