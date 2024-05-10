Return-Path: <linux-kernel+bounces-175522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765F58C20C6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A641F1C2209E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA815FA9E;
	Fri, 10 May 2024 09:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="A3u2ykTA"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3B8BE8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332894; cv=none; b=fvWfcEcF94Yg65Ahc8DQxnuZ9OiKpnpVPGHvQB7zH2JuvTpfpExWXiQUiTo8r63QWsmiXVobsjzppjuXDdPZpyrrqUltgcQyNi6BI+gZXOfm5JmLt0PsHvanHsOHlY/iBvLgRkosY12y0Ob5hd6g0l1B7YEuyM3aAgjEmSfFIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332894; c=relaxed/simple;
	bh=kc4GbU1nJuP5rf8sWY3kjEhTD6HDa5dyZKuLq3c/7BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoYBdecghEPTvOJx8aMfdxq4B/nx+apKb2/kVcix9xaSJXWQuz08O66m1LYWlLxUWCGjDbtVPAsadkPamHOtS2/xkk56UtmqAaPWfkH51kQo/qxkZ2cdlc0J/8Nys/HCQ5fBlQr7yHrKu+BdvT06BpKItuXlyboxwaTn/TlX2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=A3u2ykTA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so207949666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 02:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1715332891; x=1715937691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kc4GbU1nJuP5rf8sWY3kjEhTD6HDa5dyZKuLq3c/7BE=;
        b=A3u2ykTAyXAyeRKw9MkBuXrG1DJBwEmkSQbKLpEAxx4v2grUnD+TIBjoawonlokfKt
         7IPM/f/RbJ4vWA9QfMNa5kewBHgQCS75NObixZ9FMH8UjTF3EyPn6UnGiAVhdaQ1555r
         7wgwvof883UPBnOjly7BQLUaaKEWu8//twh+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715332891; x=1715937691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kc4GbU1nJuP5rf8sWY3kjEhTD6HDa5dyZKuLq3c/7BE=;
        b=CVkgH9lYXUMP1+Ldp+c8866LcsY1mu0AeV0Izt88Ah7GcusgR5t2uLiezZR4fiELYr
         6ajFUy3hU2CxArasZc0poa4GOO4VKQ0iqU+luPY9PmxbZe1cnDnK4Hg1hT5JYks1xAy3
         7QoAKFczBEqUM5J2izAnx/Hg+Npodd02F0pxV3UBGw/2yxlfqG53rXMogHU5gnJH0gBn
         8hOU56mtM9tJRBtzRc47DRI43Tnfslk2fRb+aCCZ526xG07pJ5YS5AoeJqpq1x51jspj
         KpyJ7yq65n5/JFlnaQ0S5miUEfmDUrIubBX3lcKxlXEjNZt5yWphcwDRjAfUeHZ5aWIo
         UZmw==
X-Forwarded-Encrypted: i=1; AJvYcCWqBa5Op5pDAoTknJk60u5HsnxDaSbywyhVI7BGpXkpqvs2rmxOD0LG3vxulOMZFHsUN6H2CHCACbrxt9PYcedPIAHpcf7uxW3IlYPt
X-Gm-Message-State: AOJu0YzOFR9Jf+z0SJjZoyyB0RoCM8c0M8B6bDfU8aaLnyz6e8SYGV0d
	+h4WFMOEWS0Z5svrT8FHEmAPGXfXzJtvXl4b0TSKQcto2NT5TYmo0AJ9BT7rfeDELpFPXbwFBur
	JtGwIKBqbieatg4kg11vQxlbUCDI/tfDY9Jn9hw==
X-Google-Smtp-Source: AGHT+IHoNg2wt+6Y3ymJG8oVFpFmmomjuz4lHKnzzbQ6LgbHb/LqMAAY75w6GRVowCoL8xUng0HBItGtzaV8OwenIdU=
X-Received: by 2002:a17:907:1707:b0:a59:c577:c5cb with SMTP id
 a640c23a62f3a-a5a2d55a749mr146034566b.10.1715332890702; Fri, 10 May 2024
 02:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509125716.1268016-1-leitao@debian.org>
In-Reply-To: <20240509125716.1268016-1-leitao@debian.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 10 May 2024 11:21:19 +0200
Message-ID: <CAJfpeguh9upC5uqcb3uetoMm1W7difC86+-BxZZPjkXa-bNqLg@mail.gmail.com>
Subject: Re: [PATCH] fuse: annotate potential data-race in num_background
To: Breno Leitao <leitao@debian.org>
Cc: paulmck@kernel.org, 
	"open list:FUSE: FILESYSTEM IN USERSPACE" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 14:57, Breno Leitao <leitao@debian.org> wrote:

> Annotated the reader with READ_ONCE() and the writer with WRITE_ONCE()
> to avoid such complaint from KCSAN.

I'm not sure the write side part is really needed, since the lock is
properly protecting against concurrent readers/writers within the
locked region.

Does KCSAN still complain if you just add the READ_ONCE() to fuse_readahead()?

Thanks,
Miklos

