Return-Path: <linux-kernel+bounces-517629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5DA38380
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505E03B404A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D487B186E2D;
	Mon, 17 Feb 2025 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1GvU5L+"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E81FCD09
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739796848; cv=none; b=Fesp/trW/qw6jBI9g41c0jpiHvhzPkPPJVvnNT2epUPa4s8kvtQL1biZq/EXu3yOWQ7ZoOQSvzP/YyiWi5Ery4Y6JpIjqwarOcI4fxFhWUqijaHZ1MR6NPRQTYibXvpcAfBLZpqJR4PCg5PQ6Gl2vDF2DV0NpyJtWs7WCkJqM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739796848; c=relaxed/simple;
	bh=Egu4KagOY4eBm/WyUTX/bDT18tGt/RCB2UHpWbfOxIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lg5KTDdhpTZE6ml8BcarrQuo7cKhfo120HprWupIqCVodiCWB7CeM9ZveWNg6DvgiUf/fIRYcdmNLvq+XBs+4Y4q3inKWKjExvU8IuB1IjHRc5DdAS8f7WkewNPD7A2GfyFVMy0SThXRlVd6j1s3O6xeOIbd8V8HwmbY4kKNftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1GvU5L+; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso1788796a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739796845; x=1740401645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Egu4KagOY4eBm/WyUTX/bDT18tGt/RCB2UHpWbfOxIg=;
        b=E1GvU5L+OF7posO2qp/zAmQ3H9cmVD9DfE/9Nhm3EQZnwDw4qGqEtDAPzIajOEZAVI
         Ppv1/J1CfmGtC8KHGq94wK8fgyET+cCAtBq6pWz1+B4eJQUV4TrIORCsZp83tiyfIixo
         7AfnHeON+lNeO9tqXaSr7Bm553DjGzDMu0Mbt+TFXxawrRwxv6aVXo4QfjBxkwu1BQhP
         sc6WPvtVXJRh2P0qZvMtU98t5JfBVH+FXIECCuSnaJ6tFBUEgQcPZcvQxSlc34qO6AXZ
         /kQpXUkFSKMk3AoNL0k14uY+hckKYmpANv32PjnFBFYM/Qr6V0gYhqitXjGTUf2moOA7
         ghnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739796845; x=1740401645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Egu4KagOY4eBm/WyUTX/bDT18tGt/RCB2UHpWbfOxIg=;
        b=gjShAIZDorKTn8Cu898EyJrur9GEl1R/KKGH0faIAx94UW4HEDCYkoDtv1gOoDFL2Y
         upBJu1VVahXRLKHBhwgnUJxcluQEzc0DE/+RHjgb6++Ik+dfaZeOHBidcfwJuxayvdC0
         5K9/eqNofL+fSw8jjhPFzSqx6YIg4/6SGF5rLk2J4K0tFOpiOkdqFmDV/673wCgrchWG
         SCP7fRRqFr0uwtDnn3KUctAERM4zTKR+ExUJGKgxYphvNI3pl4tvmDD+bQetxFJYCdGr
         /+T5TBav4RTqH/QXow4+lO4TTF4DM92kwc4dzVKBXZ016NXc3xsfswLTW2eHM2x4/+TZ
         A2QA==
X-Forwarded-Encrypted: i=1; AJvYcCWSNEvjscv1r/KscXCwlP8R5VWLZuF7BQG4RmzkG6fUGChdMlxS1GKnK54dKbPtum4vgk+UKkabsqSuv3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy524n/WdepZMDUS+VKKY4mqdSh7Vc7PeFtDW/CJZZHQbN7KGya
	P9+YjVzyNKsN/C/CL/0XhvPrvMN3SpS/TWkMLvlyG30/7W4ZvE7JCXz1V85ksW0=
X-Gm-Gg: ASbGncsPNDVZSc5vuxI9Z6UU3oZt5XeV5GhgUVIe5ESy7B/7+mSSZY/3Tce1d7BEkzW
	MIgc1Uzi1N7XkQno/J9W1yudz/t7zNfvtsNVIzrYQmYdwU4sDBO915FvnJ+m5KMP0WLIEI1apsK
	BTic4r+n0iT7+OTKef69A8hWGdBTGVjMTTwdDEexDdVAYMJ9wJbZlNbQg8YzEWUdL7IlYQuoTSe
	enrdDO0aw/FtTpIBhnGo+YN9+LpdPEq07QGEIC3Sxlm0MhFgyj0h37yEmDsnsNjyT1iVdXD9KHJ
	f9vtCLtWHDk7RgNa8w==
X-Google-Smtp-Source: AGHT+IFYZvC9AyQ3Qo3Ass97b7QBggJJgTgMzB8oPnoQxqXsky8Y8ZOyzFqTsX9Fo7+f9pXUVVBcjA==
X-Received: by 2002:a17:906:f5a2:b0:aae:bd4c:22c0 with SMTP id a640c23a62f3a-abb70a959e4mr845116566b.19.1739796844653;
        Mon, 17 Feb 2025 04:54:04 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322dbsm887225766b.10.2025.02.17.04.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:54:04 -0800 (PST)
Date: Mon, 17 Feb 2025 13:54:02 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jin Guojie <guojie.jin@gmail.com>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
Message-ID: <2e662ogdk63dxj4fqzv6cptsef6snwkjzdfrv6knsl2gmjial4@qmkkzrwbdpk7>
References: <3a5337f9-9f86-4723-837e-de86504c2094.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYQD2K0Vz_jHD_YNnnTcH08_+N=_xRBb7qfvgyxx-wPbiw@mail.gmail.com>
 <pl23stfp4qgojauntrgbfutmrstky3azcoiweddseii52vgns4@6446nbhq2zl6>
 <CA+B+MYQuz9ue1ZogpEGb8J+F8UA5P0dD-R1cRUp-4EgDBnPS+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qaouh2rpksdqyz3f"
Content-Disposition: inline
In-Reply-To: <CA+B+MYQuz9ue1ZogpEGb8J+F8UA5P0dD-R1cRUp-4EgDBnPS+Q@mail.gmail.com>


--qaouh2rpksdqyz3f
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] cgroup/cpuset: call fmeter_init() when
 cpuset.memory_pressure disabled
MIME-Version: 1.0

On Fri, Feb 14, 2025 at 06:04:18PM +0800, Jin Guojie <guojie.jin@gmail.com> wrote:
> In fact, this "case cpuset_memory_pressure" has been in LTP for a long time,
> and the same error will occur when running in multiple kernel versions.

So it's an old failure that no one has looked at for a long time, i.e.
c). Thanks for the clarifier. (It might be benefitial to look at v2
nowadays ;-)

Michal

--qaouh2rpksdqyz3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7MxaAAKCRAt3Wney77B
SUlpAP9bjeJ6R1k7/Pmiwp0mqVfO9um0OFcFMps9f20Td/koTwEA8A/oqWRiRl6k
Q6NoGzllEbbBUYe7m0xz3BYdqp2xvQg=
=pa1n
-----END PGP SIGNATURE-----

--qaouh2rpksdqyz3f--

