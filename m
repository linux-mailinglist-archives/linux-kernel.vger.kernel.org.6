Return-Path: <linux-kernel+bounces-408647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE639C8175
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 04:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA2C281686
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 03:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988861E8854;
	Thu, 14 Nov 2024 03:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Npnd7a68"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E091E3DD8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 03:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731554641; cv=none; b=NdFV18kzsnNE/IkQnL7TZDUTvXASe9OEd1E1vw0NByyNASlKBJ0wvonBqFO4506ihscEF0lmtsS5+zGFR1A96ok8yXHWLEKkHGd3JnWLdaOA3ADWomwzFFOQytzXUUBAoPqicMHWrb568L/prC+cSPUMwH2dVfpLZSfUFkN6VNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731554641; c=relaxed/simple;
	bh=JgrV2Jq0SPELrPZSvyVQdJlx6L/sMyGDhRU2eXf0MZA=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=S3rikiCaufnbtGsGQMj4O7aRcgsFIoBX22cjFmIPprL6pnbMhnBflzzWqvB7+J5v37B/dt0YcYkgvP/BYFMd2h7+XX9alavZAQ0E7fxZojClVO4DE7+DQay4pnLredj3Swg9I6Whih+i/3s0tKyb0lpSaxsGCH//iWpZQX8VgJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Npnd7a68; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1601e853eso6586285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1731554639; x=1732159439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUpPj+dpybQGGOfSGoW27bPTzacoX7hU8r/cJFFobQk=;
        b=Npnd7a68omikY783X+WyIQ2z4iNQeO6vs+ZmrvxlrNsqS1zPZheYa5HGI1TfIzudq3
         ZFXWI5LojTKlygnFLw/0Z+Ee9iyDKaJVr3p9Yg3oDG6V9W5lZx8Yusj6/7p6GMdi0dFi
         ZtgoB6zzxou3jOMRCQ36HYAieYZMUxpTePAciQ6e8ohIomqaUUlKbu3PXzRC19WRfLyW
         +fbWL3YXzyJ8tQblwP0kQ8meRmVra5bRiPO1enQ/lpMcDA8Yfbu3jUfov72aXJk757Q0
         zylbt64GoTAu+qsOfGSZ9hJlw64lAoCf5+ggnSSX99AFDOgQsVhrJ+vGrSd5DJ1y+zzB
         iy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731554639; x=1732159439;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kUpPj+dpybQGGOfSGoW27bPTzacoX7hU8r/cJFFobQk=;
        b=r69t630UJQe1f4yRsRiU+bbJT0wEIURJwJh7mSnysiJLbBNiXN0qe2HebHDwxbd/0l
         iCBdy65X9jQ3YU/Oky8yZcV+iPr7HNo0SpHmwx0OX2Lblebk+Xw/7hCDc1T8VBsQucq1
         dU5Rj8nCHFiYUJihlCsWYY818q5AJZwT7jvVz1YO3wofn5e2sxKct/Gq/qeu56JY8Tlj
         IPm2zsAnC60oSIAM9i791LGTp9AiAf8yif6c28P2Mp6J/pB+xHZSmqGfefGV5czKl9D3
         YjH4UZaQGEyezpUtF9+Ldk+Z2CdnwHnqdW0dN3/VWTdQRJ2NOKKFQB72onWla9Ts/PqO
         5EYw==
X-Forwarded-Encrypted: i=1; AJvYcCWxpwGxppLCDLL2T/qU+2MrQC+2pcjqgJsn/tgNZtndgl6o01N1JvPOknw3z2qj7WBeRPryykWAfophHGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZBZFBf1n+v96u6EszJYRMcdbT05NcUqT20Sc/x2YYwzX8wuV
	eJ4p85cJPZ4A7psr+r+K+1KgcJGZM/2Y9P/uQnkKxRrwuhr0QaaBjFmt5+BY5Q==
X-Google-Smtp-Source: AGHT+IG3Wdvq7FikGudpKFODVTevKnkEGW7rbWK3lfvSez93bNJXQhpltuZjtk9OIthHDKdV3+dI5w==
X-Received: by 2002:a05:620a:24c2:b0:7b1:41b8:9ed7 with SMTP id af79cd13be357-7b35c0b3d7dmr76252285a.16.1731554638970;
        Wed, 13 Nov 2024 19:23:58 -0800 (PST)
Received: from [10.69.180.250] ([166.194.203.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b35c99c6easm8793685a.31.2024.11.13.19.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 19:23:58 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Ricardo Robaina <rrobaina@redhat.com>, <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <eparis@redhat.com>, <rgb@redhat.com>
Date: Wed, 13 Nov 2024 22:23:55 -0500
Message-ID: <19328b27f98.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20241113230425.GJ3387508@ZenIV>
References: <20241105123807.1257948-1-rrobaina@redhat.com>
 <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
 <20241113230425.GJ3387508@ZenIV>
User-Agent: AquaMail/1.53.0 (build: 105300523)
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in __audit_inode_child()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On November 13, 2024 6:04:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Mon, Nov 11, 2024 at 05:06:43PM -0500, Paul Moore wrote:
>
>> This is completely untested, I didn't even compile it, but what about
>> something like the following?  We do add an extra strlen(), but that is
>> going to be faster than the alloc/copy.
>>
>> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
>> index 470041c49a44..c30c2ee9fb77 100644
>> --- a/kernel/auditfilter.c
>> +++ b/kernel/auditfilter.c
>> @@ -1320,10 +1320,13 @@ int audit_compare_dname_path(const struct qstr 
>> *dname, const char *path, int par
>>        return 1;
>>
>> parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
>> -       if (pathlen - parentlen != dlen)
>> -               return 1;
>> -
>> p = path + parentlen;
>> +       pathlen = strlen(p);
>
> Huh?  We have
>        pathlen = strlen(path);
> several lines prior to this.  So unless parentlen + path manages to exceed
> strlen(path) (in which case your strlen() is really asking for trouble),
> this is simply
> pathlen -= parentlen;
>
> What am I missing here?

[NOTE: network access is patchy right now so you're getting a phone reply 
without an opportunity to look more closely at the code]

To be fair, this was a quick example of "do something like this" to 
demonstrate a different idea than was proposed in the original patch.  The 
bit of code I shared was not a fully baked patch; I thought that would have 
been clear from the context, if not my comments.

Of course improvements are welcome, but in the future know that unless I'm 
submitting a proper patch, the code snippets I share during review are 
going to be *rough* and not fully developed.  Additional work by the 
original author is expected.

> And while we are at it,
> parentlen = parentlen == AUDIT_NAME_FULL ? parent_len(path) : parentlen;
> is a bloody awful way to spell
> if (parentlen == AUDIT_NAME_FULL)
>  parentlen = parent_len(path);
> What's more, parent_len(path) starts with *yet* *another* strlen(path),
> followed by really awful crap - we trim the trailing slashes (if any),
> then search for the last slash before that...  is that really worth
> the chance to skip that strncmp()?

Pretty much all of the audit code is awkward at best Al, you should know 
that. We're not going to fix it all in one patch, and considering the 
nature of this patch effort, I think there is going to be a lot of value in 
keeping the initial fix patch to a minimum to ease backporting.  We can 
improve on some of those other issues in a second patch or at a later time.

As a reminder to everyone, patches are always welcome.  Fixing things is a 
great way to channel disgust into something much more useful.

>
>> +       if (p[pathlen - 1] == '/')
>> +               pathlen--;
>> +
>> +       if (pathlen != dlen)
>> +               return 1;
>>
>> return strncmp(p, dname->name, dlen);
>
> ... which really should've been memcmp(), at that.

Agreed. See above.

--
paul-moore.com




