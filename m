Return-Path: <linux-kernel+bounces-224875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B09127F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39514281AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A4C22EF3;
	Fri, 21 Jun 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d98Px7yV"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0263208CE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980630; cv=none; b=EnXUzTjWH02c/G7gG2BYglaM6SpUAR3vyRQ2W7ntfgt/KUAi6QEoYPVgK/CQ4R6XOUFP5lLoODxpM59T7T6hBgOJfpIG7f8r0TO83KJGD1SSpjUKj9mMJ9gXO2hLhtZ2OYGgIIvJQ87oAlDSZ9bbpYjlR2zOl8RFH9j9bU94MSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980630; c=relaxed/simple;
	bh=jPkpSn3EaajHQYDjX+mOYG2lvzKJWAU8FHfUUlYwBGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fdz4eZnwbDTiwYierLbhtkJa/8g1D1Es52HQcyn1k6F2MKXzpdHOb6lQN+ME0e2KElB9qcFeexm3aQs2ZYBV0DzVIrDjEntQPyYxTOnVfopYAteFSIwTeRQ9IGh5spouMO14fXDSppfN5JJA75DblWEEwY8uPUIPu7dmrMfxW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d98Px7yV; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9cc66c649so959636b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718980626; x=1719585426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVHWNO8hVBMBs9zzdjCJwZeRLm+D6gnBpyDsLKY0eeA=;
        b=d98Px7yVzaZ3rS9tQI1EEWxE4CkECIoev6PfM0WL+GxccaD8vuBpuR05pAvbtqJv9K
         SS4e78Hct/pH+I/0jQmBRDCs+Q537R5qL14rLz4R9me4T9yzLJDZHshmKlf7pdVnKQs2
         P4k5g6AhBZ+0f+Zx/5c/fb+muBHTdjWzJZKKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718980626; x=1719585426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVHWNO8hVBMBs9zzdjCJwZeRLm+D6gnBpyDsLKY0eeA=;
        b=S042fMFeW+FdiAwWtUFKc03UnFuYUkkaDf0Mblyad5cPWkaHN5iJtXpm7QXOutbwkl
         EwI931syP71EC/FfgEFCRRLsWbb+H7p8Vdcje7E1AiKNtHBoYOujRZ/6AnlTffP4vCik
         7r7+njHcenTtaTs8WwBbgdVbgRrwSZ5agP8URktEmus83xjCYaZUkXFXgSbPkKqzdRLp
         XHECjMz2sg5LUns9yYV9t1GIaYSQlDbbQK/Q3aPrrC0iz3e/iSe6CSK/mBUInTJ6m0V9
         Wuiu1A4gUYW94F8L2FVdWg1G7CpZnA3rutmX7UbR0cmOod3jPG+Wl4mX311ejZ0K1Wu0
         sJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVQt0P7RGs9z6ZhdJcaDKR0ELKW9b4VAMWpacongFliQcggX8V+CJC+6CFajVKnwInyOGTXO5TL4ghk0NxW6ODMKmqH8gnnuunhK8R
X-Gm-Message-State: AOJu0YzkzqJ4NaD4qxBYKuhjz0M7aAPxSY/OISy0izbD+FBSzxe0DslP
	xE7nHYq45zyOTusN/uC4NiFWJ4s4fypS6k1qruKLdwY34t/ERKD0/kzKkQcdrOHZBWKaPOwRBd4
	=
X-Google-Smtp-Source: AGHT+IHLcJ1OFQ7W2Yn2tQlV82klxYvE7d4GZst6X2PcKc8KJSsRBGHuu/upa1powGAUwKadkLxnVQ==
X-Received: by 2002:a05:6808:3a18:b0:3d2:2780:6e03 with SMTP id 5614622812f47-3d51b9bd45bmr11964424b6e.22.1718980626574;
        Fri, 21 Jun 2024 07:37:06 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2b9d259sm11654171cf.52.2024.06.21.07.37.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 07:37:05 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-44056f72257so412791cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 07:37:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkOH9BMMi0HQjB73ygF0dVAfbNtAsPQjMTQegC3C+eIg4RjHvsqkOdQ2kFsEmvZi4/bcopmg1+9nwzMV+30QtQAqa4VkmYxM1vG32D
X-Received: by 2002:ac8:5f52:0:b0:444:aba7:8c07 with SMTP id
 d75a77b69052e-444c1b4816cmr3609321cf.18.1718980625180; Fri, 21 Jun 2024
 07:37:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620142132.157518-1-zhengzengkai@huawei.com>
In-Reply-To: <20240620142132.157518-1-zhengzengkai@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 21 Jun 2024 07:36:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uw4-czLekDJ1aU55Kxb5NeXVufnpo4fYy9EwQ-KUqDCQ@mail.gmail.com>
Message-ID: <CAD=FV=Uw4-czLekDJ1aU55Kxb5NeXVufnpo4fYy9EwQ-KUqDCQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] kdb: Get rid of redundant kdb_curr_task()
To: Zheng Zengkai <zhengzengkai@huawei.com>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org, pmladek@suse.com, 
	christophe.jaillet@wanadoo.fr, thorsten.blum@toblux.com, 
	yuran.pereira@hotmail.com, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 6:58=E2=80=AFAM Zheng Zengkai <zhengzengkai@huawei.=
com> wrote:
>
> Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> removed the only definition of macro _TIF_MCA_INIT, so kdb_curr_task()
> is actually the same as curr_task() now and becomes redundant.
>
> Let's remove the definition of kdb_curr_task() and replace remaining
> calls with curr_task().
>
> Signed-off-by: Zheng Zengkai <zhengzengkai@huawei.com>
> ---
>  kernel/debug/kdb/kdb_bt.c      |  2 +-
>  kernel/debug/kdb/kdb_main.c    | 18 ++++--------------
>  kernel/debug/kdb/kdb_private.h |  2 --
>  3 files changed, 5 insertions(+), 17 deletions(-)

In case Daniel picks this one up since it CCs LKML, I'll copy my tag
from the one that didn't:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

