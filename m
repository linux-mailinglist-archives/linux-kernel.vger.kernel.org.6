Return-Path: <linux-kernel+bounces-512826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E79A33E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6F53AA292
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7AA2080DE;
	Thu, 13 Feb 2025 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fon6FwR7"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F99227E88;
	Thu, 13 Feb 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446411; cv=none; b=Eu68aSGMGjlwcXmffsMzW0X5v0ibQ5n1Z2FIj7d1LUnaA4b5spWdeuQuK6PVeKtbjO9JZ8pnwRISaYnwgbxAD1/Y3SY7DxGzQ/8gmx80j1a8hhBa3baDRw1hVZBESbOKQyeSBk/ZyTioUe2yumjRME2pXEQDq9XUTbByJGJXWHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446411; c=relaxed/simple;
	bh=p/0qg44bstO5WNnUfr82eA5sFdyx00TkPp8MmL37jE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXZPXfz4uxBJgMDbpSet67p/u7gDIi6jKVfSnU4s4iTaUwPF2/Twqg0KWvUqWlKC+uE5aXjbQLoIUO17NEttpjlvaKNqA2Scn/kyTSoIOfGCkeOn5zaWjnoaUHV6ZY5J5TJLkVD+IgnQRpApPnuX56efK4qXPMlsLFiNSxRd0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fon6FwR7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c07cd527e4so30140385a.3;
        Thu, 13 Feb 2025 03:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739446408; x=1740051208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jCjzjrsnGB8UX9TppDQ1Fq6klVuQu117zKu3PlITgVk=;
        b=fon6FwR7r87uDOJbpM4B/0JIcj9/r93LNuCZd/o0rdiGoCjTR5mbiIAuWel/OS3zRB
         GKDxAVvBAbuc5obMDc01+n1cS7FXUw+3tr+u6IkzwiK5K0d+OIhSP84TTenWX0y2iCKz
         V8OGk6IYFAMtJaAneWYrTskCLc+ozTqfY6DV/DsgJ//7IV0LLwfNKHwvoIEJb0P8imKl
         uYaQ93H4+F3/HVQtdK1ZjhQ82hdyaf05Y2qbFL77bw9btW2F6dOYxe8J+Cu/9Cge+qA6
         iBUM+6WSI6Tg3t+ZrCmFA/H0pu7078w3qp9+KWSVKtfmKoo0YeykRcrYw9Vbr7hIYm12
         8XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739446408; x=1740051208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCjzjrsnGB8UX9TppDQ1Fq6klVuQu117zKu3PlITgVk=;
        b=QCa2GAMZ55bkDkqn6YvucznYPGl1MY5IyZH264LW/imbPNGqgzB8WvdMi1shuV2gAu
         mTu5idm+rcAodZg/rBxQlSVIHj7uIl9V8xu5JYNQgALpRURRF+i+o/PNC0o3Gm7f4KTl
         cjQiRsUhLEgmyIm9PtkIj0VXz+nUI7cuWeTDOisp4jTY7G0yZHcetMvp5EKF5vmNmGfY
         1+GEMOeMVouRWuNc2x5T8TyimeRkVo/eDYrK2hqpG2tAzsJ/W9PokBdkq0TcrcPtfqAx
         KQuAH4R+c3Y4npt3I9YGXzsaHmm5L+pT3DGZWzEGfAAoyg43f91RnKHA6dakgNvH5K0J
         aV6A==
X-Forwarded-Encrypted: i=1; AJvYcCWaycBwRJ17jq7Aw5nG3MBJvk+bqJg1/fNVGiAkMoIU3qrdz9ADoRdQjhyxm2erS8wxguGqh3+4NUrkDsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVHoo6iKZhm9LZ3jH1enKy6wxU7PwgE6ywtrlSMahDp3YTb95
	metpkv4L7FPVq6JknrLW04fvEvMJd7uxwYzKPDMWcRrPYbJTFg2M
X-Gm-Gg: ASbGncsPmrvTQBN68/tChWcE8b6Os77OtZGodaIcOThY3GZoz2ysloCwTMWGVyK+4uI
	95APyYGhfbYyBmQA84mmwR1t0oEDgZt2wjrvxEqUyv/ABQwHrw8+A1sBylpms1ksbkz76w7x4GU
	feCPRuv5IWJQSDvN5iNb4BFEBAj1rJLrN7VmC/nTNmgRbyKhXI3Mn9Sl3CoskNS5sq7iFdj0cq1
	7E/KEMbCwnly793YITDbCF4KSRYrlxdWDi+Tck28o8gBhTDcZkEETGC2jBQCN/nHRQ=
X-Google-Smtp-Source: AGHT+IFXo9NdWsRyyruApIs1cjKDwDnPHq25hEtzH65MpQ5viX9oTBCdwL1YIhjUn707bQRGVi/hdQ==
X-Received: by 2002:a05:620a:3c92:b0:7c0:7a75:4fc8 with SMTP id af79cd13be357-7c07a75526cmr310011285a.24.1739446408565;
        Thu, 13 Feb 2025 03:33:28 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c07c8611e1sm74722385a.81.2025.02.13.03.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 03:33:28 -0800 (PST)
Date: Thu, 13 Feb 2025 19:33:19 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, 
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/4] reset: introduct generic bit reset controller
Message-ID: <yfhta3vfct73udltmz6ri2dsas6wx4g6hww3drdcumreqbi4gu@c6zxqz7fbh7j>
References: <20250213020900.745551-1-inochiama@gmail.com>
 <42e8f0e0f065b10fa8731d26acc856e5776fe2de.camel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e8f0e0f065b10fa8731d26acc856e5776fe2de.camel@pengutronix.de>

On Thu, Feb 13, 2025 at 11:08:03AM +0100, Philipp Zabel wrote:
> On Do, 2025-02-13 at 10:08 +0800, Inochi Amaoto wrote:
> > Many SoC have a simple reset controller with toggling bit to perform
> > assert/deassert. It is annoyed to add compatiable for each device when
> > coming a new SoC. It is necessary to introduct a generic device to
> > simplify these things.
> 
> You'll still have to add a compatible to reset-simple.yaml for each new
> SoC, see patch 3.
> 
> regards
> Philipp

Yeah, the binding is can not avoided, but it can avoided adding new
compatible in the driver. I will update the description.

Regards,
Inochi

