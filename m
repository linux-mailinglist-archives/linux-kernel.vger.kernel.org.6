Return-Path: <linux-kernel+bounces-249726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE592EF07
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CFE28218E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1116EB41;
	Thu, 11 Jul 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HStdeAhM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371D16E88E;
	Thu, 11 Jul 2024 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720723247; cv=none; b=Z+jpkkURdwZNPuB/AW3I/j7cNFrV9CJ8lQElExyII0Ne81rbKp/g0NMXFeRu9qKI/U6/vWl2TmwATUS4SHXG65crPokb0kml1LmAyMHwEoumItkqLX32nsj8DS7bqxblssrlrWAx1F961ISV1MTrPb9vIMmjpzJiaN3fdLcr55Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720723247; c=relaxed/simple;
	bh=KkzxAaKkddVCCUjlNWAR/t6qE/P/eWm3PK1qOOz6Auc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LArl4paak/gsKXYMUbEM1k1aQgfoZjKwvHDNdTsfS+m+5EWZOdXg3rrbe16gX7GpKKKWt6Cw4y22V/mW5b9MADiMH2hBw39/gpaTZM23D+XQ1SkpIrbkCTQka8GtjaBTgJu4DByhA3K0WGYgwLUmuB+Y0af9uJdxhD98hoe6Wtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HStdeAhM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720723244;
	bh=KkzxAaKkddVCCUjlNWAR/t6qE/P/eWm3PK1qOOz6Auc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=HStdeAhM+QYvH0XVo2lmWa8287cpmSi22DF/AMI/nT6TxDH1ClZDY3MpkNspXQ5gg
	 tv1J/hv+drorhLdlfcPcaNILK0ahxNoi/z7vyxdAjd0T7DJ0Vbtf5nuw6rOUNm/tQE
	 pOUuMCYXex3u1nZKhitvr1/JmfvdL3BmWR6HrSqBlVI8c5Xs8FgopVpTuyl6T1orvQ
	 1X6wc+MMczmy5D28oXsN2ah2QpUszHRkR5cpWVKjYRNX/HdM6w4i2x200TaFsd+g8c
	 Im5gmt5tJiuyPzqk2poTT6VN1DJy8sX/lBiHXX8QeiA9c3dHuvKMZduilpzlxg+NTN
	 KxjQ68PkaYE4w==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 382B837821DB;
	Thu, 11 Jul 2024 18:40:38 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ZpAO6SJ9pZ2EOlrv@e110455-lin.cambridge.arm.com>
Date: Thu, 11 Jul 2024 15:40:26 -0300
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
 ojeda@kernel.org,
 Danilo Krummrich <dakr@redhat.com>,
 lyude@redhat.com,
 robh@kernel.org,
 lina@asahilina.net,
 mcanal@igalia.com,
 airlied@gmail.com,
 rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 steven.price@arm.com,
 liviu.dudau@arm.com,
 mripard@kernel.org,
 tzimmermann@suse.de,
 daniel@ffwll.c
Content-Transfer-Encoding: quoted-printable
Message-Id: <0C74C2BA-753D-4D1E-A041-A55422947005@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <ZpAO6SJ9pZ2EOlrv@e110455-lin.cambridge.arm.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Liviu,

> Hi Daniel,
>=20
> I know this is an RFC, but are you trying to avoid Cc-ing Panthor =
maintainers
> by mistake or by choice? I will be away on sabbatical from next week, =
but
> Steven Price at least would be interested in having a look.

Definitely by mistake. Boris is my coworker, but everybody else should =
have been on cc for sure.

My apologies.

=E2=80=94 Daniel




