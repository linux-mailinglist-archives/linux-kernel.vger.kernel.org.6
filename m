Return-Path: <linux-kernel+bounces-529581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F7A4281B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D8A170945
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC118EA2;
	Mon, 24 Feb 2025 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ECkjPOEz"
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4112627EC
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415192; cv=none; b=iEK13wJ80UOby+3o6wzvNNI7cEghQXj8NKQvkZStz9Oj1isfLIuDnRkwcG3k7PvCiors60LeGr/wxpaFzJWEfzKmTL5BDHLZ/69BecI2guG6RKVa4q/JsmAs2nkKNwyRCkbulWakNLkSt+oCHJH2WSb6nrCWOxjitrKiNRTZXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415192; c=relaxed/simple;
	bh=A/sSeIa0en0Dl2HTUtfj+TrBQx4ou7E+HxQ8hM8jKp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiDrp8q5LWUbyA6xDUVOiAMJTzyqEYXKUnPHqiujfiQJsHaAFLGmG3x3+5TV48ZOlaZTJDtWGf7wSIMmqrAf8v4ZR0JOqM/tOHuiggY+/uE39O4Y7y95BV08BdVRRD2LrEWH4MHlTy/FGGuTJqNOwq+ugQrfyiwPewcMmk9Yxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ECkjPOEz; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ab744d5e567so789589166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740415189; x=1741019989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A/sSeIa0en0Dl2HTUtfj+TrBQx4ou7E+HxQ8hM8jKp8=;
        b=ECkjPOEzGS87TAMlGi47Y30S08kWhPOwrLzNQAdpJA15ODwQLnJXdY4Qml7hKfbs3g
         XSjdboo14xdPohpbsF7IhOBF8yyATv/UU36Oo/2bgnOS91kaZK5HAKxUoPWi67+O4WWA
         EFfLpgntE6033TpRpu4W+700sOAnpu2qNGaEgxG8xCvfAj2mp4TjojD8pke9B2WJMX5v
         zTKxiwYYfpkNFQvYv3r94/VS/wep7Pz9ySxQXHHbvrFSEiM0DHtfweqP8SdeKCROQCO7
         W+kaWFHYgRetFYhmsB+UL1iBFckrrLZWS7U8fDs1RiElR1IIEoIjMAeutdtwBN4ht/kA
         LMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415189; x=1741019989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/sSeIa0en0Dl2HTUtfj+TrBQx4ou7E+HxQ8hM8jKp8=;
        b=tfn9RsMq3NZLPHG2b/218a1G+yjQewg83tLDZzASG2bixmNwJrfPNXPieHd1otjC9r
         l6fz545CgVp9Ms7LJg56GfoGi4GjU+wfc42RRXh4tjkXGO8wowrp9yF75hOk2jM9pPxF
         jWf1wmc6QAER39t/th16mlOAUuLK7vC3pKOM5BrgsLoU06YhTK69/e8sfQMw3EAfmcQD
         CmKLVve0Eo7r+4jdEKbIb87xtf1m3cqdKsN3LijhWgHfBNC/OTvvaxG/KbeENNRZz4hm
         y3NxgXC9OqoIKsDvrnF6AD2/nTWX9XqEmgU6VfNta7GOqQAYKrULdQ9a1RaVyMlWRT0Y
         1I6g==
X-Forwarded-Encrypted: i=1; AJvYcCW6cKv2ISUC9DTMfnsZLMTfQTveIQ33wzPSudUj368t5UXKCvFUCzfG15uCrhh6Z4dNFgQapSRvFerV+WU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwogESnp2dD+x9TngDn2n3Hw6Ae9XjzPCS2tug6LwzTsl2dv78S
	uN9yL4gDu7wCf0s4IgQCGuf+HC9iIyYBZQt85YDY9leVbADEyw8CaNDP8I/Ye5E=
X-Gm-Gg: ASbGnctmwZYeHcZeSh/IATI1M3p32+yQEzW3G294hwSrnfZ4rQr4mU3Mm9m7i99pvPr
	xVLuRrOUg9XmGBruJBT/e0Q3KG6QQnI6UIs97EFPQe0im67NY2KQYuaGXQORVSjDCg3slbMK8Rv
	jDHRYU+xIk9C0WDXYLHjBsra9cpLXmSGy+e6DRAHIMPBQM1IVTGE5CVMJpqV/4HurB9bm4V574s
	gdZXTO2VUgJgOXqFIlzC28k+eEO75304bGihurh4otl7fy6sgEGkHm5yfmX3McQ/hsma/2HaZQS
	/Qllsde7wRwoc0AbrmfoTLKe5Ky5
X-Google-Smtp-Source: AGHT+IGSLxJWVXnv3CdGgTuaPwMjyEnoPf9OHWFvCUlPZ62Q7/AjtvUpJqZrvW6HLmGmYJeX1/7uWA==
X-Received: by 2002:a17:907:a2cd:b0:abb:b154:c064 with SMTP id a640c23a62f3a-abbeded95e3mr1885139966b.18.1740415188993;
        Mon, 24 Feb 2025 08:39:48 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdd78ab59sm1085851866b.74.2025.02.24.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:39:48 -0800 (PST)
Date: Mon, 24 Feb 2025 17:39:46 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH 0/9] Add kernel cmdline option for rt_group_sched
Message-ID: <pngv6psyjkvhyxszv6f73nnxjydr56dtsrns57mgosqxoqq27l@lzrrhjpil4ub>
References: <20250210151239.50055-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="am5goqc7aay7yuv3"
Content-Disposition: inline
In-Reply-To: <20250210151239.50055-1-mkoutny@suse.com>


--am5goqc7aay7yuv3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/9] Add kernel cmdline option for rt_group_sched
MIME-Version: 1.0

Hello Peter.

On Mon, Feb 10, 2025 at 04:12:30PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
> ...
> Changes from RFC (https://lore.kernel.org/r/20241216201305.19761-1-mkoutn=
y@suse.com/):
> - fix macro CONFIG_RT_GROUP_SCHED_DEFAULT_DISABLED invocation
> - rebase on torvalds/master

Have you got time to look at this?=20

Thank you,
Michal

--am5goqc7aay7yuv3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7yg0AAKCRAt3Wney77B
SRgPAPwOnFhyJ12t/2cuU/uhNM9nJf5k39CWtDwn1oDOm4M23QD+K/QECCKE5bGM
CA0wjvZYxkYnV+D59hQ9lw0OmL4lfAM=
=KtN5
-----END PGP SIGNATURE-----

--am5goqc7aay7yuv3--

