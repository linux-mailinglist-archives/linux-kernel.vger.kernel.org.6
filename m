Return-Path: <linux-kernel+bounces-348830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8998EC57
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1075D1C21D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8961465AE;
	Thu,  3 Oct 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pVU1ocyH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6bzsDfgO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pVU1ocyH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6bzsDfgO"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125F13D882
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727948151; cv=none; b=unuu4EF+GSe9OWqz3mhT02b4SCvuPaVEIPYQOvjDJ5fBnXDAeWwHubKG4+5PDklUxMMmS6fxpiiYhBeRFDVJ/1UJKIn6wTT15h5WqauKVEucpv30/CCCWuNKchF6V9EVk9KOdTooTWH1p5V1izvcKuhK/hU8CmrJOxD4BOGQomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727948151; c=relaxed/simple;
	bh=iL4fAnM3dHMQTI7UQ3r2elUOBFsMfEiu8u112qh2DNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aF7OeOtE2RIhrRXcRaZV5TULanAciNd9h4RWdNVnlc3Vcv1TXQ5+1QeQOSzOU54zMnzXy9MpgiDsZqYFsq6aDgQPHnpTAXSnPb7tI+JP/gSOswwZ6+5OW+f5Kf/vRXhZVBe2aomUMrwi8t4pF8gNnpQ310cx6b82prh0NdA9Bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pVU1ocyH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6bzsDfgO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pVU1ocyH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6bzsDfgO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80AA121D40;
	Thu,  3 Oct 2024 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727948147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L69FxSOeClbMeu+XyEb/3BiqDA7J+F3bE0442klnBaM=;
	b=pVU1ocyHdD+22go8XY5119TRZYW/Ug0+lqwDyOBhJLQpb5o8GBQehkfOYch9QRPHYxzOBE
	RdCuaxL0H0PCGRk84Ns3sSJU/Z8Pvmb4h9N3J+/a2nuOhT4gXieEkNbjT5h3sLeTLVaVuj
	mlnqQbrq+JSx7Y6yW9pMri86EE++OjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727948147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L69FxSOeClbMeu+XyEb/3BiqDA7J+F3bE0442klnBaM=;
	b=6bzsDfgOFoCthSnmeZjpLfHN+eiBcanLJwHd2PteSQEPL8AbOsykqVUN4eU4AwVQ9jBtNN
	knz1Rw/89O6J82Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1727948147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L69FxSOeClbMeu+XyEb/3BiqDA7J+F3bE0442klnBaM=;
	b=pVU1ocyHdD+22go8XY5119TRZYW/Ug0+lqwDyOBhJLQpb5o8GBQehkfOYch9QRPHYxzOBE
	RdCuaxL0H0PCGRk84Ns3sSJU/Z8Pvmb4h9N3J+/a2nuOhT4gXieEkNbjT5h3sLeTLVaVuj
	mlnqQbrq+JSx7Y6yW9pMri86EE++OjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1727948147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L69FxSOeClbMeu+XyEb/3BiqDA7J+F3bE0442klnBaM=;
	b=6bzsDfgOFoCthSnmeZjpLfHN+eiBcanLJwHd2PteSQEPL8AbOsykqVUN4eU4AwVQ9jBtNN
	knz1Rw/89O6J82Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A268139CE;
	Thu,  3 Oct 2024 09:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T4swDHNl/ma4bwAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 03 Oct 2024 09:35:47 +0000
Date: Thu, 3 Oct 2024 11:35:45 +0200
From: Jean Delvare <jdelvare@suse.de>
To: liujing <liujing@cmss.chinamobile.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, W_Armin@gmx.de,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eeprom: fix spelling of switch
Message-ID: <20241003113545.33087f36@endymion.delvare>
In-Reply-To: <20240921134128.16870-1-liujing@cmss.chinamobile.com>
References: <20240921134128.16870-1-liujing@cmss.chinamobile.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,linuxfoundation.org,gmx.de,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 21 Sep 2024 21:41:28 +0800, liujing wrote:
> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> 
> ---
> V1-V2: fix title description, move cacography to spelling
> 
> diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
> index 9df12399bda3..cb1c4b8e7fd3 100644
> --- a/drivers/misc/eeprom/Kconfig
> +++ b/drivers/misc/eeprom/Kconfig
> @@ -97,11 +97,11 @@ config EEPROM_DIGSY_MTC_CFG
>  	  If unsure, say N.
>  
>  config EEPROM_IDT_89HPESX
> -	tristate "IDT 89HPESx PCIe-swtiches EEPROM / CSR support"
> +	tristate "IDT 89HPESx PCIe-switches EEPROM / CSR support"
>  	depends on I2C && SYSFS
>  	help
>  	  Enable this driver to get read/write access to EEPROM / CSRs
> -	  over IDT PCIe-swtich i2c-slave interface.
> +	  over IDT PCIe-switch i2c-slave interface.
>  
>  	  This driver can also be built as a module. If so, the module
>  	  will be called idt_89hpesx.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks,
-- 
Jean Delvare
SUSE L3 Support

