Return-Path: <linux-kernel+bounces-214656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277409087C4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA3B1C21A46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C5193095;
	Fri, 14 Jun 2024 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEYuxDYT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D512D192B79
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358194; cv=none; b=T2/mfJn28BwTRpD2B2F9JJW/0Kq96+f9B1/VtR+dEZD7vVgi7S9AfeGJqNaf1AF7T52BneT9yBHFwEyznw4ngIORYAC44e7EZmi5LlH295uLM2/AAbP0UTabgHt4ms0+x7cBhF6kmTvsWBh1BRg3XaxcjDXmbQmb2wpJnM0Zumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358194; c=relaxed/simple;
	bh=tLQgAiSqIKd8Fr/cSViZ1UALzCWG3iDxmInXrEl5pr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ilJoUtqtwkL+a/BHFPK+Z9SueWjzMDwpP7fO/5WuCuK6pNt9Q/b8rGLKOwFAxK445nUjGFtiDwuE7aKavUUHxg5KBACH/5wATMyhG30stUEcSNhMaFiI4JWkuxUHtrwxE0fCK5BbZqPsbBXbTigT251NVJSxuYiZFGbVCPhGQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mEYuxDYT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c6cb1a76fso8756a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718358191; x=1718962991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLQgAiSqIKd8Fr/cSViZ1UALzCWG3iDxmInXrEl5pr8=;
        b=mEYuxDYTGkcb+LpOwFZdoMmdKeAT0qXZBHdA7gW3HmyuQw1EW4yhXGppW+jtels5AK
         sUCMTpKZmYgc70c09qQmkMPbr9HtHfwxiMsSKHM2ha1Y6YnVC4lSadtgAL6U9e/k83Bh
         /nqRbDgxBns1FemuLtBm0ZeokLXTl4Rt8aBqjlNY0I+tOveot12vMaJySH0yPVYzJu1P
         EWI5nLqADRfWwNOXgAM8aLI23ymDpwzsoFj4EGhONJ9991YSPd4VR0WgUljDC/u1zCGF
         g8T6mtNo1PTP9b+ldD7DtE4CAjOV6vxqoQ6NSSgHkkxrXVrEgP6RShxSseXbXCoWC3CM
         n3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718358191; x=1718962991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLQgAiSqIKd8Fr/cSViZ1UALzCWG3iDxmInXrEl5pr8=;
        b=O6v0I2vhVODd8mV819R0guRuvf78uYCnhl8/DC20gCYhaUuSKcTsxRQYXgGDonYw+v
         qkxTZK4yTT5UpVcydarA06VIsT8Ry5TK45t9pAN6b9dtcyc8Tomaq5K0oXkF6pj3JhfJ
         Yd4hisLRTst6PirbBpC8aLzxAvFIqLP2f+iPPcujzu4aQgfUgbgEuXN9Gtar5Rr9fh9+
         Q39oXrvrV7zRJQ+6JZct706DJrKs9pmuoTd1UbBM/Iupidww2FlgK1rSBDoRcIjrVkB/
         GdR4wdDqj1JfbUnsr3cBKLwhxsCLJ/a22XYQ0p2J0IwKJ8Yq5QcrvFK+LiMxWQOQNO9V
         jbkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1jVoppH5bfG4SoOwbQd+W2s/bgwE7rZoNaEQ4ReS3vwA4IOzwJ9tTlW/Tq5vS0zw9GAz+NhnsO+WMgKYQU6+/Syy3g6mmCdptJzuv
X-Gm-Message-State: AOJu0YzAK1K6F2Erv2p2E9cfiaaQL+VSD+Zmxr8xkFAqYSgYrO/OfM4C
	pK2oFxzZERGdqHDRpoaI+7dQxnikzUNriYVJIx1MCIWCenTkOPR1fKbP/X+L6Ro9nK13tApxshN
	szJSqTGiZF8HS/iJSEuQBIFeOlUTTAQSV29Jfc8VMtQ+X3XYQxA==
X-Google-Smtp-Source: AGHT+IFvDUJj2XIdgBgpDYCy46upILTWlHhD1AvsiHaBR7J8BVYYLQKdVBGYSCjJmIzXS9M7jGMzR7holN3E0CkL1bE=
X-Received: by 2002:a05:6402:4301:b0:57c:ae72:ff00 with SMTP id
 4fb4d7f45d1cf-57cc0a85d52mr107336a12.5.1718358190869; Fri, 14 Jun 2024
 02:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614092134.563082-1-thuth@redhat.com>
In-Reply-To: <20240614092134.563082-1-thuth@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Jun 2024 11:42:59 +0200
Message-ID: <CANn89iJafAvVot3_AgGGj8pwc6FTRMkZ2X3ZqsOV5J_XDSWPQg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Remove the "rhash_entries=" from kernel-parameters.txt
To: Thomas Huth <thuth@redhat.com>
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 11:21=E2=80=AFAM Thomas Huth <thuth@redhat.com> wro=
te:
>
> "rhash_entries" belonged to the routing cache that has been removed in
> commit 89aef8921bfb ("ipv4: Delete routing cache.").
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

