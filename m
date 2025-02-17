Return-Path: <linux-kernel+bounces-518175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10CCA38B00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3023B3B39EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6F233132;
	Mon, 17 Feb 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNilreET"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796E222A4CF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739815072; cv=none; b=Xs6Ntsz2/RVMGxZF1bFHYkXv3LDe4mSRSQCl6OIE8V1DfjutSjaTyMjnhzTSR8/hzfdr/3pOGr/4/R8stK3fA/fDANZg36nXkN1AdVoHSwNnr3cyiBo6KMoLYaT0vNYgDEZZIdQ3V+9fiNieox1YR9ExzAOpr8rS6QPcPjwGjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739815072; c=relaxed/simple;
	bh=BBNDe4VDZ7B1rKJS4SghuqNUBX7l/JBij6Kgv1XI5D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxojRS34BIht7lA58kHEx1Pzy3Ui1PQUtQMLJzrEIwDDk9ZcWhuHINQH2TdWSrXDM/SfjPdefcbJzsR/DPmmtnAXEWr5KCKA/QIAGmt8P2e/CTymdk+dJZKnLACjUNSKICdCe5E9WoLN3mDSiAb/Azxos+N51yXIAfi8NusVq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UNilreET; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so7871511a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739815069; x=1740419869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBNDe4VDZ7B1rKJS4SghuqNUBX7l/JBij6Kgv1XI5D0=;
        b=UNilreETx55NatOlDR2oBk5nWfNwLiQc/ge7tPzJ9qpcWWKgv5PV0YXiUgvlTAngCU
         1ZCxzb4A6tbr7fBYsc76SI4bUCHSqEXVzzTANHjDGqptiuIE8cSLg1am019xZ6+sTqFY
         GM5dFTRF/7+aiMDULP+bqiXJFwWIoodUxfMNJPHWDkRqW/6dhswTGlq8abap75K6K8Wx
         cgYE/Zrf8dlxjYlpoF+iXMBlPpMZuxM7F/1Q3sn1C1iDQUsVfSTf12VnqMwcGKiy5uZg
         KridYPbaPCF9pmMNFHaCtlA2QJfi9epdCtO3K4C0nIQ2J0SGYr22XSY8GzbUGsU1XR81
         2tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739815069; x=1740419869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBNDe4VDZ7B1rKJS4SghuqNUBX7l/JBij6Kgv1XI5D0=;
        b=YJpAd21o8MwvOT8UgHzlNalfYuOKUoHU1EZHwCAVEsJoMNka081rO973/fRaKF2HMQ
         HX53gjOD7XNQ2O1ZDllqVwwl0lVvVltzvzJ7Suy4NdP+m/weSC0RVKWqnKwOoZDEt9rF
         tAdNdfA614xcxFFTvJVlu3Jv2J+aPLtPde2X1zisfWU67cw0bFEZpaMQL5ViQYhbUnR3
         glHa6HISA2ul+ct79Rh9eIDMtue7dVmLll/PJeK3QXKj2i8xzstGlsA8T5TxsBftMCN4
         rf+74kYtQ2PFppna+HfSy2pE/cilTRcMFMcTa3py3sI7N3I5wv1BI8mz/kCu8pmiXKM5
         dMUA==
X-Forwarded-Encrypted: i=1; AJvYcCUk18m4AS9ZcNfsRh5pCfHo5ZY2KFVXDGVc6rcjv39FLD9pWqrhrN6hO6jIgS7tSuxbMNWmrzNTsJRRfJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygcXYJ4A1ieF0RGw1LiKfhOctTXRFENEB8qfUTe+tvXZsH/20u
	EIKqrrKu1+Vt7Tc3gVm1rT/VpF/Drx3gQtuJKsmcI9UFlKUKBtlnR5Q8Rrpgx/8=
X-Gm-Gg: ASbGncvCZDFe3Kq77yHqsDPkIRnATjaXhzYLqYZUjaVTGd8HF/bM2T1qInKnHMBCJYw
	9N/kIbvx0gK68O5sH+eUWZSh9x9dLZROXhkr89NrmaynT7C/c0sZT1nHgTskf6wpOQ0drhvCLC2
	I3PNEg+JUFwEjC3Yg5KUPxS8EIqRjGe2GBkX7Nhca6AtCbaqCQzGkyR93OWuYZ/0mfHSu3qvpSP
	8kf0aazA7aJen5AsKKBSOhVayEqHASEGKQPYpwrR92PM8diIcg2X17ohPVvUYKi1+Nwx4gSfT4x
	uoS/oI+RV+P0dkCfOQ==
X-Google-Smtp-Source: AGHT+IHhLdwZj2jv74Mbs98LUBVEWhEdTq/6oUDnDWYmDroBwSv6ozcHSeV/0qNpWeUox6P6nvdeuQ==
X-Received: by 2002:a05:6402:3495:b0:5dc:c9ce:b01b with SMTP id 4fb4d7f45d1cf-5e0360f9622mr9042695a12.8.1739815068694;
        Mon, 17 Feb 2025 09:57:48 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece28808fsm7407349a12.75.2025.02.17.09.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:57:48 -0800 (PST)
Date: Mon, 17 Feb 2025 18:57:46 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
Message-ID: <t574eyvdp5ypg5enpnvfusnjjbu3ug7mevo5wmqtnx7vgt66qu@sblnf7trrpxs>
References: <20250205222029.2979048-1-shakeel.butt@linux.dev>
 <mshcu3puv5zjsnendao73nxnvb2yiprml7aqgndc37d7k4f2em@vqq2l6dj7pxh>
 <ctuqkowzqhxvpgij762dcuf24i57exuhjjhuh243qhngxi5ymg@lazsczjvy4yd>
 <5jwdklebrnbym6c7ynd5y53t3wq453lg2iup6rj4yux5i72own@ay52cqthg3hy>
 <20250210225234.GB2484@cmpxchg.org>
 <Z6rYReNBVNyYq-Sg@google.com>
 <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nesrzqfldixxuyvr"
Content-Disposition: inline
In-Reply-To: <bg5bq2jakwamok6phasdzyn7uckq6cno2asm3mgwxwbes6odae@vu3ngtcibqpo>


--nesrzqfldixxuyvr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] memcg: add hierarchical effective limits for v2
MIME-Version: 1.0

Hello.

On Tue, Feb 11, 2025 at 05:08:03PM -0800, Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> > So maybe someone can come up with a better explanation of a specific pr=
oblem
> > we're trying to solve here?
=20
In my experience, another factor is the switch from v1 to v2 (which
propagates slower to downstreams) and applications that rely on
memory.stat:hierarchical_memory_limit. (Funnily, enough the commit
fee7b548e6f2b ("memcg: show real limit under hierarchy mode") introduces
it primarily for debugging purposes (not sizing). An application being
killed with no apparent (immediate) limit breach.)

Roman, you may also remember that it had already popped ~year ago [1].


> The most simple explanation is visibility. Workloads that used to run
> solo are being moved to a multi-tenant but non-overcommited environment
> and they need to know their capacity which they used to get from system
> metrics.

> Now they have to get from cgroup limit files but usage of
> cgroup namespace limits those workloads to extract the needed
> information.

I remember Shakeel said the limit may be set higher in the hierarchy for
container + siblings but then it's potentially overcommitted, no?

I.e. namespace visibility alone is not the problem. The cgns root's
memory.max is the shared medium between host and guest through which the
memory allowance can be passed -- that actually sounds to me like
Johannes' option b).

(Which leads me to an idea of memory.max.effective that'd only present
the value iff there's no sibling between tightest ancestor..self. If one
looks at nr_tasks, it's partial but correct memory available. Not that
useful due to the partiality.)

Since I was originally fan of the idea, I'm not a strong opponent of
plain memory.max.effective, especially when Johannes considers the
option of kernel stepping back here and it may help some users. But I'd
like to see the original incarnations [2] somehow linked (and maybe
start only with memory.max as
that has some usecases).

Thanks,
Michal

[1] https://lore.kernel.org/all/ZcY7NmjkJMhGz8fP@host1.jankratochvil.net/
[2] https://lore.kernel.org/all/20240606152232.20253-1-mkoutny@suse.com/

--nesrzqfldixxuyvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ7N4lwAKCRAt3Wney77B
SatUAQDZaNdWHwjzXd9poJ9nHN5lCECypBk//h7v52pBxjbhGgEAzcXby8B//Pga
UrXQF9ErO8OmlXS3SMQq9MXR1nAU8Ak=
=C5m/
-----END PGP SIGNATURE-----

--nesrzqfldixxuyvr--

