Return-Path: <linux-kernel+bounces-170280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70D8BD466
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692BE285B53
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07DF158862;
	Mon,  6 May 2024 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAZzdo7q"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37CB15884B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715019008; cv=none; b=AzMEsje9VF0Lqw5bY1tvugXgeUfXKwnj/AVbTdjEMmkONcHJQ2CSUY6UHWpyR1w5uK9qnOfj921bqK2QzU7VF0vQvAVZTJdOaWqeOxyuD5p5r9HHRF5bI8Epv1XeCNijm1FBJmrkdZLfKeQjt9wDc9MGrnWLFzq/I8i7M48H4nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715019008; c=relaxed/simple;
	bh=3YT6GoTBD5RTJNZvjWe/gTCDSC9xyl71eW2q74FFQVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoeI5ymqGqfacjwplUmJZI7vjnDkKI7DVFgYV9KVK1TJu1FQrNgQAB/mNEbiEkVWwD07Q6IJbikFiXmzJkebivsGLCNFa5c22O/X1a89Kq2DD/VqORGJSGkaKSkD4Zd/wjFeLzjSRkGt/qYe851FfMjaD6404NPEfAB9u9Si2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAZzdo7q; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f44a2d1e3dso1903152b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 11:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715019006; x=1715623806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YT6GoTBD5RTJNZvjWe/gTCDSC9xyl71eW2q74FFQVs=;
        b=jAZzdo7qqbPjfCZ79qeE+HRxqUXad4DAS62+gOhBR2XCzx4cShc+KknqKlRUmcHu9J
         b8yFr4kxn/++cBOEK1pGRM3/dTCy5MV0zbhszmNiFrwaaGy7gdWWY+P/6+Dpnn6Ka9n6
         2sPJ6llaE/xfFUWIb16wmjaqffM+Lwhtdw0dNbH1aRT/4lR5B6+ibgKm/4Kk3wFjZri0
         twJlFpNOm7/lpaRZnAop29efyLgRcpa+b3H/UD9lI5AEeASWJ8eIzv/glZj6a3Smd0Y/
         j0USyXeCUKCth22X5q8YK3R9DgSoSjABxV41sPV8LL9Wo7XshERZKw0C64wd5NhJsb7u
         yW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715019006; x=1715623806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YT6GoTBD5RTJNZvjWe/gTCDSC9xyl71eW2q74FFQVs=;
        b=ixhbd9gIVRoet3iszWpALTLf7SiuyTRfTp81KVYdpr6z7MATyD/5GlxrD9i3l1TtGT
         gOo9YLKdO+3CHvqEiMOb5yrIva4gAqMOeHPo2beFBdWfQt4+tFNikwt+2x/+vEAzWcbM
         qY10qc8iy97IT9yTP5WbIEvit3hO+tSX4uHANvD3BZ/V3P9DcyXlIxl24jYv54xe0Wg+
         yrBFSl6aQEBFNBGfxrMBhLWZ5rw50yvSAQUkxOFi3fX+rGf4Pz6fMm9THIVQl/bqXuL3
         3nBgVXOa5Ooz2/opyoxrJqqrFonZyU2hiYYnjz2SMF74hTRoM1Utnihr1rbtVsVNTViV
         aUcA==
X-Forwarded-Encrypted: i=1; AJvYcCV87IppGTKG1u6izs2uw8+s1+UuDdvCGD8GIZ0/lTGpnkpAnv8hn+S0mykPEsi7asCaXmPdDwTZmAw2Ulia9snuwAslGT7u+0tEWO1D
X-Gm-Message-State: AOJu0YzMyG37w8Q7clhkbssuqFd/cx7eAAUbPevKkSNlNzI3LU9YB/BZ
	tqwD/7qZOZ4NfNWh7fow5LhvI/T6H9MugCuyiqWg+l8+1KrPlojaR3oiiPB8n1604/3qXajiN11
	3O9KwTVGBWxmHuyb0T+rzeGJGbYIO8YOe5ew=
X-Google-Smtp-Source: AGHT+IHX8PagyLuNaCOkfS7Kj0znlYabXOvIdJsimyqynpZ7zYWizoaX3k9aFYgI/STGAH4BqPszoOW+tPGykBsBRdA=
X-Received: by 2002:a05:6a00:148d:b0:6ed:d68d:948a with SMTP id
 v13-20020a056a00148d00b006edd68d948amr12160424pfu.23.1715019006151; Mon, 06
 May 2024 11:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502092443.6845-2-visitorckw@gmail.com> <202405030808.UsoMKFNP-lkp@intel.com>
 <ZjQ/JOpcdgWZXo0y@visitorckw-System-Product-Name> <20240503041701.GA3660305@thelio-3990X>
 <ZjSSylciH+qJeEEG@visitorckw-System-Product-Name> <ZjSUk4vgsQ63wfcn@visitorckw-System-Product-Name>
 <20240503155401.GA3960118@thelio-3990X> <ZjVdbavKgDo8a0CZ@yury-ThinkPad>
 <20240503222338.GA1908482@thelio-3990X> <CANiq72mJPPp=H6qb7sG1K1hxR3uiHA9+WEVAZkvymSt_dW3CbA@mail.gmail.com>
 <20240506175209.GA1425562@thelio-3990X>
In-Reply-To: <20240506175209.GA1425562@thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 20:08:41 +0200
Message-ID: <CANiq72=mSafSJH1hab57LxYfyj_BD7UOtyAerOT8S41MD-MnAw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] lib/test_bitops: Add benchmark test for fns()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, kernel test robot <lkp@intel.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 7:52=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> No, unused can be used with local variables, used cannot.

Yeah, sorry, I meant `used`, i.e. it is that one the one that
constraints the combination rather than `unused`.

From a quick look at the links in `compiler_attributes.h`, `unused`
can also be applied to types, while `used` cannot -- it is another
difference, but your sentence above already implies it anyway. :)

Thanks for the correction!

Cheers,
Miguel

