Return-Path: <linux-kernel+bounces-226399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB131913DD3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0E528208D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2226E12FF7B;
	Sun, 23 Jun 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OJrysQXD"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC00184112
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172739; cv=none; b=RGjoINXwmzeKlnBjo8dhi6k/9/+51mC7l4sh+Uio5m7CPow9prRVZvujP7FuLSJP/nG4xtHxCVC98PacN0oIYBotpYvA4dh+OFSxoxgIaNJJf6drzcBeTPUv/6aDyVuZiCWiiUCCjr7ynZJ0dV0EP8uvbDxdFnk1RIXniukqidw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172739; c=relaxed/simple;
	bh=jR9bgBA7NYYo6tH/Nt97A1fciIqhK8E1S3zhe9dCOrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FEdGcVghsvYCNyjv4JtuspTVt3bgfKQIk2FQJxconelnKIrs3eN1An9EB6BXyV0tC1VRF8NSvopUo7QIVrPg4PEKdlyYwlC8Vs+zzx8CpMVgIQh/7eT/tj3Tw4TnUttoQ9qstYVWAGoBtUAxhQHerCIa20791WAm+uZuYhSw3y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OJrysQXD; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-63bdb089ffdso27973297b3.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719172737; x=1719777537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPeK97CxUc4C62ykOIb01hARJTE5foK9XL9OL/S8HEM=;
        b=OJrysQXDMr8Q+TpDKYbyoLWzL6ZaTUyztnkfLBcDIvZfIMxfu3ZwNKU9I6+ooQESqc
         sVlcA4C/9ftIq+nj1YJsF2L/tJ4HWHdEkAF0cE5ueoUzTho+B7FT/K++tiHE1SPLBRMW
         XfnDOnQYUmQDP/9CjBxgddaqoZHxva323KvI/QCJVblsnGsEvcamvq3SokFkWP0vYbnz
         0wZXf03W6rVJk3Fg/L5TLkoW4zClP22SD8m2Ma4rdzOrCnqYcNX6szgXaET4oZzhBYFd
         qJmS+GR044F4AGl3ZKoaYCmfIT4ACSGt2pnfC1R+1b0VJ4vjX+KbhAxhLMnvNutAftqn
         N2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719172737; x=1719777537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPeK97CxUc4C62ykOIb01hARJTE5foK9XL9OL/S8HEM=;
        b=hpmhAU7AFDrri4a1tzeFZDkUoVfvS+YbaQ9xRbkmHjrQZ9iuJAgnlVeJUP7pRes9Sb
         eAi78SpccjwKotENXfdR6FfD0Vd/qx5lYcDVnMb7JIi+XWy6tb3rPlID18VmQ2YPx1Sg
         BM/qUHQp87WAj6P/c6A7yWLXrQhrsZWAMFpIKEpbndt2erAO8rmYfje9d//1strJaY67
         27q0A9wCAgSi79zfS70GBhaJshFrARLL5E76hicNQN+7UoWhB9XYvlxOSSCWBinV60qa
         7goiQ4i1EBCuyEWhrIzulEdWhUagDs98F2sExx8BCvj7DP6AZVJPqgJRNGrT6nPCp/PJ
         1oTg==
X-Forwarded-Encrypted: i=1; AJvYcCVufTA5HLlcyU32/ViOCWum52kxzIHQYs7lEKpTsGzKw2Edu1cdK9AnjrMsQ40mlESzZjmZ45J5JfOpfN5x3p9mwZkda0TZ7wIIr/k+
X-Gm-Message-State: AOJu0YxUen5ZnP0Hk+av7UmcM/W4HoTqxFY356ptVrBiy74AqDX9gfTK
	KE/b9gmSq3xLDITSYCdJXbXUcAo1P5NVmkI3de87ajDvn8pF9I6ZH5H7zxyZxYbQ3adBPeBbcwS
	voLjQqEExcGkIKAUkbN9Va+Oaa/ScrpVY0XGU7haM5guaUZk=
X-Google-Smtp-Source: AGHT+IGFA9lUJJmnMkAwMpephtbkytW9x1soWCtoiPBgCKUXz3TwA1C4YtW6H+7qK1ib8R0VW+G7w12KOnlD5u81s9Y=
X-Received: by 2002:a81:92d7:0:b0:61a:b199:9313 with SMTP id
 00721157ae682-6433f0e52a0mr20470467b3.16.1719172737018; Sun, 23 Jun 2024
 12:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <763db426-6f60-4d36-b3f9-b316008889f7@schaufler-ca.com>
 <83ef6981a29c441b58b525e9292c866a@paul-moore.com> <c59a4954-913b-4672-b502-21aa683d7cdb@schaufler-ca.com>
 <CAHC9VhRjbWuFeprjNP3r7tU27cW6bEZytWq-3XTjzoN7Ki-zzQ@mail.gmail.com> <2cddc480-f911-44e3-b415-33e0cec2964c@schaufler-ca.com>
In-Reply-To: <2cddc480-f911-44e3-b415-33e0cec2964c@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 23 Jun 2024 15:58:46 -0400
Message-ID: <CAHC9VhQBrTo5oXSc=85+ACLF044cDWUbzEt9-b89tHUzK-b8xA@mail.gmail.com>
Subject: Re: [PATCH RFC] LSM, net: Add SO_PEERCONTEXT for peer LSM data
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: LSM List <linux-security-module@vger.kernel.org>, netdev@vger.kernel.org, 
	linux-api@vger.kernel.org, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 6:00=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 6/21/2024 12:41 PM, Paul Moore wrote:
> > On Fri, Jun 21, 2024 at 12:06=E2=80=AFPM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 6/20/2024 2:05 PM, Paul Moore wrote:
> >>> On May 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:

...

> > Unrelated to the above, it would also be good to datagram support as a
> > patch 2/2 thing in a future version of this patchset.  Please be
> > careful not to carry over the mistakes we made with SCM_SECURITY (see
> > the GH discussion linked below).
>
> That's "in my queue". I didn't want to spend time on it until I got
> feedback on this one.

Fair enough, thanks.

--=20
paul-moore.com

