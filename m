Return-Path: <linux-kernel+bounces-434284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1CC9E645D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4E01697CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 02:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D8C18CC13;
	Fri,  6 Dec 2024 02:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjKiYlf7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3617DE2D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733452961; cv=none; b=Os0uWq3J/3zh7yEs2Bh/tbodF7epicNiMWWw6tX5Buv6O6XG2O2ASHFZK8iDcOKecIXdJYADIaFB7TYHp2A4qVJeTLmbzKFmO+EGvaL6eRgrEbSh8BN4Lk03Cdq7aICaFRgbBPlagXrQ6qyphjZ5c5dON39P43rYNuXK/5EbW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733452961; c=relaxed/simple;
	bh=VapI9BO8bDoxLf+txhz8n6Uf6jhZ1jCyATxFGisXxN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fD78dpVHrJkwA3PBYqhEfka1muKzwUMJrcgKPkT6IDRrrEX44dNEguoYlyWRBNUZZwhcdgFl9KcsjBtlD4lOhlxpfyK+K+gzMf25zbvMDZx2rVLT9lFUojvPvHVZ1vcjL+UwKKsBO9NwE0x2wL90ET40Pj81nvm3nlkYRt2lw8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjKiYlf7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733452958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VapI9BO8bDoxLf+txhz8n6Uf6jhZ1jCyATxFGisXxN4=;
	b=TjKiYlf7Hm9K42a1EFSC2JJ9QwDokUgj3dkLNLd8y+joPWb6LOhP0meFeLCuwOhzRWJTXC
	0tEMzlK+2OzG7EauJPZEJAimtBHyx0xa0+G11+1F/Z0f3NgWyHZR8qcaB0L2EcWUkT5VOW
	UZIFZRrnDpn+i53CnDoSyZC4mj4hYJY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-ZB9WW_3FMOmR_6nQuWa_Uw-1; Thu, 05 Dec 2024 21:42:37 -0500
X-MC-Unique: ZB9WW_3FMOmR_6nQuWa_Uw-1
X-Mimecast-MFC-AGG-ID: ZB9WW_3FMOmR_6nQuWa_Uw
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee6ea04326so2606731a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 18:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733452956; x=1734057756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VapI9BO8bDoxLf+txhz8n6Uf6jhZ1jCyATxFGisXxN4=;
        b=Y2fE0Mn2xDiHV0sOYh1mHRLiezqSF5hvx8Oa/e4gghhWYr50gp0MuBOoMVitgDhhV2
         xCoL9BZZT+1ScZ468kRhNTag7Xr9iUDEADRaLAqQWWObeQH8BPAvuZI84rB2Hae8rJJ0
         g0TgGQXwrve9E9Ie+OOCA+n+zt1JjddJ5yED3dXyoQ/Qr56LKbU5/whOcfzHGwNIfAqG
         tXqJ7BgrdvehoavoABkpVjRpfbONxKbH+Zk76IXNoosgMzlivOGvSBTUMHAUzgAEMJwf
         oDkA7gVibCKJ6Y1ie4coJ7MdLadJKywnzrRfGfJa7/LTeStOohTsxeFDMaGutt9FS6pA
         ZZXA==
X-Forwarded-Encrypted: i=1; AJvYcCWlfKIAftQN/gR6+aGrQaNy+0P+6OVRwrA28zv1byWa7y5bcaApJKmiRi+ByqDfzRzsrMDJdID2ZmzQoaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSRMZsSU9FzzADS32BYZPRhFEjDIj0wsi+RTm3Uu/C0m9Lpv2B
	nM2UV7ywlNgtasp/aIRE4HOzfdwJEwe/sGuChsxAe6G0ArmrOQuLqhQi5qqh0VUeANqbQLOf5AW
	+zDot80+2mcMM+aVXSEbiE4sDLRf9oZs1c5gAxMX8dIM7zlkEDbQ/2EhI7lMIgXaw+9UxOiRexa
	kqe1/Vesf7dOWNkSWoNpflqi9hrYw9OCNBH1yX
X-Gm-Gg: ASbGncunIKFOiZKZ3I2J3+tEZIXsM2IJAk19ecY3RW/IcdMNkcZyTMcjFP9MA9lTERb
	2fI7A1GgnMnsPmMzK3INH7Io+vJyjXzr4aw==
X-Received: by 2002:a17:90b:4c84:b0:2ee:d63f:d77 with SMTP id 98e67ed59e1d1-2ef69e121d2mr2499915a91.9.1733452955995;
        Thu, 05 Dec 2024 18:42:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXC1PaZ/v1xzGb9UHzuP48eKxe8R8L0M0pU/SFP7iOc+J8n98g8ZduoEmx31sFn2mMYoCCNI12FCuwzw5Vn5M=
X-Received: by 2002:a17:90b:4c84:b0:2ee:d63f:d77 with SMTP id
 98e67ed59e1d1-2ef69e121d2mr2499880a91.9.1733452955619; Thu, 05 Dec 2024
 18:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205073614.294773-1-stsp2@yandex.ru> <6751d9e5254ac_119ae629486@willemb.c.googlers.com.notmuch>
In-Reply-To: <6751d9e5254ac_119ae629486@willemb.c.googlers.com.notmuch>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 6 Dec 2024 10:42:23 +0800
Message-ID: <CACGkMEswqwz_EG0onQcOZdt6pkcaJ7zHsVpm=c2HUkyqdOMTVg@mail.gmail.com>
Subject: Re: [PATCH net-next] tun: fix group permission check
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stas Sergeev <stsp2@yandex.ru>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 12:50=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Stas Sergeev wrote:
> > Currently tun checks the group permission even if the user have matched=
.
> > Besides going against the usual permission semantic, this has a
> > very interesting implication: if the tun group is not among the
> > supplementary groups of the tun user, then effectively no one can
> > access the tun device. CAP_SYS_ADMIN still can, but its the same as
> > not setting the tun ownership.
> >
> > This patch relaxes the group checking so that either the user match
> > or the group match is enough. This avoids the situation when no one
> > can access the device even though the ownership is properly set.
> >
> > Also I simplified the logic by removing the redundant inversions:
> > tun_not_capable() --> !tun_capable()
> >
> > Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> >
> > CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > CC: Jason Wang <jasowang@redhat.com>
> > CC: Andrew Lunn <andrew+netdev@lunn.ch>
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: Eric Dumazet <edumazet@google.com>
> > CC: Jakub Kicinski <kuba@kernel.org>
> > CC: Paolo Abeni <pabeni@redhat.com>
> > CC: netdev@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
>
> A lot more readable this way too.
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


