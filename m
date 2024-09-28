Return-Path: <linux-kernel+bounces-342295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2997988D30
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694F0282BB5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100281F5EA;
	Sat, 28 Sep 2024 00:39:31 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A01EB27
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727483970; cv=none; b=W6jg1O1V5G3F2Y4eW+IxA2ArAN/O3lYJEeqGJsrekg5MLiNidndDwLzqoW9bPUos2K5mYiEirRSNlM7Y1aetuVYMWZJ2k5QufbKemPdLmfpb+r451gcpSM6b2I9PZFGL0BjAKC0vb5YTKLpPD1jgyr3qwUIsUWhzJ/heXoOuWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727483970; c=relaxed/simple;
	bh=c/ciuv49jwuFWqETgx/klYPmKfmZTkIM7XV4gHvneRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7jt2n7qqFAIKdwXVkfFjkbuPrul5rChI6XCSZ/NgkwRdZHDcZZ45nDSgr6YZzGJFWjnkFS24DwOOf7KBL5sFsiZd4viMF4CRZ/WbbcR4hMc8kmr4sey7SSh4SACOEbeuwwnOxEgNAUbpCyYy6mANbNsfbRE8JbcGw8eyh/ig5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a0c8c40560so11300055ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727483968; x=1728088768;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/ciuv49jwuFWqETgx/klYPmKfmZTkIM7XV4gHvneRs=;
        b=GWTMrXAV+nP36jbQAmtZPcBW/2cDC/fecRV0bxEl2LZ5O0mosrweCFc3u/MUZhzjkd
         A975C9wctx2+1Og1jMp2JSMd8yJWA1+bSznsWhmcvbAPoERw0Ehxia5fjnTyvjXP6qQs
         EUlit8Vgydrj4crxymYYbNnI2lGbdpC8xl+nDdbTS5aVA9E9dWfnhcuoR1pyBxYF3Q9W
         +WUX+eHIRljWTGyMtVGfKdkT2J2hb3ELGvupeyen3p0hZjAaozq+Z5D2p3CpjPHNL3d/
         uaUaNeBMyRGDwYvNCq0i23wlqoJJ7nCe7jpUvTQWxyNP+zYhORTBNgnO+XOejlViV/jb
         1XBA==
X-Forwarded-Encrypted: i=1; AJvYcCXhWZQ/pMjrJ0v6pPbtgs5oBj0OAx7C2g0+8XbYxal6LNXINgAX5sLSS1LnHiEopV/N/9Hllusv2A28zdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXp1g4BZch2k24yX6Fi+L/1YnMGaQJ3MNZHlJEJkjvMxAD1E/6
	AKDSmYTNRFv0ohhIxPRN80S8HuOfx9lto2AG5Z5H5B1B9u+2sdApke60TA==
X-Google-Smtp-Source: AGHT+IHF2P+k1aONr/o/7rmxbHV9XTU9YixEymu1uYIStXD/EHgi4N0WvZlpqTSpBSZ/g88VCs4g1Q==
X-Received: by 2002:a05:6e02:1a4b:b0:3a0:bb8c:bd0 with SMTP id e9e14a558f8ab-3a34517fa15mr40841935ab.12.1727483968160;
        Fri, 27 Sep 2024 17:39:28 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9f55sm787709173.166.2024.09.27.17.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 17:39:26 -0700 (PDT)
Date: Fri, 27 Sep 2024 19:39:24 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, sched-ext@meta.com,
	Daniel Hodges <hodges.daniel.scott@gmail.com>,
	Changwoo Min <multics69@gmail.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Dan Schatzberg <schatzberg.dan@gmail.com>
Subject: Re: [PATCH 3/3] sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED
Message-ID: <20240928003924.GC2717@maniforge>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JxSO7hcOnYBdCJrz"
Content-Disposition: inline
In-Reply-To: <20240927234838.152112-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--JxSO7hcOnYBdCJrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 01:46:13PM -1000, Tejun Heo wrote:
> scx_qmap and other schedulers in the SCX repo are using SCX_ENQ_WAKEUP to
> tell whether ops.select_cpu() was called. This is incorrect as
> ops.select_cpu() can be skipped in the wakeup path and leads to e.g.
> incorrectly skipping direct dispatch for tasks that are bound to a single
> CPU.
>=20
> sched core has been udpated to specify ENQUEUE_RQ_SELECTED if

s/udpated/updated

> ->select_task_rq() was called. Map it to SCX_ENQ_CPU_SELECTED and update
> scx_qmap to test it instead of SCX_ENQ_WAKEUP.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--JxSO7hcOnYBdCJrz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvdQPAAKCRBZ5LhpZcTz
ZMgJAP9ZMNfxH3fervQLW3ow9DCfE8fNJkAg4N+AlFQolz2tIwEA09dRtU4HFkjo
zSj42Vl+zWr1FUG+E/XfsGBdLEsSdAI=
=gh9D
-----END PGP SIGNATURE-----

--JxSO7hcOnYBdCJrz--

