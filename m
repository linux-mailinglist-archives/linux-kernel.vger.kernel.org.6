Return-Path: <linux-kernel+bounces-341060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A60987ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63315B2596C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB8188CBE;
	Thu, 26 Sep 2024 21:56:50 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AED188CAE
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387809; cv=none; b=nCt0S15DU/0f+Dyq35sgMO/P9lBQRtLqNzfN5H9yDWRuM6yFpIV6FZAHL6OFdbtIn/JlJmqRNLEZWXvOw0Y/CpWhKMTYyhSLgDfgG9s6QG9mTaAq30qBRh/xM3ZcrOF43eXD+IMHyGS+S/D82J24POj+pgKhNT2sHqEPdOBQZ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387809; c=relaxed/simple;
	bh=LI6lwKRCMqp8Bb9kQ+fM0DmcQawI/KUqEiyaN0Rpjf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaj8BjMwe1fJkiT6WVUmHMdqgv1etPWupKeCsyXmFUunApRM8waSYErrpCgPcnDCQvGZvd395Er+HR+imcGaD7a2QFbGgJ5XDFtMoyNTHEAi4ZvM/2RCknnswm9Tlww8Xh9wKqQD9gVffhwIdVikpvvtgpcPICz6dCpYJA77i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a34517248dso1408305ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727387807; x=1727992607;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LI6lwKRCMqp8Bb9kQ+fM0DmcQawI/KUqEiyaN0Rpjf0=;
        b=NP4KMeEXB1cH08Pfw0FjISBJ4tWW47yhDO1BhfknVNMrTAU680OTRRB0byajkZbkdL
         eE3mzeGtuspSuOgTm2FyEBvNSECHV3Vf3RML66akZraGEPOcQkgw5xEoeE8PB/xP3qAD
         XKNG3oTMrNGkfftQH4mMpn4fnLNNpJ4CDbMsVl43rqAtZ07UzNeMxixzW0V/5iRjUrnx
         VfHFOc15+C60bpsq+thUrFoNn/JoEBq8YdkTxmF99c3LrRi+Ijm8RfM0Q3+dNf3ZnV7G
         jcpWXcfalj2plasUIlLY7bOVW/+Hw63pPZnKn3Jgp+ZI5o87ASCyNYv+e3tgaArZjOz2
         IsCg==
X-Forwarded-Encrypted: i=1; AJvYcCUtcoz6niDQo/6th0RIqsC3ndS+NSha3X9Ma2oWQQPZXuOrHsUz7OKjgtlrJ7ti++SpNTV6YPJrcaMRMhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1ps9NNDlDmVlpTVQzWx2ieR5+RI5zWzHs8g84yse9yMnOAtu
	NsMuOvyQ+AZwNXhd5O2NGaN5WsP19ZwzFOUPyvy9NUJX9HUDY9qH
X-Google-Smtp-Source: AGHT+IG0imTSxpfW4jGxBKb+NycTneSmP8spgC1z9E3Xsg3ySilH0s6EdGFIqCzNoA3iqu8dKJzUZA==
X-Received: by 2002:a05:6e02:1a0a:b0:39f:36f3:1957 with SMTP id e9e14a558f8ab-3a345148113mr10401615ab.3.1727387807454;
        Thu, 26 Sep 2024 14:56:47 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344d605a6sm1618025ab.11.2024.09.26.14.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 14:56:46 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:56:44 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 4/5] sched_ext: Split the global DSQ per NUMA node
Message-ID: <20240926215644.GF26346@maniforge>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="beXLnesoyKoxGYxw"
Content-Disposition: inline
In-Reply-To: <20240925000622.1972325-5-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--beXLnesoyKoxGYxw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 02:06:06PM -1000, Tejun Heo wrote:
> In the bypass mode, the global DSQ is used to schedule all tasks in simple
> FIFO order. All tasks are queued into the global DSQ and all CPUs try to
> execute tasks from it. This creates a lot of cross-node cacheline accesses
> and scheduling across the node boundaries, and can lead to live-lock
> conditions where the system takes tens of minutes to disable the BPF
> scheduler while executing in the bypass mode.
>=20
> Split the global DSQ per NUMA node. Each node has its own global DSQ. Whe=
n a
> task is dispatched to SCX_DSQ_GLOBAL, it's put into the global DSQ local =
to
> the task's CPU and all CPUs in a node only consume its node-local global
> DSQ.
>=20
> This resolves a livelock condition which could be reliably triggered on an
> 2x EPYC 7642 system by running `stress-ng --race-sched 1024` together with
> `stress-ng --workload 80 --workload-threads 10` while repeatedly enabling
> and disabling a SCX scheduler.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--beXLnesoyKoxGYxw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvXYnAAKCRBZ5LhpZcTz
ZKn7AP9zMoKC7dxVU53Z8sQnqxYDcHgJ7HLB2kGNPmXoBTRjbAD/TZbx3S6qhi16
9aeREoHtpxMGKdl39ebpWvhwXRiADgc=
=MFDQ
-----END PGP SIGNATURE-----

--beXLnesoyKoxGYxw--

