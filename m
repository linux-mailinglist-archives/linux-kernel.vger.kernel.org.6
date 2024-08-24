Return-Path: <linux-kernel+bounces-299816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE795DA53
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 03:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2091F233C6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20B79C0;
	Sat, 24 Aug 2024 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B4jcbAUV"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE837A47
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 01:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724462084; cv=none; b=Q781hcYE9oxOuC0kQCq5tW/YknrHc/ecqvr/Yiupa7n1i+UIXAqFdKRpy/mA6GvH25Z7iWX6X6wtnXHNAA4J6w76vaCnTijAJbZEnBIznPwySg06YgKVogMOs4CI8rl+QKwF7EUu2XVMTOSo0a0w96wYUs+6h36Q0O6DNhebbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724462084; c=relaxed/simple;
	bh=3ltXvU/EqVjBNZCATDE9AKbK4I9cB4dTLRGwGvtGknE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ucGxzncva24spR7Zdcz5DVusOZf2op6CvQGdbx9iCd0Rr1MIIsol0nOp3+ulLfB3B1Wi6o6My/GBin4ZpjSt2nqWMSyiJ6yd0XFU3EhvaLXcMQT2Uu1yAY240NlE+lpMX7RfuAfsc7w+Hb66pZNaiQsoTsoxw2yiosVfPbt2KQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B4jcbAUV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b99988b6ceso27541357b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 18:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724462082; x=1725066882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4D2X7/K+4SYrs0mfjAke0PQKQjsGDVZHDjzzxg00m4=;
        b=B4jcbAUVWFfZHxTHIUUHMAxvEaDDPPOgExqNi5B698v+ryd5iKCKd0c3bXQvWJ4z9s
         ZvCXPRt8QWuaJ6WFii4mejJ8VduNq/Xg24IQJCDOJGVmVTxDcOef9aAsycmM3dmwtQ7v
         w4qNgi8pTGD4n7JtzEKriAJbC4r0L4KRZEijA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724462082; x=1725066882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4D2X7/K+4SYrs0mfjAke0PQKQjsGDVZHDjzzxg00m4=;
        b=DzRKflecJ+wJFYfz2ur6SB87KfxBzUIbmLgctrJswayRtnB1t0ra8g/TTOAlnumSb+
         NbkgQEMRJBUHyq4F6Z5LYRJjVWyDKJHQMl9KBgzZX5CUVmiG0pchlF5oxseF689zdKBM
         s/u2ePzKSEVw/4pXOC1Cy1IIqJhv/75ZimSk3x1W3GFby/DBpdsX4e3NvnFqzyWIuB/q
         kbHsZVkvaRwIiKGmT6VFlckRGL4uZNsUFApC63aZ+ttk7qBmvcYVQsDHPJo+K2/kKa/G
         4rqk7gAkhHFmStVnhhZVTGMZWWUZuB4512Pfy+lCKjLZKBQ+G6f/nAuEzaOiw5VLTawA
         RaDA==
X-Forwarded-Encrypted: i=1; AJvYcCWsejoFPeWNrXRV6uxariV5qxRNHPfVaS66xn1OXcj78CtSGl1mph7o3a3yInSpDj7kUjz9H1WDzkfMPHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybAYwJBOKpwAUIp6df00ruDDCvCnjv7+J22KosGumqESFkM8X6
	4NmwxqnNE7ll6dVr09OjtU6I7NytIDNltD79FnKbr6ut9Lvm5V28cQA75nHn3XMKylTGRkQLd/t
	WSXpIJYGEr/eemzHp5Oh03RB68sD4MTtkOzLkhA==
X-Google-Smtp-Source: AGHT+IE6ZW88HoHP1Dw+5Mhydbv6PiMgNhRVRsbt3kx9tUZB91yn8vzE8b+B7f4QD6IHh4f2iU6uScsmlcLPUekzXvY=
X-Received: by 2002:a05:690c:6609:b0:6b3:8248:34c with SMTP id
 00721157ae682-6c6249dd2femr48331147b3.4.1724462081895; Fri, 23 Aug 2024
 18:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823-firmware-traversal-v2-1-880082882709@google.com> <Zsj7afivXqOL1FXG@bombadil.infradead.org>
In-Reply-To: <Zsj7afivXqOL1FXG@bombadil.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Aug 2024 09:14:30 +0800
Message-ID: <CAADWXX_zpqzYdCpmQGF3JgsN4+wk3AsuQLCKREkDC1ScxSfDjQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
To: Luis Chamberlain <mcgrof@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 24, 2024 at 5:13=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> I'm all for this, however a strong rejection outright for the first
> kernel release is bound to end up with some angry user with some oddball
> driver that had this for whatever stupid reason.

I can't actually see a reason why a firmware file would have a ".."
component in it, so I think the immediate rejection is fine -
particularly since it has a warning printout, so you see what happened
and why.

I do wonder if we should just have a LOOKUP_NO_DOTDOT flag, and just use th=
at.

[ Christian - the issue is the firmware loading path not wanting to
have ".." in the pathname so that you can't load outside the normal
firmware tree. We could also use LOOKUP_BENEATH, except
kernel_read_file_from_path_initns() just takes one long path rather
than "here's the base, and here's the path". ]

There might be other people who want LOOKUP_NO_DOTDOT for similar
reasons. In fact, some people might want an even stronger "normalized
path" validation, where empty components or just "." is invalid, just
because that makes pathnames ambiguous.

              Linus

