Return-Path: <linux-kernel+bounces-315468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E8096C30B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9881C24A03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83C1E4137;
	Wed,  4 Sep 2024 15:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS8ay/0S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471801E412D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725465092; cv=none; b=Xb4rUebiGeJP56ZVMo1M5bH+Vm1Nyhepe+Gpg5St2vNyGShNaCq4wH7hAHDjJ9NUYiW2w8NPcAB8Xziy7kOwL4NmctMK18cjVJu3oyt44/ipEgWBlDYhsWohC9ayLkqF7j5PD7tuG76P+dQldqemZmXEGktac3iCW/3PbwIkf10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725465092; c=relaxed/simple;
	bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sUpuyzFuKPDb6OVLs8fqlaSy55fUrZL8l1ZRtE8RE7lTPCzufeUEQYHbMWb2EoulxRlB+XCNKnpDf3G2P14wa2a6P1t7AJpoa4YK3ZpBJskiJnkIHM7GlA+IeZw3qvkvs3TnvLgxVFNx50e863/nNkE888xd5e2YOttOGSTKo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS8ay/0S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725465090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
	b=JS8ay/0SU+4aqJti0/KIoqZmxxW/l2fWrJW0aXvF2zsEvJY7N39BAKa8iqw67rXmZuq8fT
	K9QmFNgyEfGoGGOGVPPGBa3dGu4z2HoKv2uXF9s+lVNuBz8CE7ZfcCQDX0YrtoVVlxTWc/
	Yr7YHoemwfuMnaLCyxGDGfaM4c4pVuA=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-FYWQwMmLPEKEhaP3WEbQsw-1; Wed, 04 Sep 2024 11:51:29 -0400
X-MC-Unique: FYWQwMmLPEKEhaP3WEbQsw-1
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-4fce6e3067bso2597097e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 08:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725465089; x=1726069889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76uG9nA5Z2kXAd2nlaY3PPD7K/CyxDqr0+DKOaLWywU=;
        b=FfPSK4TF4U0MqPVMH14EBFmEQoineQlaLbGuitvAA+U/UIb6PiEro4/DsHbwpGXtr5
         UuxacQRidiHtj8J6MNllfxoUkgdCFfynacK2YOpFT0BJXaObGb8jkJP8dHVcg/rPG8Bd
         whvkPCF/+Oy97hNVHyQ+zskxFzOb/Wenpr9uMkwhdLDbuhIr6lYyKFIDlMI2iWr9Xz4u
         DjQbwS20IxebwE1nqWSq9VtRHwFykbhmaGpGKHzH2tSwmDbzF6NZx0VWhInc7fC2KW15
         AgBXdpV2hmixNHc4ZEboRyKQDfVak6LE02PAaH+r1bFIPG5aGyaX4XKEf/HBnWsrrjMj
         mOLA==
X-Forwarded-Encrypted: i=1; AJvYcCUOtWwp4U3CG+R56F3Ckp5aFxp6RMOGdlCuJjYTGrxreQBtN0p1lubnk6YzO2aAHSEKwLSx5zIJTsuWjkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiiJAhZ8EgvNW9YgqXNhwmN9y0Kl6CWYc336Y/kDgiHef+Ddi
	2PTzbm6eEjeKIUgZsxWWkUpwBZlLP41twWeROgj7pP2i6ex8cAQtXlDht7+yieX7ubmmspB5pRz
	brLk7aDyZlzNAO9iZLhNFw8rnndcrHJrWKJVA4haWknDFshYS0UPuSqPxCe7fdlXTQdSce8+UIj
	U=
X-Received: by 2002:a05:6122:411b:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-500aad4a345mr13917541e0c.6.1725465088653;
        Wed, 04 Sep 2024 08:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6DuFNQkzu/koNhZpY20gpJZ5XX5BKL3S/FjTMXEDCyB3q8D3zZLHyV2mW6t2xJyy7IgmqHQ==
X-Received: by 2002:a05:6122:411b:b0:4f3:828:7a47 with SMTP id 71dfb90a1353d-500aad4a345mr13917520e0c.6.1725465088242;
        Wed, 04 Sep 2024 08:51:28 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.133.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d61b5asm635774585a.110.2024.09.04.08.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:51:27 -0700 (PDT)
Message-ID: <cff6d1fcd3331574a5189737f1f58774882649fe.camel@redhat.com>
Subject: Re: [PATCH] um: kunit: resolve missing prototypes warning
From: Gabriele Monaco <gmonaco@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>, Arnd Bergmann
 <arnd@arndb.de>,  linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>,  Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, Richard
 Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Date: Wed, 04 Sep 2024 17:51:20 +0200
In-Reply-To: <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
References: <20240904135019.200756-1-gmonaco@redhat.com>
	 <942a2aa5fc93f6dc1bc88b3b25e59b044a7a425f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


First of all, thanks for the quick reply

> I get that you have this on kunit on ARCH=3Dum, but that makes it
> neither
> a kunit nor a um patch :)

Well, yes I wasn't entirely sure how to put it, sure people from
UM/KUnit know what this is about, but I agree perhaps the patch title
can be a bit misleading.

> Arnd had originally wanted to fix this another way, but that got
> dropped. I don't know if this fix is right, though I can see that it
> works. I have the same workaround in my tree, but I'm really not
> convinced that it doesn't have side-effects on other architectures.

I thought about doing it differently, perhaps using an additional
header file or even re-arranging the macro dependency, this seemed to
me the easiest and perhaps less risky for other architectures, but I
get the concerns.

I could perform some further analyses building it for multiple targets
(besides _it builds_ I mean), if you have anything specific in mind.

Gabriele


