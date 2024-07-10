Return-Path: <linux-kernel+bounces-248229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2608592DA63
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F1B3B23085
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9619D198A05;
	Wed, 10 Jul 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CU0wMyne"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F83A18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720644404; cv=none; b=Vvy/4T7b65o6qUKG2HtF7kXmP2GNcvJBNBY7A3uDh7BhriYiS9VNc8JTmHLJybnEyG+Wu6pwUS8Rgqj+MqlGvfgwgaJPMiVAoFicM12gJyUhfwlSVvHBdQDGoNMjmEaIuzR1X9yeSFC82RMTITq1x/04MC9VG4ZGnfgjoUtq9Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720644404; c=relaxed/simple;
	bh=d/wF/+1szpn74odmbOk4Ueqm33+P/Ge8CGNfNiGpOXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0j1n7b80UJhWQ7aoI9s3M3QCe0ij/UkrwwMGH6R/+J+Sj128h8HZzgmcF8mVMBv6TAWg5GhP3JxEYsXFILzhDD5fCkCQzm1gKZJVH4Dw3zV0t/v/wr7EudVDJ44tKAWusebnyptKp3fKbMbitjdOfhozmCus7iBsAWoEQZ9a6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CU0wMyne; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-25e3d388580so122535fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 13:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720644402; x=1721249202; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6F3+lAkPEQaUNUkz+HZyDAW2CgNWSyFvymAUJjriBA=;
        b=CU0wMyne8FC+btzBmO1h3IXlIvPB6LTzB3BaG9p6wgmi444FclaGv6Qb0/7dsgo25I
         qqnKOq3zxENDzndyc7LG5kVLd1vx4ERgeApEHA/HsWElbznRbQRMgtHkaD6wASp2gLJu
         ZA7i+GWVaNzJlkbcvP6staQ034yq+qgdtnt8jbaJM3wRLqu6E9n4pcZ3mlcJyqkgmVts
         KWkgF2xOSwlKAzkzhD88sBojU+OtxoF4CqXRhiWyqO/EH20IfBSeLHyt8Kej4RmcUgB6
         OjD0twIwrWAZgRnSzDCQLosSHc/42wT+iijR/wR8/D+KFrMdpeM70j4pBH7NFbxzz7rh
         ZYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720644402; x=1721249202;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6F3+lAkPEQaUNUkz+HZyDAW2CgNWSyFvymAUJjriBA=;
        b=Gp3ZMeRP38mRyoY6PWYRQhEvbZzNZvpABv5mzqyvXReNNOS1vcr6XSubVB1SzaXuOh
         VDyYMsVBgXfj48wwiQ074Zcwkq9pYzap0e4znE0XzeVpgRzg7gtbm+v6Vjds2jOIZxW6
         cK5qsMhEwBpWcLXsyLy39h+MasnhbmxnHKMJnpLv2VV1qlqB14FQc6InsepwYYjd/PLm
         3y4cwXT55caye4wURs/IfOw//C3FSUPlCHkbcmgJDZeux5qZ3tQEKQvsaUmjKXyKFcR2
         9s0DwH2aWGnnSoR/RhQV0zSSHYrDh+aBbGWCdUCavSGHSdCBSKUGkSqMFOiAzB04KgBr
         cRxQ==
X-Gm-Message-State: AOJu0Yx1Irx7VN/DIcKUcNWe4qKlIzbQah2c3zoeSkzLmfmT9HjtvAf9
	3GOu9x052Ia1m4D8FuXvF+GuE2bkmZfk6TGjm9JoP3xFF1X39CHToTxUlJPG3W0AXAjA/5vFi6D
	TtmcRlixgs395/GLT+Y9Zd4/o0UAsZR4IXS5V
X-Google-Smtp-Source: AGHT+IHD1pUbDguSz3tSAdKmeDxXAVUwdA775CP8W5jvdh+VyIuiUP9SiOWpO0PMRvWwtfyaygRzVjQpA89XTrIeujE=
X-Received: by 2002:a05:6870:5491:b0:25e:c034:31d with SMTP id
 586e51a60fabf-25ec0340354mr4342969fac.50.1720644402407; Wed, 10 Jul 2024
 13:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710174031.312055-1-pbonzini@redhat.com> <20240710174031.312055-3-pbonzini@redhat.com>
In-Reply-To: <20240710174031.312055-3-pbonzini@redhat.com>
From: Anish Moorthy <amoorthy@google.com>
Date: Wed, 10 Jul 2024 13:46:06 -0700
Message-ID: <CAF7b7mogOgTs5FZMfuUDms2uHqy3_CNu7p=3TanLzHkem=EMyA@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] KVM: Add KVM_PRE_FAULT_MEMORY vcpu ioctl to
 pre-populate guest memory
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	isaku.yamahata@intel.com, seanjc@google.com, binbin.wu@linux.intel.com, 
	xiaoyao.li@intel.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 10:41=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> +       if (!PAGE_ALIGNED(range->gpa) ||
> +           !PAGE_ALIGNED(range->size) ||
> ...
> +               return -EINVAL;

If 'gpa' and 'size' must be page-aligned anyways, doesn't it make
sense to just take a 'gfn' and 'num_pages'  and eliminate this error
condition?

