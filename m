Return-Path: <linux-kernel+bounces-327018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3271976FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F080DB23B86
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CE81BF7FC;
	Thu, 12 Sep 2024 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="A8vqhQuL"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79261BD501
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163906; cv=none; b=OUxb26Ocqo3FNywuxb0+Ru5j2BEILD5iaB1yPgIO4WtKYHQXlO7HiPmsDBQIvGoqS3fsoJ+ttRDTz6T5PuNEsCjVfhp1q8olsKk15R57pnx2CVI4WUolx1+7TVy7dNITH4D9gL5Kx/54AjWxw0B3ZVpWK6vIlVmJ1fcu+uDE4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163906; c=relaxed/simple;
	bh=rsyVoMxasFdrzg1ZCN3FzbL7tdpeuQ4bade0QJUXi0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1nPbPEuaxvuTPuCCcvVhAXhlaFxz7AMI2TsoLtICInkIjMNO4H5OT6GlTf2oIiew4L0SQJkk5lKkqWqMipxTlLVXHRzZNl1/gey8Zpxj4gG2jBg1r+CE2WZPfD1b90O4KrkOFJHwiCAz7gnL9asYQk16jjQLbHpXZGtX0+ing8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=A8vqhQuL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45821eb62daso6987781cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1726163904; x=1726768704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWE9bW9XtqMX66iof/3vxgpMkfAbJVizDpepSHwC0ig=;
        b=A8vqhQuLoACRX+XIzdFfYzEVP9P3qWyCN4wcpgL/PQ3z/ehMGZEJSEWkSUI7brTpH7
         Xlxp7tHidEHNqySAi43OYqzzhFqgXbNz7aYG9BI96nYZgmNvokCmc8p+lqOPZ0RRTTad
         n69jG86sWJCCGRNhdyM5hUCWV9zWwGhCi3JuVIIpbYcs1yuqeJmP39KbEFnp7bYLLraq
         iTNd7BsWjUuTNpa04I7DS/YrWykk9E/h9F6p7lO+2gZxNpgmYmq5oLvu1sVslP0AIqAD
         2npc15ArdH/yppk7ArtZQNq9kBqf4NwOftIVjfHIIGOEIRbgN7DnkroOIMkvMBpuEbZq
         ExOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726163904; x=1726768704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWE9bW9XtqMX66iof/3vxgpMkfAbJVizDpepSHwC0ig=;
        b=lPFl2iKqioMY8MTqtwG+hJZboO0T2gwHzg1zsD55Eidm+TlnnlW44BMrRr9k3gNYgZ
         q0na+6PkGcJK+6mf+tnbee0L2mvLf8AW/MyZwXDXRZcOoBjsEfmHheLjpyn2GtCpGFL6
         u7B93diznBYB5glcliUwv3LOJSKEpKiUhmKUIdDMRRA8TYoCIMJtAtonN4RqM90FWTNT
         FMrMMnmnPSn0ozT7O1xJAxXlorTPLymlx18vF8TwDMFP3UE63GowOi/fEpLSNC/OFPMl
         ad9XjsLbYp/LUD6PnQuP0967pbTIMjtCQ6xkfKorYa6a2fgZ/9MREF/ets1iXozy35is
         5Enw==
X-Forwarded-Encrypted: i=1; AJvYcCVSeJ5kSMoW650n2yK8PMi012ENoJ/FbsG2Idm7PWUvLCpcj2Rao/ilW+UJpPX78oxkkRazJuvmCB+EBPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNqSD7eeooLIKDTNntVrnbJGX33b1kUPndEESKsSUxW/zHvwXe
	6y1zS9KOVNDDtajTHIKmcNgJSJFmnFhjQHsjYpObcGLggLhpSINuEDNbvD1w7EVsTpZm2RSL9JL
	A76083KEKZMch03Z6qyPnlrGG0VStbnBujMSm2Q==
X-Google-Smtp-Source: AGHT+IFuvDGUGnOq4enNgaz263NpOLDBjldkv6QXNDkKpAomPEH83V/kDoS2P8ablIwkVQkOc3vbJREnzodxgrYgnl4=
X-Received: by 2002:ac8:7f51:0:b0:458:5d27:851b with SMTP id
 d75a77b69052e-458603df3e5mr44591581cf.46.1726163903530; Thu, 12 Sep 2024
 10:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912173608.1821083-1-max@kutsevol.com> <20240912173608.1821083-2-max@kutsevol.com>
 <20240912-honest-industrious-skua-9902c3@leitao>
In-Reply-To: <20240912-honest-industrious-skua-9902c3@leitao>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Thu, 12 Sep 2024 13:58:12 -0400
Message-ID: <CAO6EAnWOrzOhHNURLct1tsxLL_gaNT+nWttTk4oPcD66h-xAZg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Breno,
Thanks for looking into this.

On Thu, Sep 12, 2024 at 1:49=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Maksym,
>
> Thanks for the patch, it is looking good. A few nits:
>
> On Thu, Sep 12, 2024 at 10:28:52AM -0700, Maksym Kutsevol wrote:
> > +/**
> > + * netpoll_send_udp_count_errs - Wrapper for netpoll_send_udp that cou=
nts errors
> > + * @nt: target to send message to
> > + * @msg: message to send
> > + * @len: length of message
> > + *
> > + * Calls netpoll_send_udp and classifies the return value. If an error
> > + * occurred it increments statistics in nt->stats accordingly.
> > + * Only calls netpoll_send_udp if CONFIG_NETCONSOLE_DYNAMIC is disable=
d.
> > + */
> > +static void netpoll_send_udp_count_errs(struct netconsole_target *nt, =
const char *msg, int len)
> > +{
> > +     int result =3D netpoll_send_udp(&nt->np, msg, len);
>
> Would you get a "variable defined but not used" type of eror if
> CONFIG_NETCONSOLE_DYNAMIC is disabled?
>
Most probably yes, I'll check. If so, I'll add __maybe_unused in the
next iteration.

> > +
> > +     if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
> > +             if (result =3D=3D NET_XMIT_DROP) {
> > +                     u64_stats_update_begin(&nt->stats.syncp);
> > +                     u64_stats_inc(&nt->stats.xmit_drop_count);
> > +                     u64_stats_update_end(&nt->stats.syncp);
> > +             } else if (result =3D=3D -ENOMEM) {
> > +                     u64_stats_update_begin(&nt->stats.syncp);
> > +                     u64_stats_inc(&nt->stats.enomem_count);
> > +                     u64_stats_update_end(&nt->stats.syncp);
> > +             }
> > +     }
>
> Would this look better?
>
>         if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
>                 u64_stats_update_begin(&nt->stats.syncp);
>
>                 if (result =3D=3D NET_XMIT_DROP)
>                         u64_stats_inc(&nt->stats.xmit_drop_count);
>                 else if (result =3D=3D -ENOMEM)
>                         u64_stats_inc(&nt->stats.enomem_count);
>                 else
>                         WARN_ONCE(true, "invalid result: %d\n", result)
>
>                 u64_stats_update_end(&nt->stats.syncp);
>         }
>
1. It will warn on positive result
2. If the last `else` is removed, it attempts locking when the result
is positive, so I'd not do it this way.



> Thanks
> --breno

