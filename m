Return-Path: <linux-kernel+bounces-348161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D8998E385
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450DE1C23070
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B74E212F0E;
	Wed,  2 Oct 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fziR4jMA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WhvXSn1i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fziR4jMA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WhvXSn1i"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA319146E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897657; cv=none; b=SIihReZWm3p9Lh8mO5mMDwIr6NLbgVBLz02e/pU9VByk6/PJXFi2Qvn8ZMigbl6VPj4NGCs1oMwYmLqryRyeJizGU55xB6BTfAHvhR6rBNvqGcIYSAJGdXHjW7AmslslpAZutyxrXGoBacaVcztW8JgsrbVlFWrPrTTtQEDkblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897657; c=relaxed/simple;
	bh=xKu20YOTWNm1xVEeGUtCSeOOXVWFVIZWOm+4WqX1HNc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QETdpR8GvIfX1hNa6MD4kSsFI8TWW6A69NnH304Tom5b3wk08CqMTTT2Dikk06FotcRvMsZfJShEIrUCgEOMmXSoa8JQpmfEj89kJZ7lZN5iZ/4hLwCvR8OhffGAZdk0lUDZkyRZkbJmL8ImFvY5Mn57csB+lyuP3U1Eu7dWlMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fziR4jMA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WhvXSn1i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fziR4jMA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WhvXSn1i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6FD1FD79;
	Wed,  2 Oct 2024 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727897653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkPq3Tqq4+DFeCmMuxDHXn7UQLOD+ntOPosCkgrFsh4=;
	b=fziR4jMAQOmonay/4bhud0YnkMsfhA0eOFLjmErw97GO33g9LrGa8RepNLFhUFTB0j3j4M
	7jxWy61ETzEPxYZorrBofEnNevmBD4gw42YzuardzgMPhZgqGeULkwHF3tv7jOYCX8TyCw
	CrHWrK/Y5NqwS8FodMEf6Xp/ZseOpwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727897653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkPq3Tqq4+DFeCmMuxDHXn7UQLOD+ntOPosCkgrFsh4=;
	b=WhvXSn1iqTg1W96OgnKc0M6MiZsVlQ7nHp57nDeL7mKYeOBG5uNZ1qjNCdUMKFWIYCAktx
	vIC+q4OE0UG3YiBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727897653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkPq3Tqq4+DFeCmMuxDHXn7UQLOD+ntOPosCkgrFsh4=;
	b=fziR4jMAQOmonay/4bhud0YnkMsfhA0eOFLjmErw97GO33g9LrGa8RepNLFhUFTB0j3j4M
	7jxWy61ETzEPxYZorrBofEnNevmBD4gw42YzuardzgMPhZgqGeULkwHF3tv7jOYCX8TyCw
	CrHWrK/Y5NqwS8FodMEf6Xp/ZseOpwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727897653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bkPq3Tqq4+DFeCmMuxDHXn7UQLOD+ntOPosCkgrFsh4=;
	b=WhvXSn1iqTg1W96OgnKc0M6MiZsVlQ7nHp57nDeL7mKYeOBG5uNZ1qjNCdUMKFWIYCAktx
	vIC+q4OE0UG3YiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5875613A6E;
	Wed,  2 Oct 2024 19:34:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NZsJFDSg/WaUDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 02 Oct 2024 19:34:12 +0000
Date: Wed, 02 Oct 2024 21:35:05 +0200
Message-ID: <875xqal2mu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jaroslav Kysela <perex@perex.cz>
Cc: Linux Sound ML <linux-sound@vger.kernel.org>,	Takashi Iwai
 <tiwai@suse.de>,	linux-kernel@vger.kernel.org,	Ban Tao
 <fengzheng923@gmail.com>,	Lars-Peter Clausen <lars@metafoo.de>,	Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,	Johannes Berg
 <johannes@sipsolutions.net>,	Jerome Brunet <jbrunet@baylibre.com>,	Martin
 =?ISO-8859-2?Q?Povi=B9er?= <povik+lin@cutebit.org>,	Peter Rosin
 <peda@axentia.se>,	Clemens Ladisch <clemens@ladisch.de>,	Takashi Sakamoto
 <o-takashi@sakamocchi.jp>,	"Geoffrey D. Bennett" <g@b4.vu>,	Shengjiu Wang
 <shengjiu.wang@gmail.com>,	Xiubo Li <Xiubo.Lee@gmail.com>,	Fabio Estevam
 <festevam@gmail.com>,	Nicolin Chen <nicoleotsuka@gmail.com>,
	"J.M.B. Downing" <jonathan.downing@nautel.com>,	Piotr Wojtaszczyk
 <piotr.wojtaszczyk@timesys.com>,	Vladimir Zapolskiy <vz@mleia.com>,	Herve
 Codina <herve.codina@bootlin.com>,	Cezary Rojewski
 <cezary.rojewski@intel.com>,	Liam Girdwood
 <liam.r.girdwood@linux.intel.com>,	Peter Ujfalusi
 <peter.ujfalusi@linux.intel.com>,	Bard Liao
 <yung-chuan.liao@linux.intel.com>,	Ranjani Sridharan
 <ranjani.sridharan@linux.intel.com>,	Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,	Pierre-Louis Bossart
 <pierre-louis.bossart@linux.dev>,	Kiseok Jo <kiseok.jo@irondevice.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,	Daniel Mack <zonque@gmail.com>,
	Stephan Gerhold <stephan@gerhold.net>,	Peter Ujfalusi
 <peter.ujfalusi@gmail.com>,	Jarkko Nikula <jarkko.nikula@bitmer.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,	Sylwester Nawrocki
 <s.nawrocki@samsung.com>,	Vinod Koul <vkoul@kernel.org>,	Sanyog Kale
 <sanyog.r.kale@intel.com>,	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,	Shenghao Ding
 <shenghao-ding@ti.com>,	Kevin Lu <kevin-lu@ti.com>,	Baojun Xu
 <baojun.xu@ti.com>,	M R Swami Reddy <mr.swami.reddy@ti.com>,	Vishwas A
 Deshpande <vishwas.a.deshpande@ti.com>,	Kirill Marinushkin
 <kmarinushkin@birdec.com>,	Kevin Cernekee <cernekee@chromium.org>,	Anton
 Yakovlev <anton.yakovlev@opensynergy.com>,	"Michael S. Tsirkin"
 <mst@redhat.com>,	Oleksandr Andrushchenko
 <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH] MAINTAINERS: ALSA: use linux-sound@vger.kernel.org list
In-Reply-To: <20241002151536.1855793-1-perex@perex.cz>
References: <20241002151536.1855793-1-perex@perex.cz>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[lin];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLtz4y7943h1dm9t59x9i47taa)];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.de,gmail.com,metafoo.de,analog.com,sipsolutions.net,baylibre.com,cutebit.org,axentia.se,ladisch.de,sakamocchi.jp,b4.vu,nautel.com,timesys.com,mleia.com,bootlin.com,intel.com,linux.intel.com,linux.dev,irondevice.com,tuxon.dev,gerhold.net,bitmer.com,linaro.org,samsung.com,kernel.org,foss.st.com,ti.com,birdec.com,chromium.org,opensynergy.com,redhat.com,epam.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 02 Oct 2024 17:15:36 +0200,
Jaroslav Kysela wrote:
> 
> We are now using the linux-sound@vger.kernel.org list for kernel
> related work. This patch converts all remaining entries that reference
> the former alsa-devel mailing list.
> 
> All ALSA developers should subscribe to the linux-sound
> mailing list. Thank you.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: Ban Tao <fengzheng923@gmail.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Povi¹er <povik+lin@cutebit.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: Geoffrey D. Bennett <g@b4.vu>
> Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
> Cc: Xiubo Li <Xiubo.Lee@gmail.com>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Nicolin Chen <nicoleotsuka@gmail.com>
> Cc: J.M.B. Downing <jonathan.downing@nautel.com>
> Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> Cc: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Herve Codina <herve.codina@bootlin.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: Kiseok Jo <kiseok.jo@irondevice.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Daniel Mack <zonque@gmail.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Shenghao Ding <shenghao-ding@ti.com>
> Cc: Kevin Lu <kevin-lu@ti.com>
> Cc: Baojun Xu <baojun.xu@ti.com>
> Cc: M R Swami Reddy <mr.swami.reddy@ti.com>
> Cc: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>
> Cc: Kirill Marinushkin <kmarinushkin@birdec.com>
> Cc: Kevin Cernekee <cernekee@chromium.org>
> Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>

Applied now, thanks.


Takashi

