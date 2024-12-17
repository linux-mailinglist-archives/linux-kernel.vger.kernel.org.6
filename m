Return-Path: <linux-kernel+bounces-449836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1588E9F56BB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D986164C26
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E155C1F7579;
	Tue, 17 Dec 2024 19:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gianis.ca header.i=@gianis.ca header.b="sunqxarp"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799831F75A7
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734462926; cv=none; b=ZdOy6OTN7v2fSwSsm37G1p+eJsNdniG594yoghulqOQiUn7E49TdnB68ggrh2kjeBShCQjib+IUOeMSEncohoyIryETNj+UOtoqjOn2y+bf/uLLwWyATcBqtdmOWdoYH0Maz7eZyNmX8ddZns4yvzmFTIQeScZJl0L0k3J3ibr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734462926; c=relaxed/simple;
	bh=RZ3AXycBEpQLe338a0yTIM8nHTtn67uqVQLOPNADtik=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXsOhkey6K5vYCjyNvO4NYbnruiPBLxL3D0ehY2UHJOraMTeKJkOsyPvn+WH2f/Z3G0C5JmM3JUKgzgbP82rd78+bW20p7XdFmh+VGM3XrkM52Kg0cRw5BD9S4eJzIr0mzJY9fjicqpRycmNedpgVKwwQ4KeuEWHREdW+H/rtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gianis.ca; spf=pass smtp.mailfrom=gianis.ca; dkim=pass (2048-bit key) header.d=gianis.ca header.i=@gianis.ca header.b=sunqxarp; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gianis.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gianis.ca
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gianis.ca;
	s=protonmail3; t=1734462915; x=1734722115;
	bh=RZ3AXycBEpQLe338a0yTIM8nHTtn67uqVQLOPNADtik=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=sunqxarpX4VViV94esGr0pWeoRlJAd6+0/UOt2gqgK0uaKXPy6fGbNZ6XkvSU1qK6
	 9Ff023FFmlcqdz5Ap8FgxL8JULvW7kNEe3aHH6PaJ5qRslfm6i2BKavZqzwYJIW5Mo
	 UVkAzwHrsb1ocSz7RQerJPnkWFH9BbGH14fLsIewv7tfPj3oZuvPBIOwNXJMawVTRw
	 MBaPpczFfc4XIVpq2dr4mxFiWj+MkWqYshgAnZLlw0BbyVITVj2mGzTP+DSPKsW7/Z
	 FFWaPpQO6BrAoumNX/I2T+GS76M52Jl3eUyY2IEpSwphaLvxa2K0wKGhsGe4nUCngF
	 WVbnoHrm+agxQ==
Date: Tue, 17 Dec 2024 19:15:12 +0000
To: Vincent Guittot <vincent.guittot@linaro.org>
From: Dhaval Giani <dhaval@gianis.ca>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, qyousef@layalina.io, hongyan.xia2@arm.com, pierre.gondois@arm.com, christian.loehle@arm.com, qperret@google.com
Subject: Re: [PATCH 1/7 v2] sched/fair: Filter false overloaded_group case for EAS
Message-ID: <Z2HNuK_Zyfc2zZ0L@fedora>
In-Reply-To: <20241217160720.2397239-2-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org> <20241217160720.2397239-2-vincent.guittot@linaro.org>
Feedback-ID: 128275035:user:proton
X-Pm-Message-ID: ed6aaba38c6336e2ddf920dfc1c5a06f20c9d1d5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 05:07:14PM +0100, Vincent Guittot wrote:
> With EAS, a group should be set overloaded if at least 1 CPU in the group
> is overutilized bit it can happen that a CPU is fully utilized by tasks

typo - s/bit/but

> because of clamping the compute capacity of the CPU. In such case, the CP=
U
> is not overutilized and as a result should not be set overloaded as well.
>=20
> group_overloaded being a higher priority than group_misfit, such group ca=
n
> be selected as the busiest group instead of a group with a mistfit task
> and prevents load_balance to select the CPU with the misfit task to pull
> the latter on a fitting CPU.
>=20
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: Pierre Gondois <pierre.gondois@arm.com>
=20


