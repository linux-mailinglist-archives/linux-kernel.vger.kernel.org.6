Return-Path: <linux-kernel+bounces-241962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DCB9281CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C79284590
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364C6143C61;
	Fri,  5 Jul 2024 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il9nIFuH"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AB143C6C;
	Fri,  5 Jul 2024 06:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160346; cv=none; b=ZyJR3+oYsrWvm3U4vZOqTX9XJ1VQJqgVCqxSJBZ3vtSCooucblfmY3YzTX+FJjc5XdSJprd5TD3vwittDCJkSuxKCioQufCAq5gdyRIhuY5+R+viyzxepWulubExFZxTvBEy45zWYc7N+8eokuMoQ1Ow8Qk7F7rt6B2QfIzcrJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160346; c=relaxed/simple;
	bh=YvKG9q2xL++Pot6DpoW89EfPEWqDOPrpX/PWSKVl0/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFdUWdn0MQz+dajm5hyn89bj5M7SQc12xlSaK6xJTp0A+GrS7RY45AY6WIwpgFW85bFDZx40K96NBq25vXZYNgqfqDZIBSNbuq0ets75F4RT72qYzsMHugXV8GuT7Q9nNfyEu3N+0/MuzDj++gLvDxmkIMsO26ix4WdN70x3baw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il9nIFuH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cbc66a0a6so2238565a12.1;
        Thu, 04 Jul 2024 23:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720160343; x=1720765143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Wq4Dg6ZPYZPbtDaC82FkKemLA+7PBLo2xay7aB0Wg=;
        b=Il9nIFuHLfb171EP66/qtWm9tBEzemx9lONEACVZ099SA9ZZlDVHnBKWSWDEw8toSY
         AH7e1zniv6f6G5zv/pF7N5+y+YNNa1027bvK1aja/ANHWJP7wCk4h+p42gS1S0HwJ+96
         xO66IrA53Gw5kBnIUfBGS7O4Qf6p7AAgH8OVHZ5bK4X+MR2NzChLtTwTCcD8kX01qNM7
         s/wg/OyzrWWgRBXnw5lg+SyxNqjEEUDfZaCO2hJn8KkDlsseiTywexpU09/MimoUKa4u
         SHhiAY8hyzgZc9NPssQ1+sO6htZFSZvvosBeFcaG/rlDbYeOTCBAmvGaTxFkEJzPNLvZ
         lCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720160343; x=1720765143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Wq4Dg6ZPYZPbtDaC82FkKemLA+7PBLo2xay7aB0Wg=;
        b=n0tWbboOXP8hAd8b6ujE9dRz0YCXFhAhVYZoujWAWLgOfb26R2TVVeAYQgfSksy8ua
         IKUpI8WaqeqL6zGQW7Hm2+tIqUinzkAJ72P+5FVw9PWIdtBuvfHLZ9x9oPzKbD9e7LMT
         +9lEQ6qjvcZpotzG8ywsIX0lRSLML0sKm+Y7S/zfrbBlSTlgC/FPtZOMS4JnCYjgIPPm
         zmgZE+Qvat6QIzJoDdcmRn8mZqW9zqqZPIuqByncaUpVCyMBe62QKuVI+ZKr7jpsqNL1
         elRsj8fZPNARMkYW9ZOeynRD+2YeKE7X2j/DdhNfwwYt5t7nMH8W0Ni60bYrVD++J7cb
         IGgA==
X-Forwarded-Encrypted: i=1; AJvYcCW9Bfvc55/xkE2aBRSIJU5D+KJ7pk9HuujLZX0TOpICDoz/Eii2rDDBnfDKnezFqm5nusVk6kYnlNLlyHT2rXGt4olOltfEawdJKKiotRvz1O78v1+R744Dus3TdpEYRVyW1hwk51RILXC1PyshJZWaMaCA3hH7toStRFVhKlcpUvkochD49Mz4zfLJE11ZBkTRYN7biqx2E6FKo44OJzRQbd0=
X-Gm-Message-State: AOJu0YwsSeGfLDUektsd5bjymkC2n2MQY0a4rHo6fKyzg8TEpCb+kMxs
	ShjUST55ZhAmFViwp+y42jTVJ0I0XXoTizA5HVpHsWn3KjSQxTVTNPAlYmM=
X-Google-Smtp-Source: AGHT+IFrY7Z+uxnj1eNgnw5yoecoECUL4t10Z+SLuYa0KtqVJpHhYmqVAjCavTKPjWkykYPPtxZ1NQ==
X-Received: by 2002:a05:6402:350b:b0:57c:bec1:ff4b with SMTP id 4fb4d7f45d1cf-58e7b2111dbmr2517727a12.10.1720160342980;
        Thu, 04 Jul 2024 23:19:02 -0700 (PDT)
Received: from localhost (host-79-17-25-43.retail.telecomitalia.it. [79.17.25.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58d97c6d26fsm2398945a12.61.2024.07.04.23.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 23:19:02 -0700 (PDT)
Date: Fri, 5 Jul 2024 08:19:01 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	Jan Alexander Steffens <heftig@archlinux.org>,
	Johannes =?iso-8859-1?Q?L=F6thberg?= <johannes@kyriasis.com>,
	Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <debian@fabian.gruenbichler.email>,
	Josh Stone <jistone@redhat.com>,
	Randy Barlow <randy@electronsweatshop.com>,
	Anna Figueiredo Gomes <navi@vlhl.dev>,
	Matoro Mahri <matoro_gentoo@matoro.tk>,
	Ryan Scheel <ryan.havvy@gmail.com>, figsoda <figsoda@pm.me>,
	=?iso-8859-1?Q?J=F6rg?= Thalheim <joerg@thalheim.io>,
	Theodore Ni <43ngvg@masqt.com>, Winter <nixos@winter.cafe>,
	William Brown <wbrown@suse.de>,
	Xiaoguang Wang <xiaoguang.wang@suse.com>,
	Zixing Liu <zixing.liu@canonical.com>,
	Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 13/13] docs: rust: quick-start: add section on Linux
 distributions
Message-ID: <ZoeQVYda-AZN6PYy@gpd>
References: <20240701183625.665574-1-ojeda@kernel.org>
 <20240701183625.665574-14-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701183625.665574-14-ojeda@kernel.org>

On Mon, Jul 01, 2024 at 08:36:23PM +0200, Miguel Ojeda wrote:
..
> +Debian
> +******
> +
> +Debian Unstable (Sid), outside of the freeze period, provides recent Rust
> +release and thus it should generally work out of the box, e.g.::
> +
> +	apt install rustc rust-src bindgen rustfmt rust-clippy

This implicitly covers Ubuntu, since packages are sync'ed with Debian.

In addition to that Ubuntu also provides versioned packages (such as
rustc-1.74, bindgen-0.65, etc.), so in case of special requirements
(e.g., older kernels) users should be able to install the required
version(s) using the packages provided by the distro.

Maybe it's worth mentioning as a little note, so that users are aware of
these extra packages.

Thanks,
-Andrea

