Return-Path: <linux-kernel+bounces-199341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F5C8D85C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B6A1F2283E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CC212DDB3;
	Mon,  3 Jun 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoHbFe7G"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04212130A47
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717427365; cv=none; b=tJHhdxMMKKL9IdbPJ6CIsMPOIdfNhavgq1+TIcuPOxPkIuqKf4G6Tjg0H5NvCSGCfGvuhGHY5IYrKgCePFDR7+XWLk0NZ9rU3ujS5WwQT2hpKMcsBuNeyWJlTtuEUikHatOplFhUqBrHjU/FfeXpaK/ZJBzr265RQ0QXwCOqsHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717427365; c=relaxed/simple;
	bh=pp6PaQicwBJNm0g3BSIAdlQfiRdOCfcFDk1LxZ1CVrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3c3NzW7NwOkhryaEEvPpHNsPtDOLG0ymc5DMMbKU1ytPMSPWXYraU/nVgfQa8AwHPKQFLe110uEXU9TWkYhAFtqk4IP7Rz90g8p3fY/kn13DdCxyQuWq2h2e1NpJc8d9A1UFBuLSeB1QxSsc55DJZFR1NdpF7nSblc25uKBvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WoHbFe7G; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68c5524086so3660466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 08:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717427362; x=1718032162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp6PaQicwBJNm0g3BSIAdlQfiRdOCfcFDk1LxZ1CVrM=;
        b=WoHbFe7GOcb6/DwdsKgdEudPYkBrx6WF65g1LsAye8fVAnk3xrZpfsSxnj6Ovxowva
         myRw4wT6kUJjQV5oX7iYsiAY5RoyhqRVQvdI31ECqmmgxtw9gGakF51Qcig7yOptoOOs
         1wD0gnkYrH8tuD4fC4oEpEcLI2+/yDtdzf9ezzva3/4qFfgCmgaLscGmifixh9H/nxmY
         G7mHpqfmj/De4vwvOqpMODOSupd3lE0Ci8hcTnPCqUD7IC04m9u7Y0xvTrRcdKriZ8AG
         3oHBoUnjAquDtABTiJaGKstCv7KHD+xdCObynXqfQ9mkS/BfCJCj4VSYKlIZqBmussF9
         ISpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717427362; x=1718032162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp6PaQicwBJNm0g3BSIAdlQfiRdOCfcFDk1LxZ1CVrM=;
        b=r+0aTNcUYKr03N7fjcPNDGL9y16ilnkL35bKEWHesGzexO63lfLoLiA42XxkRkRY0O
         kvnja1qBek+5+cg6ldzXrUqQcyO8sfwpKHRD3iHHJMxgBS3KDA3f1/qQP675yY0Yj+/7
         LM565F6pyGGaEf91p8b/lGWJtIUUtNQ0gDLoFmt/zNjncBKBNbL1NKW1f/rmYmDtKubO
         7mYc/Fj24sWAzlVKBwES5YwyzQwWsCRv5oTXKzDUcGNi/SxIHx4UpoWyXQ2zjP8haGpW
         oUGRIWIQhzLb+P50E+im/YLNOb7LjTmnxChaLd2tTQlrloOm9mm1cjR8WZmuerzdrxnV
         08sA==
X-Forwarded-Encrypted: i=1; AJvYcCVy/nXWPwXeN1q4RXcdiGRxnU8tTCDBzgIakR9zUzuzlrHUV/kihunAp7H0kYGxNE+mptkkiNpXVHe6TOQ4y132jO5qIR1G3qeiymmE
X-Gm-Message-State: AOJu0Yx8O0M9/HV/Gmi5YH+7/TvGEI9Vx43iSMTl7sshHfUEQ1uyxHzP
	wl0IU3eZmVlijlCE5y8yScdMoQMSCsF0G48H+8qhYUE/MivPj76SeDjxLmd3H51aOZMhGISpl8G
	ziP3hMXXmJUcM01aivdODBimBjxE=
X-Google-Smtp-Source: AGHT+IE6b9O7VxJ/MlwnUxzc9k1t10GWuccmSK66WzSEy0nfQ5hxBoOaBj+LVMlzwGzS0tHl8lC/kp1tb86x9ahWnng=
X-Received: by 2002:a17:906:fa99:b0:a68:e018:a09a with SMTP id
 a640c23a62f3a-a68e018a101mr337538766b.6.1717427362228; Mon, 03 Jun 2024
 08:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net> <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
 <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
 <20240603121853.GA19897@nvidia.com> <CAGudoHEe=AiRpkyLJTZzU8MtiGC86Kivbyi1xF-Hh0hGJKWhCg@mail.gmail.com>
 <CANiq72kPH_gZrGAEr7WvjzNiNUZz2YtgRV0=PP0LuxaecckUoA@mail.gmail.com>
In-Reply-To: <CANiq72kPH_gZrGAEr7WvjzNiNUZz2YtgRV0=PP0LuxaecckUoA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 3 Jun 2024 17:09:09 +0200
Message-ID: <CAGudoHEQ9ZDLJ5Dhjg=9Y25wmoef4GpDNL5XBZEk57KCtMHUYg@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org, 
	danny@kdrag0n.dev, mic@digikod.net, linux-kernel@vger.kernel.org, 
	joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 3:38=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jun 3, 2024 at 2:52=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >
> > At this point I suspect this *is* the intended behavior and other
> > people don't run into it because their editor does not look at
> > .editorconfig to begin with.
>
> This is https://github.com/editorconfig/editorconfig/issues/208 -- a
> `modified` value is proposed for just trimming modified lines.
>
> Given the latest version of the specification, it sounds to me like
> the intention is to trim all lines: "... to remove all whitespace
> characters ... in the file".
>

Looks like a dead report.

I suggest someone whacks this file or at least moves it away from top
of the repo (somewhere into Documentation maybe?)

I did my civic duty. I'm disabling the file in my local neovim config,
so the entire ordeal is no longer my problem.

Cheers,
--=20
Mateusz Guzik <mjguzik gmail.com>

