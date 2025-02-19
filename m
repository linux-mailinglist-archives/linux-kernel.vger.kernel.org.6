Return-Path: <linux-kernel+bounces-521049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B583A3B337
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CF218988EC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69E1C5F01;
	Wed, 19 Feb 2025 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OP0ZWc5S"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946F9191F77
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952361; cv=none; b=lPx5eQcloca5Jto0xVeKdidkwyFsyNxzhwwIYY6RpYiefzqSJNrFfgeYCSTawonVEFHAEnS0ojcaYRdzVEa0KpqKPw8CJ4IZEqr7bq4H80G79JuE5ofQJ0ustEa0YTDKHYcrcbk+D9M37tGUsHKqAl+QJo2oS7NjarwicNBfygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952361; c=relaxed/simple;
	bh=6b/FYVUKFZW/rZzPAqlMXsdGXCeCSu0N5Kd+DJjdp7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adyr3QGUQfSq4JDpHQTTMB59Q89+iXmwNV0YXCigDbMiFlYv9JaHtVR+syg7JMJQvr/ol66Gu/UpJ6F7t3aAQRd3RbF/RHLwncjY0uh/sbcZ1iZnIv59IwtbVPGGgcmukeVcf2hk7ZEBkBVuJgqUQ/d6AUY2QbQjMqdbnSMrPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OP0ZWc5S; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abadccdfe5aso825957366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 00:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739952354; x=1740557154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wLGc0PhsYQqjnufHmhSBlNvjs6ldgEolpYxIgynjQOs=;
        b=OP0ZWc5SESZewczmU4FGe0a8AgI4gtgDFl/IwY9sYT3Za7fNJT9i5NqT2W3xCuBQIf
         TrJZzWXu+vo/PqlX2Zwy7+Yw7xFLcTvuPfgoeRRLSuXzUTndXRoaeI4OSKMcVvWxNdnC
         /QZBHXJUhIpL3PG60Uuw5XEd3lfFevbS9XdFskpRhrroZ8JNxmlx1+0tgb6LgX74CDXX
         bd84sQVbuXkLxmFeomxiX+rAZ5nIlKfPMMMN7v4CegZ+LqAtZodxN8JPHCLWR2+CZD2P
         3equ3fiYigPR5vGksIGlTSwqyOcMqBBG88MKv4mF0ks7nNojOy4142pIeYRs9zlUY6HR
         2fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739952354; x=1740557154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLGc0PhsYQqjnufHmhSBlNvjs6ldgEolpYxIgynjQOs=;
        b=M3tfI73lT8tW605xgV8XmVFGT8I9nGLigNNuBO7RPRW0vhxb5GNffPoEy01MDmzpWP
         4MpXLgxvc/mmT8cJoHVIR+oR6jnCCadVrNFWSvsSIhssEw0N5W6Y65vzXIUH72aSji2M
         2BG/nmO0YZtFm4Rt+OokMLMRe5f8cKhxWJnZSa6S9MlslBvBOCTkI3wORziDZaPPROWV
         f/jQwb2Zw9z0K2MXo/84wqVe/LOdtZ1u0Tj/XUGRvTmadmNoCU1/4JLV5RJIAI4OYiOR
         PPJZ9JAUKUTDllM5w0vXg0XH45/scBqacrGWHbLrEnYZqFc47wLH0BkwEzpQ4nAfIhQC
         5IQg==
X-Forwarded-Encrypted: i=1; AJvYcCWQ9FBknTI9CR/7eNom6hhWRK/5NzxQ1g6r3xA3/FOxfk5vfz92255MMXJ/lfk4XfHjKTM41UIzTb01NAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHS8PK814L+ldnlszYGiJkUryfQ2447Q+fuXQUd5+x/arvvYP
	1B5ZkRnDFIK/L0etSZAJGJw5HrPtAjiKjUbkmwsZpp4bL2hyGpPCAZo731yfXfQ=
X-Gm-Gg: ASbGncslrxouLsbg1cO3PgEBD3Xyqtp3Sdu9OHoyBjQ9NuU2Y4edUhuYUk/vfyUXI2G
	Q52mE2/+1WliKCssuwTnP+1wxvmJOEeDCXp287qi5UfICGRQeiHv7P10OATt0j05u2zndr1X3Uw
	hD9ZyNVG8K5h8Hpd4tYCmgYKxpmAzgiY2ug0ocdTiuqVZkKQzyMJfzTzUD2r5a025OW7RgVv+Nx
	6MsxMuvo3dlJBbHZrW/N/kwGOLsAvSH2lA3vUmJY8y4kHFD9flTMA3GCM2fPU0GcBV2h83kRuq/
	9AueboQHwPwq0SRVmRAM
X-Google-Smtp-Source: AGHT+IGBEq/z6D6qnilsHC3+mDce/VGZCnHMT6t2e1BeXhqvd14hXzgZOEYBBCCaEPZH9/ztZFe9uQ==
X-Received: by 2002:a17:907:7247:b0:ab7:c6f4:9522 with SMTP id a640c23a62f3a-abb70921334mr1722647266b.9.1739952353901;
        Wed, 19 Feb 2025 00:05:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abb8915db0dsm690660166b.145.2025.02.19.00.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:05:53 -0800 (PST)
Date: Wed, 19 Feb 2025 11:05:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7SwcnUzjZYfuJ4-@infradead.org>

On Tue, Feb 18, 2025 at 08:08:18AM -0800, Christoph Hellwig wrote:
> But that also shows how core maintainers
> are put off by trivial things like checking for integer overflows or
> compiler enforced synchronization (as in the clang thread sanitizer).
> How are we're going to bridge the gap between a part of the kernel that
> is not even accepting relatively easy rules for improving safety vs
> another one that enforces even strong rules.

Yeah.  It's an ironic thing...

	unsigned long total = nr * size;

	if (nr > ULONG_MAX / size)
		return -EINVAL;

In an ideal world, people who write code like that should receive a
permanent ban from promoting Rust.

regards,
dan carpenter

