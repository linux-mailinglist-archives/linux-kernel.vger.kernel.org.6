Return-Path: <linux-kernel+bounces-284183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE0194FE0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8191C2250A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14203D3BF;
	Tue, 13 Aug 2024 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u2vC9BMS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85s1Hz1L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u2vC9BMS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="85s1Hz1L"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413493BBC5;
	Tue, 13 Aug 2024 06:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531417; cv=none; b=Qr/p+UpYcQPx9ar71mW4bUxqdK/2J4d0dMhXFGQAgQJfF1YprPQFCGXGR0WEf1IL2/vpQobZq7zAQG0pJbpQi9ElMALejIW2dA9BFLt0WtLB09lJ/Vu4iA+BVeqUhhcNJGxLQEsONBRkmEVWqyYrjyv1OhHK2gEKss1UBLtt2/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531417; c=relaxed/simple;
	bh=n3Q8ujzM+BHuw1uUmaBoWsUnALIPKIcP+FK0TnsEwyY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eXgc4767HRIkKpqBS86HYgoKIjrA38GqLV3uQUEdDAX4IIE8JviDzJ2FtnJoj5N1BMalx8G9kJ35hywZtPyamlVYG/8tGb+GS4vUzIp3Ka2XqZJPBXtZx4Hi68Vz9OP4aevLxlwpLiOaOAkuIlEjd8Ao7ThvnTAtlfpZ/wM9DSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u2vC9BMS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=85s1Hz1L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u2vC9BMS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=85s1Hz1L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D03522721;
	Tue, 13 Aug 2024 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723531413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zzt+7PwpiA7+5DBqZif280/U0cpF6Vg2+xMwnhvF+qA=;
	b=u2vC9BMS+kyBs5HvI0m8zbMu9dXNHuVHyruhNpnKIAOY/RIbtQhz1ZcmJV+hd3FAU2BA7X
	2u44AYQVhUIq4xP1dl36tksUbGSsDZ81o8RuIE0rDY0fV9Yro4Cc8+/OaCVsfJTtb/YhN0
	lldOvU5iKo+ZbCDWNs6G99mOnm4IX9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723531413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zzt+7PwpiA7+5DBqZif280/U0cpF6Vg2+xMwnhvF+qA=;
	b=85s1Hz1L2x1fkCnxxUusqZa4QB1MdMihCMvX+zu/aKSPbg+Vh72Fy25eeUCpweKmTypCI3
	WaU5oPP8prBuJFBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u2vC9BMS;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=85s1Hz1L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723531413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zzt+7PwpiA7+5DBqZif280/U0cpF6Vg2+xMwnhvF+qA=;
	b=u2vC9BMS+kyBs5HvI0m8zbMu9dXNHuVHyruhNpnKIAOY/RIbtQhz1ZcmJV+hd3FAU2BA7X
	2u44AYQVhUIq4xP1dl36tksUbGSsDZ81o8RuIE0rDY0fV9Yro4Cc8+/OaCVsfJTtb/YhN0
	lldOvU5iKo+ZbCDWNs6G99mOnm4IX9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723531413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zzt+7PwpiA7+5DBqZif280/U0cpF6Vg2+xMwnhvF+qA=;
	b=85s1Hz1L2x1fkCnxxUusqZa4QB1MdMihCMvX+zu/aKSPbg+Vh72Fy25eeUCpweKmTypCI3
	WaU5oPP8prBuJFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0971913983;
	Tue, 13 Aug 2024 06:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dwyQAJUAu2aaFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 Aug 2024 06:43:33 +0000
Date: Tue, 13 Aug 2024 08:44:13 +0200
Message-ID: <87ed6sdirm.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juan =?ISO-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Subject: Re: [PATCH 1/2] ALSA: usb-audio: Support Yamaha P-125 quirk entry
In-Reply-To: <64d6f88a8f978fa6fa090e9c81ed2a834bf21308.1723518816.git.soyjuanarbol@gmail.com>
References: <cover.1723518816.git.soyjuanarbol@gmail.com>
	<64d6f88a8f978fa6fa090e9c81ed2a834bf21308.1723518816.git.soyjuanarbol@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -5.51
X-Rspamd-Queue-Id: 3D03522721
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 13 Aug 2024 05:31:27 +0200,
Juan José Arboleda wrote:
> 
> This patch adds a USB quirk for the Yamaha P-125 digital piano.
> 
> Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
> ---
>  sound/usb/quirks-table.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index f13a8d63a019..24e6f68e2f1e 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -239,6 +239,7 @@ YAMAHA_DEVICE(0x1030, "PSR-295/293"),
>  YAMAHA_DEVICE(0x1031, "DGX-205/203"),
>  YAMAHA_DEVICE(0x1032, "DGX-305"),
>  YAMAHA_DEVICE(0x1033, "DGX-505"),
> +YAMAHA_DEVICE(0x1718, "P-125"),
>  YAMAHA_DEVICE(0x1034, NULL),
>  YAMAHA_DEVICE(0x1035, NULL),
>  YAMAHA_DEVICE(0x1036, NULL),

The entries for Yamaha are sorted in the device ID order.
Please try to put at the right place.


thanks,

Takashi

