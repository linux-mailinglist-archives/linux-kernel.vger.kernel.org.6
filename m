Return-Path: <linux-kernel+bounces-407916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A49C7917
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 17:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08629B448BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D810204F82;
	Wed, 13 Nov 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K7fTlxtC"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325081632F9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511920; cv=none; b=TT1qCAWbOP5etxmUmruht5UcWL396sB5c5UJ90YCR9KXGkwEwXR9Lb1qKfZ2pdeYhsGBjpjXf5L32aYBbSdOnq9Tw5FEvWWH3EOXmvzwMF1U5sDYyIYRWhLPSguPdJYeDzaUuOiHJXB8LHxPga5Bp+gSZWedUOWrspHgcxXCAg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511920; c=relaxed/simple;
	bh=xqgXxTxBWAWFFuhzT7ZUPnsnzXEdn+x+B/SzUaMtKJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fC8i8Vi434NpNQ9gFDy+0hSHLiz98OSpP/H/pC45kMVSOZTeyxc5TU94Kw/fbclUNMniB1ULkb4PdYWfYTAOO6Zec50mDfstUqVKtZN6Dl+u5PZs0mW2s32kRFBrAnw92oCbuiUznxrBNMdPEWiB5vPgd6VaCQpum+ahdAE9zlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K7fTlxtC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4608dddaa35so314411cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731511918; x=1732116718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9GgnVY5FRHI3/LENNtRtKpX8Cbd4vLaiASbNO/6g4o=;
        b=K7fTlxtCfU7JUaNVNlFB1RK9KehX7nYk3Uujk1TcP01uhXmzMRRPkGtc320qSCyjRy
         c71wf4j9gXE+DP4BiB6vUJdUwZlbJBhPJDvNjTxT/EoX2SG26HKWXIy86n9w4z0t93Ti
         eS67SgDV56vNS/HxoYxHv2/W5DpBMxFaJM62/V45AgrzZqEFOZoaFP9PrikZ67hWAQeH
         Pl/7V7po9UkafY2PK8/D2DZzh07b3wi7n+41OoFhZijszCxN43mQpY6FMCx6A5oO1xve
         aGY9RV+vpuysW5fKgKZhNkuMbkDUw+KtekNpZCG5c4h5NPdS9JL4Dr2rNaufSWcsw2jZ
         u0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731511918; x=1732116718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9GgnVY5FRHI3/LENNtRtKpX8Cbd4vLaiASbNO/6g4o=;
        b=dKH81TpdJ6gQ7dkdItAxwq+x6U8VGb7mfJAfMhhqTcWSiBZuiB9Hgb8Ctm/UQIvaDV
         p3XO4xaKGyq/u0+0RwClo+oETEjKCHeYxDGXt1LH7vI1u/2KOvAMn1vHOFhan0F3iVxc
         mLnWbfPDuSRNKWc/+fS6ELgpa4JvkJQY7GtEcptlEnqHZE6CrwNO7NhJzppEusQGPtRP
         3d5jmM59NUqXXr8Hg2YM/D+kxyMCgHJQZv2lWoXWasmg1z0mp92YKOB5ccS5xhd1/Rnr
         C//wwtfp9VIz7UAEZpxPGl4wBm4CnEFbQOsheGAjnUsKwYjdeXbyFwWenn76eH/bgJ5D
         RFEA==
X-Forwarded-Encrypted: i=1; AJvYcCXTAm004SNF2m+Japm1JX3Jl6ucfnHTwprEoAu+k2MfEYeeI5ngnIO0zW4C5I0HWX6/omoUPdkfq2/YU6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCZ9m4q21COw0fwok1L/zuJA7d5axEnvnavlmfbzAH72XAn0D
	HkiChyawB6q8U+7JUEBakdP0cY5YX0s2TrmPP9E8GrBAQKegxQ4xGQ3eQQji1wmGEeavYK4tYED
	8W6y52P1dgzNnM4FDvWBKjYBoLUTBKn2aGBQK
X-Gm-Gg: ASbGncv4ZRhzbXgGuUIbAHQoFhQFDRp08TgJfC906NiXyMj2B+BSfPRakUmkEWs3zeD
	6bwLs77PIqeJU119bxfrHqetF81N8kCXF+Rjr/K1n0HuoG1EnIWc1lU5MN9ixHQ54
X-Google-Smtp-Source: AGHT+IGk9uxtnYHtkUgg0UPzg2N98kSBmf4LY/P7qNUHw/OFxW5T7HTd6jN4yeLp8NXR4qXMG3dc/DR2Pk6+l2taNME=
X-Received: by 2002:a05:622a:1ba8:b0:461:3e03:738b with SMTP id
 d75a77b69052e-4634cadb528mr3052931cf.19.1731511917940; Wed, 13 Nov 2024
 07:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com> <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
 <LV3PR12MB926503BA63C616562E508D8C945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
In-Reply-To: <LV3PR12MB926503BA63C616562E508D8C945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 13 Nov 2024 16:31:46 +0100
Message-ID: <CA+i-1C2JXYUBnE7fn6df0=KR4KeD0VgwO5Cc2xRhO8rBqC_p+Q@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: "Manwaring, Derek" <derekmn@amazon.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"x86@kernel.org" <x86@kernel.org>, "mlipp@amazon.at" <mlipp@amazon.at>, 
	"canellac@amazon.at" <canellac@amazon.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Nov 2024 at 16:05, Kaplan, David <David.Kaplan@amd.com> wrote:
>
> I don't see how ASI can ever be a user_user mitigation.  User_user attack=
s are things like influencing the indirect predictions used by another proc=
ess, causing that process to leak data from its address space.  User_user m=
itigations are things like doing an IBPB when switching tasks.

Well, in the RFC I'm currently (painfully slowly, sorry again) working
on, that IBPB is provided by ASI. Each process has an ASI domain, ASI
ensures there's an IBPB before we transition into any other domain
that doesn't trust it (VMs trust their VMM, but all other transitions
out of the userpace domain will flush).

In practice, this is just provided by the fact that context switching
currently incurs an asi_exit(), but that's an implementation detail,
if we transitioned directly from one process' domain to another that
would also create a flush.

(But yes, maybe that being "part of ASI" is just my very ASI-centric
perspective).

> Also guest_user mitigation is not a thing, did you mean guest_guest?  If =
so, the same argument applies.

Oh yep, sorry, and yep same response.

