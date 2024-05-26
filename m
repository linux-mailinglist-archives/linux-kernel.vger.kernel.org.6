Return-Path: <linux-kernel+bounces-189854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36258CF5DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6511F212E6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50174132484;
	Sun, 26 May 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S/8elkxn"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC71A2C2F;
	Sun, 26 May 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716753641; cv=none; b=n7hW5LY7GBtAzBY0MlnegzJA5AZwnpZ9ljOJd2/50CxbBz1XvW7Gf+v9s6V+lAlWY06LeWOpb1o5oFOdXC1V3iw2QYTicfYNCK3lar/yjRyCqk1qZtra2UvHQp0svI9hDLaPwmheNH3MgZUILsv4BEVoanZA1P3e2qbgJzGEo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716753641; c=relaxed/simple;
	bh=8A+OM3sTxfdAQk+4nK/bQxigKY4/0/MfZSdsbo7dG9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+GDlts7I6xmVXe/FIkA8j3qNlsfUBhsSQbTte5BfszfkVW/aLUaHz+KID+ciEv2OXkFAtbZzqt5Zec68BuXJfSMIoy+WlFYd5dV52ZEgNzKdKVl6DX68Fm8RKfQg/iIyaMa76GVAcQ6OGzLRC52v2aYw6MXSI7BDhQdaR3JUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S/8elkxn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f48e9414e9so2790185ad.0;
        Sun, 26 May 2024 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716753639; x=1717358439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A+OM3sTxfdAQk+4nK/bQxigKY4/0/MfZSdsbo7dG9g=;
        b=S/8elkxn4Ff8V9ursRmBGm1G6qJE660e3rrHqfbStEMzlOJps5pahg/un3UZ1cUnGP
         g3+/Rrf5r41ixbA+nzCQK+rCpgNhLsa0IMBwNJRpmfSbyD6m2BLKMe7vILslxiIWyuvK
         fhaQW2WD7vNy89WdBc4aG9BiDT0OQJySPuTC/SjORB/FJtZWPH8ePrFGrzCgHbxBgeSy
         tF3cmUSqeouJ0ddyEdVUrbypJwwqgX/OkIVuxDwv+9hqeD4OY3KymJn++rq5IYYd3zNM
         6fB3vTW266+er+Lah4TJ8pjIM8oFKsLrvomFVwi0txyvh7UQQJE332XVLHLZ3AR3r0dn
         R2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716753639; x=1717358439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A+OM3sTxfdAQk+4nK/bQxigKY4/0/MfZSdsbo7dG9g=;
        b=lu62Ok+VqLh1DXJUl/Vb0KAyIuDyUyRzTWfxbxr1+OaDCwD51vO72x3jEBcm2QXo85
         JbtXZir02qj/dFu2gai67vMkffvoTMO9f0km+E0rnovJpflXomuzW8I4nv7D8XNrYXrf
         h+CugwQxrRgZiZvaFs2BmkxiTl260IUdpifZ1uchNyueAKCrSdi347h/8crTHnL1jSIx
         fJBrunsDAplmwhd0PYeKGL8Qa/b7FqSRM4OYs5HmCThnuFdq4iNGPTMoIeU4u9IZAUVM
         E4Nhr/wOwyxMZ8loUzk1ai0mR0WENWR8S77MIyT4/fG0ITWb3TtIOwbGxy5aMIHUOoWw
         XF2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUikGF/K6OVA8PQH28fHbJ7LHyvxlp1JbImtZx/gt3jukxP9hL55Ofoo0MNxwdS9TEr4gTAEFMltdRMUU77b9su75liW6KbtK1GTw7FKSSGLxWJpXqDSkzX6Q4aWYRFS3Pdjml/QDuq
X-Gm-Message-State: AOJu0Yz7Z9L8oIBsQVIPk5JXY0+CGQi9PfAFygjVMVGpZyKMm2uRl6g9
	Xr6TJVJjuhWW0aQGWWQTktZ5rimgsYVCuxgT6odaI3rdkUQ/fBvr8qqiEC9RWTTbh+2pLy51oqa
	7wtG6Z8ltjVJIXc0j9JnbHkZnv8I=
X-Google-Smtp-Source: AGHT+IEFOV3K9f3TILkzsZp0EiSSxLAed9kq49ndCFOq2eGYzLGyurKA63ZB77hjZ+GO9f9tTn3zPHbWb4Hl6hejnYQ=
X-Received: by 2002:a17:903:2451:b0:1f3:a41:92fb with SMTP id
 d9443c01a7336-1f339ef1437mr156787985ad.4.1716753639251; Sun, 26 May 2024
 13:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507131522.3546113-1-clabbe@baylibre.com> <20240507131522.3546113-2-clabbe@baylibre.com>
In-Reply-To: <20240507131522.3546113-2-clabbe@baylibre.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 26 May 2024 22:00:28 +0200
Message-ID: <CAFBinCD2K=6agAhC+pB8tqnOLLsnJSRuEr3_nStN8OwrrJPE3w@mail.gmail.com>
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
To: Corentin Labbe <clabbe@baylibre.com>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 3:15=E2=80=AFPM Corentin Labbe <clabbe@baylibre.com>=
 wrote:
>
> The CH348 is an USB octo port serial adapter.
> The device multiplexes all 8 ports in the same pair of Bulk endpoints.
> Since there is no public datasheet, unfortunately it remains some magic v=
alues
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
(on an Odroid-C1 which uses a dwc2 controller in host mode)

