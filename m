Return-Path: <linux-kernel+bounces-304630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8DE9622F2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5015F1C20F51
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9E7158543;
	Wed, 28 Aug 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="B57pwSUN"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC815ECDF
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724835969; cv=none; b=b/miPE7IesTVN2q1RuSeQNLuOSr2W1aNrFaQ6V0eOSwLlAQzoSPQc0KPp7PkIT5ZOOCXTAZgDBsxKnZdIiKYHO1Ft8s5/QBpidA5X+QrJoV2gRTgmOjEXKW89M1F5mPRifqduOaKe1R39QT8/+sAgasAdKfBlvXJAecJ2OHQ4G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724835969; c=relaxed/simple;
	bh=tilZU3Kh158lJuUVKV7O5vJ4OjgZWFiiF6RI0BZAfg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq6Fyym9yN7UjrFbXn15LY9ZhSm3qwGEktW2hONyZJzGRXD/Bfga5TwNF/XOl+c0zdgMBFqkPsYL1xLKeC5aXjPRDgpCfmPKM2TpV/cFryiIAKup3b1ZZPYyoUrNr5X2qk+l/qMmn2UtEoQUNpphaT8SHJCLSDe3m0Q9XZS4O04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=B57pwSUN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3f90295a9so69570481fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1724835966; x=1725440766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUwP1bH89y2mjDwy+uYIsF7q8d+iUjc7F7MG+V5YoHA=;
        b=B57pwSUNrzfkeq72C1HWzOwMvaNQjY3cIv/ivPN2tDcAUNjRGZQbMvcXTA9yxXEpdw
         +bKFt1GzR/Tl1v51WshqzJDq+Jlkxnt9sugzURczlNMOiPt7vZ/BtL5P9LiGBh0lSAey
         YAVLyQM1BF0b16ig0dGX225roICmwcZkFa2/cOVVHYPBCJxLeKHXMJ1HBtk5h5kMh8/m
         KZDS/7bGVgDW90C8SMON16UZW2qf2WfHmOmp7DOp33Nqdag5LX9Iwz5rL7RtHv3TUmoh
         5IkCSMrDGmHWvhbE1lyt9s0c3r22oDbVFKs+ll86gOJpP6sBh8PpD/y06sQ6hQ4iV1tp
         RGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724835966; x=1725440766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUwP1bH89y2mjDwy+uYIsF7q8d+iUjc7F7MG+V5YoHA=;
        b=kTn1QYKuPv92q1w/uJk6QwWEX3s+t4jQGYFqANHGVPASJRq8rgYgZ+GFREW0jL/PYS
         NaP3i0MR98A3IVUwfEEnTklc/aWeVi8pSKRuGKiSDTfdmTVfEKUlqhGiBVNf5Cr8ApSA
         ZScBv/TYxUhBr5llq/TdhHe5DKBM+7hjF5V6NU2RUmFkJezjdwMmRdDnTDGfer+0VNsW
         ijl1CdnCf9KZc8OHKZpOJaj+UcSk40cJvPKjr0RBxpTY81BynZM76F6+S0T6P/L63DaL
         325YmMmUQeLsFs+FCqrHuqmi3ED0oU4gDQ6qiGPRW+r5JkJ74+adZGM0Hxu3dn8gp1M8
         +x1w==
X-Forwarded-Encrypted: i=1; AJvYcCXabFiyLpoq+RgScvVSz2CDoqor8o5pCzgIFSZScXskRSv9//zXcLWa4L+7PfYhF4q6BC7nCw3EVXSa41w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTEC8KU4tX+xsi/QzKKG9e3XE5koNQJI9N6IjqjzPOa2+j2yty
	hAFZAGVN0U4TBEydqmHLTNU6ALMqkQTjkdnSR4A9Y7ueAAqcnlvAmzYRnD9yQgk=
X-Google-Smtp-Source: AGHT+IEk0hGUKNFKy1gAbF519cS1Zf9jNVuoleszEhO12zfKPjpQIg/vIHKKuEXsuMjAwz6KFlZ/ow==
X-Received: by 2002:a2e:908a:0:b0:2ef:2d3a:e70a with SMTP id 38308e7fff4ca-2f4f49090f4mr89975361fa.18.1724835964996;
        Wed, 28 Aug 2024 02:06:04 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb4824e7sm1973814a12.92.2024.08.28.02.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 02:06:04 -0700 (PDT)
Date: Wed, 28 Aug 2024 11:06:02 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 13/13] riscv: Add qspinlock support
Message-ID: <20240828-801ce72599586044dcaa767d@orel>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-14-alexghiti@rivosinc.com>
 <20240821-ec1ec92842570050429621d1@orel>
 <CAHVXubgtw3rZq1+jNv2LrsQBhViu4Sm9Gw3B_7-XLzBw52x6oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHVXubgtw3rZq1+jNv2LrsQBhViu4Sm9Gw3B_7-XLzBw52x6oQ@mail.gmail.com>

On Wed, Aug 28, 2024 at 10:16:40AM GMT, Alexandre Ghiti wrote:
...
> I sent the kernel size impact using -Os as asked and
> ARCH_WEAK_RELEASE_ACQUIRE should be handled by Andrea.

Sounds good. Thanks.

> 
> Thanks for all the reviews drew, the patchset is way better now! I
> won't respin a new version since there is only a minor comment change
> requested in "riscv: Improve zacas fully-ordered cmpxchg()" unless you
> insist.

I don't insist. It might be nice to change the comment text at merge
though since it's safe to do with only compile-testing and it would
improve readability.

Thanks,
drew

