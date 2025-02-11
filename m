Return-Path: <linux-kernel+bounces-510133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5B3A3189C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF64168926
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46B268FC2;
	Tue, 11 Feb 2025 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvnKZi7P"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422026773A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313051; cv=none; b=B5/Q7FsEYG9BYrA6hReL2TQUwaiXlHXzi3Xb/+GiYjJ4evIcHOtiL5CGcRenLe3vt7/O4fFtaD05Znos1xivRpkmRhZ84oc0EcJRVFeQyPdGAwKA8mNB6RgoJih2rq+1E3ju3neykGjDi8ZgRFk695CzR1YArGkrJD6cpEUBJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313051; c=relaxed/simple;
	bh=qG0UvHV1Jro9tTb7SPhDTlVdRVxBMEkcrRrrgEzaEs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rc6MtkdiCjptosxtI0LUhOJxIP7L652SntOFR6TYRxe64306/nAlkGCz90zkZWu9GUpgrW23rmaQ4e00tD7Gk0ej0VonND4NuSPj1lxS95PmeA5AxgQD4JV4NSZ3E+y2P9kpaAcNLuD8EEJUadwpB5edGo+bZhIqja4DwZJWJsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvnKZi7P; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso39839605e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739313048; x=1739917848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6s5Wae2RLMoUMz5R98ykOj4ADsWEvs+TEBSTZ4cnL+I=;
        b=NvnKZi7Pl7hXT+cbiGwQ9ReWtlMgrdj2NDCT4sUia2Tj7kN8Stx3E4poqcTew4RoWr
         F+jZiBsUFEu/wjBX1P8JozvNbmcYx1Nnw7/KMBQDW/te9DnHPgP2L5wAhttnOpWF9rPn
         ByUts7qx8IhEyQPV3JVDTahN1jHsCnUJpjUqcruhfSmbqJdxQtbuq1EQnA6nDnwiSFY3
         YRSCqPlz/HJh0yfXidmEua3Dt7slrtEWIlWCLqhtVOZjcHAcQdFU7+tIqKuIqsdN6Uv+
         qnYxn8eYl2yfIKAUMsg3+8LZ8WDp3tNjcJzvNLeaW0Pg22K56BaMmaIBCch21czFgC7D
         rWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739313048; x=1739917848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6s5Wae2RLMoUMz5R98ykOj4ADsWEvs+TEBSTZ4cnL+I=;
        b=IQAKGldhs6VhnTeCedikzc/3ZrEboHeBy+CGvn/bYlisRvps7thSAoZTumnviiM4NF
         5sOuZu1ozPnhwiEVPi+xDmeOciR3EEA+1Bc9JPM+Ofkk5m259Bi6a85PN/g5azfe7Tew
         z4ks2ODGiNZeEqtYNjrpRBwsUEls/sjSHPMDgP0vyCZwr7ccwjCG06QqcWz+VftVaijG
         AeeorqV4KzsV4DSMfedswcsZFXrMk+1l0PmzSogPlvffVATBSEJ6Vsy4UVadV4jBUmBX
         THA8Gqw2cJp4lkisJ9OoTYqwTRlvuUVBMDy9mJr2MGigBI+Zv/Ri5yzP1qHUdJ3PR8Gw
         BcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXC4fF90Pa9uyfTfp+KPyvod62FLkDe4qXvVCVXDUUNOABakW4jj19jJ/fN0GjcrO/llJUYQtuIrCHe6Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAEy9gdTZcBAnXCL2bVcIFBf+2NHUeI/ESAe2fpuq55qN6gwP
	DfMUDoI8xZuUs/aMpi+8lNifLqsAiTdxyTdwXsSMOs0nAZQTK+OA
X-Gm-Gg: ASbGncsycgYfMRebIeSplWF5ZTT3cVhCHNs0DuySYA5HjgKQdxH2kxjN3v6T0YB+FTY
	7KfyiTfr9LikHSX3cGUGsI5O/5PecboCJiU9NMQ7kfjKtGhD9B+H0ad4pDJ1ZCNK/2Rm+Ur02d2
	5LvmW12+UfNP+u2wqB/dX62pU+GogAT888uY6nfyxzNICjWYcTilXZ8LNMPsPygiYhOzqHZpxJC
	ZT/O/Cix/OiJEK8/5Teybc1DWCi2/sTwasRNaDmIsgYZmc7klE6bcnfAexKUshO+VEjCTTLFbgb
	bDt1peSz5+GqiF/fBQAKwI48nFQ5vPeMrbr8q1UomN0ctG00Zum+Ng==
X-Google-Smtp-Source: AGHT+IGhGkDHRdJeOhaLSoJ/TQNmakH4kS9J3eSsPz1GbYhyddct7iNThdXIBsrasSx2t07KVMW9MA==
X-Received: by 2002:a05:600c:1d91:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-43958176addmr7986095e9.9.1739313048107;
        Tue, 11 Feb 2025 14:30:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a055910sm1134515e9.9.2025.02.11.14.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 14:30:47 -0800 (PST)
Date: Tue, 11 Feb 2025 22:30:45 +0000
From: David Laight <david.laight.linux@gmail.com>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: yury.norov@gmail.com, anshuman.khandual@arm.com, arnd@arndb.de,
 linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
 skhan@linuxfoundation.org
Subject: Re: [PATCH 2/2] uapi: Refactor __GENMASK_ULL() for speed-up
Message-ID: <20250211223045.5c2b92a4@pumpkin>
In-Reply-To: <20250211162412.477655-3-richard120310@gmail.com>
References: <20250211162412.477655-1-richard120310@gmail.com>
	<20250211162412.477655-3-richard120310@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 00:24:12 +0800
I Hsin Cheng <richard120310@gmail.com> wrote:

> The calculation of "((~_ULL(0)) - (_ULL(1) << (l)) + 1)" is to generate
> a bitmask with "l" trailing zeroes, which is equivalent to
> "(~_ULL(0) << (l))".

Yes, and if you look through the commit history you'll see it was changed
to avoid a compiler warning about the shift losing significant bits.
So you are just reverting that change and the compiler warnings will
reappear.

For non-constants I suspect that (2ul << hi) - (1ul << lo) is the
best answer.
But the compiler (clang with some options?) will still complain
for constants when trying to set the high bit.

That version also doesn't need BITS_PER_[U]LONG.
While that is valid for C, the _ULL() are there for the assembler
(when they are no-ops) so there is no way asm copies can be right
for both GENMASK() ans GENMASK_ULL().

	David

