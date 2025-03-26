Return-Path: <linux-kernel+bounces-577055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A23FA717C7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9396188F7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9141EB5C0;
	Wed, 26 Mar 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKipyvfN"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738A1DD539
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996953; cv=none; b=kWO8rfUFTHuzPWYXFGG8cpZBTuwlKW/qNE9YjywmFA2a5vDbwPrYYT+v70cCdGpFr3mo/p+jGI4oKyEMGFUYRSo1kXc8o4k5ruRzC8UECH0SnsGf1Ulp0fg+qRynOsmJDSsphqF9sVtK+5cM41qVO/j29oqf757/7j56Emqpdmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996953; c=relaxed/simple;
	bh=OGDNG6idMLL2fg/jcUPZqDK3G7jWR6/8Xr54WtdYPwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CM5W4+vlVvc63QXboqzygaQNDAa8U8j9QYI2zmFfHsHxjgFgjJc5Golac3jV0IGCdYdfYAo2nZAmPyaWX6ZqhyDTDRch5TGqpmS7XwRGNPJojax5yj27PSboI7iW/5ym7/65nohu1xq2bKPI/Dr9RTcezFqGK0UfJLrLIy8XpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKipyvfN; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so65148941fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742996950; x=1743601750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OGDNG6idMLL2fg/jcUPZqDK3G7jWR6/8Xr54WtdYPwY=;
        b=TKipyvfNEgeSCcLjkkrEwhW7MBq3oJodexvGUgGEZ86uZ1JFlk7I+dOPCP55OBe7h4
         KjDDE6Wi9kKzVHlzYEKNCBQ8uolVo0oUDI/N28GSeILS/PxhAhjdnwltsbBWepQdfHhY
         ABEevIvK4xSv1E4dmvY2nLy2s7hxzgAs3lvbx472ifR2GJ+HtWOicOPHBkXcXww+XenU
         sWVXJM0sj0WZgkIC64k3MnHa5nL0KK6l9f6B+iLlCZmcq3LpAEslnxLqj19qqmWGBqRP
         AvQpsuRrGW/rQAdishd7WRKwSgsF4PIJSiEYQshQww7gqaVBsPxi1bwMPVxD3LUGBK+O
         MCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742996950; x=1743601750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGDNG6idMLL2fg/jcUPZqDK3G7jWR6/8Xr54WtdYPwY=;
        b=wHJXvawz9e2Sj8PxbiK4Ak3jN6NGgn9cA1jPkWYUfKizs8hGBXs+AzHsqh/51yu0jj
         Z5ONlOtPK4aJcnrA8rjHHQd5eTPJlgAlo5q6W0YiAtis3rXoLTkmRiEI4WMirQKKFM8+
         kGAMYR3h0TGpEmtsgEnsKuftYL7lN0LtHSsB0YFbQYk/c6rqX3nHVwGqqgtGOxrg2WaQ
         tsff0/qwaPIziN+02K6aUQlZ7vxiUd4mZZSWhRin3uak6OsdMgkokH57aRzsWGz/eyGc
         dsZgODRQSGgYsAJhi7o558dbwf1BCJUjI8f0Z3PqTotMmejZbo6mawGbRIrIpe+fRxiM
         Xd+w==
X-Gm-Message-State: AOJu0YyxXmTnMD3L5mReeIbLvtDq68vkx/TYxyVmGZ4QeU5iesliOzwH
	BAwYGKwmAYynPAGIVnJQcb2aE0j2Yn/UkEUEY3XoJPl9r9VBIVQtolm4sSsabN8dhH78y12vmIR
	KTb6t7Pl0/nxVIdhnipkkMeau/XY=
X-Gm-Gg: ASbGnctotuENLUCQ+WV7H7puzbTFkPfGNkmrWvnvpQC3ls8+kx9OfRpl127GMYRxTIj
	Z2CYf5QGeV1DNCeeLxXSCmkFBBFI+ObR1XFgtY9GN3Kff91Zy27xGFzEydEf5c1IZVU1BuuTw2C
	cp5zqFF9HeM+5mhZ4SPCswh3KkQvwf
X-Google-Smtp-Source: AGHT+IFIwQQwWW1IOsH+PJmtzPvszrsGTrELspsCDhab5UEvJVgOCKe7n4jYNVcdj7INdXBYuZsjpwbmm0cfQanNVYc=
X-Received: by 2002:a05:651c:a0a:b0:30b:ce0a:3e84 with SMTP id
 38308e7fff4ca-30d7e2babbdmr81618581fa.32.1742996949600; Wed, 26 Mar 2025
 06:49:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUV6dLN3qBgzZFFq2gcG3Bssp6UShafLF-3A3BLpGAGt6g@mail.gmail.com>
 <20250326-fervent-tunneling-frog-c56394@meerkat>
In-Reply-To: <20250326-fervent-tunneling-frog-c56394@meerkat>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 26 Mar 2025 14:48:32 +0100
X-Gm-Features: AQ5f1Joo5mG49B--ga-BRhNlWcuWtpGlga7zXrBTil6PdZQ0vpeW7tq8T-K0nws
Message-ID: <CA+icZUW+EJ3N=1tY2=WPFQx=kFVgATbU2fJvgcgsA1ho9Scfzg@mail.gmail.com>
Subject: Re: [Linus Git] nginx - 403 Forbidden
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, helpdesk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 2:34=E2=80=AFPM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Wed, Mar 26, 2025 at 10:35:53AM +0100, Sedat Dilek wrote:
> > Hi Konstantin,
> >
> > I see several ERRORs when reading Linus Git online.
>
> It's because we had to deal with AI bots again -- I had to block all brow=
sers
> matching a generic Android/Chrome signature. The restriction is lifted fo=
r
> now.
>
> -K

OK, thanks for the info.

The reported Link is working, now.

-sed@-

