Return-Path: <linux-kernel+bounces-566297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E033BA67602
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA09516A6E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1320E01F;
	Tue, 18 Mar 2025 14:10:37 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3920E006
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307036; cv=none; b=tGs49oSPqln4tqz9WPQxFEQWj/ryWcqyLcI4qAi9O4sEJYVsvHkPKi6v5mARe02Q24RQuxYT3JzrGa8/E4ceRUwt57tkcJaPpkFeWx3ZigLgqe55fuhQ+HwAvi9gsIjMhfNely0fYaL02KabfEjvA6S9l4JmD6H/jjYEf1KJ4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307036; c=relaxed/simple;
	bh=Hh7+4H2OqzHvehRHdsNqC5RBGFRkij8niL4MoJc4CC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U82FDt9PDgtDXiuqk0VcFuGphgskAT6yjYYAvnVxsiqYWGaZ8Md9XHWxfFDjYQpkCfecDr0P82RDsGtUy7+alWWTYFecDI1u9Qy5z9k614suPxkZcfBXzRVsrTrPj3hHrX6WksnBZXHQzOuhNqlimpLfZ3hNYB+ES3nKmuGtYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0B1821940;
	Tue, 18 Mar 2025 14:10:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87E1E1379A;
	Tue, 18 Mar 2025 14:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SzbNH9V+2WcJBgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 14:10:29 +0000
Message-ID: <b89fcad1-ed97-4354-9892-14631794d95d@suse.de>
Date: Tue, 18 Mar 2025 15:10:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org>
 <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de>
 <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B0B1821940
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On 3/18/25 14:38, Daniel Wagner wrote:
> On Tue, Mar 18, 2025 at 12:02:48PM +0100, Hannes Reinecke wrote:
>>> -	list_for_each_entry(tmplport, &fcloop_lports, lport_list) {
>>> -		if (tmplport->localport->node_name == opts->wwnn &&
>>> -		    tmplport->localport->port_name == opts->wwpn)
>>> -			goto out_invalid_opts;
>>> +		INIT_LIST_HEAD(&nport->nport_list);
>>> +		nport->node_name = opts->wwnn;
>>> +		nport->port_name = opts->wwpn;
>>> +		refcount_set(&nport->ref, 1);
>>> -		if (tmplport->localport->node_name == opts->lpwwnn &&
>>> -		    tmplport->localport->port_name == opts->lpwwpn)
>>> -			lport = tmplport;
>>> +		spin_lock_irqsave(&fcloop_lock, flags);
>>> +		list_add_tail(&nport->nport_list, &fcloop_nports);
>>> +		spin_unlock_irqrestore(&fcloop_lock, flags);
>>>    	}
>> Hmm. I don't really like this pattern; there is a race condition
>> between lookup and allocation leading to possibly duplicate entries
>> on the list.
> 
> Yes, that's not a good thing.
> 
>> Lookup and allocation really need to be under the same lock.
> 
> This means the new entry has always to be allocated first and then we
> either free it again or insert into the list, because it's not possible
> to allocate under the spinlock. Not that beautiful but correctness wins.
Allocate first, and then free it if the entry is already present.
Slightly wasteful, but that's what it is.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

