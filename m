Return-Path: <linux-kernel+bounces-214920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C331C908C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6617C283DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198F8199EB8;
	Fri, 14 Jun 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="viyCHidv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZP/JNik0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="viyCHidv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZP/JNik0"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD81195F1D;
	Fri, 14 Jun 2024 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718369709; cv=none; b=ZxemJ/aKCTByUL5nFydKhT8xZCiUgnPjBjSr3Fsxcwf2yDZfCu21+sr0/LIKZDEeRjHFDzfs4BVMHL8PzIrvxmkFHpJcNP/3bZhhp1WO7Tzbl0E3w00S1tjnczo7+TESbNTBVvZ0ve9ZHKMcO6ifaCnX+vuu0/+8gOvjEvjSLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718369709; c=relaxed/simple;
	bh=iVaGy8W6T9mHWV09FW/jEM2EB0wqInQIFp26nT7SuGo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPbtrNCAOHfMADN+JmdHnrwDI20Hg8QQp2qjPRwiFML8r/Kj1xLeBl0l2P++Z6WOFWnnrSWRNq6TJdmd+8BNxlxjgU1TFpsBaPhlCAo2/6w3R03kjJ6PaaBQBX5r4xIkl177N449MppOYcdZeJzwr1IhsFcXMfhcrRFQNmqm66Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=viyCHidv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZP/JNik0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=viyCHidv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZP/JNik0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 555323380B;
	Fri, 14 Jun 2024 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGUDi25w4Wy8PrwQH04bIY6SwVHvmlcnTQSHgTX6SZs=;
	b=viyCHidvKG8WizadpgE3JPFzoDPLNhysHZH2521vxDq/M6Kv/+L6rJSK+aCZ5me3yXcqgC
	58Aj3vdwGaHATf4MP0GQWfncwLqpb9pa1rJZfYzhB7KFAz/qCmvSAwgmskP2r6IRAf36iz
	LkKbk+LGHShUSPRFAK24Zc+XNucLwjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGUDi25w4Wy8PrwQH04bIY6SwVHvmlcnTQSHgTX6SZs=;
	b=ZP/JNik0MIRN4mwSRactvzFqH1VMb4RsixqM/peSVFDY8O1Ot73WHlY81+47EH8oPrit5P
	JKXRR0F2LrjAlaCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718369706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGUDi25w4Wy8PrwQH04bIY6SwVHvmlcnTQSHgTX6SZs=;
	b=viyCHidvKG8WizadpgE3JPFzoDPLNhysHZH2521vxDq/M6Kv/+L6rJSK+aCZ5me3yXcqgC
	58Aj3vdwGaHATf4MP0GQWfncwLqpb9pa1rJZfYzhB7KFAz/qCmvSAwgmskP2r6IRAf36iz
	LkKbk+LGHShUSPRFAK24Zc+XNucLwjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718369706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TGUDi25w4Wy8PrwQH04bIY6SwVHvmlcnTQSHgTX6SZs=;
	b=ZP/JNik0MIRN4mwSRactvzFqH1VMb4RsixqM/peSVFDY8O1Ot73WHlY81+47EH8oPrit5P
	JKXRR0F2LrjAlaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CA6D13AB1;
	Fri, 14 Jun 2024 12:55:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5FdPCao9bGaRMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 14 Jun 2024 12:55:06 +0000
Date: Fri, 14 Jun 2024 14:55:31 +0200
Message-ID: <875xub8z0c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: bo liu <bo.liu@senarytech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] ALSA: hda/senarytech: add senarytech codec support
In-Reply-To: <20240614031630.61581-1-bo.liu@senarytech.com>
References: <20240614031630.61581-1-bo.liu@senarytech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Fri, 14 Jun 2024 05:16:30 +0200,
bo liu wrote:
> 
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
> +	/* chips always have more than two EAPDs, we can control EAPD per pin. */
> +	spec->dynamic_eapd = 1;

So it's a fixed value, and we can drop this flag and the
conditionals.  Let's clean up the code.


thanks,

Takashi

