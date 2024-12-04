Return-Path: <linux-kernel+bounces-431272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C17F9E3B5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F370E285846
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C101D54C2;
	Wed,  4 Dec 2024 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUL48ZwF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D11E47C5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733319383; cv=none; b=RZxa/WxrYx12z6EBd+DOog8Lwi7fuD8J26Kx90mH8hUBv3h6cZE8yrfQnmCuZtCjBwnAL60TcpzcP6ZVVqypziO1Sgld50CxYNwwviBGcOtlgw8pLDjPPrNtqcD6Ge90/NUq6ufmtZC4aHLOR5cuvzI8q6q1dlADE7lDpr5VlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733319383; c=relaxed/simple;
	bh=G3H9vPm74tu0lvdzHCfMTn/mY2bbhXewyUb/tIQ3V/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EhtUbYmpeICLDFGzNsy9BOy/cfz70El07a4bB6U/1hA+5nBcDmF7I6Ec2mDw9FHQYXJC6ZYk1dyI21FLXVmBE1ryTE/A0+pQVypoLton8VStQM+2Iz7n/zVA0Jb8MDTDZhPPOxl0jibWLEGrI5D8dtv2rx4QtKB65oPhNrn0czE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUL48ZwF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733319379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gAKk5WRAWeLj8mWsqp9Osu+484W5ZjNbKQlb66yg3SM=;
	b=dUL48ZwFHQH3w99vmR3MmtuYOaolvCM1AdTsfnUKZKPQ8RMMh/r9oNV9bt8MjkBCpX8ptO
	24UKWneCrMJTwxhbSEFLXBpeAUIfL1uP1MMYSCOginhhI+W22s7JXsbK6Uf8trZzAeQtnF
	jonXw5+cv3WeTjKfLFU/Lm1RDkQAXjg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-QBqVpzIZNX64D5NeEFhwdA-1; Wed, 04 Dec 2024 08:36:18 -0500
X-MC-Unique: QBqVpzIZNX64D5NeEFhwdA-1
X-Mimecast-MFC-AGG-ID: QBqVpzIZNX64D5NeEFhwdA
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5d0c64ce365so3792944a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 05:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733319377; x=1733924177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAKk5WRAWeLj8mWsqp9Osu+484W5ZjNbKQlb66yg3SM=;
        b=wE1v0O+bN0DBbEn8/M760yyBb3zteHzGChS8+3Bod/crp9slM8g5Jo/8k10we6L/Qa
         MhdPZ1UIdB4zM6Ui9XYrjJTuYCHl6Q1cNiEpxurRAFB6VqCPZstPja473vSKI6+wpdX/
         fFVbe9Tt21LiRvKtohezLhrGp03N/9efDlogj9tCFEz+Q5qUIXnYvYsKchaLsLkxOL6u
         HOZljcDzM6w6GoPM4FhpSxCqL4nm0vSwjUayVz+Hk6LATYD/sihN8JrB9s12aZW42Wiq
         tJ31+DrA5NiyyVCN2xRIXuVxSvoPVVcAe+dvtPhcgy4a+a40c23BDnc4yt3VEIgpoj9z
         msiA==
X-Forwarded-Encrypted: i=1; AJvYcCVOhRocL03wbWCYdh/3KKSmTYbT9V4HP/4UgFlqN9j7Lk16gM0TdDXjVjrgddTcAO2JgwRqB81NawZMfKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVib1DECJynuVHI5FzH4zbRVzxtr0RrPAJwE2HSwtej90NBmyC
	vIgtbzM5qNWwgV6iD0vvt73+cxRZcarmNdd+Twx3rk3a1EXGF2l7xn8QtM8tqZ7+DpyRRZmO0WK
	y1QVpJ/4U9EWLgqj9kPmjl/Q/CtNR13jXJVYo7v5k463vEbjZu9armgaklCSOzvfPPO9/dpefkQ
	9FZKbO0e/xTm2xj/HyuEHOuS/1etJaTln/N02R
X-Gm-Gg: ASbGncu8DM2F5bKetkthx8b3KQXdvn+Yvni+BC0zdpoB9TGBKYg8iIwo0Sbjs6OIHQi
	fB9ZpRJuuy5vcuXs6mpnd/kFwZ3mUKIXIotg4d+KUADsChmxkJXJ+iAZbVCkw2zt8
X-Received: by 2002:a17:906:329a:b0:aa3:49b6:243 with SMTP id a640c23a62f3a-aa5f7cc14f8mr413856366b.9.1733319377602;
        Wed, 04 Dec 2024 05:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9EZvVnmBeGnetwReNdL3BjxaGWr5jMEtJFqHT7yFYKm3v/3OzQl7rY1r9CK1O+SUO5D0KIc+BN2UTnSYPnuo=
X-Received: by 2002:a17:906:329a:b0:aa3:49b6:243 with SMTP id
 a640c23a62f3a-aa5f7cc14f8mr413854066b.9.1733319377242; Wed, 04 Dec 2024
 05:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105123807.1257948-1-rrobaina@redhat.com> <2d9292c28df34c50c1c0d1cbf6ce3b52@paul-moore.com>
 <20241113230425.GJ3387508@ZenIV> <19328b27f98.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <20241114040948.GK3387508@ZenIV> <CAHC9VhTyp6ao8n0EVp_JdgRXFfP0nLkf0YMKPmiAurFJ_CM0fQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTyp6ao8n0EVp_JdgRXFfP0nLkf0YMKPmiAurFJ_CM0fQ@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 4 Dec 2024 10:36:06 -0300
Message-ID: <CAABTaaCXu6aeTLwVngOpnCVQJ1z3_TYcdjiA=nkvGyvTN1O8TQ@mail.gmail.com>
Subject: Re: [PATCH v1] audit: fix suffixed '/' filename matching in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eparis@redhat.com, rgb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone, thank you all who reviewed this patch!

On Wed, Nov 27, 2024 at 2:43=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> > Anyway, regarding audit_compare_dname_path(), handling just the last '/=
' is
> > not enough - there might be any number of trailing slashes, not just on=
e.
>
> Good reminder, thanks.  I see that Ricardo has sent an updated patch,
> I haven't looked at it yet (waiting for the merge window to close),
> but hopefully he has taken that into account (hint: now would be a
> good time to verify that Ricardo <g>).
>

Yes, I did take this into account. As well as the other cleanup suggestions=
.

- Ricardo


