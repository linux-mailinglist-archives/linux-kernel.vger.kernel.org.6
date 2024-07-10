Return-Path: <linux-kernel+bounces-247206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411FF92CC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EAF1F246FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5507D84A57;
	Wed, 10 Jul 2024 08:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gdyX7l6z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E3482485
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720598853; cv=none; b=UmdtcjL2VpF3jVEZCt1lVMttTSl3+on7wQbeIE8TxE3XmJ+rOWmAsRlBYkQFZJOkr4YrjJB6LnAYNb/09I1sx39VkbSuiwZQgEJmR1Ruxo5f1oxGG2EGYGrE1D4GcCDwl0evqsrH+wF2jLo3PneeZ6PCX/6xbL9RG62ZzTmMqxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720598853; c=relaxed/simple;
	bh=FEbhogfEsTLrTHCnY7TKXRwi70W1BNgYKcv0tvCujYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKb9ZJGNkGJ/So1bbHsnsWowopIj0EkJ6DkHj1asjTv7OF+b57bqE31rBgXM0NbfWWhZ/tIdtSrw58A0KjDJIwfSmUIoltsKXms9IojvxlBx4VEQAw2SdhFd3JwZdqpgk69eQM/EP0xi4ioFk49UnKOGD+9PlCqPaQr4SMwZDHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gdyX7l6z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720598851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xHQwFNbnE9Dxnhgjr9tW3YFKUmm3yw0j9yYTKxOwX9o=;
	b=gdyX7l6zLbo5aHY+K/YVP+kwpZ1x59MvRt5GQdDfdiAjR6q0FP9w5FXFjP5FdeTfyjsbjM
	g8jIEavscNhTW8yE4vWzIYUheqmdfNo42bNcd3h0PjPPvH8+j0f9GZCEBmNHFy+UOMAfmR
	uCIaqnsi1/iuahll4wA0PjaRhX9juEI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-MN8euOOqOoWNizoAcm2foA-1; Wed, 10 Jul 2024 04:07:26 -0400
X-MC-Unique: MN8euOOqOoWNizoAcm2foA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a6f571c3eefso362736366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 01:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720598845; x=1721203645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHQwFNbnE9Dxnhgjr9tW3YFKUmm3yw0j9yYTKxOwX9o=;
        b=mL6uYovyNlqK+yEhBtm8jn0RA+Z56kAa+4RARPvULO0G5GGptYOoRc9CEok2EOWO0g
         HSJGjpIFo8NDaeQfVu5iW6V5hJ6UqiI22ocYeOvdZv93iuxyut+nk4LdPRZD1T6NGLYD
         nku8q1XygEKpcsfSoDKj4Xa4ql25/DHX+97fS9MZEnnIxTd4TKMV7MAHC3OLI1PdQHhf
         QuJKLamE1E/9lImlv6YY9BnjXqmmvpzQBM/j2s8DdJru/yYqwDB0gS7DMsUmGzyItIoU
         LRnhThK1LyG3yn3NV/rLd33+d4F9lwoAbdHlcVQsbIwAnXIHqc9iWxIhpTsaXTCvvXp6
         vT8g==
X-Gm-Message-State: AOJu0YzzuWjL6cVw8RlsLTHB0kJC0fbJUEBTJayb3GiZB+wijCSep7Vn
	QWYmNWHbSRgfRcMOsg5zItVImOgmj38Ih0DepXdyRavAjqHQxOnIoZXmWq52R+d0bqvDjksdyJt
	Zk7kTaHdXWMO0q9vWNQYcn6qBtLLGpvqLlkAghDKiX5W2WZ0UK4QbViVMW0K+4sMKyxJPsdR5
X-Received: by 2002:a17:907:94c5:b0:a72:6b08:ab24 with SMTP id a640c23a62f3a-a780b68a964mr413231766b.14.1720598845220;
        Wed, 10 Jul 2024 01:07:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf6dDTxwRNAfEJlHRXGRVbYJBGXexlxoaf8Tl0dNFnxms69TgHGlHeV0ZlKFpr+tIVRwc1uw==
X-Received: by 2002:a17:907:94c5:b0:a72:6b08:ab24 with SMTP id a640c23a62f3a-a780b68a964mr413229466b.14.1720598844877;
        Wed, 10 Jul 2024 01:07:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a855eb9sm136530466b.151.2024.07.10.01.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 01:07:24 -0700 (PDT)
Message-ID: <66a6aa98-009f-42c5-84dc-4c763d484472@redhat.com>
Date: Wed, 10 Jul 2024 10:07:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: manual merge of the battery tree with the leds-lj
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20240709133420.55645c59@canb.auug.org.au>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240709133420.55645c59@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Stephen,

On 7/9/24 5:34 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the battery tree got a conflict in:
> 
>   include/linux/leds.h
> 
> between commit:
> 
>   6b0d3355e5a5 ("leds: class: Add flag to avoid automatic renaming of LED devices")
> 
> from the leds-lj tree and commit:
> 
>   5607ca92e627 ("leds: core: Add led_mc_set_brightness() function")
> 
> from the battery tree.
> 
> I assume that the bit number valuse don;t actually matter, right?

Correct, which bit is used for which flag does not matter.

> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you.

Regards,

Hans



