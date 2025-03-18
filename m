Return-Path: <linux-kernel+bounces-566188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE993A6747B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2402E1663E2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0052120A5F2;
	Tue, 18 Mar 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="I1ZfZPoq"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571871BC2A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303090; cv=none; b=qCLKd28tI80y5M39En+vE2A6yBijGsLB44257GWYsuaPx1ZIi/yG0Sh3J9LAp+uIS2D0KA6mtpITYqKsKd7SPd94WH60NOftzbpQR1qfwX1lwPdfndVk1WbX+3BGUbxNNJ2dqwiRQU8ksjq9OFC21tZMcvLPVShZIRKWrKPZWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303090; c=relaxed/simple;
	bh=rAoZPPj6og3qbdTUd+kdK1TN+o8DFSq7sKZ7kC04U3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OJNpmYl08T+HF3Y3S3LhG9C4O4br63cXheqdU0hyW//13jKFsj60QJUush5d+vjang45cqnezgwUBPnmJsf5gyAHDDeUILmcP9haacCqpwogzvs02F/PPl1qMIvuSHTqLQZ1CcwDmI1ZKaMXIVb3kkQ0O9XfJEtM7Q8ymD07K1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=I1ZfZPoq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abec8b750ebso1012637166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742303086; x=1742907886; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=osstQuHAzfklsJKcyQ5YgpgmW1p4IsbG4RMShF7oP3k=;
        b=I1ZfZPoqpOHm5x2f/O0j2BiatAZG3C8MQY2LAWiXjm9oPMKrBs7YAqRjAQ+609G5LL
         Od3sRrg2ZSHpTQwYkTD+jpCM2yEfYMVUlNy36orvi6fZM4AjTu+S3mEh4Uj5R77wFQA+
         osVxoX4tojKiTNgY8F+hJmJ9AKo0zSOOxN2wFN2mXW/qXFgXtsK7eHKZDqA5AqwlQQBk
         E0dMRQmbBTNHDORBMOHRlr1dAJwnw1ZbP4pGZxzYIcdAlMZMgB2rXpf4kGK1YXhaPZTk
         5/6PtT2suO0+OKxchXrqWcu76vp8tUHns/YYmCBf3qRRDQ6c33OKmvduFWzphseVTYSa
         tLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303086; x=1742907886;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osstQuHAzfklsJKcyQ5YgpgmW1p4IsbG4RMShF7oP3k=;
        b=X3Lc23Nk9gUJDcqG2wNki6T4WQP1UjFf0PguNOoo+H/zUdsGhPWLK5SeCL+A9JfB6K
         zrBrhOrK66IzEvwcNVLeLVKmf8QAuVeEO0DN1x0yzsj81D01BmZeOFybMcmfUobJ1W4X
         J/+I/J7/S2WsrP/9C0Gh1z7pp7EAQn2ZnvQSGBJJh2rJPlVVnxqxlU7JwIurxGk6Jg+e
         K1oJE6wOjvXfFoFX7VB9AIuKqw1St0XthW8N5rtiCoiJAjsxbIUjnbJwHpWK97i1gHyt
         qQy36cpF6WMn4fyLlxCkY8mLg+frfPB+h5zUo5ZECFfAaBLVjJgMy3KAUZuTFqcF8xvl
         LolQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjYNp99c23te+jZz/fCz+WxOq1CU17KCiM3Dy/QPevMAXcpxlnjcsKW7ZaKV3Riv/Z9/WZy4YoiZdf6aI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8vtT8Ut+4dvLGUWSoxSWAGe4e4KbtZz9jOglcoms0ew/14y+h
	GdX2lyiZODfbJhDKxTqxs84OvOuQ9Dhta6Ftbg2r1M2/6grM8bLdJA8MAESI080=
X-Gm-Gg: ASbGncv3HF3VXqe+sZtJU0JM0naAlQYa0mKjxifSEr9m2+emmlE+fMa1bcdbI/vLqBH
	HFQNTB4+u9dk1YQQL5qny6nWlranQlTU4O2i7hzUbgxVQ0ypf86RhJUk8xxs2fLNhe9/TRld4zy
	BZP0JH1gSBWvCi6YQYDUeOiSvXqR30FCN+Yp1BwbvN9HH63oGas2qlFhOzB8+Plc+wIYql3g9T6
	FEZRA6WnOg+2CjVveF44RAhEc8PMp3QhZxKkgxQCg5sJqjwe96KYAGGi2e1cHhadTWlT5cIqL4Z
	4b3v4IEE1LvVyFlfo1cyBDVAq5+8YBAjkN5O7F1g6e8=
X-Google-Smtp-Source: AGHT+IGdh0WRUnaOS+0hMkCHSlVoqZUJ8K6VEh0bppD6ycHe2aggMOvABEGmZbqWM3TEqHXTbMgvOw==
X-Received: by 2002:a17:907:9814:b0:ac2:9d15:2ec0 with SMTP id a640c23a62f3a-ac38d444fa1mr418237966b.27.1742303072628;
        Tue, 18 Mar 2025 06:04:32 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::59a5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a47ccbsm840478566b.130.2025.03.18.06.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 06:04:30 -0700 (PDT)
Date: Tue, 18 Mar 2025 14:04:29 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	charlie@rivosinc.com, cleger@rivosinc.com, Anup Patel <apatel@ventanamicro.com>, 
	corbet@lwn.net
Subject: Re: [PATCH v3 7/8] riscv: Add parameter for skipping access speed
 tests
Message-ID: <20250318-ec2a990d55378039a863b94b@orel>
References: <20250304120014.143628-10-ajones@ventanamicro.com>
 <20250304120014.143628-17-ajones@ventanamicro.com>
 <1b7e3d0f-0526-4afb-9f7a-2695e4166a9b@ghiti.fr>
 <20250318-1b03e58fe508b077e5d38233@orel>
 <c5e174e4-4fce-4c7f-821a-cf3781becab4@ghiti.fr>
 <20250318-18b96818299ef211ef8ca620@orel>
 <d7a04d06-766b-4b43-8c42-2b681629c35d@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7a04d06-766b-4b43-8c42-2b681629c35d@ghiti.fr>

On Tue, Mar 18, 2025 at 01:58:10PM +0100, Alexandre Ghiti wrote:
> On 18/03/2025 13:45, Andrew Jones wrote:
> > On Tue, Mar 18, 2025 at 01:13:18PM +0100, Alexandre Ghiti wrote:
> > > On 18/03/2025 09:48, Andrew Jones wrote:
> > > > On Mon, Mar 17, 2025 at 03:39:01PM +0100, Alexandre Ghiti wrote:
> > > > > Hi Drew,
> > > > > 
> > > > > On 04/03/2025 13:00, Andrew Jones wrote:
> > > > > > Allow skipping scalar and vector unaligned access speed tests. This
> > > > > > is useful for testing alternative code paths and to skip the tests in
> > > > > > environments where they run too slowly. All CPUs must have the same
> > > > > > unaligned access speed.
> > > > > I'm not a big fan of the command line parameter, this is not where we should
> > > > > push uarch decisions because there could be many other in the future, the
> > > > > best solution to me should be in DT/ACPI and since the DT folks, according
> > > > > to Palmer, shut down this solution, it remains using an extension.
> > > > > 
> > > > > I have been reading a bit about unaligned accesses. Zicclsm was described as
> > > > > "Even though mandated, misaligned loads and stores might execute extremely
> > > > > slowly. Standard software distributions should assume their existence only
> > > > > for correctness, not for performance." in rva20/22 but *not* in rva23. So
> > > > > what about using this "hole" and consider that a platform that *advertises*
> > > > > Zicclsm means its unaligned accesses are fast? After internal discussion, It
> > > > > actually does not make sense to advertise Zicclsm if the platform accesses
> > > > > are slow right?
> > > > This topic pops up every so often, including in yesterday's server
> > > > platform TG call. In that call, and, afaict, every other time it has
> > > > popped up, the result is to reiterate that ISA extensions never say
> > > > anything about performance. So, Zicclsm will never mean fast and we
> > > > won't likely be able to add any extension that does.
> > > 
> > > Ok, I should not say "fast". Usually, when an extension is advertised by a
> > > platform, we don't question its speed (zicboz, zicbom...etc), we simply use
> > > it and it's up to the vendor to benchmark its implementation and act
> > > accordingly (i.e. do not set it in the isa string).
> > > 
> > > 
> > > > > arm64 for example considers that armv8 has fast unaligned accesses and can
> > > > > then enable HAVE_EFFICIENT_ALIGNED_ACCESS in the kernel, even though some
> > > > > uarchs are slow. Distros will very likely use rva23 as baseline so they will
> > > > > enable Zicclsm which would allow us to take advantage of this too, without
> > > > > this, we lose a lot of perf improvement in the kernel, see
> > > > > https://lore.kernel.org/lkml/20231225044207.3821-1-jszhang@kernel.org/.
> > > > > 
> > > > > Or we could have a new named feature for this, even though it's weird to
> > > > > have a named feature which would basically  mean "Zicclsm is fast". We don't
> > > > > have, for example, a named feature to say "Zicboz is fast" but given the
> > > > > vague wording in the profile spec, maybe we can ask for one in that case?
> > > > > 
> > > > > Sorry for the late review and for triggering this debate...
> > > > No problem, let's try to pick the best option. I'll try listing all the
> > > > options and there pros/cons.
> > > > 
> > > > 1. Leave as is, which is to always probe
> > > >      pro: Nothing to do
> > > >      con: Not ideal in all environments
> > > > 
> > > > 2. New DT/ACPI description
> > > >      pro: Describing whether or not misaligned accesses are implemented in
> > > >           HW (which presumably means fast) is something that should be done
> > > > 	in HW descriptions
> > > >      con: We'll need to live with probing until we can get the descriptions
> > > >           defined, which may be never if there's too much opposition
> > > > 
> > > > 3. Command line
> > > >      pro: Easy and serves its purpose, which is to skip probing in the
> > > >           environments where probing is not desired
> > > >      con: Yet another command line option (which we may want to deprecate
> > > >           someday)
> > > > 
> > > > 4. New ISA extension
> > > >      pro: Easy to add to HW descriptions
> > > >      con: Not likely to get it through ratification
> > > > 
> > > > 5. New SBI FWFT feature
> > > >      pro: Probably easier to get through ratification than an ISA extension
> > > >      con: Instead of probing, kernel would have to ask SBI -- would that
> > > >           even be faster? Will all the environments that want to skip
> > > > 	probing even have a complete SBI?
> > > > 
> > > > 6. ??
> > > 
> > > So what about:
> > > 
> > > 7. New enum value describing the performance as "FORCED" or "HW" (or
> > > anything better)
> > >      pro: We only use the existing Zicclsm
> > >      con: It's not clear that the accesses are fast but it basically says to
> > > SW "don't think too much, I'm telling you that you can use it", up to us to
> > > describe this correctly for users to understand.
> > But Zicclsm doesn't mean misaligned accesses are in HW, it just means
> > they're not going to explode.
> 
> 
> They never explode since if they are not supported by the HW, we rely on
> S-mode emulation already.

Exactly. Zicclsm is just a new name for that behavior. Profiles try to
name every behavior, even the ones we take for granted. Unfortunately,
like in the case of Zicclsm, we don't necessarily gain anything from
the new name. In this case, we don't gain a way to avoid probing.

Thanks,
drew

> 
> 
> > We'd still need the probing to find out
> > if the accesses are emulated (slow) or hw (fast). We at least want to
> > know the answer to that question because we advertise it to userspace
> > through hwprobe.
> > 
> > (BTW, another pro of the command line is that it can be used to test
> > both slow and fast paths without recompiling.)
> > 
> > Thanks,
> > drew

