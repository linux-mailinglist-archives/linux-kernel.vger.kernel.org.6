Return-Path: <linux-kernel+bounces-382715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECEE9B1297
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30A31C21C0D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653151D9669;
	Fri, 25 Oct 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfD0Ef31"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1A8217F30
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895495; cv=none; b=iQS3K9qLJPWM2lT2llIYX73ggXFHN7T8D2psjt9PALRQ5QSdrzzlURjpD/QdLsyPukUv1AgG4ROdNfxrtYyFjVKawErbw9VXrxXlLtSvPuCO8fG+kphESSsRD9srwCrgNkPHcbyzNa0EvmrRXom2PdnfjrXxAo8n8/+AfnlzUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895495; c=relaxed/simple;
	bh=peaXwBeqvzMzdpHMpSvYdZXIArGq+jxUk3/8YEbSynA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=moIe+86hvJe9F3Mci7mVi09+6fSVyipggEfEG6fmOIHdlfcDbFbSDpgv/iGsAhX8zDBu9lC0dKVY4y78N/oj0vpfSWuFr1JGMrAwfeq9JKU5bqwrRQGNyaPuCyKjyV0GoPClOlSk5rnZg1O0bv+A97sUk12Z5E47v2NhiUKHAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GfD0Ef31; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f7606199so3171340e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729895490; x=1730500290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugvXr99oNQyERXTPqzKhuTsXIZd9WkdB8xJoxbh67vA=;
        b=GfD0Ef3164OR7MqcTSYW/8Xo+MckY/bmvj/qM56fY6J6/hE9WeOgxBcC1lfzhyXF7p
         OTghAwJnfsFRgwuk6rw4ft1447QcL/oGDfQj2xfOFG5HLmn2LtXUIGmJb+G7WnngjT0W
         oDdkRZanZyjQQWhJGDTJ7yOMNuVcZOBZAqhvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729895490; x=1730500290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugvXr99oNQyERXTPqzKhuTsXIZd9WkdB8xJoxbh67vA=;
        b=v02dvWTcR5T/iSdTIE9Y75vNnGTT++rWk3iIKjexnqiEsp4OZbH2MKn3yUBPawINCf
         qfHxUrVNTJtGrOQJg2e31U36q2Nd5cbvwf5SQoCP/HPYFUQRei27gUQWa9rcMnc4e5Z3
         Gh+W9jYKF3Fge04FfMwAVRRUHDYFb3Kn+RF6uotPPzWJAZdlezZV6eV1YqnO98GwEVSn
         /RvPV+crGWlxxM/iaMpv8CWg9FPFOxqA12odL7vcye4WnBj5hiy208thQSByyGj269SW
         gq1CEEIJq2c6sqrcpt8/dznzAHPcWs67xMutstOGn9kKcrkvfQMXiRywWxpt8i6wJEaQ
         mUtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZUAyokDpGUG8knTL4n/bAxoU79K5hi6znzlvq4Lh5v95EzbpCoseNgWlnQSwF9XqzO0D6x6v2nOr8Yh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykimHBRLMntBWfNwUbgRJsdzV9/fB3BPkUtwg0w0mfhavVn6K7
	RV9FmfTwzMIGS+wCywlvWTwnUdDbBl0OqHQlkqLh16d5PyKDgjtA+7lVd3wWMWXZU3Fsklf4/Sa
	N/w==
X-Google-Smtp-Source: AGHT+IFuHECwTbSQzHFUBmHtO9AtaoeWT3iLl0IcLLs1s4drDPK5pBTtXZNLSmZPCE4BIFwBvDV5QQ==
X-Received: by 2002:a05:6512:308d:b0:539:f8cb:f5e3 with SMTP id 2adb3069b0e04-53b34a31bf7mr358377e87.48.1729895489833;
        Fri, 25 Oct 2024 15:31:29 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a6bbsm323003e87.18.2024.10.25.15.31.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 15:31:29 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb4ec17f5cso24356311fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 15:31:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhxQ7b+InlVu/CcJFhG3uClNeDsNtkrSUD5c47c1fh+JD3yXi2W6VNlQuiyMPTrY2b9zYuskEUEQ2kaJY=@vger.kernel.org
X-Received: by 2002:a2e:be20:0:b0:2fb:5a19:5b9b with SMTP id
 38308e7fff4ca-2fcbdf5dademr3775951fa.8.1729895487832; Fri, 25 Oct 2024
 15:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021211221.GA835676@lichtman.org>
In-Reply-To: <20241021211221.GA835676@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 25 Oct 2024 15:31:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-BYpZb60Ap1xHXdoDtf=2UhTD=MQc8Lw=WkRmY=+wWQ@mail.gmail.com>
Message-ID: <CAD=FV=X-BYpZb60Ap1xHXdoDtf=2UhTD=MQc8Lw=WkRmY=+wWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace the use of simple_strtol/ul functions with kstrto
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 21, 2024 at 2:12=E2=80=AFPM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> The simple_str* family of functions perform no error checking in
> scenarios where the input value overflows the intended output variable.
> This results in these function successfully returning even when the
> output does not match the input string.
>
> Or as it was mentioned [1], "...simple_strtol(), simple_strtoll(),
> simple_strtoul(), and simple_strtoull() functions explicitly ignore
> overflows, which may lead to unexpected results in callers."
> Hence, the use of those functions is discouraged.
>
> This patch series replaces uses of the simple_strto* series of function
> with the safer  kstrto* alternatives.
>
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple=
-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Yuran Pereira (2):
>   kdb: Replace the use of simple_strto with safer kstrto in kdb_main
>   trace: kdb: Replace simple_strtoul with kstrtoul in kdb_ftdump
>
> v2: Nir Lichtman (2): Removed confusing support for hex number inputs wit=
h no preceding "0x", and other CR fixes
>
>  kernel/debug/kdb/kdb_main.c | 69 +++++++++--------------------------
>  kernel/trace/trace_kdb.c    | 15 +++-----                             2 =
files changed, 23 insertions(+), 61 deletions(-)

FWIW, something about the way you're sending your patches is broken.
Both patch #1 and patch #2 are supposed to be "In-Reply-To" the cover
letter. You should use a tool like "b4" or "patman" to help you post
patches.

With what you have if I try to apply your series by pointing at the
cover letter:

--

$ b4 am 20241021211221.GA835676@lichtman.org
Analyzing 1 messages in the thread
No patches found.

--

...and if I try with patch #1:

--

$ b4 am 20241021211451.GB835676@lichtman.org
Grabbing thread from
lore.kernel.org/all/20241021211451.GB835676@lichtman.org/t.mbox.gz
Analyzing 1 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
---
  =E2=9C=93 [PATCH v2 1/2] kdb: Replace the use of simple_strto with safer
kstrto in kdb_main
    =E2=9C=93 Signed: DKIM/lichtman.org
  ERROR: missing [2/2]!
---
Total patches: 1
---
WARNING: Thread incomplete!
 Link: https://lore.kernel.org/r/20241021211451.GB835676@lichtman.org
 Base: applies clean to current tree
       git checkout -b v2_20241021_nir_lichtman_org HEAD
       git am ./v2_20241021_nir_kdb_replace_the_use_of_simple_strto_with_sa=
fer_kstrto_in_kdb_main.mbx

--

If they were properly posted b4 would be able to find all of them.

-Doug

