Return-Path: <linux-kernel+bounces-392829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828459B9898
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4714D281F97
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC861E2313;
	Fri,  1 Nov 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WR+6KgqZ"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F91CEE84
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489301; cv=none; b=SQ/d59f9DHS9Om2mehCAAG9+96wPtrCF2/W70LjeavGLSzKU9yXcX4U3ozmtqM53C7GjusG2Aqpm7K3XczandifxACsyy86cvCmaxJOuyQYcII1UOHpZwJBLtIhT+gc2TijJyV1hTpBDGPs14ZRJ7y7fpgy1ou7VCP4bpg/cIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489301; c=relaxed/simple;
	bh=2EFpvy1gOo5MIVKvbOIjdyEtkMrOJC8NVjtOAwHlpBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zo4BlKYf2H6bDkNZE3ilygW0Tnu5APFoYY99mX1tAuHOTrSslbE7FHusOZM5BMoY68MU7LLYfjaD2Lxo7kIx5AG1qCYIZIvJKPln8oYhMmp4mgOLEuvMNy4JNF42GeAQnhIZdjtiELc3FYgOqo0I9A3+p8MDqtJK56nhicPLa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WR+6KgqZ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f1292a9bso2757615e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730489297; x=1731094097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2EFpvy1gOo5MIVKvbOIjdyEtkMrOJC8NVjtOAwHlpBk=;
        b=WR+6KgqZJYlfCk1tV5HGLh5iIhPWH+33VaNJRvAGGOdEqOl6EO97677OweaCihBm/v
         bEAvaDbMhVoDeYp2rw7PUhpLkZOh31tL+rhqIHfkeHY87f8OMJpQDRB/RkxuvEk8yJN3
         3Ph5w0PUn8vEBS/1J1+gtpQFLLpbgZOwgkcQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730489297; x=1731094097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2EFpvy1gOo5MIVKvbOIjdyEtkMrOJC8NVjtOAwHlpBk=;
        b=wSfUK1Z7N1o1ZoCfBudZRCyJKMPnxNhqHpltqu/6eM1zdBMU5b1pHJJN+EBy3qHdx4
         orA8rWq0EwDpHagnbySrSE6TrfXnrqPClVduTdCCmytGMDd2X5wha3rMAE6CEpOkwulq
         h/236mie/qqngsa5I0O8XG6MSdM9WI7irHUMdpiwNV3pn2E+NWSM20jqmJ32HX8u4hNI
         l1CcjTZiLYf6B5b2KAGryCYY+Dx8Ty4eoLfiyD/z8JRwW1V9FqMln+hT2wfP8WPsrRGj
         ELdKC+MUS8ziS0CrzDcEGAUwIejnrukdRd1D1Pa+8YS0ud8HntELH411vTh1e436CPr+
         mAig==
X-Forwarded-Encrypted: i=1; AJvYcCUphwNFQ4gNDGjvknKOkbvWJjQxnhZpdiaD+dsp0OwNKNcD0Y6ROMBWJsNjF1z+oxvf75V8LNEyTunsgco=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYJagKwTI36dD8iueH8Tcrk39/I7NljCCd0KQRXrLh3ldcBY0f
	mvoNesOjyEW4mXc1WDWHxlhgDQNewg05EBgUH38yJHZnPtVT1KehBwxxcZzcpLGU11jQlYh0UzL
	LiQ==
X-Google-Smtp-Source: AGHT+IGwAUq0L3QiTkRDvWWPvket8xOzjNrTKRtbizb0nUo7UCjGNq7bVI5V+XwY6zvsP8fNpSgLww==
X-Received: by 2002:a05:6512:23a9:b0:539:f619:b459 with SMTP id 2adb3069b0e04-53b348cb0e0mr11734271e87.17.1730489296573;
        Fri, 01 Nov 2024 12:28:16 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcc29dsm650968e87.215.2024.11.01.12.28.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 12:28:15 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb6110c8faso23900071fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:28:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAtr2JBShr68VVD6vS46VK5uJreiUX4in0S1ItxzMlTQLQ6s0VJvjVYTsMnscTBhgHGQzjILz9NtqkhKA=@vger.kernel.org
X-Received: by 2002:a05:651c:1a0a:b0:2fb:55f0:2f7b with SMTP id
 38308e7fff4ca-2fcbe04f0d2mr124438281fa.35.1730489294936; Fri, 01 Nov 2024
 12:28:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031192350.GA26688@lichtman.org> <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
 <20241101002612.GA29456@lichtman.org> <CAD=FV=V+EJf--J29YM7XuHbNO0fFzLgOYBhBA5VsnnMTG-LArQ@mail.gmail.com>
 <20241101183418.GB752705@aspen.lan> <20241101185700.GA38961@lichtman.org>
In-Reply-To: <20241101185700.GA38961@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Nov 2024 12:28:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKRbvsowiHfvLz3QZa_D74b5n1TRhFnVch0-QupFjCjg@mail.gmail.com>
Message-ID: <CAD=FV=UKRbvsowiHfvLz3QZa_D74b5n1TRhFnVch0-QupFjCjg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
To: Nir Lichtman <nir@lichtman.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, jason.wessel@windriver.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 1, 2024 at 11:57=E2=80=AFAM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> In the current state using KDB in keyboard mode doesn't react to expected
> CTRL chords such as CTRL+N/P/A/E, but does react to arrow keys,
> Following this, I have also inspected the serial mode and over there I se=
e
> that both arrows and CTRL chords work.
> From what I understand going forward, the best solution would be to add s=
upport
> for the CTRL chords in the keyboard mode as well to be in line with seria=
l?

Sounds right to me.


> BTW I originally wanted to add support also for CTRL+U and CTRL+W what is=
 your
> opinion about that as a feature as well?

That sounds reasonable.

-Doug

