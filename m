Return-Path: <linux-kernel+bounces-349526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F83098F7DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1AAC283D20
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4A2126F2A;
	Thu,  3 Oct 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j7tqYcVV"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDA217BA3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985967; cv=none; b=Y/LOjC0hwz8ETyuDEeCR98DJjjStR90ekXpaYaBsYmrZbNjbWDZYHEWucma6FnpR0zHQKEZlssyLUVmDG8D6dkPh2lBSGK2N99im3XH1aBZaeuf17n5fzEtrfNOUvmgpGGvv9OcLLyCOrZ/YZdO+dimq9fhjrW2pdRVl36B3Fj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985967; c=relaxed/simple;
	bh=hSUWgNV185nneWzES4OzK4vK5Eea03Ph2K2/JhNMW+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CihXPBc2ytfW/S1SsAiY0ZhAf2jciUMNS/TDPuET7/GGCezdNjMLCoeb2DUKGV6P+PZorsIqfc87URlNSL2iruT6DfKRXH1LOtRzMOqsiaN3Ii1GeVH1/xv+Jks0k5LKdrDjuXsAzGpUyacoA0MagFTN8Y+wDjwKXbRWVfw+bFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j7tqYcVV; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6e255b5e0deso11624447b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727985965; x=1728590765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHzI9kibwBGfbX+u9LfgG392Bz0yBO/FrADznXjpfXo=;
        b=j7tqYcVV3x/XlKQt4Jrfe6glfAkoAUeui0hIfdxsK9C6OY1DNRxjcxTIrRHfCmC4HU
         DMFRDFowt6izwr868bjssZK13KpWkILt+iEfCI68S4akc3ZDYG7yrQkKSR8PhBY/GTGp
         PKVP8diE+qMPB/s8L2HKb1w2//jHthg/mI/QHlQKozaziyigN2zH7wf7FnC0cZREX33F
         TjGZauupae3PRbZ+3RR8Xc8QN56z3kIq1L6rjrBnBlJE6sx9TWsLXafk4Yzr2SCyy4yI
         ghTbmYhvlW2KLfsgrvMeco3oPU7SRaDBSWl++MLq/eArkXUYU0sekXLnwKWi0l9xt55R
         kB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727985965; x=1728590765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHzI9kibwBGfbX+u9LfgG392Bz0yBO/FrADznXjpfXo=;
        b=TybAJvPZTE/S13eJn2TQuLkrYNYSgX4kx++jzw/V7AV5J/UqJrNEwT97fwXdQl9LcQ
         yI/yszCtgJcoLCuvv6c6/0PlGG4uPTEg5cS193JV7aS51Y/1lpi8Ybu9HIUWJXqNsHdK
         G57kF8P+i5CQI9FbGLAasMqnab00bjrBJlWF/MBKASjg6/pGCmlacXrPES8WADsBn+xa
         ldtT6a0KupmxHGus/V5wNixxqLQ20/zKCXNNKc+j6CrOoG41MCZkjesSDQTfp2Mo/D22
         hAdMiBrzuDLQVQRTEZKtQiFBXd9r/b6LsLTX/pJLZuPBvp8boHIyfgWn6F3JloDu3977
         eupg==
X-Forwarded-Encrypted: i=1; AJvYcCXGPtp3RnxN9lVwI6tS67T0quD9dGLRs8AuJHf7mhYjo8YnG5kpFaY9AJSfHLVBepW0h/De7kto1zcleoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAjAZaIEw7nZe2eG8+Rgb9ZuIYpq7ygRPHafLbXKz7th+Ip0J
	5UnKn/MoaDC7YZzynuu9ky713B9JFVG40CaaAbO6QsEhMzl1QXZ7PRVabd/q7F67y4IlGmbjsVA
	4KZ9eWm8WHYVKEF0Kr87Xt8XZvWM4EG1aGQFm
X-Google-Smtp-Source: AGHT+IESiGJnMtl1gZFqJRNktO5r59aOQQF1KKLqhp/PZ7O+Nz98cRWkE2b6UlCPgSskCbDZSVsRWB9LF8R5tSuAhAA=
X-Received: by 2002:a05:690c:60c2:b0:63b:ba95:c8b3 with SMTP id
 00721157ae682-6e2c7c16a00mr3687097b3.6.1727985964764; Thu, 03 Oct 2024
 13:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926013506.860253-1-jthoughton@google.com> <20240926013506.860253-5-jthoughton@google.com>
In-Reply-To: <20240926013506.860253-5-jthoughton@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 3 Oct 2024 13:05:28 -0700
Message-ID: <CADrL8HX5WxpRD98rQkBhVQo0asw_c9VOwk79OJDWqzRDmkoX9A@mail.gmail.com>
Subject: Re: [PATCH v7 04/18] KVM: x86/mmu: Relax locking for kvm_test_age_gfn
 and kvm_age_gfn
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, 
	Yu Zhao <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 6:35=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
> @@ -70,8 +70,6 @@ static inline u64 kvm_tdp_mmu_write_spte(tdp_ptep_t spt=
ep, u64 old_spte,
>  static inline u64 tdp_mmu_clear_spte_bits(tdp_ptep_t sptep, u64 old_spte=
,
>                                           u64 mask, int level)
>  {
> -       atomic64_t *sptep_atomic;
> -
>         if (kvm_tdp_mmu_spte_need_atomic_write(old_spte, level))
>                 return tdp_mmu_clear_spte_bits_atomic(sptep, mask);
>

This delete should have gone in the previous patch. Will be fixed in v8.

