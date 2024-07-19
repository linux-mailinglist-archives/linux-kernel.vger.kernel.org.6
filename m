Return-Path: <linux-kernel+bounces-257153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E829375EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D625B285AED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB5F83A18;
	Fri, 19 Jul 2024 09:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L3X8FZOr"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7482D72
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721381889; cv=none; b=bJkfdFMB4/ZvjPE2HSLnldhPUsh47eASGNpP5nHtm0ytuJZ2AQyRSn9VJE9J5d2KDWHH+tWmvXLr9ZvMjF6pXbOiPYgvK9kyXU8yjw7qcSpkj/UnImFDeP/u1biRd1gzLKTM9fxm5qwrH5BFpdpo62go6XbqWO7tzoiAwt5vwus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721381889; c=relaxed/simple;
	bh=QCJD0mQOiMjnGuAJudaL7EcJbEt4EzgBOz8VC0vUBAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAM/Mh29tEXxBZUw63h7A2jGNcQ+9uraIZjjdUTkyXAzpMVMda30bnxZXTB4RGBqcvb/haWbNKSi0ilbsJioNqXxy9jmRJxxJPdgrDaqqvbVkARD3/ghbihL8OyYpWNbgokikIKOdA86y2tcfwKtl/GsUAiidDLNe6nCoD6APUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L3X8FZOr; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so23862771fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1721381885; x=1721986685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHuQOzwZHF/RNpfChTvHFJsWi3ick1N/VEEIytMiyeQ=;
        b=L3X8FZOr1oTZ+1GEgFIL8xhA9re52AgE6Qz/RmZlOudm0TpQN2t2AZJ5n+/bFlPaCP
         vBJOmEIHrxRdEY443F2p52oyPgQZjzZbwpiz4e8UrSoKdiNGIdgKNJ8KieOiHRTlrpKd
         i82YJUgIzF319AIKeT3bhK7gi0Lft1HIUAAIpQMlJU1aQlHV2NbHyuhY5goctPQjslrK
         GHppjlOnB0DQRn65D6vfqGa6TxGUlz2C/vm1w8co4l52EwTtWbQKZX2ah/6i0ETbVzXE
         y92L4N69mpSWv9tK1pPIoGGyJj9qvqa+K8k77LjvsBl7DXT1rVkACkS7CXJiIC+N/LfU
         CFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721381885; x=1721986685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WHuQOzwZHF/RNpfChTvHFJsWi3ick1N/VEEIytMiyeQ=;
        b=Sp4la5rTa9FPl9Nw694uJuwwZ8n+nGJlcaQvPbHFy148NTx5Y29dAhz0xRUjZqPxi5
         e5ZgWhs1wpPnRn4p2s/Wfdb//3GOQkQ4p6C/J8onpcvbevUwN9Tnb2Xd8E/tmjgx4LOw
         jvn71wtfK0YuXRyEbGlEnNu2ewBM6z5TS+uU7u69rLkOaCPsPSvte5EAdS7gFqsoRhTO
         fptP5AwiJJ8LcY1OAAM1ll9USLvYrilUr8R52af9dHqf3sPdqucMV1U6IcMbiA/wIlxH
         IL2Tzr9p/hWzQ9l6/VdJ1UOsZfI9mbSVNWFVTE91veUz0N16o2ASyhDyH3mxVhIrwkWp
         Dn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPORo2HQm6Ati2PJaC4p+KhIGZL9qKOeS61rVKh2VMqS3/dgeuN4iki12warqLqsGsXlT2Q0YwhsT9CoHO6C540TyP7KExexdDwBos
X-Gm-Message-State: AOJu0YxSU1Db3pHbu2CC8NAFEig9EYoeXKKl+YB5ooED9tUSOYS654AZ
	nyA2BrPGWstkLmgzayycQn8ALIAyU8x9EBdyTQ5PbKOpAquFCFPvtgjMD2M0QuIfhNAxLKhJYv0
	Nosv/IwW8Z2yBsqBMMYMtOl69p5BDMF4XKTyehg==
X-Google-Smtp-Source: AGHT+IGiJNTRWlBgnX41CQFZmILGxpV1J9kBUt1OoMxruvBGLdHaDWwzwf0eXsqOE/wPqccfZTwogeTX0F7BgSX59RM=
X-Received: by 2002:a2e:a17b:0:b0:2ec:596c:b629 with SMTP id
 38308e7fff4ca-2ef05c726bbmr33287691fa.20.1721381885303; Fri, 19 Jul 2024
 02:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718152254.16007-1-eric.lin@sifive.com> <12bd744ea481c8a3505e6f4869d409d24d3db795.camel@maquefel.me>
In-Reply-To: <12bd744ea481c8a3505e6f4869d409d24d3db795.camel@maquefel.me>
From: Eric Lin <eric.lin@sifive.com>
Date: Fri, 19 Jul 2024 17:37:53 +0800
Message-ID: <CAPqJEFp+KHku2ygaHhv0YP3Wy1RhuKOZ33EAonzaUxxkM5z-Fg@mail.gmail.com>
Subject: Re: [PATCH] perf arch events: Fix duplicate RISC-V SBI firmware event name
To: Nikita Shubin <nikita.shubin@maquefel.me>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, aou@eecs.berkeley.edu, 
	dminus@andestech.com, inochiama@outlook.com, irogers@google.com, 
	jisheng.teoh@starfivetech.com, jolsa@kernel.org, kan.liang@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-riscv@lists.infradead.org, locus84@andestech.com, mark.rutland@arm.com, 
	mingo@redhat.com, n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com, 
	peterlin@andestech.com, peterz@infradead.org, samuel.holland@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nikita,

On Fri, Jul 19, 2024 at 4:51=E2=80=AFPM Nikita Shubin <nikita.shubin@maquef=
el.me> wrote:
>
> Hi Eric,
>
> Nice catch!
>
> Shouldn't it fix every patch that copied affected 'firmware.json' by
> the way ?
>
> Something like:
>
> Fixes: 8f0dcb4e7364 ("perf arch events: riscv sbi firmware std event
> files")
> Fixes: c4f769d4093d ("perf vendor events riscv: add Sifive U74 JSON
> file")
> Fixes: acbf6de674ef ("perf vendor events riscv: Add StarFive Dubhe-80
> JSON file")
> Fixes: 7340c6df49df ("perf vendor events riscv: add T-HEAD C9xx JSON
> file")
> Fixes: f5102e31c209 ("riscv: andes: Support specifying symbolic
> firmware and hardware raw event")
>
> Reviewed-by: Nikita Shubin <n.shubin@yadro.com>


OK, I'll add every patch "Fixes:"  in the commit message and send the v2 pa=
tch.
Thanks for the review.

Regards,
Eric Lin

