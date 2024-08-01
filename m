Return-Path: <linux-kernel+bounces-270917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B06E944709
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB65B21DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACA16F0CA;
	Thu,  1 Aug 2024 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhJiWE6Y"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943816EB65
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502244; cv=none; b=CmZwbSnlv4PJ8pXl2+uwTlmhYhZX2PmK6oBlOFV2Rmun8HWWFkfe44mtcxsduRfRp8P5doBXVbLvRcKKADiSseh3xxYY4xfyF3+H1HIVFOHXievEEHZsG73J2BL5EtaPR3A9Ac3oab4PEXqpZIFd8LGNT0+GkFjF7QBDC8sm9JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502244; c=relaxed/simple;
	bh=+wTx3JVLQw4uNjXqb+IRtE1NTOiVfXPtU24MNzV5llU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbnRI2X9RcuYPzZsGPr2VThp40JVa5P18s7CGMTmWZTdBs84h3JRmV0QvcMRhE/oUnZDurR9YWbz+f8UXlx+vk8YNMIs8+AJp8QySJVuwYOC3DDDMvB9BL2q+yTYuVcpj8dRuY3Q7TD45Jf+poMkHIko6+KBQGNQckOKfwQde1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhJiWE6Y; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-664b4589b1aso15324437b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722502242; x=1723107042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wTx3JVLQw4uNjXqb+IRtE1NTOiVfXPtU24MNzV5llU=;
        b=hhJiWE6YJFGC1dcIIPIMO0l78wnMcvtmEoO2icNyfxKUARDXxT0PPEa2U9EcltML/t
         EPLCEErHf5BWBN0OOeU546aJ7h5lakRB/S/VYoN6As+b+eh6Bs4vheYxx/1Ol8T/BUgb
         60VCLXquLlrn/sv4L0ieaVJRh05oDvufeneSe6HrGINYV1+l6mPrziE4L6SnrQZr6Wet
         4KpH1eNIknA6dPVveuXWULFX2Z+avopEEJSi0iKS1SAO90Tv+rd8iqi+AJD/mz8Ga4cY
         Z1GQ53O7u7XQkMEYEm2Y3D8RXTstFkMovGG6Ms4aEFELDZWt3u/dm4dw8R1DiC59hZr5
         zMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722502242; x=1723107042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wTx3JVLQw4uNjXqb+IRtE1NTOiVfXPtU24MNzV5llU=;
        b=OKyGukLMdMo3nISSudszvU06Zezj01SY3p+kuUdBKZl52Yz7gGuMvwCjvSrA9ZN9xz
         TPzsSQuiE6+5NOOInzHhf2JgmifEVvsuL4p75CLmVjbbzLtesF5BMgYo+9+yzUmB0On8
         9SXuIu3MjvooEpo60lE9i5gAjhRDCa3OBNliQr06O3wTH0HF8XSKaAnlnFYOYgkK9oxq
         jP8wywne6OpTy6WXFjwE3UQgwn99O7QZNnqBjvkisaOT++GJgiomdkPUhSiKzgZQvdDk
         O4/rdxZOBKz13iGTHumRj0cUs9WfCdMFW+jAmud2/cMuPpr81x1pUWMrmUdGpLW2UTUb
         0ixw==
X-Gm-Message-State: AOJu0YwLSmIBTIalZGOye9otQu5cZamx9+QeNHX0mdjc9SGcIgnCjk1E
	euIGXBe6LbLb4jGbd/f6Ccgw/x2YnWC7jhSfpJNeYKKWTs/7mFRXt+o9dI5NqX0FdoKNR24/IiB
	UG9sRiY0uadYlqgsUiCI6akrGrVU=
X-Google-Smtp-Source: AGHT+IGI3sysuZQwSLtcR6eNxQQU67SwRPeV9GisH8EZAXepKtbwu1bAweivtcaEmvsmd+1vfc1M0Plz1hIrCH9nS+Q=
X-Received: by 2002:a0d:fb43:0:b0:627:7592:ced7 with SMTP id
 00721157ae682-6885311a626mr4056007b3.10.1722502242281; Thu, 01 Aug 2024
 01:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731210052.6974-1-rosenp@gmail.com> <87le1godh1.fsf@toke.dk>
In-Reply-To: <87le1godh1.fsf@toke.dk>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 1 Aug 2024 01:50:33 -0700
Message-ID: <CAKxU2N_b51S=gDthQtM+aRnCt1Zg1SrodjmLF3u9aV+Y6GefAg@mail.gmail.com>
Subject: Re: [PATCH] net: ath9k: use devm for gpio_request_one
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 1:26=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@kernel.org> wrote:
>
> Rosen Penev <rosenp@gmail.com> writes:
>
> > No need to manually free the gpio now.
> >
> > Remove if statement as it's redundant now. The gpio bit now gets cleare=
d
> > whether set or not.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>
> So presumably these will conflict with this patch?
>
> https://patchwork.kernel.org/project/linux-wireless/patch/3b46f6c7-4372-4=
cc9-9a7c-2c1c06d29324@gmail.com/
This does not look related.
>
> -Toke

