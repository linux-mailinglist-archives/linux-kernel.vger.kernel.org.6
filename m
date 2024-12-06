Return-Path: <linux-kernel+bounces-435046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFDD9E6EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6136C281A42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC67206F1A;
	Fri,  6 Dec 2024 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dgaFdIkC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01AD206F1C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490021; cv=none; b=cefn9CWRr9k1zk/n+MzCWOPGaVOvXpyBNIq8jKlOggSMpQJOGFatVcsBFM+PiDHXvYqCgsDzTSRaBwic8hN5nwSktovTCAkI0LIsLg9xmno48TXa9LyNUmAZ4qFk9KkjG7xNKYcuQrIcvOj2ncUAxMuG5qLba6LCU/+A5GL8Hz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490021; c=relaxed/simple;
	bh=PW6Q+/r8QRjgroTX3+KWZFperSsUGEs9C/zFXUin/3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnb0GFX0jN7WTT7b5n2ydXNGXQdAuNYgcRn45yWKgeF4R/oAW2/18XRa6MqqZ2K8DqsMrVmiAoGZ1Udtzff/Zcr0f5rHKoNtbw748WWH5thOBYtZjaks0WhgDqL4dYfEw0oYZ9RwS0yd1EVXOlaQ2EK+p8qARfEV/rRz+/Hch1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dgaFdIkC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733490015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4np2Gt/G625+NVUj+saJleDuMjAPrEfkQvrELJ5U0PA=;
	b=dgaFdIkC4kw3gerDXNPeBH+oBKgFDxFNfLma/mJ+urNGOfl1cqsFfqNC+ZispM9C7MbJKS
	eITXOM48QACWAF1/OxeR3DRRd2JgsSnODU48TR7BS5wSgOutMxzUd26ZGaoGeEHWkWxMXJ
	S0ckHant/A9aKTH5SKTU/O4H6neYeh4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-eLjGL7yuNc2DI7FBZuswLQ-1; Fri, 06 Dec 2024 08:00:14 -0500
X-MC-Unique: eLjGL7yuNc2DI7FBZuswLQ-1
X-Mimecast-MFC-AGG-ID: eLjGL7yuNc2DI7FBZuswLQ
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5d0b6f3770eso1163955a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 05:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733490013; x=1734094813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4np2Gt/G625+NVUj+saJleDuMjAPrEfkQvrELJ5U0PA=;
        b=mjucQXxbma0esDZdzwunBRk1a0Qy12TY51Qy6SxfFzI+sCgdYMW94v69t4hM5ZTA5/
         CKS0bwOPsmlKmgNrWAe7IRaNohgyA+Jx/YljgurB08KPrKWmdodX8w254patYw75Fpay
         FW72b/OwgKKw9/LscClnRFmgPfvbYI6re6pkTGurBTrGLgtoo3Rs42zSeCenl0XJMAyV
         8BfZuEGdIRHz5NL5ufOKMYVVUd0wSIUpXHNEbTzgIJ9SsO2bcjZbS5L5eLnWc8/6xiKA
         ZUjqyXnJ2KtSbudJcNvFEe2hpZWX049jnyjmnRNx3HYSpA9C2Mo3P2YzdHdcblfuKIbG
         0bxw==
X-Forwarded-Encrypted: i=1; AJvYcCUPUewIG8iiALQJ+Tfe/uj1SkzuruwD1YyXGSj3oDsO4Rrnl4BkX9Ns2QxNad1G2EM+OXGRQFF8jJQkVd8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+LrhyTDxiRr3aGDYLKH1ppEANh6hN6R6LV371gNUiV539HyR
	8n1Ye6SGKqEWCmG6FKB2yB9ozjYafrd9eknZk2ZhUKVX3q3LXUcvucaWwCUBVj5NhZNnxAsr6Sy
	XtG93MVxa6+tzJSoiVplBYLA0OIhWqJuNN/Y8lVbee5YTLprrKuYcdYJ38mqrF9Z4Jm8GwTzNha
	dq/m6/f9uZ0RuX6I8B9MMRRCrY3NE7r7Txwn7g
X-Gm-Gg: ASbGnctiWn+ScDZ9uy08a89663/DmTvcAHGJnHzaX2jy3NfIfbYgITUtLAGkdbuJmQS
	jaIz21it8kzxiUA61rkhJNwQIQZOFm31g24ZBoJmu4C2/yLG+CmVbOaQv6NPHJQJv
X-Received: by 2002:a17:907:910d:b0:aa6:3e97:f9db with SMTP id a640c23a62f3a-aa63e98157emr128922366b.50.1733490013103;
        Fri, 06 Dec 2024 05:00:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGbiJ4az96p6Wq62FXctxA12RJ2DsEtqG6ZgCij4WznqIqqVnc0rVhUWkKSVx3XxBChHE/U3LahunxkzQ4SqU=
X-Received: by 2002:a17:907:910d:b0:aa6:3e97:f9db with SMTP id
 a640c23a62f3a-aa63e98157emr128920466b.50.1733490012718; Fri, 06 Dec 2024
 05:00:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122121843.641573-1-rrobaina@redhat.com> <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
In-Reply-To: <d3391fbff2c69be230d368c68d215be4@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Fri, 6 Dec 2024 10:00:00 -0300
Message-ID: <CAABTaaBQ0+tSx++xYB2NJ=3Qkein9Y5=eY0uU-V9Qb6mR28GvQ@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix suffixed '/' filename matching in __audit_inode_child()
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	rgb@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 9:22=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> Yes, Richard did provide a reviewed-by tag on the v1 patch, but v2 has
> enough changes that I don't think we can reasonably carry that forward;
> of course Richard re-review this iteration and provide a new tag.  I'm
> going to remove it for now.
>
> Al never provided an explicit reviewed-by tag; simply commenting on a
> patch is not the same as providing a 'Reviewed-by', the reviewer will
> provide an explicit 'Reviewed-by' tag in their email.  I'm going to
> remove Al's tag too.

I'm sorry about that, I was just trying to give credit to the ones who
helped. Thanks for clarifying the expected review process, I
appreciate it!

> Other than those issues, I think this looks much better than v1, I'm
> going to merge this into audit/dev now, thanks!

Thanks, Paul!

- Ricardo


