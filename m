Return-Path: <linux-kernel+bounces-364438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC2B99D4A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4286B254C3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946821AE850;
	Mon, 14 Oct 2024 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCpOf0kv"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F61B4F04
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 16:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728923298; cv=none; b=lYNSqaekEG9N1C/0uaoDWNELlnwfkvHz83n0JeCM0N6hojjnHoohyQ0OWjyq1HwOG5JiRkXe8HKCwRLpFVHpL5eduyXk2adCzVpQPBosTbpSL5cDSeru0SXkXNLn3t2kkQId6FNJJuXMewBufMwMcmI5wgodfuNeI7eWZmgbUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728923298; c=relaxed/simple;
	bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anZmjpYaE/N6ilaOC3/qb5pRRZXhoH8orwlsDeXc5c/FRBapwJt/Fqp+GYb95R7lPqtlJ+VP2Yx9oqgeNA3jlN6UB2rPhAe004eAoea2gryj7FIi3DL8QtAoZ3XdsBR8uHRB1b9SgrwROXYIAeERCfqyO5sWCCiPFZxXl6uks90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCpOf0kv; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d4a6ef70aso436414e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728923295; x=1729528095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=;
        b=KCpOf0kvas0rG+JxwSq3pjLpBf7lNlA9CppBSxjVwYjohTii1qgLDMDfbXiJlK35wD
         9sxfcvJzJpmeFksBEw+ehd+vIUaW7UZ0vditu8Kj0FR8uNDxI5zEgFyMfQVIeFIqjzFk
         sIY9+cYFS2+5AoSYOOOgWZZzxmDqIF7BUdQ7FVCUAw+W8Z6Y5KnMv3h+mcALGCSP/FBC
         cptLdLCD9ywvVhypHYw/Afc1AMUZ8D+cULKn48cJQxK+45tM1pJdJ4dNW/tn5cbHYzM2
         PpBE5zJ+U8GL7QQGHa+k+1xzHaObL5DJJTGnNGMoJfaj0ji2U+to6FEP0146YwIAgh4D
         fwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728923295; x=1729528095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lfAMO91it2cDxvAsrXrdZ8WvRxbUyiDWy7XG1lwedI=;
        b=TkE23e0ubwNZrPe+baWu0YAZWU/oktAOZGCNzD6zTlbFoj6EIAqacKSZn51mIZ5F0F
         PnkksHWwTPiB9bTk9nkQopel8ssSbJIACKNS9YRw6s1tQ4Sv+M+qSKgZebTnYr6b7xNE
         gAeZWhfFozEk2rkeiZwQn+pYLcsvBhQopVatLXM29+Gk6cUjqF80hsxj1wbJ+77rv4mL
         Vs/Z6lqMpLSD495ZdTWlH6QUKDv+UJ2lTGW0/4dVicGrZY5Ht4C3eYs6nRiIc8UUZFLA
         BIsVzwQQWLOpAfXio8G5aq3jeWzt1RVn2cHxXKuQkyySD/nYmflHvlTW2jLV6WxeYKjF
         q8Fw==
X-Gm-Message-State: AOJu0Yz4crue372U4giJZugZG37Cbv0DX0xKMjVJoB3Ce5E1qK2H7EcG
	lUqZdpyAwaK+wsfVzVuHwmm4F+doWfMzH34C0eeWIhPsfG/w6U6OJsJjTCuAggZeJ+NvRyoDP1h
	v7L2Bsr/By8x3X8BfDCXYd2HnhgY=
X-Google-Smtp-Source: AGHT+IE182Fb41RE9AOm8wcIYCzGGR+HdLS3F/hvPllVGWRy7W6ATYjwmFbsnKxabf5DFdYEnhTiw+22kGeCSq6OldE=
X-Received: by 2002:a05:6122:791:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-50d374a2ed3mr4576421e0c.1.1728923295449; Mon, 14 Oct 2024
 09:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010192626.1597226-1-daeho43@gmail.com> <ZwyyiG0pqXoBFIW5@infradead.org>
In-Reply-To: <ZwyyiG0pqXoBFIW5@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 14 Oct 2024 09:28:04 -0700
Message-ID: <CACOAw_yvb=jacbXVr76bSbCEcud=D1vw5rJVDO+TjZbMLYzdZQ@mail.gmail.com>
Subject: Re: [PATCH v5] f2fs: introduce device aliasing file
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>, Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:56=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Oct 10, 2024 at 12:26:26PM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > F2FS should understand how the device aliasing file works and support
> > deleting the file after use. A device aliasing file can be created by
> > mkfs.f2fs tool and it can map the whole device with an extrent, not
>
> s/extrent/extent/g
>
> > using node blocks. The file space should be pinned and normally used fo=
r
> > read-only usages.
>
> Is there an explanation somewhere what a 'device aliasing file' is?

Plz, refer to this patch and the description there.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/comm=
it/?h=3Ddev-test&id=3D8cc4e257ec20bee207bb034d5ac406e1ab31eaea

Thank you,


>

