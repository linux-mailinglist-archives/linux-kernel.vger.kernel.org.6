Return-Path: <linux-kernel+bounces-263514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442B893D719
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B411C21EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1817D34B;
	Fri, 26 Jul 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="LN2caqVU"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3B517CA0A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011894; cv=none; b=jrdFhn40QvYtpixtMjlSJSJwim6PdB2LH4ptKu/+X/NHBjxYc3yqU7LBlltFWwliiosVlhRRNcjo6qMQBt031KEoB7a+uEi3U1cPO1w4cDz/wK4S+avj22I5b/uCg3PKiYT4CMzu8k9Rm35MccC2uTd9Hf4MQaA6Nbv6yNe2xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011894; c=relaxed/simple;
	bh=EdT0LNcW/fg+/3EqCSqFErM7Ot3ITnnmLAMCTmrP6I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnDp4pr2AFPFFmz3hdnrWGOWK8d50nLFAkN0q3ollRvedDDrH9egjORoZ8Ay4IJ1GD7urS030ZzcvXDUc1hVkpy1wQTB8WfB8luGowv6uWfgX4qBkcnsePJWxrw2skYhYL/Owu4X5xL1DEJ+9Hr+JX+M47PMKjeqsDtNKRdULbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=LN2caqVU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc658b6b2eso7272835ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1722011892; x=1722616692; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a0HpN9HmDodrUSDORXqRofIB4AnVMlhB5oPbGsDNiZk=;
        b=LN2caqVU4451DdiX6i4QfOnjg3dGSMeGIxUlre8GSx1JCcC4nx7Emok8jZTfOaJ4qK
         6UFzWawjgCm08F9ztkOl4PZrx4/t5wMuTEQesDzydCNA11+4eKisbRuYs502jOBXqt8m
         tlacK6KfDDt2XfKtQioBFC8vmrOs+OCxrc7DxKZFXagHpsqjJbZLplGwXAE/hZUCnkMo
         uV5FJbVIO02eYttnCnJISB463vdwopBvACmA7bx0Nlzv8kye7v/8rAzJgAPCHq6g8Sg1
         5aJxhQay6pdepFnUs4RA6HfPgmjroRjI8fQYnc9prcJ/DiqBYM28MAc4QqLkHUXHBn04
         Rm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011892; x=1722616692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0HpN9HmDodrUSDORXqRofIB4AnVMlhB5oPbGsDNiZk=;
        b=cCEpEjckHW+2r9PuPm0rtbpIeh06XpiSXXCYG0FrRll4lAkulHMhVE+Fz2DHeZCo81
         wghD7XSDGzSOpuHCmaNJceIoQQQ/+dJKTxHYcYu4yDKmlO3eEmhKIVvzfMGjA57Ke5Eo
         1PCVvi6EYrqgdVtFr3tfHSLVteWGT+9ygc9ra0eW2iXL3I90d3pruqiZ8pStfITPyYHg
         8Y7AosodrS6W22pdfrMvFzO9B+ixWzmRSbaav2xBkoSgIvSGWWqZUp51me8LxaXuSGD9
         yrBlgWKcnPyctf8hVPxEtDx2T3Z21Lq7NAKjg/D3YbUpxPvV3qCSqxjMwNbf9G2CDnil
         qylw==
X-Forwarded-Encrypted: i=1; AJvYcCVL7G7vfTw72VKajGpS1iSduS5ZGhph7fOETDpFyM7wTcKc0AWY28Tx0pey6EjpjmTR1W54yxHfQ4Ruk7g45JtJvNfvYIYA0PO9zyWj
X-Gm-Message-State: AOJu0YwOrqGEKfG4XQNYlX0WhlwufdBdewL0KLNFgl0cU5HerTneAmEU
	m0+Fqo5oImAOWSTpLauTZb8jw1On5eULPAWtHtMwkI+6aZWuXhx4MQweRTDxIxI=
X-Google-Smtp-Source: AGHT+IGgSdGMTreHVjBjvhyywbGtPKuHA78vW4E4X9Wxkh8LiuFv+1u6kKBI9jhD+IpTldIfmpl/Bw==
X-Received: by 2002:a17:903:234d:b0:1fd:80f0:e859 with SMTP id d9443c01a7336-1ff047e4564mr2287615ad.2.1722011892159;
        Fri, 26 Jul 2024 09:38:12 -0700 (PDT)
Received: from x1 ([2601:1c2:1802:170:dd1c:823c:f5e3:153f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7edd91asm34682265ad.131.2024.07.26.09.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 09:38:11 -0700 (PDT)
Date: Fri, 26 Jul 2024 09:38:09 -0700
From: Drew Fustini <drew@pdp7.com>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Drew Fustini <dfustini@tenstorrent.com>, Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: clock: Document T-Head TH1520
 AP_SUBSYS controller
Message-ID: <ZqPQ8X51S6PrzQxI@x1>
References: <20240623-th1520-clk-v2-0-ad8d6432d9fb@tenstorrent.com>
 <20240623-th1520-clk-v2-1-ad8d6432d9fb@tenstorrent.com>
 <57ef2eef45f2de15e6607da266b37b2a.sboyd@kernel.org>
 <CAJM55Z8iF8yV5JK5v6ZtQqS5AaWwCZ7uwhSYb7hdxh0juDFdqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJM55Z8iF8yV5JK5v6ZtQqS5AaWwCZ7uwhSYb7hdxh0juDFdqg@mail.gmail.com>

On Fri, Jul 26, 2024 at 03:45:36AM -0500, Emil Renner Berthing wrote:
> Stephen Boyd wrote:
> > Quoting Drew Fustini (2024-06-23 19:12:31)
> > > Document bindings for the T-Head TH1520 AP sub-system clock controller.
> > >
> > > Link: https://openbeagle.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf
> > > Co-developed-by: Yangtao Li <frank.li@vivo.com>
> > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
> > > ---
> >
> > Applied to clk-next
> 
> Thanks, but this driver seems a bit incomplete. With this applied the Lichee Pi
> 4A no longer boots without the clk_ignore_unused kernel parameter.
> 
> /Emil

Is this the case when you apply the dts patches from this series?

The dts patches won't go in until 6.12 so I don't think the presence of
the clk-th1520-ap.c itself in 6.11 would break existing systems.

That said, I have been using clk_ignore_unused. I had been thinking that
made sense because the full set of clock controller drivers like
AON_SUBSYS (always on), AUDIO_SUBSYS, DSP_SUBSYS, etc, are not present
yet in mainline. However, the T-Head vendor kernel does have drivers for
all those clock controllers and I was suprised to see that the vendor
kernel fails to boot when I just tested removing clk_ignore_unused.

As for clk-th1520-ap.c in mainline, I'll investigate further which clk
disables seem to causing the boot failure when using the dts from this
series. I suspect I may need to add nodes that will cause the necessary
clks to be enabled by their respective drivers.

Thanks,
Drew

