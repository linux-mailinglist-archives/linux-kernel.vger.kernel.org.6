Return-Path: <linux-kernel+bounces-325821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 746F6975EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 03:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D641C2280F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 01:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5669224DC;
	Thu, 12 Sep 2024 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWFWYkPw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F253AC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726105664; cv=none; b=mb5si/aYNXErOtFDFCXTzLc06F3OGKOl2BuGRUb35H7CrfBlephihsh3TSIFgPaT1prSsVX5IaJQGyEEruARdE1etCMc0JEPhSmdxJ2+CRfKPkaHJHsml9oBWvUDpqwRYzL5JeILbVryT6AuoXwfcPnhpMJsJ0htHB0TZ/QQ08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726105664; c=relaxed/simple;
	bh=4kxuS1AIBSnin27g8FmmDst9UMdWeGBb4Oz2BIvY9Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6qmxGQZ1vyuHALNTEhYU92IHED+GbdcvlT9CTBS+98kLNJxDo6ec9ZbZxe4S5WeH29AVBejF1DJ3v8gsvPtseerqwbM73WkjRMTl6QHmEo0Sukpi3uv/pSlmVauJdxq6zmWLS5CGNODzaGMgF2vS8PYImK/jpBksXZQ9HO4vDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWFWYkPw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726105661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4kxuS1AIBSnin27g8FmmDst9UMdWeGBb4Oz2BIvY9Ag=;
	b=LWFWYkPwzDjbst+pCOd24kPxBzGGYi6k7c0BjmAvDzFKW1tyCr+voa6+AIqvyRUpMYQoYa
	5z2Zre8tBoY3jRg/0gTM9Ogzvs0Y6+JjyZFS0CEX36AI++OCE9/TjjCGJl/oddtCmDeKO8
	MaVaUI+bcCwf6Cfqo0OJBUmmEJSwA4g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-V5KU5a2iNqSSs7PLyy55Fw-1; Wed, 11 Sep 2024 21:47:40 -0400
X-MC-Unique: V5KU5a2iNqSSs7PLyy55Fw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8a4fab0d7so610305a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726105659; x=1726710459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kxuS1AIBSnin27g8FmmDst9UMdWeGBb4Oz2BIvY9Ag=;
        b=uMdkQLPAperW2R2Ws9LdJsKDM7KpmIa3tI6XW3+sRXup1+9vVGlRdwbjg8vCEY1Myu
         LfVbYJMh+PNj57Y86N6aGACvwGHw3gar2QT/CuoQCYpyhXxouQpCiIyg4FzSnPz5aXLI
         dzSLViI5U7g1u4q22aiX2UdcwZZVbCgD8jgN3AQelQgt/ouDdO9xtWqMxyQ1NZUJ6s8i
         bAhYOiL4brWiPcLg8J3Bh26GaFYu/GRM94WbnJCgQwiNF3TmOuW/SNLwbvNMhD5mG/HN
         AndtqCyZ+1C4ph+ys/P/Xl6mlDNCRhg7Ba87aU2LdA+CoKoZm3q+UVdModu/B4ogIW22
         pbHA==
X-Forwarded-Encrypted: i=1; AJvYcCUTO/FAf1QiRbIPfZ8tWu1e0U/1DR5Y1IlnRulbxcCkxLp+2E1wauW++uD5aWYwOVl518ioGcJOzB8nwFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxR8XMcx6PorCMGyIylnq8iAUwvODw6wzMJ1SPUForyRFI9n6M
	3WW/1N81Dq+P9tqCB5RItffKI6s/PluMjrC0fA9SNdUVzmfWaim/H1edQZvQZltJPUES7K21gSN
	BjGuseuE/qDFl8dip7owhpjKwPO+1BEbt2GF3Y+EHpvLgIbOFS2Qo+QaOOJnprefaKo5+IO/nRn
	AK2pGO1Z4VO51uBVzGkikytepo0UKJE4Og/ilnMJR00VyHStA=
X-Received: by 2002:a17:90a:ce01:b0:2cf:fe5d:ea12 with SMTP id 98e67ed59e1d1-2db9ffb8564mr1569277a91.24.1726105658723;
        Wed, 11 Sep 2024 18:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxZKczFGfKFB53IOYqTjQPUNWxQs4r/wv0X/MYrSTF/VVDx6dP+mE0uScujlc+dYqOeR2GSx9/J6bta8HjgRw=
X-Received: by 2002:a17:90a:ce01:b0:2cf:fe5d:ea12 with SMTP id
 98e67ed59e1d1-2db9ffb8564mr1569247a91.24.1726105658261; Wed, 11 Sep 2024
 18:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909020138.1245873-1-lulu@redhat.com> <20240910032825-mutt-send-email-mst@kernel.org>
 <85fb3a90-fbf4-4925-8b53-197f3faa574d@oracle.com> <20240911150013-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240911150013-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Sep 2024 09:47:24 +0800
Message-ID: <CACGkMEsrpAXz-opeJMkPC7h-3H3POGppZk7_Ke+mO3nyG5y7iQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v1 0/7]vhost: Add support of kthread API
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:02=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Sep 11, 2024 at 11:20:30AM -0500, Mike Christie wrote:
> > If people are ok with something similar as in this patchset where
> > we have both vhost_tasks and kthreads, then I can send something.
>
>
> It would be better, as you say, to modify the vhost_task code so it can
> emulate the kthread behavior. However, given that apparently some users
> are unhappy, what you describe would be a good stopgap solution
> until we have that.
>
> The main difficulty seems to be to describe what the
> behaviour is, exactly, so userspace can make informed
> decisions on what to use.

Exactly.

Thanks

>
> --
> MST
>


