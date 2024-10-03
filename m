Return-Path: <linux-kernel+bounces-348937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E67398EE24
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B120A1C21BCB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE288154C09;
	Thu,  3 Oct 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjdGvVG7"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87AE10E0;
	Thu,  3 Oct 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955073; cv=none; b=gB6r1p7Z7fP1XiqHp1f4FSJHTCpnMfRMoqqheiSEYd45bvj6kGg/ElswuB3cbC7eF/gg3sGt5upoFeo9s1YXxiCUjUeFln/rBM/9ImoKVXF7VNp/SywBaDgWaLp1e0ccU6QkV+vFGTgluAGlUwSOJxQrmj+Vdn8eR8UlrqM+w7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955073; c=relaxed/simple;
	bh=gh7AiH1TZgK6DdBNLlxO2DI0t14/pxLdW+EFid71JnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7LKqgF2BXKIbazpylr957JJDNzOiGi4Igg3Vkcg4PjRGc+Um9f49NyYnHkvEYebQJE1YYNif0iNCTD10HS9Toz9N6Co9pm3u9s0poYMUlhzfGM5uUU3DteZznwxKSCdA/8TIGpusNHig5vdvq8nc1z0k63dXpVabFgOHYzl4hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjdGvVG7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4583083d019so5616341cf.3;
        Thu, 03 Oct 2024 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727955071; x=1728559871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gh7AiH1TZgK6DdBNLlxO2DI0t14/pxLdW+EFid71JnE=;
        b=PjdGvVG7aTKKcNajnzfm9HZsN+mkk8NdHC3f99P4TJ0tOKEFFXzorEI8U2Heupt391
         IzHgr2mQ7b9j2fgjjMJSn6ykhlg3TmzHdiPWVJSahm41iBjAj9H3K+cRQ0kscRA9vAlg
         7UWz6iAaf497iO+mxEA10NnyiBT2JuEBXimTx0USriFHm9GhPvb9KbcgjRnZGe6/fNLp
         5AKEnF6Aohsa+Uz4DUKpCEKPROQv0Gn747gej3UNCugtIWeFKI02UykHocRdY3aXvvfF
         KgNWL5EswZM4RqSRFLE//KJ9HrODQTME54AZRsb6GBZAU2R37SQ4AaFJiv5dWaD4miaH
         k+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955071; x=1728559871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gh7AiH1TZgK6DdBNLlxO2DI0t14/pxLdW+EFid71JnE=;
        b=QWPt3fDYanfMAAdpqdGPfJm0bmzj+x6pXM5CbHIZ7yAHXCaWIRrMeo7e++ojHGAGm8
         4XIeaCxNwoGRXTHGoMH8GKuHHmF1XnSJwbfhvG6WEpFwFEVEdtkARdfopLmuTI3pJZR7
         zNcSZr8kpUUiIiAfGAH9+y8Mib21ZdJq1XjfPVivJ6WKgUMWw6yclJ9/utzgH28a5pwW
         S0AQzcNb4Yxwt4mO/HSgktSZtYFfpwvU63H6I7h2EhOeBIRJQFznSeXLSRM5GITnaby7
         q7NMS55sChtpyK/LWM52NcfcmFbROmHz9JO+m7nzwyO/bOR9qIlumibU+JilFcvbLTlG
         NOMg==
X-Forwarded-Encrypted: i=1; AJvYcCU4q9vSXW3Ir8lGnxmy2/AmzHryAJFuDknd8mRKIbD60IeAsrJPCstMaKNdDL4ELbnu1Sev5C/UOUX2WNs=@vger.kernel.org, AJvYcCUGpkBwMIxztnLIgpDKEMyt5f5nGIOQ4UXUTQkn1cNiN0ug4DSojT+xzhPzkGPaSPPbznt2Z6sOAIepSxy6bEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUluHDtjWjGVG8GG4PMnfThp5KzdqPkSyYSpMu4OMDi0WF7757
	qQ7rwgO4uNa3E67pS4PuG3VVREbH958TTd8OhtYt6ufqdRISeQ15kMfTgCCuaXsekEVz1YwVqNo
	lfYtBTvD0+h0P2yW+DzvsZ1nJ+oY=
X-Google-Smtp-Source: AGHT+IErhTdnk3JMPmzlTQHvybxPEj2bg7gIsYFxYE7dZOm1Q538p5Jk4okebBFD6BnKJBRKXXc8JeW78tisymP7HFI=
X-Received: by 2002:ac8:5d4f:0:b0:457:c74a:6384 with SMTP id
 d75a77b69052e-45d804b528fmr94378741cf.20.1727955070562; Thu, 03 Oct 2024
 04:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001205603.106278-1-trintaeoitogc@gmail.com>
 <Zv1RhZpQGkVBlLCU@pollux> <2024100240-wrangle-condiment-3f0c@gregkh> <bb2f6786-b99e-424d-b54e-c56d9c7f1f81@app.fastmail.com>
In-Reply-To: <bb2f6786-b99e-424d-b54e-c56d9c7f1f81@app.fastmail.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Thu, 3 Oct 2024 08:30:34 -0300
Message-ID: <CAM_RzfY+HDuUwhhKDN5b56Ct9YbWp2BOV+i7Q9+bdBDWA6duBg@mail.gmail.com>
Subject: Re: [PATCH v3] rust: device: change the from_raw() function
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, 
	a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Boqun Feng <boqun.feng@gmail.com> wrote:
> This work is because we have an issue, so this should really have a:
>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1088
>
> tag.
>
> Greg, could you add this when you queue this?
>
> Guilherme, please add such a tag next time, so we can have things
> tracked. Thanks!
>
> Regards,
> Boqun
>
Understood. Next time I should add the closes tag.

