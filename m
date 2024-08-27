Return-Path: <linux-kernel+bounces-302529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A695FFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C761B217F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C74286A3;
	Tue, 27 Aug 2024 03:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DXUCWhIW"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6725E3232;
	Tue, 27 Aug 2024 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729467; cv=none; b=phwjfjNyI7bjPvpdbb/oYb9+w8KFNb2XCcTahxMqjso2fXTXwZQLIRl7Vyj0cdqb1SvFQH2BEpxGNtQAT9N7LR9953ygHX6tGoqMVAXuEf/xbk0r/KbQ7fzqAVELMP0OgN7qSfzM9CER4ct3bdVCTAN0dMywLnpwWYTGOvx+XXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729467; c=relaxed/simple;
	bh=pdEyDHiUewDTYCXKOReuxFYlYTCvVNEK8XdDRwlXMho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Om4h0xxkpxsVCNaxvnsmKMLhRwGDrM+N1+sImyk2jLmoZuvfxWHB9bRuG/+MQxtMR0DH83PNoFT6Yu4GshZaKw/TbnslDAFstd2OpofwzgYyzLWv536zAbdP0eMc//Vsd34X6/4j2AkcLwsprryiG1h6tAFW4PdMmSyCq1fikK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DXUCWhIW; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vPC0a
	v8885Eqk/XJsUnGb3mosbXQZFoAH9c7bSZMNbI=; b=DXUCWhIWkGHlEpJatfQpj
	4/Qv401XUT0lJ6CX8Ox0S22H9RnVEsU0kGJ0VorZNMe/963dQs43WJQeErnlKZ/C
	Dl61h2ny1a0RfAj84N4rJ+tORQQmvLt8kqkpjfvwXlW/TdHyyIPh107ejxxNGdIW
	eH80osNJ3E93Q3uxcGNZgg=
Received: from localhost.localdomain (unknown [111.48.69.245])
	by gzsmtp3 (Coremail) with SMTP id sigvCgAXreFjSM1mFL0CAA--.640S2;
	Tue, 27 Aug 2024 11:30:44 +0800 (CST)
From: soxiebing <soxiebing@163.com>
To: tiwai@suse.de
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: fix snd_hda_bus_reset when single_cmd is not supported
Date: Tue, 27 Aug 2024 11:30:43 +0800
Message-Id: <20240827033043.107572-1-soxiebing@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821014238.338864-1-soxiebing@163.com>
References: <20240821014238.338864-1-soxiebing@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:sigvCgAXreFjSM1mFL0CAA--.640S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry7Xr47WrykAryrtr1DJrb_yoW8WF17pr
	WrG3Z3Krs5Jr1xKFZa9wsYyryjyayayrW5XFn8JryUC3s8JFn5tr4UWrWYgasrAryxurn0
	vF4jgay29w1UZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR7rchUUUUU=
X-CM-SenderInfo: 5vr0xvpelqwqqrwthudrp/1tbiRARIw2VOEdGPLgAAsB

>On Mon, 26 Aug 2024 11:19:58 +0200,
>soxiebing wrote:
>> 
>> >On Wed, 21 Aug 2024 03:42:38 +0200,
>> >soxiebing wrote:
>> >> 
>> >> From: songxiebing <songxiebing@kylinos.cn>
>> >> 
>> >> When an azx_get_desponse timeout occurs, ensure that bus_reset
>> >> can be used when fallback_to_single_cmd is not supported.
>> >> 
>> >> Signed-off-by: songxiebing <songxiebing@kylinos.cn>
>> >
>> >Why do you need to change?  Does it fix any real problem you faced?
>> 
>> Thanks for reply, i am testing all these days, but the problem is
>> still exists even if using bus reset.
>>
>> The problem i encountered is that hda_call_codec_resume returned 
>> timeout of 120 seconds(defined CONFIG_DPM_WATCHDOG)) when doing s4, 
>> azx_get_response timeout occured, it is a low probability event.
>> 
>> To avoid exceeding 120s, can i change the count value to 3 in 
>> hda_set_power_state ?
>
>So the change you suggested isn't for any real "fix" but to allow the
>possible workaround with single_cmd to be applicable somehow in a
>different form.  Then we should rather try debugging the original
>issue, instead of change it.
>
>Does the response timeout happen *during* the S4 suspend, or during S4
>resume, or after S4 resume?
>
>To be noted, the behavior you changed is only for the single_cmd
>option is set explicitly, so it's more or less the designed behavior,
>and I don't think it's good to change blindly.

The timeout happen during S4 resume. 

In hda_set_power_state function, the count value setting at most 10 times,
i feel like there are a lot of retries, can we change it to 3 times, to avoid
exceeding 120s ?

thanks,

soxiebing


