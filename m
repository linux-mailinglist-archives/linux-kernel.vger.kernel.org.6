Return-Path: <linux-kernel+bounces-234982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B891CDEC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 17:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3712FB21C20
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB0823CE;
	Sat, 29 Jun 2024 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="5k00CWLy"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0004D1DFE8
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719675289; cv=none; b=PMGrjcyDD3ftCluq55nnKtm25BhfMInVwG3ttFc5GhATsWi2oY2UBufdIOdR7YK/GX7zCqZTJtATcI6nnBXxheMLnoZb68B0VW+WEVZbxw+oumrjCuRpzcS7zLi3t/sn7S4K0Tx37zSgaqQYrHqVpUvaFPWCumGpy15zKsDcdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719675289; c=relaxed/simple;
	bh=tcrv1emIiF0c9leopgU8fSqbwyVlehaFj8V97sK9GnE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IApP/LFCxZXapcDPLBMNsuiP2c5CkRVbbpZK31vlldzFs3oXyGWeLjeE0xiQWROWVv01LV1vYzQGr+9o0BARQokuaCFA4rs66ZiBoX5mWhgy3IdQeQCUGJytB53yxWRg8i+g8fSj/EmjlT+02Dh/vr6V8IAgX/EIXyucWtHAeKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr; spf=pass smtp.mailfrom=emersion.fr; dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b=5k00CWLy; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=emersion.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emersion.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
	s=protonmail3; t=1719675270; x=1719934470;
	bh=tcrv1emIiF0c9leopgU8fSqbwyVlehaFj8V97sK9GnE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=5k00CWLysWDqh4H/ioHlbfQgsuuaH575h0D5vgYr2/HcG2vTqNd8csabAx1f8lmeg
	 dAgneA4gfeRcru0yBxeARxyrm/hAxMb7TPjFpHHZYk8mxcDKGsVTNskqN380Maotnq
	 AsPNmCk++mFAINeHPLDwwffSZ+NFPQbZcQZDwimtiAWTSAddrVj0MM5m9gF219VMH+
	 lRoA9i0T7IiVfDQTFs53Jx+/CNkrSf2Bo/gZEic3XPQws3whrdiSXROopY5wITwuqf
	 yCtZWH8x6XfNjaAC5sMTt3yDMcL55NLkIH1XM45FLbythv19FWyFSDARLoIHhftbm1
	 wCekgVB25I5og==
Date: Sat, 29 Jun 2024 15:34:25 +0000
To: =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
From: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-dev@igalia.com, alexander.deucher@amd.com, christian.koenig@amd.com, Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch, Daniel Stone <daniel@fooishbar.org>, =?utf-8?Q?=27Marek_Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, =?utf-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH 1/1] drm/atomic: Allow userspace to use explicit sync with atomic async flips
Message-ID: <PPWhSnGWwPfxmBFtMxYf_r6jv7owTpZf43ColyQuh1tcjl9qN9lrHrYO47QVdgS2XXUeORRMlw6gNfwx67bV4MmAQ8IyKpDLe1C8UmjDcUQ=@emersion.fr>
In-Reply-To: <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
References: <20240622170951.738735-1-andrealmeid@igalia.com> <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
Feedback-ID: 1358184:user:proton
X-Pm-Message-ID: 1b2e1d26fc220e1e05526e8edebce2894d8d6761
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

BTW, should we allow OUT_FENCE_PTR as well? Would that work as expected
with async flips?

