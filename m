Return-Path: <linux-kernel+bounces-448074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7B9F3AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A06161665
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97241D1E74;
	Mon, 16 Dec 2024 20:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fv4xyS5p"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2191CDA2F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380445; cv=none; b=Ma1cwxgqRYlCaOT8aqn3tpEGBBU/tMIu2Rc5TGJIhVSFARlh4yFgZ6asg/7EQ3/0QYle7lDlGU+HYRa8zNXdDxTUJNw96uR6rQoCGmcJDl3HY+5UH7BOFNngWfW/ajG9lZnYYza3YDZvqxE4nE2IJhJ/SKyXbpqhyO8NOaoEEhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380445; c=relaxed/simple;
	bh=4gjRJh71FkagCSg75aUSNwACHA6SWDq9YX3ztm5/2ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ssg7Ekr5a6RJcaj4jwegc4CWP/6oCvcj2VR15uOi5FXopIlxiUrbPUP+XZ4dHI7Vczc6HR/tw1u4/OD1O0yRZac3zURrTCn+DqL3iaKAYsRH7sw4rbamMI1N/BKmWuW4fgvWfP2/g7CVsA4VdZGaQ6xuYZbWmH++GfV7jj7q/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fv4xyS5p; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e15e75717so526572a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734380442; x=1734985242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0nUfHmf9d9Ek70SiUd7v65urIcv6PcXEuQBmXQvaC4=;
        b=Fv4xyS5p3G5qWszvHIUONMynr/lYOpaojQmjCXjYa/jLtAW9aakp3D/4D730vUis49
         YdFFpIL1FTJA5ecMsV+iY55HqYRW9ReBa3/MZ9jwk0cvQoBXx5XXiwP+uzZsSlOYjyQ2
         Td/rpd/un6dlZ10eAatZigKXrfCsEOrGUPfGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734380442; x=1734985242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0nUfHmf9d9Ek70SiUd7v65urIcv6PcXEuQBmXQvaC4=;
        b=hh53vzcVeYZj96cbwh7aI8aAPgF3V7Nbo/AHbDykrsZfJHPJp9eabNh7iktvaP2oFX
         PiRjB+avr6G2BI9OqfjEF72AjRyb2cEcAPzxPC2qEd5iiomOZHWlUWQZ/aDWSnw2hWZU
         PaU7Q/liWpNQbvKK2/Jlffd8luGcdVPM/odSwRBtSfD7eNvoGtfLLuauURLoV57/Yge2
         zetv0BwfIZ043XbcKhFAvJPWMlWupOQLZxfQgkgziOHpNywDbK764V/JC4RzPcHcCiQX
         bQZDoNB6+HJt93guYuGoiQZ+aK+Vzwt+RfPi4IaFEuu16TQyB9q0+Wdm9X84S1wXJHdX
         t7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXCgazreDmzF9CJNACi7mEY0US23X4+elaXp8GIxZ4jeQuG7b34SWiV2ieaaFAYjsGcz8Xu10f2us1DZdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZoVgIMMDJTZjw4BjbN1if0Y8BJ+Jde47R0xSU1KK7yJav1nYG
	rlqip6mDLJg+2m+QNZC9sjBHlXokcSExV2wW/2tF8qAF750FTSi6phJacRT5bBJY+pkJukagx56
	tOLXlh/UgOtO9Ndl4HxB5AGVehypE0eoR9IpI
X-Gm-Gg: ASbGncsLv3tEmwtPkN/i7X3/+yU2vZDq0iaNAyMAXE0q9X5+am8A67EJ4KLuoJrvnos
	7ELQaUgOkBr9xtdd7VfDthUiN7JSxCDxguj5djMyVleP2iCThuYrYQSXdcHRtmd9FjjE=
X-Google-Smtp-Source: AGHT+IEjHTjhzXjZlpe/m/rtb9hWJfMNlEaPN9aXabHQU461PGl4HmQjfQb2jncDSkIp+HsSDH3UHYdHeepnpUDUxOw=
X-Received: by 2002:a05:6870:5688:b0:29e:99e5:c623 with SMTP id
 586e51a60fabf-2a3ac8c6446mr2803836fac.14.1734380442586; Mon, 16 Dec 2024
 12:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <CANaxB-wvHERPBu+17b5GP3pVv7pC8J0dkK9MUG1tSir4PQx=ZQ@mail.gmail.com>
 <CABi2SkXgZfTvyPX_rcb8KTKyeHxpZrL9_2Wr+vJ1q3K3_1rwoQ@mail.gmail.com>
 <CANaxB-z57KoCNawGEkmpoiHV_iCaYr8YiOc2zQiTHM4fso0ABQ@mail.gmail.com>
 <CABi2SkXYjq0ACYkFf3e35DoOJP6d3TEpLEU_RCTmNLHQ_YJq6g@mail.gmail.com> <qsjxqi64jolf3ywbz2sdtsrjehvvthxjvrsjvonvjmc7vrvlvp@nbn2ehiedagu>
In-Reply-To: <qsjxqi64jolf3ywbz2sdtsrjehvvthxjvrsjvonvjmc7vrvlvp@nbn2ehiedagu>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 16 Dec 2024 12:20:30 -0800
Message-ID: <CABi2SkVwBpV4gcWJVNKxAmDF4_6HMOyyv-9mYtTaGgqG0-JZCA@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Andrei Vagin <avagin@gmail.com>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, 
	ardb@google.com, enh@google.com, rientjes@google.com, groeck@chromium.org, 
	mpe@ellerman.id.au, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Liam

On Mon, Dec 16, 2024 at 10:56=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [241216 13:35]:
>
> ...
>
> > >
> > > I like the idea and I think the opt-out solution should work for CRIU=
.
> > > CRIU will be able to call this prctl and re-execute itself.
> > >
> > Great! Let's iterate on the opt-out solution then.
> >
>
> This patch set has been NACK'ed.
>
> Please rework your solution and address all the concerns raised.  It
> will not be accepted in the current form.
>
Thanks for reminding me.  I'm still considering Lorenzo's feedback
about kernel cmd line [1], if that is what you are referring to.

This thread was initiated from Andrei, and is a separate topic for
CRIU, which I'm gathering input for a solution.

I would like to gather all feedback and consider them before the next
version of this series.

[1] https://lore.kernel.org/all/4e7088eb-b017-4d8b-8e0f-5cb409b112cb@lucife=
r.local/

Thanks
-Jeff

> ...
>
> Thanks,
> Liam

