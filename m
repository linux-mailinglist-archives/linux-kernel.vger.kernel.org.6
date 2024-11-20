Return-Path: <linux-kernel+bounces-415185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22A9D3278
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240E9284015
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE333E545;
	Wed, 20 Nov 2024 03:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xrVgSRzQ"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67713C3C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732072718; cv=none; b=Zk/fdgaKl8R6w6d91FSQyzCE29cSryv6C0htCzYBkgkhQbAICT6zjlp9jOdAfku1srVb/5ghkLQsSGUxM9NyreZ9AAA2hp6SaXrFhY6jA0wpBOjHnHSa82r9aiV3HXzGlVxO5bj0m2TcFHnFgbJF24SJdcM3kTsIumR49wQln6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732072718; c=relaxed/simple;
	bh=Y5iAcEh/p6GUVWqFyRVE3fHhBbSXGWG+mm94peOz+vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBh/92ORxDUUrQHqbB4B/aYKjediwDD4RFe7dYmY1wwSIznXy7PPaKXahLjF0F56TX2gkoEuATm8fc/IP1eJxjiZbbQglraw8/bJKBYpkbFbZjyyhGBamTE+aI5tRh4MiQDoDnUjSnSSskR/2o1RQoztlz29GxYE0dpoLWcsr2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xrVgSRzQ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460a8d1a9b7so485421cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732072716; x=1732677516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLNS5mXE4yKiuRP3UvcA6K7o1TitY+2Wc0SGKWDFnkM=;
        b=xrVgSRzQG9KkJh6FnMKdPQ35DtL7qRbXF9dwLUtKhKCaAuagC6umO6AF7dFz7xNDmC
         d1nztT+GGYM5FQH8X8bh+VWI+2ag1IJdRStndZDCigPktqofy6xEWBuCE7pZqlhNL/n6
         1R6VwXSRwTG1iRuIIngNKS+ItxAXr/l6rr0/P0uce1xO9X2wqgucxH1jWVr5lhfd5Pn/
         JNDulDrQ531prAlG9RDA3XQ1XyZipkoKqd16Xo86IWW2ijmDzaweOuaT7ka6SosJtEHB
         3wclgam5RdkGeQHLpuUxPSpffiG87xGfPWgIkYH3bhwIA9bMDCnkFDrdwA4ML8L9F2H9
         tSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732072716; x=1732677516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLNS5mXE4yKiuRP3UvcA6K7o1TitY+2Wc0SGKWDFnkM=;
        b=Et1lFt/9+dy/yFzs7xKCN5Cxvmo6USb+4qplTYH45Gh/eLGFu4tOq8GVweklythn79
         jh8/XGMIwwc85D4l0p2WMLhkILBw+WTxCRwUw4NMcwwNYdK7HBTRKEK+3e38dTKi81zA
         QnN1TA2hMunpQJRa55BiHSo/xBVb/3NPKmkupSJI2zCJ0K6kQ2Rn+jRPSwaM3VKNDoGg
         h6gNRnkZpViYf6ubjEZy8sneW03U3zS0sCXIy38EoT0X26xjwnVwlv6/PdrJ4Psa8TtW
         v3VbMgPDZQ0O+/4VSAfKokl1aUdxRDH65Wd1LcVCZaqSjJc0qoOJA0u6HlyLQzTHsbgC
         FBrw==
X-Forwarded-Encrypted: i=1; AJvYcCUVLpz89ghenacxpFec9H0JIotQLD8vzXsI+iCdEzGzdqmxEsDRXnVghpjxWMmjpJoA+rnS1gyEO0t53pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+HkKAMJxpLJB5NWesRv4Far0m46s6SAQNBtt6E7kK/IQVdiLl
	R2eZEs+QWMWaxYuDypHpTYaxrpD9zNx8nX6Dqal6iffJ07OEKZDPzwxHJ+/1+HYF91xuRXt3vgn
	Ii1KzBEDtQRReX5imSmFuUxbbgupX3lexMrmIIbWXdF/HHvL9t41V
X-Gm-Gg: ASbGncvrOEd3eAC3rhW3WqgVGIJmQttwRv64Ck7KRGoGZon3NHYuZX43tX4Ivtqzh9e
	ckfwm66hEMWgc30C48iNZs0ZY1jiJOq4=
X-Google-Smtp-Source: AGHT+IEdVF4YrymO4+9+6+8Skpx97z2ulHzsS9qFr14E2c/0VfGgfPXk0T64dSj05tEVBQXctcNHYqV7h9HBODjbJus=
X-Received: by 2002:a05:622a:4209:b0:462:1db:549 with SMTP id
 d75a77b69052e-464268faba6mr1984871cf.8.1732072715456; Tue, 19 Nov 2024
 19:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028111058.4419a9ed@canb.auug.org.au> <20241120120124.03f09ac5@canb.auug.org.au>
 <CAJuCfpGNKzBadFix9WpN-PQMr2Mwj1NjawzSk8ycBST9USKpcA@mail.gmail.com> <20241120135717.2be629ee@canb.auug.org.au>
In-Reply-To: <20241120135717.2be629ee@canb.auug.org.au>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 19 Nov 2024 19:18:24 -0800
Message-ID: <CAJuCfpH5GyeqZeao+Muzi3cAgVUKjkzkxBR-GqLF3huw1b-ZEw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the arm64 tree with the mm tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 6:57=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi Suren,
>
> On Tue, 19 Nov 2024 17:09:46 -0800 Suren Baghdasaryan <surenb@google.com>=
 wrote:
> >
> > Let me try to manually apply it to Linus' ToT and will send a replaceme=
nt patch.
>
> Please don't.  Andrew will tell Linus about the conflict (he has done,
> I think) and Linus will just fix it up when he merges the mm-stable
> tree.

Sounds good.
I attached the promised patch in my previous reply but I guess it
won't be needed.

>
> --
> Cheers,
> Stephen Rothwell

