Return-Path: <linux-kernel+bounces-448255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF1C9F3DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6437A3D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2C81D89F1;
	Mon, 16 Dec 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Hx1r7iH6"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAA61D63C3
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734388609; cv=none; b=oPskY+vZl1bb5wT3mlNC3FmceNz20yxD3hfY2uxWkeev3ouZFf75Zt0IAKEeSRc7IlVbEpUQH/JpUW+yv3kb/vMLbvfuWVuXgU/pemfokOfGj4kFIj6fg2+Yac2M4kXpC1Ak951drdAfG2vd4kodrXd6r6wOrITu2O2lyD0Fe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734388609; c=relaxed/simple;
	bh=inXzpADGtPHeGwpIoq82t7ervJbwbUJ1Ucksm7CAcpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeS6n5LLfD7ZUaNp5wvpxEJaMbNQ3G0UZKeLLo2Hj71Lnoc9etBNfbaWtkLmkbeyg68bpnZK2GO0dJ+fZl21SjCe9APnW/84akRdzxrGvGIrsQxNVgLiV97O3O4OgJ8YLACjiXfbd5Q7hHWtOrGKYaYHqr33DRo3cl7weOCyWJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Hx1r7iH6; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so1557274276.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 14:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1734388607; x=1734993407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6os943Of1tDvW4uLJhDpBJWnflWuQy9vb7Ql1c+OMI8=;
        b=Hx1r7iH6fuT9WUUT8NxqnvhN35feMGRgJFERW9leSKxzbgFT3U19bwRB3yeE7vF5FY
         8JPLeEn4ERUkmngOlQA+H2fWT/hgmeceuSl92+g3OGX/hVVy0Ybgf7XB/31T+mjl3qcn
         WtvJ0miFy6fCRuVI9ZSNqATTchW+b2M2BI33AAxPmR/SxYmeriDdGbLIJqKZyfXbf97x
         XMdOPtfaLtIRQF2i+w5G80Xp4gMnF3Lu7o4ltf3A22q8RfwOz4+0k4eGtJ/mQXZePy0r
         ZLbGu22l8o7h9rm9AJAsf5s3P2hzO8V13zb6fTjyAkwoUdES4RoqeKvC3zSMVgKAnXh0
         090A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734388607; x=1734993407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6os943Of1tDvW4uLJhDpBJWnflWuQy9vb7Ql1c+OMI8=;
        b=dPUNKHj6/r3ic9TnnlMEXrORbsnhyIU2g/6N3nzBoVFCvr41cl+6+eeCL1s6pOngj4
         uFKX82b4XrhBhGl1PBPTanrEAEj0GCApW91t3pdCK1xxTxqMTukYo/In/bokDXOrTNVL
         KOoLw1N917wvR8kF7JWYbBvqYq0dlSyy5XRd0PbJlNW1pTpl4+adioxbW1ndjA7dhUXY
         7c9fINICvSIt5z4ONdpSQ4wFT3j9tjbPpCGIFax4WF5Fz/bkxxA8+kMR2kJDXuQhEzTn
         vfRmitG1BDLHUjp1QKDQ/745kAaGzPi5gaTibMevTFY8AuYRcuS1CCWTR792giwi8DAg
         KirQ==
X-Gm-Message-State: AOJu0YyPKaVZTyV4rXsOfJzU/bUj3QAN6jNb4cmDBmVcG0KADm/c1k2Z
	k6FxIUIhO04R7dnqkXh3fO6MiXqnFbcZfwvXlB3FDf+Lqh+cfTZvfe8QAYCXJ68WB87z6Bkzifb
	rkA9UzhmDlYN5dz0j1imI/JAoNrl+vIEu7CZz
X-Gm-Gg: ASbGncu7z1yCQye5xhGBzw2silGVKkiUvTc81SMwdRkTGMwOYYmRCh2GDmvjrPJuFdg
	2S1NDYoJiyWCGqaKvdvBfmTOzdlW5H5lyKipa
X-Google-Smtp-Source: AGHT+IGVriorONirNEnIESXzmcduoTaMMyac5ha0vL5v2Xs4ij2bd9mHXsOFZQyFChVYPtOE00F/28qDUhdAj1sz3WE=
X-Received: by 2002:a05:6902:2785:b0:e39:8882:9ca with SMTP id
 3f1490d57ef6-e434a354f87mr12874245276.13.1734388606735; Mon, 16 Dec 2024
 14:36:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216174959.723936b0@canb.auug.org.au>
In-Reply-To: <20241216174959.723936b0@canb.auug.org.au>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Dec 2024 17:36:36 -0500
Message-ID: <CAHC9VhRHMd2VUeDj0+cVLa=jyQdOsATVgiAYYEYbhmJ7-EL=iA@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the security tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:50=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Commit
>
>   8cd7488492ef ("binder: initialize lsm_context structure")
>
> is missing a Signed-off-by from its committer.

Fixed, thanks Stephen.

--=20
paul-moore.com

