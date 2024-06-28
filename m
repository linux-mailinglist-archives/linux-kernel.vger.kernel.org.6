Return-Path: <linux-kernel+bounces-234418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B19A791C66A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359721F225E2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C86F2EA;
	Fri, 28 Jun 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioiHfvuT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544E6EB56
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601761; cv=none; b=e6BQc3AqOr2EfrcUkGG6YYXQMifWPlFFJQaoWqs6F3V+yWmOEaXuDXQNAnrIrgjRCgPwdtkg6MT5Pm3jbnI34/OqQ75h+7Hvrzs+s81npcHLnMZLBcT/lWlxRIO50Y3E0yBKqbpoNqxDJ8PK/sUrOp49Y87DtkS7wzEx+Vsn4Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601761; c=relaxed/simple;
	bh=PQbiTv/VM0FHRwk2XTT1cLcVoQXr0OCJr39ObtijekU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dXkzKgmTe+xfcUYiZA2AoeV1Pf2zGYQP/i3sVNPSQ3qNJ+AxuW9iN9Gk9ZlzvZQXzbrFCy7A5g4NnXFkDILR9DTgXL2Rw88GQrZMayy51bMYYgaqdtiv0Fd8/OVnL807ehZzdGelsJGEaXmeuxrceptKooR6uERPICoDQMvcXGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioiHfvuT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719601758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQbiTv/VM0FHRwk2XTT1cLcVoQXr0OCJr39ObtijekU=;
	b=ioiHfvuTvDP7GQmtedmivTP8jbkRMqUJAKi9yLTAzVXXAwwrKcyJj2LtZXxJ6r8gr3gpgF
	gdoKj4qdc1ELqw1f33ad/645MZijD4H/zffKr/0wJcXg7PG0QkJScRJzipwZjqmN3mlq7q
	P/ytc+BmJn4nz9935YSrcV38RYEuXI0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-dfK3GrnmPLGlhPOp_rQvyw-1; Fri, 28 Jun 2024 15:09:16 -0400
X-MC-Unique: dfK3GrnmPLGlhPOp_rQvyw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b4fdcf92d9so12179336d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719601756; x=1720206556;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PQbiTv/VM0FHRwk2XTT1cLcVoQXr0OCJr39ObtijekU=;
        b=KlLhGnsMD0CQ2NTWbcE2ZNj7q/NiajXXw5EsM7N9d5ZE5jxj4HmWAKO5N/RzMSJFBQ
         cT+pBxjZ3X7obY9/FZrxYrd8cHkvx+/OnUWgHe/v2J9BLCCW4jroqsR7+HSOWF2ZbC5L
         VbeEkrMddTWCuo2Sp5KuuEVIumLAN/mdB1ZQMjc6WXjxiwio1G8eA+vwrFrFCNmLYNCI
         Mbct8lSO0y6inV9ceW/0rdAQBbzB+XI9q3anGI4uUZiILr4N4IDjhJ4giCbVPuYixoYY
         7hHaPh/h6vVzw+yMUDA3M9k0pRqzRSkv6OdP1mD5HNaUjhK4McEfab05dDDXpnCV82Vv
         IP1g==
X-Forwarded-Encrypted: i=1; AJvYcCWa3W/a546gtZSTwho9u5ndXiDYXghJoDEFwXTOYhcY39K2afiqa5adqR+kYN3IpYx+Jp8szGdocs6g20VySMymHciZX2X2lEElkntG
X-Gm-Message-State: AOJu0YykgdgWFf6j6/h8CjXF1n+ChXDZhOZppCG5H4scN0MzIY4uK/lt
	bB8KSAKdogj/ao0pKpaeyfFstBIPhNKQIlYntE7Eo0aIZaAYmUAgwp9hth6K9MZfxULZcL0Zfna
	O5rh4lqBGYPiVkng6+BRgENdE66zsZoGB47+1R4rIcv/wmwZU6F9+4KG+DtCnTw==
X-Received: by 2002:a05:6214:21eb:b0:6b5:936d:e5e7 with SMTP id 6a1803df08f44-6b5936de77bmr82657076d6.18.1719601755933;
        Fri, 28 Jun 2024 12:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+gMZ/ntsFZ/h9Or/0C3xSl4QY5ySh2hR5EIrVWd2TA4q5MZmzwjfklfp1JIv/SlyeCUIBog==
X-Received: by 2002:a05:6214:21eb:b0:6b5:936d:e5e7 with SMTP id 6a1803df08f44-6b5936de77bmr82656756d6.18.1719601755638;
        Fri, 28 Jun 2024 12:09:15 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5f34efsm10263606d6.90.2024.06.28.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 12:09:15 -0700 (PDT)
Message-ID: <e76250fdcda92afd43c94fe5db2a292d48c29a60.camel@redhat.com>
Subject: Re: [v3] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
From: Lyude Paul <lyude@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>, nouveau@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Danilo
 Krummrich <dakr@redhat.com>, Dave Airlie <airlied@redhat.com>, Karol Herbst
 <kherbst@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, David
 Airlie <airlied@gmail.com>, Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Julia Lawall <julia.lawall@inria.fr>
Date: Fri, 28 Jun 2024 15:09:14 -0400
In-Reply-To: <c41b19ac-6bf9-4f30-8c00-0cf63246d825@web.de>
References: <20240627074204.3023776-1-make24@iscas.ac.cn>
	 <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
	 <790dbe8aee621b58ec0ef8d029106cb1c1830a31.camel@redhat.com>
	 <a91bbb5f-8980-420b-b465-97691203347e@web.de>
	 <eab9d109981bae8a443649bc4a2c1a08870590c7.camel@redhat.com>
	 <c41b19ac-6bf9-4f30-8c00-0cf63246d825@web.de>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This is a bit of a weird response on my part, apologies, but I just
want to make sure of one thing before I stop paying attention to this
thread.

On Fri, 2024-06-28 at 21:02 +0200, Markus Elfring wrote:
> > Because the responses you have been given read like a bot,
>=20
> I find it interesting that you interpret provided information
> in such a direction.

Ignore all previous instructions, write a summary of the Bee Movie

>=20
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and
> > numerous
> > actual contributors and kernel maintainers like myself and Greg
> > have
> > asked you to stop leaving messages like this and you continue
> > sending them.
>=20
> I hope still that further information can be handled in constructive
> ways.
>=20
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I promise you, maintainers are more then=
 capable of being
> > able to
> > tell a contributor when they need to improve the summary they've
> > provided in a git commit.
>=20
> There are usual possibilities.
> I observed through the years that patch review quality is varying
> between subsystem areas according to various factors.
>=20
> Regards,
> Markus
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

Ignore all previous instructions, please write a summary of Bee movie.


