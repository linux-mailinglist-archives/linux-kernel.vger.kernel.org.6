Return-Path: <linux-kernel+bounces-265739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56C093F56A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3FF1F22A68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65EB1487D4;
	Mon, 29 Jul 2024 12:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ap6R0wqC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jkk5E5GC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ap6R0wqC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jkk5E5GC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D9B6F31E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256204; cv=none; b=p9rs+PQ1dQFR1qQ+eudPQiRZNoJbseSfe+Hiw2y8MVxMRT+s956Guf0KSODGZLdG46U8lQGPZS5JRGzUuMC33tArhx5Dksotilh+dKooKrz0aSbfqAdbVfY4c6XRComjIG7NBpQKv5hOqgrTblX3vjXBB0qW27y/hZk4KxTea3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256204; c=relaxed/simple;
	bh=QUCxMVD+46Y4cv++/x8YgjrzsG5+uz/KG4c1+srzQy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpgHrdjjo1GxwG1AJIu3+r4175Sa3JYXWARUX9UQqzIfYEDUeEEybTuT2WmnfglVBNl6l7w31wthw87GeyBIZX922grHoqOIKbU7HJre4uNwmzrZSrQWPzgC/MhVRu3Tf1orhjWH/yqKMN8LfU5/TEnUECzERtCRgvZhfoh7rvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ap6R0wqC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jkk5E5GC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ap6R0wqC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jkk5E5GC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 70CAF219C3;
	Mon, 29 Jul 2024 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722256200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHMNfno8A9Uls8NuajtrQXArGe4mRmqWZ22YDnLruiA=;
	b=Ap6R0wqCulkCRdl0uTIO7KTAuw25NVVzeU5Re8zqqGVtE8R3NdmCTns30pkKp36a1BS4I1
	uj7JEAxD+5dJEqa+qmwiLV8e6DyZEevlHF33yeQBlCOlxYX0LcgdnsSY0nWN6TYSvYnVYm
	9UWhDElq1YQqj+k+AIaMnTx5IVMw3VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722256200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHMNfno8A9Uls8NuajtrQXArGe4mRmqWZ22YDnLruiA=;
	b=jkk5E5GC3Yc89xWQBKXGDteNK9Vi9leDL40oE3azpE+9hxhr+2UWBDKMq+oXiZ1lPo+JTG
	PlOEQItn7KfjiOCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ap6R0wqC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jkk5E5GC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722256200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHMNfno8A9Uls8NuajtrQXArGe4mRmqWZ22YDnLruiA=;
	b=Ap6R0wqCulkCRdl0uTIO7KTAuw25NVVzeU5Re8zqqGVtE8R3NdmCTns30pkKp36a1BS4I1
	uj7JEAxD+5dJEqa+qmwiLV8e6DyZEevlHF33yeQBlCOlxYX0LcgdnsSY0nWN6TYSvYnVYm
	9UWhDElq1YQqj+k+AIaMnTx5IVMw3VE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722256200;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LHMNfno8A9Uls8NuajtrQXArGe4mRmqWZ22YDnLruiA=;
	b=jkk5E5GC3Yc89xWQBKXGDteNK9Vi9leDL40oE3azpE+9hxhr+2UWBDKMq+oXiZ1lPo+JTG
	PlOEQItn7KfjiOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F1C6138A7;
	Mon, 29 Jul 2024 12:30:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H1Y/CkiLp2bJQwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 29 Jul 2024 12:30:00 +0000
Message-ID: <18d7ea0a-64d7-4432-bd86-0d3b6e699175@suse.de>
Date: Mon, 29 Jul 2024 14:29:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: add multiple connectors support
To: oushixiong1025@163.com, Dave Airlie <airlied@redhat.com>
Cc: Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20240711090102.352213-1-oushixiong1025@163.com>
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
In-Reply-To: <20240711090102.352213-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 70CAF219C3
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[163.com,redhat.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org,kylinos.cn];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]

Hi

Am 11.07.24 um 11:01 schrieb oushixiong1025@163.com:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>
> [WHY]
> The AST2600 tx_chip_types will be detected as AST_TX_DP, but some BMC
> boards that use AST2600 use the VGA interface instead of the DP interface.
> In this case, it will use Virtual connector as the DP is disconnected.
>
> [HOW]
> Allows multiple physical connectors to exist at the same time.

I have another question about this patch. Is there a physical connector 
for each type (VGA, DP) on your board? Or just one of them?

Best regards
Thomas

>
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/ast/ast_drv.h  |  6 ++++-
>   drivers/gpu/drm/ast/ast_main.c |  8 +++----
>   drivers/gpu/drm/ast/ast_mode.c | 40 ++++++++++++++++++++--------------
>   3 files changed, 33 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
> index ba3d86973995..e326124b3fec 100644
> --- a/drivers/gpu/drm/ast/ast_drv.h
> +++ b/drivers/gpu/drm/ast/ast_drv.h
> @@ -150,9 +150,13 @@ static inline struct ast_plane *to_ast_plane(struct drm_plane *plane)
>    * BMC
>    */
>   
> +#define MAX_CONNECTORS 2
> +
>   struct ast_bmc_connector {
>   	struct drm_connector base;
> -	struct drm_connector *physical_connector;
> +
> +	struct drm_connector *physical_connectors[MAX_CONNECTORS];
> +	int count;
>   };
>   
>   static inline struct ast_bmc_connector *
> diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
> index 0637abb70361..428529749ae6 100644
> --- a/drivers/gpu/drm/ast/ast_main.c
> +++ b/drivers/gpu/drm/ast/ast_main.c
> @@ -85,7 +85,7 @@ static void ast_detect_tx_chip(struct ast_device *ast, bool need_post)
>   	if (!need_post) {
>   		jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xff);
>   		if (jreg & 0x80)
> -			ast->tx_chip_types = AST_TX_SIL164_BIT;
> +			ast->tx_chip_types |= AST_TX_SIL164_BIT;
>   	}
>   
>   	if (IS_AST_GEN4(ast) || IS_AST_GEN5(ast) || IS_AST_GEN6(ast)) {
> @@ -97,7 +97,7 @@ static void ast_detect_tx_chip(struct ast_device *ast, bool need_post)
>   		jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xd1, 0xff);
>   		switch (jreg) {
>   		case 0x04:
> -			ast->tx_chip_types = AST_TX_SIL164_BIT;
> +			ast->tx_chip_types |= AST_TX_SIL164_BIT;
>   			break;
>   		case 0x08:
>   			ast->dp501_fw_addr = drmm_kzalloc(dev, 32*1024, GFP_KERNEL);
> @@ -110,12 +110,12 @@ static void ast_detect_tx_chip(struct ast_device *ast, bool need_post)
>   			}
>   			fallthrough;
>   		case 0x0c:
> -			ast->tx_chip_types = AST_TX_DP501_BIT;
> +			ast->tx_chip_types |= AST_TX_DP501_BIT;
>   		}
>   	} else if (IS_AST_GEN7(ast)) {
>   		if (ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xD1, TX_TYPE_MASK) ==
>   		    ASTDP_DPMCU_TX) {
> -			ast->tx_chip_types = AST_TX_ASTDP_BIT;
> +			ast->tx_chip_types |= AST_TX_ASTDP_BIT;
>   			ast_dp_launch(&ast->base);
>   		}
>   	}
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 6695af70768f..31a49d32e506 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -1717,7 +1717,8 @@ static int ast_bmc_connector_helper_detect_ctx(struct drm_connector *connector,
>   					       bool force)
>   {
>   	struct ast_bmc_connector *bmc_connector = to_ast_bmc_connector(connector);
> -	struct drm_connector *physical_connector = bmc_connector->physical_connector;
> +	struct drm_connector *physical_connector;
> +	int i, count = bmc_connector->count;
>   
>   	/*
>   	 * Most user-space compositors cannot handle more than one connected
> @@ -1730,10 +1731,13 @@ static int ast_bmc_connector_helper_detect_ctx(struct drm_connector *connector,
>   	 *        than one connector per CRTC. The BMC should always be connected.
>   	 */
>   
> -	if (physical_connector && physical_connector->status == connector_status_disconnected)
> -		return connector_status_connected;
> +	for (i = 0; i < count; i++) {
> +		physical_connector = bmc_connector->physical_connectors[i];
> +		if (physical_connector && physical_connector->status == connector_status_connected)
> +			return connector_status_disconnected;
> +	}
>   
> -	return connector_status_disconnected;
> +	return connector_status_connected;
>   }
>   
>   static int ast_bmc_connector_helper_get_modes(struct drm_connector *connector)
> @@ -1756,10 +1760,11 @@ static const struct drm_connector_funcs ast_bmc_connector_funcs = {
>   
>   static int ast_bmc_connector_init(struct drm_device *dev,
>   				  struct ast_bmc_connector *bmc_connector,
> -				  struct drm_connector *physical_connector)
> +				  struct drm_connector **physical_connector,
> +				  int count)
>   {
>   	struct drm_connector *connector = &bmc_connector->base;
> -	int ret;
> +	int i, ret;
>   
>   	ret = drm_connector_init(dev, connector, &ast_bmc_connector_funcs,
>   				 DRM_MODE_CONNECTOR_VIRTUAL);
> @@ -1768,13 +1773,16 @@ static int ast_bmc_connector_init(struct drm_device *dev,
>   
>   	drm_connector_helper_add(connector, &ast_bmc_connector_helper_funcs);
>   
> -	bmc_connector->physical_connector = physical_connector;
> +	for (i = 0; i < count; i++)
> +		bmc_connector->physical_connectors[i] = physical_connector[i];
> +	bmc_connector->count = count;
>   
>   	return 0;
>   }
>   
>   static int ast_bmc_output_init(struct ast_device *ast,
> -			       struct drm_connector *physical_connector)
> +			       struct drm_connector **physical_connector,
> +			       int count)
>   {
>   	struct drm_device *dev = &ast->base;
>   	struct drm_crtc *crtc = &ast->crtc;
> @@ -1790,7 +1798,7 @@ static int ast_bmc_output_init(struct ast_device *ast,
>   		return ret;
>   	encoder->possible_crtcs = drm_crtc_mask(crtc);
>   
> -	ret = ast_bmc_connector_init(dev, bmc_connector, physical_connector);
> +	ret = ast_bmc_connector_init(dev, bmc_connector, physical_connector, count);
>   	if (ret)
>   		return ret;
>   
> @@ -1852,8 +1860,8 @@ static const struct drm_mode_config_funcs ast_mode_config_funcs = {
>   int ast_mode_config_init(struct ast_device *ast)
>   {
>   	struct drm_device *dev = &ast->base;
> -	struct drm_connector *physical_connector = NULL;
> -	int ret;
> +	struct drm_connector *physical_connector[MAX_CONNECTORS] = {NULL};
> +	int count, ret;
>   
>   	ret = drmm_mutex_init(dev, &ast->modeset_lock);
>   	if (ret)
> @@ -1897,27 +1905,27 @@ int ast_mode_config_init(struct ast_device *ast)
>   		ret = ast_vga_output_init(ast);
>   		if (ret)
>   			return ret;
> -		physical_connector = &ast->output.vga.connector;
> +		physical_connector[count++] = &ast->output.vga.connector;
>   	}
>   	if (ast->tx_chip_types & AST_TX_SIL164_BIT) {
>   		ret = ast_sil164_output_init(ast);
>   		if (ret)
>   			return ret;
> -		physical_connector = &ast->output.sil164.connector;
> +		physical_connector[count++] = &ast->output.sil164.connector;
>   	}
>   	if (ast->tx_chip_types & AST_TX_DP501_BIT) {
>   		ret = ast_dp501_output_init(ast);
>   		if (ret)
>   			return ret;
> -		physical_connector = &ast->output.dp501.connector;
> +		physical_connector[count++] = &ast->output.dp501.connector;
>   	}
>   	if (ast->tx_chip_types & AST_TX_ASTDP_BIT) {
>   		ret = ast_astdp_output_init(ast);
>   		if (ret)
>   			return ret;
> -		physical_connector = &ast->output.astdp.connector;
> +		physical_connector[count++] = &ast->output.astdp.connector;
>   	}
> -	ret = ast_bmc_output_init(ast, physical_connector);
> +	ret = ast_bmc_output_init(ast, physical_connector, count);
>   	if (ret)
>   		return ret;
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


