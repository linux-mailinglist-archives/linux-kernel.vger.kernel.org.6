Return-Path: <linux-kernel+bounces-444672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0479F0AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2102835FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2181DED6F;
	Fri, 13 Dec 2024 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oA1q7Z7H"
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684F1DE3B1
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088739; cv=none; b=MdWVWBhbyh/nG4C0kiEvD6wJ6VhLduiptaZgdnayzfWV8dwhAFEv3We5ce2/QBb94vjb0cGjEXmX6ctQiKlgH4XTv34+j40Ej0sl58LHyFRoVhRbuxB0XyCwQUgTHOj94wieTVmxlUkhbt+mTz9Ueq3nUY5Q4JPNL1MKWGhowqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088739; c=relaxed/simple;
	bh=4sWUtOjeYmhgS7vSba/RGHfcehHVoBrgsxjqxs2uKZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYMN9o0+MEBp9BRja+S1423xQ7AZJVQlH04NuDmGx0Uwu0B0lF8JklYDmzJhJGFTlwQplFNZSDW3QygqYlfJN9g4GHMW0PL5rfTDVswJzgwbqtx3w1HXykvqZ71DnsCNGLEf+clkXhmChwJquXTJ/Adn/kRZXEseZUaOTYrQ+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oA1q7Z7H; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-aa670ffe302so301230866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734088736; x=1734693536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SOH0ZpkdRhKcY2RdyrG5izzazJLX5YhFQ9ww5KfiGzQ=;
        b=oA1q7Z7HKz9YyAS7uruOze5DV4+jvXINhKSNu65w3rVRRjJuYzZbD2r3b5kT8fMlwN
         b+LPqWrS8LBv28jfLuMP6KvifDHAtWpBUumYigybBHdFWTTn2pz3KzZnsCpsYCppHNxL
         YSJy0pPH+9v+CMxwk+jmlgGCJFGHCdjO2WK6tymuwRhCHhfQ1oV0vTz77pkKBX6PUie9
         ZXEwDEyTdQEcG6Qttx8+2znTpZLAuvW+wJqZwADfqzWVLOf13l3TBzR1v3RjhXJes7+t
         kDyraGzZ7a6ttUOKHQTE59M3nEUWtnt65C2Y26VAsNe0AvbitRWyljgk5i6c+PITcLlC
         MJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734088736; x=1734693536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOH0ZpkdRhKcY2RdyrG5izzazJLX5YhFQ9ww5KfiGzQ=;
        b=hSAm+TBhQczzrVRXquUKOXO74AHwNH+f81vMXL/0CXsLNoeLEn4UDB5jwNSmm2zwPg
         PMnU+D+Z2vPsHoyuTUeVAeLCsBifNAGKvKLobiHlZdGZ6Gn/ETrUQe+jVPKTmdFKFF5t
         lQR/Xvcl3YrE5kTXSVvks11XL49TxQgHBNsyac575u1HvOeaOFw/cVu4g8/Klti5nKSY
         23meU6dg9SnIWmQ83QGq6zwcZyH+6UhG7UE/+ckcIb8iBHPGIQ6v001W/BAaK6q5uhgG
         QlRaJpbSnyllKevWROGn3ce19cbsuL1xYlYu6sgHgBpVGjcF+8u6eKkral/lFausdoTn
         gETQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl9WS79eZCM3p6uyMRxR0qLhwKUyzEl6HN960Cw1S/bJQ9xpU7a0rnO+DtitKlkh5PDYmkS960nXBehrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/koPK0jN6BZgoITS33Bl/y5ouwbAnWmI6zrOBhBZBL9OqeUre
	jPpVf32XzuU4YjjNoKSplCJ0DNqyjA1Y/TfZtZRv1hKrudF7DtORwXf4OSYgVu8=
X-Gm-Gg: ASbGncs1Bg7K+Pus0BvkYQOnIq9FV5b0trpMmgn+1VAPV2+u5JztATCKAY3aoaLbFkB
	rdO3i8qTw25zba8DCVPXpsq+nYLw6HMwMhct8cr2nEX9mrCoWiIy+XkAaVFAd/MdSTOHTGCIK9x
	K6EyN8dcLIcC/kkzjVfZ4ULFGU4ejwrZq5Wt3frRevvJiOqOQQSjnNzVvb/s5ApRCTrj5Rz1JA8
	rcOldohUqH4JXDYS8nS8z54NIO9dbVT7pQ9ofO7TJb+G3pRXoSYOFIXhlSut09mJg==
X-Google-Smtp-Source: AGHT+IHCNFIusKuDoVAQrVy2w3RyEGZxyWlRUmcQIBaYG0LZ5xafYNpj5fwC5H5p5Q6bHAeD7wm9rw==
X-Received: by 2002:a17:906:32ce:b0:aa6:b5d8:d5c2 with SMTP id a640c23a62f3a-aab77e821e9mr229783666b.41.1734088736131;
        Fri, 13 Dec 2024 03:18:56 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:998:492:1e8d:6193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6705a566dsm824777366b.162.2024.12.13.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 03:18:55 -0800 (PST)
Date: Fri, 13 Dec 2024 12:18:51 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: usb: gpio-sbu-mux: Add an entry for
 FSUSB42
Message-ID: <Z1wYG8gpdFEvHCI3@linaro.org>
References: <20241212-x1e80100-qcp-dp-v1-0-37cb362a0dfe@linaro.org>
 <20241212-x1e80100-qcp-dp-v1-1-37cb362a0dfe@linaro.org>
 <kq6qjrynlbqgz2ltdap67lsbehmzuudjhbhyjymy26wlffol6o@kggtwtbujilf>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kq6qjrynlbqgz2ltdap67lsbehmzuudjhbhyjymy26wlffol6o@kggtwtbujilf>

On Fri, Dec 13, 2024 at 12:07:35PM +0100, Krzysztof Kozlowski wrote:
> On Thu, Dec 12, 2024 at 02:08:23PM +0100, Stephan Gerhold wrote:
> > Add a compatible entry for the onsemi FSUSB42 USB switch, which can be used
> > for switching orientation of the SBU lines in USB Type-C applications.
> > 
> > Drivers work as-is with the existing fallback compatible.
> > 
> > Link to datasheet: https://www.onsemi.com/pdf/datasheet/fsusb42-d.pdf
> > 
> > Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > index 8a5f837eff94b27bbd55bfe45f8d1156e3d183eb..e588514fab2d8c9d0d3717865fe2e733664fc28b 100644
> > --- a/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > +++ b/Documentation/devicetree/bindings/usb/gpio-sbu-mux.yaml
> > @@ -20,6 +20,7 @@ properties:
> >      items:
> >        - enum:
> >            - nxp,cbdtu02043
> > +          - onnn,fsusb42
> >            - onnn,fsusb43l10x
> 
> Is it different from onnn,fsusb43l10x?
> 

Yes, it's a different chip:

https://www.onsemi.com/pdf/datasheet/fsusb42-d.pdf

vs

https://www.onsemi.com/download/data-sheet/pdf/fsusb43-d.pdf

They are probably quite similar, but the fact that the usage/programming
model is compatible is already represented by the fallback
"gpio-sbu-mux" compatible. So I think my patch adds it correctly?

Thanks,
Stephan

