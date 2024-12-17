Return-Path: <linux-kernel+bounces-448978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 097369F47E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A73E188F0CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB41DDA33;
	Tue, 17 Dec 2024 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GYdwFu/v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cxWWLnaI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xXYGIO+c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4ZR1zEDf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5BE8493
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734428751; cv=none; b=Wil+vu74gqG8CsHYj2s0/ESFWnDFDKKdgQKOju7EbzmUgL5wLD6Op28oYZPGtQLQr6JixCZ+Nk1EBGr+Eu6hMFs2DQLptGFwjxUeQgzu+NCID83x2207arOoItVljMnJadnnJtp4uPR9fUR5Kj+I58vNxdENIjcqIrkhNv6RteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734428751; c=relaxed/simple;
	bh=z+pnC/G859cKybbtc2ZmcNxLk5OjSEDzTUIXTtqeUBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6xxCi0k8tT7QXZjf7Ff8h36mA11kG62KNNZNfYHwizQLW5rx6Nc+AyYgNMYfkR2657yR+PtOWCLGmAg3wOKUETuyKaPf0qZr7BCSvBOTHckTnATUNGZ1p9xM6IqCRtTTAk8OSaxzXR5n4UK1taasbu53EV3yl2C8jg6Vcs3RNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GYdwFu/v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cxWWLnaI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xXYGIO+c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4ZR1zEDf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3C4021119;
	Tue, 17 Dec 2024 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734428747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=GYdwFu/vRbqfJstJpYntcMeS3LvCafiv9n8KzT7zqQWjLdwJVWVSTdS86GTiqjPgDf9hOy
	C3m1LomlgQgUfx8DL2DrGSQbfwXRgAfwKDJUAXkQeGkF+z3FckRQR5xN9zPxewUYaZlJEO
	blq+Wo8a/a197HXGVKZXCMCCEAE8tXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734428747;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=cxWWLnaIVUM3niRFPJbE9eSQklRf2MGmb/apv8apkslXLTfLPemWA3fJaVQjaxntKvyvXH
	GIlGqPZO/QFM7wAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xXYGIO+c;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4ZR1zEDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1734428746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=xXYGIO+cL16axWwGtXLDXhdRRj3jp9wem/c1E/kqXwr7VsS2rltRKTq16cb2qYwONWoJrf
	lKxot/IUOxG2YlwcNIJEskSkkMXdyDwdjPD+nBQ0xTaWK1EG3hbL7QYpoVgsi2C0oD/5wp
	MOFbT0wivKI5hYISbUW9qkdypA2olOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1734428746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FJGw7z6aUL2viCAu7yz4er/Htu6dAjQkM9uWFeT73uQ=;
	b=4ZR1zEDfWuASP31naDlhQMiFocGJoULmGWSAKs56kONqhydXIsDfnPbmCyufM6H4WVrUJr
	MHYuUQ+sk+Y+s5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CC1713A3C;
	Tue, 17 Dec 2024 09:45:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vdAZFEpIYWc9NQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 17 Dec 2024 09:45:46 +0000
Message-ID: <b8dad319-8e6e-40e7-ada3-f50863315614@suse.de>
Date: Tue, 17 Dec 2024 10:45:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme: handle connectivity loss in
 nvme_set_queue_count
To: Daniel Wagner <dwagner@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Paul Ely <paul.ely@broadcom.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241129-nvme-fc-handle-com-lost-v3-0-d8967b3cae54@kernel.org>
 <20241129-nvme-fc-handle-com-lost-v3-3-d8967b3cae54@kernel.org>
 <e89d0b3b-e4a1-4ae5-8250-c15e3a843e76@suse.de>
 <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <bef1a7ac-2614-4a70-945d-e691e9107089@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B3C4021119
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 12/17/24 09:35, Daniel Wagner wrote:
> On Fri, Nov 29, 2024 at 12:10:33PM +0100, Hannes Reinecke wrote:
>>> +	/*
>>> +	 * It's either a kernel error or the host observed a connection
>>> +	 * lost. In either case it's not possible communicate with the
>>> +	 * controller and thus enter the error code path.
>>> +	 */
>>> +	if (status < 0 || status == NVME_SC_HOST_PATH_ERROR)
>>>    		return status;
>>>    	/*
>>>
>> Hmm. Maybe checking for NVME_SC_DNR, too?
> 
> if no one complains I'll update the check to:
> 
> 	if (status < 0 || (status > 0 && (status & NVME_STATUS_DNR)) ||
> 	    status == NVME_SC_HOST_PATH_ERROR)
> 		return status;
> 
> okay?

Which really cries out for a helper. But otherwise okay.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

