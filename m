Return-Path: <linux-kernel+bounces-269710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B24943608
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514B21C21AEB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863F45BEC;
	Wed, 31 Jul 2024 19:07:00 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7B3308A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452820; cv=none; b=fTALnAo2XVH8KuLFFVCu8ehTVLXTF6MV6kNVHJ2tHoOkH79WSavERC6iIurLOZtynt/8QJ9rWtVGMVz6sAvE8+iwIsR9o0N+YTXm+PvnphTAykdL08a9fm+8MAz0Qi3oS4DYzl9c0uegly2Wu4KQaTj8DMWr4p3IPk282WLhCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452820; c=relaxed/simple;
	bh=ax71NKzLNgYwR4xJfLQuu4YXIdwjya6nW44kKDgOatQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmZn1IipiqsiK7EslI/LuQH1QyilaF8Iq89kOOebPv5DX8+pTPNRZzIZ4JJHgedRJ+ukCmpgKpygKiUOuKl2154gc8A6e3A+17hus+kQTEieu0doJ4pgENhNFDs6Lo7YIR3UiASlpZQqg4TjOvh1nk4n/1T2b9SCU371ANIVI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093997dffdso2053507a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 12:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722452817; x=1723057617;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ax71NKzLNgYwR4xJfLQuu4YXIdwjya6nW44kKDgOatQ=;
        b=KKQYygQd/ZMA/TB35/lfE8i8wfZk+DI0SSrj3642qOdTbJ5ZdRCvLuL/ybXCjmyHKQ
         FK8m7aI23D9+VuaIGfbn8TqUeQvDRXooVeeVBsaMkMhhkj9wXYGF16GGiTP5Sj1FZHv0
         hNXPj82smfVU1VV3F4AUjgmTBTMPufyWkajrVe/wk24SQvJxrvXVG5aS2dnGLmchlAou
         eFZfsol6CULhJ3ydobLE/uS1+0bEfBmXgJaPfFV+WtpCBM2QhBsz+cr0S3JD7wW2X4iU
         thQ+hNMsZn0znOCQaaxuxJlAGr7G56ovF6aJtRNRbxtcQ0HkQsXvP+zzQJXTIwQ3vulo
         OzAw==
X-Gm-Message-State: AOJu0YxOwwlMOB1aUm5cuPvnCWvfnw4lYIyxQILT/Okiy7AbU6XTw8ai
	jP8YmuTNYx6ce2o0COTcD4ZNnRv9o0fUOE/m9KHEQmiflhpqFjI+Oyafzg==
X-Google-Smtp-Source: AGHT+IG6ZTi5/XtK4pc5pWbxqO8UJOFPGGfiuO4SPLJZXDN2+ipAGKDXRLFG116Csc0T5xWVAmiLuw==
X-Received: by 2002:a05:6830:638b:b0:703:651b:382f with SMTP id 46e09a7af769-7096b7ae162mr113920a34.3.1722452817512;
        Wed, 31 Jul 2024 12:06:57 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94c9bsm75914426d6.101.2024.07.31.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:06:56 -0700 (PDT)
Date: Wed, 31 Jul 2024 14:06:54 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH sched_ext/for-6.12] sched_ext: Build fix on
 !CONFIG_STACKTRACE[_SUPPORT]
Message-ID: <20240731190654.GA6429@maniforge>
References: <ZqqI349WxdejfXZM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UAn270PBnANoLGw0"
Content-Disposition: inline
In-Reply-To: <ZqqI349WxdejfXZM@slm.duckdns.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--UAn270PBnANoLGw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 08:56:31AM -1000, Tejun Heo wrote:
> scx_dump_task() uses stack_trace_save_tsk() which is only available when
> CONFIG_STACKTRACE. Make CONFIG_SCHED_CLASS_EXT select CONFIG_STACKTRACE if
> the support is available and skip capturing stack trace if
> !CONFIG_STACKTRACE.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407161844.reewQQrR-lkp@i=
ntel.com/

Acked-by: David Vernet <void@manifault.com>

--UAn270PBnANoLGw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZqqLTgAKCRBZ5LhpZcTz
ZAwTAP4mHFOorXzztt+sdtKYor3JeFuaY/szwXfr7+URL8kr+wD/TrLboOdeag3h
16AhU5JJCyx8K2lIjKKtE1Jmarz6igo=
=HVMV
-----END PGP SIGNATURE-----

--UAn270PBnANoLGw0--

