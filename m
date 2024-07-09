Return-Path: <linux-kernel+bounces-246750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA6392C62E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228DC1F237A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67277187841;
	Tue,  9 Jul 2024 22:16:54 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6955317B05D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 22:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563414; cv=none; b=A0NTVx4Z5tro2DhMLUeHRMAHDEUjOvWIlxf284WV6Pw+Y2BOJ0hfvvo9TcQeZ84SnDZOyIhzSPvOKA2Ap7d7oCKRmTOOtSbson5MdeAJUMmzw17UwHPohxQjh0HQL/PVonrCLcwjGeUudALIBjA2AtJHQcSyND/fouM6BczXCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563414; c=relaxed/simple;
	bh=EmiXJ5IBlBooNbQ0wcBUYah6KEo57w1Tp450sV6yMtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YU8ifb7VgbX3z+oOBtnJP8Fvli8VhGhsI+kLYZD+g8RESC00lgH+uXu9wmM38xoxrbhfT2OImGOXgh/qw+bvc+9b5WIL/s7CNfvPAMAzL6VB8qMRL0Y3tfcVpuCU/chPVSNeQqsqSc/msYz6Pc0ZJz9jWFhD0rXP3R66JiiOfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f02fe11aeso246523485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 15:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720563411; x=1721168211;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmiXJ5IBlBooNbQ0wcBUYah6KEo57w1Tp450sV6yMtc=;
        b=e0TPwgYB5rIXSKGlU8Lj5j8zbx5QS+zDH9XFhMpftZBLQ9B9m3Dlql3z4Sr55Eesrz
         zgEaIWwkydZWRmXGOvJ+xO7Il8dwcIrg5NTMgGGPknggO5hkH8QzjvfxIcY/dRZZHG5x
         AGO3TmHPcS953WAlDsOL4BRmPAgWe22B4/VFkf4yssBMI/wUDBiQa69YWt4hKm+CqTV9
         c7MjQc3A31DFIHUY2iMVvoX1AcQIqR8z84ZpDK88tDOpauB5yxX2GxhyWzqk56lkOy5U
         IjlGdu3IbeDof1e0/jGbJ4Fk3VTRgXhP30qqpmlYPN+ZBlmkyxmLZX3h8AIbsvoJC9r/
         Iw9A==
X-Gm-Message-State: AOJu0YwS6D38cEg0imvUJx9mPDPfLgiUQcmKgLeS3b7HAaFEsPEUU8xx
	dKYB3EKLEtiXR/BoTXMJC2IOaZKKd9+EBDpcLDUZ8kLRTJyV41FM
X-Google-Smtp-Source: AGHT+IFVMdZcYWkIwMI85LKonIa8Hb6LsxkmKE7eJ8XMMy3l/cyA0P42JwbmTid9N85cDWsZvmYpQQ==
X-Received: by 2002:a05:620a:10a8:b0:79f:1783:55a0 with SMTP id af79cd13be357-79f19c0a4d6mr376462885a.78.1720563411260;
        Tue, 09 Jul 2024 15:16:51 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902b956sm137209385a.68.2024.07.09.15.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 15:16:50 -0700 (PDT)
Date: Tue, 9 Jul 2024 17:16:48 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com
Subject: Re: [PATCH 2/2] sched_ext: Make scx_bpf_reenqueue_local() skip tasks
 that are being migrated
Message-ID: <20240709221648.GB248762@maniforge>
References: <20240709211001.1198145-1-tj@kernel.org>
 <20240709211001.1198145-3-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ATaVd2TTD277T/j+"
Content-Disposition: inline
In-Reply-To: <20240709211001.1198145-3-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--ATaVd2TTD277T/j+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 11:09:43AM -1000, Tejun Heo wrote:
> When a running task is migrated to another CPU, the stop_task is used to
> preempt the running task and migrate it. This, expectedly, invokes
> ops.cpu_release(). If the BPF scheduler then calls
> scx_bpf_reenqueue_local(), it re-enqueues all tasks on the local DSQ
> including the task which is being migrated.
>=20
> This creates an unnecessary re-enqueue of a task which is about to be
> deactivated and re-activated for migration anyway. It can also cause
> confusion for the BPF scheduler as scx_bpf_task_cpu() of the task and its
> allowed CPUs may not agree while migration is pending.
>=20
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 245254f7081d ("sched_ext: Implement sched_ext_ops.cpu_acquire/rele=
ase()")
> Cc: David Vernet <void@manifault.com>

Acked-by: David Vernet <void@manifault.com>

--ATaVd2TTD277T/j+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZo220AAKCRBZ5LhpZcTz
ZA/9AQCV7nyWj+eDlsH8gb+UONdpXXWRh846xIsxXNyIuU/X6QD+OVMKjFTUf7cO
27LZhWu2Ds7FyCe3PplVxDMP57MZ7g0=
=AEnq
-----END PGP SIGNATURE-----

--ATaVd2TTD277T/j+--

