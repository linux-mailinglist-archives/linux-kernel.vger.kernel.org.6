Return-Path: <linux-kernel+bounces-316392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD24096CEE0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E0E1C221AB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 06:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2BD15746E;
	Thu,  5 Sep 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOSDtUOE"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D863612D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725516425; cv=none; b=Ghot7WM+nG01cm6gakaTpJDMulOIDGiDJnQHpIgI7VbHMZQhrwETiAUR+JovwiETfV7P70QGT5pJuIVeRbQziOnHW4+7zrwnvYsAj/h2fKMUXnCYc6ORIgboIoSG1iHHHzGDCeCu8JFET09H/q3QNikGUZaWJ2yy7+Fy/wEeo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725516425; c=relaxed/simple;
	bh=5LG1d3avN5co6G6gzC32VQF9Lut496WAZe399A99cSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4Kntc/1kS+zhjcjYp/F4NceyETqMpEs1O+FMNbq/AQtzabC7Ed7Djv2e3VnnPyp3SRyB9WdNutlQFMWYRWs83avZVuouYg5+Q1G/Ig7gSpJ+aGSyHMZWggap9XKyyOo8i/ofeTH4K7OE4lXlaf7V6sJa4MPWeQNZgDgXAitZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOSDtUOE; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6c358b725feso2270866d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 23:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725516423; x=1726121223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LG1d3avN5co6G6gzC32VQF9Lut496WAZe399A99cSk=;
        b=QOSDtUOEPlKm5Fkc67GZbyO4Bxo99xAKGXMyngPoxjFAiNzyQL0JTjh9YjL9XXeBsc
         JLXgSySabUAopAqpZl/kOAC141vVYrEpUauxFfoCOH2g5mqoRr4Qrv9U+kz7ZCcVrkNf
         2LwQcm9eXNcDrj7+IIY4jNEHh0sA7tVBcjjMpfeNyt72QRxbAkAV7yghnlcNMokKErpq
         H6oyyISeF4Pi7qbKYsqJX4b/82APANFf+pBiSBUwJBhKctPAU2FZcbUnfvMnZGxlAi/z
         kfpOGA3UaQ+b7TqN1/mu+yTzCHSapPZDpz1/1Ej/vv/Ptw+RW+lqCFjFA7MrUVFDNS+A
         fEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725516423; x=1726121223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LG1d3avN5co6G6gzC32VQF9Lut496WAZe399A99cSk=;
        b=aI5mkAtC+11rlBstsEHw71Sp1p1bkCnxZqH189bE+7etc7a15HI7A3pjdjB/nIUzpT
         7BlIi12kuaAjD2HspQ74GT3OehVCmenWwvS52WKwdGdGSXfgySAYSktZy50EJuYI1IdK
         FHLi8WfpjBfp7TuYJTg0ZNLcXSijjBWAJ1Ogz6AwPJlQiv4GIfcvr+PxsSeaVEmUAiGG
         ACvBBF0FJaGXge/iEGUDijlWc2OGrTwk5heWdv6U2fOnALJPu4gQfMYh9D2MGEsR6rmZ
         TX6GUFlfD9nY1euEuM10dWY07uauYX69vH8ydtGGlEFkBuS8VKIGHOXna/rRBuwnAh7G
         dteg==
X-Forwarded-Encrypted: i=1; AJvYcCXb0e2DIaZNwL8eqWSdH51vufVuXMWQ2SofJPV3kzeEh/nll2TGclpYpvzWZmWz9wNv4RqYf45nRC+Eg6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJH6CAkhCSfyS9PHGwKtks15nZwMxoSvqWgJ2znvKveVzc7r9
	pMNFHrg5beNsne1Fvn+tDjwKE55/mO5bHhCQnxTFT03XcRduuHn8nGEVOm72ZAB6rE2zo/XcPYm
	ab/YJTnro8QbeUa0UVbwjJ3wXX4Q=
X-Google-Smtp-Source: AGHT+IGB8ymXCte18l4OE7yiIbhXNCU7V0Ne5O+JMA0juqCKhfd8whLL2b7mgE/CSWSFgutJc0fE9TPCp01kmop852o=
X-Received: by 2002:a05:6214:5982:b0:6c5:12b9:d5ce with SMTP id
 6a1803df08f44-6c512b9d761mr74759286d6.4.1725516422860; Wed, 04 Sep 2024
 23:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com>
 <CABXGCsNztS8MLteq5=fcddwuQ1TCzeOM8TdVtpJ3crK=sV5PTQ@mail.gmail.com>
 <CABXGCsMdxHJ-MLkS0pm51Sk8g0PTghsuZxmowvj5t44bVN4ndA@mail.gmail.com>
 <ffd2c40c-1c2e-4465-b26f-88d5e08a80d9@amd.com> <CABXGCsOoL5vD0+FRALFQFr3ZBpb2z5mpGKzAD5RHoW9_sb5yaQ@mail.gmail.com>
 <f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com>
In-Reply-To: <f68020a3-c413-482d-beb2-5432d98a1d3e@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 5 Sep 2024 11:06:52 +0500
Message-ID: <CABXGCsMSTsBFW=OirDszPFVOiNgyOBSh3qyzAw-Coi-McnicAQ@mail.gmail.com>
Subject: Re: 6.11/regression/bisected - after commit 1b04dcca4fb1, launching
 some RenPy games causes computer hang
To: Leo Li <sunpeng.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, zaeem.mohamed@amd.com, 
	pekka.paalanen@collabora.com, "Wheeler, Daniel" <daniel.wheeler@amd.com>, 
	"Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
	dri-devel <dri-devel@lists.freedesktop.org>, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:06=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
> Can you delete ", new_cursor_state" on that line and try again? Seems to =
be a
> unused variable warning being elevated to an error.
>

Thanks, I applied both patches and can confirm that this solved the issue.
The first patch was definitely not enough.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.

