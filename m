Return-Path: <linux-kernel+bounces-310040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F2D9673DC
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4B31F21FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08C17DE16;
	Sat, 31 Aug 2024 23:40:07 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A72E416
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725147606; cv=none; b=cG/JkktSxl+qg9VHlYZniyMjUdQAWVK6KIamokE8zofig88QDNWTI1AqQpk2ZR3ZrwGqu6+Xr2jfx1IRq3tYci5geOrlNVzKgsInkMvH719+1VDSnEJf+aDmILG5nGe3ZmsHHgtUNomC1j/PBIWCEQsRnbVpcqKXukzkVXcxfbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725147606; c=relaxed/simple;
	bh=CepNUa6G1BKyLUXi3UkrrcwJivM4c4mZD/5+rPf8quw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoudoLo1/7rfPz96OO4TR1CJYMdv7EQL25FH5yRhc8jy860BkvV670imzhvq2eKN8cIZBN+3z4XPjwqzBsNGWoV9quRBNtqRpAgC1CStGF/UNTKcrcqCqeFAv+6oOP60ChxqGre54/s/E801fqVhPX0He2yiU0T3lEIEQ7+vK04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a806b967afso274258785a.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 16:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725147604; x=1725752404;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CepNUa6G1BKyLUXi3UkrrcwJivM4c4mZD/5+rPf8quw=;
        b=ZkJco6bn/CNwU8sw9J9BlA2zHDTvZ/UwvrpjDhU4FTR1PxmczqXoRxP7fteVqtvnkN
         BKGFHvJIWV+RBlWU20ehrR38N8BzuCKhdqXwvoOQiYmVwzX8iL0J45OOhGDrYH/Db620
         gbH+/NJIYaYu/gFpjalr+CUn/s34FmK5m153F3B6RNQTD7yhX7+e6LNeBy/oFYtwA/H7
         xtq7dR8kVtHqWtTIeJ7+Z+Vp6EyvlVxcSd7scecf2bjfwWQyRJJQImUeQULxq5fM0nuR
         3Lr/oz608dao23hGlqxh7rwzr+1Jlm1StGiaWzO4Sl4qj5fbxP+xlgnD2QD1YFoLiFvQ
         IyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxKy9IMizbVbG1ikf1+VQtZXzKB0DZlHtcuka3dEXVvjPUDCnjRNSwIopHd+BxfwPdixwfwk4+XNTS9gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcxSiaV28xE5MtJWc++pr/7V3bJqSWg2sUS2bnNqUaIgRZkRLa
	YX+g/QiXwLATRca0g68GWD7qSzR+feCHikqMHa07pjpeVvhfZJiJ
X-Google-Smtp-Source: AGHT+IFDw3sQKMQ3oWMra9JxxrcXbpcHJmLKS9junO8g4AzX6O/EIUQmLFjClftRMeg778F5AJ3wnQ==
X-Received: by 2002:a05:620a:4055:b0:79e:f878:7ffb with SMTP id af79cd13be357-7a811f0aa1fmr1234483885a.9.1725147603779;
        Sat, 31 Aug 2024 16:40:03 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682d9f993sm27038941cf.89.2024.08.31.16.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Aug 2024 16:40:02 -0700 (PDT)
Date: Sat, 31 Aug 2024 18:40:00 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] sched_ext: Refactor consume_remote_task()
Message-ID: <20240831234000.GB70166@maniforge>
References: <20240830110415.116090-1-tj@kernel.org>
 <20240830110415.116090-3-tj@kernel.org>
 <20240831040516.GA70166@maniforge>
 <ZtKrISQNxZIS9JVO@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eAz9o3jw2tULQpTV"
Content-Disposition: inline
In-Reply-To: <ZtKrISQNxZIS9JVO@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--eAz9o3jw2tULQpTV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 07:33:21PM -1000, Tejun Heo wrote:
> Hello,
>=20
> On Fri, Aug 30, 2024 at 11:05:16PM -0500, David Vernet wrote:
> ...
> > Not a functional change from the prior patch, but it occurred to me that
> > if we just deactivate like this then we'll also fire the ops.quiescent()
> > callback in dequeue_task_scx(). Should we add a check to skip the
> > dequeue callbacks if p->scx.holding_cpu >=3D 0?
>=20
> Right, migrations shouldn't trigger quiescent / runnable events. We should
> be able to suppress based on holding_cpu and sticky_cpu. Will look into
> that.

Ah right, holding_cpu on its own is of course not enough because its
whole point is to avoid racing with actual, non-migratory dequeues.
Thanks for taking a look at that -- in the meantime, this patch LG:

Acked-by: David Vernet <void@manifault.com>

>=20
> Thanks.
>=20
> --=20
> tejun

--eAz9o3jw2tULQpTV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtOp0AAKCRBZ5LhpZcTz
ZOxlAQC18eBgPWEgc3ngzvrjzq1puBjxay08SZ/7RKxg9wEHEAEAjLC8biDc4/yC
Bky5oJjL27XOSj9AUJmzDt3U+llYTwg=
=ufwy
-----END PGP SIGNATURE-----

--eAz9o3jw2tULQpTV--

