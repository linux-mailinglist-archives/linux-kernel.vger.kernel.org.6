Return-Path: <linux-kernel+bounces-536040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFB1A47ACD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA4B3ABA10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E67F22A4C6;
	Thu, 27 Feb 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8jG40Sv"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ECA22839A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653495; cv=none; b=fGUVUMMaR/tV2uvo6RlKFYDqdmlGAnCWMGUr+qAWBV6OAq5Hv27ZdiqR7Koxx0DMA408HcpL4Vv+i4vnYms24pfYkIt7JkL3THcqi+0VrpP3R0w059puWO7fGYnhsya9G/zdU6ybJRMm19X2Mi13aknOod6nL28PjHbJkISPftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653495; c=relaxed/simple;
	bh=gwzpWMlcaBsycOSM+YUnNeqP1En+P3xOlXYQj9751xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtk4VEKJx9bZNXBJsRMfDXbeDlMQ148NmJQQRq2jANfomQ0XV61LUdxifLbFiLfHwSJYxXXMwsxQwv8SNOSMUuGP4VQiIw+qG8G7JExtmDeT7IA4+wAhvK9/QfzV5yq1d4vbDRNL1i3cfQHcluBh2WJC+QkGlgOWFcpINP2uWDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8jG40Sv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22349dc31bcso11961975ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 02:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740653493; x=1741258293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dT185d0FOI5HGH1Y9sKArCWlsv6m/rsOymauDbDjP3U=;
        b=f8jG40SvR+tTqZXivwmbTuzK+DO/r9wrYoWkQL0AzPtryDN3sWcpz33zUosOjidD67
         nte/jJbratepfGh1A2LxCsz4EhV4Pq8noQDtC7KpyXo7rm2ZSOGhPnfG656Iip1EHJDN
         72WUj0pfsPxnfhKd2+RBQIiWLwLN/HTNHhOHalbcBKWo+4Hnlo6TXUWUiwMjipTDehHJ
         88S4ZEBSdRxH3l/XrCsPYMhgROOn0DsvzGaPG2EkTGh5CGym7x3bFfHuNOjVwe4cl1AI
         KacuN3K4ye93kpT1c19KqpPHQl+szAyiWu7yBEiNqLajUMQBCyxmZIKGI8+wvtqNgkRl
         k0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740653493; x=1741258293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT185d0FOI5HGH1Y9sKArCWlsv6m/rsOymauDbDjP3U=;
        b=bSigoT3zv6LID163y3nOCcGUDZr/5xXCKId6saUFnR31bGEUyqPCm5amB1yTmC3d57
         ORHIGXyCsgCklqhkpq7W4YoSTsP0sJiFYVxYhLGVx+PyMDiPqkIZuF5hfiwoFKgh5HiV
         CbT4jd9Vmw2eFpQmsvkI/adgvB4AUkPzWa1mzwl93HBPKDjM9g6VDEKz6IFm9JvBi4de
         bZHMKUqV5VqUh7SrYCQsTyU3ja+Uai0KAd80PxfjSK1uSElRv+TU94YEF4qlwiTzWR9/
         jddW9yF00u95ouxTUni8eYNmAHKhWiiIbx1vLDGbyjRS7s+y0Vxfe1O6XRThs3mg6lZn
         vduA==
X-Forwarded-Encrypted: i=1; AJvYcCUG0YDRGfQcSsTrr33LngOdCVczA+su2L38PDy4/RMlMoae/+0a+fEisQOteCp0vggznADqWhMbCtnoAPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+KPAeh7YHGUcjfiCI8/Ze/NrrnKmt9O3Ri1r/A2LbXCg2LUoE
	su0ErFaIaoiFpfTM6ITiPIoGDBc1UzQr3cLUKSiYVMTtd0w/N8QJTt76KhJWa9bb4JbKB9S+rY0
	x
X-Gm-Gg: ASbGnctpvrB+Rgphb68K7+5oWA2qgDIYw63OMaDfu7rXMiQIKz/VtIhqOh4OHpW+s0K
	I4aUW8+QyJwHEuLuTppZalWVReZMA31vGfaGyaYzC40g4GGDfjC22I5wNBzwbWjKt2M/e1c50Un
	fuIyw9q2+Fh9xYPWKzu75NL6ZhnEffaCjVTwVNo9MglzZle8etWd+8i7S9pTSBs0GBTGJkx4ocx
	1zrL7k6i0TvHWMklOZNXDdQzsr02FDSVlRCVAxxNrOymAVcpl8gm3mPiEiLwEVFB1F1tjsO1JLp
	cLteC/VznctKqCjT+7zS0zcQdxE=
X-Google-Smtp-Source: AGHT+IG630+3TS5xhf+OKW8ljyiG5CNAh5ck7afIDwubQFhmQKZ+JGICRHGY8ej+2hddtp+GzFMYKQ==
X-Received: by 2002:a17:902:fc46:b0:223:3ef1:a30a with SMTP id d9443c01a7336-2233ef1a520mr66106575ad.45.1740653493594;
        Thu, 27 Feb 2025 02:51:33 -0800 (PST)
Received: from localhost ([122.172.84.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bf3sm11387155ad.110.2025.02.27.02.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 02:51:33 -0800 (PST)
Date: Thu, 27 Feb 2025 16:21:30 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Burak Emir <bqe@google.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: add bindings and API for bitmap.h and bitops.h.
Message-ID: <20250227105130.wkklh2wpybz3kggl@vireshk-i7>
References: <20250227101720.1811578-1-bqe@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227101720.1811578-1-bqe@google.com>

On 27-02-25, 10:08, Burak Emir wrote:
> Question for Yury: What would you like us to do for the MAINTAINERS
> file? For now I just added the new files as F: entries.

> diff --git a/MAINTAINERS b/MAINTAINERS
>  BITMAP API [RUST]

I would suggest adding this too.

+  M:	Burak Emir <bqe@google.com> (bitmap)

>  M:	Viresh Kumar <viresh.kumar@linaro.org> (cpumask)
>  R:	Yury Norov <yury.norov@gmail.com>
>  S:	Maintained
>  F:	rust/kernel/cpumask.rs
> +F:	rust/kernel/bitmap.rs

-- 
viresh

