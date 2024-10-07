Return-Path: <linux-kernel+bounces-353347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07041992C89
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2C283516
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901971D357B;
	Mon,  7 Oct 2024 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUHZhh2H"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A81E519
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306341; cv=none; b=qNXIOlaPAm7I/sZhfJHWimJS6SHP2S5sP0BKvfkvMZ18tObG3Fty+zbawVEWO0g86pm3jTXG2m2VTf/ThKfL3u2DRT3xdnj1fOzr3na3UWSNsRII6d+m+yKrStOxb5sn8dPoZGr5fQzx54vJGCjEMvZ+BNJwPOTRoMq8x9BTO40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306341; c=relaxed/simple;
	bh=gH6mSj/nGBhCKD6xsrkkvUGmYw+Z4LkigWiRH9MP5rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldDtvWEdztOeg5huIqMZ79ptr7gl5QvhxPWrpNE3rz1h+QKnOhmuDbBZi4BGm44RvHgq9aXu8yAOq9MXuzPxNpwIAUZSy44hsUWf2uX80+yJUQv381XVmU8o8Ugt5vYGIVgty5hPd72ixU1nQHFaHEGOqbiEazV4PF8Sj0Ajdjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUHZhh2H; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5df9433ac0cso2159786eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728306338; x=1728911138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ls68pjOR4FiCZoFiuF0FTRFOyUjeqlvcsABp5OxIFKo=;
        b=IUHZhh2HVxqNMRUwaXDAOzxzNn03JIiPRTQk75XjXgDPKg2ytAeq3fiIWwcFQwrx16
         mvN3tFbMh3iN33FOaqQf68oAySRiKkefR1Y6CRIY573LNzIcz4Y93Q0SeW+lYUxs5yAP
         VOiGwiZAO9FZ5UOqjUFlpgymQSn1xGRvka1cy9X3cbgmfFWA2lTHb9fY4W3Swjgh/9Zl
         PVxmvo695ZY60CyosVW7wJgb7VV91GHLSfMsHvQ3IlhQ5ZU+hW1t6XagV4E/4TGjTLX6
         jGj3j6DJhqsSVtv0HN7NVhiHU9IilXA2ICUn47iQaY63dmQrGj90jK1QzuTSR9P1R0an
         qtgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728306338; x=1728911138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls68pjOR4FiCZoFiuF0FTRFOyUjeqlvcsABp5OxIFKo=;
        b=oxWND+nyAUZu5k8IscSKRDCeZzdCecKmm6v4n7sehMwlYLzrCEavMnf6Zl0aed5iE3
         V87kJ+Cpj4Qs2CCwbVcAFzoUAicLVicJUYez8hJvYvIBFF8vObVco/zjPoXNDwqSEXMY
         RqtUtLRjCMN4ZsdQ3gwh5VqQdzDcHxXa/gXvtKFS1okAP5tauxGpTNZKvh92SesKzNH+
         kA7kE98O2IEIFL0RWfYv84JyHUzqhXqHY1QROoUsQdPoDTJmoruz4iLDx8jRiiT981IU
         gOIX94dJk9scJFWMDPVjs6Hs+1b4tYP+wxJIHuS9daFEuvuPlCCkXDy4vv0RdU7tyrFg
         0asw==
X-Gm-Message-State: AOJu0YyNTDzKP61Gassiw0xgtExuzFcxDJkBvE2y+eW+/1mt7E2sY6pA
	DifRQFNr757VgSwVSD2X8uBf8R8O9fDbTMv4OPZiZlepME1f1kdgVZWyaxzolLWo7HzSMBkKS7G
	1XPhN508cRfbSl5olOj8e616N+Xg=
X-Google-Smtp-Source: AGHT+IEUXwSisu3tDiX1Vv/KXSqN67zbc7xBbJSyhwz0AjpMPsorovurymQqh84YmQG3/pE863HIQwYgq3gRpMg6Pfg=
X-Received: by 2002:a05:6870:558d:b0:287:3cf8:4abe with SMTP id
 586e51a60fabf-287c1dafc3dmr8186134fac.18.1728306338344; Mon, 07 Oct 2024
 06:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007094438.398806-1-luca.boccassi@gmail.com> <20241007-lustig-mietfrei-b507b1fb7f03@brauner>
In-Reply-To: <20241007-lustig-mietfrei-b507b1fb7f03@brauner>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 7 Oct 2024 14:05:26 +0100
Message-ID: <CAMw=ZnSSA7F=Fth2eyTUSf=S2q1LA+UUXgO8vPS5HC6jN0E+Ww@mail.gmail.com>
Subject: Re: [PATCH v7] pidfd: add ioctl to retrieve pid info
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, christian@brauner.io, oleg@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 13:27, Christian Brauner <brauner@kernel.org> wrote:
>
> On Mon, Oct 07, 2024 at 10:43:28AM GMT, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <luca.boccassi@gmail.com>
> > +     struct pidfd_info kinfo = {};
> > +     struct user_namespace *user_ns;
> > +     const struct cred *c;
> > +     __u64 request_mask;
> > +
> > +     if (!uinfo)
> > +             return -EINVAL;
> > +     if (usize < sizeof(struct pidfd_info))
> > +             return -EINVAL; /* First version, no smaller struct possible */
> > +
> > +     if (copy_from_user(&request_mask, &uinfo->request_mask, sizeof(request_mask)))
> > +             return -EFAULT;
>
> Use copy_struct_from_user() here it's not strictly needed as we
> technically don't care whether userspace passes unitialized stuff as
> this is an output-only struct right now but imho it's just good hygiene.

Here I was intentionally only copying the request_mask field, as we
really don't need the rest of the userspace struct and the mask is
fixed size, so I thought it would be simpler. Should I still change to
copy the whole thing instead?

