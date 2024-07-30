Return-Path: <linux-kernel+bounces-266687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E0940547
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C865A1F2663C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5C5433C1;
	Tue, 30 Jul 2024 02:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIqsDO6I"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16A2A1DF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722306482; cv=none; b=DKLCvxlBYXtQaS6iKY4FsPLgYwbDLM/xSmVDyq/vnOt8aURF2hABUS0SPfKryXRyWW9SUlsePjX5l6ycJLP2p0n/aCi1aDaYPpROjJlbNNyiHnz7z9zxP07+IijFXYi6iX7xJpGdre1IUHHopFltMoRQ08Xl1SEt7yPhKbek56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722306482; c=relaxed/simple;
	bh=sqApR/ZIhpAevz313qwT2ZgE87xnHWMAQXPACdvG0qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQ9+i0dEJKxxtzt/KW2PDqEdh14DDvuXyJxcRhz8sew2+Axuzsq2Oog889aQpVLUsCf7bobqcH1raziKnhxCm5+qmAF/osbFun2H6bON3J+ec/C6SlF0Bu0e2/eMwQY1Q0lMb8PY3QTLqLBnK8yp2p/FdUs2Ndi9Re1OA7kD1RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIqsDO6I; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52f01afa11cso6173127e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 19:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722306479; x=1722911279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkoibKK9tbWkHu5YdOgJKQ1PYjdZREX4hpOxdsN90d8=;
        b=FIqsDO6Iembs+dhvUWssR+2ck7iJKU8IwMKiiPkuidV+F4w2JLWuPdk4cPyMg9y/pb
         wcTNfvwyFWkCkMAjJsn0r3Q6+XrWUAnuXLGYAXvlWHN7E++xQV1AkLrciqkmuMfiXZA0
         g6mOs+MLhn7V/wXz4gRcibHRzdYn1nkxZfGePA7n15VMOuFTPIpljDaCrXVyXCutevOD
         mmw8o66Ay3at7ywe79rhJl6F/rO7Oiz7TEW/Jkl0P2ESGpmcDiByqdfQgn7xqQ53KOWO
         VzkOuryzErJXkzcRQd04cjCgrwgxhiB4ZnAm+xuDObpEjmiS59ka6gdNpJgPyGCEBmbT
         F5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722306479; x=1722911279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkoibKK9tbWkHu5YdOgJKQ1PYjdZREX4hpOxdsN90d8=;
        b=QaIrboHdQFNYAx2fBRV8+gtZK+YBhrPs22//WttMFo1sw3+lGc7AMzPOSGHf3ZnKaR
         f7O8YJ9wblrbYrPCLp3PPZWY2tP6azaj0F594zQo/IKJUjq5WXh6RWcmNgZRXcUiS/7M
         CGwwdHii9/U9fK1cS+RwIqoxVXWW99UDZEPkd2+qFtReUmHxV4LPUPvPow7ZAri2oSaA
         /BijEBgX8MtZJ7mOrg7qFEH8C17bORGyTIJIQOWKXocUUvprR+kWngr+0RBwmVUHFhPd
         cjp69wZY62yUBZTAn1he73eh+tI5Y+LCNZl0EACnNgZlHyApeSORZoDh8B/EDkz9Jo4s
         RUEg==
X-Forwarded-Encrypted: i=1; AJvYcCViZvllHy3gpjMxHdp3uREgStRjqcEgQQQoRtfwNu84J5y3tbpQC2Sfb2uXDI9inPIyMZ4zEdLSndXrWmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWutnfF2JP53H/3AqKwEMVsm5uh280dQM/wU92GHPC9xyHycj+
	5zIhPLaEJjrgCpP++rd4phRZTiYse0q54MJcc2wzIzmrv6/3Y7Ld1Qp6rUK5K+DJuJa7oiv7j1G
	77VOEJViF/UZkjYpN2eZWAmcG8cg=
X-Google-Smtp-Source: AGHT+IG1WiuNTv/RAnpYSeYcxvZ7bwBEAwmNBLo3tjB1w85T0B1IjKVoPkYUzQ/9EDwR7NyynQjrewFJLJk8aNFkhQk=
X-Received: by 2002:ac2:4f0f:0:b0:52c:cb8d:6381 with SMTP id
 2adb3069b0e04-5309b270661mr8278719e87.13.1722306478671; Mon, 29 Jul 2024
 19:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org> <Zqe_Nab-Df1CN7iW@infradead.org>
In-Reply-To: <Zqe_Nab-Df1CN7iW@infradead.org>
From: Chuanhua Han <chuanhuahan@gmail.com>
Date: Tue, 30 Jul 2024 10:27:46 +0800
Message-ID: <CANzGp4LmtbGHO8x1E0E5scgSPCET8d3y5UxGkOrnNry98885kw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ying.huang@intel.com, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C 00:11=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 29, 2024 at 04:52:30AM +0100, Matthew Wilcox wrote:
> > I strongly disagree.  Use the same sysctl as the other anonymous memory
> > allocations.
>
> I agree with Matthew here.
>
> We also really need to stop optimizing for this weird zram case and move
> people to zswap instead after fixing the various issues.  A special
> block device that isn't really a block device and needs various special
> hooks isn't the right abstraction for different zwap strategies.
I disagree, zram is most popular in embedded systems (like Android).
>
>


--=20
Thanks,
Chuanhua

