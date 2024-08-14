Return-Path: <linux-kernel+bounces-286740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF8D951E6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114EEB29DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC51B3F33;
	Wed, 14 Aug 2024 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxF4c5wF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20081B1436
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648819; cv=none; b=uTtNlNF++IkySun/ymFATTTgEn6DxFpfJ6AVD92GjwFDkIyZ9LOr2wSEW8aLwFNhc+XmkDYcYtTzPNp0nTkxH4ECv1dGZWeETBXNo0IJ5w5iR2ncm1mUmqv5OGJ4ze08xIM3d0bnd88L4Z9+wD4tkldMkUqQDZ89RpfziIEtIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648819; c=relaxed/simple;
	bh=cZK+9CiAPfSWI38eL1UoH/fsIcbJXE6qt2DT35KGH2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFZv3ZsQj9/yDH6H/jpALjyKlNelLBHkjVt1tlKoSihQ2Qx79xzCXhxlDgb/ngNZ8Rm2Y08zcpEbwMeACqUZHhve2CuaC7qoBn7xE9e9f3uxklDs6jG8TGkGEaOYaNmT4/8jNOwjcGkwbHv7T9eTVX2VryaUgQYdnAdW21YgjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxF4c5wF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723648816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulPWnhLOoIH41QmEJRRe4Hlw46FJXyZOpi4bOVSTk24=;
	b=RxF4c5wFdfz9Af/C5bSeb7eLgPrvT5rY/Qfp+ibk4NRFX+nAeRfocf6eD0lMJbC3oGu9B/
	MOiAPmvdjbqd88es6gWFveCIJgXsLmUQyj3ymuPjqBR2OySrNOFx5XVjYt/6uhy3YcVD4d
	hhjV3LgrUook5yV6OJBxbPIl9cKhoG0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-8y7Df5g8OJS-YGGyk4ZJFQ-1; Wed, 14 Aug 2024 11:20:12 -0400
X-MC-Unique: 8y7Df5g8OJS-YGGyk4ZJFQ-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f9612b44fso3965939f.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723648811; x=1724253611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ulPWnhLOoIH41QmEJRRe4Hlw46FJXyZOpi4bOVSTk24=;
        b=vGc35VehzlWdizQMgW1kwka3U6qu/OenAymNRHzJAwE5EsXUTjtQVovO3oIs0BDsqJ
         o+bSxWfpQ3DIcQDbhaixw0o1Xu0ca8IBzSuL2Y8048Q6TbSsctgk1MfCk1Okh6mREZiT
         WM8OZFHQfOgMOgHsVXLOBqrU0W8MQ517DaV29pvzx/fZB6dbmX7MZ9/bmQILFwjbWs8W
         PdI2RSeUSVtl3ESPHKPHO0eCnqVjeC7pKk8RIOuvlr5pBi/3QCuGHZEmQkNl+U2/ayNk
         GNUX7kF5wlvFPoDdReEotoNFmzhTbMJ8KQ83vki6KlPJpM8GPncXSpxKo0b9U+McaEJz
         x1+g==
X-Forwarded-Encrypted: i=1; AJvYcCUjjD9p9qJ66kit0mHvLeI/Bjlo658/qM9762++3p5wy3pqrs8jNa4dDsejKC/qOxalwOUV/tNq1hOddUpgjFamqzorJbHojBMNKB+S
X-Gm-Message-State: AOJu0Yx6Zb9FXDAj5qC8ZoPbLfMU5/tsYShbAwVXJmDMfUpvvxYnmhSe
	SaTXACaGQQXr8PvI+FZKvkgekCKwkcogRcc0isc0X+2FsFJvjdDfLUSYOOPPCDD1AhYdyt70sf5
	a8NrlAEjgShuHDE+amI+BGzfzhmaxKeiFX54nI8EZX0aAFpexoo8zrj2gnwK/SA==
X-Received: by 2002:a05:6602:148e:b0:81f:8c39:2a5c with SMTP id ca18e2360f4ac-824dad7c882mr456810939f.12.1723648811307;
        Wed, 14 Aug 2024 08:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIFIwdzTSsvM89TIZZFFOfNfZzwnpB58q4eedX39fD7qNtwWxQ6h8Zt0cR3/3jDiwyMrRATw==
X-Received: by 2002:a05:6602:148e:b0:81f:8c39:2a5c with SMTP id ca18e2360f4ac-824dad7c882mr456808039f.12.1723648810945;
        Wed, 14 Aug 2024 08:20:10 -0700 (PDT)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca76a01356sm3258226173.88.2024.08.14.08.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 08:20:10 -0700 (PDT)
Message-ID: <48c5e8bb-2f65-41ee-b9ce-f31b2997b751@redhat.com>
Date: Wed, 14 Aug 2024 10:20:09 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs show actual source in /proc/mounts
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>,
 linux-kernel@vger.kernel.org
References: <e439fae2-01da-234b-75b9-2a7951671e27@tuyoix.net>
 <2024081303-bakery-rewash-4c1a@gregkh>
 <0798a2cf-b43b-4c17-94a0-142314d80f5b@redhat.com>
 <2024081417-husked-unfair-172c@gregkh>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <2024081417-husked-unfair-172c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/24 11:50 PM, Greg Kroah-Hartman wrote:
> On Tue, Aug 13, 2024 at 02:18:07PM -0500, Eric Sandeen wrote:
>> On 8/13/24 4:54 AM, Greg Kroah-Hartman wrote:
>>> On Sat, Aug 10, 2024 at 01:25:27PM -0600, Marc Aurèle La France wrote:
>>>> After its conversion to the new mount API, debugfs displays "none" in
>>>> /proc/mounts instead of the actual source.  Fix this by recognising its
>>>> "source" mount option.
>>>>
>>>> Signed-off-by: Marc Aurèle La France <tsi@tuyoix.net>
>>>> Fixes: a20971c18752 ("vfs: Convert debugfs to use the new mount API")
>>>> Cc: stable@vger.kernel.org # 6.10.x: 9f111059e725: fs_parse: add uid & gid option option parsing helpers
>>>> Cc: stable@vger.kernel.org # 6.10.x: 49abee5991e1: debugfs: Convert to new uid/gid option parsing helpers
>>>
>>> As this came from a fs tree, I'll let the vfs maintainer take it if they
>>> think it is ok as I know nothing about the fs_parse stuff at the moment,
>>> sorry.
>>
>> Hm, I guess this is OK, though it seems a little unexpected for debugfs
>> to have to parse the trivial internal "source" option.
>>
>> This actually worked OK until
>>
>> 0c07c273a5fe debugfs: continue to ignore unknown mount options
>>
>> but after that commit, debugfs claims to parse "source" successfully even
>> though it has not. So really, it Fixes: that commit, not the original
>> conversion.
>>
>> I'm not sure of a better approach offhand, but maybe a comment about why
>> Opt_source exists in debugfs would help future readers?
> 
> Why is debugfs unique here?  Why does it need to do something that
> nothing else needs to do (like sysfs or tracefs or anything else...)

It's kind of a long sad story.

Originally, debugfs took no mount options. And because it had no mount option
handling, it had nowhere to reject anything, and so any/all random options
were silently accepted and ignored.

Then mode/uid/gid mount options were added to it in 2012 with:

d6e486868cde debugfs: add mode, uid and gid options

and it continued to ignore unknown options:

+               /*
+                * We might like to report bad mount options here;
+                * but traditionally debugfs has ignored all mount options
+                */

A decade+ later, I forward-ported dhowells' mount API conversion with

a20971c18752 vfs: Convert debugfs to use the new mount API

after some discussion and agreement that we really should be rejecting
unknown options, and all seemed well until ...

https://lore.kernel.org/linux-kernel/20240527100618.np2wqiw5mz7as3vk@ninjato/T/

it was reported that busybox was (incorrectly) passing in "auto" and "noauto"
from fstab during mount, and thus failing. So, 

0c07c273a5fe debugfs: continue to ignore unknown mount options

got merged to re-allow/re-ignore all unknown options in the spirit of "don't
break userspace". All unknown options were re-ignored including, as it turns
out, "source" which then led to the current reported problem.

As for why it's different from tracefs, that's a good question. Tracefs was
cut-n-pasted from debugfs, and had the "ignore unknown options" behavior from
day one, which in retrospect was probably a mistake. And now its behavior
does differ from debugfs, but nobody has reported the busybox problem against
it, I guess. This is an inconsistency.

sysfs has no ->parse_param at all, so vfs_parse_fs_param() falls into the:

        /* If the filesystem doesn't take any arguments, give it the
         * default handling of source.
         */
        ret = vfs_parse_fs_param_source(fc, param);

case which handles the internal "source" argument just fine.

-Eric 





