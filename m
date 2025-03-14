Return-Path: <linux-kernel+bounces-561734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF143A6156B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBAE16CA32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FA32010E3;
	Fri, 14 Mar 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQzwU2kO"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB2A202994
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967768; cv=none; b=tHJx4tR+nyK6axlLMQHdxpvaEd68Wg6zR2YHzIFeZftra9kOuVSPlQrCJ5DyQxEL340zLgLvuiDMsyWuJLp43Yrmzx1QlTFV8qsfeA4pJ09HSj+baZvF8GZ+ZWA+89+Nfo6AB7iqz3N7By1az1P9u66jigOVlAOwE3o9nlthzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967768; c=relaxed/simple;
	bh=JnZ1YHJjukNmc9qetPt7sSkSNc2R6dj7qnTEJ4+cikQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY+vbYgt7hzKCE4nTV04/zt4E1kNS9uNoNdLqxjBlNpriaezwTkLvI3xJyNZHhKC00Sf3z9K53Rbiq9aE0zoZpzKm7v9oHelYwuFsvdyQF7cubFsBjHgMQeV38j/EKUxly+EOUJYvIpJhwKncD9v251hoifN+E2Qn+NEMbFrSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQzwU2kO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfe808908so50875e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741967765; x=1742572565; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKoGoA18ujKk5HU/x65AGFBw6cvIwE6a5BEmMBdMtSA=;
        b=pQzwU2kOPr1+N4eVQJsmTzGbapTIT2cFIb4HT1CsarW/JRKNpUYX+cfLuxeRfMYFe2
         OcrUvzIO4x9EXvqpntVP3S81uGWCj1VDXpGS2G+bWVIIVLh29FopYGOjzg1dsc6MAJT2
         7aAYcUW6UC2enATYpgwTD+zds/yij2TybB01lfKhU0jjqeVFu7dni5CyP3GGYHheRv0a
         3MarfZ4T7iGKS+19UYx4nbtoDm+/vJR0WNEFrDRjnwE0GMFjF93imGBUnH5u77bGCWgt
         8hBmflZOtUJ3yliSmGNpfF6wdLeC6FrGUzE3h1mnc+VOKLxTX202dMjY/Av1M9Ykfsjw
         fwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741967765; x=1742572565;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKoGoA18ujKk5HU/x65AGFBw6cvIwE6a5BEmMBdMtSA=;
        b=aaDaM+u3yEGWP/hJohEqMkhE2WE4uawwtROjr2YzL1T7roO6oTnrCTAhefG65m28lM
         gWPM3Hxh6Qszkb0IpQ++QYPCPH0NvT5AdH5/IbIrrBb0DL9zQ9oyKu78gILtoTEn/Zy8
         vZ8kyB7GmdPzfpsa5w6w+uxUT+U7ojORYHPUSNzU3O67Q53fbIboHiQykvduHsmWMvOJ
         zDhRhVLYb4l04CHuhz/UfGS4bLhOs6cn0SctxVzH6JkXdxzrTYlRhwQtbU9awxcmXvFH
         ZHI7mKWrs6BKC7Gy10W97C5J44v2f87ez0/zZUyk4ZnWCeKudc69kJXd5MQv1RoX9Zbv
         k6Og==
X-Forwarded-Encrypted: i=1; AJvYcCVUHk3qb2oUCRQCxNAEticjRnNl+MZ9nh5QBQObzSC6YxOmPiWHRFwU6J5+nJReVKXjbFFKBDdSKGXWO7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZRvTSBmCjRjglOWEPSTIqm5H6j0DPWDp8opd4tEe4cyP74Pz
	VRO2MwCzjnbkzSskdhf6/f1heYNeM6UzVbKmN3r8zswkz1NPpdksYMAlwzJNYw==
X-Gm-Gg: ASbGncvQfLC0Evsx5LRAqJtG1yRVk0KOhn/Zjl1LruZseXXWXKwF4Iqy5Pj4roVIL8p
	r0QQo29HEyskeL5iAreKxGz4Rvf6+dySzjJPsh4rj1KduxlPp9IImMWzQs/j2KTo9ZkhT56eJVE
	40XIgk8m7EeIEuLUr3A7amCOL3iIQKIATShPH6PNZDpKyoPtpqkUBHxcTFgElGYhDS/fHwYxZhF
	PKW/eyrCrxXkOE6j367jCrzor9Pb3BfY2XGfOGJ/3ZhbQKgtlGuxCGdOseUSUe/yokmftDXkfAJ
	QakS36vQW0GbNhnAfxLUrBtXq9NHJJEaLv9/LZXm3YvLCdf5n7afVsp5tyWh0lSvsBFcB1Dc7Fp
	elYjfC0I=
X-Google-Smtp-Source: AGHT+IEwYCKoSx0cSs3htw+SGMCjLhU2RU9hodxnkl419jpY8lUbMFXoXkJQoMHy2icUExOKjxJZxA==
X-Received: by 2002:a05:600c:4748:b0:43b:df25:8c4 with SMTP id 5b1f17b1804b1-43d1ded2193mr1458335e9.4.1741967764799;
        Fri, 14 Mar 2025 08:56:04 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm6097615f8f.70.2025.03.14.08.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:56:04 -0700 (PDT)
Date: Fri, 14 Mar 2025 15:56:00 +0000
From: Brendan Jackman <jackmanb@google.com>
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] selftests/mm: Skip gup_longerm tests on weird
 filesystems
Message-ID: <Z9RRkL1hom48z3Tt@google.com>
References: <20250228-mm-selftests-v3-0-958e3b6f0203@google.com>
 <20250228-mm-selftests-v3-8-958e3b6f0203@google.com>
 <08023d47-dcf4-4efb-bf13-5aef3c6dca14@redhat.com>
 <Z8mYG8eQnMsOA4c1@google.com>
 <16023193-6cb4-46d1-91c4-43342e7e6d30@redhat.com>
 <CA+i-1C3srkh44tN8dMQ5aD-jhoksUkdEpa+mMfdDtDrPAUv7gQ@mail.gmail.com>
 <41923b80-55f4-44b6-bc59-60327e5308f4@redhat.com>
 <Z9FHEdZoYbCMoj64@google.com>
 <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cc0c1d-2b02-41de-bf48-3c57cee97c53@redhat.com>

> > Even if it's a bug in QEMU, I think it is worth working around this
> > one way or another. QEMU by far the most practical way to run these
> > tests, and virtme-ng is probably the most popular/practical way to do
> > that.
> 
> I'm afraid yes. Although allocating temp files form 9pfs is rather ...
> weird. :) One would assume that /tmp is usually backed by tmpfs. But well, a
> disto can do what it wants.

Ah yeah but these tests also use mkstemp() in the CWD i.e. the
location of run_vmtests.sh, it isn't /tmp that is causing this at the
moment. (At some point I thought I was hitting the issue there too,
but I think I was mistaken, like just not reading the test logs
properly or something).

> > I think even if we are confident it's just a bunch of broken
> > code that isn't even in Linux, it's pragmatic to spend a certain
> > amount of energy on having green tests there.
> > 
> 
> Yeah, we're trying ...
> 
> > (Also, this f_type thing might be totally intentional specified
> > filesystem behaviour, I don't know).
> 
> I assume it's broken in various ways to mimic that you are a file system
> which you are not.
> 
> Your approach is likely the easiest approach to deal with this 9pfs crap.
> 
> Can you document in the code+description better what we learned, and why we
> cannot even trust f_type with crappy 9pfs?

Sure, I will be more verbose about it.

I've already sent v4 here:

https://lore.kernel.org/all/20250311-mm-selftests-v4-7-dec210a658f5@google.com/

So I will wait and see if there are any comments on the v4, if there
are I'll spin the extra commentary into v5 otherwise send it as a
followup, does that sound OK?

