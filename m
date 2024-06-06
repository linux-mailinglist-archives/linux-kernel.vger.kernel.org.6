Return-Path: <linux-kernel+bounces-204058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5370E8FE370
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679B21C24B4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCA517E8FB;
	Thu,  6 Jun 2024 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gtk1a9bp"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03417DE1C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667534; cv=none; b=OxQNhZJIVUK4mGXy61YhBXcctNsY3oaXCzHTyz2Is8+o/50fRXIj0zVpOwtb9eTDmmrDWrqzSAio2SyuHZ0b7XruppG0E9vwL9P2kqvnJGQOU0mQ0N8PIMYlMEKQWgRbt7e8d8rJs6qa/Cqj05+sFkhs17vUJRZLOgVS5Fu+IL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667534; c=relaxed/simple;
	bh=hzMInXZBrq08VfXm9EodIoLXJ2qNXwWHpR/vSZpB+as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fqIesnTY73eydebrUpyIPlb+pwABv/iWm/fZSW+ddE+rvB/wwUgEqQ77JqG1aCoTSj3iffyO2e92ip9RMHJUgZaKrol3tUunhpvloQ9xU1R/wW5FQSr3ggVjSQEihfJQYPvOXQwpKso666Yt/40ufGCa38qEPzM8ajpT5p7Hl10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=gtk1a9bp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2eab0bc74cdso7316281fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1717667531; x=1718272331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzMInXZBrq08VfXm9EodIoLXJ2qNXwWHpR/vSZpB+as=;
        b=gtk1a9bpnVtDocVdEOLvEOtSatyS73dq6dJfgs1U+WASwtsiqzSuVhHfb0c2T6rklL
         HEBfmgXDL587gyb6sDVbecdU7maBaPvdxalvbmUw4sBKfUY8EXlOtU+hzixVOJiw1Z1t
         iVw58P5FR2jo1hocr6P6kJCmL9NRP5QSG28dofAGZiMyFrUjBqtV6fQbxEP+PprfUYmn
         b00b1+BLLIOROzaImz6CTvHi4mN3qzotw+BiFqecf0LMDG3TQ0t7plzlq9usP4L5CWsg
         FEhh6cFj8JH7pmSvVSFy5LjBuer4lKhswukaCZDnFfBR5XwmuSjeXKTQO36uWCzQ10b0
         JiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717667531; x=1718272331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzMInXZBrq08VfXm9EodIoLXJ2qNXwWHpR/vSZpB+as=;
        b=oKztz2dl9hmeWqpj4ewAaCM5K1L9uu8G+/wKvMWnVcjZbl9+5uT66MIeNW1GLkqKil
         EH+hmgYRtkKX8KvoREJPeau3VCqc1hgShO87sbJ6S9Y/MeHVe7XhStZZ0s6Y1hGPGy1K
         YGDaSGwsOJ2jEj8nFgo6RYnWLQmDXBgyd/DmysPI5d5/iOaFbqf+eTzPUQr5A9sS0O1i
         W2SZ6YzkrCZ2Zpxu56EjACWou4wewu2cWFUJgM7Fw0hTKihHMqankR1MRcNFFj2XOnL5
         lgYCI2Ysnqbxkd9nBiB/ro4Hm3qiBenML1r/9OMv9VuEKCTiNjccnSAor7Rqun9NYWyJ
         xPew==
X-Forwarded-Encrypted: i=1; AJvYcCXh3KY7MvLPGnCntn+Ge33N/yxaKPAMP5Xku2c4q8Rqcyk8ezhU4iDSCdTwDHMp2FA3JIs9rMNkE6gzGOsKiN3tu/albWYPPn11lPGW
X-Gm-Message-State: AOJu0YwkM8wSgSJ+7blvwEQoj0WlVIR+uY7AmRb1FZuDFW/0FHt1YXtT
	newAZZCxGt1gfM61qh05K9jW7G7S3Dfun9/YytwR93lIOSq4d0Bae6NEjEhivaUPn1mxFwsgDJM
	MjEvrk5+k+d63irXL7GH1hOiyDAvSPK5xaOlBSQ==
X-Google-Smtp-Source: AGHT+IGRjxg5JxSkcZ0TIa9nvKzj+6js95PShzriLgFiyIk8WZvSEOxoci54ygHxxx3XlK6Ngc3iCOMpgDTyPLdieC0=
X-Received: by 2002:a2e:9617:0:b0:2d8:3e60:b9c9 with SMTP id
 38308e7fff4ca-2eac7a82898mr28203101fa.33.1717667530690; Thu, 06 Jun 2024
 02:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422080833.8745-1-liangshenlin@eswincomputing.com>
 <20240422080833.8745-3-liangshenlin@eswincomputing.com> <mvmr0das93i.fsf@suse.de>
In-Reply-To: <mvmr0das93i.fsf@suse.de>
From: Anup Patel <apatel@ventanamicro.com>
Date: Thu, 6 Jun 2024 15:21:59 +0530
Message-ID: <CAK9=C2Ug2gcS5Rbqc9EQ6mVwrJkoeLscOm6wtgqGKHdqEdSpSA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] perf kvm/riscv: Port perf kvm stat to RISC-V
To: Andreas Schwab <schwab@suse.de>
Cc: Shenlin Liang <liangshenlin@eswincomputing.com>, anup@brainfault.org, 
	atishp@atishpatra.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 6, 2024 at 3:10=E2=80=AFPM Andreas Schwab <schwab@suse.de> wrot=
e:
>
> On Apr 22 2024, Shenlin Liang wrote:
>
> > \ No newline at end of file
>
> Please fix that.

Fixed in KVM RISC-V queue.

Thanks,
Anup

