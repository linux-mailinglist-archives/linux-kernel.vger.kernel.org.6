Return-Path: <linux-kernel+bounces-275509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3879486A2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 02:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB641C21BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 00:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44ABC2566;
	Tue,  6 Aug 2024 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ToQwUMoF"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEF64A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722904501; cv=none; b=C+jyHmPB3oCX5U4r5FW3y+xX4kSnLMqzzco02NCvpQVv2qVnGrgHP6DAAK/hUPIAVVflV1W9G77ejs7oLYfrVqjzvbgRkGvw98+6dvqQdYnfji7Yla+FRL8OYJfUszvljGQ9Qsf22GvKo1kLyFaaPlVVSxqKtLkTuH51goqLrWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722904501; c=relaxed/simple;
	bh=Os1pWRnghW77CcMhqb/vY3gTxewE7tQNvKDtva3Qkr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sd0rOfuLlXnVclV1N0eMfokfXEXsVovgop7PknKop62nDSDaykagzGby2kJXumzmMS8Ihl2Z4HlNRY0MOkVCedbnc5PFcnyLIHWErYNLKe4KeHOG8YNWCtmCuUipZ+7Dk3KUePQy2FCoJDVtcZQo9IljfL5fUR2JdLENrFJly2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ToQwUMoF; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5e1c86b83so123474eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722904499; x=1723509299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os1pWRnghW77CcMhqb/vY3gTxewE7tQNvKDtva3Qkr4=;
        b=ToQwUMoFo0ryrpZURztQW17hAy5OBYz9rkwXu8AX3z6MTrnzaSv7uwrQFJwxAGdwS6
         PrSYcm0AgnbE1o0tlKHz0ZJXfsE48phZTMEbArutqae7G49kGLqBNeNPKHG1rsHes+BZ
         gTVComRptkz/9+ufSshRtwmCmhJ17kNYCkuu5E+/cEMSwnGU+vV8/pHvdK+oLosj/AWY
         BHtD5uoT4O2h5yUojOY67puv6O3bUrpwKClNHoGPtfrh3fSPmLACdDj9Zj4hwkQD0IzC
         IOLMXPW/IHrlvNio+G9S2UPiuWhpUU8srGkkNtSWrGASQzM0QV9/UpvfPPv3+tqgZFDV
         WT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722904499; x=1723509299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Os1pWRnghW77CcMhqb/vY3gTxewE7tQNvKDtva3Qkr4=;
        b=xKxY1ofYM4q/qOvNY+/UBAXt1u3HlVVvxlIer6LBBffw3UuLHtb/5bZNFXLMbhQeE5
         4fs1M3v3LSyt5h3aMzPPplJ97OJsXv0DYrGES4vj2H4BGNiNaMu1ZTMbazVoE5NJQFY7
         jeT3/dIvbwo6WQ3jgsW1efelSYOgJiXTiB5RzSMlS7E/eM+8ry5Ubhz0n8ccOr/8/nVO
         tgUpEe3Q/SUyaUDfg0CzTzIdmVA97XO9OD5ASliGsMgdihokN9XF8nquGWk82/RsadQa
         ymQNOUb5kyZr2jl5g8KAVKtkzlbouFjNCSt+RhXwQJHIB8XNAY2hU+EJnZZCQQbCwrHJ
         Tkog==
X-Forwarded-Encrypted: i=1; AJvYcCUr3gJqZ9QNxfdby8fp0XxCci6BB11oHemqsj9+O5uc97gCtT+2PdcyLdA+a/HpY9kkd0zbBLuxBo7DxDDrAFcGhTqjlMUDLtYY5+VX
X-Gm-Message-State: AOJu0Yw5IzUpjiQn2mmgXzllo07W8gmRQjCGNO5tCWrV/5VdUZ9wZV9l
	3RHOmo2FD7olfLMmFL2EGZuLij7MenEfM4R+X5U44eoHJK1RCkqZ683oGQpzIlUCTV+GhriGyfr
	JYDUaphoYnH14ZnnBWI+rEZC8mi4=
X-Google-Smtp-Source: AGHT+IHnPtZRLSAqkjpB1vyWpMQHFpm1d1/WsdYfYWVLmvW/TVJp2gPcpSZM8wKb5QCjTJzO6EYXHcPxTN6BgbBEYjE=
X-Received: by 2002:a05:6358:310a:b0:1ad:1c1e:9799 with SMTP id
 e5c5f4694b2df-1af3ba8983amr1548382355d.17.1722904499131; Mon, 05 Aug 2024
 17:34:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805232243.2896283-1-nphamcs@gmail.com> <20240805232243.2896283-2-nphamcs@gmail.com>
 <CAJD7tkbnYi5WsQC+5QfrVgmqb34yzY9HtVZ4cZjw9eg+ikCXkQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbnYi5WsQC+5QfrVgmqb34yzY9HtVZ4cZjw9eg+ikCXkQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 5 Aug 2024 17:34:46 -0700
Message-ID: <CAKEwX=NVo5sBuz17HUZirsk01HDN2JQm+9Av85UWms1drvmt8Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:13=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>

> Nit: It is unset and reclaimed by the writeback logic in general,
> which isn't necessarily triggered from the dynamic shrinker, right?

Yeah you're right. Just sent a fixlet correcting this :)

