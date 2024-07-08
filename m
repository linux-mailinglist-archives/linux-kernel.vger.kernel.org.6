Return-Path: <linux-kernel+bounces-244223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE1792A10F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B85B24561
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908880BF5;
	Mon,  8 Jul 2024 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dCLPOwpN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579917FBC1
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437950; cv=none; b=K5fXGPFtfJuKeV9f1b6RUZVuTsLqQqUTnO1QRh3p9NQPPoppBt3hMSqKmwHIv5TEtDdP6RX/fH3uE5o+XonKDeKCXNZktnzXGHfEFyZzhqvPi6KaEUlWSNlZEnPHEJHFJfR9y8+++MrdR8GIXdAhYDQc7dJmk+1eRRgwQMqHJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437950; c=relaxed/simple;
	bh=iKpwXvhbB0qXDjkBNWkywakk5y4ndG5jn1tceNaYV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxfM/EjvoxIS3xCaszRkH3M3/oYMMkdvem64FvZbZifL4Rkmh5U5DdsbAm3p82Gg15w3lY8QSsYzETw5r1LxneBnOl0TTo/7hYG96ebvtpd2JdT4IZTP9RUKLTBl8lwgEcoNjsbn8ph9lrGvba1UtjKJpYN2K9Qydg7gelJNZ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dCLPOwpN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720437948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxDEKjje7ewX3dmdPxps0vgNGDNpfSpWeAQAGsyxyvw=;
	b=dCLPOwpNpG7bb4Kzrl9/8A83rOHGr65xPZyvKuAcDwIfdHpGY8D22beOoZUgx5cmdKfIqN
	2yBjB/p2I4UbSUz86wVfSkiTaGe3qYu7RvUQCLeAhA2HGHzt/ArATdTqTGBlJOS3KfeJ7I
	BNuORW8ZhBRSvC4dxaBMmsOJ/oXQ/rY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-iFQmSQZnPbOo9Yd9xvSVJg-1; Mon, 08 Jul 2024 07:25:47 -0400
X-MC-Unique: iFQmSQZnPbOo9Yd9xvSVJg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4266d0183feso2913405e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 04:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720437946; x=1721042746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxDEKjje7ewX3dmdPxps0vgNGDNpfSpWeAQAGsyxyvw=;
        b=lKxIpgliFhVXHMvBdd5OUF0OJH5V9SqTbcu2tFC8WQGJ+HWbm9kuj1BzmRrJoRZhZE
         IBigxxvkbmLnN3DMHeKUSVfcr3PdPUjAjvu7pMQzB3069wgO/W2Fz5eS2zTwTM113oJX
         Co6kFEW40Pa09juRJG84cW0OQRVocymqPU7XsQMwLvUVe8Q/xszCQ3JGzLJVO5AhV2Qs
         A3x1ldYR8CzRbfdqIzG/8e3f3Zu7+VFWfP2SL/HZdk9bBVN+jXnrxcDInCih/U+4WUby
         zmsiOjEPt40b8SwyvQV61OgB8IGVN3mfgbYw2MXV9Pi5NhrWWWQQSdoGVeslrzefzZjo
         9l9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPUFcuoKU76+CRKpvD7QHF1BbaUspfmwO2cuqFaUgBIW9wKqdqbPZgtc/PRJx5zIohjA6IXeKQ91BEM2wuLtrpPqpksugfENBtDxOA
X-Gm-Message-State: AOJu0Yz9cC7fF/gCPWy7jq+QzLj5XYZmH9uKMx6y2F+fA6+MZOooRRC1
	G/t6Rnw913Tc7ic8KcceQtSRm+ibLx8jkxmBfu5UUK5xeuqUI5mR5yl4LqjLSqchX437PHqGRwq
	Ij8IAH858kr7fOcKkn94oNwZORLINNknzVzFTHXP3NfyoyJl7gheUqAu6kVY3Rw==
X-Received: by 2002:a05:600c:5493:b0:426:6ee7:c05a with SMTP id 5b1f17b1804b1-4266ee7c253mr768245e9.15.1720437945912;
        Mon, 08 Jul 2024 04:25:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFleDfM0VAI2FqOfDLpFDYDHHTu1E1XX5kKYuAnqPX8YzewfdIeXDRmz5P8FtyDaahi97NdSQ==
X-Received: by 2002:a05:600c:5493:b0:426:6ee7:c05a with SMTP id 5b1f17b1804b1-4266ee7c253mr768125e9.15.1720437945583;
        Mon, 08 Jul 2024 04:25:45 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a1dda61sm162052725e9.19.2024.07.08.04.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 04:25:45 -0700 (PDT)
Date: Mon, 8 Jul 2024 13:25:43 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: firmware: fix invalid rustdoc link
Message-ID: <ZovMt7AHJdiGEobg@pollux>
References: <20240708090615.2267476-1-andrewjballance@gmail.com>
 <CANiq72mB3hA6GeN2XSqRpV4m+rCbr2+NLHgmfpphjm1Wo1wBBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mB3hA6GeN2XSqRpV4m+rCbr2+NLHgmfpphjm1Wo1wBBw@mail.gmail.com>

On Mon, Jul 08, 2024 at 11:16:34AM +0200, Miguel Ojeda wrote:
> On Mon, Jul 8, 2024 at 11:07 AM Andrew Ballance
> <andrewjballance@gmail.com> wrote:
> >
> > rustdoc generates a link to a nonexistent file because of a extra quote
> >
> > Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> 
> Thanks for the patch!
> 
> I guess this is meant for staging/rust-device, but I think this should
> be a review comment here:

Firmware and device abstractions were merged in driver-core-next.

> 
>     https://lore.kernel.org/rust-for-linux/20240618154841.6716-3-dakr@redhat.com/
> 
> Cheers,
> Miguel
> 


