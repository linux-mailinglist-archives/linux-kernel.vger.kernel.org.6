Return-Path: <linux-kernel+bounces-439668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5159EB26D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDDF16B7D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4B71BFDEC;
	Tue, 10 Dec 2024 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUprwK1z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357A1BE852
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838985; cv=none; b=mdSZErPvNmygnYAd+LDIwmDmAgXf3JZ0F3a8P7ECpnJjZ7/l+KlFNKfUUUnHWP0Nrm5tytnR4nt4UHUfPWSSZk50cZT3uOXiHDJD43SsnjDrTo2qTzVSkXwA7uSNAeEHWF9H24pASugZI9EZqliNA3tJrzVdqoM9PUJfb2fSN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838985; c=relaxed/simple;
	bh=r1uDnHbtgZJWUVIR1vTcKu9dipb8j67J8hgLIyCxLBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=XRedkWIvE2cxafjr6c+2RY2lH8Bfg1nkKlLlognTjktw+4gh3+357y9n5tEThbeYQELtwiWPLO+IIoBrj1UkeThKJAiDq0vvNN4YMpcyBvhfqpN0WEz728WNrBpWlSCPHR0zimLBednRidMpeeJtj/bbOZS6IF6ZXBpWXhpE+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUprwK1z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733838982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ii60ZcgJ/ZFw2IPUTiPFLc566IQUq/Ff2SMoVtpygM=;
	b=CUprwK1zX3nt3TbjBHD9STv8/pi1Vhp/UBAnAgmQ2V62+yRWIjR02BPOnGR6EN0uaBz988
	1TxWR79TwoWI29YNcj4SPGCvQUIXPAjcNkBV6oFXWwLYc9ZPKDvjAFPxilh41LoBQpG7qA
	50LS2EPuBk0desGn7BsUIC6eoKWKTXk=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-KZ6-YWTcPF2aKkTWoh0cOA-1; Tue, 10 Dec 2024 08:56:21 -0500
X-MC-Unique: KZ6-YWTcPF2aKkTWoh0cOA-1
X-Mimecast-MFC-AGG-ID: KZ6-YWTcPF2aKkTWoh0cOA
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-29fb55d5357so1945969fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 05:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733838981; x=1734443781;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ii60ZcgJ/ZFw2IPUTiPFLc566IQUq/Ff2SMoVtpygM=;
        b=JC0SBbhFazBn5muxzizU2E7PMGIfvs4aZma8lKKGTkFpu+5BaMAIEE0wJreBxyqHMO
         TP1JXsgPMW261Yo0JTx+6HOLjhm+rKyadlrPXtVOR33p14LsDPllUKtLGmLPZ3i00NYU
         vKriC69M9BIERu/QVKUe3brkT1BzjSnf2XkluCBqg1ohJuuUqyC4xv0tPNuA0kJuYna1
         xhMVjS1bbVMngROenHqfWCyPgV1DAT0P6aE+chk+6a9YnWmiAz0RDWS9OFXtCn7U5smZ
         7ccxiwOjt5kwx6Eme1EGpYaDXlfuPBdM7crMnAdBDDyaoAjgtOqr3fp+C2z8dxEdhXpc
         HAUg==
X-Forwarded-Encrypted: i=1; AJvYcCUgTSJNY7QKbU3EuuiLxgBZ8zX2dYKICv/kYfKiIQWvl2suJGq+/Tb2rPE2ay1VupmE+Ph3+FDs72dqkWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAOap1mllEKCqom8xqQAHa+CJvNtcwrOZN+An9cuwh/kv1zJ/r
	LjJZ13x8+TxpNAx2wjD1KEg32o1HBhuY/gVrxChrlXAVrhtJKPiadQ/+i52LNxe5FQIC7Nzd4hp
	3FTUKgJL9hcbIehwlNqeE4HAbrAEW4TPdQbWdixgaOcA4o+PgcmeGM1D7yDTd+U69kyjiiXyUMD
	Y+HtIVMEHxFIFnW7oaMxzectj+RcVFM9gV2bRd
X-Gm-Gg: ASbGncv19N6p81kdarHn73VsIqft87o9IO0GTEmkjJKB1BMD2u89ynNdWZ0QLu4uueV
	evGmPk+UFV11NmRF0iiIAuTyfrxNHz9soM/E=
X-Received: by 2002:a05:6870:8326:b0:294:cac8:c780 with SMTP id 586e51a60fabf-29fee551e87mr2672026fac.6.1733838980855;
        Tue, 10 Dec 2024 05:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBa8ePqNNQyFs98wreteDhgMQxduKEaaCzy2huGooSIR2R4O+8918jdaAC5YT4jq3YL7dMue774KGx5Y4pz+E=
X-Received: by 2002:a05:6870:8326:b0:294:cac8:c780 with SMTP id
 586e51a60fabf-29fee551e87mr2672011fac.6.1733838980614; Tue, 10 Dec 2024
 05:56:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733755068.git.jstancek@redhat.com> <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
 <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
In-Reply-To: <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Dec 2024 14:56:05 +0100
Message-ID: <CAASaF6wVb=c2mYJDqSdjbGD2hQ9CdbxmEKopVoT3Aniy+xRJ+g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] tools: ynl: add main install target
To: Joe Damato <jdamato@fastly.com>, Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com, 
	kuba@kernel.org, stfomichev@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:30=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> On Mon, Dec 09, 2024 at 03:47:17PM +0100, Jan Stancek wrote:
> > This will install C library, specs, rsts and pyynl. The initial
> > structure is:
> >
> >       $ mkdir /tmp/myroot
> >       $ make DESTDIR=3D/tmp/myroot install
> >
> >       /usr
> >       /usr/lib64
> >       /usr/lib64/libynl.a
>
> This is super useful thanks for doing this work. I could be missing
> something, but it looks like the install target does not install the
> generated C headers that user code can include at build time.
>
> Am I reading that right? Is that intentional? I was thinking that it
> would be really useful to have the headers installed, too.

It's not intentional, just noone asked for it yet. We can add those.
Would /usr/include/ynl/ work? Or do you/others have a different suggestion?

Regards,
Jan

>
> >       /usr/lib/python3.XX/site-packages/pyynl/*
> >       /usr/lib/python3.XX/site-packages/pyynl-0.0.1.dist-info/*
> >       /usr/bin
> >       /usr/bin/ynl
> >       /usr/bin/ynl-ethtool
> >       /usr/bin/ynl-gen-c
> >       /usr/bin/ynl-gen-rst
> >       /usr/share
> >       /usr/share/doc
> >       /usr/share/doc/ynl
> >       /usr/share/doc/ynl/*.rst
> >       /usr/share/ynl
> >       /usr/share/ynl/genetlink-c.yaml
> >       /usr/share/ynl/genetlink-legacy.yaml
> >       /usr/share/ynl/genetlink.yaml
> >       /usr/share/ynl/netlink-raw.yaml
> >       /usr/share/ynl/specs
> >       /usr/share/ynl/specs/devlink.yaml
> >       /usr/share/ynl/specs/dpll.yaml
> >       /usr/share/ynl/specs/ethtool.yaml
> >       /usr/share/ynl/specs/fou.yaml
> >       /usr/share/ynl/specs/handshake.yaml
> >       /usr/share/ynl/specs/mptcp_pm.yaml
> >       /usr/share/ynl/specs/netdev.yaml
> >       /usr/share/ynl/specs/net_shaper.yaml
> >       /usr/share/ynl/specs/nfsd.yaml
> >       /usr/share/ynl/specs/nftables.yaml
> >       /usr/share/ynl/specs/nlctrl.yaml
> >       /usr/share/ynl/specs/ovs_datapath.yaml
> >       /usr/share/ynl/specs/ovs_flow.yaml
> >       /usr/share/ynl/specs/ovs_vport.yaml
> >       /usr/share/ynl/specs/rt_addr.yaml
> >       /usr/share/ynl/specs/rt_link.yaml
> >       /usr/share/ynl/specs/rt_neigh.yaml
> >       /usr/share/ynl/specs/rt_route.yaml
> >       /usr/share/ynl/specs/rt_rule.yaml
> >       /usr/share/ynl/specs/tcp_metrics.yaml
> >       /usr/share/ynl/specs/tc.yaml
> >       /usr/share/ynl/specs/team.yaml
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
>
> [...]
>


