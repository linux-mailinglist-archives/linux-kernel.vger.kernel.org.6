Return-Path: <linux-kernel+bounces-286149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 192CA951741
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF36DB22D21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D695139590;
	Wed, 14 Aug 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TP2/LV1l"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60BB1448C1
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723626027; cv=none; b=THf6tmZ+2gmrigr/oRfnbrwphTQegVrHg9uyvo07dz8X7MQ00VL1Qw9NCyqF9MBjsHZWeY2kiYRENGo4lhBfPgPFh5XhXJFbo1F7GC7KdNojXK8uRt5qoJHBxDg/D6y5D5Kl49BXyrTeRpcaj2bWYcQCn9zGCBWmoptIOhm7YIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723626027; c=relaxed/simple;
	bh=gXxlIlQ3EOincyEWslqnAwuFuJghTWyOpHUNsqq3XYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK1MedgjuniWSrK1DoMp4XIHhLOxORKhKcdWGjyjJ+GRbUc8L6PGOGVzU8Wc0EmR6msFWs/vz9Bchx4cCW/OqTHt2uF7RSCSu94lr7lKkskGLeIP5636wphqKpnUTQ+stXxmioiqQ5eSvcD4N08H8qrFZ3EHYjxfnILncVDhmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TP2/LV1l; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso62777825e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723626024; x=1724230824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pteG83gVaufdudJefczaWE/asvX/A9MjU7KHPVY3kzA=;
        b=TP2/LV1lDn2J7cQ71i6mZ22oMXlJr36MA0xyPJUI/mPL0/ifZ9DrIFkGaAVqxey7Mx
         LVF4nssshMnYsUcnpPiFs9B9gBBasnH8u/qLa7m8ZpFhW0JMkA4UP3J6wklvzUbf3qQG
         eFhMaj5V+3NVVaAtUAy9m1re46lkvx0ibGUBfXZZyfpnzzJNFG1xMPLgmJi6CYb2cXZs
         SvOFILZzyHAhiPTdTLcMdAYe74vT0+xypeQDODU9Dv8ZVwsc/ZIzhCIMwm0ah34qi8yC
         M1TSc4BXbDBuqQiASWB0HdrrdqnTGaPWXdwP6sDgPsOQTg0pmDRenjALQUkGXRYakwRa
         IsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723626024; x=1724230824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pteG83gVaufdudJefczaWE/asvX/A9MjU7KHPVY3kzA=;
        b=coeG0RjLj0IfRRFGRoSCdJxQk33pOO5JKFeEQKU7qxmbb5zwEU+mwQ6ZTvtbqZW7P1
         6HMOI6cAhjsEvt9JtHuqF8z/kfQzgdQoRrRQAR81tfZJ5XbZDMr03vZMfxK7ed3KvHk8
         +/XQwsQG5POUxmhS7z5qTqjdS43+qfaZv9AsnBnyfxmP3hA6EIQMDcf+q3jNptqfLPis
         wjOBIoCwOLVlhPjAv/3YgUSGUS2svxqsWrEeZ6ztwXj8LpPY+lyL69pDcfPOFwK7q63J
         MT0PSNUjYBmqFC+l1itLilED/Ae/6HXNpjo4W1mhWWPimiBfUj7dupoEdsNX9IsT7STe
         ou7A==
X-Forwarded-Encrypted: i=1; AJvYcCUVde8iy4vqYOvTA6JZJ6HkbkhBMYATxUh5wmc9ekob0hJ4SO/ktatEdP9fK2whj7TYd72HvuakWdULRKxbcVffNrg0su/N+zbdTfdD
X-Gm-Message-State: AOJu0YyEEJ2Y3sudRbAKZA7zmbjWUT9DEMKPB5Biv/s20YPqeZqwQ+US
	53ettc/wnZUSRinh+fBDII3hcxtiht+wOTIRIu3+rMK3xegwUkUY5PryWJ/TshQ=
X-Google-Smtp-Source: AGHT+IEfaKgysHFnacwzzzTQKgCJVEmQuk0aPxOC7j04talTUiUX34+7xIMMplZhDYBWthouaVkhBA==
X-Received: by 2002:a05:600c:4706:b0:426:6fd2:e14b with SMTP id 5b1f17b1804b1-429dd2365c1mr16103745e9.11.1723626023923;
        Wed, 14 Aug 2024 02:00:23 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded31e19sm13324485e9.15.2024.08.14.02.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 02:00:23 -0700 (PDT)
Date: Wed, 14 Aug 2024 11:00:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Subject: Re: [PATCH mm-unstable v2 4/5] mm: restart if multiple traversals
 raced
Message-ID: <zh4ccaje54qbi6a62rvlhclysyaymw76bona4qtd53k4ogjuv7@tppv2q4zgyjk>
References: <20240813204716.842811-1-kinseyho@google.com>
 <20240813204716.842811-5-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7u5m3mmofm2gmeqj"
Content-Disposition: inline
In-Reply-To: <20240813204716.842811-5-kinseyho@google.com>


--7u5m3mmofm2gmeqj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 08:47:14PM GMT, Kinsey Ho <kinseyho@google.com> wro=
te:
> @@ -1072,21 +1073,26 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgr=
oup *root,
>  		 * and kicking, and don't take an extra reference.
>  		 */
>  		if (css =3D=3D &root->css || css_tryget(css)) {
> -			memcg =3D mem_cgroup_from_css(css);
>  			break;
>  		}
>  	}
> =20
> +	memcg =3D mem_cgroup_from_css(css);
> +
>  	if (reclaim) {
>  		/*
>  		 * The position could have already been updated by a competing
>  		 * thread, so check that the value hasn't changed since we read
>  		 * it to avoid reclaiming from the same cgroup twice.
>  		 */
> -		(void)cmpxchg(&iter->position, pos, memcg);
> +		if (cmpxchg(&iter->position, pos, memcg) !=3D pos) {
> +			if (css && css !=3D &root->css)
> +				css_put(css);
> +			goto restart;
> +		}

I may be missing (literal) context but I'd suggest not moving the memcg
assignment and leverage
	if (memcg !=3D NULL)
		css_put(memcg->css)
so that the is-root comparison needn't be repeated.

Thanks,
Michal

--7u5m3mmofm2gmeqj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZrxyIAAKCRAt3Wney77B
SYKsAQD5fmVCdF+nm0mGrmT0+x5ogK2m8VCEriQpCK6PmawfwAD/Y5ceRaiYsOrt
WpZ551lbq/yPf1Dnfxl8y42Xq+Ogiwk=
=Q7ol
-----END PGP SIGNATURE-----

--7u5m3mmofm2gmeqj--

