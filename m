Return-Path: <linux-kernel+bounces-185112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A008CB0A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394401F23083
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64C142E7C;
	Tue, 21 May 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljIu/XqC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C29D142E72
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302697; cv=none; b=gJwF2LONYYje6BXjIgbmoMnQpE2ldIC+NauVecUPXikFwoi0IDHVgDaVtX8/29ERo4q/91VR7/uRvbzYW1Q0uI8+gFFuGfMKLxZqrOcCoPK5eqY08M1ac+dBfxZqIS3WD++hMNe9xYOihOQY1TVbuZHHIdfr0UGcctyJmsq5Zrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302697; c=relaxed/simple;
	bh=FatzCaS853KlYpYCWfaJEegcpJasCmhPSuNmSeKGISY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJqX5WPlrG8p9W4D0VIw/LV/ko5LY7eu6HUXPobujTsL5aEWe0fhQPCVbRfJn6TLFtw0H65k93GN0BtvwnqyWyTOu5CA8f4aOnB4tQDgzc+kpmaZ+GLOd8NhCVDWGiTDc/Pejcj1U3CNva4nqEl/ANJsLzqNcJXC7m3Zji6Nbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljIu/XqC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200ee78f35so23885045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302694; x=1716907494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyDi5SGXAlR6Eka5SnGRBj6FnVdCq3lRHBbU5fvuqSE=;
        b=ljIu/XqC55wKixjXui7oE4gMwjKpVSPCzJ1FNo2VkZFqoQXzE3VMgrTCtNRlqfipuS
         DN+A9MXar6PiSQOKe7z083xdwThvMM1UveZakNxZlx2c+rP9I5w05h84iE4v+NSeaFtt
         bTPgqIrTOL0GfFwrX7m/RWqFYZWSLYgcRxiB8oR5tJD1nK0qTQfG7YxK10/+vufewcxR
         uvDbHQTZS34bAqaOObW9yMyVlqoG2mJNFRNqcEtgz3fjbZMwX/qoRN7mWyuo1h6UaIpo
         KhA2MzjYw7ElqLSi4M6XqTgdNjLX3V+xvVxZiH73fqtugngivJNgryup8WvPSV4jdXtg
         jZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302694; x=1716907494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyDi5SGXAlR6Eka5SnGRBj6FnVdCq3lRHBbU5fvuqSE=;
        b=nsMUh7U1kYJakcgKxUf9Wki24hhR3c/MPYvYrXBn3/wiD6itqfQdBt431wGU0FR2ar
         PZqPsusYNSJ2UYQu026pFXenEFtRdbszeHGOShPTS3uShpM4Ot7NXhWAoK2rt5HGXGm2
         cZmHj7iq+zuk6UdyOVFp9i3mQlYaeUTl59ug6J2xpkh7peCozp58TtJJIOWkIW9TH89+
         w+7JQA0YNSpBAOY3lCV7Yvfl1ujjqtPU31c8FAkkFEjrbPlcwtLGsYPP2kv8yDjB55tt
         R/gkR2CzLasyiVP4CKAZ0fs0aZREBlLYFgiukOpJG4j4Wzd2c0qJPxnbGiyRN6jOcSOE
         8owQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSoSy3tpTNiYlRYhbPTiJcyTy7K/enPY7QEVIuBXi/NEl0WX30yrSgqbRo0m4I4/xJRbsIMf1BYzRXcsCnUWDThDa+W+SLh6lOtIda
X-Gm-Message-State: AOJu0YxrJHMnWYF0bJkYdrVZ6Zu9Z85ePpyAP93xkH8nTxvX1GZHikuD
	z6Jcg52RqtBiX4WsGILjdvOTt8l/JsZ0yr8DcMe4roLOF7mU56W1X+3jPdQmE/Tk1orRP15S9g1
	5V8yMF+AHz+2tf6odeWIEdmhBx4E=
X-Google-Smtp-Source: AGHT+IEXRJD/ZVc9gWrunTwefX+xmMFSFeehnNS6hwPLTLedsMwHlnZ205lJJTuFVNYrrslMuFKWGJ4NOLs9UrGHvcs=
X-Received: by 2002:a05:600c:2295:b0:420:ec6d:26c8 with SMTP id
 5b1f17b1804b1-420ec6d2925mr71909995e9.12.1716302693527; Tue, 21 May 2024
 07:44:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-6-jim.cromie@gmail.com>
 <CALwA+NahLwNXapUogMGvBX1LavVKMoipLwN7v1DdjtJzayEkNQ@mail.gmail.com>
In-Reply-To: <CALwA+NahLwNXapUogMGvBX1LavVKMoipLwN7v1DdjtJzayEkNQ@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 21 May 2024 08:44:25 -0600
Message-ID: <CAJfuBxxZATOwNW3TM35YixTaTQQ5BGvcQHu3nemPWvAX8XYbLw@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 05/33] dyndbg: replace classmap list with a vector
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:45=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com>=
 wrote:
> >
> > Classmaps are stored in an elf section/array, but are individually
> > list-linked onto dyndbg's per-module ddebug_table for operation.
> >
> > This is unnecessary; even when ddebug_attach_classmap() is handling
> > the builtin section (with classmaps for multiple builtin modules), its
> > contents are ordered, so a module's possibly multiple classmaps will
> > be consecutive in the section, and could be treated as a vector/block,
> > since both start-addy and subrange length are in the ddebug_info arg.
>
> Should it be start-addr instead of start-addy ?
>

yes, we dont need spurious new terms.  will fix.

> >
> > IOW, this treats classmaps similarly to _ddebugs, which are already
> > kept as vector-refs (address+len).

