Return-Path: <linux-kernel+bounces-286150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC3951743
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69121F263DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C949143C50;
	Wed, 14 Aug 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HmGiSlZt"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD27013D24C
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626042; cv=none; b=YIpE0qc2yeNb53zg838cXZ6FSPmTSuq5lgVpkmQEoJGe0C2vidvejp1dJln1ooWU89GWmyLNIA0YeVtqlB54XAx2ZwFbUUy5GT8ogqLmX6XJsPLmgt6tKV6x7+59SrQDv49UalhuE+r3Hc30weYKPQs0zadJ0pUAte0jH/xdMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626042; c=relaxed/simple;
	bh=b+Wtda2iYnSZWvMXTMr6gkdKX03az6OeFmtiXJm/YjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYt7fh368J5AX6tu5pgWzeOW2OBVVZ4XobdKHE6xOYNC4f/qLzWwrlbtecmPZ6IWhTNMq3k+4t+1J3r8vW2+256vFMfWKOI82R2/HIIwoM5KzOJ+LkPRlCdeuC4DlxfdMq/Og1f9wvrN/wH5xEOpxavZ8G7EvPoRpsYrg5lOvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HmGiSlZt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3717de33d58so135f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723626028; x=1724230828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e0VrBpxRv+L1cvAlfJueXS2O7eGCDgmOcojPruWBRGc=;
        b=HmGiSlZtPHtMu6Tr6FgJI7INgaO2iTNqxSTMaqfZ7UNkvQFhqeKy3Pf/U3MPs48ton
         vIDoLmujNkdCzSoDyscim45CgnfT6uqMM4Xt5AcnIbd5p5mR7uORnfuchLFQAww05BAV
         DzJSif34yz4Y364ddhydnsz7HB+7JR0YrPe4jYy0c2bbCXczczFlAp38wVeKVVPsBZdJ
         szGLKjt/hsJp/SfxuFT4jnAL03XupnLe4Xf2BClHnCpzfFeY7UHKmmoUO4OQ5aFbrDR9
         Gwf4vs90N3NgUOpWGEm+ev38OHHrVq2WTswb76Y//MEK1MYRdLwnSAyh5okG6iZEXDft
         Sndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626028; x=1724230828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0VrBpxRv+L1cvAlfJueXS2O7eGCDgmOcojPruWBRGc=;
        b=FUZcVH2sEoGh9TYY6VF6Pu1GNVFanfHABwU2GxQFb5T1P1EVZSHCtLdS0L5IVM8vNE
         +sbiRPuesfJfT0Opalgiazc8n15p0i4mFDLaKbxua/iyeO1CKHrigIl6+V1j5QTAlMhG
         1tySwltDWkH68goHzoV0sHiuaeKl0V1dNWEb4nBOFKe8SxbuD6U3vESHLoOTBw7CHEku
         Cmpu+7hUNH/cdEW07Dx/ldTMwivBTLoljEXMiFNE0R/1IMnveXK7hJSREukuzf6qHmLO
         166SKE8DJXb2H109Qsa1xG3BJplbLbShL7RsKH3whu5U/mTcGlfx3NaRkRN563MF1pHJ
         iABQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx807QZGqtagnfs3Wp8H+HcbkCMjfg3Y+wnloLIg7rxgXYLhIMQJrSfmIfXObRu/tIged5Gnci0yWNF6YAipJF4+vgrdfkZ7JpPznC
X-Gm-Message-State: AOJu0YwPs+3BbEf9v6f+JPtLy6br++2oIaJbI8aBBsLRgl7TiuqOgYrD
	IlGpxgdZJpTgD3jzNBxYh6VwMk3ZSA/+hgjT5vLPnxdZrzpmfzhRJr/7Yp6JkvU=
X-Google-Smtp-Source: AGHT+IFyfm3ym+AqlP5pRWLc/xKd5ydJyd/NB3v7AWxcNKzihK2+5E2i19SYg9/O9xIa5ABkRI0+Hg==
X-Received: by 2002:a05:6000:1a8d:b0:367:8a2e:b550 with SMTP id ffacd0b85a97d-37177832cd1mr1808313f8f.60.1723626027663;
        Wed, 14 Aug 2024 02:00:27 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3717314e38bsm3500857f8f.97.2024.08.14.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:00:26 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:00:25 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH mm-unstable v2 2/5] mm: don't hold css->refcnt during
 traversal
Message-ID: <qh77aw6nnsytwtux6f2bkzmene3fzrh4skegvqktlw4b47jgea@oxovqnsrulef>
References: <20240813204716.842811-1-kinseyho@google.com>
 <20240813204716.842811-3-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nj7zfqzlclqebzss"
Content-Disposition: inline
In-Reply-To: <20240813204716.842811-3-kinseyho@google.com>


--nj7zfqzlclqebzss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:47:12PM GMT, Kinsey Ho <kinseyho@google.com> wro=
te:
> To obtain the pointer to the next memcg position, mem_cgroup_iter()
> currently holds css->refcnt during memcg traversal only to put
> css->refcnt at the end of the routine. This isn't necessary as an
> rcu_read_lock is already held throughout the function. The use of
> the RCU read lock with css_next_descendant_pre() guarantees that
> sibling linkage is safe without holding a ref on the passed-in @css.
>=20
> Remove css->refcnt usage during traversal by leveraging RCU.
>=20
> Signed-off-by: Kinsey Ho <kinseyho@google.com>
> ---
>  include/linux/memcontrol.h |  2 +-
>  mm/memcontrol.c            | 18 +-----------------
>  2 files changed, 2 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 90ecd2dbca06..1aaed2f1f6ae 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -75,7 +75,7 @@ struct lruvec_stats_percpu;
>  struct lruvec_stats;
> =20
>  struct mem_cgroup_reclaim_iter {
> -	struct mem_cgroup *position;
> +	struct mem_cgroup __rcu *position;

I'm not sure about this annotation.
This pointer could be modified concurrently with RCU read sections with
the cmpxchg which would assume that's equivalent with
rcu_assign_pointer(). (Which it might be but it's not idiomatic, so it
causes some head wrapping.)
Isn't this situation covered with a regular pointer and
READ_ONCE()+cmpxchg?

Regards,
Michal

--nj7zfqzlclqebzss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrxyJwAKCRAt3Wney77B
ScF3AP9cGpM5R3nEkhyTYVHmwEk8lBkIAZEhJSg7XT8+mjoBAgEA8MHPEk593wkd
iR6vP0rVJwmIoAqYDttw3aJO8G+bXA8=
=7ASr
-----END PGP SIGNATURE-----

--nj7zfqzlclqebzss--

