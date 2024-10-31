Return-Path: <linux-kernel+bounces-391439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980CB9B86C7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D366B21D2F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03501E0E03;
	Thu, 31 Oct 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FU7/VamT"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C819F430;
	Thu, 31 Oct 2024 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416418; cv=none; b=moNNgNHZtazxzmlb1jc4AsJ/GOqPpX/a7jxSOm7OY3UbwL6QiABtasx4e6x88iF912T+XOXHMrOqvZRIz00i/ej+xTBgPzvcWWgd5vHxXNa7GTDL3aUD51pLUdrWDjTyHRSH4aAsBb8EpsTlvKnxpm3r7ZEpdnreEspsM2ZQlH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416418; c=relaxed/simple;
	bh=NPEe7PrssaZbZ3xTsE8DLNbNq5rGbhvcLwckuu5NZZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GECi45UB7JW4iH2aEZSxYWo9QFcDhJpXB/eNpS+XACsi/V0MQcSCxHf+BcnhNJiNydFIezq0XAc0AIu8Esky+ERAkJ4VU55VnDquHayyISC2rgZ8ovbT1eS/iWrF1GoSxPFlfbHekxlNcv2NKvhOXTuZEz4d1THLvPWX3C1aD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FU7/VamT; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso1059445a12.1;
        Thu, 31 Oct 2024 16:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730416412; x=1731021212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii0kEwrxMeKD6ai8F4P/+h5BX5m5f6101kjzvcy1Bp8=;
        b=FU7/VamTgmuNidNrQYg3euUbcRtz5bsz6TB1LMn5zIRW839pkxMwhEMZ1nXXpRDCXG
         jSVOJSEP8TDPQ4rO1VBmj8Ekd9H8G0RsSWrmWYxMZLWZ07Tdz+7ftc5DyEd0CKLOkH/g
         XlbPp7uTTvyXlnXeQx2G8WsJWVNbdAChARZ1t+qqwgC9V8+hlX5HjHustIWGNa6nr4H0
         gms4kA+ntOoyGTWzGJTM9FT++3+oLXB3Bw0FDQOrNePkWZZnsd+iJhuqxfG8DEbFM3h3
         7g+PhCxSQJdrmomCg1+lFr3X6QNaqDE9tcMoH1KeHa3gbT5ewcEO7tzJltVXs9A6V6ES
         dUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730416412; x=1731021212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii0kEwrxMeKD6ai8F4P/+h5BX5m5f6101kjzvcy1Bp8=;
        b=wRYN2On+Q/oxpi08/gIW1DA91hEtNgdOpTkJ0vUoXFqZ07alb+4hVNLwxYluP2B7Aj
         Q7ueQZvX/5LKd8Ho5SjEFnbOs3djd0gEvZ4/ORbyMLmq4wvZpzWdIyKxKHHO8CjT3qz0
         RuKuy2qIFqGzIb1StIZPTbdPfxi6Jv2wEr0ktj6Jl0EQZ0GmUuP692xnW6g7hoAK80bu
         AjgWnfaKRhhqya/KEXuMhpv0nzZ3R1t1771RNCPQLP4IYsje/dEQ4U3hiA0/jYrj+99D
         gxpU4S24ibr/0bkKUxpdCLYlVPevWc3zytF2ry1SYg1/LghbIAom51plRUg3tGTWuJqq
         ru+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdwTXpblTakw76hNF1vrSEHaojGwkcty4ZFLgtMoIGsZsMk7t4BACMGtD1/0On+o73Y6RbR0AR6RLjg9K3@vger.kernel.org, AJvYcCXNJs1qsAjmoKPeqpzyTWVC5U2ff42Vd46mahGcJIZPBBPew6J/53UtphC6lq0vp9FNELj0HtR5TH1d@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLC+ckQWpgdepQsxNozDj95Crt7g9ZY+lTppCUm1DEzjlHDAH
	k/Bb3LbKjpN/kMD8jktuaPr+0iyJ5GhkJiZN2ls+mBTCL7r7/EtP
X-Google-Smtp-Source: AGHT+IGT9BughKRRNW5nz1IyDJrjjO/pXrWdnusD1MQeMuR+s0APSOVSBqdDkMHvxgC5e8Kip24JwQ==
X-Received: by 2002:a17:90b:1c10:b0:2e2:cef9:8f68 with SMTP id 98e67ed59e1d1-2e8f1059571mr24207222a91.4.1730416411738;
        Thu, 31 Oct 2024 16:13:31 -0700 (PDT)
Received: from localhost ([121.250.214.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa57cc3sm3936055a91.32.2024.10.31.16.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 16:13:31 -0700 (PDT)
Date: Fri, 1 Nov 2024 07:13:03 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, Conor Dooley <conor@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Guo Ren <guoren@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Yangyu Chen <cyy@cyyself.name>, Anup Patel <apatel@ventanamicro.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 ACLINT SSWI
Message-ID: <tjoe7t45tbogrjmyip6lhkqprpc42mkmgysb7xinoreehsgnz7@uqqsp6llevy5>
References: <20241031060859.722258-1-inochiama@gmail.com>
 <20241031060859.722258-2-inochiama@gmail.com>
 <esuteqvz37blehx6wa5cj5ixlglcbullhuls3rcvjtuiviqqpb@ojho3arlnwst>
 <20241031-armored-marbled-36cfb6d599e3@spud>
 <87ikt8wh8l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ikt8wh8l.ffs@tglx>

On Thu, Oct 31, 2024 at 02:10:18PM +0100, Thomas Gleixner wrote:
> On Thu, Oct 31 2024 at 12:38, Conor Dooley wrote:
> > On Thu, Oct 31, 2024 at 02:14:40PM +0800, Inochi Amaoto wrote:
> >> On Thu, Oct 31, 2024 at 02:08:57PM +0800, Inochi Amaoto wrote:
> >> > Sophgo SG2044 has a new version of T-HEAD C920, which implement
> >> > a fully featured T-HEAD ACLINT device. This ACLINT device contains
> >> > a SSWI device to support fast S-mode IPI.
> >> > 
> >> > Add necessary compatible string for the T-HEAD ACLINT sswi device.
> >> > 
> >> > Link: https://www.xrvm.com/product/xuantie/C920
> >> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> >> 
> >> Hi, Conor,
> >> 
> >> Could you review it again? I have updated the description of
> >> the binding and mark the device is T-HEAD specific.
> >
> > Only thing I would say is that
> > title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Device
> > should probably be
> > title: T-Head c900 ACLINT Supervisor-level Software Interrupt Device
> > or similar, since this isn't Sophgo's IP.
> >
> > w/ that,
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > (dunno if Thomas is willing to change that on application)
> 
> Yes

Thanks.

