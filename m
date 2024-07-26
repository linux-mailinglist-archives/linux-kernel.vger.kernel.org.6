Return-Path: <linux-kernel+bounces-263299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D3E93D3F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015471F24B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FAB17C213;
	Fri, 26 Jul 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UldgrY9h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FAB13A3F7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999786; cv=none; b=qaGINwhKd5BXillC1pxoxg/DEIZH+wQkQqLcr1cFyo2eGf1ZluoPbFzE4FZqQywlEVOSy+AlUDH8rXr4XYYiDtngzDtF6Mfb7HLD0cW6Jao+xYnHULwRz+qB61W7+fbQNQA2cs5IlZI7XeDX/8FYowah2g2UbGTB0j8UB1eDLK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999786; c=relaxed/simple;
	bh=xmKf9omwUxucT1oeRkAGbgWNHALpXShtwR2JSwaiBgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=G8kjMJLZFFAQHRd0KESXgIjvtu6QSPwmkV1bQLUjbqu9CpuNanp2YVsDPqOVjG+TQYMrCxKTYn0TCgB1fCPUNxNU6LZO8Hdlf8t/T5NbjohNVG6H+rIVdVTKVAKT+nEcAicpsFU72cdI9gpVeDFJHYiog2tUW2UwWvJ1CGveynA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UldgrY9h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721999783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+Xb2FoYdB0d76xIYmgmvNy/BmZ9+wOzI/YfNgYKqlo=;
	b=UldgrY9h4raN3oKBJQ1WArLmBAH9YOgPrXETU15x6/S0SvEzStRrMT2zqxvR4xCzPwkyfb
	WzDupIqjHXzhqr5oC0ZsLKl9lPspwVB0JFgtuTPHf4nMy8gckp7WLWZ/NENWZ652zT7jRz
	bZxoqv8pd5aJl6NmE7q2dRJfjNCdBDs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-EoRgXg6QOyytad3d8_ddmw-1; Fri, 26 Jul 2024 09:16:22 -0400
X-MC-Unique: EoRgXg6QOyytad3d8_ddmw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f0276170f9so12456201fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721999780; x=1722604580;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+Xb2FoYdB0d76xIYmgmvNy/BmZ9+wOzI/YfNgYKqlo=;
        b=xUvE/tirATUxOAMorw0ILI1o38UzZmc5CSad2SagF3dESqO0J8py2sf6ItW8wlBMg6
         JFzryhypScMa00Qo3t/JZhjxkNwDyFVIw99ek1sUHFGdTOMof36ZG2vNA08W7O5/k3VO
         SyUWwiGpEgY/6cLTxP26AgKJcGPd0WksD7mhKZalwbuqx0LRi0suH2ns/oFVZe5vS31g
         OZf2bmOdGJAyk6TAdu5peDL47Za/KiAYZqpE4EQz24gAK+d40tApqlyJ7olO0KNsni1d
         zuo8XQpO6LcLtm8gxOYjBXSlAybBT2OnwJnpc3Hn17WhTyzJrvas98ieHRsADGphzNJj
         gdbg==
X-Forwarded-Encrypted: i=1; AJvYcCVjrBc0gkLnXRRFISIcbiJktJ42k3qUM4x8tRRKFmOuDCynJemsAfFzyH6fGtKE++I0O1iZpqMDkjSfoAoXEusIt+isXBrkDKtjfDgW
X-Gm-Message-State: AOJu0Yw43rvzFZLsh31ZTwGuNcP+HuRC+aH7aRuZfEHd91tU52xW7HXy
	tJGV8dONucvOvWXy2XnwVq620u/RZdOYI/l00KOjozdwCq25Cp8zcF2RoRTm0A9F1RoL7XFQgp3
	Z0nJzqnoKxnWZLSRFhO3v+r/+O6VLr6IKhvZek8PhbLTSr86fows4MkuuoXh0ybzx90L12hd1rt
	+vi4YRSVuNUYyOhMGoz23NvgazDNeYDq10uPWX
X-Received: by 2002:a2e:8ec5:0:b0:2ef:22e6:233f with SMTP id 38308e7fff4ca-2f039c9862amr40567681fa.21.1721999780757;
        Fri, 26 Jul 2024 06:16:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENkd152LdcVGYZFsu1bzI6uLueRTD0erDZebrYWI+gUvt514koc5pNhArM6ncFt9ikhIn1ddo0wjWm/mrfZK0=
X-Received: by 2002:a2e:8ec5:0:b0:2ef:22e6:233f with SMTP id
 38308e7fff4ca-2f039c9862amr40567411fa.21.1721999780306; Fri, 26 Jul 2024
 06:16:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725013217.1124704-1-lulu@redhat.com> <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
In-Reply-To: <ZqKKaLdn3DBr7WrK@LQ3V64L9R2>
From: Cindy Lu <lulu@redhat.com>
Date: Fri, 26 Jul 2024 21:15:41 +0800
Message-ID: <CACLfguUORsgxmya8v2shsS5mJ3iZpxu6zv-fGsw9ZS2uwFFPWw@mail.gmail.com>
Subject: Re: [PATH v6 0/3] vdpa: support set mac address from vdpa tool
To: Joe Damato <jdamato@fastly.com>, Cindy Lu <lulu@redhat.com>, dtatulea@nvidia.com, 
	mst@redhat.com, jasowang@redhat.com, parav@nvidia.com, sgarzare@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 01:25, Joe Damato <jdamato@fastly.com> wrote:
>
> On Thu, Jul 25, 2024 at 09:31:01AM +0800, Cindy Lu wrote:
> > Add support for setting the MAC address using the VDPA tool.
> > This feature will allow setting the MAC address using the VDPA tool.
> > For example, in vdpa_sim_net, the implementation sets the MAC address
> > to the config space. However, for other drivers, they can implement their
> > own function, not limited to the config space.
>
> [...]
>
> Nit: the subject line has misspelled PATCH as PATH
>
> I believe net-next is still closed so this code needs to be resent
> when net-next is open again in a few days.
>
sure,will fix  this
thanks
cindy


