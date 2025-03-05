Return-Path: <linux-kernel+bounces-547110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51256A50324
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F05D1895632
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228B524EF9E;
	Wed,  5 Mar 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R0f2Rv5R"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A024EA8A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741186906; cv=none; b=mIRzq8iklgzPBlNfvQqu7V7f8FsDOZdxwG9DbqfpTGeDLGjK5WWDD2S898PB0gE3JP5ias44hVt7RPBvOE9WFYsIqF7V0rxprt64xObjRyBXHZSB5n8XvmRoor6Q2Dxa5MuCNZaQqc/YCmpEJ1vVzc+uWUpOIMcXqWfbDobI8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741186906; c=relaxed/simple;
	bh=lUDN2FTPIBZksZjXeFJs8IYepzlRpej42fM20ZtJ10Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a89w/VmkoXW13kyjs9H/FLQX5rO4mCcFNqWcTHgrxX36fEul1j44FR4evjeTSTYY0BCrQ7KS12C2LUHWm7sDN/81ydF3suNbTCXABOuJmu2YeL4zaJY9YbeNldMlrvxTENBFg6bRKU/mcuPp90oJpDbV5otJ3e2eTAhOZqtjuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R0f2Rv5R; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bcfa6c57fso9210995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741186901; x=1741791701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lUDN2FTPIBZksZjXeFJs8IYepzlRpej42fM20ZtJ10Y=;
        b=R0f2Rv5Rmqu57EmOcE2UXowXc/PksYag574O8qQ5gfVyF78UFrExUqw/nuaIm0+YiG
         Ic3am0KS3CuJ7FSKhNc8XVN4ec/vsjoTDVe2xQsonEtuAk7VTAUkjJXwjUZAOL3GByrv
         zHveXe9le0sarmSjh9yojKakozUsRyw2zDvNwSwFuOhBLgYylr1YOIYeeCPb3/XmDTdx
         j6WoryV1BcGHkRaBWpxnXrd1RjTZZuhmXMdvCFTbY6GFYke0Y034c8mOSAQJJEHEOEzV
         asvtiOB+tyMZb2Eh6XukDzL9zUv6GJ4RkWLHsL1ogSj3bxbTsnpGvrXDd++SIqYB/rw7
         wObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741186901; x=1741791701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUDN2FTPIBZksZjXeFJs8IYepzlRpej42fM20ZtJ10Y=;
        b=Z5kaVNzKiPBzqSGCv4/TXDlkISnjuqn5xxVQ+NewVmXECfcxUQvX+kxrwWVs1bqnR+
         HwLPS3dCnv2gyqt1Fj1BZD9tAXzsDtXPKc4PUvrdYON5JHFezwo+AbCGMwZlEAUyfLQ/
         mCJtmWeHumSdl9FHm0bbaSv7jdYG/HOvVQIZg7ZuVJCJR7+hPyATZAsoEVzZHc4V0fbz
         EinGxOFUYNeuturRii6NqlV/mPFdwMB7XHuonI+z2Ry2tqAwdiHEe56X/4vF4Q3dFHSg
         Gxk1B2lY1U3h/rHNmLKPEfb2uyg3JhbGrk5IO9FzjzXQQGgk3YaUQLKqNtzfhwVjqAek
         Ww2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUeccJKKPqI0HoqFdV10DRH+l7SF3x4QnVXi7D+RpE8BmYoocSHHSr9u/a9lairj/3XAAsR60Yvt8dZiGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHOb6wCpWLrSwqa+P3KHD7FCXgl5RkkK2GO38PLVBYE+dlG2TU
	1Z/hEIWtGnzUyzY4vq6i5+9A0k/FnF0httgK/Ky9ehmmeAYORqQzOfBckMUlA08=
X-Gm-Gg: ASbGncvn5NXabgkNNFfxMB5Dn21C94MN85VKDNVm1Wxuf1+Igmex66e8M1e5+2w3SDK
	AFg0IiBSnF5DoFzl6vNCzaswm8CGxqZ5cBpl14mh/q2dQnCdeQqD8MDeuSFoj1dcZZUMGZNfbC0
	XMCG8krcLD8aAhAMsNAC6ITSdXt9aIV27rBjdCZ5l1LVW2bOQJ/egcC7tjhwz+1bVGmaPO41Zf8
	ejvaGLSmyw5mvg3I8atPicum3WlQVw3yJBgikC71GXQdn2/iW96qtNRWEAJBiLsmWDuatgpSVx9
	y6v3+hd0SISmxEfgBpYF3mGknms9i5H49t1m76Zko3TW1zs=
X-Google-Smtp-Source: AGHT+IE5xeV0NUbNuYKzvFOV3AEJUr+EReH4NEBfc38jPX0mdKmdS3ZR7+QmzK4BxhzpwO1278L48A==
X-Received: by 2002:a05:600c:1c26:b0:439:9274:81db with SMTP id 5b1f17b1804b1-43bd292a806mr33898885e9.5.1741186900528;
        Wed, 05 Mar 2025 07:01:40 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e484451fsm21658482f8f.63.2025.03.05.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:01:40 -0800 (PST)
Date: Wed, 5 Mar 2025 16:01:38 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-ID: <sk77mxmicnkuikluyi7r7oipn5rzf3v6d5jbhe7qtfvxrlpcgp@44yzmfadjtaa>
References: <20250221170249.890014-1-mkoutny@suse.com>
 <20250221170249.890014-3-mkoutny@suse.com>
 <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
 <20250222090208.2b7aa864@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n4qsuijfubozppny"
Content-Disposition: inline
In-Reply-To: <20250222090208.2b7aa864@pumpkin>


--n4qsuijfubozppny
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
MIME-Version: 1.0

On Sat, Feb 22, 2025 at 09:02:08AM +0000, David Laight <david.laight.linux@gmail.com> wrote:
> It also seems a good way of being able to predict the next pid and
> doing all the 'nasty' things that allows because there is no guard
> time on pid reuse.

The motivations was not to make guessing next pid more difficult, I'll
update the docs with better explanation.

> Both first-fit and next-fit have the same issue.
> Picking a random pid is better.

I surely don't want to delve into this now. (I acknowledge that having a
possible range specified per pid ns would be useful for such a
randomization.)

Michal

--n4qsuijfubozppny
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8hnUAAKCRAt3Wney77B
SatLAQCLUp9Io5Ukm//Nmg5Fi6bNTNJ9OOvj3Vz0RpfBn1XDDwD/ZLoJh3aJ008u
HVxHLGdnDtj801p48rWW+9FitrsiyAA=
=A1Hk
-----END PGP SIGNATURE-----

--n4qsuijfubozppny--

