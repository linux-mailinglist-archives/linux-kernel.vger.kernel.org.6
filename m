Return-Path: <linux-kernel+bounces-343195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DB9897F6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 23:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BBB6B21028
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED71DFF0;
	Sun, 29 Sep 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="PeczMUKU"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11CA1428E0
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727645921; cv=none; b=UDsGNXvDh6IV8ambtYsldwy1oQWRlIwanEHzyvzC4HLfqnx/pJky0nM350OvLZAvRKTDr0Ltc60UXZd3pp2ZHue/NAmGSz3Up1cMAa0OanetmsUH4JShAV5gwZ66AXN8OEHcWKcR50SO/7N7k6j/zqcPca+Sqa3Z0BoIQ3jCtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727645921; c=relaxed/simple;
	bh=ZNY9VyfDM9tqtA90xwrR2HvYJHZ8XZv734O9gqNA8mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjxnd3X8bG5q/loeT+DbPOTvhyx1DEDdskXpQPvCdzYEtGey+/mYP/LQlTA0dqdraRm28NVNlQnX+OR5xXqgCXueWZcOnlFED+ZaqoMxsw2EgaskW/HS3kztQ+dLf/3ZM5B9o+dE4WAqczRC1ER0Gfj8LEN2wGp5dJ/IaM+3s4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=PeczMUKU; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e235a61bcbso20345237b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727645919; x=1728250719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNY9VyfDM9tqtA90xwrR2HvYJHZ8XZv734O9gqNA8mk=;
        b=PeczMUKUZyGqm37d+2hfAyeGrB1BtibiJcEE+uGJ2GuZ4c6gIRyDDESN/cokOHgwwC
         u+zizlHZNemtyBnjxrSTM5gRkUOMivDvjgzT6uJiUqHBkjzz6KaKPK2Qdn1wFlX8Mujl
         EJkSTWXRcnYS2SsOe/UUXrxTiRQbpDTrocSO84SF5V6BJ/2/Y5aXvA3VNMDF7u/6ISTr
         v547zeS8otpGJztXfkWMcjaZPWe8r6HLzafG8PKSZwyc2lnuntdGGAn16F3pV1os8EYc
         +h7LZk2YBvzdNzJgEWR2clIicJVMwKzBk8vlqmlGl1pxaSr8/k+tK1BMBPp9DrGyzCTV
         eTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727645919; x=1728250719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNY9VyfDM9tqtA90xwrR2HvYJHZ8XZv734O9gqNA8mk=;
        b=Fb3g0EIqBlbuL8ga2dAPi+5C+N3g3AbdFVKt1mvu2ICDHI4zjqWNPyatlpNibBsa1R
         r6+3Ci6aht4sgpcHygF3Zt7P09YKSb0VFzZuj0FJTsZVBNpXPWRdIx3gyp5m74prVhBf
         4N3i8pJGnXpWfOUGnEMoGX4zWdxVYxMjUp8sgvYENMvcOQz5XoQLAw7dBtNjRdb/fceH
         540RXMeWcjXj/rx9ZNDzCiAKG3nCyjsDuAYazcpAqEASwBLDF5Dw9fw9NN+3FDBXkGe3
         xwts1GPqbNha5Hd0pUaPZyFQCcA5CWg0xsZyLKy6+5Hhe1jUrPQBlJkQu+ijp3CiL5df
         NeUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsiDwhq7di1TB5czvAQQq6othZjwORZChPAN3uCUGPBU5RuBjXkF5D8+ChAXLshcyS/eqKCLyFkaE5Ea0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc5U8N3ohasI2sksA0H33YhKmadErhKkGZMzDMunDkinZPAn3W
	A4DAX9FtwK2BCVkd/DaCzTM7XFY779vY3TQTIGx0GrlOzvUJV5ghQBvoPFlf0rlWGYhVTWsE9km
	jKDq6dB+kY+5DOTPnW6ifwc00yb6DWcEs+K+TNA==
X-Google-Smtp-Source: AGHT+IE+itK6MB0ZFmcjaz39EOyDbuNYm2rO49VdiYLG7uciGvFfjCMrV44OlHc+8UYdxJ+Af2ZKwF8W3CE1I2PLRVw=
X-Received: by 2002:a05:690c:4b92:b0:64b:b7e:3313 with SMTP id
 00721157ae682-6e245331712mr80972767b3.13.1727645918737; Sun, 29 Sep 2024
 14:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918212052.8790-1-nells@linux.microsoft.com>
In-Reply-To: <20240918212052.8790-1-nells@linux.microsoft.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 17:38:28 -0400
Message-ID: <CALNs47tAL3yCXuHAOtp12VascnmFbE384VwnupyWtHB9vc3+3Q@mail.gmail.com>
Subject: Re: [PATCH v2] rust: types: Add examples for the `Either` type
To: Nell Shamrell-Harrington <nells@linux.microsoft.com>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	linux@obei.io, kernel@valentinobst.de, kent.overstreet@gmail.com, 
	matthew.d.roper@intel.com, kartikprajapati987@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2024 at 5:21=E2=80=AFPM Nell Shamrell-Harrington
<nells@linux.microsoft.com> wrote:
>
> Add examples for the `Either` type
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Nell Shamrell-Harrington <nells@linux.microsoft.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

