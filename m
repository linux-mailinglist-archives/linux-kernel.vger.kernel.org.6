Return-Path: <linux-kernel+bounces-186047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E3B8CBF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A203D1C21D08
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D303B823BF;
	Wed, 22 May 2024 10:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="a6b423a2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KXHLpd4X"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD8881207;
	Wed, 22 May 2024 10:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716373324; cv=none; b=kV77MqOu63q0FfP4XNWn91gOx6jWiQpD5sVehPlI1wxVdUbv8A+laUfGM21F7nF0O0XZBHS4fT8us0hHbjLYxUYSeLi/ohjdKg4mUkGhm2gIMI+o04nDXklGjPYywopeHAbUtg2r95JTg6dDs+skuqOXrr34Ou+OxDCcLGD6fcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716373324; c=relaxed/simple;
	bh=TCoePWRYJi4KOAnmSOS55T3ifpIcroxPS64SFMGYJNQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pqZ9f6dJN3LXwsYZiKnq8Ibyex1exqzptgNgoUXoazOHm8iCwvhYxNbgqa3GWJw1ajQJAQ1mgm6wkJLFa/b4+gYb6nH+I5pgqecNlEUwRWdq1n3sfwyAMN98r4Kj1mdEpMlkTMCP8qTte+ltEaZsXfX1Wz+29S/9LqYV09+QL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=a6b423a2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KXHLpd4X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 379275C78A;
	Wed, 22 May 2024 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716373320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUc3HhrMnz+GO71XQ6hpxcI6UtS2QZU5LTVuZlIMPkY=;
	b=a6b423a20hBj3LeuaLGD0FC4piYirzZNzIgDhNRuLroO32IAAougYMUbRvBSX3FKUqon2V
	8YwvhlRQfYdgVbPgOocJHZ4tsWDcBWO98kKy46eeoONkBlDuFp0N1toWhL1/YLrzeR5oWb
	IDruCAatrG/myJinILeQR+OyQoVVLZM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716373319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rUc3HhrMnz+GO71XQ6hpxcI6UtS2QZU5LTVuZlIMPkY=;
	b=KXHLpd4XWZtyCFN82B4oQJrX7kDa9a1Jru5GXNSrKV8sf/ayJzWVwslnPER8dnOfFbW17K
	DxCSfR3wtgV6TE8KNryRGxzKAFgdCL4ruXNwelzE/M2381upmT+giRIRO/c/b4BOnzz+ed
	ExNCgrcBsd4iGlGsuzVYQO50MbC69p4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D10FA13A6B;
	Wed, 22 May 2024 10:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g97ZL0bHTWYFMwAAD6G6ig
	(envelope-from <davide.benini@suse.com>); Wed, 22 May 2024 10:21:58 +0000
Message-ID: <5f3cccea-eff5-40f7-a868-743ca837e84d@suse.com>
Date: Wed, 22 May 2024 12:21:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Davide Benini <davide.benini@suse.com>
Subject: Re: CVE-2024-27429: netrom: Fix a data-race around
 sysctl_netrom_obsolescence_count_initialiser
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>, linux-cve-announce@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>
References: <2024051722-CVE-2024-27429-878c@gregkh>
 <ZkxdqOUek_MHqIMn@tiehlicka> <2024052105-pulsate-reborn-119a@gregkh>
 <ZkzGL_vXciG7ipm5@tiehlicka> <2024052219-storewide-arrogance-8d54@gregkh>
Content-Language: en-US, it
In-Reply-To: <2024052219-storewide-arrogance-8d54@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.29
X-Spam-Flag: NO

On 22/05/24 07:11, Greg Kroah-Hartman wrote:
> On Tue, May 21, 2024 at 06:05:03PM +0200, Michal Hocko wrote:
>> On Tue 21-05-24 16:40:24, Greg KH wrote:
>>> On Tue, May 21, 2024 at 10:39:04AM +0200, Michal Hocko wrote:
>>>> This and couple of others are all having the same pattern. Adding
>>>> READ_ONCE for an integer value with a claim that this might race with
>>>> sysctl updates. While the claim about the race is correct I fail to see
>>>> how this could have any security consequences. Even if a partial write
>>>> was observed which sounds _more_ than theoretical these all are merely
>>>> timeouts and delays.
>>>>
>>>> Is there anything I am missing?
>>>
>>> Nope, you are right, our fault, I'll go revoke this now.
>>
>> please also revoke all others touching the same function.
> 
> I don't see any other CVEs that reference that function, but I do see
> some that reference the same type of issue in the same file:
> 	CVE-2024-27420
> 	CVE-2024-27421
> 	CVE-2024-27430
> are those what you are referring to?  If not, which ones do you think
> also should be revoked?

It seems all the CVEs in the range [CVE-2024-27420, CVE-2024-27430] are of the same kind.
Shouldn't all be revoked?

Thanks
Davide Benini

