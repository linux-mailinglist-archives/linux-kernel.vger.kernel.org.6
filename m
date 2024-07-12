Return-Path: <linux-kernel+bounces-250893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E7292FE35
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D95B238E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6017839C;
	Fri, 12 Jul 2024 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="kw7nw1SW"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7531B178386
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720800348; cv=none; b=Dz9/2YgN1VA5+z+j5aBqoAIfA31aqkh2s4nTKV1qMEwRzURMSxrUcwi/B0bsQ6IKRIyuea3SkZ7hZbIR9RCipt2KsH4GjDwYaadP85IwELVHujrLxJpCgC2pRDDsea8L5pZriPw1lmeEuJRPyKPGq1oX+EonjBE8NCiItcfAaXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720800348; c=relaxed/simple;
	bh=17sio2ZhmsqlAE1DZIk02yifkOUU1ZRs/pDBLf3fjlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4j3/hQPlkMRQpvLR3nQWw5H3chZ5GzLA//ENzMB7UE0vIjeZSmbLCI5CgQvPVvE4r37/ySAZWSfDz+7zoKrXHto4qGtO5SJmCG3f4eahaV985vZrBsiuPPai8e9OT02iXlF1IROMP8bvd10pvYihDJgvRmnQrPB/DFHzTmR3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=kw7nw1SW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706a1711ee5so1761313b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720800347; x=1721405147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tVEDV1iMAAfIFvW/+wvdACc3/PqlD9+6N+4kH9hopjA=;
        b=kw7nw1SWv+wNQZuswpSv9+HCWqT4Y+ZzsZK9va9CDQjIo+ryT7ldLvkuEPNimo55IS
         jVTjz+4v0ukbHZk9l05XJlc8RivrsLoDcA9EuYbrbcsNcTVoricEa+r9ayC/9d6FHq8E
         SJgENqigUJzEyPywpswXb3DViKmyOgGfBfRqSM2y18Kl7afl/9/l5pKz3QekEkGCdnT6
         ZfD3plmnekbOqJbFiKBWEmCScdDAyQJO60Q4LWLwTMK1z33i88td8ee7hIAF/TM4ckn/
         bAVyVe5LOFeLnHpCjpHlA+SmWYs0OdemPXaluss/Hr12JDmh4mhGmcnqY9dPlaILW9q7
         0rVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720800347; x=1721405147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVEDV1iMAAfIFvW/+wvdACc3/PqlD9+6N+4kH9hopjA=;
        b=B7vUTKVnVBNJpVOeZLgzQ7a3wyK0UvrCKWRY9ysjhdldOPGG5uDqzglYJZesYc99He
         7jpu617U8VEeOE2sIGBK+Fh4VOqKIy/+PnZLZPq0TmZnXx+uKwqvUB52KcFji4Ru8hSI
         Fxh9TBKdwACKCchvvhdcooouU1b4SP/9My3h8cT6iHBkB111U9rQ6YKMMe2sxj512j0i
         1GSKBo1HBCSrFS5Ptu8RoeLlY4IYcsr4xnjX4nz/Yo2vohYO+G3aQZOeOhkF6j8LgR6X
         Ijbfi4w521T7IpDNhY4BylpT18v0qxPZtgpvg6IAf1Wp1wwn96Zzjq4FpAtwFp26FBJt
         8Ziw==
X-Forwarded-Encrypted: i=1; AJvYcCX3X3g6e3jqL9Q6SteMsf5tjRGOYlTPPUKDdMKVV8VghVo9LJWM6D29Hr7JZkEx7D2UBJ4jg77iDh+16XJdiYMGEuNOk9A8ybqpo4Bi
X-Gm-Message-State: AOJu0Yx80r+dLhChuqDyCZfP9HQ1IOLPeZqgZ4vDJbx8EAY5MhK6Y2AV
	K7HD2LVZqkzddKarR6Pg+WnmlmKR20v+s6qklewtVsG58QKkDy/u3GN79FuPrjw=
X-Google-Smtp-Source: AGHT+IGKYJDZpE2qytnY2B2zgOVQ0LmknywmMQBDC+167zUbGSI4bhyIw6ryHaK7vauAHXZnTY8yLA==
X-Received: by 2002:a05:6a21:99a1:b0:1c2:8e77:a825 with SMTP id adf61e73a8af0-1c29820ed74mr14226594637.3.1720800346753;
        Fri, 12 Jul 2024 09:05:46 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:c949:fd63:7988:f01f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad55b4sm68571125ad.293.2024.07.12.09.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:05:46 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:05:44 -0700
From: Drew Fustini <drew@pdp7.com>
To: Conor Dooley <conor@kernel.org>
Cc: Kanak Shilledar <kanakshilledar@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] riscv: dts: thead: add basic spi node
Message-ID: <ZpFUWJ9ujDyeGORh@x1>
References: <20240705093503.215787-1-kanakshilledar@gmail.com>
 <20240705093503.215787-2-kanakshilledar@gmail.com>
 <CAGLn_=tT08KUX0J+WURq=EXKDPj=--Wg3qmCjnzGxNeMcz3NOg@mail.gmail.com>
 <20240712-denote-disprove-ce271b70c78c@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712-denote-disprove-ce271b70c78c@spud>

On Fri, Jul 12, 2024 at 02:48:46PM +0100, Conor Dooley wrote:
> On Fri, Jul 12, 2024 at 02:11:18PM +0530, Kanak Shilledar wrote:
> > Hi,
> > Any updates on this patch?
> 
> It's too late for 6.11, it'll have to wait until 6.12. If Drew has his
> tree set up already, he can at least queue it.
> 
> Cheers,
> Conor.

Yes, I'm in the process of setting up the appropriate branches in my
tree [1] and then I can send an applied to for-next email. The plan is
that I will send PR to Arnd starting with the 6.12 merge window.

Thanks,
Drew

[1] https://github.com/pdp7/linux

