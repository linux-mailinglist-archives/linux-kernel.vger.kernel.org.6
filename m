Return-Path: <linux-kernel+bounces-342293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5B988D2E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 02:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363A61F22647
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 00:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB8217BAF;
	Sat, 28 Sep 2024 00:38:46 +0000 (UTC)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22065156E4
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727483925; cv=none; b=Mshwm0M1BSm7tW86YIcsqOKipzyB03a179fMJvDwYaVIMu/vZtBYpilJ/ZyvxQYDXg6fl78vfJB7a66Oew1nSdFn23jGCJArVhPp+7jS/X9tY4D+ET8AB0MuMU62DhMYvKnRrKnUxZ/QsGqxF/BuSKaHVsDkCt0l91bKbC0+hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727483925; c=relaxed/simple;
	bh=sM8WtSigPgCS2L4BLIsikC3lACERUenrzN+asAHB2CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx2fFGR/25sWMoh1J0xmdrp04MtO1a0UCjCeN9olAC87BgdzgROGWDSQNeHjL1PIHGib7JjkKA8dGc2od4GpBjvOrm5GT+BVcrSxvsssmWs+2RRS3HZoRceX8hTH/rYUlPayXeRYlnL6lH54/fa5TpToRZk2DpT7F2xp/GWT/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so9879945ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 17:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727483923; x=1728088723;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sM8WtSigPgCS2L4BLIsikC3lACERUenrzN+asAHB2CU=;
        b=jmjrEszItqsXUjX9OYZNIaz1dV1fp7odskWNL31EH7FvNNsZ7di+mFGlEUmYKFIRCQ
         6uOC1/OtlERraBZlOqf8JNRTwkEwDb67WuD7QTtfGfK7LXniUoJkFOD9KaZme/NgFeDc
         wOCSMyqmJ4o1lvOc97IkDP2/zXmNgb4ECBj9VE50W/5vACxuK1TRdk5IQt5h6Z2BHYDl
         pJLNiixudkEMQP8boONNXOsgI3AoO2K6mTL5rDRG0DIFaSwc03gRwkG98Uhs0PI9nbX4
         rbgRY/gsrrK4nvm3o2o4keMJGIGtYGwiOtGX3qPeW1iHBX6ppFp/1KAn1bEfVVDIO/Dc
         /BPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVH6k6hnK5EW9DCgt/CN1sJ+9dGzQ73y7WIU9inIdhmZbEdsnGJY0XUn58OwLObXhS0fZfx+mgahwXIqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiGAPFybdcr71AWkarmDlrbrwAOcMJl/JswZFe2E8cgtV9H7Cq
	o/T2B6msWKCtlUowoXJS2wLFOStDqx3uoXmy6lp9xJhLfHTkiNXL
X-Google-Smtp-Source: AGHT+IFN5w8v/CaWgpUmKpvbyLnQmJZ7nLA+iW7kyNsbR59T/KSMf4AMeHUq8rmIAtLG9tMeloMNZg==
X-Received: by 2002:a05:6e02:2188:b0:3a0:a311:6773 with SMTP id e9e14a558f8ab-3a3451b4ba4mr45539535ab.21.1727483923123;
        Fri, 27 Sep 2024 17:38:43 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888d9661sm781153173.135.2024.09.27.17.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 17:38:42 -0700 (PDT)
Date: Fri, 27 Sep 2024 19:38:40 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 1/3] sched/core: Make select_task_rq() take the pointer
 to wake_flags instead of value
Message-ID: <20240928003840.GA2717@maniforge>
References: <20240927234838.152112-1-tj@kernel.org>
 <20240927234838.152112-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gxEZvZMm+Os/zfMg"
Content-Disposition: inline
In-Reply-To: <20240927234838.152112-2-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--gxEZvZMm+Os/zfMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 01:46:11PM -1000, Tejun Heo wrote:
> This will be used to allow select_task_rq() to indicate whether
> ->select_task_rq() was called by modifying *wake_flags.
>=20
> This makes try_to_wake_up() call all functions that take wake_flags with
> WF_TTWU set. Previously, only select_task_rq() was. Using the same flags =
is
> more consistent, and, as the flag is only tested by ->select_task_rq()
> implementations, it doesn't cause any behavior differences.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

--gxEZvZMm+Os/zfMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvdQEAAKCRBZ5LhpZcTz
ZJ3kAP4j692RTrZwnbIgJK09LVskEshj6EC1fFKVulstmriJwAEA607EKMx+aKW1
XxmqzcNN6ga9GQ8mCwJIEyxAaWkXAQQ=
=/3A1
-----END PGP SIGNATURE-----

--gxEZvZMm+Os/zfMg--

