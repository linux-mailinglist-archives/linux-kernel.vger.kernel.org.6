Return-Path: <linux-kernel+bounces-551625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A67A56ECF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A22818921C4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EFC23F434;
	Fri,  7 Mar 2025 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bKNoPmce"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AF664C6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741367605; cv=none; b=K9OF4K2f85zxqCv/0t/YI/nJPV7cqzs181G4yBwi/S23Y/Yit480YVMDIXPj0AN2cuS+q+/wQF4YwPSE8xEqxRtbIRp8fyhUA47k7DCPS5Lz0TJa7QW+c/gVn8PgWK9AyCIz3xqZiSVljnBVv8Z9U7JF0wLXGYViKUZWw/7vfK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741367605; c=relaxed/simple;
	bh=zyEda87EiO9SZgXcIrtFswmtuewymM+H3mdqEU1aE4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=o3mI/dv852+zoR0mMdfLKXRpytZnX5EVpyZbbOlzkRBIVsX9cRb5kbTztLu27ofFdHRkcVbTvbeEZBJiXOwDRtzI4hcNfjSPjs97O4FTonOdH5IGIkI6lyd5qJMFboeAD8zq6lTxrnBy61GpEE3GTjgziEtdz3Zmf12GIceeLNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bKNoPmce; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e461015fbd4so1478042276.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741367601; x=1741972401; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S49FbAWmDPAgJE/oAbV68GaShaPYtOqhE7rqbBh7qI=;
        b=bKNoPmceUmxNFSHjD5fH5HTaD/MDGfaUg/fQhcNpc22QIHKsBMFwttyIC16BStf15q
         ffFL2NlEWdpnRYQAg3kaqDYHIJf26zXB5ZOJ0YjjIDArBz7mHrAXRb+CU0NTN6LLVtPT
         IYUbhDrns9X/CLn6LJF2LZ1FfXt0wZqktfDUXR3/45gACvGBTqi59q6AGZBvcDqYVQ3Q
         MImleZJxdqvNb4uUtddbXdr95TqJQEqlDuNLQnWyX9bzOKlvHAQ3DX91Chs87J814GtT
         UCib54LNMpR16wVK3bgMt6a5ZwR0Sgtf1y49DXmGasfNbCL0HKdcvn1GaXe9EitMJgTW
         q04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741367601; x=1741972401;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S49FbAWmDPAgJE/oAbV68GaShaPYtOqhE7rqbBh7qI=;
        b=WvPK2amy4VFB5vSzNitE//B4Z3FAzmtg0tVLyoigZS1gNQZLFce/WiE/ntJ+LP5pCP
         AbI1dBN5zdZwrSdiz1AxRrIyc29Nhxcdf1u9S4vJIWUR2gwEXLmPHx6YIw+WYtz3NIn+
         BF+xn+HaSB2vhSkZ0gAe4BG5+fpel32dA/ZJxiQBGea+lP27XkYQpzPnUR8z13iInWz/
         2WGiYXDuXUcGVsa2Ig0dgjF62v+QXEFjsMqtkeXLeKIBKREB/+IP0o7oX97HlFCaP2AO
         Vf29ASBmpexYYsoYWq+DdAycrkjf8A1EOjsXIzByQBMSomQQWxj1mWuuQ6IHf41IVdqQ
         Hv7A==
X-Gm-Message-State: AOJu0YwgkL1JCRjCOZ/IwwjUTdRsWcaMVfBA0WA8gZ1oMVbfzUT5aSnR
	PSmGp1pfg3pwIFsB44BWl4emQdbnZQl5ZRh5s65R8tB75YxG7j2JTD29uDPMy9ucsSVrlnL4Tyc
	6IZ7qCuiw6gObokc/zR4RaK+ndgZVUBWqhUEagRKpq2pJS8U=
X-Gm-Gg: ASbGncv4b84Q1VnvmKxJK8vJTMk8xczuFLFrvU8R2aw6ctM71os0jwmu/BwI99Z9GWT
	fYe8B3O4DSGc9MUAvSctln+URxuR2+NOZVIza/S7wvcN3PmTUc6FaPzFjTtXUzTs5db6f8UJ0Jv
	6P1hzhmYHDvvqrsmSIc/Vcmm3CKQ==
X-Google-Smtp-Source: AGHT+IFZrcJv3DKH8N6mKzfALP9vldTvOQNZ8fUbwS7RCNKpJm8DuIWRxIESP30rLGZ3T+fRUPo8Z8hpS3iDl7k169o=
X-Received: by 2002:a05:6902:2805:b0:e60:9d12:c1e5 with SMTP id
 3f1490d57ef6-e635c1d8d02mr4575004276.36.1741367601049; Fri, 07 Mar 2025
 09:13:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304222304.214704-2-paul@paul-moore.com>
In-Reply-To: <20250304222304.214704-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Mar 2025 12:13:08 -0500
X-Gm-Features: AQ5f1Jrh7gd2P5xNLqeBO5M-me2kPDDYAuqauHazRQMXvPgY8cCGhwVzpDIzO-A
Message-ID: <CAHC9VhRW4Be+uBbtgCRvSkUj1-CtYFZ9jbD9MZM70i7GhF624Q@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
To: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:23=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> The lack of an explicit credential (kernel/cred.c) entry has caused
> confusion in the past among new, and not-so-new developers, about where
> to send credential patches for discussion and merging.  Those patches
> that are sent can often rot on the mailing lists for months as there
> is no clear maintainer tasked with reviewing and merging patches.
>
> I'm volunteering for the cred maintainer role to try and reduce the
> confusion and help cred patches find their way up to Linus' tree.  As
> there generally aren't a lot of cred patches I'll start with simply
> folding them into the LSM tree, but if this changes I'll setup a
> dedicated cred tree.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)

I haven't seen any objections, or any other volunteers, so I'm going
to go ahead and merge this to send up to Linus during the upcoming
merge window.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 896a307fa065..68e4656c15ea 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6139,6 +6139,14 @@ L:       linux-input@vger.kernel.org
>  S:     Maintained
>  F:     drivers/hid/hid-creative-sb0540.c
>
> +CREDENTIALS
> +M:     Paul Moore <paul@paul-moore.com>
> +L:     linux-security-module@vger.kernel.org
> +S:     Supported
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
> +F:     include/linux/cred.h
> +F:     kernel/cred.c
> +
>  INTEL CRPS COMMON REDUNDANT PSU DRIVER
>  M:     Ninad Palsule <ninad@linux.ibm.com>
>  L:     linux-hwmon@vger.kernel.org
> --
> 2.48.1

--=20
paul-moore.com

