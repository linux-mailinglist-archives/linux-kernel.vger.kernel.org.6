Return-Path: <linux-kernel+bounces-293714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608F958377
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A731C24379
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18418CBE6;
	Tue, 20 Aug 2024 10:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dhhcYPD7"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E117518C904
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148059; cv=none; b=e+nTMrm9wwZ1OSkVjNOQKooi+tPm0UzBZpq/GpDybd/zYsMr86LauFEHrOlENx24H/U6kvK6T6SBK+uVAcyqzr2UJkz8CWna6LT6UWW5je1fd+psDhLnZkSfaOetoeaIdKcI56M3nVE065/GZlZk/t9PqQ/jliRSdKYJwInk4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148059; c=relaxed/simple;
	bh=bWtnqhRI/JuTkpJ+WLDRzhJVDXOqPx+pGUcrSL2lqYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhJeAMfnmR6u1Px85OHsE77M0Y53gKko9CHKsnZ5Gerk2djTyL2S4CteE7pCLTznnx8QylsKVRP9UztoRgcHkFggNueWvX/D9Rm8ZiXv3HxifiwABaqcFs+/1czmMm013VwkLqt/Gw1UxGKQPkNaF8D92QHQAzgmzba8T5Ipfys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dhhcYPD7; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aa086b077so552157866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 03:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724148056; x=1724752856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWtnqhRI/JuTkpJ+WLDRzhJVDXOqPx+pGUcrSL2lqYQ=;
        b=dhhcYPD7+cDdZL7SIMO7+5ihYrd4Gm0BoT3zJNglQ96hnaes/aWJYkDw1vAGJmZ+bm
         XTEOPfsgVybNkFp+WBcX4f5cihutEuhAQz7bP38vLiTBRtgR7DUnxvSRQzc2XbejT6IZ
         pNmy63Sj5VD0KxXNiQqAkFvkVndhB3Xbf9S1lSh4mQVLrIuydQJN3XoOuT/qOmyM4eKS
         PqIJJ/XalAGcciQNE/9d5mSEV7RgCmAuVcqFPkg7srIGmCOq4/xSvZsEmrQDFjRJLWm/
         ivwk3IZKEmFh/xEzkJ06o0BR+sj2z6OPuozMY0SgsiwMTO3lOsEsvZFG1gOuCjJe/UIC
         x+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148056; x=1724752856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWtnqhRI/JuTkpJ+WLDRzhJVDXOqPx+pGUcrSL2lqYQ=;
        b=ocOYPpNRieJXhRhJYjU4etG+n+nvEjJMO+XXmN2J+ryl8Dc1cF9Qm0CfkzUIacKAfc
         +jvuxsW8wMRzPPt+xvGcF9nsZyM44ZO6ceBqwVb6tmxGP9JbzIex9LMCvibTRFaaZiyG
         1eqn1+UUzEKXNzk4ZZc5vZAzX97GL8WTVf2b8NBlDKLFZ3IlzK1qd3SB9H8jJYEsDoVs
         X+7lKEyPDcaiLlQ0hfCrJLW3DlguCKbeoKWcAB0XYQNLsyb1x97dprGbQiIpTbdqe6N0
         VblvK+qLijtq6TaOcCy9KsP1QlbmPM0BbYOM88+FntA3XDwWc1Dga5o7/IDMa/yLEtqm
         HN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVLrFF7Xu8ARPtuara7imz7F7Pa5qvWPO8pJnWrOZ++xXrNQJop7OiO4T/56Yvtlrraa9X97EJWD6tyBi9i/Geu57oCp2OqGUDognlx
X-Gm-Message-State: AOJu0YxIbJYhBQ0ZBOdP8vccrf9uHObREATd9IHSC3czavJf1zGQdiEa
	TGvDkMMo8MPNiRURw4ek8t9/n81mKYoWEG1hatMEvM/ae0l/a7dLvm/Plu4bpz0=
X-Google-Smtp-Source: AGHT+IGE3PxS/8B9eIPrX7NxB0OYZw1vG3KBe6ZRFywGBUkcNdU+qDHyI4oW4rHxkVwksuQSpJI//A==
X-Received: by 2002:a17:907:1c9e:b0:a77:cd51:3b32 with SMTP id a640c23a62f3a-a8647b6ec91mr119130366b.62.1724148055852;
        Tue, 20 Aug 2024 03:00:55 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383934508sm744346266b.101.2024.08.20.03.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 03:00:55 -0700 (PDT)
Date: Tue, 20 Aug 2024 12:00:53 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: Li Lingfeng <lilingfeng@huaweicloud.com>, josef@toxicpanda.com, 
	hch@lst.de, axboe@kernel.dk, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, 
	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
	lilingfeng3@huawei.com
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
Message-ID: <k56cnz7q5hxzh6hqmw4gnxobr2wlo6xryf4jqlky3mylcs4px4@zrhciaca2asy>
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
 <ZsO4ArRKhZrtDoey@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3hqaf5xszdcakr5n"
Content-Disposition: inline
In-Reply-To: <ZsO4ArRKhZrtDoey@slm.duckdns.org>


--3hqaf5xszdcakr5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2024 at 11:24:18AM GMT, Tejun Heo <tj@kernel.org> wrote:
> I still don't see why this behavior is better. Wouldn't this make it easy to
> escape IO limits by creating cgroups, doing a bunch of IOs and then deleting
> them?

IIUC, bios are flushed to parent throttl group, so if there's an
ancestral limit, it should be honored. (I find this similar to memcg
reparenting.)

Mere create + set limit + delete falls under the same delegation scope,
so if that limit is bypassed, it is only self-shooting in the leg.
Shortening the lifetime of offlined structures is benefitial, no?

Michal

--3hqaf5xszdcakr5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZsRpUwAKCRAt3Wney77B
SWVkAP4rVAcf8/rGbwJarR3fhhbeDC6WwPUzDJ8CX8Vedw6MJQEAlc4hWQw2q8ZX
K+DRgWzsjRm2cS6gEPunEX4GMP+/xwI=
=ck8I
-----END PGP SIGNATURE-----

--3hqaf5xszdcakr5n--

