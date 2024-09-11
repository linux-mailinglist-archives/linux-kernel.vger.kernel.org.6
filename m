Return-Path: <linux-kernel+bounces-325564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCF2975B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3A471C2258E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA37C1BB692;
	Wed, 11 Sep 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TaWJl/CA"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01BD1BAEF0
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085353; cv=none; b=Pd2GJ90gpE6va30fX9bHW9IwzINSlXjNtquuMZX2FDWTwXnT7AFFEyEDncOUfXEgjex1on60wMDW026sI1XlbBN+UyaStuMo3kyOvoaufgtHb+U6szuvLEDXZqiPaJpUowkZ13SjKg0BRAMOkuYl0P4dWDuc/vOUQ/40OzNq7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085353; c=relaxed/simple;
	bh=r1JOqL3SMuhLoG9ZrTANujvTb8IR0/561m+yfMw290k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7qL+QqZIMLaXEeVm4u9s9FhHXEJOBO/WAhWi4ugg6u3UjkuFshVcMBe0k3Vfx+dzwTak2O1kTLfRTSWZE5a6j/snnIW1gzpPEFEyekrtShXLZ+B3bgCwOV0pK4v3kaXFDJ3O8h7nekbja0qm8lcHeapCZrTzUw1FLgJOCeiHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TaWJl/CA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so39345566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726085350; x=1726690150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1JOqL3SMuhLoG9ZrTANujvTb8IR0/561m+yfMw290k=;
        b=TaWJl/CA71qt773CNDROhpyTbON1eFQ+8tR1Hrosh3cR40+UVaj/xjc1Xo+EHz33E2
         WcI/ybRpTGA6nnxDQI3C+uMOkqIQ2j6ibTLC4mN5UkEzaLoltH6QWHrrXHHd0qQcq/B6
         fzQ/+/P99PkN6mQvQ3Iapneu6WzZex6Zjxlks1KqpOQTF/Lv8owJPyqQ3B04XImDm1ak
         m2w9UfnXPgPEkWRa5FUqdD8lhB6PSCzxjUGbE+755tMSKImTDjayiuo3O0Ue37/eeLD0
         sE5YMKED7AgHyAGhRh+gaARAQfCqIVJg4b+ICwQbk/b4ijptnFDfu7ipCe5UJPsVjOPN
         FvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085350; x=1726690150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1JOqL3SMuhLoG9ZrTANujvTb8IR0/561m+yfMw290k=;
        b=lhvRiL5e5/dhPdRa+IVEv7tY+xGf4WtSzKLj6x0WzAUEDNX2f7W4Hs2wz8pU5XDba5
         0NTu896ezBS69USlFJVuyxt5Wq/Ml3L4dwrOnaaQxx51pZyGv5b4jtfbJ36yvoY85CK1
         /BlOiuAknXD0hGw49VwIC7EDBsUrBISkHwkUodw5EOQKOxYI2nH8p4Kul+nh0cXCa71N
         57+NVOiUDCMizeqAXOCPpnk95v6Ihzu+S7aNDBYNblJIUaJXf5NbmS00SiATok7gF3lW
         q9iokeLv10nPz5e+cqm9CUsIA/1CnJotcFYcAgarG1FBAPhHw1woi//1e8y84W+uvpHI
         g24Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvEWecPojlxfoNV2zCeGG7WwaWC08QfHdhnqBclep1eXvOK1+Vdq6PZeXCNo3tS50feT6KOJuOIPI1XNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWQDPQ2TLTNgjrYXtz3ipk9hfTlRD2fIGOLnNuInKhyCGa7+iA
	DYqNKkqOyNy6ITnWTFuPSOha/x7sS6Iw9UHfoDA3hNRo+wqIVwzmDjYNQApucoxD2TIqIbcSshs
	a1684DKVioWoTYGqyZAHlylUSSAPDclEXwaE=
X-Google-Smtp-Source: AGHT+IGWDQse6TyscgG5CfIR+8gOsyQKavEm8292qY8ZHQsZge2FuH6Ti9KhFX+uKagr39m9dkmwP219Kf1Yc5vk1VI=
X-Received: by 2002:a17:907:6e9f:b0:a8d:5288:f48d with SMTP id
 a640c23a62f3a-a90294bd976mr51828166b.32.1726085349509; Wed, 11 Sep 2024
 13:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-3-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:08:57 -0700
Message-ID: <CANDhNCpPnU7-=QWU7hWWn5LOCsb3kJFJ=VwyHc-b0ssepE6SXA@mail.gmail.com>
Subject: Re: [PATCH 03/21] ntp: Clean up comments
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Usage of different comment formatting makes fast reading and parsing the
> code harder. There are several multi-line comments which do not follow th=
e
> coding style by starting with a line only containing '/*'. There are also
> comments which do not start with capitals.
>
> Clean up all those comments to be consistent and remove comments which
> document the obvious.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

Thanks for the cleanup!
-john

