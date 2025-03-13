Return-Path: <linux-kernel+bounces-559455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64BA5F3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80E119C3296
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A1266EFE;
	Thu, 13 Mar 2025 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lMCppmO+"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B7F266EF0;
	Thu, 13 Mar 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867893; cv=none; b=MWLMyjGGpyDcONFJx8F5RKuW61IeDAER2beB+dKxco14tnfFTjMmFc8ZpQpvLJGsoL74h6+zi67J37ogq4NKPhl5uA6pu6i2sGskM/yXNfNrSDreb/5CeeUbClP/Rl/5vCEI7KvKSK8f28u+C4j456u3nA7FkZmL6Mqv60U5I8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867893; c=relaxed/simple;
	bh=7nQe31pvC+Nq8CCk92sZBjOybCTcSBoCn6YPHX7VODo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1Qd15VoLo20rk+FvD4eTEUkOC3bvmepPdHGCn0U2n0BwEvcAQ8c++vB9t+XhRZbe9fao1Goe7xNghKr/+rS85OA670ZiCE0GSLUBcjI2U48cCQOz3KMUXpd7unbUToz62m36PiFbHWphdy4PSPPPCM93DltXwSVym5mEgpktEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lMCppmO+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/R4YONW3k4TYaz2Veaayqev9TVAocqD3do1VhSmvPWk=; b=lMCppmO+meSbVHYnYJLkHuHLxj
	aDiPqi2UT3VirHkj2yvbgT36DKjqOKOt3s4XlTyr1ORkIlNtj6Xp7TVOrCWyR24rSNy47REGUQhmA
	hrsh0/haPvZSgFavxOTKDXz/v5hTeOU3RYwFmLp6ThjoiFqBAec9zjXErFYjjI00qtVabRdchublS
	1TevUD+VKPMF4v9qKSzZtMZvyjQmXqIuCJwae+jitZQS1pqEBBMHvoILwkd0KUmiBAl9bAadq1OKS
	qoXrKf2ZDLYekq52r3XSa22NQ7szHQwFPMfAsNiJeRvOe4KckLs5Wj14D5QbPZImuYVmLxOVHoKZU
	V57v4AAw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tshP4-0087R6-49; Thu, 13 Mar 2025 13:11:15 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,  Dave Chinner <david@fromorbit.com>,
  Matt Harvey <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] fuse: add more control over cache invalidation
 behaviour
In-Reply-To: <CAJfpegtDBR4RMMOotxQC3d-pa38xNNB7ajfHrnpi_oQ0XWcTkA@mail.gmail.com>
	(Miklos Szeredi's message of "Thu, 13 Mar 2025 12:39:17 +0100")
References: <20250226091451.11899-1-luis@igalia.com>
	<87msdwrh72.fsf@igalia.com>
	<CAJfpegvcEgJtmRkvHm+WuPQgdyeCQZggyExayc5J9bdxWwOm4w@mail.gmail.com>
	<87v7sfzux8.fsf@igalia.com>
	<CAJfpegvxp6Ah3Br9XUmnz_E5KwfOTC44JTa_Sjt0WGt8cAZKEg@mail.gmail.com>
	<875xkdfa0d.fsf@igalia.com>
	<CAJfpegtDBR4RMMOotxQC3d-pa38xNNB7ajfHrnpi_oQ0XWcTkA@mail.gmail.com>
Date: Thu, 13 Mar 2025 12:11:15 +0000
Message-ID: <871pv1f7vg.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13 2025, Miklos Szeredi wrote:

> On Thu, 13 Mar 2025 at 12:25, Luis Henriques <luis@igalia.com> wrote:
>
>> Hmmm... And would you like this to be done in fuse?  Or do you expect th=
is
>> to me a more generic mechanism in dcache, available for other filesystems
>> as well?
>
> I don't know if this would be useful for anything else, so initially
> fuse specific.
>
> An list sorted by expiry time (implemented with an rbtree) would work,
> I think.

Great, thanks.  As I said, I've added this to my TODO; once we have this
patch sorted out, I'll move into that.  Thanks, Miklos.

Cheers,
--=20
Lu=C3=ADs

