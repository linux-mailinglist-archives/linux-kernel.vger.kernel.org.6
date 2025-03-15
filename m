Return-Path: <linux-kernel+bounces-562481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB069A62967
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC523BEC38
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2B1F2B8E;
	Sat, 15 Mar 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lj1212AT"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B61241A8F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029169; cv=none; b=ocwz/Y7iLR8kVPYcrseo9oGidIMTJ1niXdXcW+yPFlUV9DoRdxu6NzVno7WtqR+cpINv8bcEnXDku1cBNZfFdWCKERiGASv4dqXwVBPbd/EFZyLTCeQkCXLlABvfyqVt1oxSd2Rcgn+z/32uwCpI5rqVcAvP4Ej/POisvBBBNQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029169; c=relaxed/simple;
	bh=a3UIbOy4QmYY4PfL1I7O69Y9YFwqI1DiMtGnNJVIPVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tv1H85t5OzBR/eW9Y/zI/osoaNjSitVEhPGoSdgjgxqzPe6KFUvioRjSmtLbcroJTJJLnP6QxnSyJPJWyGXQa/+RIZ8Nl4SdIymvpJL7G1y/tpHRwdpEmHxeOYSr+83qhcVVahK7ZSyFnGOlhUOArXHs8DY9eH2bpDiQ2x3qrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lj1212AT; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso5077a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 01:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742029166; x=1742633966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3UIbOy4QmYY4PfL1I7O69Y9YFwqI1DiMtGnNJVIPVY=;
        b=lj1212ATH5tPcQOoDqY1BXdgvs5iZK6TUJLlOUYS6wuCBKEOkIICf0D3OnyGtHWNDS
         OJ7ZidJ33o5Rmqk87zc1WykaErLYejvH87MzOkZHSgmKQWBqpoWVmV9asr968LBsSklo
         u5Efc5jCSUeu3KLCdWtVWUiMNCbUwrBNfK/cIM6vdVMKDImQT2iqINQKamdVmoWxTqG3
         AqAw4RvINbWXUgbhWfrj+Zhz3PhhdRCc9XC+tOOZYZ50OOYeTRmvYu33kg/Sj6Nrildw
         ecIRb27I9K65bQ064r7vor5Sc67z982RsxwSTc6reCIaf41yTNrM8o0Y5oLD9R9f4PSp
         Ihqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029166; x=1742633966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3UIbOy4QmYY4PfL1I7O69Y9YFwqI1DiMtGnNJVIPVY=;
        b=JG8vYzRe+SoSFQ8HWBpvCu/uxacOOgnbDd6TAyzu61GJ42P9YTrjLTVNvGcR2sqf+l
         fVPGfNjpYJyLA1VhezaFcQnSofe02Z8BIiACA9sjl1Z2R3oUVhA4DpK/tcrtsoTfPAfa
         0sQPCBEkAmTclJaQohZGWxyCZmzHm+WuJCEVK5HcRQIZwLNBDJEIgF/kfd4z1JR+VmOo
         PnUpa7rbfWzGr8AYf3lchKjuYtZsyugHgd4ZaIMbpNAjCSY8d4dxgT0GztthKC8W9nH7
         slQ3evENgEy2xs1h1HP+7chALixbA5HQuz4hL2tvQxesPPgDIu4TFCOtALJkFYUqHC/z
         Fivg==
X-Forwarded-Encrypted: i=1; AJvYcCVtDTVFZsZj+qpUBLZNkCDe5JYCjPdS0xgnfKCVrF7e4hyUcAmlCTM3Sx/lLDEmLVYGe567pl43QzHvQ3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhyH+BDPuNfJ1v/F4tx/02Ly+3Obx8nDzBc1xBYP1is16epAyQ
	i8cp+DBUvLWIkmVUjRxsVlZVnz/0VaT4NtUJo2o6fxNqzOthtvyXvAC3tNPHisqb1p3wfq63i9D
	Juc9zL/cVVBAapQKYLAv0t9tlF84Et2GDwSwN
X-Gm-Gg: ASbGncunJPjurnkyY/Z4gWTCXdPwqkNMu7mt0WkLx1MfhjoPL3B/ZwnbbCqUyHGmnCA
	myoHswKqgspBcCS+WTLPJA/umCC6ZUHOBk0lz0I79cBN0WDSDcc9ZV2x4ON+kfkPiWPitqcCQNe
	ofx/fDq+oNsXeqw13hgepqVP34dQ==
X-Google-Smtp-Source: AGHT+IE+dXs97/Zsvb6VNnIn4JhvNf3ZmeHugrDF5Oo+TfPvYxKv9MZCmFOCHdsG828AfmKXMwR5QbNXQf4OSyZGGBw=
X-Received: by 2002:aa7:c50c:0:b0:5e4:9ee2:afe1 with SMTP id
 4fb4d7f45d1cf-5e8cf638fadmr48899a12.2.1742029166434; Sat, 15 Mar 2025
 01:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315024102.2361628-1-seanjc@google.com>
In-Reply-To: <20250315024102.2361628-1-seanjc@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Sat, 15 Mar 2025 01:59:14 -0700
X-Gm-Features: AQ5f1JriodUiWgwMjT6SHrLMF4ZHu49pONF2k89lVnsEELpGG9I9MIer5FlQkY4
Message-ID: <CALMp9eRZpj3UcwhsDrJ8T_BhQytSyaXtpwDMK_w2=-5xDut4qg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Explicitly zero-initialize on-stack CPUID unions
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 7:41=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Explicitly zero/empty-initialize the unions used for PMU related CPUID
> entries, instead of manually zeroing all fields (hopefully), or in the
> case of 0x80000022, relying on the compiler to clobber the uninitialized
> bitfields.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

