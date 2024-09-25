Return-Path: <linux-kernel+bounces-339133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991169860A4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CF5288DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4C5C603;
	Wed, 25 Sep 2024 13:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5/nx5z8"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EBD537F5
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270344; cv=none; b=qfC72XJulmpKN4OjFOa9GVeb1hOqW/T4MvPEztiOPi69mq8R8QlTk3A7i/5XpheWI8IgC5gCw/DNIx1vnT2G5dR/yh8SYVYf98MTe8qDK0fNkyxfV3IFKiTOFwDhejv7Z8eDirp2fOnE/ZcmouILBaKh+wnZOxes3jY23OGq884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270344; c=relaxed/simple;
	bh=bSUUCMRcUEPJMWUyyq7cDb8aB2SQdtv/cShWT/TdmWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEif9zkeypMbUNNardOmVl+ByIJmDuTIlQuIYWPgfkaWlqKFnWqVgDdEThyxlr1tpGRL+u3eyhp+0stixNlgPTrP9BsFBufGewdkJ12H5jxQsv/e65a0fyWXiehoYLzXCIXqJa7RgbelfIHwX7rAJdlFWS/yGNjjJgtvZrCGwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5/nx5z8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53659c8d688so774305e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 06:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727270341; x=1727875141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSUUCMRcUEPJMWUyyq7cDb8aB2SQdtv/cShWT/TdmWY=;
        b=B5/nx5z8eviWPW+i9uZOuT9VAnXcyB8hteg/z4567NlvaoSRfLww3ZTUzUK3jcw3JR
         yAi7Fle+vK6K4a7I3R3eL4bSqtG7wFsadmAVJgzbGCHaFzDR9UWFwgDAI0n3zY7CRAMZ
         ahrmO7Mmo29kPf0NY3fU/C5gUJliaKxUsUsFVg8SNXDcBnJv9x6Ds+ovYtJusdKthjjs
         zBmTqiavc/a+PzGjOHbZGJrPLnlDDfPNP/dS67T9YroWScrtZbAlzDouVOSmD4rCxwLA
         Yji89MaOHTSEjNgKtdTAgNUqDaUNkzAKdBGLqFLzIQHH6Qa8yYLiCj1wzgeDOuQY/og0
         S5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727270341; x=1727875141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSUUCMRcUEPJMWUyyq7cDb8aB2SQdtv/cShWT/TdmWY=;
        b=jmIELcM/5J77cVZxUPwFvCVHrB91SPxvo7ShYJFxzrumQwRQVfQBB3jn5UElphqIXS
         mVID8K1QGL1KMKKlDxC94lz+pQDvjHT+nqD76ZACKAJrpRjJ8p3BB6NZTMHZRkwJjK3+
         m7aQQSVcbOgbXzWsWipW12s809gkhMBGfxGekYlSUsxzNjr3tZepThgzu/pTW+MVZCOH
         u5aj5thvsUr+wIjkv2cmBvIPOYNyJPW3ye8vbpENMcy44rxh0ONp1fBo3lfdrFJaQtGC
         4VCXkpsGnBn87RBs27MaASvEPytQ0QF46sLIuYsvyR8pYdJy4ZYNIku6l2lXXC5VGAFc
         2sxw==
X-Forwarded-Encrypted: i=1; AJvYcCX1qsnVNRXpADh1YR4C7UhizH7yAji+QvCiQhAmB/FPuvsmXQXqqvUmlyheo2CQ7IohPAFPYOAtzybSCFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAmc3NLA8n4WZhBIO19vnYfCs/mwV9vjxMS6l4tMrl8VbRy0U
	BhPFhJkAfOatFE17Y/cbz/4ROKG63kx1yXbkq4tbjQLnwsCHa8YMP44HWSLPnfRk23IxZeRnw9G
	OQB3lL43QWmGael7qEKr6AY6oWtg=
X-Google-Smtp-Source: AGHT+IFl452v5tYyj4PohbBlaI7VqwpRobJ6IjXzS1JpKUP9zXdChn582VM47JwDn1+7KDLISV/7kYSXOzSvXmKG24A=
X-Received: by 2002:a05:6512:118a:b0:533:32cf:6420 with SMTP id
 2adb3069b0e04-5385117d7c7mr983870e87.8.1727270340398; Wed, 25 Sep 2024
 06:19:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
In-Reply-To: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Wed, 25 Sep 2024 22:18:47 +0900
Message-ID: <CAB=+i9TJcnFhwef+efw8yBynZ28M2tWiYvuYS0aVoD4yt_+0Zw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Introduce panic function when slub leaks
To: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, tkjos@google.com, 
	Fangzheng Zhang <fangzheng.zhang1003@gmail.com>, Yuming Han <yuming.han@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:23=E2=80=AFPM Fangzheng Zhang
<fangzheng.zhang@unisoc.com> wrote:
>
> Hi all,

Hi Fangzheng,

> A method to detect slub leaks by monitoring its usage in real time
> on the page allocation path of the slub. When the slub occupancy
> exceeds the user-set value, it is considered that the slub is leaking
> at this time

I'm not sure why this should be a kernel feature. Why not write a user
script that parses
MemTotal: and Slab: part of /proc/meminfo file and generates a log
entry or an alarm?

> and a panic operation will be triggered immediately.

I don't think it would be a good idea to panic unnecessarily.
IMO it is not proper to panic when the kernel can still run.

Any thoughts?

Thanks,
Hyeonggon

