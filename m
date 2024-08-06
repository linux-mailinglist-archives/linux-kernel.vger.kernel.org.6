Return-Path: <linux-kernel+bounces-276896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A29499C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21941C227BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AE170A3A;
	Tue,  6 Aug 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eb3sUuf/"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65599170A14
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977974; cv=none; b=XvNpupC3+A55j/9uhNmQ4H1b2Im7Ms1GyTRTAk4QkIOkhaGRrEYHDf6mf2GJEjmVzeUyHwJIzsRheYyOQBiTyAI28DsZbI5/Tvp3Q40TSCG2jhCysPDavFs3Gb9kkBXF1RgLn+bOpeeYV5XS+XMpSMmCliNvGh+4Ad+zEY4O9+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977974; c=relaxed/simple;
	bh=qyUz9Qqv5k5SudOvCxQPX4RBki5RQXyIqfhgrvWKdyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjSUaT/CRBqs1986reTQIKiJs7ukoVRmnNAvCl6skQ3PLNFllXX+lj+thvHjYzTUuOgTqK7s1+u9/uJvKPefdUdRGCL89uK2dp2wpr8aD/ljpttaQ8Vk4Gctuu6D/AyGNOWLV/fPPNql61U71yEXGc/v9xFzKKsvzosl3lGozJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eb3sUuf/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-67682149265so11462007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722977971; x=1723582771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=Eb3sUuf/v0kca+XnoKJZRiENpb45DUPlfGi6IMf13qoSoLYimi3mbIv6qhH8hOEh8A
         mtVov7Lo2+nWdrAHGka9zLYVA1Sjmjb3AcjWwDADP1msPFly37oB04+MJAo54CujViTu
         a1vCj3WAE+S3ZIjyJgFSjCbqF+44/OIo599KJgBo80TX+cbW1YJaofC74vUrXxBHwvc3
         sFE1L/cMDbIe99kU4N5IUeNp9/6xTDjzSbnrqVs0378SkaDdfLa0lvtM6stQdlKdcDlN
         DrmYuETjc7TuhIltjqm90BxNzaWLUuccUumCJk4/JR+ilZrg3hf3VdnUc5ty8V2xUoWk
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977971; x=1723582771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=BfupXweS9g5w6jhLXXJG8yAWhLGGsz5zRdImh379CzIr5lhyINjEvxSJu+o0Ax7F/p
         dhMbJbIRD5c5BpzN8Nu1drf5Rk4i/+VzVfjqzE5pWxGvYha4hrwuvZLu9kE98UxW+mRr
         EpddyWyFrtR/sADZwMbNMmRvpAqqOo1BRB7z9Uo8ihrR+uzYdC/XnOGcyw3Ll19kRcOy
         E+Ht3mrZ8eh3Mp2u9s9pR1SdR+81UwRVTy96mkChDsYgQx6enPvXYduGK15hthf+ACQq
         kkXZS1NS+64HLvt2RTyyLgzJtJllCqKuXhmQAjIyBPoaTry6LbwFitI8+zVTCwYKWg4f
         AuBg==
X-Forwarded-Encrypted: i=1; AJvYcCWbTs9M8bYk87RWIJoOnP2oTwXTu40je1eyootiYc39ml8S0YaajL1Zp3w36A8qtBgwkQ5CMrjEvzdBZuf5itL61d+pedfnZnWmihBP
X-Gm-Message-State: AOJu0YweGlSl0S0s4B9rebUCHyO+DkLdn/l0o092VNA3MvVrSnv74zkU
	gWF54idAn0tMla2ed3fL7A+xPA9V8n5rLh8Z3l5JV4ZzBBiXLwAGUIA08jpPxR3HzKNoCHOi4ZI
	fYipuaCi7o0GATCHu/ly/cA9H3g+Rdb+JtNd4
X-Google-Smtp-Source: AGHT+IG+g9ZPIj3c+gMV8h9nbV6S0gFWlT866BH5MDCEFMia55H31Vc+W1m/exuwqdaE7fTnf6/iUgbwZyFG5W1FJkM=
X-Received: by 2002:a05:6902:15c5:b0:e0b:e2ed:b6c9 with SMTP id
 3f1490d57ef6-e0be2edba28mr17255194276.9.1722977971481; Tue, 06 Aug 2024
 13:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 16:59:20 -0400
Message-ID: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> IPE is a Linux Security Module that takes a complementary approach to
> access control. Unlike traditional access control mechanisms that rely on
> labels and paths for decision-making, IPE focuses on the immutable securi=
ty
> properties inherent to system components. These properties are fundamenta=
l
> attributes or features of a system component that cannot be altered,
> ensuring a consistent and reliable basis for security decisions.
>
> ...

There was some minor merge fuzz, a handful of overly long lines in the
comments, and some subject lines that needed some minor tweaking but
overall I think this looks good.  I only see one thing holding me back
from merging this into the LSM tree: an updated ACK from the
device-mapper folks; if we can get that within the next week or two
that would be great.

--=20
paul-moore.com

