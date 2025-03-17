Return-Path: <linux-kernel+bounces-564191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3A1A64FED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710B23B2970
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1704723A9BA;
	Mon, 17 Mar 2025 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpw8Ef9f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F400323814F
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216197; cv=none; b=OTvHPbB4+YpDZ/BUXNBKGdndk7gTp4HxlLOHwmNhfDk7hl9ZIz395KGDzrKd/LKb9Wu7OVlle5Gwqe8zRzqSRpy1OpSoeywv2KEYY5fn5WwTAd25nsspInKnc2dNgXqIPK6KzmC5PIpLvhUzyN+0VRtcwJawLjzAZTYfrB0rd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216197; c=relaxed/simple;
	bh=qhR+stvQyKNFKrc3dX73Q0Oj9bJ1GSmvzUPtxWmpD7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uzei5Yl6EglA+XUsFRhJseANb5iOwLg13A9DGXLMSvyHFgoVAOQ+bYr1YDTzb/uulpFmYGzI8yMFb+utEwa3A9dvBvSpBcaE3QF4Ubpnx7QzhmAo4uD6lHpg9W0t23HCkeJh5pptqmeJfNIfmvrSu1Js7diUS1UWohx/GdX5Hlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpw8Ef9f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742216194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pLLA8B7Q6RruRJ/SeEP0F06UuUK/GekT/XdbY6Zuva8=;
	b=dpw8Ef9fZMrNYIlqz5K7dGdJoS+7uFtQcPQgZDId4Sjlk4ccdU2o+aKI6mLF6GB16WjOGR
	7sZV1nVK/v7xUxmVXZJgcrxb76/F36vdhGBMI6RSGwsaJY55KTKkywRKWAieuveJzA1DAa
	2xTV0QHrUvMr08QEgNDC+gYP9TSyIe4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-re4lO5VlNM6jA31yTTMKWA-1; Mon, 17 Mar 2025 08:56:33 -0400
X-MC-Unique: re4lO5VlNM6jA31yTTMKWA-1
X-Mimecast-MFC-AGG-ID: re4lO5VlNM6jA31yTTMKWA_1742216192
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d01024089so17647645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 05:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742216192; x=1742820992;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLLA8B7Q6RruRJ/SeEP0F06UuUK/GekT/XdbY6Zuva8=;
        b=T23ZUFTDrmHI2UnmoD4PG0AgYq1n8oz38UG3nAZpOMyhANTUgLRvKN01vl3TpPcCO/
         C5XIq6VibvdnyskoBAxBf4zcL3l5rGbu19XD04ZmJ929/qrKazR5QLkN196qb0OPY+GH
         aRGKhMbe8N892Uq38G+8feZq5FDZPlWElf7Wgwc2c7DVy9IGmfZbPjCrxz5cyRtkbrSB
         AZbsMoP3us+4+nHYrAQKhijYiyVn3Vqlu41CJeReC7CkMWP5MUG3GSWqJ0BKF4BEfD2Q
         s3b7T+P1LPu4Wr9e+SJ9zT+SQefqVDOHQ3+rqTHsKoq4L+inWMjQkdtr+eg5uO0ir18s
         dYKA==
X-Forwarded-Encrypted: i=1; AJvYcCVMNlONlYUbev3lL1HGC9Z7GjsmGeeA30pzadkLpvX1aVhBrS3fe59jwxmlvdqhEr5AxHddTg3IalDyNBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzem1KugeTj5srauBp1FFt3CYfkRTc7dLkmxe6cEt+P0jrpP65C
	Tn8O/cmt2sVOZPmqCc6PPQqlNK+/6BAlSIUnYdWRgOm9EPKrp4a4iNQKhtsU/9PLkVylxJzqPiN
	4vYPH9C738gLlfcWvGfGp7xa76om9VN9+6J+DT+LSltIz4edb2xmJwbMiEhvVnA==
X-Gm-Gg: ASbGncv73JP5eTwindmnK1ezKGCGHgbGvUwBSW+iPFmV6PY/ui6mk1TSSyz3yVd4Ao0
	xQz7pD0+MWE3jEB/i4zC/kpMi7lsUOfldSQvvKuaAw34tPmjG1KDAk4p2KizqRtTqbTNVlbquff
	SFypQK7UX9DzrBK/ecmYq6g1/Nwm21bxb0iwjB6hRwc7eB+5jIWamo+rKAKQP8IzyPQ9rxyXEhm
	y4FMBsoAGJB3SEP6P5oJuVCrgnxmXgO4+jHoYisEqCLgUM2dDjt2b1DfoG1Mbg7QB6JBsxKoYwC
	AKjCTxtB1T5CSzmTmrJapi6T3wTltCWyjwr9NnZCqa5tAGV6cL8yv7qRP23mjFtjjmyQQxG5ow=
	=
X-Received: by 2002:adf:a189:0:b0:391:2a9a:4796 with SMTP id ffacd0b85a97d-3971e2ae2fdmr9145133f8f.18.1742216192259;
        Mon, 17 Mar 2025 05:56:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIpr8LRCQQZUxAWE1Jo22GeaEAUfQFRwAkofiJzd6KgF5dHT33ZaPc1Wl2+/7G725sqDyAdQ==
X-Received: by 2002:adf:a189:0:b0:391:2a9a:4796 with SMTP id ffacd0b85a97d-3971e2ae2fdmr9145110f8f.18.1742216191872;
        Mon, 17 Mar 2025 05:56:31 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda32fsm104214085e9.4.2025.03.17.05.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:56:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij
 <linus.walleij@linaro.org>, Yixun Lan <dlan@gentoo.org>, Conor Dooley
 <conor.dooley@microchip.com>
Cc: linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] pinctrl: spacemit: PINCTRL_SPACEMIT_K1 should not
 default to y unconditionally
In-Reply-To: <6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be>
References: <6881b8d1ad74ac780af8a974e604b5ef3f5d4aad.1742198691.git.geert+renesas@glider.be>
Date: Mon, 17 Mar 2025 13:56:29 +0100
Message-ID: <87msdjdddu.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

> Merely enabling compile-testing should not enable additional
> functionality.
>
> Fixes: 7ff4faba63571c51 ("pinctrl: spacemit: enable config option")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Indeed.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


