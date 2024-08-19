Return-Path: <linux-kernel+bounces-292809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F29A9574AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22B61C21089
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E8F1DC49E;
	Mon, 19 Aug 2024 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kyg//etU"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A5157E91
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096656; cv=none; b=O6nMDlqjng5J8Yc2U3azP1o9KToqFNcz/+tlYm56GqVr7u4RvWhcOcNDe2y+AZkA4KjPwhO02R1QMP2A0LvlLif7WnrpLF9nkKD7DI6PfUwBXZW8FcerzLJiCgerG1NvqD/eThqzvxrvO+q04s+6HPTg9v53b7Pn6JhUIQbbjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096656; c=relaxed/simple;
	bh=w83ocErDZIzCw8c8O7vL+g1+VP5ZM2OU81Qz7bqaBRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+mdzx1WnTeKXcKt36nfs2y3raFgZYA8cISJ0D+VVjHlPtnCQxHCcbQVnVwZLcEJ4urBdxEKLt/cKpSeR4VrZGA4kjw4tn0AvxQ3rqEQpjrMX0g0m+sBN9hT7N/zDgYvDCq8CeBox2UiDuf//PtEYco4IewGl98gd7MgG3iKXUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kyg//etU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-530e062217eso6251198e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724096652; x=1724701452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDiz02fpJ0BHDvVXU18To+N8ajErks/Wn/P49vHS5RA=;
        b=Kyg//etUfl0pXEFI1K5vRdrvtTNHadCSLXJdcUhGYYklIkB3SEOX27TfADQDnjqA31
         2F1OSgLeTj6+o0oP1pQ5/o5ejkhHZn/84gGwE5lVGIMaaBfDGm+UmLV5sl/ThQbcfWBj
         sZtjiWZnsZKFm7wLZo1NjrCmKiSzF5tb9xct9I3jjiEJB1KRT/lJsibZg3ZXEv8ZXGzk
         f3OnplQE7LS2ec0qLtp/7UNc9c+5L6w7tOJYA275+5HBOqi5ax5ECZMA9Gg3GMZw39GM
         W7dK+5JXiyjPIq4Koxt0cFwKdz+HfEYHBrYDpoqLm8TBHrWlj9Zk4NYE0m86/x+gzHUx
         dSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096652; x=1724701452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDiz02fpJ0BHDvVXU18To+N8ajErks/Wn/P49vHS5RA=;
        b=iw1kFiQXIa5gdkAdR0cHp1+luIN+jhLtZf34Dvju6sBERWvasSP6egGU/gwVkpyLuI
         MENfUSwNagaIqQfy2ZJEyYCJ4KEP4wjULxetkLyXi6OR7Ni+kauXA6HrSOXXQj/5j9ZT
         FlSmD2K7vzQ+v3kp1NA761YBm+BZsN2u8aXODTR9mGwRc1PV8GBJIqY0ouIbAGV17ay4
         fUJU0yVOjMFkhnUQUqqBwxyDkNFmsN0NOztALWbd3we4Afka4N+umdmeCxBmPjAVv/Xh
         sHjR3gv3sojqF/vJNH03G4NSII0OqKHQ8APVc+z1+SavLhQxJtSgQf7ClKm9TI4LTeOi
         dPvg==
X-Forwarded-Encrypted: i=1; AJvYcCVRx8ZRuwU8y3fhuCPXOo+MU2D9v+NR3P9Hsd4lWmImeD3Hn05QPmQtWXk0YFfgrLiR2e4/7bfOV5+LB16qEPoWxQBTef4/1VydufnX
X-Gm-Message-State: AOJu0YxgCfVsQ4jq2AAMpGweFQ4FBsKOTiI5/EVRnGootPPTmWRXnzAL
	JzSZekdW0cnGbLZ3la98ighud8y4KSs30b9uqYJssBGRoqbzuB8Rn0+J4Y0tVC6v8m8U96RBEC1
	hJnjN/Zpu4jAOlG3oimZkTaO3zz3M/kmBhMjgjHTYd1BQkz/Ekw==
X-Google-Smtp-Source: AGHT+IG1BaOgHVZEdvbKaXGctP//pb7CyT3HJWWrHjhhlPOcCZVibicxUbUt9KdvzqmsEwfys0s9oPhOXTmbq0LTH3Q=
X-Received: by 2002:a05:6512:33d5:b0:530:e228:276f with SMTP id
 2adb3069b0e04-5331c6ba93dmr8709338e87.36.1724096652012; Mon, 19 Aug 2024
 12:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
In-Reply-To: <20240816192310.117456-1-pratikrajesh.sampat@amd.com>
From: Peter Gonda <pgonda@google.com>
Date: Mon, 19 Aug 2024 13:43:59 -0600
Message-ID: <CAMkAt6o1KZH=fTWWOoPf+Z0j12xUYrbqj=Qob4E1LxJBtivo4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] SEV Kernel Selftests
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, michael.roth@amd.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:23=E2=80=AFPM Pratik R. Sampat
<pratikrajesh.sampat@amd.com> wrote:
>
> This series primarily introduces SEV-SNP test for the kernel selftest
> framework. It tests boot, ioctl, pre fault, and fallocate in various
> combinations to exercise both positive and negative launch flow paths.
>
> Patch 1 - Adds a wrapper for the ioctl calls that decouple ioctl and
> asserts which enables the use of negative test cases. No functional
> change intended.
> Patch 2 - Extend the sev smoke tests to use the SNP specific ioctl
> calls and sets up memory to boot a SNP guest VM
> Patch 3 - Adds SNP to shutdown testing
> Patch 4, 5 - Tests the ioctl path for SEV, SEV-ES and SNP
> Patch 6 - Adds support for SNP in KVM_SEV_INIT2 tests
> Patch 7,8,9 - Enable Prefault tests for SEV, SEV-ES and SNP
>
> The patchset is rebased on top of kvm/queue and and over the
> "KVM: selftests: Add SEV-ES shutdown test" patch.
> https://lore.kernel.org/kvm/20240709182936.146487-1-pgonda@google.com/
>
> v2:
> 1. Add SMT parsing check to populate SNP policy flags
> 2. Extend Peter Gonda's shutdown test to include SNP

Thanks for this.

> 3. Introduce new tests for prefault which include exercising prefault,
>    fallocate, hole-punch in various combinations.
> 4. Decouple ioctl patch reworked to introduce private variants of the
>    the functions that call into the ioctl. Also reordered the patch for
>    it to arrive first so that new APIs are not written right after
>    their introduction.
> 5. General cleanups - adding comments, avoiding local booleans, better
>    error message. Suggestions incorporated from Peter, Tom, and Sean.
>

Tested the entire series

Tested-by: Peter Gonda <pgonda@google.com>

