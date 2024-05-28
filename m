Return-Path: <linux-kernel+bounces-193178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 123EA8D27FE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 00:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C45BB2384A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1313E034;
	Tue, 28 May 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKeCzv1/"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5213DBB1
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935079; cv=none; b=HBZ7SjQSRShSKq1/VY8DGZG/RF8X5dpD7D6ocLh0Ovf4nrV/QBpIV82ZO78SI4Pp6Kj7r9pkWT9ab3KqWIMy5RbjHWt7FMpsSSUdCpc9OvWlk7z8u6gSUIeGUi+tov5qII8tlgID0dJrt2uI1TgEY+I6Xwt2yVr7LX7RgxKqs3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935079; c=relaxed/simple;
	bh=GSSEWukZFE2Gu3pijabeLIdOL6GHuqpyPZcN0QTIm28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gewnEy1jBBw8Dcc1jK8+Z6vrPK3x9b9kTt8jKSPtlTYvAg1LqwkiMjSEeEmSdggLD3SwdKZtpEP12eVVmkaXUDzu5lggwY+nsCSrDSKixyrTVtUFmu2+h+5AYFa1YBceLBLUU3N2/NxgUsw9ri+ZjVkhwDx3CjJ8WTwWXKJ56Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKeCzv1/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso6587a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716935076; x=1717539876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSSEWukZFE2Gu3pijabeLIdOL6GHuqpyPZcN0QTIm28=;
        b=aKeCzv1/jYgKygQAlr+iNSxFuVGfo3POHpZK1q/Y6zm92EoWuzdK8V7Sa3nUJZoUXh
         JqpG1fJeaEiEtLGoS/Qy9S6usn9z4SHt9kv/iqKks91myQWrFi6hkd6MAA6gOScj4QuJ
         nx+I1WvSBeWOxhRXNHYk3QAETrT54I3yY1IN3A72PhGu24WeoEKv6pI1r7RZXjWEl3G1
         C/SJDkLU9gxX7T0RBj/OfQbfRXzGclrJueSlaap7YmzhJxajTRAXGg5G5IELG3JbjJa8
         I9PANMdLbPcABZuV5IdaW2oa7odPZBnQnuRLvMcTcHuf6+cVczvADj4C8YczwpXJLDNZ
         iMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935076; x=1717539876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSSEWukZFE2Gu3pijabeLIdOL6GHuqpyPZcN0QTIm28=;
        b=hqT7EtTWt/GFtr0635ZEoc8MLKqts1VyCJcHI3Y9E4EcPFRi2l2+14WEmHpdRcS6V4
         i8ZpN5+TdphmNSC+9hZsO3zV3Aypv/yFqFDNg55RTtGduFWCGSnQGMmv2l7OxIBbbdni
         QhSNB5XM25KEUJ78zJrxo5K/npvFtMmcTDYSLQYWiqHguPjLkQJJLLXbMHXjRmN3/SaZ
         Ssns+T2OOrTXG3MBtLgTXHiVxKm2EASveEobryBDiYWDysnHzkurivKQvJLSl3Mu9Fjc
         FxVJZvYypmqpqGbAl8MDRPo7Y3OtTKHyuFvN2na+EFD0Jfu5sWB0eEuJHNBd0YVpVmmb
         bPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhYEtiA0zjRSiWVjaxu4Pt5TWecT6+AZrYnI+mag16ovaKTIk/Npld8T15yBeGInUgm3otGa/x6hF1iS8SoGyrzZFXOWgiIgmvcLiN
X-Gm-Message-State: AOJu0Ywmym4xxHncY1smftIQcMRe8Z7QXRrTQMO+SFzoq1ugxoz7rHGt
	xUwZYeBI9dwP0X3Hw9gfDmlyFTskb+aWBJWnnWJvdbi75ldHF7XMekpSzLf0/0wEgCq3woezsqk
	jjTQEJP+1GGFUN2MxY7NSa0Q1WJVpLphf/Zld
X-Google-Smtp-Source: AGHT+IFH3u3WiLbWyZD6sTqsaAWhFG+2x5wPCWYFrNFm4bc5hVfvSyoLJaVBFsdBHGMrup5HuCyUU4cYpTZ6jSKz8xw=
X-Received: by 2002:a05:6402:553:b0:574:ea5c:fa24 with SMTP id
 4fb4d7f45d1cf-57a05d20d22mr6096a12.3.1716935076207; Tue, 28 May 2024 15:24:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503041843.99136-1-jhubbard@nvidia.com> <20240503041843.99136-4-jhubbard@nvidia.com>
 <dbca543e-224b-4fa5-ba23-37f4957ff79d@nvidia.com>
In-Reply-To: <dbca543e-224b-4fa5-ba23-37f4957ff79d@nvidia.com>
From: Edward Liaw <edliaw@google.com>
Date: Tue, 28 May 2024 15:24:09 -0700
Message-ID: <CAG4es9Vi3Kmvb0Nn2FNGmVL2YB_5qcJHunUaTRuSy=mkiLhb0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] selftests/futex: pass _GNU_SOURCE without a value to
 the compiler
To: John Hubbard <jhubbard@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	"Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 8, 2024 at 2:05=E2=80=AFPM John Hubbard <jhubbard@nvidia.com> w=
rote:
>
> On 5/2/24 9:18 PM, John Hubbard wrote:
> > It's slightly better to set _GNU_SOURCE in the source code, but if one
> > must do it via the compiler invocation, then the best way to do so is
> > this:
>
> Hi Shuah, Edward and all,
>
> This patch now seems to be obsolete, due to Edward Liaw's comprehensive
> fix, "[PATCH v2 0/5] Define _GNU_SOURCE for sources using" [1].
>
> [1] https://lore.kernel.org/20240507214254.2787305-1-edliaw@google.com

Since we're dropping that patch, would we be able to merge this one?
This should resolve the futex_requeue_pi compiler warnings with Clang.

Reviewed-by: Edward Liaw <edliaw@google.com>

