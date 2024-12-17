Return-Path: <linux-kernel+bounces-449251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FEE9F4C41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0D1749A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545731D1730;
	Tue, 17 Dec 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRFygNvz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233B21E5702
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441797; cv=none; b=qhwruULLz4CyeljvZ6MZnrZggTzEZnIinG6koyy8p1hQUtShqjJr+RAW8c1zqmyBm/siF/wBGuUsIM7yIs5V14Dp3lZtVeggjtrTJFAJH3V7dvA3BsqX4U/TA1WGR0OjfBP6g9clvxBP9B21IBZIQH68krOKXZsClpsrdtQATzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441797; c=relaxed/simple;
	bh=zluAZksj0L8x1p9l+OOtyBpDtW4al/9Yh0L5sEpVqUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HShLesh/51KzaJ2JO25Y1Ag9FSgD/+D3U1WkRuQWG7pZer0Hv4/S5eL5aG4GbbivgwrVSKLgtCzTSChNo0xWekfWDYLIFh5DwZNJur8iIsbc8nH1nMTFvHT4JbYdoR3nwdIz3ukS9c+235tBjzFTDYV7XpiD1Dd59ywJYGhATbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRFygNvz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43622893c3cso39535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 05:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734441794; x=1735046594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zluAZksj0L8x1p9l+OOtyBpDtW4al/9Yh0L5sEpVqUs=;
        b=IRFygNvzckuJ5rHKl3lY4l/RBL6k2DvrIRHpBlmXO3vEkMqKzycRcjv2YOCpuFma9G
         ak3BFjVKMYaByIRkNggz1Jn4wTf4DwolAQC8MV6l/W4o73Azc8D3plHV18v4dzkycPnH
         1KTL+FFQIAPy3iqM/6Pi6LosVr4I+YRq4PW/7uPI14qyHEB4A/IuQspCJHWxFIx05S7/
         pT0+G0OEgflZuwdqh7pG+S5FapipA+GO3shwhG+SOdxjp4SXMFsPAZRgs5h+oh1++jlB
         1uWWucr1Ab6Ppe29b5tNd/VIFWbGC471S0OD+kCo+7qo5PCmtsej3xZf3TzOeHhkp8VD
         lbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734441794; x=1735046594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zluAZksj0L8x1p9l+OOtyBpDtW4al/9Yh0L5sEpVqUs=;
        b=ftKZkPtP0za+tmDEoGNs23Oj9tsOkdVGdwz1cHO5tUEHkekLSPVZcx0ieG+rfLgpW2
         A3vGtmh75Gi5o9GOnQVozPLej0ShFGzTAregtOTHhm2ssKD3r6hxZq5RYLe4i3I4ryQY
         Vpk5MAiPU8SbMX891NPB0baiJT1I7B9AukG48WPP5eNgfLruERLfR0jF4XAIZHO9DC1S
         rL/G3t+MbpVNn7xOb9LCciCjp7YWYerNwFf0z3HVWiSJfl3bTrF1x8eymY0ixymZe6HY
         y2hE0OzWrRm7fvJXSpP5tpQ/PiT3elz6/eODElo6em/0iCunLVijzGeMUJsLNaBSC25f
         LnFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgCFXJtr/D+22GPuB4NeTUqkHcXoxXO0WUbJ0BuX9Ys0O7VgLznqYlbckVcbqnTw3yPNLd3Ef89bFr428=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppYMaMz1YWVY0mtpNeFANHEUba3RexOVRzUrLdDkKc8rVUJAB
	ax2e2ZQzxJfovSDHhU+3lbVYRrqCqDceUQHVO+Chu7oEvDMtNCZWRpJ8CTO0wGAD8Bd89Cco16Y
	SLuMvrChMj7UZ9KQfSwsbbrElFt54/rYQiErD
X-Gm-Gg: ASbGncuW613JhxAFAnHv4GBjBShU2BMnPYplls5o3Ug1KALBKtA74bhRWVm4NjuOgDK
	GxSjTh/XKdExr529dNiLSUR+kGc0XQLOufMwTk/hizuvhufIbCG9+psB3pESu6eTL+A8=
X-Google-Smtp-Source: AGHT+IG5ALWJj0ksNk9sQYWDvuIBxfw/FZ03jE5oquPujoQVSflCn5++EfO42GLq+XkZqgVWsqivlsN1K0ssWL87W0s=
X-Received: by 2002:a7b:cb19:0:b0:42b:a961:e51 with SMTP id
 5b1f17b1804b1-43648ca90ddmr1215695e9.0.1734441794300; Tue, 17 Dec 2024
 05:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216175803.2716565-1-qperret@google.com> <20241216175803.2716565-12-qperret@google.com>
 <CA+EHjTxRt=XoCZbRLE1UjMg4bzgoLYD9Lh0nzmjvPZ2Q4xQOkg@mail.gmail.com> <Z2F5KboZewSDClKg@google.com>
In-Reply-To: <Z2F5KboZewSDClKg@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 17 Dec 2024 13:22:37 +0000
Message-ID: <CA+EHjTzmEonAUNNHM8X__6XHLko0fksjT0_ZVHhKRVsZp0zQCg@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] KVM: arm64: Introduce __pkvm_host_unshare_guest()
To: Quentin Perret <qperret@google.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Sebastian Ene <sebastianene@google.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 13:14, Quentin Perret <qperret@google.com> wrote:
>
> On Tuesday 17 Dec 2024 at 08:53:34 (+0000), Fuad Tabba wrote:
> > nit: This parameter in this patch, and others, is sometimes hyp_vm, at
> > others just vm. It would be nicer if it was always the same.
>
> Argh, where specifically do you see inconsistencies? All changes to
> mem_protect.c should use 'vm' consistently in this series now.
>
> The code in hyp-main.c does use 'hyp_vm' consistently however, but
> perhaps that is what you meant? I did that to follow the pattern of the
> existing code that uses 'hyp_vcpu' in that file.

You're right, my bad. I was looking at the code in the patch, not in
the files. Sorry for the noise.
/fuad

> Thanks!
> Quentin

