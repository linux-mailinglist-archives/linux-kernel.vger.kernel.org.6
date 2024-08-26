Return-Path: <linux-kernel+bounces-302001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CA195F877
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76775B231E4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A261991CD;
	Mon, 26 Aug 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dB8k/zzj"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D498198E6C
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724694263; cv=none; b=ekABVGJmLOroGO8GijH8K2S8Ny/WyE90VLKT08Zf06IrLZf9FScKbu4n82vytMsf7jMUjb9Y5AVrnVWyxyrA2g7ce9KhKhXzEU3RqjOBE2h20Su+PybsQIwQ944LDNl95wQfK4QClDxJwkCVfZkovOjz5jc0nAhNsq5bUz2BQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724694263; c=relaxed/simple;
	bh=9PvgO9q1h/7D5jostK0u5lFyjCTvJr3Lx1ClGmA8R+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A/BTMvmsy53erEgX2defVi9rpOFp2dKCulbkM0pkApotkHJ4dzCjJ6aZ9p5CvG531K8HSTWsiMl22QR41N8DBWN6oFtdb/uPo4alfvw+Q0zzIlePUGZ0f+Z3o6r9lMIMja9Cv/l5WOv1uq7PRT4nqJyJcqwU45EAFEr0Ohz9TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dB8k/zzj; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a83597ce5beso709004666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724694260; x=1725299060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PvgO9q1h/7D5jostK0u5lFyjCTvJr3Lx1ClGmA8R+E=;
        b=dB8k/zzjYu7htPgPlSMTKcPAvuSbkkLbvNq+SWtgiUNoNQwY0XXQJTLaOEs1lW6N+C
         emaoWy47AJHkO7ys6SVraEpZLDathSJNnuXc8pdDOaKk7jVuZyupdBjFJ3hIh1wI52Qh
         cf9ahNH6Lcgg4e5sTnur7e8zxoHx0jzWX1xSmBn6Xl+cjyVzULMkLVhsIz6TaJoQyxXy
         TDlffmqTc1GUo6GBeK4fIQ2m/BMTYF87JxXnzmaeldZcz5rCXvNSoxsrQ7II30w3vRYQ
         v9YzTzA+r3MQT0hGgfoBZHU6KvyLdhGStM0UkftOM3mDiCkzGLfSd8nFiLwgMZRhgFmB
         4muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724694260; x=1725299060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PvgO9q1h/7D5jostK0u5lFyjCTvJr3Lx1ClGmA8R+E=;
        b=DQK9qjP1OtFjii4jIV/do/KRemkTSpUsghJY8RJq3SpIEDW922Pbb55UgSyHFbEqKG
         gNMi82UTIFRS/PuTk6x6w1K3NMAoMCnDVlWPTmZzTcPFI30kg2OMW/OzTxyep72ueYPt
         fCtldUHp4tN2RdNYF41oln0cme5jsbeOypKPQ7vRpRyhcO+mOflSgMN0oyE5gX7u0zxs
         HnPxnmy8QvK+68ZzKW3wJoeByqLkrbriO4/1D1J/htKXPIP3vkSZkYEayeooPD0wMrpU
         CHsokGbL3GhuVdz0RbWWpW4CiVvOc8AUsoqPnDkoXBH+Ed6b1+OAKFV+Nk4m10NenvRd
         hEcw==
X-Forwarded-Encrypted: i=1; AJvYcCXCNXxR3042EYoEAGWKAbXF+uBmEeNMC8WAoW/evt7NAvjIiNR6/ngnoPl6jkwWsU1Qh1xUPiEOn9xfayI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjlftPGF37eFkGV4YcBRPFf+5rIA9r777vBKMY6P6KJ9Z349Yy
	S5BCvngSVdplyDsnrqZ4Z1AkiKBevk8nMroTrM6isap3n/vmuhf/ejbSD6Ro0ScCPfb+VXI53If
	PTc+JUBa9PzpNhnW3cI2XHj5Q01EOiY4ElUYP
X-Google-Smtp-Source: AGHT+IFF9vUS8OxBejSqqMSUmmF5xUfZGKqgaHuFma/jZA9cpi9bityrwEAFiYr+xuprhQpb+9vHN3wTjTTS6P4Q7F0=
X-Received: by 2002:a17:907:a46:b0:a86:9fac:6939 with SMTP id
 a640c23a62f3a-a86e2a22b2bmr46796366b.30.1724694259798; Mon, 26 Aug 2024
 10:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826130712.91391-1-djahchankoike@gmail.com> <20240826173913.7763-1-djahchankoike@gmail.com>
In-Reply-To: <20240826173913.7763-1-djahchankoike@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 26 Aug 2024 19:44:08 +0200
Message-ID: <CANn89iJ0qNYP8zMz6jDtP2=n23emnue4m2tyJkE64QL_xiwc9Q@mail.gmail.com>
Subject: Re: [patch net-next v3] net: ethtool: fix unheld rtnl lock
To: Diogo Jahchan Koike <djahchankoike@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 7:39=E2=80=AFPM Diogo Jahchan Koike
<djahchankoike@gmail.com> wrote:
>
> ethnl_req_get_phydev should be called with rtnl lock held.
>
> Reported-by: syzbot+ec369e6d58e210135f71@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dec369e6d58e210135f71
> Fixes: 31748765bed3 ("net: ethtool: pse-pd: Target the command to the req=
uested PHY")
> Signed-off-by: Diogo Jahchan Koike <djahchankoike@gmail.com>

Quoting Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).


Thank you.

