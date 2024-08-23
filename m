Return-Path: <linux-kernel+bounces-299162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B1095D113
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 273731C23AD9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997B192599;
	Fri, 23 Aug 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfF8QuhD"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C94192589
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724425634; cv=none; b=LfOQDrhm9+clD215qycGT2WNGdxJUt2fni2gawUWqZBvabw/2/CkwIRAaQhxpRhRng2cKo4c+4dXbzfoG/hxi4hDdF3q7wz4cdGrxEt6vikuPxjgPx0h5XR25+TgdWbi3HIGskpMDvDG/171SCyCgMTz9fw/ym8t1cThDz1/c8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724425634; c=relaxed/simple;
	bh=Trk7kRqz9cwbWgyymtr7L+zIg0BtyDTU0ddlg39/M8Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LmtYWNjzuRbI3dxpgI+0h5QgC2bg8NDLgv0CamVOl/NIh1DOhIzKXTSUjwo7FTNIqDlHw5dYEaHjWkDYktqMRnbLZUkHXepi1TuOPGmZhY0CjxaZ5eeTyJqvq+QAbvqMiocnXrH81eOuZfbn+Fb0QZ9KuEip38lmcfbjokOkXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfF8QuhD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a86910caf9cso333537166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724425631; x=1725030431; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hN/u/MQcY1xAjLL8Hjod4ME8opqYEyKjoXDkSbZQ89U=;
        b=OfF8QuhDYZaK3jb7P2cy+ds3AvlyoKwcRPCJZBT0L9Lb3ebLnk6Xe7WpUdG8X0/bD/
         9hvBAwyjEEGXCujhoutTwHcJ5/GD0KKq40K/I2Hc5iphFVauH40Ly+hN4pOXU9To89ia
         OGMDqthDiVYsAj4DIzQ3DiPD3wsr2op4Sfk7Tf89RQhYD6iHwfGkiGfLo5mtZBis1QQf
         qpn1fpBHCu5n32K/g/JZZ0jNW+wIq2Y7ksbgkCSnV2TmO0+rrtdHGvi3fET9IhHBClux
         g6/VcBtDWYnZoGPxObaBwt1xikDya21bfrBr6s2PUMcFcSgIJvrjy/htOmBnLaVWoYFk
         LCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724425631; x=1725030431;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hN/u/MQcY1xAjLL8Hjod4ME8opqYEyKjoXDkSbZQ89U=;
        b=N+YfGkJDfwe8OgpwifoQBOejlWDPPtLfMkFsa2qADL3ebCMsgt/baDsTJaKwdzh4dd
         QFTOgkOY+xWpYLCVUMnE8Ruq+9VPDAXV/1DdI+HCySqCZ0MqjmYzgZTE7n0Ekkd9VxPx
         e9Z3uHbzleCwX8BWUQFXSqHjtGgdYxUaaN7T87MBdmGU8ERjbIIVXMsfokOVUqo7mW0n
         2mtm576UtUblISeoXcr5cT5go6I0GhtwxfGtItYJX5b0aI06q0lExM9fOclgwlGX15Hm
         Tzotw6bqG7LhMkRN0J6ETGM1Pp8WTKuEnAAiWUA8VVzp0k3K7UykoDwW3rR3z30Xdeqe
         7pbA==
X-Forwarded-Encrypted: i=1; AJvYcCUxNvPw9T4NBCUfKenXSziwOyYMN+T46OmTWfm57Pg3X+wdr5fWF12k9KwkLroLJz9/aQQLS6to3My7BZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JWpVi01UkiKoAr+19iW38F9RVnMJ6q++NV7l9wIs6aG+SHQw
	x2OPAe7OaWhtmGn6oGigmwBMo1trwo/TTsP0wx/my6rI/XU5zDmy
X-Google-Smtp-Source: AGHT+IG5tAtRJxhV8UgS3aL4a+RPXNeZQ71j1OSkrJuVSejXjR1anmR0EuaxDPjcIBy/x4piGenuQg==
X-Received: by 2002:a17:907:86aa:b0:a72:66d5:892c with SMTP id a640c23a62f3a-a86a2fa7ed2mr249230866b.18.1724425631323;
        Fri, 23 Aug 2024 08:07:11 -0700 (PDT)
Received: from smtpclient.apple (89-73-96-21.dynamic.chello.pl. [89.73.96.21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f21fe18sm269127766b.29.2024.08.23.08.07.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 08:07:11 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
From: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
In-Reply-To: <ZsiLElTykamcYZ6J@casper.infradead.org>
Date: Fri, 23 Aug 2024 17:06:58 +0200
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Linux-MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <02D2DA66-4A91-4033-8B98-ED25FC2E0CD6@gmail.com>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
To: Matthew Wilcox <willy@infradead.org>
X-Mailer: Apple Mail (2.3776.700.51)



> Wiadomo=C5=9B=C4=87 napisana przez Matthew Wilcox =
<willy@infradead.org> w dniu 23.08.2024, o godz. 15:13:
>=20
> I wouldn't be surprised if this were dodgy ram.


Well - that was my initial hypothesis.

in fact i had few of them. Ranked (and ordered) like this:
1. downstream kernel patches
2. hw (ram) issue
3. kernel bug

So full history was:
-build myself archlinux 6.10.2 kernel; upgrade builder OS (only kernel; =
nothing else)
-run normal devel process and (to my surprise) discover interrupted =
CI/CD builds by kernel oops
-downgrade to 6.8.2 and done 4 full builds (full takes 8..9h of constant =
12c/24/t compile). all good. =20
-prepare vanilla 6.10.6 (to exclude potential downstream (ArchLinux) =
root causes)
-run normal devel process and still discover oops
-make sure hw is ok by week of test with 6.8.2 (recompiling for 3 =
architectures on 4 OS (3 in kvm). This was almost 5 full days of 12c/24 =
compiling. All good
-because last steep was all good - decide to go to you :-)

sure - this is possible that 6.8.2 had luck with my ram and 6.10.6 had =
no luck=E2=80=A6.but i personally don=E2=80=99t believe this is a =
case=E2=80=A6.    =20

btw: we can go with elimination strategy.
So what i need to change/disable to be closer to finding root cause?
swap?
now it is swapfile on system nvme


