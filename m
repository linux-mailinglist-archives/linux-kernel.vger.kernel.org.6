Return-Path: <linux-kernel+bounces-193751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6F8D3222
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A3CB28AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B33180A70;
	Wed, 29 May 2024 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SintWRtc"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9377316936B
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716971379; cv=none; b=p6JzpgtsK4FcYRKuGvANpp+ePPv0B6ZIXpWgxSj/CIXIgH410PHon0tsFJlBlzktA9/njUiQAPiaPmxXlupAAy8A5JQEaauv+ijljluABmL/zKkm7VN7eeFD2NGlqUbhsOUVUxnFN7QMSxffqzTRIH0MvIWYbf0CX+zxvp0vQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716971379; c=relaxed/simple;
	bh=1YVdUCwouStxfwxnG32hP50AhXVdPgyiygSC//AbcxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKNZyfswN9KDIc0AGNoEKeaeFPf9xVg2FtUz9lifk38eBobr7OHeOqhJKZ7wb07ZmHBgjfp8fMARfINsHYu0zSmZx0KEP2N5nYsQqm4qPlZD/diIMH8J8l1y/CtzKiQeIpl7RyNqM6N9vkaA4yP6H0oUavK+vtioEUtcUnxlODQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SintWRtc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so11468a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716971376; x=1717576176; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YVdUCwouStxfwxnG32hP50AhXVdPgyiygSC//AbcxE=;
        b=SintWRtcydtx+Z5Gyw2nxTtEI9RjAyWtlUnkEQCsI/EvwHmU+Be7mvcukYIirr1T1K
         2DumjSqQRcBBtpRp1LhZkjMTUJ9Iq3Lo7+rgEnvGaJpvTMixFpG2OngX1CJlkwvAyFPi
         IO6zQbnGpup1yL08fn0Ev7/MwUXirH+uGKbLGikIUncYAGkUMjmOkJe/Q+itcXBh2I4S
         NKZau1nK1Nd/abk6lj6JSNUrBPOzW9nVHXzMUG25ZYAhjIjF2/4ViXtcpy9jWvhlbRv+
         pF8Su7fhUaAvLOQ57Zp/gkFo3AAsMKto+XQskzh+/26haOrO7El/0AbUAztD1zvNIpG7
         k/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716971376; x=1717576176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YVdUCwouStxfwxnG32hP50AhXVdPgyiygSC//AbcxE=;
        b=sS5tWiUhtJDZADBZ8j1re0tOS/yHvBwOs3A+Kvqhkdc+7Din4hVy9tPKmyfEf8sCrb
         k+xL6ZDMmjY/t+2Bmv4RAxmDgdQgxxehOeJFdj85HOvugX2RU1ude389K2YKCcHFC0LV
         LyCpoA7cMA3C+BXrSKnEriQtbKvZXCnaSMXWINNMNv0S98M6gniKf/AVOL+UZ6T3xh39
         j3/5qBMpGt6vzRC2uPhsXG+clxvfvJWVN0q7qnJ/m0urbOz8CT2vX/nx1lauokxqhxgV
         TvK9fkRqtcmYL3RR2sPZ+tNSZ98vAmpFKwRZu2tfpTQc5xL34r8JAkJGhdJ7KPuq4zPs
         H++Q==
X-Forwarded-Encrypted: i=1; AJvYcCUejVg3S9a9wRbZrYaGvPcKNhPSnoxjFlBd0jpIf94nAzByLLaaqlSl2Mwvb9BiKnPf/87GDPFs2v0oOUY0kcu9D4RRsXlC3xj+bZyg
X-Gm-Message-State: AOJu0YyFaNhY6mJ4r/Ec1W3tsG2NeBpp6p1e/khPaQ094L9al8dRJgab
	5lpqMHDI3001zWrlDjoKLSOYMvUFWuaVu3PtfjH0MtqLofRmJQc9qFR1mrcqgLECIAaXq6g8/hy
	7TaqlbYH+5rkdmCVR8NTmb9zON0Y7M5GzdpFo
X-Google-Smtp-Source: AGHT+IGAhtDvsJERwf3pb+t/VLOUXZcR/4+FfDaCdhT+APDm0SbJawgi6YlMKOwTLAhHnB/JKadI8zSAKP0IVHve4qg=
X-Received: by 2002:a05:6402:40c1:b0:578:61c0:eb0f with SMTP id
 4fb4d7f45d1cf-57a05d1fae1mr93618a12.3.1716971375558; Wed, 29 May 2024
 01:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com> <20240529-orchester-abklatsch-2d29bd940e89@brauner>
In-Reply-To: <20240529-orchester-abklatsch-2d29bd940e89@brauner>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 May 2024 10:29:24 +0200
Message-ID: <CANn89iLOqXZO_nD0FBUvJypgTA6NTL2dKvXYDxpMuZReYZXFDQ@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, kuba@kernel.org, 
	dsahern@kernel.org, pabeni@redhat.com, stgraber@stgraber.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 9:49=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, May 28, 2024 at 10:30:30PM +0200, Alexander Mikhalitsyn wrote:
> > A recent change to inet_dump_ifaddr had the function incorrectly iterat=
e
> > over net rather than tgt_net, resulting in the data coming for the
> > incorrect network namespace.
> >
> > Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dum=
p_ifaddr()")
> > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Closes: https://github.com/lxc/incus/issues/892
> > Bisected-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > Tested-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > ---
>
> Acked-by: Christian Brauner <brauner@kernel.org>

Thanks a lot for the bisection and the fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>

