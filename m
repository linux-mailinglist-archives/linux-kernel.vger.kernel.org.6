Return-Path: <linux-kernel+bounces-198360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 923688D7724
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07511F21458
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257151016;
	Sun,  2 Jun 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYzbOrEb"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443871DDD6
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717345745; cv=none; b=ugIx1q5rVLYuJ3UT+cIpwk83xpDB4q5f/knuFaFDoYvLZc6gwXTKSclycHSSJ6t8AwwVnLL1rGUi5rKHKmKj0KJeGisT6aKXSGxDOB7NyV0yNJ1+EG/yoBeeNrDdfr+U0ECTMT4GbYrq65XC4JY/QIfQV69T0huanaPZW7g4m+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717345745; c=relaxed/simple;
	bh=bRAebncTr5dTqRVO5e1xTPCZ2Wb2ror0a6gDeuUh+WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=od0ncIjKt1wZizX91C03JIq7T40IAG2Wb9598gigbzlbJcGV2hCLjtSSGDOlokolhog6PIYCmskatTJ1dtiR18uSIVfLCIFJB+XWWUdUGVxAgHBcOlaQtJD+tPZpHGaBShx/V9/BfvdhTHwzmZOivcGlaA35LqAxpnbfNM8gKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYzbOrEb; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso1591289a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 09:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717345743; x=1717950543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRAebncTr5dTqRVO5e1xTPCZ2Wb2ror0a6gDeuUh+WI=;
        b=kYzbOrEb6MSwNOI2zLUwsLLkCEt4RfsxQaUK2dP6pgX0brngZGMp5i1QKivYntb+mn
         N1mpVguftp8JStpaTd2xm1fZgvIbrs+aV+UPcj7M21oCeq00jyKBnb83Rvz14sPa1UY0
         Qk5ELv9eZE+71G924617MiBxZwXmz68TX9lgSWy1/pczgj+25MX0xPa+5UEjFPjmeY/g
         wFCakZp0JnSbcpu1QK8zkFj8Y7+alnfxMlgHQhhAkHx6ezkYIRDbsgvfpthAstbxwxW+
         aWjPp/hTybCuWiJ/UcqRm5TN/GxtJEcoOSNkU04DaM87vNm/U83Y04AbKNZUMnTFgW2a
         DLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717345743; x=1717950543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRAebncTr5dTqRVO5e1xTPCZ2Wb2ror0a6gDeuUh+WI=;
        b=Twxe9Ow0uDwUY9eZ9PWcQhJybd9WNU7A7JKIvtaJOD1s/TJg5HrWHksntYtK9HS+E8
         L18Y/wKy5wbSopY5EqBBuLeLZqQVcySHaHIKtkZ5jbUUjWh1g22M9Te/uuu5Q4NLhjg9
         /PvmPW//Z8WHOOUo1T9SkxAJp4bHVyKPDlX1GbrfPUVN5hmpuL02W22lG2uc9ejzKnj+
         VXyenpLpGWucivA86QJzV9irUYvjAwROMSwpk81RSEdJq7Q3QaI+M8nbdWxTGN3WTb0U
         hF7gJsEjBeyx5LwrXfv9DBVKWi7fPootHqrVy9PViSDTBNhnDtUlebzCTXDX98OCC5Fp
         FjAg==
X-Forwarded-Encrypted: i=1; AJvYcCX6BE2DwpdENALVixST41hBzCHao/CNlfUJe7ImsEzUqO+N4ppT4kXYTCHP0i+ZBjg0Z0PYztaPwPZwxcni1G+cdcCq4Iug74QJ4lz2
X-Gm-Message-State: AOJu0YwjkfTxHA7NE6riWoK5D9WsTX1yLQAsxxyKx2LCFlD/2emOShSX
	Nndpfzl4YMgMu6niH2RoqBEwndkdAoQa23Efm/XQXDRsrfBKVNWtilWHPK6yPaLzak0wPJdqgV0
	bowuJh4zo0QF72MGT/vLHriH/el8=
X-Google-Smtp-Source: AGHT+IHGkfEpGVkMpVuPjcpKEqWpK/eX91V8bp4MaRNl9OXTvy8LmpuO9Rrs1HO+7yt4KR1DAcH/HECbCPFM0yYuOAM=
X-Received: by 2002:a05:6a20:2451:b0:1af:d044:1395 with SMTP id
 adf61e73a8af0-1b26f141cfbmr7396195637.20.1717345743488; Sun, 02 Jun 2024
 09:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net> <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com> <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
In-Reply-To: <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Jun 2024 18:28:51 +0200
Message-ID: <CANiq72kSyHxLUFYA0KyXoQszHoZpTXyN5oPyx2OMbQZVG4dzcg@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org, 
	danny@kdrag0n.dev, jgg@nvidia.com, mic@digikod.net, 
	linux-kernel@vger.kernel.org, joe@perches.com, linux@rasmusvillemoes.dk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 2, 2024 at 5:31=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> You can try yourself by editing fs/dcache.c or fs/bad_inode.c.
>
> It stems from this line:
> trim_trailing_whitespace =3D true
>
> The problem is dodged by setting it to false or adding this to
> ~/.config/nvim/init.lua:
> vim.g.editorconfig =3D false
>
> Is there a non-giant-hammer method to disable the thing? Maybe some lua
> magic to special-case that this is the kernel tree?

It may be possible to disable it for particular folder/patterns and
then try to get their maintainers to do a sweep eventually.

Cheers,
Miguel

