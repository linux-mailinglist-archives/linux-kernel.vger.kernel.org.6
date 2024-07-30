Return-Path: <linux-kernel+bounces-266851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10A940886
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF631C228C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E31D18F2C1;
	Tue, 30 Jul 2024 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aLszJTgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0o5QEgM0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aLszJTgf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0o5QEgM0"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F382563
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722321735; cv=none; b=h9juXQoZHuboHYYFOHKzOwr3hEyf7MBOw+4PVKEBlU96vcMyaf7s7YQeaySKJB9QEG3KoqGK1J/MrWRpHSb/DjkKSjNtH4SUwsD2steddMJyf2PD8N7nz/XOAWTkCug+x6EtpxiDHDysRfSQv1tKBKCar4fKf74nWs65ct3/2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722321735; c=relaxed/simple;
	bh=gppfQQ2otra6A/yJM1ZHsHdvtFrWi5kI6ZtNy2n2v3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PwgKl2Udw6i70HGVr5DVXq9J6YYptYxo/f/y6rVeMQvSgDj7xLM8hSdsQCdhYcfD59Cic5ccvHKfhR5IuYcFBYmR4QxEyD1BYDdxTc4tXEDVZYgNThqbsR2pefpqLvw3CB8T1AxRefS9lF+ZHWfHHakWIzHxvE1G47KFs7IBPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aLszJTgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0o5QEgM0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aLszJTgf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0o5QEgM0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 907CC1F7D1;
	Tue, 30 Jul 2024 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722321730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=42KMu/9JJlpdMs3Dz+NBG8HtOK+dLk10eQ6cd5m8NDQ=;
	b=aLszJTgfjQA96mIWBoTHE1bDRrHTNrSHcSzasMXe6h5xmqWxOdHEdacYJd/XytyUsbXOL0
	j2yLE1DBOtw++7vaf9satDDFX+Y+PEsZsEq/GTTaGXMmDhoIW005wWP+tNjbGb+6R7F74y
	N/nQQn5JZt3pgONvh9OisXTbK9GDM3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722321730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=42KMu/9JJlpdMs3Dz+NBG8HtOK+dLk10eQ6cd5m8NDQ=;
	b=0o5QEgM0xpQLZPiplSMly/EKoub9XiCHe85cyGxWH9p7/F/m58kscljczVrYEzxNX4694a
	1IENvP8vcY280bBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aLszJTgf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0o5QEgM0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722321730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=42KMu/9JJlpdMs3Dz+NBG8HtOK+dLk10eQ6cd5m8NDQ=;
	b=aLszJTgfjQA96mIWBoTHE1bDRrHTNrSHcSzasMXe6h5xmqWxOdHEdacYJd/XytyUsbXOL0
	j2yLE1DBOtw++7vaf9satDDFX+Y+PEsZsEq/GTTaGXMmDhoIW005wWP+tNjbGb+6R7F74y
	N/nQQn5JZt3pgONvh9OisXTbK9GDM3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722321730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=42KMu/9JJlpdMs3Dz+NBG8HtOK+dLk10eQ6cd5m8NDQ=;
	b=0o5QEgM0xpQLZPiplSMly/EKoub9XiCHe85cyGxWH9p7/F/m58kscljczVrYEzxNX4694a
	1IENvP8vcY280bBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BB6413297;
	Tue, 30 Jul 2024 06:42:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DN8gEUKLqGaoYgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 30 Jul 2024 06:42:10 +0000
Message-ID: <14fa96ad-4abd-4754-a622-d9f04429d759@suse.de>
Date: Tue, 30 Jul 2024 08:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: add multiple connectors support
To: oushixiong <oushixiong@kylinos.cn>, oushixiong1025@163.com,
 Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240711090102.352213-1-oushixiong1025@163.com>
 <edb91a7b-e28d-4145-8143-b1be2a9d7d55@suse.de>
 <e7115a83-844a-d1c6-0fe5-2d80eb6a55e2@kylinos.cn>
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
In-Reply-To: <e7115a83-844a-d1c6-0fe5-2d80eb6a55e2@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kylinos.cn,163.com,redhat.com];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -6.30
X-Rspamd-Queue-Id: 907CC1F7D1

Hi

Am 30.07.24 um 03:25 schrieb oushixiong:
> Yes, I have  tested these patches, and these patches fix the problem.

Thanks a lot. Patch 2 is the one that fixes the issue. I'll add your 
Tested-by tag to it.

Best regards
Thomas

>
> Best regards
> Shixiong
>
> 在 2024/7/29 20:34, Thomas Zimmermann 写道:
>> Hi
>>
>> Am 11.07.24 um 11:01 schrieb oushixiong1025@163.com:
>>> From: Shixiong Ou <oushixiong@kylinos.cn>
>>>
>>> [WHY]
>>> The AST2600 tx_chip_types will be detected as AST_TX_DP, but some BMC
>>> boards that use AST2600 use the VGA interface instead of the DP 
>>> interface.
>>> In this case, it will use Virtual connector as the DP is disconnected.
>>>
>>> [HOW]
>>> Allows multiple physical connectors to exist at the same time.
>>
>> And another question: does the patch series at
>>
>>   https://patchwork.freedesktop.org/series/136198/
>>
>> fix the problem?
>>
>> Best regards
>> Thomas
>>
>>>
>>> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
>>> ---
>>>   drivers/gpu/drm/ast/ast_drv.h  |  6 ++++-
>>>   drivers/gpu/drm/ast/ast_main.c |  8 +++----
>>>   drivers/gpu/drm/ast/ast_mode.c | 40 
>>> ++++++++++++++++++++--------------
>>>   3 files changed, 33 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ast/ast_drv.h 
>>> b/drivers/gpu/drm/ast/ast_drv.h
>>> index ba3d86973995..e326124b3fec 100644
>>> --- a/drivers/gpu/drm/ast/ast_drv.h
>>> +++ b/drivers/gpu/drm/ast/ast_drv.h
>>> @@ -150,9 +150,13 @@ static inline struct ast_plane 
>>> *to_ast_plane(struct drm_plane *plane)
>>>    * BMC
>>>    */
>>>   +#define MAX_CONNECTORS 2
>>> +
>>>   struct ast_bmc_connector {
>>>       struct drm_connector base;
>>> -    struct drm_connector *physical_connector;
>>> +
>>> +    struct drm_connector *physical_connectors[MAX_CONNECTORS];
>>> +    int count;
>>>   };
>>>     static inline struct ast_bmc_connector *
>>> diff --git a/drivers/gpu/drm/ast/ast_main.c 
>>> b/drivers/gpu/drm/ast/ast_main.c
>>> index 0637abb70361..428529749ae6 100644
>>> --- a/drivers/gpu/drm/ast/ast_main.c
>>> +++ b/drivers/gpu/drm/ast/ast_main.c
>>> @@ -85,7 +85,7 @@ static void ast_detect_tx_chip(struct ast_device 
>>> *ast, bool need_post)
>>>       if (!need_post) {
>>>           jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 
>>> 0xff);
>>>           if (jreg & 0x80)
>>> -            ast->tx_chip_types = AST_TX_SIL164_BIT;
>>> +            ast->tx_chip_types |= AST_TX_SIL164_BIT;
>>>       }
>>>         if (IS_AST_GEN4(ast) || IS_AST_GEN5(ast) || IS_AST_GEN6(ast)) {
>>> @@ -97,7 +97,7 @@ static void ast_detect_tx_chip(struct ast_device 
>>> *ast, bool need_post)
>>>           jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd1, 
>>> 0xff);
>>>           switch (jreg) {
>>>           case 0x04:
>>> -            ast->tx_chip_types = AST_TX_SIL164_BIT;
>>> +            ast->tx_chip_types |= AST_TX_SIL164_BIT;
>>>               break;
>>>           case 0x08:
>>>               ast->dp501_fw_addr = drmm_kzalloc(dev, 32*1024, 
>>> GFP_KERNEL);
>>> @@ -110,12 +110,12 @@ static void ast_detect_tx_chip(struct 
>>> ast_device *ast, bool need_post)
>>>               }
>>>               fallthrough;
>>>           case 0x0c:
>>> -            ast->tx_chip_types = AST_TX_DP501_BIT;
>>> +            ast->tx_chip_types |= AST_TX_DP501_BIT;
>>>           }
>>>       } else if (IS_AST_GEN7(ast)) {
>>>           if (ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xD1, 
>>> TX_TYPE_MASK) ==
>>>               ASTDP_DPMCU_TX) {
>>> -            ast->tx_chip_types = AST_TX_ASTDP_BIT;
>>> +            ast->tx_chip_types |= AST_TX_ASTDP_BIT;
>>>               ast_dp_launch(&ast->base);
>>>           }
>>>       }
>>> diff --git a/drivers/gpu/drm/ast/ast_mode.c 
>>> b/drivers/gpu/drm/ast/ast_mode.c
>>> index 6695af70768f..31a49d32e506 100644
>>> --- a/drivers/gpu/drm/ast/ast_mode.c
>>> +++ b/drivers/gpu/drm/ast/ast_mode.c
>>> @@ -1717,7 +1717,8 @@ static int 
>>> ast_bmc_connector_helper_detect_ctx(struct drm_connector *connector,
>>>                              bool force)
>>>   {
>>>       struct ast_bmc_connector *bmc_connector = 
>>> to_ast_bmc_connector(connector);
>>> -    struct drm_connector *physical_connector = 
>>> bmc_connector->physical_connector;
>>> +    struct drm_connector *physical_connector;
>>> +    int i, count = bmc_connector->count;
>>>         /*
>>>        * Most user-space compositors cannot handle more than one 
>>> connected
>>> @@ -1730,10 +1731,13 @@ static int 
>>> ast_bmc_connector_helper_detect_ctx(struct drm_connector *connector,
>>>        *        than one connector per CRTC. The BMC should always 
>>> be connected.
>>>        */
>>>   -    if (physical_connector && physical_connector->status == 
>>> connector_status_disconnected)
>>> -        return connector_status_connected;
>>> +    for (i = 0; i < count; i++) {
>>> +        physical_connector = bmc_connector->physical_connectors[i];
>>> +        if (physical_connector && physical_connector->status == 
>>> connector_status_connected)
>>> +            return connector_status_disconnected;
>>> +    }
>>>   -    return connector_status_disconnected;
>>> +    return connector_status_connected;
>>>   }
>>>     static int ast_bmc_connector_helper_get_modes(struct 
>>> drm_connector *connector)
>>> @@ -1756,10 +1760,11 @@ static const struct drm_connector_funcs 
>>> ast_bmc_connector_funcs = {
>>>     static int ast_bmc_connector_init(struct drm_device *dev,
>>>                     struct ast_bmc_connector *bmc_connector,
>>> -                  struct drm_connector *physical_connector)
>>> +                  struct drm_connector **physical_connector,
>>> +                  int count)
>>>   {
>>>       struct drm_connector *connector = &bmc_connector->base;
>>> -    int ret;
>>> +    int i, ret;
>>>         ret = drm_connector_init(dev, connector, 
>>> &ast_bmc_connector_funcs,
>>>                    DRM_MODE_CONNECTOR_VIRTUAL);
>>> @@ -1768,13 +1773,16 @@ static int ast_bmc_connector_init(struct 
>>> drm_device *dev,
>>>         drm_connector_helper_add(connector, 
>>> &ast_bmc_connector_helper_funcs);
>>>   -    bmc_connector->physical_connector = physical_connector;
>>> +    for (i = 0; i < count; i++)
>>> +        bmc_connector->physical_connectors[i] = physical_connector[i];
>>> +    bmc_connector->count = count;
>>>         return 0;
>>>   }
>>>     static int ast_bmc_output_init(struct ast_device *ast,
>>> -                   struct drm_connector *physical_connector)
>>> +                   struct drm_connector **physical_connector,
>>> +                   int count)
>>>   {
>>>       struct drm_device *dev = &ast->base;
>>>       struct drm_crtc *crtc = &ast->crtc;
>>> @@ -1790,7 +1798,7 @@ static int ast_bmc_output_init(struct 
>>> ast_device *ast,
>>>           return ret;
>>>       encoder->possible_crtcs = drm_crtc_mask(crtc);
>>>   -    ret = ast_bmc_connector_init(dev, bmc_connector, 
>>> physical_connector);
>>> +    ret = ast_bmc_connector_init(dev, bmc_connector, 
>>> physical_connector, count);
>>>       if (ret)
>>>           return ret;
>>>   @@ -1852,8 +1860,8 @@ static const struct drm_mode_config_funcs 
>>> ast_mode_config_funcs = {
>>>   int ast_mode_config_init(struct ast_device *ast)
>>>   {
>>>       struct drm_device *dev = &ast->base;
>>> -    struct drm_connector *physical_connector = NULL;
>>> -    int ret;
>>> +    struct drm_connector *physical_connector[MAX_CONNECTORS] = {NULL};
>>> +    int count, ret;
>>>         ret = drmm_mutex_init(dev, &ast->modeset_lock);
>>>       if (ret)
>>> @@ -1897,27 +1905,27 @@ int ast_mode_config_init(struct ast_device 
>>> *ast)
>>>           ret = ast_vga_output_init(ast);
>>>           if (ret)
>>>               return ret;
>>> -        physical_connector = &ast->output.vga.connector;
>>> +        physical_connector[count++] = &ast->output.vga.connector;
>>>       }
>>>       if (ast->tx_chip_types & AST_TX_SIL164_BIT) {
>>>           ret = ast_sil164_output_init(ast);
>>>           if (ret)
>>>               return ret;
>>> -        physical_connector = &ast->output.sil164.connector;
>>> +        physical_connector[count++] = &ast->output.sil164.connector;
>>>       }
>>>       if (ast->tx_chip_types & AST_TX_DP501_BIT) {
>>>           ret = ast_dp501_output_init(ast);
>>>           if (ret)
>>>               return ret;
>>> -        physical_connector = &ast->output.dp501.connector;
>>> +        physical_connector[count++] = &ast->output.dp501.connector;
>>>       }
>>>       if (ast->tx_chip_types & AST_TX_ASTDP_BIT) {
>>>           ret = ast_astdp_output_init(ast);
>>>           if (ret)
>>>               return ret;
>>> -        physical_connector = &ast->output.astdp.connector;
>>> +        physical_connector[count++] = &ast->output.astdp.connector;
>>>       }
>>> -    ret = ast_bmc_output_init(ast, physical_connector);
>>> +    ret = ast_bmc_output_init(ast, physical_connector, count);
>>>       if (ret)
>>>           return ret;
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


