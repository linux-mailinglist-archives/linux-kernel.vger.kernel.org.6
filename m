Return-Path: <linux-kernel+bounces-251232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5339A930269
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D5283AA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539213210A;
	Fri, 12 Jul 2024 23:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRxluJyH"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CA376F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720827196; cv=none; b=iZCYoUwjPlZsG4iocwpbNq6FYc0Il6hsTj9X9PrsoGLa9X00vyyBVRvJiJ1RSsCGdfRipup4l+HH1QzBNA54oBxRR5SMUVNG1hGi+USsQImCZILn4AmCL45g8c/MfQYVe0vZ5Ui0mq51zweu9GkKg4VBHWtQABhnS/c1XWxq/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720827196; c=relaxed/simple;
	bh=TqJgy1ROu7Uudrkyo5C7SDS6jOJr/ZjsstnH3vTMPHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ku+QLvedT1tCSqWzCCxsPVfTVyjkRbsHADpyEzqmMr7m+HKYLgbZ6beJS763f95v3KhAu9KvIhsqscZwRP487e8RFLOfqqQLzQNX7vGtKl2AuMU/ym0OqT3aKLuW2lpZMTTI+6r8shghMarO/VvFKwy9CG3wUagGm+UxL5TR0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRxluJyH; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44e534a1fbeso61161cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720827194; x=1721431994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqJgy1ROu7Uudrkyo5C7SDS6jOJr/ZjsstnH3vTMPHQ=;
        b=JRxluJyHywKZACfpm1IhvafkRWQIzNxwKfsQQfv2z9F5cRc+or6oCDjjIEmy6Mnxvx
         Zg0TOu743/8vOn8MeJGyD+yC3XmrZRFsow6HPfB3SvAyUFgd8WxYGH67ieVdszW4lk5B
         Tb93MQlC3JaYXzmGObR54CG8jqtoAoWUGUZmHlEDvN/2ekk7+go7rxocuvatZ6kU7T/2
         cO7q/myrIY4dktitR0SBXfKejMtkkSInR0O43voY2T9P1tH//WwKiZ0DfO/VxkwCnoQ/
         OjMklMpTjA4kRHpu/R2YPMVipW5vgF3iNDm4kRVFyxcKOY6LhCMa6hLRTnGHwW3rlZdr
         BJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720827194; x=1721431994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TqJgy1ROu7Uudrkyo5C7SDS6jOJr/ZjsstnH3vTMPHQ=;
        b=H7cV9ac29x54E+FTmPTen7OQMMb4YA3hpX98wsu2IZcyPF/yPpRc5HIAUS13J6UBtB
         rGmxgh/EDwj8MQvpGNk/q2HXy4iOX1gEwfbDrQOHlW71n2rsozFkOGDTrQnb0ufQr0HT
         qes9CbF7Schb6K7Jsl6mZYhDFCsg/fPJ7aiRPJJ4gp1FZ5SVpxM4gBTqSpNwKMMkscQj
         WHH9p7gTwecnEbDZfYk38KAMkF23subOTw3Lc+c3pJSMAvcFkSDt3XMWwGEt8I1yrzg8
         VlHa3dzxs25YYzKp6rxbYVdfqW/tpTwEviYnZ+PfkKnNRY7nGw075qVIun20rCDgJSEu
         PACg==
X-Forwarded-Encrypted: i=1; AJvYcCWE2rr3vtYlfiGLbq3khkW6B/FetdU9mNz70qV5zJPUBxlPDZvaI6h8q7mWOMsysg5c57wuIxGCtH+WhCpj4O0TWiggjBjzZCmpzItq
X-Gm-Message-State: AOJu0Yw9wldVP/jZFviZfofEoOovLtFmr6xaWkiEUfq2o3ltudD7iULZ
	Ns6t93OSSxzRzn9bNJF0eyilTDh96oUcAFiGggfgnqUz+hnEfTgnKlvATvGsHGJ07vZd5kWUq/r
	v+NJiDUJLftNeqTMvcu6C8cIIWsoM8xAtkbXs
X-Google-Smtp-Source: AGHT+IHtnKJnIXzn59VJPCJo3G+kc3sOXTeZdQitzs4Euj1bez54/sF6SyDkJNeuuxfXDjL/HZ59iEzG9QtNytdOLHs=
X-Received: by 2002:a05:622a:1f89:b0:447:d225:6e3a with SMTP id
 d75a77b69052e-44f5a28baaamr1424971cf.4.1720827194011; Fri, 12 Jul 2024
 16:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712093943.1288-1-ravi.bangoria@amd.com> <20240712093943.1288-4-ravi.bangoria@amd.com>
In-Reply-To: <20240712093943.1288-4-ravi.bangoria@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 12 Jul 2024 16:33:03 -0700
Message-ID: <CALMp9eTan+OGKbRbZup1SVnHN0T0T0Ed_CVmooev446QDejqPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] KVM: SVM: Don't advertise Bus Lock Detect to guest
 if SVM support is missing
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, seanjc@google.com, pbonzini@redhat.com, 
	thomas.lendacky@amd.com, hpa@zytor.com, rmk+kernel@armlinux.org.uk, 
	peterz@infradead.org, james.morse@arm.com, lukas.bulwahn@gmail.com, 
	arjan@linux.intel.com, j.granados@samsung.com, sibs@chinatelecom.cn, 
	nik.borisov@suse.com, michael.roth@amd.com, nikunj.dadhania@amd.com, 
	babu.moger@amd.com, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, santosh.shukla@amd.com, ananth.narayan@amd.com, 
	sandipan.das@amd.com, manali.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 2:41=E2=80=AFAM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> If host supports Bus Lock Detect, KVM advertises it to guests even if
> SVM support is absent. Additionally, guest wouldn't be able to use it
> despite guest CPUID bit being set. Fix it by unconditionally clearing
> the feature bit in KVM cpu capability.
>
> Reported-by: Jim Mattson <jmattson@google.com>
> Closes: https://lore.kernel.org/r/CALMp9eRet6+v8Y1Q-i6mqPm4hUow_kJNhmVHfO=
V8tMfuSS=3DtVg@mail.gmail.com
> Fixes: 76ea438b4afc ("KVM: X86: Expose bus lock debug exception to guest"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>

