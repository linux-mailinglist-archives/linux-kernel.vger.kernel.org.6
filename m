Return-Path: <linux-kernel+bounces-568516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3CDA696A6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 18:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36BA421031
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 17:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B169F209695;
	Wed, 19 Mar 2025 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S2MiDkxi"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A25205E36
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405753; cv=none; b=MmV+Iuyf6HRufxSqCfLgBgLRRfHyvsXDTwEezhd0rbPqohMhc6Htgb+GHt4cxe4yZg5Zr8PKOMyPowwiI9ZavD7lOuJzpi2J906dK4onIxVzYD757Ds8S76fArqFiBrP8nDSmuMbdbi/SSEE6KQANjC4btJBp0AOMDPmUDpQ8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405753; c=relaxed/simple;
	bh=0l2z93wokPsNlr9CNoUbjWKtixu8c3OJeKbw+StPh74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmPllrVIQVI6/aLxUp34lJtzlS5QfLUbfYL8mVZn5Bf+pSHyYXivp1E2lFM7ScmBRxRAC33yxsyZUGLM6J53aEfxywVAg7NL07GJRTElX1pB+13a4r5ARMHqrFa20FiEgTL94e6VA/RAezGCBDDNns4ux75vacDb41Xrd8golWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S2MiDkxi; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43d0618746bso37723445e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742405749; x=1743010549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0l2z93wokPsNlr9CNoUbjWKtixu8c3OJeKbw+StPh74=;
        b=S2MiDkxiWVxeVrodJNDEDVn+o4/Ap8hnAMdkeK4F1d/+S2VLk0VfzUeR9eO6eJqt/X
         8N7PZpX4Z+J2FnSYf2u8ruHHjq2G/rE7aUtMXhZm8MoKLYOvqMdggatBl6yWTSukZad4
         ttJC+1eF9vY4FtEpbGRkRh8j8ZbW1iD94uDGrhSFXqWQvpbeGG7+E+9faTl38UKQ9nag
         ZNXB56cRmh7niHEEmgra0cFMyIgOcpdO1sDoiRIxrBCWGcAb4aQQUiByamkpmUKwp+Ip
         grnR0Jdq64TtlESaJGfi8Fkl2Ni90YDg9VVc1HibJgKZorTwbFOTqL5x+Cj/yG9RIJu6
         T+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405749; x=1743010549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0l2z93wokPsNlr9CNoUbjWKtixu8c3OJeKbw+StPh74=;
        b=sT/DX9RqpbMi8DJCr+/zEIDaAA8ihQYl9I1KR/4r2hjs5wp/qZHsDmyUytdz7pjZhP
         VG/ORLhKeeZJyNy85Kr2F+7M3BxY/fuKrAFS1VI+gbNNQ3mkywgEl/Lj7qBcLB8SGKAN
         VeCRu2o7aE400v/N+ptIFrhxPQZv5Ovi8bYT4isJrgPt2+I7HVgu4vH/r3z5vhjJa/dZ
         pn73nTwDzKESkMENY5RGcqDJR+3sqa7cDxz36jKGTEqQT5/d3QnE8Z+Swzi2kYgODXN5
         Uza2HkCvyojI2PNPCPJ1vqVX763VI9a5QczNtCCA8a6y6TI019Tq+R7Y9KAW8xOVO0Ur
         rkAw==
X-Forwarded-Encrypted: i=1; AJvYcCWTK6PLMycQzu+g7KvbbhZMmOhUP9WGZcDD8OUS8cCEwfGvNvzSKxGrl5049RSeTG+xHwvAsqOCHiImYG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2dj3gej19pIQX/hIWmYwZXu91CIBI0qTNHA+muJr4lUlAeXT8
	sBCc6eleoUP6Cuwr8jYtfewYvt6+x5tAYjdAgkPnzqPpgC2IV7Gb2v8PsJUwVEU=
X-Gm-Gg: ASbGncvYjpClV85UNtilT5wgrAf69xcCNqpCNt1G5scbDY4vepr3nUBrMkKvB071GKk
	i/2o2Q2VJq6aKWv/gybFlo5krG+6MakQ76vpZWyrZBUeOu/Xxz37HMxCwYIrYJ1o37xk4eCvmI6
	iHX86rMkLVdoKBBQGs4gvP86CBKWsVLANwbqdXRFAFOJJi5skqNh1lETiiXApRAQkuoIoHa8A2N
	SJt+ilINDvdO+Ju9j5Vzk58GOHdXgGhBMOoL2lnwzb0eOSA6DnRM3XOY1QpA2XteYFR9qZE+ipn
	89uIDuVE1l9eSO+TR5NAwLrLTjwVTPSZ6Z9mYDf76MAG8+w=
X-Google-Smtp-Source: AGHT+IGSY1s1s9fdWTOqCvd15nCY+1i4tmiNttO/M//h1esu/RG1YRloGZrRBRjGkhNkFUvY5SdRkw==
X-Received: by 2002:a05:600c:3ac6:b0:43c:fe85:e4a0 with SMTP id 5b1f17b1804b1-43d4378b869mr37926545e9.7.1742405749373;
        Wed, 19 Mar 2025 10:35:49 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f55721sm24738885e9.20.2025.03.19.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:35:48 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:35:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, 
	Jozsef Kadlecsik <kadlec@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org, 
	Jan Engelhardt <ej@inai.de>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
Message-ID: <xn76sakdk5zai3o4puz4x25eevw4jxhh7v5uqkbollnlbuh4ly@vziavmudqqlv>
References: <20250305170935.80558-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mkh2zl7plkwrsur7"
Content-Disposition: inline
In-Reply-To: <20250305170935.80558-1-mkoutny@suse.com>


--mkh2zl7plkwrsur7
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] netfilter: Make xt_cgroup independent from net_cls
MIME-Version: 1.0

Hello.

On Wed, Mar 05, 2025 at 06:09:35PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
=2E..
> Changes from v1 (https://lore.kernel.org/r/20250228165216.339407-1-mkoutn=
y@suse.com)
> - terser guard (Jan)
> - verboser message (Florian)
> - better select !CGROUP_BPF (kernel test robot)

Are there any more remarks or should I resend this?

Michal

--mkh2zl7plkwrsur7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9sAcAAKCRAt3Wney77B
SculAP9GVIoNd21oKejOf5K+kuWK6ln1L3Qw50YXK5VXLv4gMwEArmRvNKABVTIK
cPswoGaacpZ2rtBI+7CV6ppLjJtekQU=
=11CI
-----END PGP SIGNATURE-----

--mkh2zl7plkwrsur7--

