Return-Path: <linux-kernel+bounces-518944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C6A396A5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426123BB4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C022E3E1;
	Tue, 18 Feb 2025 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZZ2ki4+Z"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A0B22DF92
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869116; cv=none; b=unt0yzf2lPWw2Oz1dXOyQ0MrR9+xig9jrOT1hEUm9Od6/7LFWlU2Uq2N5EZ+s85uX/ZvDsWduxyepL5PNGco6JR/Tj/76acJyVZsyADdQRiLXJcWQHqF7H+ngIdQRr4MIlvcP6B9yMOv1yUmm7dfRY1P1F9qFOB3qHzVIzTN7og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869116; c=relaxed/simple;
	bh=Gf1I336jgiBsKtK6Xe3UxKCB8/iP1W2mCBQ9k2mDag8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpFDuFsTfIh+twOKyT41m0liF6H5xwjUb9j3s24XziZ7WY5MpuBrwRVGUebp1C/U5nh6bP95zi+SYmKALsiie49CGxT0vRpD73vPg4w8qMM5KLkZwQFm9mklNKrDtjR1WVHKnKvpr3Vdz76bZ8xdfGJhR+pkjKYlrifeSrg7/AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZZ2ki4+Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-220d39a5627so75040585ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 00:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739869114; x=1740473914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qqCVPwdqyK2Ili+2+zXGFMWFYgYIwIsQtKu/VjLpL8=;
        b=ZZ2ki4+ZluLnIrI8lGhVWfzy2c4QRjXxsq6o4smOG6YXKiwMtI4769jQ/eUySaXbip
         u7PCqorrd/xBE3GkM4sbwyf/lzw0SffuZagKspjRcxPs/SgaQNjcwkaaCYe5fMx+KxWm
         g4nYs3zf+ZZAuYPpHP5gqF9BWTCn6URDFtb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739869114; x=1740473914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qqCVPwdqyK2Ili+2+zXGFMWFYgYIwIsQtKu/VjLpL8=;
        b=f50URl4OfnBVMD/jLwtgbipbnP9gOG2D+Zxr7JRjMGmjUrjnRu9S7wc6gIMOS0mz9O
         XfeSvJ5KNNsQhKZvlC7PmY5b2tGZopY8UVQ4QtuTUNqD9/ZKn581ZbdGDNgE+eQtwdbD
         TbhMuT9G5z14Y9PK0hHYECHomf2l5JsPiF/Q6950TQY/ClOsNWeDAxTs27xpIsmKDXM9
         YXDeivSn5kIPwQYFzMlh4L5Z5s7dHN1Elj5uyMnaFv/KGos/3/xLAPx97k0zeu7rzpSu
         WDg1NDS59o4wrFE9Huxe8X7nj0OGwDVct6BzVA4X694NE2cVcQfGC9dHFZ0JpqVGiOn6
         x49A==
X-Forwarded-Encrypted: i=1; AJvYcCVo7SEot+rI+S0L/xAJW61+gHyY5hNLtbnHl1dg1b2CAyIBvJQV16VJUcJVzA5na21GJ/ERSTXOmbGlD4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5f+bfh+rcA1+HS+vRmUxGZjHIFokuJFM+NpwaC/oOcystgmJ
	pEU3UuR99HBtdsH75p+1PhU0ZFYhQ2htNnCMsov/VbAKrORXITx5EeFYftxGpw==
X-Gm-Gg: ASbGncs9UNKrFtUyWCra8dEmhIYM9e0TibOGLW6fLirL8ws/MSY3o8TRBr3NMWfAfdC
	nTs+zfksvTKl7STWpKf5H93WTn4qiD9bfr9Bsnb8Dpg62fyEqVNwLFgxdpYGjuk5fnBuTk8pejO
	0Hso8pcf0w+uf4ARAyva1NACAxXRkxTKg/aGQ8zCIsmjrQvqnDerO7BjNNkP2KWtrCYE0K8P+EZ
	ML0OfzkXg19430tU4YvEwkS3F6mpRgJcMDjt36PxmmfpE37gbKMY+n+Tesl+6rUrjjtryPhS6PJ
	+cbwUyj01CL7RefEZXI=
X-Google-Smtp-Source: AGHT+IEEOJtMg2r+ExCu5k7nAqe+yfuyqpapvJqV+nJnjxWfgOfZJYnuiAmofVtL8kqiPugF9s2+qg==
X-Received: by 2002:a05:6a21:790b:b0:1ee:a914:1d64 with SMTP id adf61e73a8af0-1eea9142045mr12447625637.28.1739869114293;
        Tue, 18 Feb 2025 00:58:34 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:e8b0:5a6a:30d2:a33f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae1ee4febb2sm828296a12.51.2025.02.18.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:58:33 -0800 (PST)
Date: Tue, 18 Feb 2025 17:58:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	linux-kernel@vger.kernel.org, johannes@sipsolutions.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, dakr@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, pmladek@suse.com, rostedt@goodmis.org, 
	john.ogness@linutronix.de, senozhatsky@chromium.org, quic_mojha@quicinc.com, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com
Subject: Re: [RFC][PATCH 07/10] printk: export symbols for buffer address and
 length functions
Message-ID: <20250218-175733-neomutt-senozhatsky@chromium.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
 <20250217101706.2104498-8-eugen.hristev@linaro.org>
 <Z7RELnyWRLietj9b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7RELnyWRLietj9b@infradead.org>

On (25/02/18 00:26), Christoph Hellwig wrote:
> On Mon, Feb 17, 2025 at 12:17:03PM +0200, Eugen Hristev wrote:
> > log_buf_addr_get() and log_buf_len_get() can be reused in another module,
> > export the symbols.
> 
> Err, no way.

Yeah I think we've been there before [1]

[1] https://lore.kernel.org/all/20230905081902.321778-1-hch@lst.de/

