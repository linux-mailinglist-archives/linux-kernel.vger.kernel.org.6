Return-Path: <linux-kernel+bounces-362752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D7A99B8FF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 11:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60525B21565
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 09:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9513BACB;
	Sun, 13 Oct 2024 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="FWpAQ3n/"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF847804;
	Sun, 13 Oct 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728813265; cv=none; b=CgSa9PKjF+jNwgY9/YGca+XxBkMJp8V+d83+swA10iZ87eQZKGyob7cyRFE+2SndyXy1UL3VE1OhBeQC/Njuejj4txIlL5OKS8xmcP/ZLqWYFr5/xleOyp1HzHnjaVxnJ8NLq+l1EPr7lIkGlkoP/2Y+7VMyZo9qKnScPCC0jdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728813265; c=relaxed/simple;
	bh=OJ5AhyLgRm7P2UuNNp3mRuuJI7IvSY7HTNsSc7zNEPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKNttktFOPZjDVTO2ApadOcK4u1JfJnTulSERedVQSOrwC2mT8t3cHowfU3GDYsaeTiwOxN9WOKpqbNABqJfLsHieNcci2yshTHOHv98KLzNklEV5dAXUCObOLFq/q4GvUnwtuc0vwlaimEqJ2jVnEQP/72cjz21UhBwlWHoMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=FWpAQ3n/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728813251; x=1729418051;
	i=oswald.buddenhagen@gmx.de;
	bh=vqeZVm15JugonPdtajp4jH6eT/ju9QoLRzHPHcnPjEA=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FWpAQ3n/NBw+0RLSgrUSXd0cyfh9tYsQrcYlDg9ZkLKG6OmXVgOwa5Mm0ixaGrcY
	 dUoJ/6pRkeDOJcOkWJSvbVe5e+MCLFbEiR0Uc1kMFeFYtwjJZaDOWjn+bSEhtSb27
	 M8XZc1cDwEA6kv5jpUKrcM+whuQhWq53rMpY1q9DXDxTtcf5/GsmlrBrQdsZS+Tfq
	 azUGjmWm+4exJXT7W/2jp6XfREN1ygpIIJMRyJUD2xl1VjOB3BCfHG/H5VOfitN1N
	 4xwRbeSAbPa9lR0VH8vw2SRuZcwMNKknpm8Pkmv2QONmIfSEZQThEu4ssLcw0VTUs
	 7+/wQTVmR9V7GLqH3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAh0-1tWm553FI8-00gPkw; Sun, 13
 Oct 2024 11:54:11 +0200
Received: by ugly.fritz.box (MasqMail 0.3.5-13-g85b6fce-plus, from userid 1000)
	id 1szvIh-Lqi-00; Sun, 13 Oct 2024 11:54:11 +0200
Date: Sun, 13 Oct 2024 11:54:11 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ALSA: emu10k1: add a capability bit for no MIDI
Message-ID: <ZwuYw27Y1YQy-DQJ@ugly>
References: <20241013014714.7686-1-uwu@icenowy.me>
 <20241013014714.7686-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241013014714.7686-2-uwu@icenowy.me>
X-Provags-ID: V03:K1:NuEU3kD24d9l3aRyLqs9wY99swTUS3wu9/T0+UNrdmN/kp+BDn7
 At0YP59XmSuZjsru7/NtgtBkp4T5Rji1gqdWAMJqed//iuohLdcw4qi3dh2MRgQU8Pt8dya
 TqpldtrzcwRIa3Z+fy0G/XLZuFI9PAtV5usx4MXS50uO1n8rfOwALVySVT6AXT0e/Qh6Nn6
 FnyJCcXEcmH6XdJGwl7fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KT7geH487rc=;oiqomaDc4TIErBF7A0Gi7/Lf+MJ
 cZ8yUvOHayUqzJwXbmc3MnoMHI5yu7w3IcOxVJXcVBt9A0IALSr+rlWpWOWwHvsPqrlz+ssUk
 i1kA8ltBbUgdVcLAL7fHqY/YmyF7ZgUDFR3d8PTitTGhD/wvLLqbE/DohdpcSkXvWyRCSby+3
 kV+YVhrkcUuVL5Gr627K5/xlgWeKg82rKOth9PKA7sa4KSX86Q+yvWJUMEmOzDN6VLFti4AlO
 jtYF32sV6AnLD3Mh3x7c19ctZdMhAKdUXkP5BYAQUc5dbJPnMOEcmn3qPpfYNGz/fEbCgelm3
 6N9iGeb7epvHRzfN640N0X4gDhaIYcAeEDPdIbC0JZDN6qGb5f/T5msAao9vsdYsJMV6R+Kv0
 RVgMv/V55IDr8uWbYSSgEPWfuAhMo4NP45ZEHfQT2Q2clFJOnJ7+iPC0Ha1LYzC+UXehZ3l0S
 8FnJc+gYx2bcy/tKyGDyZMGYYLhqiCogIt9gEb4aWLUal0/09HngQ3wWpMqNS1QQKtoYa0Tug
 ypVYBEJChWoKqJ6FC6a7qHCczDSkWTZX9DL05NQpf0v5VlQRzd1Qqu3R17eER6kfc0NGJ1q3v
 lig3VDelLdV2pv8Hb2wNvSv2mbFuPxs2ua0PGiTp4lMRWN4wU9mmzhaUsQUWDz3Lypj/WV6xW
 iNGMeqvx4uhgKMjGQ0d8Rj139VLCAFFcdSLKEgj0JBws5MhNbmtv4uieJyf26jKZs1UNoSmrz
 CGeddS3REzfufLb3cPI5xFubZrO2u9J04xNCJulB9GUe5YKmY8ssRCj28jGxnlItRwJXrPWub
 mulZzk+3VxH1Meqf8O8/JHfA==
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 09:47:12AM +0800, Icenowy Zheng wrote:
>+++ b/sound/pci/emu10k1/emu10k1.c
>@@ -133,7 +133,9 @@ static int snd_card_emu10k1_probe(struct pci_dev *pci=
,
> 		if (err < 0)
> 			return err;
> 	}
>-	if (emu->audigy) {
>+	if (emu->card_capabilities->no_midi) {
>+		dev_info(emu->card->dev, "Card has no ext. MIDI ports.\n");
>
seems like excess verbosity. there are much more important things that
are not reported.

>+	} else if (emu->audigy) {
>
i would eliminate that, and instead populate the card table properly.
that's a bit more code, but it's more uniform, and the resulting binary
is even a tiny bit smaller.

also, i would squash the patches, as i see no point in having them
separate, given their size.

regards

