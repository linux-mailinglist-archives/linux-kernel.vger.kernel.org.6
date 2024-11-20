Return-Path: <linux-kernel+bounces-415866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBAC9D3D99
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055ACB2DFB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77111B0105;
	Wed, 20 Nov 2024 14:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XniGTXcX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1481684B0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732111900; cv=none; b=cVydcCfddiKQcfUtphmv3KMPY0SDhEy9iw7rTnz0ssPmA1MvktvrIhFZLHtU44CxHbgwnzAP2Vi6hQxsks6+9gWDA5Ptit8whxrpiwk02JBqUkA22iEfk4MwrQbe9qvnrYlk75g67P4oFTR6TMSsWKKHZuakxM2jymqoCc58bZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732111900; c=relaxed/simple;
	bh=FfUNXLNLMYAUKNxyY8yLvAOSk6II0QVXiht1oJ/aXwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ax53YtgylPiba0me7M4S3JIjhpJt8G6PUsJrUSAXuGc8TFjH6cBsjV7y/2WTGYz4Rtonz5aTspfJrcMWkK23OrQCMs3byr5N5WwvPsuSZUCDIPsPDD4X1KM3CuUop1jM7hsjMggZy1NVPBJpTXL83Quip7zx+CX4MMadYbjTx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XniGTXcX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732111897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1HheHXxH2Lq66Pb3UAs+ct3ExAz5ElR999iJ69jx0Q=;
	b=XniGTXcXE6ofL7xAVKM+7HsySRB7eZxoSwv4Epqkxhh8yOSFBJo6pAIMnK7MGHjun0Ubiv
	s58swN52YTw6LplqpmEcVRn7UhdB1ovFJHrKrfj0euPPKp6rJmNPZ50LIuGYyuAMhQpwz/
	1Z0etwSnCUZPI2OF1dJLv/cnm92KQyY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Wju3ulSiM8mqhVfYCdebvA-1; Wed, 20 Nov 2024 09:11:36 -0500
X-MC-Unique: Wju3ulSiM8mqhVfYCdebvA-1
X-Mimecast-MFC-AGG-ID: Wju3ulSiM8mqhVfYCdebvA
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5cfc97dade6so1623498a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 06:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732111895; x=1732716695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1HheHXxH2Lq66Pb3UAs+ct3ExAz5ElR999iJ69jx0Q=;
        b=MmfAXDGoGyLmrxIsnDCr5aG6Y+b+twcLO4b04KOh1foMlR3ZRNEi4xnZyp/vaUpJh2
         g2hFqqK+Hko0Esn+NA2WwuD7YMJnPqumPZpzTUQx6RPIcEsJHTglNG0UcXcXX/hKktdx
         hKJ25WuwT9BLQ8wH67jCCULWHPMkY8QBQ1E5h+liJexi0YjZloSvtgc1i3LAv3PNDURl
         xM+cKX/GgpL3dLX8cvLLPVC5mI3zBz2gV9ZhERmAqziKkS4jp6FEPI9viRSCeI65MKK0
         FkOQ8dQNRRnPh+cnhH2zhQptFMTQAQpEjyfsJlRpZq3AtpkXlulR1ZWfMD22TA+FJFSf
         QRPA==
X-Forwarded-Encrypted: i=1; AJvYcCWY2yrG+qiJPRgp116t8vUxkRKGEXezMg3HsSgqEpUikxQtyw3konxj9yqzjhjKKksXta7jenEauF48qJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyCDDj3IYzYEMQaVus5Wpeb6UFf0bMFmEkwCvCDMCsvyI/z4m
	KuciJX5PcOgC9Ul6qQbaz+ZSxhOPSKovMFWcXS2pCbHSkWS6VNWbs2+xx807AvGBlAjB3SmF+BK
	p2UNNKKNaxO8zj075WBnErPJwiaT/y7bYuSAIDd+WIsa8Sxdo/+iizOy4SRjryA==
X-Received: by 2002:a17:907:971d:b0:a99:c9a4:a4d5 with SMTP id a640c23a62f3a-aa4dd57cf5amr307473866b.29.1732111895283;
        Wed, 20 Nov 2024 06:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElPsBJusCgQQSy0/ZUamPrIprvapmeW+J3BVJ72fqi1ZqWyGC3oczhgmzOu6DsZlUvs2u7Bw==
X-Received: by 2002:a17:907:971d:b0:a99:c9a4:a4d5 with SMTP id a640c23a62f3a-aa4dd57cf5amr307470466b.29.1732111894916;
        Wed, 20 Nov 2024 06:11:34 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dfffcd4sm774935966b.98.2024.11.20.06.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 06:11:34 -0800 (PST)
Message-ID: <bcb447bc-0de2-4c74-8e17-6b0eb186da70@redhat.com>
Date: Wed, 20 Nov 2024 15:11:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] module: Block modules by Tuxedo from accessing GPL
 symbols
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>
Cc: Werner Sembach <wse@tuxedocomputers.com>, tux@tuxedocomputers.com,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Leemhuis <linux@leemhuis.info>
References: <20241114103133.547032-4-ukleinek@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241114103133.547032-4-ukleinek@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi All,

On 14-Nov-24 11:31 AM, Uwe Kleine-König wrote:
> Hello,
> 
> the kernel modules provided by Tuxedo on
> https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers
> are licensed under GPLv3 or later. This is incompatible with the
> kernel's license and so makes it impossible for distributions and other
> third parties to support these at least in pre-compiled form and so
> limits user experience and the possibilities to work on mainlining these
> drivers.
> 
> This incompatibility is created on purpose to control the upstream
> process. See https://fosstodon.org/@kernellogger/113423314337991594 for
> a nice summary of the situation and some further links about the issue.
> 
> Note that the pull request that fixed the MODULE_LICENSE invocations to
> stop claiming GPL(v2) compatibility was accepted and then immediately
> reverted "for the time being until the legal stuff is sorted out"
> (https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/commit/a8c09b6c2ce6393fe39d8652d133af9f06cfb427).

I know I'm a bit late to this discussion.

Still I want to point out that Tuxedo and especially Werner has
always been a good upstream actor and I do not believe that they
are operating in bad faith here, but rather that the GPL v3
licensing is just an unfortunate mistake which is hard to fix
after the fact.

As maintainer of drivers/platform/x86 I have worked quite a bit
with Tuxedo/Werner and their contributions there are much
appreciated. They have also helped a lot with sorting out issues
with the PS/2 keyboard driver on Clevo barebones covering not
only their own models but all models and helping out with cleaning
up the quirk code there which was getting a bit messy.

Also as you know Werner has already relicensed  all the out of tree
drivers which Tuxedo could easily relicense to GPL v2 to GPL v2.

TL;DR: I do not believe that Tuxedo/Werner are acting in bad
faith here and IMHO it would be good to give them some leeway
here while they sort this out.

Regards,

Hans



