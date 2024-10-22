Return-Path: <linux-kernel+bounces-376609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E19AB3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332A61F2153D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D11B07AE;
	Tue, 22 Oct 2024 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMLaYi3i"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7B31A38E4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614102; cv=none; b=RD6Faz+ab1pYGOhb/ykzh/P70WqJWO73MCLngjfP+rkKEOrE6YFv8zXZ026XaWmKBKpOX7BisAMX9H77Oou+Q4Z1C0s+K1moCMAlychEptVGMMOfQoXCGTow9HpkHUq20iUcQTepzykR0/OAURHNJ5Vn0+42Uo8Jkhc6mbUzeJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614102; c=relaxed/simple;
	bh=259y/NALTpfzycNQF0RX20neEB0RTLzUden805nlCPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3x86hc1UgoyAfe7J2KQSorVQPYvnHWjd3MP5foOjFAoQA8fWxbsjAoA4ZRecmcp8mUZNr0znC0gokgbCcN/7hK2+GzFt07/s1Tru6rONJiLy5EQrm8Jwa1lBGzMjrcT5qqOLR/desyE3QuPLPAOO7Bhlul2XLfVzhUhXSZcs3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMLaYi3i; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e305c2987bso55597877b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614100; x=1730218900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AB6AS7bJ5wBbcya1+n7l9nd8Ua0pFUCnTuSAh4P1Yk=;
        b=VMLaYi3iJGV0Gt1dpwGVVk4YGW4AtAKyZ1lrESQpn/Hg8HS/Il20P3s8BoYLcbwI3H
         E933KqNqLSnp0o6QwxCbyU9ZL6dIBINsn6ysFRxbUq2gYu70J8/joXO9RS5NrpeNH/bj
         P+kOjJ49617zfUjSICuOq4xR5ISqs99XG5F/a8dh9Uk5l8CAGPVaEIx7jaQ2fK9n8UU2
         wzq5vd51fHZ/fVw6ElfqrwOyPkngUO8ljlgd9uM5AjZU6BCT+OByxd+KulcAKEmiTAKk
         QBUsfcPSo+P9xT8GwcKOAGMWzKM6/8tN+Br4+rk9lYvIDROjP/92nQ0AzCqHtKA/XYnu
         RdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614100; x=1730218900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AB6AS7bJ5wBbcya1+n7l9nd8Ua0pFUCnTuSAh4P1Yk=;
        b=dzOOmedJMPtXYFTlIYE5l9wCKVYkqAi0CkxHv0lR49oyHxkTb38QZ9PfljL69K5P/l
         WhZDl0nCfzPi4cM/takqWnaUy15ahgFY1SxKbQhheBMS3WqVTQeuGMbjfxVLDsn0MP8S
         IBf6EfluC2M9GaMw93kKNouU/0wn313JUwvrrJfErHA6ewNR7K7FQQjEEwQqcy7yC/q1
         MoU1NPR3v9hSzMfBsE9n4goMZ7ypfOns95jW0svtPsEirCQIjqHBnkZ4MrxBKnsTHgys
         AXa5/FvW84vcuOSSLExvz7OGko8YmAV0grTx0fxXpCEybtFyiFdgMs5cC0dA/WdDGPGe
         9lig==
X-Forwarded-Encrypted: i=1; AJvYcCXEY8fOgMLRgEG319PADs+yI+DbIecNrARgvEF/BkofKgTpCsaZdoLL/q2vTwnC3gSCF1ZU2LgPn29c+1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3s2ylKS47MFl3lF5sKtV/KBZUgjCxBn4LV/OGVZZfacWNuscR
	3CRy8UzSxrTQJdF6QEtWwLDpBV46a5Pzh0dW+zrNUSvKlJhg18CSzyM3Bqgj2oSSxgPnfGVS4Lf
	xZZMWQPSBkahiUV1Xo06RwOmQ+D4=
X-Google-Smtp-Source: AGHT+IE+TRHtfB4nMJrRi9Yp3xiRB091X4SarymBV8L4OkkaBBLISizccqEWXgEdDSpDwu8/sSxQcDkT1iKSKP2SLdk=
X-Received: by 2002:a05:690c:6f87:b0:6dd:beee:9218 with SMTP id
 00721157ae682-6e7d3b848a3mr42202967b3.30.1729614100326; Tue, 22 Oct 2024
 09:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017162054.2701638-1-olvaffe@gmail.com> <20241022123052.3e0f3f17@collabora.com>
In-Reply-To: <20241022123052.3e0f3f17@collabora.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Tue, 22 Oct 2024 09:21:29 -0700
Message-ID: <CAPaKu7SbrtMpD=TvrB_y1DfhN1rNafLwAkdhX6+gzCW0ukg=0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/syncobj: ensure progress for syncobj queries
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	faith.ekstrand@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 3:30=E2=80=AFAM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Thu, 17 Oct 2024 09:20:53 -0700
> Chia-I Wu <olvaffe@gmail.com> wrote:
>
> > Userspace might poll a syncobj with the query ioctl.  Call
> > dma_fence_enable_sw_signaling to ensure dma_fence_is_signaled returns
> > true in finite time.
> >
> > ---
> >
> > panvk hits this issue when timeline semaphore is enabled.  It uses the
> > transfer ioctl to propagate fences.  dma_fence_unwrap_merge converts th=
e
> > dma_fence_chain to a dma_fence_array.  dma_fence_array_signaled never
> > return true unless signaling is enabled.
>
> Looks like a bugfix to me. Should we add Fixes+Cc-stable tags so it
> gets backported to stable branches.
Thanks.  v2 sent with the Fixes tag.  I did not add Cc-stable because
I was told it was the maintainers' decision last time.

