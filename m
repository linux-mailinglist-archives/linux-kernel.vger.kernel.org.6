Return-Path: <linux-kernel+bounces-420645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207819D7FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2453B25A84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5A518A93F;
	Mon, 25 Nov 2024 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MKdrU5oo"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AC3D0D5
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525266; cv=none; b=qV8EjhwcjmbNe7JdS0sVVsdy+6Fqg+ysL/1EQny7kZQOnwTNqJ5QkxHK3zHSIo3Ep1vfqtNhrJ5duRl2dxSW4JItAeTd7AD0gZnN3rQ83KMw1JWDRfEIBD1mZtcadCqE4GmZ8Q0TbalHRPESFBJxnJ2fP7FTiU1TFTRmAcixhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525266; c=relaxed/simple;
	bh=xCD8RvClGzAMSnnHYQv40YACwVqG7KUnjAVXvpGmtF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jokc/Gk/KDlH52RbEpgDOicUoteq4ckfQsjTAG4GLWDJDtV2cvuGEwdFuC7C57M23JV+TL0s9dw5hNVVjRCeJfNLyOzw0cDOSn6TMlIDXHqiZ+bhvGMu5IOwCY7R/fsj3zSkPToDvz8Iu5i+NecXiqV0FKDT0xOFJQi3HhEKCHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MKdrU5oo; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43158625112so38563545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732525263; x=1733130063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xCD8RvClGzAMSnnHYQv40YACwVqG7KUnjAVXvpGmtF4=;
        b=MKdrU5ooq4c513v8bCyU6pBn0Zo/Rcd2cSuavl+YhsqfHK57AIaiTFnAJj6ZnYwVN8
         p7Iw9zJpfDqu7+gld8aAEsjmxQiXCWm2Q91mQG/Gw2U9cveuVLj1JwG4cw0xVpjuGdYW
         vSjpVwa6+x2zOBxV+qvyGfKuBzt4sMNttnPC225MR7p3W3wCNGO4UpzPnWasT/BBRn0W
         NvYusyIWKRVtVSDKgd3MsbznngVZQgiLpdzGg0x49Onpi2HSROZgYKCza7E1CM6viaeM
         QNF8TEPmpiiio23O152Ydxoylajb4x/D9dgQtEXIfqlLHis1jKhykMCoTdoj2nRVseSe
         uhjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525263; x=1733130063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCD8RvClGzAMSnnHYQv40YACwVqG7KUnjAVXvpGmtF4=;
        b=djhStBeN3gFsrzOyO8CBSPieSINolDO+kWZNtYHYf26k6mF4FlLYoQSz2CxWTNHIwz
         L2gXmMe1QpGcRpy/fRKm6W5Is8LHEKFJsjntJSqy3mrXdh7HSrYqqU+Bdsp6IhNN8KGs
         mWCxBb2VJmt/rVIirNs27pBjjgbsv5SMxR5lm6MsXXdV3wCDrxgjHKWqJqC2/6UCKfWL
         J3nD9aT9TqXNHHWf0brjg0nShRPDe+auIHxMkthWXQ1G5eLVq+5x9YJxuvZj6aSKVYNr
         Bx45GbSGf4muS1/DdvJ7bTmwW5cRW248CtSDB+s7LFQK1R3AFiMpDElu3jBhfiCt9t29
         wIJQ==
X-Gm-Message-State: AOJu0YyG/G+VvX463+GSOXj/3fDXj+2VzbwKUnKcmPeEeIHH5ZjfeID0
	u4MfgNfiZ237MA8OxU7tfOPJjtCs/G5NQrIphpxwvUbAjcxiSe4x0JA9m/MB8PU=
X-Gm-Gg: ASbGncsuNk8w2MI5fQyAK8fB0j9o7F5nSzGTSnXa+r7VuE6PB9cydfiqdQieiYpcbZ8
	+vJtuXYrxvBBPpt+0979lhsWAe/l/1aQgS7hymrQXOPs8kDyDL+7UvzlAkrviFuQdjH6LeAnM9p
	PlGResexIUkubOoN4hjGxLnC1v/YEIjYXSeNp2HSiStkf+F4wmDkJmc3Jz2UKfz0eSIUGoYn4R9
	6S437UJj1IATPFV+l/BM/kDS4Em3cmbcuNEHTK1K78VP7BYxvBF
X-Google-Smtp-Source: AGHT+IE+5w5COF+F5rYltE9rBlsjm8wSrfXzUTXMOPeyu62rRfNwF3h9/qxhoIjiGq3wwkGbGBFEPQ==
X-Received: by 2002:a05:600c:1c08:b0:434:a1e7:27da with SMTP id 5b1f17b1804b1-434a1e729c3mr2768025e9.25.1732525263461;
        Mon, 25 Nov 2024 01:01:03 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbf2b29sm9735891f8f.107.2024.11.25.01.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 01:01:03 -0800 (PST)
Date: Mon, 25 Nov 2024 10:01:01 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	michael.christie@oracle.com, Tejun Heo <tj@kernel.org>, Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] KVM: x86: switch hugepage recovery thread to vhost_task
Message-ID: <hbv5uf7b2auiwyjkekmtfpu26ht7ulvapnszx7rdgwoowqdcna@pwuuodkenwgr>
References: <20241108130737.126567-1-pbonzini@redhat.com>
 <rl5s5eykuzs4dgp23vpbagb4lntyl3uptwh54jzjjgfydynqvx@6xbbcjvb7zpn>
 <CABgObfbUzKswAjPuq_+KL9jyQegXgjSRQmc6uSm1cAXifNo_Xw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qqb3ia4ee5ip4zwe"
Content-Disposition: inline
In-Reply-To: <CABgObfbUzKswAjPuq_+KL9jyQegXgjSRQmc6uSm1cAXifNo_Xw@mail.gmail.com>


--qqb3ia4ee5ip4zwe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 01:42:27PM GMT, Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> I mean being able to send it to the threads with an effect.

Understood now.

> > Consequently, it's OK if a (possibly unprivileged) user stops this
> > thread forever (they only harm themselves, not the rest of the system),
> > correct?
>=20
> Yes, they will run with fewer huge pages and worse TLB performance.

Alright.

Thanks,
Michal

> > It is nice indeed.
> > I think the bugs we saw are not so serious to warrant
> > Fixes: c57c80467f90e ("kvm: Add helper function for creating VM worker =
threads")

I'm mainly posting this because there are some people surprised this
didn't get to 6.12. Hence I wonder if Cc: stable would be helpful here.


--qqb3ia4ee5ip4zwe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ0Q8xQAKCRAt3Wney77B
SfgSAPwP3u+ZalijELn3qaKxgwpOHg5xL05CI2GSCnjTPDyL7gD6AwoGjfAJWwG/
N8U5cOSctHBjzIagsgUKSPmc+aCA1wM=
=M4XR
-----END PGP SIGNATURE-----

--qqb3ia4ee5ip4zwe--

