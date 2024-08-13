Return-Path: <linux-kernel+bounces-285404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C666950D03
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016061F256BB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01761A3BD6;
	Tue, 13 Aug 2024 19:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJcBxzHA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8719CD00
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576693; cv=none; b=kqY7M4MKDbBfrD1hOYsEYxBSAkJ38ik6zfK53c4bcVGDtF7AhnQcvyFquoC5MtrBHxvnJs9OYD0E6rBY+7Z6/w70Icx+dS9GKnqZwOopL5QDNsc/4KSgjMEzVMDROk5WlcA08MVe1I2yiI8IwRIQcmftuPcd9KPCUydkwWTUwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576693; c=relaxed/simple;
	bh=J/7f+bc9NmdSfhFyguy4I3TTRwUcHRQu6/PwycSGG5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vc9jvTFYy4VLmKtxkySeKpxEuA6fBQFJ3gQeWw396wJ7jAEoJCHAUOY/+ypgRJ2fO026Ie2vXb4VrqXaarMromYqQtathpogZoZm5/HlPVpvKoNPFbN9UMYfIlrgWJMXrlRdC4xbImZrH8ht0OuSjnAqslQS3sI5m6FQm8Ws3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UJcBxzHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723576691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqBAn7A/SORxl/E+//yz9lAkEvT4ewR8zL8GXdVNf8k=;
	b=UJcBxzHAE3pSRDZHXwtxUjNRnYAoap6bejF+bPyRjj1NnEaVs5J3qu3ltoY4GWg0SpbYeA
	FjLog788JJK/EaqOeLCh3Jhw30nlVj3NL5SunkNIhFYjsR8omP/vAIzvCqs7e65d4fq63B
	6Pn0+AJbiZ7E7TaMggxKn0yyMq4lYRg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-fw7Wqma1MwaI-8NDYYv4UQ-1; Tue, 13 Aug 2024 15:18:09 -0400
X-MC-Unique: fw7Wqma1MwaI-8NDYYv4UQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f9612b44fso763634439f.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576689; x=1724181489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqBAn7A/SORxl/E+//yz9lAkEvT4ewR8zL8GXdVNf8k=;
        b=s820eKomkeMHgJvwSjo57HkR9INTEzmcTsfNvyyUH39mV82srrAkbcrK0xZwAJM+hb
         TSOiym6wMW20el9lAwsvH77UzALrBnhZS/XELAIrUM7pdgFyUdMGt9GCFr9y/gnntZAL
         sp4/aFkQGPSDMgqwRHRbsiQwaC4vSwtxi9TCNF6WK4lmqzmtqTN4jj1oM4gyz1UXkm3w
         +BYRN+2gbMesN8yelp+WnmU+cRVl2AcnEnRmN7sU5kiIN6RgUvb4exOM5B63cwEByvjR
         N2CFDJvDY2WLTEy0CKWrSjcJ/VTZssD3SJZyvgMhHXSIyQHNFSwMjs8bxMw3njC5PF6v
         MHFw==
X-Forwarded-Encrypted: i=1; AJvYcCVzNNBtQXCq6JN3RZLmF0bKxp93tar2Cu2wImlxmuya8a5njISDD6VMDfctAcXekhWWrhRiM0waAFxnZh6QFWJgxFmaBUU3BzVt+3Dc
X-Gm-Message-State: AOJu0YxVzW1ExmyXaZ5noucpk9iCSvlqNCB6YrdeTEWenNS473uG5sqn
	2Q6t49FLN2MdDSu0HhhrWTA/x3djRw+HCxiR0gUtF8ub6J8O5vupOdo+kvRusKJQE1RiTJfcMHo
	NBkKXkplTYpgk3Yx8zgxiv0ICEvyC/gfhPu3kPjt4EsEnvMoL66jLySTctd0FCw==
X-Received: by 2002:a05:6602:6b08:b0:81f:bcd2:24e with SMTP id ca18e2360f4ac-824dacff207mr64100139f.9.1723576688821;
        Tue, 13 Aug 2024 12:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwwof9f8qA/sn+YUSjzIomGUCxCuhfKOgve8kLwDVFC2q2nZl23gWPVS3a41EDgIKaC2T95w==
X-Received: by 2002:a05:6602:6b08:b0:81f:bcd2:24e with SMTP id ca18e2360f4ac-824dacff207mr64097839f.9.1723576688430;
        Tue, 13 Aug 2024 12:18:08 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769105cbsm2650065173.27.2024.08.13.12.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 12:18:08 -0700 (PDT)
Message-ID: <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
Date: Tue, 13 Aug 2024 14:18:07 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
 <2024081303-bakery-rewash-4c1a@gregkh>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <2024081303-bakery-rewash-4c1a@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/24 4:54 AM, Greg Kroah-Hartman wrote:
> On Sat, Aug 10, 2024 at 01:25:27PM -0600, Marc Aurèle La France wrote:
>> After its conversion to the new mount API, debugfs displays "none" in
>> /proc/mounts instead of the actual source.  Fix this by recognising its
>> "source" mount option.
>>
>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
>> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
>> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
> 
> As this came from a fs tree, I'll let the vfs maintainer take it if they
> think it is ok as I know nothing about the fs_parse stuff at the moment,
> sorry.

Hm, I guess this is OK, though it seems a little unexpected for debugfs
to have to parse the trivial internal "source" option.

This actually worked OK until

0c07c273a5fe debugfs: continue to ignore unknown mount options

but after that commit, debugfs claims to parse "source" successfully even
though it has not. So really, it Fixes: that commit, not the original
conversion.

I'm not sure of a better approach offhand, but maybe a comment about why
Opt_source exists in debugfs would help future readers?

Thanks,
-Eric


> greg k-h
> 


