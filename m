Return-Path: <linux-kernel+bounces-213162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27056906DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B83A1F2199B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802D11482F1;
	Thu, 13 Jun 2024 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xrGNiGgD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UL51kaxd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xrGNiGgD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UL51kaxd"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE81474BF;
	Thu, 13 Jun 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280084; cv=none; b=PyBmgqTnpoTym01SJxYgOQ7MnWM42ZNSZa4gH8R5XyrOIq9CKTUSuCXyVrWag6tjdi52eTnbrQGVT2iTlvknpKxnywi5036lq414Mp0jcd3qHFRUoDvuoVKGJlxWGl+sNAyNiPovrq4xlQwilJxN/xAgaRjWfvjcFHm8qyL1NrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280084; c=relaxed/simple;
	bh=jXKgcxjhp7dP+6RZKb9D/HR5C/E9UziMumLh/FAU1Uc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgaDvVzDKLk3NkJv9BNm7E9VKSlb7MWb+QsFTjAyFOBR4c5wRn1oUbE0GohCs9mtmz3N3dy2rqNfxmZfp4YCG24wTmD5bS0/SKDYAQy2MR9vJ4ROuzJFNmkIPaYAFoXdMu6tdX6Wi8yr6SgeBPdWy2p14BPKWkd2wNElFuaFqiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xrGNiGgD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UL51kaxd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xrGNiGgD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UL51kaxd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFD345D2D3;
	Thu, 13 Jun 2024 12:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix0hgv8npV79bxIJwCvm11zIiXgCMm13N5u0/ILQj4o=;
	b=xrGNiGgDy8HRWNxciUEDQXKJnQCZ80pNeS7f/JveyaFqulrGiw98Qqemnt/UsyYW+teF7e
	26G2ra/8fhyqn5KABujsb9JCSxH3uVpX6znpcN1Y9e9mJWrXfbusIy7KGFUXcBp5VQczPp
	PIVBrDVsUwtIebiNzdB90m87+CRX9E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix0hgv8npV79bxIJwCvm11zIiXgCMm13N5u0/ILQj4o=;
	b=UL51kaxdwxNHIILLIGhOIcVcyKPH6EMobRY/mG88l5j2NLV2tQgqJUNo+yrCOWd+MiIfD4
	VFx5ItzdsGvD1jAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xrGNiGgD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UL51kaxd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718280080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix0hgv8npV79bxIJwCvm11zIiXgCMm13N5u0/ILQj4o=;
	b=xrGNiGgDy8HRWNxciUEDQXKJnQCZ80pNeS7f/JveyaFqulrGiw98Qqemnt/UsyYW+teF7e
	26G2ra/8fhyqn5KABujsb9JCSxH3uVpX6znpcN1Y9e9mJWrXfbusIy7KGFUXcBp5VQczPp
	PIVBrDVsUwtIebiNzdB90m87+CRX9E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718280080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ix0hgv8npV79bxIJwCvm11zIiXgCMm13N5u0/ILQj4o=;
	b=UL51kaxdwxNHIILLIGhOIcVcyKPH6EMobRY/mG88l5j2NLV2tQgqJUNo+yrCOWd+MiIfD4
	VFx5ItzdsGvD1jAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8CE5313A87;
	Thu, 13 Jun 2024 12:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zPcrIZDfambFHwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 13 Jun 2024 12:01:20 +0000
Date: Thu, 13 Jun 2024 14:01:44 +0200
Message-ID: <87ikydnj9z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] ALSA: hda/senarytech: add senarytech codec support
In-Reply-To: <20240606015703.37118-1-bo.liu@senarytech.com>
References: <20240606015703.37118-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: BFD345D2D3
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 06 Jun 2024 03:57:03 +0200,
bo liu wrote:
> 
> Add initial Senarytech codec support for SN6186. Note that this hda
> patch relies on the configuration default registers to be set correctly
> (normally by BIOS/firmware) in order for it to set up pin widgets
> properly.
> 
> Signed-off-by: bo liu <bo.liu@senarytech.com>

The code looks almost fine, just a few nitpicking:

> --- a/sound/pci/hda/Makefile
> +++ b/sound/pci/hda/Makefile
> @@ -24,6 +24,7 @@ snd-hda-codec-cs8409-y :=	patch_cs8409.o patch_cs8409-tables.o
>  snd-hda-codec-ca0110-y :=	patch_ca0110.o
>  snd-hda-codec-ca0132-y :=	patch_ca0132.o
>  snd-hda-codec-conexant-y :=	patch_conexant.o
> +snd-hda-codec-senarytech-objs :=patch_senarytech.o

Use *-y instead of *-objs.  The other entries have been corrected
recently.

> +/* parse EAPDs */
> +static void senary_auto_parse_eapd(struct hda_codec *codec)
> +{
> +	struct senary_spec *spec = codec->spec;
> +	hda_nid_t nid;
> +
> +	for_each_hda_codec_node(nid, codec) {
> +		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_PIN)
> +			continue;
> +		if (!(snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD))
> +			continue;
> +		spec->eapds[spec->num_eapds++] = nid;
> +		if (spec->num_eapds >= ARRAY_SIZE(spec->eapds))
> +			break;
> +	}
> +
> +	/* NOTE: below is a wild guess; if we have more than two EAPDs,
> +	 * it's a new chip, where EAPDs are supposed to be associated to
> +	 * pins, and we can control EAPD per pin.
> +	 * OTOH, if only one or two EAPDs are found, it's an old chip,
> +	 * thus it might control over all pins.
> +	 */
> +	if (spec->num_eapds > 2)
> +		spec->dynamic_eapd = 1;

Do you still need to verify this?  This is copied from Conexant
driver, and they needed this workaround due to different handling per
chip model.  Unless needed, better to drop (or assuming always true)
this condition for simplicity.

> +#ifdef CONFIG_PM
> +static int senary_auto_suspend(struct hda_codec *codec)
> +{
> +	senary_auto_shutdown(codec);
> +	return 0;
> +}
> +#endif

The latest code dropped the dependency on CONFIG_PM.  Remove ifdef.

> +static const struct hda_codec_ops senary_auto_patch_ops = {
> +	.build_controls = snd_hda_gen_build_controls,
> +	.build_pcms = snd_hda_gen_build_pcms,
> +	.init = senary_auto_init,
> +	.free = senary_auto_free,
> +	.unsol_event = snd_hda_jack_unsol_event,
> +#ifdef CONFIG_PM
> +	.suspend = senary_auto_suspend,
> +	.check_power_status = snd_hda_gen_check_power_status,
> +#endif

Ditto.


thanks,

Takashi

