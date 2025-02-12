Return-Path: <linux-kernel+bounces-511374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A5DA32A15
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE2D87A122D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7645E211A02;
	Wed, 12 Feb 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hIkPJqgP"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA57211295
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374306; cv=none; b=Om73J/+mT2+szBSwuI6TZFMM9n2Coa/biUb2BYhPxiQRZU5FM0S5f7fcXEpflfuk4F9+hiKIc6MKlH6UBEqjcycwJXvhmv2txnth0fJlEg9jYI3p61D2kLwOs9jl2VJQoqFHZYF/OWWsDAosa1O5Asdw1nhnaNw9ryGMajXA0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374306; c=relaxed/simple;
	bh=Kd+6DzKTiuHkjzGkdtLbyCkTyy0yaluQp17EPwunXIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XESDRZWSAAjh8qcWmgbKpdM/8j3F45Y3AudXZju+R/BdhSzgHsulegatTDbIg2ogY338DgA6Pet/sxHCI/orxvUGKgyJ9aq6DEcaoiobTK2owct6YDYeafLq2YUPPmbnyV7NUJefCxvPcgS/ns49NExzZUw6ANj2uBVcKqZ+WKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hIkPJqgP; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so106103a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739374302; x=1739979102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YSq+cHNnWSDiFyg3hiZUKEZKM5fOb5ovEsLt9hQ8kFA=;
        b=hIkPJqgPGbTqULf5gs3Rgx2UTz5aOKzJbJ9ZXALg8IrKNljYc1CqD0j+Zo1gNlV+BF
         AekVcgRwwv4WAG5zUxATu3raVe/HGhEPHQCoOw9kv5lFMfByW+H00YBRs/YkIJQw727S
         b0jOUoNtFsPOemdcidWNlj7YFsS8ZBOYv2lfJe2E5AE65fLi2aFYwaeCyyZCkHvmd5NA
         +kZF1BPUZZ9g/dNd7g7k1SSUgBE2hGekdcF1kcqMSqBoN/GIqzVLi6xX6GSV7cPNNcaN
         +0SOsQLtEZPLAbna3hjAA0fe4y8ojBrF5ZEVY6u/MzykFAqKcQPfOzdSPcMeWRSEXyYN
         CXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739374302; x=1739979102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSq+cHNnWSDiFyg3hiZUKEZKM5fOb5ovEsLt9hQ8kFA=;
        b=U/mfXejB1MBI2GJHzKJL+jZ9qtI8j4QDMuF9jmNrVp9l6DNdQDjv//7Cecq6xANgKe
         t/miz04dhPCHag6bsP1Hxsdz3WyibEMA7MwD4PancedsdkUFm6K0EkGR/7elGSUhlPgF
         BioIZtaK7MohzJ9R2fb+cOCCGCgAumm9evXZcgDpP4GNJPldHTXbOHlsmnjjb1MZW3+i
         CRTil12Lcssrekdk1nsC0IkpBsS2PUpVMSS0abtM2DXK3AxhUEuzbESFSkgRT+Da45Dx
         XZyJTQb/Bz696WMFyTyscgnxBlfz+ZJ6OJaxjB/Ar8NOuRbdR3qYgyTaYlAv697q64E7
         3eoA==
X-Forwarded-Encrypted: i=1; AJvYcCVA0f8DMzmJPFzKCy8CsB+x2pvVUD8E0AXxpojZ5D0GEwOxDBNdT2ByPIXqMlLuqobdfR2t8wFRg1yP0Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwupMr73+hIjLJN88AVt9zh77gMuXWVNwqNWTLEmLPypFNw5qYb
	9q67bVWoRRS+f1beo6GNQCIbpb9Vd7SPe3UUigzZi/GZxKIQFMwP4/lUy6D3gHg=
X-Gm-Gg: ASbGncsg77FjFkIMcWO+LvjPvFItayJArTtm+I+Hpzn2p7LCGMjb8BhPagQIvj4IZsz
	1iZ175twZ/P1eCCvN4hqSkFO3A2Owp0knLixR/q1tk7ExcHZTB2qSnpt2QlrzcTvk4sf2SXQy4r
	p/fh7Xzm7m6WKVtZC4yQ7ikkIJuwTs7kUoGRvo8uQvnWXLYIc7EfaNMu66NGNJU74HwEm3xSQxy
	Tam4L7JSlgeIJHeYwzEAUSv0eyatZfzbnWUSJX55zdH02jem63tgvYXfvtPBGKbiOJJBpp4Hvts
	IitKtNhvQxm/kvEFz+bP
X-Google-Smtp-Source: AGHT+IEL4lA8s78vp0Gg7MOmptz86X5Vg+sujBASU2RfYgzLtUU6Y26AXdNXUW7VE46t0p06RX/ymQ==
X-Received: by 2002:a17:907:60d6:b0:ab7:c426:f33 with SMTP id a640c23a62f3a-ab7f34a8230mr346620066b.56.1739374302011;
        Wed, 12 Feb 2025 07:31:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7b4aba036sm737804366b.45.2025.02.12.07.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:31:41 -0800 (PST)
Date: Wed, 12 Feb 2025 18:31:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: oe-kbuild@lists.linux.dev, David Gow <davidgow@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] ww_mutex: convert self-test to KUnit
Message-ID: <30998382-ee63-4a4e-8287-cd21c649b849@stanley.mountain>
References: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>
 <3dabe058-2308-4990-8e5d-0af1efd27431@stanley.mountain>
 <CAJ-ks9=mKzgLhJW0dV-L8eFtkW-xt8v3GM51V4QF5Ef_ENKLvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9=mKzgLhJW0dV-L8eFtkW-xt8v3GM51V4QF5Ef_ENKLvA@mail.gmail.com>

On Wed, Feb 12, 2025 at 09:33:46AM -0500, Tamir Duberstein wrote:
> >
> 
> As an aside, how can I compile with the warning settings used by
> kernel test robot?
> 

This is a Smatch warning.

https://github.com/error27/smatch
https://github.com/error27/smatch/blob/master/Documentation/smatch.rst

Run smatch/smatch_scripts/kchecker kernel/locking/ww_mutex_kunit.c

regards,
dan carpenter


