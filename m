Return-Path: <linux-kernel+bounces-412176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419889D04F3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 19:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EE9B21673
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 18:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE51DA112;
	Sun, 17 Nov 2024 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GLQKe+s6"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEFC15C0
	for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731866434; cv=none; b=VW5TDJA8/Q47GKLchrwqjlyAn0ZLY4Xr0ZCL7qeenJxdR+are6CdS6XMbeJ7gMUTjuYPDBa8DxfOESeC7ZjMSWOAE1z4gRRXB349Sqtds3aUk8qkLXt8Qgxq8n05ZJEo3dhBbbsEKHSPkhhtUa0qd7p0YxXbd6FwTQUAMsVrfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731866434; c=relaxed/simple;
	bh=n2Xyi5WHYcPb+hdFFb7K38+N6EDWPh0aIcGkFbPwbfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/ceOW8DxTAaxenJtNX1XfJ2YvFzNygThb1PLGHUzRhCV5aoZG9/qJG+LFlU6puCX35Kw6OPBHpsQUBsg772sjN0+atenDSobagIOF8zL9QpjrI6azJj7UGhZbtKy3k1cH0KdsgPYaGw7lSdYGAt+cHQkY4URoEqABzjQwnGa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GLQKe+s6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ec86a67feso670280366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731866431; x=1732471231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=62JPUB8FB2DzJFTl+6XHcOGfr7T+tH1N1vjbK06wZWY=;
        b=GLQKe+s6FKomMq/TJzlumTxlHvXamrCEIsQ4MO99F1/cn6EpcZh1bMCfZVKmGIlM1R
         YuhtA1VjRmtsZciDorXbedId4L/wPq+FILX8UU+oB/7W+Emg0cQAMF4T+OkY4/SWfyUc
         mmkSVtkqCfsElheYVAe0aSY0b5VJ2MA/2QFww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731866431; x=1732471231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62JPUB8FB2DzJFTl+6XHcOGfr7T+tH1N1vjbK06wZWY=;
        b=uToRaRtMaHlIT6HmkVGnqpJMTI1Wfk8pMFBen0P2pH7EQo2wpqbicyjXKtzCUkOEmc
         z6WEKScfRMoOIxRtkFruOmAt5lQUgciQPI5Nmon+ZlzDwyMEYwuTGZ3bK4eO3MUC62GC
         ggqa5ZBhTogxQaptZ6rYKsXR9N///goMdgVwWHaFIGagjhsiu3HlKQ20bR/rfaIWI/QB
         L6Zr2lvMDQ+MpDzgubtrHotXF8XJQRseuw/JGdky5BWk8w9ssyYOBdTX6PL/SdDlgY0G
         6S1JO/dwcfR5aicc30EN0wZLcW5LS7F51SGsROHPpVr59V079thVPmktsu+lTfzpBWBv
         hiiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBKNRHDWpWiA3NOM/TQQ6w+JXUOBO+Nr3gYUiDF4acJmsi/0tB9U7eK1EvOJQf3cX8O5AeElf++MPXRYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZi8TdPXWyOSI7N9L6ZlApkhZY051A8PgU4N3J8Nc8LuXkkyCg
	vNOHfdohJhJ/vU5HuFBznB05nqf73WdBN7X/91ehP6puGFuV51ZZPeqBodqgunbJfemRMoLH1jr
	51mtBMg==
X-Google-Smtp-Source: AGHT+IELzlYgkxK9XRwrnTYW6fdxR952lGpbvDsav9GF5O/zfc79eePtZ2wS5QnCLhOcZrZ/epcFLQ==
X-Received: by 2002:a17:907:846:b0:a99:f56e:ce40 with SMTP id a640c23a62f3a-aa48352c0e9mr978738966b.47.1731866430909;
        Sun, 17 Nov 2024 10:00:30 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e003ff2sm444720866b.123.2024.11.17.10.00.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Nov 2024 10:00:30 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a4031f69fso573018866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2024 10:00:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBaySHJGbi0AA7DHibEJKy4SXk7lYD/20OKd7qhlmTERoMD1i+mgUY5tSiuNJLHRR641bkZ3WcM4zQx1k=@vger.kernel.org
X-Received: by 2002:a17:906:fe41:b0:a9a:7899:eb87 with SMTP id
 a640c23a62f3a-aa48342678fmr916901066b.13.1731866429032; Sun, 17 Nov 2024
 10:00:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113172939.747686-4-mailhol.vincent@wanadoo.fr>
 <20241113172939.747686-5-mailhol.vincent@wanadoo.fr> <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
In-Reply-To: <8bf6922f4bb143d1bc699aadd1c84607@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 17 Nov 2024 10:00:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
Message-ID: <CAHk-=wiq=GUNWJwWh1CRAYchW73UmOaSkaCovLatfDKeveZctA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] compiler.h: add const_true()
To: David Laight <David.Laight@aculab.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, 
	Rikard Falkeborn <rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Nov 2024 at 09:42, David Laight <David.Laight@aculab.com> wrote:
>
> #define const_true(x) __if_constexpr(x, x, 0)

No, let's not do this "double expansion" thing again.

If we actually want to make things smarter, the trick to use is to
know that only a constant _zero_ turns into a void pointer (aka NULL).

IOW, something like this:

   /*
    * iff 'x' is a non-zero constant integer expression,
    * then '!(x)' will be a zero constant integer expression,
    * and casting that to 'void *' will result in a NULL
    * pointer. Otherwise casting it to 'void *' will be just
    * a regular 'void *'.
    *
    * The type of '0 ? NULL : (char *)' is 'char *'
    * The type of '0 ? (void *) : (char *) is 'void *'
    */
    #define const_true(x) \
        _Generic(0 ? (void *)((long)!(x)) : (char *)0, char *: 1, void *: 0)

should work, and doesn't do any double expansion of complex arguments.

           Linus

