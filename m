Return-Path: <linux-kernel+bounces-265967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80C593F859
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB95B24541
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F85A15B57D;
	Mon, 29 Jul 2024 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LpWepdXq"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C96115532A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263758; cv=none; b=LmhSLQC0EwLsRQ2tUlwKV7s4dJft6NZSLlDfsrBDfEnY0Uwx725ylIPoHF6KbLnls1ymyS7PoaqojlsimFq9+oHHkyjTcuaK+4IckJ58RzgRDvg89C81FjKsDSpXU548IteKpoJXnMqOhtQA9esPLpjHK8yEcXD6GxoUAoVPvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263758; c=relaxed/simple;
	bh=E1sP99WC+1szMP1BMivoeyIVMY9y2xv+cQCKsy8L+dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMqi1YAxb2Exps2qlkG6K54gC2kfxOXrx/h1lF+EgDKtHOsZqFJDA09tQe0tIqFp7PaYvTvCAXqdyLEExgDTFPkbZFp57Qo9Kg5MOzwZNsbha1ZRLodV1bIBPlx7DX4z6ymzU6zd/BoqPahUCtdGuTnWKTcbTP1ox2Ow7rbnskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LpWepdXq; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428119da952so17030855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722263755; x=1722868555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y4isImS7pTqyFJ4vBw8n5FT/MRmjX05tQSLV89xTRCE=;
        b=LpWepdXqEPwZTodZxtRM3zim+TDQKRtD/rkEUC++JULT4xrdrVWYiotAjIZYaD99nb
         YU/JCedt7z8i42Q9St1+/+x1iqAuG26BDuF5Glog+OOtJJTmU1WY4YxpzH/l3jiqEX/W
         6/WdjevnYoMqiiH2NqezIY9KF7iL4LJBzemsfR6tbVkmo9yg7j0uaq4tEQow4Cqkru6O
         Q8WmZc4eXQhuzdLidcxeJa97Dj2JCR7Bi/OYmJK59zOfCb12SSXAV/uga/6zj/r35j/E
         mhxXCFzxBCzg44LxHlKyjML/8iSNgOHFzBoUMdp/KbW+kUaOAdDHdidi5yaOVNm8ewJ1
         9uFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263755; x=1722868555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4isImS7pTqyFJ4vBw8n5FT/MRmjX05tQSLV89xTRCE=;
        b=qCzeejqBHMHi+qge1u3nAWLVVujLvB72WeH6dq+do9jaKgyjzZzaT9uYEI8F1ejqvZ
         hqJhWViM9BT6Ccq6jj++HhinyabwrMaXI8apDd53zcb9nx+6a/qXNPri8tAddDIw9ylZ
         pA0Hm3DFuVbzTwBmcXJPKb5b+IoUTd1ydkpWis5vbT/We7UWw4O+TbtfBEJ7tJBlX2Mp
         HKFqpAfxcOJ8Q02I9VQZkYCws+/apCON2/MvqL1XjEssPJW/OrhKdTGNl4+o8e4lLyMb
         W0VkjqM4cnNBbqn37DDI+xjXbfemojjgbIxyvCTOFIx3Hu3cP7ldhXhzAH6SUkSND6Q4
         1/8g==
X-Forwarded-Encrypted: i=1; AJvYcCVfC9E3nkcVRBTgHyGRssPWQL7HSkKR64yfXG5mQhJ+/+T2kiiAfigUTRF6C6May9c5jpLkRg8WhX0bmXuB0cjYGwdVr1xkPumB9dJx
X-Gm-Message-State: AOJu0YxGu+WWNfK0r/gm/WWC3Y/C3A7tUQKG1bGTVTVvaGKhhcrd8bna
	P+U2hWQ4xA5KPaKmU2XfwNc4gmhGgdkVxn2aAMuFGcMqPqVifL3XyfEofGPiZxA=
X-Google-Smtp-Source: AGHT+IGBJFDdsIvQz7PwlxMF4LFBgZFL5yaxEVS3+pZjggdyv4RKIljV8sUTNQeRxrYLaAqNoTGNBA==
X-Received: by 2002:a05:600c:46c8:b0:427:d8f2:550 with SMTP id 5b1f17b1804b1-42811d9a644mr61544405e9.14.1722263754868;
        Mon, 29 Jul 2024 07:35:54 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42805730c48sm183712825e9.6.2024.07.29.07.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:54 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:35:52 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>, cve@kernel.org, 
	linux-kernel@vger.kernel.org, linux-cve-announce@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>
Subject: Re: CVE-2024-35918: randomize_kstack: Improve entropy diffusion
Message-ID: <u7iq6sax7trmasfpqqe5val5qr7d4odjokww3cxpav7mibgipn@fpxugdvez66s>
References: <2024051912-CVE-2024-35918-3fed@gregkh>
 <lsh7xgorp67fplqey6evmukt66tbstbjob34bwyt7wiklkqu3n@6wftjk4z7xja>
 <2024072606-outlet-stuffy-259b@gregkh>
 <D4CED3E9-5E5F-4E94-AB59-3EA617213DA1@kernel.org>
 <2024072746-ample-sponsor-bef6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nwtelvjcmrasmqrq"
Content-Disposition: inline
In-Reply-To: <2024072746-ample-sponsor-bef6@gregkh>


--nwtelvjcmrasmqrq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 27, 2024 at 09:34:18AM GMT, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> We assigned a CVE to 9c573cd313433 as it was implied by many that this
> was "fixing a weakness" in the security feature in 39218ff4c625d.  If
> this is not the case, then we can revoke this CVE.

If 9c573cd313433 (fixup) is fixing a weakness of too few bits in stack offset
randomization, then 39218ff4c625d (feature) is fixing such a weakness too.

Or equivalently, if 39218ff4c625d is not fixing a weakness of too few
bits in stack offset randomization, then 9c573cd313433 is not fixing it
neither.

By this reasoning I'd be for stripping this CVE. Both patches would thus
be equal. (As suggested by Kees.)
(Also to avoid going into the rabbit hole of how many bits of
randomization are enough.)

> "improving an old one so it actually works" is fixing a vulnerability
> (i.e. something that says it works but it wasn't), so those should be
> getting a CVE if I am reading the requirements properly.

This could apply if the implementation somehow mistakenly
short-circuited the offset to always 0 (or in the case of some other
features with a strict threshold) but I don't think it works here due to
the fuzzy nature of randomization.

> I too would love to assign CVEs to "a new mitigation feature was added
> that you should be using", but I don't think that would fly :(

It would be suboptimal use of CVEs (not to mention that features are not
trivial to backport).


Michal

--nwtelvjcmrasmqrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqeoqwAKCRAt3Wney77B
ScNFAP9YC8RQLmst7FXzNyaQ2nhM7gOAChDxaqbaZdXVZXCvawEAjFT6/28rwby3
tsC8NEhA/rMY0ZhW+FiDNQ9CzHePvAE=
=6xFD
-----END PGP SIGNATURE-----

--nwtelvjcmrasmqrq--

