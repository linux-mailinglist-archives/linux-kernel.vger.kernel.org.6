Return-Path: <linux-kernel+bounces-366298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6305599F364
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75041F236B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC951F76C7;
	Tue, 15 Oct 2024 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="MWbc4Tqm"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B51F669D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011166; cv=none; b=EOTyVkzDZ14UfcFwi/WK/krsOhZA0emq27zDl51+KZ1n8ziamjL8/Hbj9wFeMMScpdjkw0jfVrhcYSfJ7BoEg7r9vMD2qoc4Zk6vtpOCshQ5ehTeZ7YgSaD6z87e3q+Vm3nJVAG2kxii9eevklunn10BD8Nu49tuDmIYZ3WN5MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011166; c=relaxed/simple;
	bh=DlFchBe0I/UGPI2C1dc3VxtVPOEl3IMFcHHk+0Ay/Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7v9eSHsfshyEdDNBuckY7YsklkH8sVv+iPtd81kAGGsUjFNfyc0u5IsvqfFDaGLgYrBS5YvL41GxXXKtFz6NM4bgA7vgToRfhVxrUpGPydMToqFVzA1gUJXfe8sAc6rxYKoyANRXm/Fu8Azyz49lBH8IbWCeK+2Qa8EdOIJzZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=MWbc4Tqm; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cceb8d8b4so266065ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1729011164; x=1729615964; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n3Db9KNu24mZIxh4KZt+GqF8LG8v2I1eNvYK+pyP8rY=;
        b=MWbc4TqmvjLsBkhuFD5ShHVUAe5+kjxNDUfojK0xI10nVyxy8i6zYcEAxuDbh/Akc9
         wmjTj+BX4tlVqoMg1JY35tpcUOkKGZCZs22uYR82VYYKRUvAObxGaWA3QjN+T0/90sQz
         NaKWNg6I8o1/ogwqq6EuE8ZOZDVbC9D4KFYuhdueD9AE1KEV+NHqI+IJ1MKu8tCSQqoC
         P9xeUm0q+Gd5iXCFXeVmhVIdpSw8682z9oBwp8Z6sM7i1/T4sB+VpG7v7w0ebJqqyBkC
         WUMZwcNF/sCoZRuDRKOEShhNLJV8xQNr2jjSbjjP3eaftm9JdqodDxwaJ89eKjYsFlmS
         7mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729011164; x=1729615964;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3Db9KNu24mZIxh4KZt+GqF8LG8v2I1eNvYK+pyP8rY=;
        b=M3fhtsbv0q+i2A1QPqsnKxTdJH+rsRXmljeQX0A7n/1DSydsrGsN3EULMNqcVeqeht
         YeVSnJjGshIQZ8nG6xXtuRzoH2aEMnTqOOgNw2wU5OzNDMOUcKaQ7Axkif/utn2dZV+C
         QjqQ7Z0gC3Jm2vo5DejvTDLg2Gg68YiDDgjX+dBQN7/zqfWN21Vmc6Zy8PYUeZa+dBrU
         HdkCDZsXK4tp25PoS3DTE27xdSfvaOot5LVcLXqbZq3JcTa+DJTbFFqDfX6PFEx9Hjry
         RykaV5lixIhY1TTLaMCS4+MsAgEKHNguxaDhPtJKN7QjO/ZeNBMFaH4Eck8y9lUkh53Q
         dUzA==
X-Forwarded-Encrypted: i=1; AJvYcCWHs8ivAN3gD6/upeMksZB8bgeMJBsXo4Qj/ghyZYPYgkD4+j5YJYhgFbFMJOYU+IpXK5U50aTkq41ykRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+YxlNWlYIy6sB0wdfQcn+2rTfzivXSGm34Y6VibWUpSVdhG9Q
	z6VGXW4BBLBYjvtdfzX85lLzY9gr0n3tfOJ+Fy9c6Fg4PgCSwxq3zDc8TYU9yqU=
X-Google-Smtp-Source: AGHT+IFSlc9Do3e06c9RaVzUfb0DboIMep1CPB/fwkRtIHhmDfcSAMhRUZD8wx8h7C68xav+nrU4SA==
X-Received: by 2002:a17:903:186:b0:20c:f39e:4c04 with SMTP id d9443c01a7336-20d26f9f1e9mr17187005ad.2.1729011164389;
        Tue, 15 Oct 2024 09:52:44 -0700 (PDT)
Received: from x1 (71-34-69-82.ptld.qwest.net. [71.34.69.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f844f7sm14225495ad.60.2024.10.15.09.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:52:43 -0700 (PDT)
Date: Tue, 15 Oct 2024 09:52:41 -0700
From: Drew Fustini <drew@pdp7.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH v1 0/3] pinctrl: th1520: Unbreak the driver
Message-ID: <Zw6d2T54M2GptYiy@x1>
References: <20241011144826.381104-1-emil.renner.berthing@canonical.com>
 <CACRpkdayc=5ee_D-t_xpOe3hSNHKDYN63J_6WO0HECNUH36hrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdayc=5ee_D-t_xpOe3hSNHKDYN63J_6WO0HECNUH36hrg@mail.gmail.com>

On Fri, Oct 11, 2024 at 09:28:10PM +0200, Linus Walleij wrote:
> On Fri, Oct 11, 2024 at 4:48 PM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> 
> > Here are 2 important fixes and a code improvement to the T-Head TH1520
> > pinctrl driver that was either introduced or missed when Drew took over
> > upstreaming it.
> >
> > It is based on Linus' pinctrl/for-next:
> >
> >   6dbd1577b7dc ("Merge branch 'devel' into for-next")
> 
> All patches applied!
> 
> Yours,
> Linus Walleij

Hi Linus,

Which branch did you apply these patches to?

I don't see them in your devel branch [1].

Thanks,
Drew

[1] https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

