Return-Path: <linux-kernel+bounces-350394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EF299048E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E7A1C21082
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B8521018D;
	Fri,  4 Oct 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z7jzMBjj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4G8v1mwe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xzOqGMhE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EIDMnngs"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012915747D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049042; cv=none; b=fEWh6bYXZ1ZI0KfU+czmq3LpDiHmGjXzed/W/gYEvWU6CzNPfVly8zXLI3RrQV1gS1G87eHwxSMciDMo2ziOuZvlO2AHDfxqfTMIh6RTtWNmFyYwpQrW9IKqxCEpb4hH2xMICaubaNv/bO82nrKjOV+ROCE3ubITJElEjPKF4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049042; c=relaxed/simple;
	bh=C6SKWU5gzyUEhzF0dJ3GwEWubW4EM4M7ie7S8SwJBRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvJqjUAZJydHOy8bBS4xOi3u+Qjq+LSaAfYkxvcOxLskqOC+w/xgPC0rgy7zAqZ7syqYccO14Oj96lLJRCxnpoZz9iBVQZwszdJge74ETv7nSN6kc3VCj/kbjy+xKq7ruIOJE7F4MLVZmfaIjwjZqOxaj1CsJXdqDu8VrnQAGj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z7jzMBjj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4G8v1mwe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xzOqGMhE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EIDMnngs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A9EB21CFA;
	Fri,  4 Oct 2024 13:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728049038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcRVJuVlfANx6SJZjEhdsTDI1vWWADF5UW+8hbd7eBc=;
	b=Z7jzMBjj+P7z41YLCwRqwMPeCqxx8iz6yG7+NzUDgaWDeXuYlcYeG+mkSB/hWX3zl/7CO0
	LpQR/Gqhdwy0GDDghsU/ZnzvTRBxnFIqLR6z/Z4h/pcJMiZgUzPHGSENNhZA1NxOj4Qeq/
	Yw+m+lhyrwUdF3Hyypav3+TzXdQuAlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728049038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcRVJuVlfANx6SJZjEhdsTDI1vWWADF5UW+8hbd7eBc=;
	b=4G8v1mweg6B1M5naeijUxIzRFYPI+Vm6+2vi8DVS1HSw9TnEtrSksix3YYlLB99s1S/ogD
	AppbCpU8qDzg7jDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728049037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcRVJuVlfANx6SJZjEhdsTDI1vWWADF5UW+8hbd7eBc=;
	b=xzOqGMhEgEfVIYAI5sjqiiC2rVv5yHR2TYbUel8PIkjWtiIrrnx/78rC0h1Y3CTrWf793W
	P1gJKMSbvXGC+XvKhFRDvyd+dUSRoxwLqs/c1vTX9L7fk27dEM2/7O+MZaGVTf8FRwIogR
	aC9oD8Lq7qbIIIUtKEMN9YI9GOPMsbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728049037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZcRVJuVlfANx6SJZjEhdsTDI1vWWADF5UW+8hbd7eBc=;
	b=EIDMnngscA7j0Ku8kjsCKhYtZ+pwGIJjHsE2NYGjsD+5qIeIcTLUBPSzCTD9hmZapx6lCT
	MSYirES0Ul3hjqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D21413A6E;
	Fri,  4 Oct 2024 13:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bwWMDo3v/2YsWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 13:37:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4389A0877; Fri,  4 Oct 2024 15:37:16 +0200 (CEST)
Date: Fri, 4 Oct 2024 15:37:16 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acl: Realign struct posix_acl to reduce its size by 8
 bytes
Message-ID: <20241004133716.enkqnmosn42oagos@quack3>
References: <20241004103401.38579-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004103401.38579-2-thorsten.blum@linux.dev>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 04-10-24 12:33:57, Thorsten Blum wrote:
> Reduce posix_acl's struct size by 8 bytes by realigning its members.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/posix_acl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 83b2c5fba1d9..e2d47eb1a7f3 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -28,8 +28,8 @@ struct posix_acl_entry {
>  
>  struct posix_acl {
>  	refcount_t		a_refcount;
> -	struct rcu_head		a_rcu;
>  	unsigned int		a_count;
> +	struct rcu_head		a_rcu;
>  	struct posix_acl_entry	a_entries[] __counted_by(a_count);
>  };
>  
> -- 
> 2.46.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

