Return-Path: <linux-kernel+bounces-567181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FF3A682F3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 02:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292263B5217
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 01:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F1624E4A3;
	Wed, 19 Mar 2025 01:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T7JstgnB"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C124DFE3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349403; cv=none; b=i8T9tMhWMOWYiyTMX2V8j5IXP5uD1yLvS9ORd+zLlnozCmAy86PqiRZF+IoXiT5af+pR79Ew1aC9Q1ukzWl2yhKox4RFQ/bIz+gFvCKukaTjVSCVONQ/RIsKsZX68CK2DginCQimEt2oW4abwsELel6QqJ81ROFJf/1ZumK9F8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349403; c=relaxed/simple;
	bh=ouX3i3BlIK9xeWSAx5idopZ4sgifcAwYYnVE/GH5f9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaocWgPYfqmDoYLvZP33Z/kCe3ydSCTGHWkSg0KiHFWIu6tLaKUzTIlqbaYgM0ZwBYzVeZrMDsh5aQwBJfWRkEYLMGZzcKNMgvjyYxgVBruHesoIg4OKf500zaY+1B5A0irkjIEUyHDJDAjwV2+NNVjtoGWAoHbSVA+YG3ZJ8pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T7JstgnB; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so119695ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742349401; x=1742954201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouX3i3BlIK9xeWSAx5idopZ4sgifcAwYYnVE/GH5f9c=;
        b=T7JstgnB/xRiX0DSrBp4AWsvGOqb8QhG+H8sQ6huA0RcTPOmTV+e6mm0XcSysUAi/6
         nhDA0YSjh4gki4xaPFzNBdW/WWD61/vUz+Q+wpApWQH3CVpGBJRBSsqV8iIGo6MIC8EI
         Grkw6cMDFFsd73zy7JwqI6gjBl/dkTqVv/blIDP+OhMvcZVPsRZc7SHHzzbBY6vwzlZW
         agZyvWTci/qvsIPfON0ftgY7dy6b+3plM1NG/taYYpBM7CgYR+D0c63wH/GB6n0/NDAz
         oJGamZUESLZQtmxwfqkXHcpoIHrk1DGJ6ZhgN98nBBr3SOgR/jhlG8qIHSmHKYoB8dnD
         lZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349401; x=1742954201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ouX3i3BlIK9xeWSAx5idopZ4sgifcAwYYnVE/GH5f9c=;
        b=wLTYWvgECHv4m/GFuFfVK9v67ANI25Kn+mep62ARwEYyrQFWe4usQgH2srTSHtECKS
         /UyKbBsyep7Xg85cZ/Z09lKDPR5Q/P6UKqCdB5cT9B+bmXwsU37vexpr47dI2C7jg8ON
         LQRyjpnqv5270lglrr/p5DQHEX7DMXxeF2eE7avqcdszyVNDbxgmLnjD6tFEBpertLVS
         3UzM8QHCgrBGoaz2PMBiuz/zoo7TOVjDAPACArtyMANkQc0MTPUfrKcwOKS0u+nbw3P7
         a30BR4/dL9uHMhNWnHSjdK6UFNROTOvejib9EYZ63nk2/VfXvai5qlcUpuf/agI6jAKf
         CFCw==
X-Forwarded-Encrypted: i=1; AJvYcCXmaLZAXMHFCm7VbDkQ+0s6+3iay1N2yBkQAGVTtfviyHoJYrC39MO2MPh5ynjXlPVP/KXYw4VyD5i7ZRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Sr8WD8nsmSr/PqQmMnQ/StU3pkaEZRAJCdlSvEU7a76een9z
	6dk063qa0yy/z/3/empqlsAxFRGuElf58DpHukfTv/2Vy+KV8bB/YvOUh7obfISgCNKIp81hvx7
	iYSGpTrTRL0xiyCYgjNydaV/9lzy9T6D/uZs9xKEvwKKA9CkfNw==
X-Gm-Gg: ASbGnctykuBSG1t4ZZs4fQK/kI3oPNjS9CB3aQLVdRGvYhacrEhFyDxp6LNwNUTwGAe
	gaqvMtATW4pMdZj7U5v8uk3u+cobTeWu6r48rAsNgtc3W8akAQ/NIwm5nKQnNrI/O1Gh7maN2cY
	cYPd0mhErlttDGm6KARCv5OkddrdRx1E1gieRNj4IKA0ncRsGxzGCUoBASRA8=
X-Google-Smtp-Source: AGHT+IEJfip408CG6iLcuESpdEX6gT3O3jt9KVpROf4xrnd1IJWORoDLVoYajUjuvtz9nQ1FFnBPw2N1ZUl5Hrds5uA=
X-Received: by 2002:a17:903:94b:b0:217:8612:b690 with SMTP id
 d9443c01a7336-2264c5dcc70mr366545ad.8.1742349400754; Tue, 18 Mar 2025
 18:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319002334.423463-1-seanjc@google.com>
In-Reply-To: <20250319002334.423463-1-seanjc@google.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Tue, 18 Mar 2025 18:56:28 -0700
X-Gm-Features: AQ5f1JrOdUEH-YRODraRYAQAbzhFmnSc3WUD0U0BmIDaDjaSw7Ab2iN7Zw_Sbq8
Message-ID: <CAGtprH-HmtdyNZnRn3UjA-pBYaBBJgUS7UQSd07PDW94kdwufA@mail.gmail.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2025.03.19 - CANCELED
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:24=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> PUCK is canceled this week due to lack of topics/interest, DST difference=
s, and
> far too many meetings on my calendar.

We would like to discuss base TDX KVM support readiness for the 6.15
kernel merge window in the next available session.

Google is looking forward to having these patches merged soon.

Regards,
Vishal

>
> PUCK is canceled for next week as well (03.26) for similar reasons, in ca=
se I
> forget to send a notice next week.
>

