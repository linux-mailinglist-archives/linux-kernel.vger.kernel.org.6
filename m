Return-Path: <linux-kernel+bounces-309235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15DA9667E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151FE1C23C25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019921BAECC;
	Fri, 30 Aug 2024 17:22:14 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D7915C153
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038533; cv=none; b=aGc+jWykt2Hd+jA3sK6O1GYR7gz9H6U0FGrcVnqePJ2pkN5AUtzpLfY2JDVonDgvRDpzAaoGsuf8/mV2HjtZcaFbrLF3K5N7nIAxI5dnoeHOembWOeVRd3dcr8A7BPj58Jeju69WVc50w38wyE0/Zm+ktbb381S4Ilrw9kILPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038533; c=relaxed/simple;
	bh=8r1wLEO5RUPniQXBuZT/FjerOAiWkWZLV3SIJ7aG7s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgdlXF4fdrzhtw682httdhQzZvv+NZBfrNN6lzL+uR6YDAbEWUWWqagxazrQm7XJuc3qljcATC/MtO288YJR1E245RCraX5FiNDYzOeyQnTyLGucdo2NHdhWgs6270W7o3brwTG6KjwVLJDSN67Ny5zLttMCVOGyEKG6yNB7EnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4568571de47so9681281cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725038531; x=1725643331;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JzpTV5tCzw6fgCtdtGJgPeLDhXcAvnEc9RcvbNyC2eM=;
        b=qjBB6JZxxBEeXdYxO+bRYaDJ4Bi2w1WmLDoiKR5UNcidVWvCXJjgKMpBDzwAHLv8E6
         LclSszqSpjh3/3x5LxKJyDJnQ89qvhpumqoZU0pjdiNlwEcKrBNu3WfSPlDnaDzk5t81
         f5yx8m1yycGRlF03VfJuHEfLBmemIxO5bbx5NYEhCl5kTG58+qtn2cluQTMtTp6SbOgm
         NY6uoLrt21+aiIESSfIf6hlfc6y49ceYxNMOwskEzC7Ul374D+RPTsVYP76OzSm3JeZ6
         U+4YudElnQq/RnDku0l0ZgQxLBGr1ZwwSIgNe/q3PeIZrGGZmknXtaamP8t9C2aiCYiE
         oPNg==
X-Gm-Message-State: AOJu0YzqljoQyjflKUFPgvUgNERSWSKkaDl6aHxZRMONfUrVVdtT6Dtt
	VA1ErYKa/3NCbMmFc+z6gmXK7qbhIy6TbugSzPoo5+dZRiK1Cbi6
X-Google-Smtp-Source: AGHT+IG+iu9MHRO5GGyaIf/yAYqlj2/rcpKt9USiWZfghmIZQQURaeGmeQdbKiSyCYNpb+NIZPBO1A==
X-Received: by 2002:a05:622a:400f:b0:454:e5d3:2956 with SMTP id d75a77b69052e-45705421c3cmr1757651cf.47.1725038530533;
        Fri, 30 Aug 2024 10:22:10 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c82642sm15658401cf.19.2024.08.30.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 10:22:09 -0700 (PDT)
Date: Fri, 30 Aug 2024 12:22:07 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2 sched_ext/for-6.12] sched_ext: Use
 task_can_run_on_remote_rq() test in dispatch_to_local_dsq()
Message-ID: <20240830172207.GC5055@maniforge>
References: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IZ9uMz1aWcKywqOO"
Content-Disposition: inline
In-Reply-To: <ZtGkPKgoE5BeI7fN@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--IZ9uMz1aWcKywqOO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:51:40AM -1000, Tejun Heo wrote:
> When deciding whether a task can be migrated to a CPU,
> dispatch_to_local_dsq() was open-coding p->cpus_allowed and scx_rq_online=
()
> tests instead of using task_can_run_on_remote_rq(). This had two problems.
>=20
> - It was missing is_migration_disabled() check and thus could try to migr=
ate
>   a task which shouldn't leading to assertion and scheduling failures.
>=20
> - It was testing p->cpus_ptr directly instead of using task_allowed_on_cp=
u()
>   and thus failed to consider ISA compatibility.
>=20
> Update dispatch_to_local_dsq() to use task_can_run_on_remote_rq():
>=20
> - Move scx_ops_error() triggering into task_can_run_on_remote_rq().
>=20
> - When migration isn't allowed, fall back to the global DSQ instead of the
>   source DSQ by returning DTL_INVALID. This is both simpler and an overall
>   better behavior.

Should we also be falling back to the global DSQ if we fail the check
when called from process_ddsp_deferred_locals()?  This patch doesn't
change anything given that we'd have the same behavior before if we
failed the cpumask_test_cpu(cpu_of(dst_rq), p->cpus_ptr) check, but I'm
not following why we would need to fall back to global DSQ in
finish_dispatch(), but not in process_ddsp_deferred_locals().

This doesn't affect the rest of the cleanup + fix, which LGTM:

Acked-by: David Vernet <void@manifault.com>

Thanks,
David

--IZ9uMz1aWcKywqOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZtH/vwAKCRBZ5LhpZcTz
ZMF8AP91M0C6IfD5MdBJhBhiuqdeF/NBqE507Dq5H6Oak/zpBgD9FiikOgHClM/4
I2NsGLHuIPV7ElXiT7EjVY8MKw5xpAI=
=6qXU
-----END PGP SIGNATURE-----

--IZ9uMz1aWcKywqOO--

