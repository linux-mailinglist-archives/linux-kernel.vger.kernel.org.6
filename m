Return-Path: <linux-kernel+bounces-535726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18F7A47673
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D871117012E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A1E220687;
	Thu, 27 Feb 2025 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y6+h/DGh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="36uObA9P";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ucnq0XgC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="04slfiWb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534B13777E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740641179; cv=none; b=MbXI91espuTWFy7mIU3FfQDVUce3/gL4XLqeWjYZaLFlSZwXAT9HeXChr1Re01Qd0Bi9VFZCQWs20f0wn7TFjRdr8LvRPwpf9db2WdQuPiv+R4K3YbTcahFOzxuj6dSrLkD5ts/XYY1k5RpM40nWi2eScg45wKGoN443cod94pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740641179; c=relaxed/simple;
	bh=QskU6KlR6VjyyuJ9smKwh5zsw5KTfvOUMtT+LJzdhUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QhoygIQUib1j3NZnd9aggWvt8G81D3ut+j5ziayXte7QJI2LdPWY+N9Mi58Gwo5eiy7c0qadOi2VHIunaVNDtBRbvW2Wi8IlYWVTJXUWtgKk3ioaY1fRDnCvwbPv+wT0BtnoYw6PPgpLCuzeCW0wBgh3o8LIFiq+on7AmxawNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y6+h/DGh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=36uObA9P; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ucnq0XgC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=04slfiWb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BE281F38A;
	Thu, 27 Feb 2025 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740641167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=Y6+h/DGhKq4QBaucrHPSs3iv19vkbXuL1aqCsCHJHecjOCmE6RHybHzS7Ji2ce/1vJY2Z4
	zMe+rOXj8V/HsybIoVZPnH7y6ibGTgGIxKOIY3yKgoPG6jye70OzxSXl/wYrxabqWRl7j4
	jRdsNqZYA+gxV2vK2mo0RLQQk/lz/jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740641167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=36uObA9PWDU+akuVqhzAc85eyqB5sYvm4FrIHYkXsTQz8Z75tvvmpO4EN+qZsDIV+fvTTY
	Cb9OEQjI/nMl5+Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740641166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=Ucnq0XgCQbSlnzK6jDqk0I5C0L7G71Gi9yh2f8k9S4zNqlDvtI4vzC5WZc5s/HDx+9eno4
	7nFfHbYDkPYKcM197oUEO2eseW9173/vzjOOcpXDoBCFffyaK6SlYotnDSihL+Rohn1L6r
	yMJrEeFlz9jdrKAGL+0wLT6hCCyRsiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740641166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LURQLperLP55U0sbtjSQUw4tyMa6MQux+BoFVADvCww=;
	b=04slfiWbJx5RmzDoR3i9HqueZGJXj5bwAMvHR8v0kuWsr8R6D4xv2OqX1oqUgut/DaJOwN
	pSJlBZTv72eWULDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C09913888;
	Thu, 27 Feb 2025 07:26:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UX7bDI4TwGcOagAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 27 Feb 2025 07:26:06 +0000
Message-ID: <7ccc3a88-b92c-45b8-bbfd-af98ab439be7@suse.de>
Date: Thu, 27 Feb 2025 08:26:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
 <03dad20d-1293-47d1-a55d-8430fcefc0bb@suse.de>
 <20250226190122.GA3949421@google.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250226190122.GA3949421@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.987];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/26/25 20:01, Eric Biggers wrote:
> On Wed, Feb 26, 2025 at 10:37:55AM +0100, Hannes Reinecke wrote:
>> ... and it also eliminates a sporadic crash which we've seen
>> where 'snd_hash' wasn't initialized when sending PDUs.
>> Thanks for doing this!
> 
> I'm not sure how that could have happened, since the ahash was allocated when
> 'if (queue->hdr_digest || queue->data_digest)' which seemed to match the
> conditions for when it was used.  But yeah, it's certainly nice to not have the
> pointless allocation to worry about.
> 
>> (Note to self: check the nvme-tls code for crc32c usage ...)
> 
> I have patches for nvme-tls almost ready too.  Just been taking my time since
> I've been updating all other users of "crc32" and "crc32c" in the kernel too.
> And I need to decide what to do about skb_copy_and_hash_datagram_iter().
> 
If it were me I would _love_ to switch the nvme-tcp recv patch over to 
recvmsg and kill the ->read_sock() implementation.
->read_sock uses a completely different codepath in tls_sw, and nvme is
the only user of that. So there's a fair chance that we might miss any
improvements or fixes.

Plus we currently have no good way of handling TLS records from 
->read_sock(), which is something we might want to do in the future.

So if we had an equivalent for skb_copy_and_hash_iter() for recvmsg()
I could revisit my original patchset and work on getting ->read_sock()
replaced.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

