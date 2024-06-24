Return-Path: <linux-kernel+bounces-228019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1649159BF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8B61C213CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056801A0B03;
	Mon, 24 Jun 2024 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXf8vkoy"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21619D88A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267594; cv=none; b=nNwI1uyL85kMyUAaxs1sVQW1Ew5QzBjXU36sZZfrlU29lorjeaTaEGVcCnOkLX2NyPawWVslkmHO2FJXayFOXLEz9Brdwu9yXD8X3NET+LOrFxybFqLMeuHzA5ZZKFCjXAFGomsgZ9yd11Pac0f5/fl0J1ftOp99Txeq+dENhgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267594; c=relaxed/simple;
	bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCffnvEiwGsPW01gXGlXdvcO0bz/x+92LA998I606YBfLMrq+03T8UHD996414mjFAjwWUtPAKjoOQdW5qurst/D4oltzXXUODsHYXbsY+XgrcarAohT6GO40CNc/7UJyIJ4bw3ERJOYgfbtj9UhMyN1gPPf3DhvzxKF/z5OQNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NXf8vkoy; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-795569eedcaso262119785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719267591; x=1719872391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
        b=NXf8vkoyUdiLGwE8GXhqfp+i0/XFM/uxv1z+ah3oPd4B0I+Yj8/dPV9jjwO47ZsYYc
         LOTMyyDernxOb7HrZplSnr+/NCsbyISz/heDNl4BKAMJWH9MrIaW4i5pj1A6LmzZodxz
         NKnEge4UouqjZ1rp/7/l3Lsx0smTL1LesgPoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267591; x=1719872391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbV55czxCzoSTYA/sPnqyvQYpq3855larmC1rOGAf6c=;
        b=tg48v4u2wWKHudyWbxs/rmULl92f4nOCFOdunYDouAq1sJUx4ZNk9GHXiybVUk3IpS
         MSlHXVsgvtdjMo6+sOEGGQeLEVqklcev/wTNk/PiNWNZVliUta/5hDGhdH/1xEuiBFQx
         yrZXlcGsNSy3iZhFlhtzCY9dJyyr/tJ0sQ88ETlYY8ojHcI/GY/U3QZxoqH9EP6eAAl3
         3oMYwvpU9ZS3OarUN7iyqpa/LSJeYVZ2NUl+0F2I8l9Uk3R6IeyZuU4J3VPeNN6AjVUv
         qXCeHras70mGcOfSxMgjq8qfB3fHnDu+N0Hwe00c2/mD5VyMDXSJsHYXZOU+hcdUsF4J
         SP9A==
X-Forwarded-Encrypted: i=1; AJvYcCXMB7p6IfKMxrLS4nWwZERn3oytFFjAlDClbEu3w3uR7niFRyBiWm35I2YSvVEefD5cnISf5YOqX04XdIu2WPyVqObkYnwcTkArblyB
X-Gm-Message-State: AOJu0YxJc99bkDBaL1FiLA0sf+MDMl/y5hz1yqHjFoQH3yTtOepVFh9s
	k1mlZWap78Zh8d6imj6hSZRulCcDYRCTcjWdrW71ythyNKO3Q3WTEWAKiSypCrpyy4NeFNmMve0
	=
X-Google-Smtp-Source: AGHT+IHYDOa1v3VBy3AM0PdFYtxQ81kYgPIFgMJnrqDQFYhZOah6P8YztZZwfOL31NP5J4aM+zZhdw==
X-Received: by 2002:a05:620a:4153:b0:795:8910:3998 with SMTP id af79cd13be357-79be6e91aa3mr641474985a.9.1719267591313;
        Mon, 24 Jun 2024 15:19:51 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bcf465449sm344586385a.98.2024.06.24.15.19.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 15:19:50 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-443580f290dso49271cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:19:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5g2qH4RLHHKq5u6W2MuwNZeWGjJqQJmxKMcDIpX84IHMtEHNAePeywDoEYmpOgIg0UzpUMnJJfiytqN0jK3tJkA2gzKy1Qk1UpnGG
X-Received: by 2002:a05:622a:18a9:b0:444:ee24:8dc8 with SMTP id
 d75a77b69052e-444f2566c83mr1037071cf.22.1719267590005; Mon, 24 Jun 2024
 15:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624133135.7445-1-johan+linaro@kernel.org> <20240624133135.7445-4-johan+linaro@kernel.org>
In-Reply-To: <20240624133135.7445-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 24 Jun 2024 15:19:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UL2NCbxmQALjKbW4BSpf4WkM30ZHLf1eZiMqRP+s-NDg@mail.gmail.com>
Message-ID: <CAD=FV=UL2NCbxmQALjKbW4BSpf4WkM30ZHLf1eZiMqRP+s-NDg@mail.gmail.com>
Subject: Re: [PATCH 3/3] serial: qcom-geni: fix garbage output after buffer flush
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 6:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The Qualcomm GENI serial driver does not handle buffer flushing and
> outputs garbage (or NUL) characters for the remainder of any active TX
> command after the write buffer has been cleared.
>
> Implement the flush_buffer() callback and use it to cancel any active TX
> command when the write buffer has been emptied.

I could be reading it wrong, but in the kernel-doc of `struct
tty_ldisc_ops` it seems to indicate that flush_buffer() is for the
other direction. Specifically, it says:

This function instructs the line discipline to clear its buffers of
any input characters it may have queued to be delivered to the user
mode process.

It's hard to figure out which direction that matches to, but looking
at the descriptions of "read" and "write" makes me believe that it's
supposed to flush characters that have been read by the UART, not
characters that are being written out to the UART. Maybe I'm
misunderstanding or the kernel doc is wrong/incomplete?

I guess the underlying worry I have is that there's no guarantee that
the flush function will be called when the kfifo loses bytes. If it
ever happens we'll fall back to writing NUL bytes out and that doesn't
seem amazing to me. To me it feels like
qcom_geni_serial_send_chunk_fifo() should detect this situation and
then it should be responsible for canceling, though better (in my
mind) is if we never initiate any big transfers if we can get away
with that and still be performant.

-Doug

