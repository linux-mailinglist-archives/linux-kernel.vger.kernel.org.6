Return-Path: <linux-kernel+bounces-299187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A09495D14E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB141F232BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0F188A2D;
	Fri, 23 Aug 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VyaghxWB"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B6F185B49;
	Fri, 23 Aug 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724426708; cv=none; b=BUvvfHR/rCOi8/A+J3jwIPBlGSqRIHjr/4PyLwCM6u4QKxEnmDfUbO4Hn3UMOfZylWozyjYQPTt6OgxpXMvL30Rssra9sJqQbPFpQv50VcRLDacKSy/FMCnwNjsZpYYBnMbvzWRUboH6xet7n8KLlz6yK/GhF7WSPepq+9WL1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724426708; c=relaxed/simple;
	bh=mu9UKweC9V9eM6J6GCNNvhfyqUFybUoG/LWx3cRLPJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO33X6U5xjgSkKH+Jpt9Ywsx1tExv6n2G7NzPiDuwxG3q3Ywc0uNHRGbjEogd0EHYjWKHs0mjeAVY2kT5xKZ2u8pLkYZOk0UPMFkd+BcV9LTvmw9xpggf5YDeEq629G5M26YJdgjl9Xbf39I4w7x6jPWIqRoWIS1kRb9LG+jN18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VyaghxWB; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6bf7a2035d9so29494206d6.1;
        Fri, 23 Aug 2024 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724426706; x=1725031506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu9UKweC9V9eM6J6GCNNvhfyqUFybUoG/LWx3cRLPJQ=;
        b=VyaghxWBgIBM4N99HtS43bYTFhHdaKknAk2vVfX6JbRBayihvSySuRYwa+PYHVDYNt
         onSjI4pgtWblysxNaTKNJJKJvCZMIJAoCvSRf5rLmMcpYZ1/fxwUBKm2ahsFYvhmR0LF
         AR6RX/sFYZ5NFH7XLp+CW7Gin1iXhz9aLoNYrfhbyZe44JeCMFteuIKpf/dU1JEyPot4
         NuvsHp8z5CMt0YhBfN58nN91ToGnydz0QXe4W7BVGjz7oSKa4fuIDwj0y4OnM8Iqgucd
         I0cRjhUdXeakd04yWnYiPscMimTyotlsORYRoChqcpSAi/fp+hQQuXn402abotluDy8t
         pFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724426706; x=1725031506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu9UKweC9V9eM6J6GCNNvhfyqUFybUoG/LWx3cRLPJQ=;
        b=FbVITqquJsgrvp88mJ4NE6ez4YxhMGY/V63rg5sBTipRnha5HFUQJJkIxaDGy/k5wc
         mXZXvTjby9gPaq1b2FqipuKHdYlg8WjKdsTA3PQ6F0cvgRllDFjeyXHGDyVu9RXRQd9d
         svcFIAdU8IFkdZza2npvRnhmXA0jRsCwTl9g1B6VSKHqH+Xx2i8Yfn2fyly7pxv9Q55k
         ymv6bt0QFa4KvwaSdP2Q45PEGw94X9R1BGIKNMuQpsPcb+xpuqkyEfWSq5Q8aJKjK0ml
         APx9+kc6V8fBY189sxqY6SgBjqUZAt3hy7qJ40FXDS94m5unBYVtLAO5DEQRBjA0lS99
         HOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+rtYCd5PK7xrMvDd3ZID7Mv/BL+GFXrB3kwvABJDJhDyUAXCazHpDStlLiIYauekO7zVYrP624cPK@vger.kernel.org, AJvYcCWPB1jEYt5rXJQCEw6p48ORcXd6+Zrs0I51gWvS/+hge2VxlfxqT/NxYBXhiZFQ/P7YGNkR+1VkIQ5yJ6um@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+WrA8eVtpPZnqgmBcD5OKvwbZ+TQ5wZHpLEOWmLlHndXaSYE
	wFSvtXuGCr4xMcqWslx+RWqpJQsF8BX67UJynn+/7mr4ZYrT1q/by5CvvugGPnPVvcY1n5VdV2+
	OKLbgm3VXZXdwjVifshVagcgpQj0=
X-Google-Smtp-Source: AGHT+IGoVva4JWtaN/yAOWV/xxGdHWcZXvWEgwo+5tN/1E6XCsWI98CURV6Xs5Nr2aGAcFUXE4P1qpf6FoQapiSYuK4=
X-Received: by 2002:a05:6214:5d0f:b0:6b7:4398:5953 with SMTP id
 6a1803df08f44-6c16d4a11edmr46738446d6.7.1724426705863; Fri, 23 Aug 2024
 08:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822170440.265055-1-robertcnelson@gmail.com> <fe33a2tns5thgxwlyeqk7kh5lve6vqlfmkwiosh6mew3ohjcsl@rdiwvnqgoaw6>
In-Reply-To: <fe33a2tns5thgxwlyeqk7kh5lve6vqlfmkwiosh6mew3ohjcsl@rdiwvnqgoaw6>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Fri, 23 Aug 2024 10:24:39 -0500
Message-ID: <CAOCHtYgi3PRHr1k99K3oLEXhD+bB0FpmXh3K60aLc=i6=J+6=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: ti: Add BeagleY-AI
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 2:41=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On Thu, Aug 22, 2024 at 12:04:39PM -0500, Robert Nelson wrote:
> > This board is based on ti,j722s family using the am67a variation.
> >
> > https://beagley-ai.org/
> > https://openbeagle.org/beagley-ai/beagley-ai
> >
> > Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
>
> <form letter>
> This is a friendly reminder during the review process.
>
> It looks like you received a tag and forgot to add it.
>
> If you do not know the process, here is a short explanation: Please add
> Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
> or above your Signed-off-by tag. Tag is "received", when provided
> in a message replied to you on the mailing list. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for tags received on the version
> they apply.

Yeah, Rob's ack was for v1.. then TI got involved and renamed the part
family, so i emailed on v2 of the change j722s -> am67a, it was 95% of
the patch, didn't know to add it back..

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

