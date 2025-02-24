Return-Path: <linux-kernel+bounces-528114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E270A413B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150E41701D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 02:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968491A3176;
	Mon, 24 Feb 2025 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzNg+v+o"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DA1624EB;
	Mon, 24 Feb 2025 02:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365440; cv=none; b=Icrqn6h0pOALeO122QF8vq3atcDook5W9ie1UCQb1pXheAAKY4r+ENJwdUiKdvjEFreVEmwUyAtj3tOhFAxJV7zUFZNxb/F4gFkLHEQtshJz1OBgXj27kQ26gGtSSSTVm2wBlDj7XCqJ/nFCd/NhRdtds3zjougypkOY33/xQvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365440; c=relaxed/simple;
	bh=9JffjOzzcbHGXeqyKxjOYJbbmsB4a1Au97yRsFSOW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEIEqdeWTjPuIQj8PSLb61jKg46r2ftot8iyawPkRtHphXXX4S22Xt4MhALzbXRRn0Dlq+z8cpOo+XDROFR3qYgIgHKUTE7mBInxxwYQMNSCPygVJEN5CsaTFX+MokkO/W7s6FxxcvtRboy37V68sI5eNIlQdwfrM7YaTP0PYUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AzNg+v+o; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so7021908a12.1;
        Sun, 23 Feb 2025 18:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740365437; x=1740970237; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOnUhudnk/ghJ69v1pIjycejO9QGM71BCF3/L9nVTWg=;
        b=AzNg+v+oLda4nvtf98teqN4Ul7vCnJTyXCRVxXFSDqpTN/2c+wb213iX5hgX5nxdXa
         7mxkDfVAu20p3XXuyqVxWBsiQ5Rf1qQPOvmzGCsuevykTEeupuDHep7HWzXd6CtLApu2
         eRiZQvKNXFtji0QH5xl4p6LZyl19hosRJvTXeC3txvx5Dni9Y3Tfm6d8klvTAmvJpH9f
         MwZq9M6HuFvlS5bXlO3K77Q+VuqZQssP0uyu3f2rp/ioNSy317VwSf7EfVfsYr8IzHRA
         mWn8mIQYo5qtmBc+q43v4YXVnKL+2UVIK8iimBU9fiuQAw5lFnNNB9SYjnFFeFVH0mvk
         VjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740365437; x=1740970237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOnUhudnk/ghJ69v1pIjycejO9QGM71BCF3/L9nVTWg=;
        b=jkBaQUU1bS3ge9NSnX/pw+6EigE3KXUUrNfQqJVsejqK18v2axIQP7qBPmkTi3OI49
         VVmvW8Wgi5cApyx8RFyLvSzA0Ron8r5tDnRYqcgu4i9TMzf9YR75EOEbeGzkQmteDbtb
         gUYEctl0dzl70MyIHEZsHvEjSPtZdzxai+yI+ExUtHnZWclxaEErWXjKEC1wG1Ig3TGD
         DyTl7HLsDTxtOCdoxxroBFoquqFuJCgPVy4m+Eb82ABvdOIKcVkLZQ8V7VHeZBZPDlRc
         3l4yvOM6aOPAMp7nw1LQUHIL+wUZ1N3sdGx+LOsKN7cbhzXagLD94guvv+V0O70l8yvS
         SRaA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8QrxvWz7F1nLQKVG7y1/Z1n2+30z3VYkHJ1rg1ZxvXm7qG64Uh4sfjyNz7JGmOzcIOreFiweiM9l@vger.kernel.org, AJvYcCX9DDxiocNXg8BvkNbiBiHBuPZInpuW5fQVvP+34RergTUEtRoGwdaU9li9H4SSj5bm4xHRr2O88vL3@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7eV0XYco0W7eQtsy7fCnS1wNbk68UoITBoul7Bp4Gkxq3XYC
	aBGdSPcfI7lY5iBjD2ZsjOgsvrzuwuZ20cRHqM02ETVhnc2+JgMF
X-Gm-Gg: ASbGnctLOhTzXJmUG8m87Wq4SW7nvXAUqNjGrUtvBElAxGtMHzeW1nm+D8haRikyU9R
	kVbDucry7VkiqqnBx/A9Ka2d8cdNytrKVIezgSqJdd+7ByDMjLbU9ECYxrzNSHHY9CJ5cIwU7yn
	6JKfZQ8MvOFoKmCeIy/jXpbw0ZavSMflTyMQTBidqFwhkSN3IXGyNEk6Du12GiWLZcM+5OaHaO8
	tbstQ1orbqCoB69OA9U/fz0BHLtIMX+55Vtc6pRcsOnuWkTrpoRhpvuU7+d3Xif9o28XyAtvLnb
	j4lfAkddKEBchxmVf+PgfPBykw==
X-Google-Smtp-Source: AGHT+IEiyHF/bof5atxJYJ1aq+nUThhjZS2+A2L49uqXPzE/BpL2M9HK5ZwzhlgRX2ZUqUt6sCy6Hw==
X-Received: by 2002:a17:907:72c8:b0:abb:eec3:3930 with SMTP id a640c23a62f3a-abc09aed093mr1341918666b.31.1740365436292;
        Sun, 23 Feb 2025 18:50:36 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abec0324d4bsm13923266b.108.2025.02.23.18.50.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Feb 2025 18:50:35 -0800 (PST)
Date: Mon, 24 Feb 2025 02:50:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 03/14] memblock: Add support for scratch memory
Message-ID: <20250224025034.g4htzqgm3r3ja4yy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-4-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206132754.2596694-4-rppt@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Feb 06, 2025 at 03:27:43PM +0200, Mike Rapoport wrote:
>From: Alexander Graf <graf@amazon.com>
>
>With KHO (Kexec HandOver), we need a way to ensure that the new kernel
>does not allocate memory on top of any memory regions that the previous
>kernel was handing over. But to know where those are, we need to include
>them in the memblock.reserved array which may not be big enough to hold
>all ranges that need to be persisted across kexec. To resize the array,
>we need to allocate memory. That brings us into a catch 22 situation.
>
>The solution to that is limit memblock allocations to the scratch regions:
>safe regions to operate in the case when there is memory that should remain
>intact across kexec.
>
>KHO provides several "scratch regions" as part of its metadata. These
>scratch regions are contiguous memory blocks that known not to contain any
>memory that should be persisted across kexec. These regions should be large
>enough to accommodate all memblock allocations done by the kexeced kernel.
>
>We introduce a new memblock_set_scratch_only() function that allows KHO to

memblock_set_kho_scratch_only?

>indicate that any memblock allocation must happen from the scratch regions.
>
>Later, we may want to perform another KHO kexec. For that, we reuse the
>same scratch regions. To ensure that no eventually handed over data gets
>allocated inside a scratch region, we flip the semantics of the scratch
>region with memblock_clear_scratch_only(): After that call, no allocations

memblock_clear_kho_scratch_only?

>may happen from scratch memblock regions. We will lift that restriction
>in the next patch.
>

-- 
Wei Yang
Help you, Help me

