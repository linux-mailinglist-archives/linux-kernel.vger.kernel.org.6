Return-Path: <linux-kernel+bounces-367606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670A29A0463
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2B6284BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26801FCC6D;
	Wed, 16 Oct 2024 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d89GzWFi"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC71FCC67
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067785; cv=none; b=Pbf82DMZhBLgmTwhGZaJUt3/Jial+R+FIceeY61Lm9AaKiXZ0PKRg1cZ3o5BRxLUJ3IJglGU0MM4vuhTJuprPvS/SghWOJFC9Jdr0Sn6bS4Mf+1B7433L/yIVe2z6YV0m1bymo04EB+zSgjaCp/+hZ4BgNrveg7cSIAALl6bui8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067785; c=relaxed/simple;
	bh=GNCebuizsmxDYYTNS4RuuXhjR8lSTd+b/g+z3SO6iws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ctRbce7TJZqINkg5yupTRR9R2qlDo/gvqzl2e+phr9i1XaZwVLmI6jfsv3hjHvBbPTW1eBlIT/xNOI9qYSQnqUbEEC2Qt578+3J3qYZCT0E7eCnFov1haOPPXNlRBRtwxGBgRVW0P3xDGtWiX7mQV+gRo4IDPfxqI9SvvmPw4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d89GzWFi; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so62412391fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067782; x=1729672582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNCebuizsmxDYYTNS4RuuXhjR8lSTd+b/g+z3SO6iws=;
        b=d89GzWFicPLxVm6g1/ek2pHjJ6ktJxCxotIaP4SLI0XkWG4NgP2daNYbcEgJ4jEQJ7
         9dJ3HRACnnIfOJiJqwD8LzojG73PrjVTz8WN0TS4zBFlqCKITAlij3C0Da9bjt/mb2Wb
         4MJlw3UMbj4jpNz6g4KyPyUJyoVWuOb514HfATvE4zQ7XdCyCpK00ltrewLFk8sWIUzx
         I30nt/GQNXIE6kgG1RrM3Lq76GjfZQF+6NSQuWKWPH65RiLEnylf07CcvCzNkIkoMfii
         96tUQxDJecPUVTMxfDA28VAVP3l1zntlvmYG8fSDKOre1O4HY4SJk73FmG1VdACL1X3D
         4syw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067782; x=1729672582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNCebuizsmxDYYTNS4RuuXhjR8lSTd+b/g+z3SO6iws=;
        b=XK966a/mUdGsQ15t6ALuJ1c3wfnAAeuoks6FSi2TQWis16oKWrStB6IFqlmbWZcfew
         rbMg+uBnDG6tYekTNt/Crn8PVgCtvrOlHnXz+RFIKxuhSxr6dFEpXao0ZRAD+5GpiwZ4
         WJK6g0OxYveQ8LsYC5sjxxYTbGp9ItGMPizkCK4uImnfRHPTeDozQCBcVJdFcEfE8xXh
         yAx51jE7M9WUZ4R+f2eEKWZQZTZoaFELdbsMq/fNbKCvJS5TUuAcHOwFuSkwDEj06UAp
         ZalrW5ubfw/F6XL0PWi/AcF0oltHd7j/ptFb+qNSMWC2v6DAThHbJ34Yl5RP7x5qR8gu
         4v5g==
X-Forwarded-Encrypted: i=1; AJvYcCXaes22NDZLKw3CHKSBf4Vn+V/VIO8XI1mtX0ndMSVifVI+SiyRoV39MyfcRwM/Asvv9OVDyQoGUSshI/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1glynoaQNTUQ42ekz5bzkNT42oM+nKWVwROgjYaD+PcFxHMp9
	gVULy8X3bpF3ijq/vC8BANY3FtcznnueI08ixsBx7SdkyE1yTyaIIm3EPcUXSP98JiWkVVl7LvR
	mQVy+/5F4+SQ+Qhafyu8OXEKdWbU4OdVJ0P7nBaNRV3vnQ/M5X5nl
X-Google-Smtp-Source: AGHT+IGBp50/rrajvwuHfUxP9JITk22QCzL/u+4K3VGqPUoJic0EKKUAc1hZr7U/fYC7c25/+4pYzcXLeYPkaJsM5pE=
X-Received: by 2002:a2e:be1f:0:b0:2fb:30d5:669f with SMTP id
 38308e7fff4ca-2fb61b3e651mr19527991fa.7.1729067781865; Wed, 16 Oct 2024
 01:36:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jz4OwA9LdXtWJuPup+wGVJ8kKFXSboT3G8kjPXBSa-qHA@mail.gmail.com>
 <20240612-hofiert-hymne-11f5a03b7e73@brauner> <CAJg=8jxMZ16pCEHTyv3Xr0dcHRYdwEZ6ZshXkQPYMXbNfkVTvg@mail.gmail.com>
 <CAJg=8jyAtJh6Mbj88Ri3J9fXBN0BM+Fh3qwaChGLL0ECuD7w+w@mail.gmail.com>
In-Reply-To: <CAJg=8jyAtJh6Mbj88Ri3J9fXBN0BM+Fh3qwaChGLL0ECuD7w+w@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 16 Oct 2024 10:36:10 +0200
Message-ID: <CACT4Y+YS+mSjvx8JheONVbrnA0FZUdm6ciWcvEJOCUzsMwWqXA@mail.gmail.com>
Subject: Re: possible deadlock in freeze_super
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: brauner@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Oct 2024 at 21:30, Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi,
>
> Hope you are doing well!
>
> Quick update from our side: The reproducers from the previous email
> still trigger the deadlock on v5.15.167 (commit hash
> 3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
> other kernel versions if that helps.
>
> Please let us know if there is any other helpful information we can provide.
>
> Wishing you a nice day!

Hi Marius,

This is a wrong kernel version for bug reports. Check out:
https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kernel_bugs.md#reporting-linux-kernel-bugs

