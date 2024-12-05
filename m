Return-Path: <linux-kernel+bounces-432738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE589E4F9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B88167039
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F241D27BB;
	Thu,  5 Dec 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bDMJAuVg"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE641C4A13
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387096; cv=none; b=Kh7RmC8/+2m95Lajv/Ap/5GrgoVODN7td1CyAUWJ5at2INwJxWiOIwXL4FxllqjbCl1ALxG5Y23tYlOGODvkHaVPkmUYo/As9ESTSz0jRXmFGek3OJxEUOh7/ZZfLoLVUSo2VDccw4zno1RqiW2Q73tRu+Jcp7XvWqh51g1DKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387096; c=relaxed/simple;
	bh=Uo9k1X5K3r3Hc4fiemmVrrIOCep2IwuCxnhIE0FNAZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/K6rSBf9gE09V+ECvx+959tjodvqzEtjiA2CO/rZZlOrnMWjcFRiFLSqq7cY811RjBsLYeZTQogaX8s4BAr/EmMO4O/GstJqKWiMI/wWz8XlTHbZUc6z+PHI0dSzi9tS7Dh3TTGde+6MnL7p5OaS9O1bskKg1C8aIBPSTtKjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bDMJAuVg; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa5325af6a0so86652866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 00:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733387092; x=1733991892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uo9k1X5K3r3Hc4fiemmVrrIOCep2IwuCxnhIE0FNAZs=;
        b=bDMJAuVg6R7OCggMtjkmf24FjME3urx061rEFQBtX3Sw48SehiFotTnOBEMMcbge6a
         D9y5s1rbiN96e5I8Gft8ppRn8/DH4sqCluiBN30mBiCL6KKpn+su0WQ4OWyFMmGMATJX
         6jRyz6nqrXfhK+ISlQngJb8lI54OpCMe4tz5B+yxhEUfWdveTZ/kWjo+QGICE4eZHQ97
         ARR2QVVKKZ/7KSYIKhpFCOgZwDwXSGptBwThI7YLOwmTnWSMUgFJeSO8LVTA2ys1mt6B
         zXkEV1wWlCRx3z6MO0VH3jEiHlMEVGQ/+FUd709bOcvS4nz3PuJPnP9PLPJdBv8FfURL
         NVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387092; x=1733991892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uo9k1X5K3r3Hc4fiemmVrrIOCep2IwuCxnhIE0FNAZs=;
        b=fAa5WKsVgcrhp31LcKQgZmsLuxNvlQDqUVSRVh3dVVmEckIITdRIw06Fzsy0BUOU0K
         cXiRj+mnM0CSWeeFghIGdSNbmF9DMHUjmROUXee7Bk4KRRug56jgwo6HK2bx944uHEGR
         jtcJl092g8XiT7uR4TIgAIs1CTHDsq9NAfdqxoCAILi1zkriowQlhELoWvLcvVpHRX5U
         2KMl5PybFVxb5+B4DuKNCyaortKJL0Ip+apDyyc2mMMdN7isXPxS4NMOtkqqgsLCR3WF
         cSXzbvVsxvRamDg6T1sAIa8oM7lLJ6UG+5kqHny/84eDpzisUDOQ19O9x7VwWL4BD9TJ
         koJA==
X-Forwarded-Encrypted: i=1; AJvYcCVw4vGt15WiAglgZOX/WkPc3KOD85pdUEq3FG7kbLmHbcJwfl3N68CoEifqEW3NguKAOdn4e43C2xO4rq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vSOQTnSRQl6VOwxAZjRB9gh53NeTvM/76l82z9dKQMGGe1RE
	ZU+TDLMIzhwt/NL04aS93G4Qb4smNnfhIddpnCI49/yrgrjTp2SKbBxNvmKNLtw3+0GgEO5sHJ+
	Sgv1lYD3IN+Mu/IKsH1lscvzZSAaZJTdSXXKvrg==
X-Gm-Gg: ASbGnculL6iMUwrIuSvPm9QyTeTn/6CML6OYVl6MJQ5C7glqFNTbt/PMm/ZSG07VYfX
	hY9DuuOXVCWALt8Vv+T4BhlGN5gdcecLt/YOn4TDzzBClOKGgjHNLe6OsmmAO
X-Google-Smtp-Source: AGHT+IF2FUmzqqeTqCOHliK3GHeSyqq90+/gTLGnQGE6+L+NEFrr+o2g/bwcOvlBUZndiM7KCRfcrc2i2XJirDHBN4w=
X-Received: by 2002:a17:906:3ca2:b0:aa5:1c60:39ba with SMTP id
 a640c23a62f3a-aa5f7cc2f2fmr781184466b.6.1733387092618; Thu, 05 Dec 2024
 00:24:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118222828.240530-1-max.kellermann@ionos.com>
 <CAOi1vP8Ni3s+NGoBt=uB0MF+kb5B-Ck3cBbOH=hSEho-Gruffw@mail.gmail.com>
 <c32e7d6237e36527535af19df539acbd5bf39928.camel@kernel.org>
 <CAKPOu+-orms2QBeDy34jArutySe_S3ym-t379xkPmsyCWXH=xw@mail.gmail.com>
 <CA+2bHPZUUO8A-PieY0iWcBH-AGd=ET8uz=9zEEo4nnWH5VkyFA@mail.gmail.com>
 <CAKPOu+8k9ze37v8YKqdHJZdPs8gJfYQ9=nNAuPeWr+eWg=yQ5Q@mail.gmail.com>
 <CA+2bHPZW5ngyrAs8LaYzm__HGewf0De51MvffNZW4h+WX7kfwA@mail.gmail.com>
 <CAO8a2SiRwVUDT8e3fN1jfFOw3Z92dtWafZd8M6MHB57D3d_wvg@mail.gmail.com>
 <CAO8a2SiN+cnsK5LGMV+6jZM=VcO5kmxkTH1mR1bLF6Z5cPxH9A@mail.gmail.com>
 <CAKPOu+8u1Piy9KVvo+ioL93i2MskOvSTn5qqMV14V6SGRuMpOw@mail.gmail.com>
 <CAO8a2SizOPGE6z0g3qFV4E_+km_fxNx8k--9wiZ4hUG8_XE_6A@mail.gmail.com>
 <CAKPOu+_-RdM59URnGWp9x+Htzg5xHqUW9djFYi8msvDYwdGxyw@mail.gmail.com> <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com>
In-Reply-To: <CAO8a2ShGd+jnLbLocJQv9ETD8JHVgvVezXDC60DewPneW48u5A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 5 Dec 2024 09:24:41 +0100
Message-ID: <CAKPOu+-d=hYUYt-Xd8VpudfvMNHCSmzhSeMrGnk+YQL6WBh95w@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/mds_client: give up on paths longer than PATH_MAX
To: Alex Markuze <amarkuze@redhat.com>
Cc: Patrick Donnelly <pdonnell@redhat.com>, Jeff Layton <jlayton@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Venky Shankar <vshankar@redhat.com>, xiubli@redhat.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, dario@cure53.de, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 1:51=E2=80=AFPM Alex Markuze <amarkuze@redhat.com> w=
rote:
> It's already in a testing branch; what branch are you working on?

I found this on branch "wip-shirnk-crash":
https://github.com/ceph/ceph-client/commit/6cdec9f931e38980eb007d9704c5a245=
35fb5ec5
- did you mean this branch?

This is my patch; but you removed the commit message, removed the
explanation I wrote from the code comment, left the (useless and
confusing) log message in, and then claimed authorship for my work.

