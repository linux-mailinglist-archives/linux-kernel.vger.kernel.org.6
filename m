Return-Path: <linux-kernel+bounces-178665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078778C561B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14609282827
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 12:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250AB6BFB1;
	Tue, 14 May 2024 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfdFJswx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jYOYD9Hc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OfdFJswx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jYOYD9Hc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01242A98
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690630; cv=none; b=InaBLe6MC8/eWG1WeMuM7sW8CtmP19VwHLHTdJ+20R75KAA+s1qjs2pR1gQw6BrXK7c+ubbg90U95QYsm6RfZE+Jh5gm3P7Y259vmRz8Fbkso04KNCOitodNKBmZonX8yx7tEn1kdnyX+gqLxte7YXir0DfD6qPjPaCq2B34m8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690630; c=relaxed/simple;
	bh=fybAa2AhazjNF6OntAwxCwydTpK6qmpPtRSw57Lp0Xs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfjgEzJOebS5n0lr/+JDzVEAoPkFEZJVb7ybYOkMBac1a6Y7YvjDD0QxR7LuF8CpwStWsX+Gekr9aNIMHIPVR8HvHbBl9t7E8hBjYYiKslNqi3fQT4IAIvD7eLpcjdDBHG6YAmTfaQoo0YMHFEVOXM+kvcQyM1VQAStyJH/eYXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfdFJswx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jYOYD9Hc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OfdFJswx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jYOYD9Hc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C3F53E9B4;
	Tue, 14 May 2024 12:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715690620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b6+tNv49nCn2ieSVSaIM5fRcj0h4rC0itWZkCMQCCrg=;
	b=OfdFJswxiTBoiznw6QMWMjDcL/nhcYc9+MfvzqZVpLIZQVamC9mPVi2112OzDDB0ULEF74
	eveBt1u30DF4RxnCL+meNgByyodBg7ROkyQGl0d+3N0p4yZ2xYgRWP6V/AUNcMKqvaoizj
	i4+ZuLHn/yoigoEVe5cXWVJ42Rho/bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715690620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b6+tNv49nCn2ieSVSaIM5fRcj0h4rC0itWZkCMQCCrg=;
	b=jYOYD9Hc6gt0PFWQBWu/snQ6WKHPQHOEIi48m1M7hmhVERDEd9R7gtkyKZj3LyZ7euWZVD
	PLyUgCTdauLSGwBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715690620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b6+tNv49nCn2ieSVSaIM5fRcj0h4rC0itWZkCMQCCrg=;
	b=OfdFJswxiTBoiznw6QMWMjDcL/nhcYc9+MfvzqZVpLIZQVamC9mPVi2112OzDDB0ULEF74
	eveBt1u30DF4RxnCL+meNgByyodBg7ROkyQGl0d+3N0p4yZ2xYgRWP6V/AUNcMKqvaoizj
	i4+ZuLHn/yoigoEVe5cXWVJ42Rho/bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715690620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=b6+tNv49nCn2ieSVSaIM5fRcj0h4rC0itWZkCMQCCrg=;
	b=jYOYD9Hc6gt0PFWQBWu/snQ6WKHPQHOEIi48m1M7hmhVERDEd9R7gtkyKZj3LyZ7euWZVD
	PLyUgCTdauLSGwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AFE41372E;
	Tue, 14 May 2024 12:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A8z4FHxcQ2b4HAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 14 May 2024 12:43:40 +0000
Message-ID: <e2346a0d-6360-46cb-8707-281de8f4d874@suse.de>
Date: Tue, 14 May 2024 14:43:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drm: Remove driver dependencies on FB_DEVICE
To: Manas Ghandat <ghandatmanas@gmail.com>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <e5c0a250-8c91-4523-b980-5b0e13749616@gmail.com>
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
In-Reply-To: <e5c0a250-8c91-4523-b980-5b0e13749616@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,kernel.org,ffwll.ch];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -4.29
X-Spam-Flag: NO

Hi

Am 14.05.24 um 14:34 schrieb Manas Ghandat:
> Hi. I recently looked at the todos of drm and found the topic 
> interesting. I wanted to get started with this issue but having some 
> trouble identifying the devices. What would be the right approach to 
> get started?

Sorry, there's already someone working on that topic.

Best regards
Thomas

>
> Thanks,
>
> Manas
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


