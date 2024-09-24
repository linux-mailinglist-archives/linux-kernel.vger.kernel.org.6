Return-Path: <linux-kernel+bounces-337037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F598447A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2AD3283D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBFD1A4F29;
	Tue, 24 Sep 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mFSdVJRC"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDB1A270;
	Tue, 24 Sep 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727177279; cv=none; b=u6mpedvUHTMAq3momE+lQWSKjCNNne51tukmAdDoo1ft0DGBP4SRFFy9r5sEpfjkXICq9BXMVnZpJQFKze0uklBuhvjNu6TlEPa2Vm8ziP2qx9UWLkkyzSlGu9pEfCzeAiZOqbRzkPqFvANb82cyGMt0+MB9kzspFHJJQtchNZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727177279; c=relaxed/simple;
	bh=zql0UFyD9e6gEijJF+6zQpiD0eDyWRmtczoPGlBcpfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LfNX7CoX8uZONxquaIsnfvJAvLykEgBeJ4u51nqQsUA6t+It52HOv04/HP3IxARqRsPO359wODKl5BnwyvizKS/PsmtpGGprTmn2hiAKFxnsL+fzCCPZvZAz/Fwg9DtssfZKS99yNfS6f4N59WhMtkz5keYA9pQcJAGkjZSZPLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mFSdVJRC; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727177278; x=1758713278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zql0UFyD9e6gEijJF+6zQpiD0eDyWRmtczoPGlBcpfI=;
  b=mFSdVJRCySvCFjfbzomIQpANIYpb5mdJnG7Qih/8VkV6zjoNuQmQu7Z2
   34g9g/dEflFFKasOeOi5CC+1tH0XsScxHpt4+p++x3/LoDYh8i5MRVQ53
   roLNCXdfh41kcqcnfQzewYC/Y8NrcJm95h8yM1lKWKLyQ3YXomxsELDP8
   T/SzOnft+6TazTIHSau2VWzxLiy3N5dMjYJ1C8WPJWO6I93putGwpmWY/
   wBJg8U1I5cvrJPOEzUWQ7g8qQ4mO5El6mXDlZlw56+7YbV08LwZ3axWWW
   vN2385q4hXg8EXGbNcxJbeM17+sEaqyXAydHgobh0ZDqEa9TVd9oBJHN+
   A==;
X-CSE-ConnectionGUID: gLqVBAZkQqmoxUm1padfyg==
X-CSE-MsgGUID: ej1v0jdzRl+8yr6Hszmyog==
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="32166627"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Sep 2024 04:27:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 24 Sep 2024 04:27:27 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 24 Sep 2024 04:27:24 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>
CC: <alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
	<andrei.simion@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<nicolas.ferre@microchip.com>, <perex@perex.cz>, <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: atmel: mchp-pdmc: Skip ALSA restoration if substream runtime is uninitialized
Date: Tue, 24 Sep 2024 14:25:44 +0300
Message-ID: <20240924112542.78321-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZvJ_ZFpIiRpD_uzO@finisterre.sirena.org.uk>
References: <ZvJ_ZFpIiRpD_uzO@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On 24.09.2024 11:59, Mark Brown wrote:
> 
> 
> On Tue, Sep 24, 2024 at 11:12:38AM +0300, Andrei Simion wrote:
> 
>> Update the driver to prevent alsa-restore.service from failing when
>> reading data from /var/lib/alsa/asound.state at boot. Ensure that the
>> restoration of ALSA mixer configurations is skipped if substream->runtime
>> is NULL.
>> +++ b/sound/soc/atmel/mchp-pdmc.c
>> @@ -302,6 +302,9 @@ static int mchp_pdmc_chmap_ctl_put(struct snd_kcontrol *kcontrol,
>>	if (!substream)
>>		return -ENODEV;
>>
>> +	if (!substream->runtime)
>> +		return 0; /* just for avoiding error from alsactl restore */
>> +
> This then means that control writes are just discarded which presumably
> is going to upset things if they actually saved a value here.  Why is
> that a good choice, rather than either fixing the race so the card
> doesn't come up too early or removing the need for the runtime?

Ok. I understand. My first intention was to follow the
https://github.com/torvalds/linux/blob/master/sound/hda/hdmi_chmap.c#L794
but after your point of view, I intend to return -EAGAIN in V2
to specify the substream->runtime is not ready.

I retested: configured pdmc, then reboot the board and the configuration:
as a result the configuration kept.

alsa-restore.service status success.

Do you think this solution is enough?

Thank you and best regards,
Andrei Simion

