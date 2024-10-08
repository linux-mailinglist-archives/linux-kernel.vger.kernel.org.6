Return-Path: <linux-kernel+bounces-354923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2819944A6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71336B23E38
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 09:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C521A18B474;
	Tue,  8 Oct 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQRcQJfm"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E135B320F;
	Tue,  8 Oct 2024 09:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380802; cv=none; b=kJgQcLFgxWDbY3k1InYRGACwAcFIZtl6Lb3YoP6Mggrlmxl9wuJLpNLVCvHPyDa2kiL8F/HB+TYc7nX/JsARKtzI/faawEVTiO0EiV2U8fpx7Da8hytLHN/1PuVLayG9+JbElHz8uzIJVdJIQqO09yRSPD8FHHo10Wl7mNhZu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380802; c=relaxed/simple;
	bh=mbxaKriv1B4xY98uVlE+Uc5qQYrVpope2MgKGwA+ixQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMebbrFn3heFxu4pnJiKV3mz6wxwi5tgCWmJ8Hq6QM/bg9HETGc4yvSCJExk27aiENQD36i3NNLCVxyqkvE9Px8UZkrR5D+kQhnqXftMBl7gizhrMgyfOPt5qH8MSuFUCK+uUWbm1kS2fdhUpm6KRsvpkNdKGL+yUD8kXZiKNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQRcQJfm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71dfccba177so1833472b3a.0;
        Tue, 08 Oct 2024 02:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728380800; x=1728985600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lNjY8hqWTpyy020a522dYm1Sd9nWVxcQw89ASfjmWC0=;
        b=gQRcQJfmWONgBRsS9A2hNzZPyTDydjwUp+yU2J02Bw2qToi/hKdWmQBOjIyKl4RIed
         3bjlLfb9aGwa8PoXGk/i9joWozWFCOZUuZWuTaw2pblkXRCHWnbbSt8CT2cRoiCbewrG
         UIx2P50spfObeXmEUTwMw4SFwtSrHLxiRAsi8YAVjxzoiyKCouUIjEts5OJWv28Oasn6
         ZePyZtTgvgaYpLGxRb/M0BsK1/mEaqSgmFbqri1mF+Wf5qk5cmxPjiE5w6/Tyy/Aaov6
         VUn22ZENi/mVW+3bJoLocijlLkO/pB1hymhYtKhBppluwhRTa8TSYlO8NPgj2i/6k4+A
         3R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728380800; x=1728985600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNjY8hqWTpyy020a522dYm1Sd9nWVxcQw89ASfjmWC0=;
        b=Xi2mzHXOoeTZus/7VQdCOV/5mdEYitiuqiNSad9nUAQNzPRkLKepN1oU9OG4diBVDN
         RHtcQ+qPUtJoWraEOHbPT6QATbuOZw6Hncddy7J98ZTQslJENI8BGAwosI+7GzWIF+hz
         D89rPg+DOpxT+hwGbOnctyKE1Z8TCcOsptCzcYOvzBx2nvjBPKadBghUhwYbO1KV/+gQ
         f8ftWCMDVW+Be3FSKTuwN4YMsPwIGOLC4AzmmgGioZ0qM+0rM7HLq058B35zTYa995LN
         o72+1nh9fmPdBImoumOh5D98sgbEpwDoWaDqINEye6rkybDUr8itOQH3tG2OiOT/4S/q
         xkcg==
X-Forwarded-Encrypted: i=1; AJvYcCUzLtWKZJ8xP35MRQtefwssp4iePC+B1EHXdrwbP0zUhmE0UZ878o/wi8pCizDb+w6leHeGMcs8cNP0@vger.kernel.org, AJvYcCVxJGbUvFVXG2GS2mVgAS1E65PIpCB75Bqm/+DktZ/EcEgqS0NKEcnCgUNARvFdsIAHIoKGcHzljwbOja45@vger.kernel.org
X-Gm-Message-State: AOJu0YxchRxixK6PrS4lHL/Hccw48FH1IeEnReE7tZo0JXf20oDXoPwD
	k4vRlBbrdJNw3EnikSl0V3gJ0zqEzYcG5BQ3h+C+GWkLwS/AuQCX
X-Google-Smtp-Source: AGHT+IEYzDN+bbU9zhSyXok1B0c1RLGC/G8QduRflQ1P15+Go65nt7wy4b8QhCP2svMd+Lb+MCPL4w==
X-Received: by 2002:a05:6a20:a99a:b0:1d7:e62:ea94 with SMTP id adf61e73a8af0-1d70e62ffc7mr1686415637.14.1728380800131;
        Tue, 08 Oct 2024 02:46:40 -0700 (PDT)
Received: from inochi.infowork ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680d8ddsm6449315a12.4.2024.10.08.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 02:46:39 -0700 (PDT)
Date: Tue, 8 Oct 2024 17:46:30 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>, Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, 
	unicorn_wang@outlook.com, conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com, 
	krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, 
	chunzhi.lin@sophgo.com
Subject: Re: [PATCH 1/1] riscv: sophgo: dts: add power key for pioneer box
Message-ID: <klah6aevo4tr2lgrtsn6e3yoay6qjr2hpfmepjz22alsthd3no@p5r5tj3k6xx4>
References: <cover.1728350655.git.unicorn_wang@outlook.com>
 <12e65a99f1b52c52b7372e900a203063b30c74b5.1728350655.git.unicorn_wang@outlook.com>
 <aixuis25v56xwnc6zd2ost5yhho5soznpa2pf6fya6orvwwke4@6n3nhzrd7kio>
 <0cad37dd-772e-4dc2-9943-a473bf21d55a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cad37dd-772e-4dc2-9943-a473bf21d55a@kernel.org>

On Tue, Oct 08, 2024 at 11:28:24AM +0200, Krzysztof Kozlowski wrote:
> On 08/10/2024 07:18, Inochi Amaoto wrote:
> > On Tue, Oct 08, 2024 at 09:43:52AM +0800, Chen Wang wrote:
> >> From: Chen Wang <unicorn_wang@outlook.com>
> >>
> >> There is a power button on the front panel of the pioneer box.
> >> Short pressing the button will trigger the onboard MCU to
> >> notify SG2042 through GPIO22 to enter the power-off process.
> >>
> >> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> >> ---
> >>  .../boot/dts/sophgo/sg2042-milkv-pioneer.dts      | 15 +++++++++++++++
> >>  1 file changed, 15 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> >> index a3f9d6f22566..be596d01ff8d 100644
> >> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> >> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> >> @@ -5,6 +5,9 @@
> >>  
> >>  #include "sg2042.dtsi"
> >>  
> >> +#include <dt-bindings/gpio/gpio.h>
> > 
> > Just move this include into sg204.dtsi. It seems you forgot to
> 
> sg204.dtsi does not use this header, so why it should be there?
> 
> DTS does not differ here from C. You include only what is being directly
> used.
> 

OK, it is my misunderstanding, I thought this header is binded 
to the GPIO device. Let's drop my advice.

Regard,
Inochi

