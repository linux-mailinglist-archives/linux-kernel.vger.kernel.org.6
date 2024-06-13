Return-Path: <linux-kernel+bounces-213708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EBB907914
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A26DC1C22B57
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33C8149C4A;
	Thu, 13 Jun 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I1yXkfwx"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F012FF71
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298046; cv=none; b=ZFoG4lEYs3d8eFMhaToZvGF3cNRVun+aod8Fo22jRXhyltR9IGy1P6TLiQKh55nlG8z6SEoWqHxxlytx2y0/XZeRDs1kY1xcWsP71NRu0WxetJcN72IhY9+FEPYqu3inVR6of0eZQN8dUlPMT2SVrZGI+WpHzPZIeaNjz7OwXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298046; c=relaxed/simple;
	bh=Ly4tuRHzyObqMrdCQcVHBM/dbQM2HfWbfZxG9ysL5rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWNB0cQiaHomZX86eknnQVUEh7IAC/PXNSKWJXrbQ+feJLRKbQ1pzKVH4gerRELJe3hsdCRyFRpnycOmFPTI72pyL2IUbBrqEMWUYI96iLdz2vpHnbRH1MFuHaeUzg++lrdnPqPWE89VTiAZ4ha249l7iNVuIAi/dvGktos//Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I1yXkfwx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6cb130027aso87148166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718298038; x=1718902838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YYzQevevyPFe2MJKTCzM3k91AB1OA/O0y28PpzZxNT0=;
        b=I1yXkfwxdcXoEsuf8a/7GV7027ElOzXhYb0se+uTVelxHOYaeOf++OxVmF5eoh2Bpx
         roYLqZWa6BHDSRvu0Y4cf3KBCCtUfQE0Exrn0NpXmhoK90cKhM+rPLoMv0iMbqbX6SNW
         mQnz88BYitVVR+heZtD4lCPrfAcs+lpWoJzws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298038; x=1718902838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYzQevevyPFe2MJKTCzM3k91AB1OA/O0y28PpzZxNT0=;
        b=ldfWwbOi6C3LGMShAp9DsLiX+PuxMQ7vjP7se0xBV/rzYphLmnqScaXl1DjQtGd3jh
         Ahi/aR3lhyOh0mQPX1waVGinzLiwxyG0yJ8dWKJmTvhK9ZA7Oam0RSeOzMzWcSzsrRDB
         gk/X10yZdlgPl5x0DwvL0kPelDewg2MDmzAQ3FJ0tu9eKb+wgFNy2N0gonMqNqEbajxO
         8eDk0+vnZ94CIGUCh4tqkmSVwYko84BxzV3HHc6u3k62kmNV13x0zhqZJPATaTUWXioO
         4dTH4A8w7jqTn4KWrZTG22h30kY6fskDkt/jR8iuvg6N9L0g13wQVl3Gw731p9ii/+Pv
         UbtA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Tr0CgEMBLDRIsx8+BoTSmO37A+YUOHH4HlDHpVKlUlzLpOgrFSMbIJA4Eeyr8Kl2+8IJklCF+FeO4+vSgNoP4lOEcZEnItgx2rjP
X-Gm-Message-State: AOJu0Ywc15lFTrMrvOZvCF1rbF8t4CrwhdOdYuDCbcppLHN1JZ+DQP74
	SSdJpPOymOITIFzU4P0nh72KLVdqHOJaRlsDyIOb+sk1qP0VrWUEH6TzDyODIGtRhqYvIIwcScE
	UEGHYBA==
X-Google-Smtp-Source: AGHT+IF9cPnemXrBgOPoQxN91YGL9KumwaE3mqAeMlmqMJgfzkE0AjtPUpM9f6LKK//l+z2X7cKgKA==
X-Received: by 2002:a50:9b4d:0:b0:57c:7826:1dc with SMTP id 4fb4d7f45d1cf-57cbd6778f6mr332347a12.8.1718298038388;
        Thu, 13 Jun 2024 10:00:38 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb741e725sm1093715a12.69.2024.06.13.10.00.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:00:37 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6cb130027aso87146166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:00:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlhVQahshdrXfnrj/f5+w+Vz0kJBh2w9wawM+OmaH91XVHn9ivWuPjB13QmsP7fFO0D0ySpe/0ErDKFspG7VHm5gFEfm50tgY1V6BS
X-Received: by 2002:a50:d797:0:b0:57c:60fe:96dc with SMTP id
 4fb4d7f45d1cf-57cbd68e58emr414547a12.19.1718298037280; Thu, 13 Jun 2024
 10:00:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613001215.648829-1-mjguzik@gmail.com> <20240613001215.648829-2-mjguzik@gmail.com>
 <CAHk-=wgX9UZXWkrhnjcctM8UpDGQqWyt3r=KZunKV3+00cbF9A@mail.gmail.com>
 <CAHk-=wgPgGwPexW_ffc97Z8O23J=G=3kcV-dGFBKbLJR-6TWpQ@mail.gmail.com>
 <5cixyyivolodhsru23y5gf5f6w6ov2zs5rbkxleljeu6qvc4gu@ivawdfkvus3p> <20240613-pumpen-durst-fdc20c301a08@brauner>
In-Reply-To: <20240613-pumpen-durst-fdc20c301a08@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 10:00:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
Message-ID: <CAHk-=wj0cmLKJZipHy-OcwKADygUgd19yU1rmBaB6X3Wb5jU3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] lockref: speculatively spin waiting for the lock to
 be released
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 06:46, Christian Brauner <brauner@kernel.org> wrote:
>
> I've picked Linus patch and your for testing into the vfs.inode.rcu branch.

Btw, if you added [patch 2/2] too, I think the exact byte counts in
the comments are a bit misleading.

The actual cacheline details will very much depend on 32-bit vs 64-bit
builds, but also on things like the slab allocator debug settings.

I think the important part is to keep the d_lockref - that is often
dirty and exclusive in the cache - away from the mostly RO parts of
the dentry that can be shared across CPU's in the cache.

So rather than talk about exact byte offsets, maybe just state that
overall rule?

              Linus

