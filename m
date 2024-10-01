Return-Path: <linux-kernel+bounces-345919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEBD98BCE8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B13F2B21208
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5E119D88D;
	Tue,  1 Oct 2024 12:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OGxEdPvA"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496B1C231D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727787401; cv=none; b=pOws73IPGvRtsRkUAb2fwth4XZZkKsAIGnyD7R25dYn++ifRMW3UL0Z6695rzgtJVtp+WaiLjSN6agPf8RzBqvOY4ortmQZPDAPiRKmpWFEYnFp04ZIE0BOdACGgEIauyzIyFQ0wqK41V81PFHvfg5KoGo0sJ6gdkYF3JEM7lVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727787401; c=relaxed/simple;
	bh=elaqumYw4bHnm8QveWuP63/6Z1Z/ku0pn5Z9ShUswHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqfkfEz+mEdnNOq8EHe3QhXBtEnTyR+Om92dlTkvyLe/v1EDSQuus3mMkC/5T/On2rJpJFcPLNFOYLqIEhO9PggTcnwm3FZ1NR4hHVxxBjeWMhUuNpGwlUDqbblyjGCEOLUeLPW0MjiId/faQsTEKBT3Qqcq+0KNnkfDxNubxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OGxEdPvA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c896b9b4e0so3485745a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727787398; x=1728392198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elaqumYw4bHnm8QveWuP63/6Z1Z/ku0pn5Z9ShUswHg=;
        b=OGxEdPvARtw6QEZlbuUXyWOhhtURAEAiCCbDR3rEtQ4KCP4jZF1RsED9zLGY/imTDZ
         Ijuo+ACmted4d1dFSc+Wqw66IYBAW6i1AjYVQMq4O1+15ZwPN/t07A+45tQ5W27ylP/u
         5ADr37E9joQBOUG+ANG2VkXOZBpCBxiyhY1gRqR1y/C53bdXKVREM3C6v7hapm0Wq3fm
         XTS0A6oJq64GzFladM/DMuAjWFuhwQZKNxi5+LrXKgDavi0tErZNhEmPk7Dry3LylOL3
         aMO+zvV2VC96i/Jmx3VIjIsvVZLZ0cDAzg95oh/BoEkM4CurbzX61fZu7ZxBwP7cV0kg
         2V+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727787398; x=1728392198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elaqumYw4bHnm8QveWuP63/6Z1Z/ku0pn5Z9ShUswHg=;
        b=iXRB++yIMxlne0O4eTyB9C1HhZDfT8wjtrJ6T7U9SDrzkoqSXe1AbnW9fxycY04SHU
         dv6AurDmIF2Zh3ry/TYzbqOY/COjuUM3URewDgA8ukrRXKhq0zvZM0eWfoJOB5ahfTf0
         22bWwscScdZSzQQwRA+MYtbvL9+ljMNq2oCyInA0WAhDYhoYeeP5Uko2JKA1nPp/k5aI
         6BAmvvkt7ZubhhjHfaLALATp2td/PiJ3rVzLKAFujFEFano8A/GUmQs7MjpYReqTpq7E
         1HMwpziiDTYu0aFbQqjchynNwtlNrWARFOeo+0EQV0ubtCktPC54LFqZnQHHWCHDQbsJ
         8cNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm8fwcAPTvTcxZEwkFLJtKfLEkfFrHE5IXC3SWVwKhAcLbwx+PCdXabMFG02bCxIm0H40Aa8ok3QLrMls=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlGmiq69LZ8DShdCHQ3JpSqdZdhhj8uzaV7BWfk9xJFOZud39
	tU7n178319r1qIiUyXZT6aqV9/fjmkZo7u2T1TDAFGjamy4MCVhJumD/ZW4Wq6M=
X-Google-Smtp-Source: AGHT+IFFuMzQa8bLdVb7xiP9LqqJ3d220UFLpvDUhIN5ChMnYlsth1zhIaCEGLIP7a8oqbX36nHraQ==
X-Received: by 2002:a05:6402:401f:b0:5c3:cd88:a0a with SMTP id 4fb4d7f45d1cf-5c8824ece42mr13869853a12.18.1727787397495;
        Tue, 01 Oct 2024 05:56:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88245e990sm6131493a12.52.2024.10.01.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 05:56:37 -0700 (PDT)
Date: Tue, 1 Oct 2024 14:56:35 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com, 
	shuah@kernel.org
Subject: Re: [PATCH v3 2/2] cgroup/rstat: Selftests for niced CPU statistics
Message-ID: <4l4afsuzqd6vowki7ldafoikpyw5sfwcvhhpeaezwhdmdj54bc@fhp6yt3ygq3r>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <20240923142006.3592304-3-joshua.hahnjy@gmail.com>
 <xmayvi6p6brlx3whqcgv2wzniggrfdfqq7wnl3ojzme5kvfwpy@65ijmy7s2tye>
 <CAN+CAwO8XEAkoBDc03Zveaci9hASaFvk8ybQ2Mwoy_VacqgRfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ns7hq3omeehksxir"
Content-Disposition: inline
In-Reply-To: <CAN+CAwO8XEAkoBDc03Zveaci9hASaFvk8ybQ2Mwoy_VacqgRfA@mail.gmail.com>


--ns7hq3omeehksxir
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 30, 2024 at 02:07:22PM GMT, Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> The reason I used a fork in the testing is so that I could isolate the niced
> portion of the test to only the CPU hog. If I were to nice(1) --> cg_hog()
> in a single process without forking, this would mean that the cleanup portion
> of the test would also be run as a niced process,

The cleanup runs in a parent process and nice is called after fork in a
child in those considered cases (at least that's what I meant).

> contributing to the stat and potentially dirtying the value (which is
> tested for accuracy via `values_close`).

Yes, a test that randomly fails (false negative) is a nuisance. One fork
is needed, the second doesn't divide different priority tasks.

> What do you think?

My motivation comes from debugging cgroup selftests when strace is quite
useful and your implementation adds the unnecessary fork which makes the
strace (slightly) less readable.

> Do you think that this increase in granularity / accuracy is worth the
> increase in code complexity? I do agree that it would be much easier
> to read if there was no fork.

I think both changes (no cg_run or cpu_hog_func_param extension) could
be reasonably small changes (existing usages of cpu_hog_func_param
extension would default to zero nice, so the actual change would only be
in hog_cpus_timed()).

> Alternatively, I can add a new parameter to cpu_hog_func_param that
> takes in a nice value. For this however, I am afraid of changing the
> function signature of existing utility functions, since it would mean
> breaking support for older functions or others currently working on this.

The function is internal to the cgroup selftests and others can rebase,
so it doesn't have to stick to a particular signature.

HTH,
Michal

--ns7hq3omeehksxir
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZvvxgQAKCRAt3Wney77B
SbiUAP9af/mzRnk0+6KuLlvEpaZlgQ792QW8ztnjyA4Gxa1H/gEA/txhhvPclRRi
6fUMFJnOb9l7N859/ZMEOAuVXpT4PAA=
=5tXx
-----END PGP SIGNATURE-----

--ns7hq3omeehksxir--

