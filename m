Return-Path: <linux-kernel+bounces-248678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F70A92E080
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C47FE281C00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B0314039D;
	Thu, 11 Jul 2024 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="tta7f3F7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQtz1toS"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1C12FB1B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681174; cv=none; b=cuirMzvjYgT909h4Y6FtnphabslFp1Us2twuOuto/bBr10m1FqpFOsp9XN8dM5c1ocdI2xsNytnTVFQ9r4cBaYMYHanlJID7GW8p6eiHkzGMQji3Ng58wcPtKyxM1ZK5v2od9XEeRlP2tzb/y3WArqIE0hyHJYlJ1AYHtCD2Z1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681174; c=relaxed/simple;
	bh=FFTMK1OAQmr4qZpTunkAx+6uInH8DGVpHZRQBLgqlSE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=R4TtjObfwaHlq7vmQA9q+iHKvgHtDdXrQg/SoRj/1orUe7QD8iIPbzExi1qRRr0v4YOGXHi6cu4JFjW4h31kt1nj1UnGFkdb5a11boL+7FWXbAM7j0wtSG6F84M6sI1UMFoV7KZd3bwwQnWNF15ROkJgvN3SOfulnTR7ySdsUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=tta7f3F7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQtz1toS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0FA391381AA7;
	Thu, 11 Jul 2024 02:59:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 11 Jul 2024 02:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1720681171; x=1720767571; bh=cRH4kBulpD
	+Ku5DyPXskqeQ+64U41D0fNmXkMOJWR6U=; b=tta7f3F7MVcLfGBidqTidoISaY
	VvrIBQEcNOJu6mNdEyqmXdl1zvYRXKujSJ9qiQGZznPduGwOsLPm2YXnNxA52/Rh
	49IBs+eQwAhNnrJS8rKDkrWGngMLhOOYWcf9g7wQLg+qQPoYB52pLhH0GHnGXuFI
	7AP4rni78lhotF8OH0Ftzcm6U+p3qNG8UXnuvp2q6pU4Z9zgIy4nAHi3CiTJAUNi
	OJS6VGtlx9dXEksbe12LdMcHuJ0RzlhedFI6C6+/v+B4tPSNrZzlFKyixvilduiw
	1YeW1b4gBMVMSq6sbhqusdsDfLMbr3gvxgzWNL86l1YoiyzSUjqKaHFuh8hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720681171; x=1720767571; bh=cRH4kBulpD+Ku5DyPXskqeQ+64U4
	1D0fNmXkMOJWR6U=; b=DQtz1toSsyT/R+1lTr/sazz0f2pKxGyCgNTR0nXLz1pW
	b4pik/afwUxknwHG9z+H3PJuKdf82xskd7oHCPeZ5E8i25QL2M4WI/yeZX9kvPgC
	XpwDRJt+bGhv4e5BvDV6WC66czxYzsMXxdzR35PxMR/Sw5447ozj8r3WK/SZvjFr
	4vkE0MK9Oq/D637V33g+k8WaPYbQpgyCX0oFFukAM5e0b9KYsedWX6Eewh5M6VPq
	eSYNqwcrH19/JuCB0QMhZoO3RdAVVuJhmPEMv7uNydewGSJR8hVuayFC16XZ+1/w
	7rCsyl/bg/yWpLFFyY2suGXvaVgbMvV166HkUcJ0uQ==
X-ME-Sender: <xms:0YKPZghPV505NhDtBV9yMg1_lgSs5f6jlflyTy5Ro-xbu8K3DqoIBg>
    <xme:0YKPZpDyg4K5NWeRQ4tuJfxS6E933I-VTHRzqOZ47M4uSC51-Y8uvY3E_9yrjIEOH
    fEp84oiLsCost9l6dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrfeefgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0YKPZoH_O5JRv0KrdP_vlkRK4FjhgVep3zd0uLJwJA8NdrS-HW787A>
    <xmx:0YKPZhQc6diWBAY932PfSOWRo_Lw-z1vDBLE-Vn3juImQWoOdiZlvQ>
    <xmx:0YKPZtywLkFOwNHIyfmCMME_9NBRO2HClmw4wOxt6Vh4tbiGVEyfVw>
    <xmx:0YKPZv6RfQfiz2T_q59ceSlgXSFy6eEf9E_jQVowHCnar6OfEEgpkQ>
    <xmx:04KPZl_5OrZ0rgxcR1a3vo6tZJMvnD8dJiUeJmmkKx6D1u7PQ5XFD2E4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7BB09B6008D; Thu, 11 Jul 2024 02:59:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fac1e788-f05e-4885-802c-ec22daeeeee5@app.fastmail.com>
In-Reply-To: <20240710215238.799239-2-thorsten.blum@toblux.com>
References: <20240710215238.799239-2-thorsten.blum@toblux.com>
Date: Thu, 11 Jul 2024 08:59:09 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Thorsten Blum" <thorsten.blum@toblux.com>,
 "Clemens Ladisch" <clemens@ladisch.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hpet: Optimize local variable data type in hpet_alloc()
Content-Type: text/plain

On Wed, Jul 10, 2024, at 23:52, Thorsten Blum wrote:
> The local variable period uses at most 32 bits and can be a u32 instead
> of unsigned long. The upper 32 bits are all 0 after masking and right
> shifting cap by HPET_COUNTER_CLK_PERIOD_SHIFT and can be discarded.
>
> Since do_div() casts the divisor to u32 anyway, changing the data type
> of period to u32 also removes the following Coccinelle/coccicheck
> warning reported by do_div.cocci:
>
>   WARNING: do_div() does a 64-by-32 division, please consider using 
> div64_ul instead
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  drivers/char/hpet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
> index d51fc8321d41..bd68afa22cff 100644
> --- a/drivers/char/hpet.c
> +++ b/drivers/char/hpet.c
> @@ -784,7 +784,7 @@ int hpet_alloc(struct hpet_data *hdp)
>  	struct hpets *hpetp;
>  	struct hpet __iomem *hpet;
>  	static struct hpets *last;
> -	unsigned long period;
> +	u32 period;
>  	unsigned long long temp;

The change is sufficient to address the issue. I had another
look at this and came up with a different approach that
would also help readability:

--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -855,10 +855,9 @@ int hpet_alloc(struct hpet_data *hdp)
 
        period = (cap & HPET_COUNTER_CLK_PERIOD_MASK) >>
                HPET_COUNTER_CLK_PERIOD_SHIFT; /* fs, 10^-15 */
-       temp = 1000000000000000uLL; /* 10^15 femtoseconds per second */
-       temp += period >> 1; /* round */
-       do_div(temp, period);
-       hpetp->hp_tick_freq = temp; /* ticks per second */
+
+       /* femtosecond period to ticks per second */
+       hpetp->hp_tick_freq = div64_round(1000000000000000uLL, period);
 
        printk(KERN_INFO "hpet%d: at MMIO 0x%lx, IRQ%s",
                hpetp->hp_which, hdp->hd_phys_address,

This would also work by itself, or we could do both.
Clemens, any opinion?

     Arnd

