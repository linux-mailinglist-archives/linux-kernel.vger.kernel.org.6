Return-Path: <linux-kernel+bounces-368479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1EA9A1043
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F118281B81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A0210C25;
	Wed, 16 Oct 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4rQ4n+3"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4406F143744
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729098207; cv=none; b=ifWfY4Ct69c8XJTaSN4noEEgpZi2FVPALX3sjWBezYt47Quzw6WEg574R3lYaBaH8Gfu0/YbUFLNtZnCc+jmUNnc3ru3N10r2jYtzdGUa2uztJxN0lxeTuv/Ey3v7kr2BFMqcpvDhNPvhHNQDmUD+PsmHRE2ef9q9zYCi9KV6nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729098207; c=relaxed/simple;
	bh=f/ummaRRuCG9uUiZCZDzKV9LYoJWA6E413cWfBgrgkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQwchp8M0HgKocs/U87IEnMm6zKYSMNtXC58eHLGUu8A33RGk6sby44Rf/olTYP151i6xO03Aoa2NwwNrUUMV9bbUEi0WDXwfYar9DWFT68dVAm9omYbwVgpZpqP5VLJVSPgotZt1AxSDWbJ8M/yirKYlmsEe7oyik5LPd5nId4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A4rQ4n+3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4fd00574so29194f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729098205; x=1729703005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6NQw3g/UfWLYCW0OnmDDAfoLvAyPJ8Gwf5pyCdbD+M=;
        b=A4rQ4n+32LXTFOXengormNRcuHQwH0mduk0XWL4Lb9IHxM+y8q4SnTFfUS1+JIcrco
         ft2dG+9DRDpvgMHdQ2Mc+sDkTcKNEx6rg6+g4j3+zcgC0YheonB6Gh6ncxJANJH2h5vl
         dnNX4wmVn0SYdcH7cfMlYghtpIcygktb6gCFlWfXjUotZD+NEdGo4R+kdzkfTTDiJCiu
         HKp/dVxIz4YqVk7eui7mYgeMl9zFREMJv26+DSpFiheaZdUbcnepwHVnKhOq56EpeDvM
         DymW6i6oPs9Xn4ROqFIHSUzOsF4SNrUQ+t75gRcg4xy/6qe6jKuZw6Vlgt6bUd8KFbV2
         wMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729098205; x=1729703005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6NQw3g/UfWLYCW0OnmDDAfoLvAyPJ8Gwf5pyCdbD+M=;
        b=Boo8kzyLXjzrX84ksfx/8Q8CfFRE3HZ4GmKkcTOOn591aEDOoounN/cVEXRPa4k9HK
         okgeIXcvNbcwGJZ0CIEWj9uYRw8OppkNv7iUKUsiY66pqYayyWS0bm0iA6GHu6zHRfEu
         V5Sc1/fGzXlVMWFo9Vu2spelsv95hSy6qbJZY8YQUoq7csj/19b1OP8UIUCxz5+5XGOC
         XXmK00QCVNnLziRk86Nnh2ty/kkB6OyE6o/cRKpfiokN/a2M9xn4CSvp9NJc+cHSqQJ1
         8CgOflJSi72Tu9QS+fB91TSymZyITs2DmJbWYKyimgS1UhpwfuBhy/s9cLWJ3NEmDHWh
         fw6A==
X-Forwarded-Encrypted: i=1; AJvYcCUj7qgAW0i+Wt6a5UwTayQLxdt3uWzZ+U98RXjCmRkZo9AVPlze3a7WLrzB5n8jafGyHB0caFjEoCoB7JM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL54PCIa11iEc2wuJ2VJ0Nm6vfoY/7LtlNQK1SUzMyf5l8Ma9e
	vsjIneQaoq5zQNJsBouwR5YkUIbM4MWMZEY+SOlU+7f7rQO5K3oqH4hRaBQ/Jj+gkCuBxAg9zCm
	yffiEMUnV7nPB41UPW1cV9S8t0G5n7p1mGGX8TG5g6XsavRrgfglt
X-Google-Smtp-Source: AGHT+IEqeiZSkbrI4YnBSZrXg2BTTyC1pkP7ycvQB0JOgIEkg8lTnedO3VPHI70vDkeusHVa0f75pXN3IJk45GFNGq8=
X-Received: by 2002:adf:fa87:0:b0:37c:c4c0:4545 with SMTP id
 ffacd0b85a97d-37d93df72e3mr185806f8f.10.1729098204259; Wed, 16 Oct 2024
 10:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com> <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
In-Reply-To: <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 16 Oct 2024 10:03:10 -0700
Message-ID: <CAKwvOd=m7bMWLVNRcr6BA_gBaqKmZ1NOd0=Sa5322FZZ4jAmqg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when
 comparing in percpu_add_op()
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:45=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
> Since I'm making comments, I would have really appreciated some extra
> info here like why you are hitting this and nobody else is.  This is bog
> standard code that everybody compiles.  Is clang use _that_ unusual?  Or
> do most clang users just ignore all the warnings?  Or are you using a
> bleeding edge version of clang that spits out new warnings that other
> clang users aren't seeing?

Note the W=3D1 part in the commit message.  That's the part people
generally don't test with, but the bots do.

On Thu, Sep 5, 2024 at 10:04=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When percpu_add_op() is used with unsigned argument, it prevents kernel b=
uilds
> with clang, `make W=3D1` and CONFIG_WERROR=3Dy:

--=20
Thanks,
~Nick Desaulniers

