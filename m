Return-Path: <linux-kernel+bounces-441294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968B9ECC69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:45:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC31164EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F31823FD11;
	Wed, 11 Dec 2024 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTGmi20L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114AC23FD08
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733920970; cv=none; b=BoANalp4hjLj9CN4c2BMT/qWGUz0UcKyXVHtQU47YsI1x7YmgihWvtRqGPj0VYNEaVooqaEVpdbXy6TW30n7Wbd9KcfyK2Q2h15uPqezJOYFjlnLkTGfeMfx80SUtCCTai+UgOueCvbiVabsK8O+ed5YkNZwqiRQgv7zxvMY6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733920970; c=relaxed/simple;
	bh=0fYgjUMXYlYiswT5A0Ojg2hqNgnMvPUhVkw1NPYC9Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChotCopg7Sj6BXX476JPHxgfmpzDn8aiJNHQb7ZQ7vVpwXGBGo62HewNRdSA4lflgL5vWu+1QqDYK8Yrv8EHL5rn+2dvwWdFtvBoZ83ksWxXsrkKCqSpmVec0kPCNO34gJ0Rw5QnYgk1qd7K2OO6jfWOHPDuecrsDEe+GOh8XE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTGmi20L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733920968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8UtYbAT6zXOJG1QRp3pJJIPM9k3jm4sydEZSlMDYGA=;
	b=bTGmi20LFr+SnRRiEzKZ3Lq5CJmxrzasUsa1sbqZeRgjSuSRndfwVSBmyvQTKLiGs3J5Fu
	nlKJ4ne4wjTW9enwOk7BpjKmzU5lSh98iBW5MAHDMUW4qjJFu9hGEJhEOXgZkv1ioXz6GX
	gSe1E0mWNag70QBo0O+KMzaCe0+AX2Y=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-JJipEIJPMbeWIivf-NO6Zg-1; Wed, 11 Dec 2024 07:42:46 -0500
X-MC-Unique: JJipEIJPMbeWIivf-NO6Zg-1
X-Mimecast-MFC-AGG-ID: JJipEIJPMbeWIivf-NO6Zg
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5f2033c97cfso4310116eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733920966; x=1734525766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8UtYbAT6zXOJG1QRp3pJJIPM9k3jm4sydEZSlMDYGA=;
        b=td0BG3if3Q77HALcq7YfCvx7Ipzl7AhdSRW4kgTnlz0enziYtXgMImPTTQw5u8YXEr
         7IytoyU0xOdZAbKJCUD3k2YYaZdxiQmavlPG/rMYq0KjmKdH58O8liNBgD1U395YAxq/
         on5BmgyIA/TFusmXTmgF8eUyrCRNhEyI+/0cYAQ1+IaNDKSim7k9mdtLgwnyrR/Ez+sh
         /vY5sNiy6fyvpWYRYMqzEIdWnvmiMJBI58Cpz/RMlRkld3l1AFAIsHd62hNhVcEwkyGm
         5B/lu98MTVMhZYj7kDWjv5KXQdHpq46HVGCQQ3nrcJMMfM21NfNNx1auJLTmp0IZuYKM
         REcg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ2g7hbCmewuEhTsQcvCf9CLCwzwvcUxOgwcsxDTi2RzhICCOfBpcU7j15oFl7tfmqo2zLsdMCAn/pNq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVin9le63LqTs9GC7ASdxIUq1Nj30eeC0N3sNC8GCuEbdAuiD
	se2o2nbhog0kqS3atKmGUH3aeK0wymer5NWggdziOX9T6arlZ27Cq3szVwP8sb1bXEc9aNn6ZzB
	fNkRnq6rD/xEMSYStgJHHS7z+36/6w+okW1pRJtcs1D8Pf7WZSr3v5a2pKbxhMayaidPe4Dme5V
	oy9YeQU8Kik1l+fgv2WjeIlrCpKlCrXPR+o5xh
X-Gm-Gg: ASbGnct/grMkCItq8bbkjcTAcdI1O6LRuTgRlCq2vLudUfdPbCkZhaM+xU8OorLSJJV
	iR8ZnOBwuXyyjF4ibmcopLRO18eBrq/o9/JQ=
X-Received: by 2002:a05:6808:30a3:b0:3eb:4acb:a86d with SMTP id 5614622812f47-3eb85b862f4mr1520753b6e.21.1733920965830;
        Wed, 11 Dec 2024 04:42:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfeFp0IcJYP1F5+VvF+5y3wrj2brl6H6PjgxmWpnV65awpOaQmAYWWttqym5r5+T8cwSL3Po5NUiU/tS6JeUo=
X-Received: by 2002:a05:6808:30a3:b0:3eb:4acb:a86d with SMTP id
 5614622812f47-3eb85b862f4mr1520745b6e.21.1733920965622; Wed, 11 Dec 2024
 04:42:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733755068.git.jstancek@redhat.com> <ce653225895177ab5b861d5348b1c610919f4779.1733755068.git.jstancek@redhat.com>
 <20241210192650.552d51d7@kernel.org> <CAD4GDZzwVhiJjJ=dqXMSqN39EeVBrUbO3QYB=ZhrExC86yybNg@mail.gmail.com>
In-Reply-To: <CAD4GDZzwVhiJjJ=dqXMSqN39EeVBrUbO3QYB=ZhrExC86yybNg@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Dec 2024 13:42:28 +0100
Message-ID: <CAASaF6wcW54MwR-CdR_bfXRJS+ar0y87g7FN1_T6qLVJX0Ti6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tools: ynl: provide symlinks to user-facing
 scripts for compatibility
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: stfomichev@gmail.com, pabeni@redhat.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 10:21=E2=80=AFAM Donald Hunter <donald.hunter@gmail=
.com> wrote:
>
> On Wed, 11 Dec 2024 at 03:26, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Mon,  9 Dec 2024 15:47:14 +0100 Jan Stancek wrote:
> > > For backwards compatibility provide also symlinks from original locat=
ion
> > > of user facing scripts.
> >
> > Did someone ask for this? Does everything work without the symlinks?
> > If the answers are "no", "yes" then let's try without this patch.
> > In tree users should be able to adjust.
>
> I asked for the symlinks for cli.py and ethtool.py to avoid surprising
> people when they move. The ynl-gen- scripts are primarily used in-tree
> via Makefiles so I didn't think they should be symlinked. Happy to go
> with your suggestion to drop this if you'd prefer not to have any
> symlinks.

I'll drop them, we can always add them later in case someone
_really_ needs original script locations.

>
> Thanks,
> Donald
>


