Return-Path: <linux-kernel+bounces-325526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F587975ACE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D261F24AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCD1BA868;
	Wed, 11 Sep 2024 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hX8CLF9P"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B851B1D53
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726082497; cv=none; b=aYYdIy+AHX242qb2B1Q+TvOnxBP6Nv5gTIzZPNDJzGEJkkJiJe7zdubNXgxb6KwpNR96Yz72gHrtTVA/epior7UXMATlFBv4/0cl3MDEZswRcyDQfimrG6ehjxvsWX/VPajAppcEyCU6EPrUYOJXPrenC8fczqQXa+dkCmhtVUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726082497; c=relaxed/simple;
	bh=GZkVq4TBqrn3vMbqIqMSCkfD9fGneTIINko7V6KeZs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uOqikS0DIcsaw5ut9DDWNLISR8OfzISEy1zA58/jfTpXdsg5Ljb/Tv/Uq2sTJ+gFFo1sKABzsVQqpngZi2+VCcRa7YC619rQ6dSpnKxHJOjiamt707rSIc+iTjA5orpHFS8yxQS12n+wPPp7Bi+roL5fWGd5BvlacJob8qVCnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hX8CLF9P; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so32804866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1726082493; x=1726687293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZkVq4TBqrn3vMbqIqMSCkfD9fGneTIINko7V6KeZs0=;
        b=hX8CLF9PrIsTVT7/EY9yUfSQJ8j/gpmsJ6uUTD0VNlMaDcS5ejr7qx5cQG/8owITO8
         j1nEJgpvZZROQJf1elhbRjeD76njgiDtxBVHb57XoRrPh2oHvc+c727iGoL4L+ll8k/c
         S7lC59ImBIMdSsbI6YJIXj/DOMHVj/5cr5c2ihraEeq9iuhx4/RtPGcfFKTdVpzU0NA9
         lrFiA9qDBrKeoXepoxJBneOEbMFVQ6hXiFPhwgxME7Fs5cG+XbfYNfN1W0OZXbocvxfi
         RIuNwQTgcFvlG/nWs3MwoMckoATUT+9XWPng8TvUT5RJU7W1JQzKbRD9WZW7T7mIDRCe
         Sz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726082493; x=1726687293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZkVq4TBqrn3vMbqIqMSCkfD9fGneTIINko7V6KeZs0=;
        b=IAdcQyldzK4ZMlz9vBUAKOCAKeWWeyfjhSXkAL7V1ht8+93zQ1QjqX39VoBXxjUIph
         9n8ayMImUl60JQwRWwJ5y747qVtHFSuhFiWOcWSJQRGdTxagYKqfbGrwvdWYtU0waVhs
         XUfi2Dge/J8whmCMYeZm69DGp/9uT2szMVhkGpiBdMKq5HBzi7g3VvdrxlUBxJTbhEL8
         j/LsMaGzS2MJb/NYDjz6aNpxz8R5ySoI8WyVwdGhQb1dYoLOpEQ+F2zLglh6rJwiPbUM
         /UKt7WS8Etulrsi4xZW5WrZKkN4G9LSFi0s5f/96meW7DbnrMSfwtoepmqbU9Buw5zjs
         hp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaw7H1v/ZoLd5tIH8u4JxSCOh+RyS7VyHkJZcxlo6CZVEXHJdYviYHYgtC7AuK4TJys86LdiawdrWqeD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6tkysJ0E03uJsWMXquP/QVAqMMHQpiK4aewbt7uwVS3AvLIr/
	PDfhgMisCYu8GsNYSca78Z9VE/NUrDWY399SX/ZSTAARp4n5BMhWydOLl7dSRRZDaqjPyptTp39
	JnKKF+QzjZuBEFcBgTGlnaTXIkMFhlfQn5uqk8w==
X-Google-Smtp-Source: AGHT+IGzFkoxRAHMAoSH1PCF8jW9WMpjUkdd3qdBFLUhwQLg2F5i8kGcbwBoRGpJWxVgkhg44hDv6+r/xdUPJPB2OjE=
X-Received: by 2002:a17:907:f760:b0:a8d:5472:b56c with SMTP id
 a640c23a62f3a-a90294644d7mr48584766b.22.1726082492905; Wed, 11 Sep 2024
 12:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4b6aec51-dc23-4e49-86c5-0496823dfa3c@redhat.com>
 <20240911142452.4110190-1-max.kellermann@ionos.com> <CA+2bHPb+_=1NQQ2RaTzNy155c6+ng+sjbE6-di2-4mqgOK7ysg@mail.gmail.com>
 <CAKPOu+-Q7c7=EgY3r=vbo5BUYYTuXJzfwwe+XRVAxmjRzMprUQ@mail.gmail.com> <CA+2bHPYYCj1rWyXqdPEVfbKhvueG9+BNXG-6-uQtzpPSD90jiQ@mail.gmail.com>
In-Reply-To: <CA+2bHPYYCj1rWyXqdPEVfbKhvueG9+BNXG-6-uQtzpPSD90jiQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 11 Sep 2024 21:21:22 +0200
Message-ID: <CAKPOu+9KauLTWWkF+JcY4RXft+pyhCGnC0giyd82K35oJ2FraA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/ceph/quota: ignore quota with CAP_SYS_RESOURCE
To: Patrick Donnelly <pdonnell@redhat.com>
Cc: xiubli@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 8:04=E2=80=AFPM Patrick Donnelly <pdonnell@redhat.c=
om> wrote:
> CephFS has many components that are cooperatively maintained by the
> MDS **and** the clients; i.e. the clients are trusted to follow the
> protocols and restrictions in the file system. For example,
> capabilities grant a client read/write permissions on an inode but a
> client could easily just open any file and write to it at will. There
> is no barrier preventing that misbehavior.

To me, that sounds like you confirm my assumption on how Ceph works -
both file permissions and quotas. As a superuser (CAP_DAC_OVERRIDE), I
can write arbitrary files, and just as well CAP_SYS_RESOURCE should
allow me to exceed quotas - that's how both capabilities are
documented.

> Having root on a client does not extend to arbitrary superuser
> permissions on the distributed file system. Down that path lies chaos
> and inconsistency.

Fine for me - I'll keep my patch in our kernel fork (because we need
the feature), together with the other Ceph patches that were rejected.

Max

