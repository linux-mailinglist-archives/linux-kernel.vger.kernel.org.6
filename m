Return-Path: <linux-kernel+bounces-547223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F47CA5046C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B971E1887B6F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E218A6B5;
	Wed,  5 Mar 2025 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZEzjGrd8"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6F15DBA3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 16:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191593; cv=none; b=vCZjzzx6fKCTuzYCWSADU13oCPtegDkil47Ocn537IqAniATzVPhfT/TzbPJrg8WzZKpTgsR5Y+1Yu0xgQuWwYJv5sZnAgi0yACc3olzjcB8j/lZA2Cyz/bw1gOIhxLjJJntu6e1czBIMV9O1Y1XCMTPvicQc8nB4Sfmds/76z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191593; c=relaxed/simple;
	bh=lfd64ISt/RbrcjtvA7JF0gaXVbwwmUokpUC9i/vb/O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fv1mD61EugFj7q8+ElEo11Ph6WbkR9GynGZt6I1ELKW8XExIUrB5XMydCVf+Lv5KCAF3mQ2Md6sElQjZviXq3oQUxIwTr0K84sDNFsojpHMb0bH77HlTwfQ6TgCKYcH5DuhoKoor5hbno7jinZdDvnb71aF0uXWDSAQrTSW9gt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZEzjGrd8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-390cf7458f5so6515908f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741191589; x=1741796389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lfd64ISt/RbrcjtvA7JF0gaXVbwwmUokpUC9i/vb/O8=;
        b=ZEzjGrd8W77Dz+Gcck7iqywTksdbLXgtO58AMmFKoJ67Huug5Dt6P6ExpIYKKmPhSi
         sXE6NDoX27fYT1/qUXzaxKWDKPqkF98VL6WtldXSAOeSd74nYIrgLAiXElQ0sDXenVLr
         78A0dJ01ZgNkc1CyOtc+k3Xn661skl9qb/NL2HkcBV/yTjwN4wJau4KRWCKRM4Zkdu7v
         RtYKBP51+ym4qJWwmDwvYPYePNFNe3HYgr6scmtvj9m4KgAh4gOLSL5kFqQndFrdalXm
         qhXzDs9XJ+5ujYj5S2nRCfM9A+SSrdrYT5QunjVpqZfI6FtudCJ6TVoNJZ7CQVqBJClp
         gbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191589; x=1741796389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfd64ISt/RbrcjtvA7JF0gaXVbwwmUokpUC9i/vb/O8=;
        b=kWQj+q3rHo13sE6l9Gy2UlRiTqSHnle0PPVxiqdQ+NnrJL+qMlwPn1kyap57hVjxie
         CHChuUd629bAgGHaEUlkhQbVkYsueN5YvpEnffZr6xjVbzgViMiRopycfod5sc68vym8
         7GS/xmupR/V1Y3Um5JSv290A6Tvls/+P581C5RroGu/8COEJ7xGypavB2mQq2JRtCZgF
         RpMYtdwNX+F4h1c65NgIJ/z+GT/0zGM7bedr1jmHdX19aCPhavnyPnrxL5/V5qGsR8Ux
         m1fM/klPIlk5Lio59RcIJr0ifyKWwjdEO8GNeLWxesTgkFddhx84AJfq1WjlKuuMMItv
         +Tcg==
X-Forwarded-Encrypted: i=1; AJvYcCXFeNoXhxxtT6MJaGxK8YjI7b3/YsKn/4jKifE1Kb9nF3N7XvHKwuINqtlXlXU7XLTDqekmbtXvG0XdnbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGhHfw/A8G7CYWRmsByn66hzFzcunOOAurpTiywODasrlc1vWv
	OmhdA9d3jwdAco0WQbyAlybO7gNRS39+nRpg75kDD40RqrQDnohNrYRv4fjz12s=
X-Gm-Gg: ASbGncsthI2qk7/xfmhCYAsigglBPhdzGRvbJEd5X657Zq6B79PkxcRuHeLbo0fJJ/u
	8rOvzxb4h4iu2EokxEdtVFHpWvXCMJ1qmuXUZ+4gAM6A3UFjI9xe8nP8FNHr+LEpB6F4Nzq16Iv
	MYqtj9vWltuQ/Q4hJFMWInjirXMgpuSlf7mFI+nSx90VecxVC+7wEqkP3HSi7L+3ZY0uC8/zsYd
	Ag3Qk0buDBLJLfZHCPckwWxbjrcQcHJwtJbmsLHpLjKhlDSHMfbkytozLbeqxHSZfqUQspfvjRa
	aVbHtDbGc7I6R1BRRYUc32nsial8KQCZJolUZ2JkBv2NCgA=
X-Google-Smtp-Source: AGHT+IFoRFVOSxz4aXuAZrJ3O/Og36uum919iPEJQo0fgDe96HeJ4Jmhlw2xmiXGf0Dk1Ste551NFg==
X-Received: by 2002:a05:6000:156d:b0:390:debd:70c3 with SMTP id ffacd0b85a97d-3911f7caa1fmr3937218f8f.54.1741191589084;
        Wed, 05 Mar 2025 08:19:49 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485db82sm21108816f8f.88.2025.03.05.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:19:48 -0800 (PST)
Date: Wed, 5 Mar 2025 17:19:47 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: shashank.mahadasyam@sony.com
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
Message-ID: <thhej7ngafu6ivtpcjs2czjidd5xqwihvrgqskvcrd3w65fnp4@inmu3wuofcpr>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
 <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grdslyhitlxydqpc"
Content-Disposition: inline
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-2-7b6a6f5ff43d@sony.com>


--grdslyhitlxydqpc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] cgroup, docs: Document interaction of RT processes
 with cpu controller
MIME-Version: 1.0

Hello Shashank.

On Wed, Mar 05, 2025 at 01:12:44PM +0900, Shashank Balaji via B4 Relay <dev=
null+shashank.mahadasyam.sony.com@kernel.org> wrote:
> From: Shashank Balaji <shashank.mahadasyam@sony.com>
>=20
> If the cpu controller is enabled in a CONFIG_RT_GROUP_SCHED
> disabled setting, cpu.stat and cpu.pressure account for realtime
> processes, and cpu.uclamp.{min, max} affect realtime processes as well.
> None of the other interface files are affected by or affect realtime
> processes.

I'm not sure the changed formulation make it clearer.
What was the unexpected value with !CONFIG_RT_GROUP_SCHED that made you
change this docs?

(Please note the docs is for generic cgroup, not only root cgroup.)

Michal

--grdslyhitlxydqpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8h5oAAKCRAt3Wney77B
SZS9AQCweGn9vmr0uVAY0ditk3HYDJkXqtlv44llDojm9l8lfwEA+VwWyZAHkc4M
qf0ODOchzeAkh9aPU/wjv2zNmo43Iwk=
=/JpA
-----END PGP SIGNATURE-----

--grdslyhitlxydqpc--

