Return-Path: <linux-kernel+bounces-571975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0CEA6C4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F02B7A5ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AC74A0C;
	Fri, 21 Mar 2025 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CVoMtSX8"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793941EFFBA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591629; cv=none; b=ipC8j/CZEEQNO82lcZggbx/j0ByefY87y6bZS+JlNsKJJLGXu/onhatWQgIObTD0yf8ovUHLtSlq9nl3CTkrk6Iz29oU1D73HM0Na7G/OanBsWP2DhThcPfuKA6XDHrCKvKePx0OUH8qE1SZzi9gJwbp8U5BGxQSdPhDgCt9LOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591629; c=relaxed/simple;
	bh=vXCTGBNTu1ZhVw/3Q0kYcVmj5r+C9dLc8FPhH6o66uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxxBaanXWZae0LYMPabsB/k0lKwcIO6XfY4CyrXQm/eapO2nNtuYe+VLx0CYiiAa9qIACCo0CaMn7VRTZZqMkh9E56ElTEpDnHFfT1bOohsGrPp2Toa6LjmwA7eUQhOBCU7+fwoRpMajhEjLF5zzl+onVVncmYnDXpgOPVFkkE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CVoMtSX8; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6ff4faf858cso17727557b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742591626; x=1743196426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i2ew2LYxgleBNPrPHWYUPReaCgmTl0BEjHG0XlfsxM=;
        b=CVoMtSX8aeCGHEIpipOw2bN3TUYw2kx91HSCAUn9jLQz3hfMF2Fy1gwK6/amNZ5Ozx
         eOc5pSMN39mbNge0B26/WZ225Z80rbeIcxbwjVjG3MQsyHKNUK+k0S5t+JlooCPbLZgI
         qpIHi72Q4uf2RX9aeAmMNAoFKVKdgEMiTifPxb59WsNjfQmviDYVftK5sV3fpMVExced
         6n6cHSzj70C8MsPteIVtomOSDXYuJwOiIiPNh+tC/rr1ESUmPR1OVhC+DF2FZwa07Ccs
         vjUEjS0gdAwP5lVScSpTaTEd/jGGWiKxX2gwvRkusFfVr76Ft2wdEdot3/XZgsDmSaAU
         MxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591626; x=1743196426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i2ew2LYxgleBNPrPHWYUPReaCgmTl0BEjHG0XlfsxM=;
        b=fiVCOhgA7qUvn/ilZm1ZTB8NUquV8LTtd71zRArOolH1AkQg6oO24hIxd3/9AZFPBw
         PSycvGKxbbSNCAjK6k62BAtM886dDz2NUle+HDbYmf99uFIUPXKfNsonWR0T431PDoKl
         lFaqhglw6fbpjT4zSMosI+c81ad7o1kMP5F6o6iajuVyiWV5Da8MhCHHqjcmJJq4y9Ig
         lrrJfuBC7G2apbyS2b0vjFAc1HIP7WXzMDUdT983o4elI9hUGitdRLjtHlvwjRb0YfIL
         ve0zH+7BhtTheupPD3joGjloQtkRC/KqQ/0JjZQHrCxqDfQpd4g5gOBf/VCiJUd1T41C
         e6aw==
X-Forwarded-Encrypted: i=1; AJvYcCVIIhZw0d4JgwhAaXuicjs1LyM5/OBcd0El38TFedOjYjv//J2zenHDkCwan0NtLmo+W5Z6ULLe2610dFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxEHj9YfeCbwAW86wT6DDECSLr45FcQcoXoEAOcN4cpNMMg8P
	AGb/NlftnzqYQkGqi950YlxV5c83/vO9dyP0ZA7VVtrnxbvrX/82rsdHjxTOmcie+L3ZXWvlhZA
	b3b1yL7P0/knRvffOa2pdEfQrHjdlCg2ameXH
X-Gm-Gg: ASbGncugTNFcRhqsKJGJGJzXIpPWWv3ArMZE+wqBg9ZtHmZqrlkB+4MiPkc++WTUvVm
	Is7Cy7zZwcFq03ITAjFFm2X/DqYK3cO7TWxgsdZQpSzQG2LbLHn66hNaVdGqTQ/3cFf7l8ESiqP
	VeiAXlgmrOX65ywcZCg+i1JVQr2gJr2lv8E6Dr
X-Google-Smtp-Source: AGHT+IEJdg9bvrmazKSaObyLFJyvWysTY9GZ1IrakNKlyqsc9PcsudY5cVnjW0AMjOxr//q3y/G2oTHH1ULQgsL6BR0=
X-Received: by 2002:a05:690c:6e0e:b0:6fd:359a:8fd2 with SMTP id
 00721157ae682-700baccc7famr70059317b3.26.1742591626216; Fri, 21 Mar 2025
 14:13:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321102422.640271-1-nik.borisov@suse.com>
In-Reply-To: <20250321102422.640271-1-nik.borisov@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Mar 2025 17:13:35 -0400
X-Gm-Features: AQ5f1Jp901Ps5YHdQiwmT3LZ4ohZiC6256GsYwktLVbiz-fabRCF7SyN3qruNTw
Message-ID: <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-security-module@vger.kernel.org, serge@hallyn.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 21, 2025 at 6:24=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.c=
om> wrote:
>
> This simple change allows usecases where someone might want to  lock only=
 specific
> feature at a finer granularity than integrity/confidentiality levels allo=
ws.
> The first likely user of this is the CoCo subsystem where certain feature=
s will be
> disabled.
>
> Nikolay Borisov (2):
>   lockdown: Switch implementation to using bitmap
>   lockdown/kunit: Introduce kunit tests

Hi Nikolay,

Thanks for the patches!  With the merge window opening in a few days,
it is too late to consider this for the upcoming merge window so
realistically this patchset is two weeks out and I'm hopeful we'll
have a dedicated Lockdown maintainer by then so I'm going to defer the
ultimate decision on acceptance to them.

--=20
paul-moore.com

