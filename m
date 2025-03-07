Return-Path: <linux-kernel+bounces-550597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD16A561C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92573B1F99
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F1D1A83FF;
	Fri,  7 Mar 2025 07:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WK1as5u2"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AE19F13F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741332546; cv=none; b=FMGRzeiizgN6WPP2A3045k4YIRac3vgFqMbWUCZmEmewHZS1ik9xD4N7/ju1AGNLSBVfTd8k2TzA799Srl5QS7XfKXVCI5XSFbCUz7lrYa1y/iJ39ZPf4C9k8AJxHkYATZco7UXUzEgM2SQpjpiYZviDzuxdXa0htYSvcaVz4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741332546; c=relaxed/simple;
	bh=9gDxCWe7Zg/nWpvugHW1RCaJiLWtan81G00ApnN9AjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6xUCkslE7mZ4mRQHi6JSXM56LNPFG6jc4VZ7RJ+x4w3JIWP8tXgcbgRKd8KZd7KeIeYPRNgESoMYIr2kx42FRzEJU5phHtAPJFr6mojHhioPDa9zT4zBypXEcuPSS0+ZHatuGdVVQUyuUfrKmY2eWB8L0CbeQePvEofMcRhBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WK1as5u2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-390fdaf2897so1435552f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741332543; x=1741937343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IUreiTCZVZCY/sR49qTRb5j3OTUwCXV8SCtHZI5UAQU=;
        b=WK1as5u2xt9X1yvMW8HD88jMwxO2yDNfVALF+WGAtNT1A0+lXznPhkcjQtbwOY3+rw
         fqAH5tmoOqcKg9NiJO3QZTYeerFdwCSHv5mPhtClV30mNARl5Tlmbztgl42EovUqv0BZ
         6nqDX4ZyzMbA48ikYLo7bAomugp4Ov+Vgu3CZsnaKs/w754oS+Zv6or/tC5BCdxaFECd
         Lr5rg6ALuToHfwfjLVVdrgwL98vQutAV385Fe0iTCKjOymUu0miqX4Jrv/KIu2KBMVpo
         UFA0zilFQvlsNRArrhM0p0TU3/aGKeOdWbfC8vN6An4OG54cInqlc7oUJmww9G5iwFEg
         zA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741332543; x=1741937343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUreiTCZVZCY/sR49qTRb5j3OTUwCXV8SCtHZI5UAQU=;
        b=G3YDtqvgHIiyHBQcrNUX37S57J3Ci6QKSJAkyFeQGiAc4BH4voUcVCLOit4Ks+/Rlq
         ojvKjnmGal7Mlug9CuZI1WtRDJjXcyJEtpN1lnc/tkmulwLs0HgQI67rPJm0yo+BfqE6
         vjOw2eX4p1Y9PbuMt/pS7612tU2hHura8uKQDqqU1yzZHKUxUhh2p02IhDr/tQjGwJyJ
         79phQj7WQx2RkZ+Fo/EfOJeCSs1yzD+jlPgjWEdeu6Ib5Iqh5Z+/j2AwbqjMCFyvt1Xh
         MW2c1xnEDPc5et3Mw4Cqa2yyE7GzS9aiM3PQy0NT3SYsktS8Txw93PFkH396zwZrUuM4
         +lnA==
X-Forwarded-Encrypted: i=1; AJvYcCXw06agj/tN+tQw4W/EwqF/LrvHiFGHtNvslpH3CBDfRQGKPg3c7VvrlDbv3rZ6j2OsH6cgUqytECBaUyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXZPKi+RjegbO3+0Uog0NKqr5byNzm/MrMDY4zxf0IZBXZ9Pgy
	oOVHsu20LIotvow7SpNvAFFI307kNI8T+kZ0TuGopwvTLoczFp8Uxnr1V+sileI=
X-Gm-Gg: ASbGncv0U5FaAehSpbMJ+FgQEyFJVBaWnuIhiRF2W6vlVjk4o29vRcERKSA8G3DURDV
	9thNtYb0ilU4zZ2ZjGJnMZh0yd9vX3o2fNgTJO/yKerfxCzvdoeRaB/yjmDl8eFksvlTr995OiZ
	NMZCn429GT5G4F85KEIXj7sHdHnAa9fuYCepDBwgF++W79gyIDHF16MiC5rPCT0SYc9i3M71z1E
	Nl6RlcLZ3S6okG/APxFzvTcUsuOjlDAmF44X9cz65eYtkhkUDEbH5uIp0dUVpBUkIq3SmbXVyty
	z7U2bOInovp2y+w7yOTP02SKX/+Xz27t9QPR1wOaf7wEMRkiIQ==
X-Google-Smtp-Source: AGHT+IG7+0XvfqpXEa4bb2S7ULVZlAWD2yns/3fQUyBqRZKt9KtX+yqDgzdFZ1rvgJVCkq7kZRve0Q==
X-Received: by 2002:a5d:64ac:0:b0:38d:dfb8:3679 with SMTP id ffacd0b85a97d-39132d228c5mr1671359f8f.17.1741332543129;
        Thu, 06 Mar 2025 23:29:03 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfcfbsm4355592f8f.28.2025.03.06.23.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:29:02 -0800 (PST)
Date: Fri, 7 Mar 2025 10:28:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: Carl Vanderlip <quic_carlv@quicinc.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] accel/qaic: Fix integer overflow in qaic_validate_req()
Message-ID: <0716c1d9-46e7-4345-b005-314f5631aa74@stanley.mountain>
References: <820aed99-4417-4e4b-bf80-fd23c7a09dbb@stanley.mountain>
 <03bfed13-c541-4a09-8330-ca3563be0f77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03bfed13-c541-4a09-8330-ca3563be0f77@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 12:12:53PM -0700, Jeff Hugo wrote:
> On 3/5/2025 8:53 AM, Dan Carpenter wrote:
> > These are u64 variables that come from the user via
> > qaic_attach_slice_bo_ioctl().  Ensure that the math doesn't have an
> > integer wrapping bug.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: ff13be830333 ("accel/qaic: Add datapath")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >   drivers/accel/qaic/qaic_data.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
> > index c20eb63750f5..cd5a31edba66 100644
> > --- a/drivers/accel/qaic/qaic_data.c
> > +++ b/drivers/accel/qaic/qaic_data.c
> > @@ -563,7 +563,8 @@ static int qaic_validate_req(struct qaic_device *qdev, struct qaic_attach_slice_
> >   		      invalid_sem(&slice_ent[i].sem2) || invalid_sem(&slice_ent[i].sem3))
> >   			return -EINVAL;
> > -		if (slice_ent[i].offset + slice_ent[i].size > total_size)
> > +		if (slice_ent[i].offset > U64_MAX - slice_ent[i].size ||
> > +		    slice_ent[i].offset + slice_ent[i].size > total_size)
> >   			return -EINVAL;
> >   	}
> 
> I agree this is an issue that needs to be addressed.  However, it seems that
> overflow checking helpers exist (include/linux/overflow.h), therefore open
> coding a check feels non-preferable.  I think check_add_overflow() would be
> the way to go.  Do you agree?

Sure.

regards,
dan carpenter


