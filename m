Return-Path: <linux-kernel+bounces-256054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4E93484D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD301B21E42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4595F6F06D;
	Thu, 18 Jul 2024 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SiGL8iuo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ckz3Yqnw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HybZ7W97";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yxt7E0Vu"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA14D8BA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721285423; cv=none; b=r+3YeFGQaY5NpAIFJFdAdkhQAPC24to5S3tehCm4b+osZpNdD9jUlUhw5azuGm4Vw+J5pcfHhiB4VT7xdDoUtzQtnpKBTYbM0z3YkoNhIgiDnysplH1h4RfGs9PCN71kIECuwxtjh+iC0J/iZCVNngfqudwJAcd40F6pvoa034g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721285423; c=relaxed/simple;
	bh=J8oxzLcxQny8NCrWkNKMUDy9iOfyUaGV1WTqZI8ek4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEHS5SGzJid2gmw5fMKPhkhz7zbXC4urMCSrzvgsFK7hzAVtSynatRh30mZU4PNbe6NNmEKU68YYrOOcJCKKNsQW3ItKNcxFCNypdmU7HSYpwzhwqHzX4RUCDBoAN6xOGOkAXcAuJ/BVrUDVgkGkalBQnjZ8SHB6WvGBaaz9DQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SiGL8iuo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ckz3Yqnw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HybZ7W97; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yxt7E0Vu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C31A221C30;
	Thu, 18 Jul 2024 06:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721285420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JGoIPWWejj4p4ZXBWFn0hELGOIB7tXKxxmmlvTlGKBY=;
	b=SiGL8iuoHIHyH6yXCyT3zacejn8iQ1z6C8q41Md73jZZaqSsgYvyROUnaOzOHfwLakGiD3
	5vg3oNVpAH7DAvfVBrWOhTU8AzslyeUxm/gJ3QKJRvHIMF98AY1k0WUqLdEE/+v+s+Iq9D
	CpYS5gXbDfMgutofYDyjjHu9J63yjpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721285420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JGoIPWWejj4p4ZXBWFn0hELGOIB7tXKxxmmlvTlGKBY=;
	b=ckz3YqnwtphfgOZE/rOLkdUDDDSlNc/4cDiDoV1Y6/fExoXD+g3JteJcVAG65i9Nxj/R0I
	AAzpY4zC2bPIPrAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721285418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JGoIPWWejj4p4ZXBWFn0hELGOIB7tXKxxmmlvTlGKBY=;
	b=HybZ7W97HA241pZHwa1Odx8aDtUbdewh8X/VL6vn/Rhg/fQJLbgNaJEyVQ8BIGJPVjypT9
	Lhbte52IX5wARWRCXOxa23SFR1b3akLSrw5xGJKxlFoli0UA1UA4BY9HlLOcs4eN48NQFY
	GvQl/2YzpfCM5viLpObPnSlZEbH4By4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721285418;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JGoIPWWejj4p4ZXBWFn0hELGOIB7tXKxxmmlvTlGKBY=;
	b=yxt7E0VuT9HqheHWp+2kNvP1Rn/mfQAXq1lo+37EqHasF7YuUQzMfGD6oMIoi6EVZznjcx
	AH99Xy1Upt9eNdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82DF7136F7;
	Thu, 18 Jul 2024 06:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RnCYHiq7mGaiBQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 18 Jul 2024 06:50:18 +0000
Message-ID: <4bcb752a-1ef8-453f-a04e-05017920a9d8@suse.de>
Date: Thu, 18 Jul 2024 08:50:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Fix black screen after resume
To: Jammy Huang <jammy_huang@aspeedtech.com>, jfalempe@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@redhat.com,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Cary Garrett <cogarre@gmail.com>
References: <20240718030352.654155-1-jammy_huang@aspeedtech.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20240718030352.654155-1-jammy_huang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -0.29
X-Spamd-Result: default: False [-0.29 / 50.00];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[aspeedtech.com,redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,aspeedtech.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

(Cary, this looks like it fixes the problem you reported.)

Hi Jammy

Am 18.07.24 um 05:03 schrieb Jammy Huang:
> Suspend will disable pcie device. Thus, resume should do full hw
> initialization again.
> Add some APIs to ast_drm_thaw() before ast_post_gpu() to fix the issue.
>
> Fixes: 5b71707dd13 ("drm/ast: Enable and unlock device access early during init")
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot for this fix.

Best regards
Thomas

> ---
>   drivers/gpu/drm/ast/ast_drv.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
> index f8c49ba68e78..45a9c7bf49c8 100644
> --- a/drivers/gpu/drm/ast/ast_drv.c
> +++ b/drivers/gpu/drm/ast/ast_drv.c
> @@ -391,6 +391,11 @@ static int ast_drm_freeze(struct drm_device *dev)
>   
>   static int ast_drm_thaw(struct drm_device *dev)
>   {
> +	struct ast_device *ast = to_ast_device(dev);
> +
> +	ast_enable_vga(ioregs);
> +	ast_open_key(ioregs);
> +	ast_enable_mmio(dev, ioregs);
>   	ast_post_gpu(dev);
>   
>   	return drm_mode_config_helper_resume(dev);
>
> base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
> prerequisite-patch-id: a03a33902f33bcc38091e2cdce9d79f630464c30
> prerequisite-patch-id: 505779a1e2094f2ee2f2a55ad44aac5cd1d5342f

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


