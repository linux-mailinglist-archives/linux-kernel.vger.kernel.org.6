Return-Path: <linux-kernel+bounces-560063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD9A5FD27
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C28C67A1862
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21A7269D17;
	Thu, 13 Mar 2025 17:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUKlJdm3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="beLv1MYd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OUKlJdm3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="beLv1MYd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CB63B9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885940; cv=none; b=lSfBETXOSTLpG+GohY6dhdnVdXEJ6mFh1wefBoDpKeLKW2LYPgNkEatpmSVoqNFWj579aEqCUBpCvK5awzdND5PW0cu71oaV2mNW7hFNwg7hpHs1KRSvqrMiliEuIjtjvEe0nSyPfEJUW4aDBCGfgF+/DKkF2tprDjWRcEGd6/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885940; c=relaxed/simple;
	bh=dAUUa1OubLTz1bv/k0IIf4cOnDgx406ok2+wXz2Tctw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S35uhZQ7N9Mqu/xNHX45VhH6raEHmy+88xG7YsvggTPMtyikZtfo/dOZ+JaG1ttSRa4fxwnTVQ9bH2sRkJHwiOxs/ypZoVRdWigF/WoBGizwgi+4ArCv8iBkNMrQu4HDNnCjhla6mG+uDaweL5tTkQ9tGXBKmOvm8XL3Fgd1TRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OUKlJdm3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=beLv1MYd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OUKlJdm3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=beLv1MYd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 019081F457;
	Thu, 13 Mar 2025 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741885936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4ICCjQ2QaChT0WMUS7l+2tIWo1GGw2+dqcK619hsvk=;
	b=OUKlJdm3ZHBUuBP3+WwT6Drxeyk8a07l6E2YRbveigwJcewnRYMT92sUwJZSXSXPDXXjCJ
	myrj+9zrcubOiX5yGx4WbJLjCo4ap33kZiynfGKJ+xGlIlf28IjbFIgaeiwPnHmUqkk5md
	XnOwvx63eJdNm8rmAdswDQkODeWeqGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741885936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4ICCjQ2QaChT0WMUS7l+2tIWo1GGw2+dqcK619hsvk=;
	b=beLv1MYdJzVP9GgHEFoSaent1f2y3D2KvlsxRuOuS2Q7rxB3F5Qy2TkarcWR44d2+MfXVq
	cZcDAbzHz1OKenBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OUKlJdm3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=beLv1MYd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741885936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4ICCjQ2QaChT0WMUS7l+2tIWo1GGw2+dqcK619hsvk=;
	b=OUKlJdm3ZHBUuBP3+WwT6Drxeyk8a07l6E2YRbveigwJcewnRYMT92sUwJZSXSXPDXXjCJ
	myrj+9zrcubOiX5yGx4WbJLjCo4ap33kZiynfGKJ+xGlIlf28IjbFIgaeiwPnHmUqkk5md
	XnOwvx63eJdNm8rmAdswDQkODeWeqGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741885936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4ICCjQ2QaChT0WMUS7l+2tIWo1GGw2+dqcK619hsvk=;
	b=beLv1MYdJzVP9GgHEFoSaent1f2y3D2KvlsxRuOuS2Q7rxB3F5Qy2TkarcWR44d2+MfXVq
	cZcDAbzHz1OKenBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECFB913797;
	Thu, 13 Mar 2025 17:12:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W0zTOe8R02ePOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Mar 2025 17:12:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7096A0908; Thu, 13 Mar 2025 18:12:11 +0100 (CET)
Date: Thu, 13 Mar 2025 18:12:11 +0100
From: Jan Kara <jack@suse.cz>
To: ye.xingchen@zte.com.cn
Cc: brauner@kernel.org, jeff.johnson@oss.qualcomm.com, jack@suse.cz, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nls: Fix utf8s_to_utf16s parameter =?utf-8?Q?type_?=
 =?utf-8?Q?in_declaration_and=C2=A0definition?=
Message-ID: <f6a3zjnituwlspbsjhiy47anx2yf24fpzofhm2nablqsk4rj6l@qfsq7pyyakba>
References: <20250313163601139fRqick9X3NNePcVQzW3na@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313163601139fRqick9X3NNePcVQzW3na@zte.com.cn>
X-Rspamd-Queue-Id: 019081F457
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 13-03-25 16:36:01, ye.xingchen@zte.com.cn wrote:
> From: YeXingchen <ye.xingchen@zte.com.cn>
> 
> The declaration of utf8s_to_utf16s in the header file uses
> bool maxlen as the parameter type, while the definition uses bool maxout.
> 
> This patch aligns the parameter name in the definition with the
> declaration,changing inlen to len,maxout to maxlen to ensure consistency.
> 
> Signed-off-by: YeXingchen <ye.xingchen@zte.com.cn>

Thanks for the patches but you should rather be modifying prototypes in
include/linux/nls.h to match the real declaration. If you actually check
the history, you'll notice commit 045ddc8991698 modified the implementation
but forgot to update the prototypes in include/linux/nls.h. And the names
in the implementation are indeed more descriptive.

								Honza


> ---
> v1->v2
> fix the parameter
>  fs/nls/nls_base.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/nls/nls_base.c b/fs/nls/nls_base.c
> index 18d597e49a19..fcce6ff1380a 100644
> --- a/fs/nls/nls_base.c
> +++ b/fs/nls/nls_base.c
> @@ -129,24 +129,24 @@ static inline void put_utf16(wchar_t *s, unsigned c, enum utf16_endian endian)
>  	}
>  }
> 
> -int utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
> -		wchar_t *pwcs, int maxout)
> +int utf8s_to_utf16s(const u8 *s, int len, enum utf16_endian endian,
> +		wchar_t *pwcs, int maxlen)
>  {
>  	u16 *op;
>  	int size;
>  	unicode_t u;
> 
>  	op = pwcs;
> -	while (inlen > 0 && maxout > 0 && *s) {
> +	while (len > 0 && maxlen > 0 && *s) {
>  		if (*s & 0x80) {
> -			size = utf8_to_utf32(s, inlen, &u);
> +			size = utf8_to_utf32(s, len, &u);
>  			if (size < 0)
>  				return -EINVAL;
>  			s += size;
> -			inlen -= size;
> +			len -= size;
> 
>  			if (u >= PLANE_SIZE) {
> -				if (maxout < 2)
> +				if (maxlen < 2)
>  					break;
>  				u -= PLANE_SIZE;
>  				put_utf16(op++, SURROGATE_PAIR |
> @@ -156,15 +156,15 @@ int utf8s_to_utf16s(const u8 *s, int inlen, enum utf16_endian endian,
>  						SURROGATE_LOW |
>  						(u & SURROGATE_BITS),
>  						endian);
> -				maxout -= 2;
> +				maxlen -= 2;
>  			} else {
>  				put_utf16(op++, u, endian);
> -				maxout--;
> +				maxlen--;
>  			}
>  		} else {
>  			put_utf16(op++, *s++, endian);
> -			inlen--;
> -			maxout--;
> +			len--;
> +			maxlen--;
>  		}
>  	}
>  	return op - pwcs;
> -- 
> 2.25.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

