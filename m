Return-Path: <linux-kernel+bounces-342155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3217C988B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 22:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99AB1F22EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 20:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6515FCE5;
	Fri, 27 Sep 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A++SYSB4"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0A1474B5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727467464; cv=none; b=mWNTVLo2JEwYIgr+m2bQmsBR26EIEByw6Jo++CczT+s82i791zO8mo8h03ziPV2t0sy7OCoCWWvsOfKJNbOL0P30tXzMMUMzI5AJOqCOVLeKh4CvootezUiqR3ihLom+XQIusD3rFKOkN+Wtl/quvXPg3CwVaIUIobEYNEOGnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727467464; c=relaxed/simple;
	bh=HnKC6MSKgHglh/TGJWlYxFLXbwHJpZmQilWuveifddM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OhsNsTeqxH4zwmcJGsof58td67cZRo+NPDJ73AsykoLC2Q8wUVU9huF8aeyK77RZol6evnIoS5m4NrlWx7kzIPWvFs5xFyorJ7MRQdpEbnJkWV4ak7ww3bCx4K2BIOGjLc6ebUgXb+7xS1WqLlgMIL7A4ZJLcX+MznMB2ZEfSVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A++SYSB4; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-710daeb8b03so107196a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727467462; x=1728072262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnKC6MSKgHglh/TGJWlYxFLXbwHJpZmQilWuveifddM=;
        b=A++SYSB4OKOoTrTcCQAAQyTbZJbPWwDehczyQBlnPVd1Po/q3yDw6UUks4PEcsgnVv
         Q9pwhF1zdvS6Wo70UQQZftlCeWHxJvdUXwddmOuryu3bNo5Rv7583lUt3tYNspw96QwB
         efgf47ELoLSI3uihLLSeA37KQOzypH03yGCbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727467462; x=1728072262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnKC6MSKgHglh/TGJWlYxFLXbwHJpZmQilWuveifddM=;
        b=kBbvCdUUkvmzxx1cfDhZcUwniJpfdCnievbJ4wRRT0JI97oagjxk1F8KZ8DUZeiINY
         pgdT1N+hal8fxtF+4fOcdl7a3OibnJZtYeuSIv1GK6pt0L/2zaPxAo5CLEOJ1fQum7ZX
         E3F59v5sJ9oIK0jTCZHKPiq8yMC4RhKVPaQUhZfRZ8vWSdUrtv4/hScJAidyrs6By/Va
         JGwAldlldF9n1RZ82eo6D3eYFeofBlO2dheJymfDNAOiD2Y6zh/11oIZb8or2fXY6MOo
         ciEvQ7edZZZyhSAdkx7eYDscVbjalP72gCEsEJiV6oDmM+Tn55zX9kS+EcSCLuPQdxVs
         KXAA==
X-Forwarded-Encrypted: i=1; AJvYcCUb993TuvVcMBtvvecj3HJuGNEWaEyaEhkF/3lWQBh+nGaHJJz58ZCASU4L242SMfOY64xkUUFWTiZV76c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZv0W6LFvUvawiYq6WGo76wcOoOuf7fs+SPX4NZiweW40wKvJM
	0t1TsL88mUog6kE77BrepyVXmw3toPpX47ge521hAMv1A8mnLP0MuxVqZTEPi1Dr8axUdcCbkG9
	1HE1yMt8JFi4wft0BQXO/Xn8Hf3EdK20A5xuM
X-Google-Smtp-Source: AGHT+IHZij8h/Bs0zNvBV9/jGTKskpPZQUGEtjPMrU/0uvu017jdpSY+XqCoKWOHXIpzdPKmfa+LIn1fUkazfPsBer0=
X-Received: by 2002:a05:6870:7f0f:b0:27c:a414:c22d with SMTP id
 586e51a60fabf-28710bbb349mr1004525fac.11.1727467462492; Fri, 27 Sep 2024
 13:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927185211.729207-1-jeffxu@chromium.org> <20240927185211.729207-2-jeffxu@chromium.org>
 <20240927125853.60978e0697a317e7965a8d9c@linux-foundation.org>
In-Reply-To: <20240927125853.60978e0697a317e7965a8d9c@linux-foundation.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 27 Sep 2024 13:04:10 -0700
Message-ID: <CABi2SkUqT42Awtpty4vV=x9d-gHtHPveYg4KhBZPxVB4h5Z10g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mseal: update mseal.rst
To: Andrew Morton <akpm@linux-foundation.org>
Cc: keescook@chromium.org, corbet@lwn.net, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	sroettger@google.com, pedro.falcato@gmail.com, 
	linux-hardening@vger.kernel.org, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	deraadt@openbsd.org, usama.anjum@collabora.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, enh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:58=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Sep 2024 18:52:09 +0000 jeffxu@chromium.org wrote:
>
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update doc after in-loop change: mprotect/madvise can have
> > partially updated and munmap is atomic.
>
> Fixes:what?
>
> I think 4a2dd02b0916 ("mm/mprotect: replace can_modify_mm with
> can_modify_vma")?
Yes.
We can add that fix tag if it is prefered.

>
>

