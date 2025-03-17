Return-Path: <linux-kernel+bounces-563389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA99A640B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E4B916ECEA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 06:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B811A5B96;
	Mon, 17 Mar 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iBoXy8mi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9MfqntZC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zSY13DXj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6790SDI4"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451A215047
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 06:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742191654; cv=none; b=biyu9TfdXuub2miZo4Puz9jfd5zAOkmFY+BQhS3lSLgu/m878Tk06dLieRdZucrGTyhjhK3YjxbZPYBOoJqbJI6cVAV4NMnnzqndOj8UmFtQXrFFzA+KzHZH7xXWLAfYhSXYXppH42RFHEXnvBw35jI1z/qm3nSdMoXvXE/VAew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742191654; c=relaxed/simple;
	bh=daVVe5UGzgFBruplBO4cn/xy2p3iQqmI9LPwqcoluBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TUQ7zURDpU/zfqHfLHaLQCqNNuyHsd1z7cofVdBQXQie7YCH57QrkRjD26Yw70ZhhnzBfsz8N8gr7DZfCH+NxAxHNQoKdcvIyNqDswjfqHwnKQO3L3opvXLcjYC9BTVfq7ysMY2vAWga7hI3LuzmWmSONRbCIvJtfg41Qv/Ew5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iBoXy8mi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9MfqntZC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zSY13DXj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6790SDI4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F1681F457;
	Mon, 17 Mar 2025 06:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742191644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cBi9VG3CIF3cKELEl6KYqqnhXp/wuWdWjVCgDPDGFAc=;
	b=iBoXy8mihjBb8vdQ+p+bl79RlYlbzJyex5MhHkx+FVRYH/dtVV5JOMfzvJwPyYNTteV4ie
	3e6i8cVEOhKdCsyy55EJaFmFjxSJPeFxs+sjt2NzGx4rut0vPCWA78PTkbLPkIfhYKthwl
	lDhtH3H+bF9e9eRrWXJqrcHR6EUkS3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742191644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cBi9VG3CIF3cKELEl6KYqqnhXp/wuWdWjVCgDPDGFAc=;
	b=9MfqntZCgtkMYMIz8St6lnwX5SlhsfouV30aV9VA5Z1hs4a1WPdyxmQP7nYzlM0HaFbSVD
	fKm2iS6jYLNwylCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zSY13DXj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6790SDI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742191643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cBi9VG3CIF3cKELEl6KYqqnhXp/wuWdWjVCgDPDGFAc=;
	b=zSY13DXjJBO2XE1/izcQ4kPyCjWpVzDSJ+nYAN7JS1eABE5b7q8f4I9sKxXH/ccSdefgDo
	/uRH9idlEnQ6PXV1tFhFby2ga5N6tnRBtWTeV+FBTQNOK//xRyyKce/YCZlmxVMye5tRT5
	YJCITNPM/dpapiLvOCGkB7HSoCdPkNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742191643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cBi9VG3CIF3cKELEl6KYqqnhXp/wuWdWjVCgDPDGFAc=;
	b=6790SDI4/Aj8WF0vtAQdleQQ7u1F4m/zSeMwbyHem9KlVGYb8vWwnkA3D3/AVchD+hMW2x
	2fAmRycOcw5qCLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B736132CF;
	Mon, 17 Mar 2025 06:07:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /MWvHBu812fFUgAAD6G6ig
	(envelope-from <jslaby@suse.cz>); Mon, 17 Mar 2025 06:07:23 +0000
Message-ID: <e177acba-24d3-4202-a0a8-92bfbfdf87e7@suse.cz>
Date: Mon, 17 Mar 2025 07:07:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] genirq: use sysfs_emit() instead of
 scnprintf().
To: xie.ludan@zte.com.cn, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org
References: <20250315141721157LhKSIQccKZ3ZgAzuvbQo1@zte.com.cn>
Content-Language: en-US
From: Jiri Slaby <jslaby@suse.cz>
Autocrypt: addr=jslaby@suse.cz; keydata=
 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
In-Reply-To: <20250315141721157LhKSIQccKZ3ZgAzuvbQo1@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F1681F457
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hi,

your e-mail is both multipart and base64 encoded :(. Pls fix up your 
setup first.

On 15. 03. 25, 7:17, xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> 
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> 
> the value to be returned to user space.
> 
> 
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
> 
> ---
> 
>   kernel/irq/irqdesc.c | 12 ++++++------
> 
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> 
> index 287830739783..8ffe12fe5af6 100644
> 
> --- a/kernel/irq/irqdesc.c
> 
> +++ b/kernel/irq/irqdesc.c
> 
> @@ -257,11 +257,11 @@ static ssize_t per_cpu_count_show(struct kobject 
> *kobj,
> 
> for_each_possible_cpu(cpu) {
> 
> unsigned int c = irq_desc_kstat_cpu(desc, cpu);
> 
> -ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%u", p, c);
> 
> +ret += sysfs_emit(buf + ret, "%s%u", p, c);

Well, so the PAGE_SIZE boundary is never checked for this stacking write 
now, right?

thanks,
-- 
js
suse labs

