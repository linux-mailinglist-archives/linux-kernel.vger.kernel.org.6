Return-Path: <linux-kernel+bounces-305292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779FE962C73
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2AD1C241DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F851A255D;
	Wed, 28 Aug 2024 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="rVtZB0B2"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244B18B476
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859228; cv=none; b=t6H/tAixue/T8Z0cMvigQx7bobYYd6vqEAch6pkeTPAf99eu+N+A35Mql5aoL+AbpkUr+/IZ4JfNQxUiQNM8LjvgdnS3+PBwvC71s+/jufDlJyygZn8244fMvcXcTE/T9YGfXHZx/0EFQ5cLnEQhKO0Nr4ZVJgKiUcHyJVD0Thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859228; c=relaxed/simple;
	bh=acM1ukf0PGPklUhQILbTRdsFVowcSJS3k8mk79y/5ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rz2V2DREiAHGFkeCx/iY5uPCA4Zr9RoKJjNVc98uzOHcxerd6fZ9J99HHEbIxF2W2qq9/1VKOzYrYSw4SiPf669uQj6vBgqCJIaRtzKXPNmsSwHQaxO1Mas0zZ87tgam74ckccq/gYjTyEPucOjSyi1uehWu3U6rbt0OMPMDoTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=rVtZB0B2; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4567dd6f77fso1753331cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1724859226; x=1725464026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acM1ukf0PGPklUhQILbTRdsFVowcSJS3k8mk79y/5ak=;
        b=rVtZB0B2Y4b/Imf5ajdAai6Q+36XQaF5pa6QGNqrArwjA4ZBnm+LdtuoB3EMZEAFU9
         hR8J/nVzircY75CRXfd/SGluXRxBTPhzLkVuuTU1Sx/149Mjkfaj35YasmywQK/kgLi0
         kExpoWXg/dtmpilKZormrg9gDzQaD3TZo+Oycp10sWPBNOBtF9YRfs+7VXeVYDJ2XsNs
         NrwW8KZok0Efwl/e2shI5AiR8bGlRIXMyZv0m933KRnhJgFSzxikFFHxUy/PicaYiZpk
         xaLGgKvNYfMVmHGl06FrY5AlDQrs1HR+uHVK9j1wzX19KnriWRp4eCH99Q18szLSYvHo
         9KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724859226; x=1725464026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=acM1ukf0PGPklUhQILbTRdsFVowcSJS3k8mk79y/5ak=;
        b=rHLas6nBKM2aEfRGvyM8VPamaJJlA1jvcFS5jM+3Iw3KaCkqQR89eVX3SG5Fur8tPJ
         luOHC30xOhBPro2AGwCZtdRH6BxE9lWWkmEz8VoAwIgWePxUo3DifmsUePP/WuTe58a5
         arZ6JQ9Dm8cO1YcU2pUyr9XHL5ejKYzpL//XFrLEiAKy0iH6hfomgFkg5NE+5gLLJG8x
         wW+2akUb6AbQFR2W84XxZGU78xjfP6fSp7/VL1M0ab0IHTiVRu+1u/Rcldqbp0M9gLfM
         YcDBQXdp7lP8wbNtbvISsQszgSBakHZANe7xQIlkzRssW7ZMCoGsi4DpB4b22ik8PTUD
         io2g==
X-Forwarded-Encrypted: i=1; AJvYcCUNwBsklnamqDgdc1Sr8I5hsvglNYcsoF1PTttVL72ItEV56VVjhN1g5D33MXBR8eQNb45JTkesyIj6XBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/bYYl68jNHMt6zyI8PMhOWXzs3ex00VuXm5JosH7N0LCvdMp
	vflYJ6SJePGLO2WKrk2k14EE00W5FFblaqAuiEWLV/S4LFrSbMWxNLBnkqujZJ2/rF1SxX4wt0I
	xSy33zybckd3v5JM6SZ5EuUBZuqlgZkX+0xAwyg==
X-Google-Smtp-Source: AGHT+IGuHbA+BH18lwQy43vBRDD5DrkY4oXBSXZ5klly3Olcm3w+RGVVcoWnqupt+RXR6gfSH1ha0PF3aVb1yC+miYo=
X-Received: by 2002:ac8:6312:0:b0:44f:eddd:3e13 with SMTP id
 d75a77b69052e-4566e680d2dmr35509551cf.30.1724859225414; Wed, 28 Aug 2024
 08:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824215130.2134153-1-max@kutsevol.com> <20240824215130.2134153-2-max@kutsevol.com>
 <20240826143546.77669b47@kernel.org> <CAO6EAnX0gqnDOxw5OZ7xT=3FMYoh0ELU5CTnsa6JtUxn0jX51Q@mail.gmail.com>
 <20240827065938.6b6d3767@kernel.org> <CAO6EAnUPrLZzDzm6KJDaej=S4La_z01RHX2WZa3R1wTjPc09RQ@mail.gmail.com>
 <Zs9BSOnKVdnsXcRf@gmail.com>
In-Reply-To: <Zs9BSOnKVdnsXcRf@gmail.com>
From: Maksym Kutsevol <max@kutsevol.com>
Date: Wed, 28 Aug 2024 11:33:34 -0400
Message-ID: <CAO6EAnXRdPMq=a9HWWxXJfc+10U1Ts1dvoAacKbNRRhrru8rcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] netcons: Add udp send fail statistics to netconsole
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Breno,


On Wed, Aug 28, 2024 at 11:25=E2=80=AFAM Breno Leitao <leitao@debian.org> w=
rote:
>
> Hello Maksym,
>
> On Wed, Aug 28, 2024 at 11:03:09AM -0400, Maksym Kutsevol wrote:
>
> > > Stats as an array are quite hard to read / understand
>
> > I agree with that.
> > I couldn't find examples of multiple values exported as stats from
> > configfs. Only from sysfs,
> > e.g. https://www.kernel.org/doc/Documentation/block/stat.txt, which
> > describes a whitespace
> > separated file with stats.
> >
> > I want to lean on the opinion of someone more experienced in kernel
> > dev on how to proceed here.
> > - as is
> > - whitespace separated like blockdev stats
> > - multiple files and stop talking about it? :)
>
> Do we really need both stats/numbers here? Would it be easier if we just =
have
> a "dropped_packet" counter that count packets that netconsole dropped
> for one reason or another?
>
> I don't see statistics for lack of memory in regular netdev interfaces.
> We probably don't need it for netconsole.
I like this idea! I'll send a V2 with only one attribute.
Thanks, Breno!

