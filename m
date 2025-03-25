Return-Path: <linux-kernel+bounces-574720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC607A6E8DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 05:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2F8B188D9DC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E21A3BA1;
	Tue, 25 Mar 2025 04:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEsO0TJt"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676B3183CA6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742876934; cv=none; b=bHd6EvIkLq/GD48ZkXXmykTh+Jtup7SYb8erB/2hrVHFYHeyPks3ctk6OrH0UQ7ofmhhwlV6hxFWZUrwv3tT1jiZBuXJuqIXjLH6jkI49a+SiWdEWPTjUQNJRKZ+NFO/nckDTLFtnc5kK6ZiZ5vczsKmO6QkPrcdzifmzTQjMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742876934; c=relaxed/simple;
	bh=pp6ZbS9UeYuz7oVMqa353ZXCNXt02VdkFc3MHYN4Hew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSVfLsgDq5yYYzNx8kszRDtEBTYEPiJ3dfnqZDLh0zAqMV9w5rmuIoYEl780H/lsBSKO5xxlm6yXIfXnJq9jE6JrdxHqNkWGoxV0c4Bi346h/tSG+SuD4UNZcdetZZWoyqVIuechpdL8Spa4vKbv6NwsJWUMFExLJP+uu3xVBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEsO0TJt; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476ae781d21so45798161cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742876932; x=1743481732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pp6ZbS9UeYuz7oVMqa353ZXCNXt02VdkFc3MHYN4Hew=;
        b=FEsO0TJtgHXdu8dY7A8XKwjWo6b0LyitXgXNEcnsQHAePIMulSqfxVxHPlB7ApGH+e
         BcEqohEWyGuOSeoBcptmsDZxFp7SfQAf9C11MlO/fr3C1+W0tCK6hDZYYLohYFGV4YMR
         ac8kPR6V01k2qCbBt451QkdKgR1dm3x/QjzD4MNinXEtyTIiQtVVosQwvw6qAv0yEEa+
         1wXpm6oAh5EVamoiUpKwiBP288s6muyrkrMUWX6Vej8MLi8xNiveatf5XYGZlciYfPjm
         gNMXvw74cHj3wHVMKIdH2I0WE4LQysNLNRlwdyasDSrX65E3Tq2oYapCpWuUtziWJf/Q
         zX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742876932; x=1743481732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pp6ZbS9UeYuz7oVMqa353ZXCNXt02VdkFc3MHYN4Hew=;
        b=u1mqQ0Ps2Qxg2bA6AiLqQPCxZ8qozyyjD5tgi79M3OphGbmsXYTQXYFd031CpnCbag
         dai14Mrqzd+ajmXep7DFM0Av23OKE4FEhNYSYYUC0+cSvOJbe2vIuY5K/vkTbi8tDSwV
         NcCZQpKHbW/5BpmDPUVtVyRjUMJi/RbG1QmD7vNBhY3xQn8lwrvTQS5XwXgVMIMQpSz9
         PAdEsR5iuMyH3cUCOR+qbOyHGJIOj/m+3h+Qoz0eCfbEWnNJie5gX5H6Hu7hvYXGbRx8
         Ur7jqG4fKyncoO8i1QVtUgc1GpOq5JuKhB66qHwJnCuLgHBonCpgNVIVrb30c+WOiFA2
         Q2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrJyIObp1k3YeqC4iGLb7eO6jV+++EMKkZ1QkhRmvTvM6nY4TbfT2bjrZjiqA8alUJmtB2cIZKr4VRuKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGGmxmlchWE6JKXpc1LbukgntgXfwGN8DiCWdEtPVh/TxkflN1
	E7CbBlaequmA2G7O6Ibwk0zphqkDzDnpK/tZ4yAhJCXtMh/SAVgkV4cGxNS7wjueRa43bhLC+/Y
	CE8AQVE9h8xaq1ZHuy/8vYZ1AVpEPztJYn/Cd
X-Gm-Gg: ASbGncsWYTUObmtmVmR0Ohw3+TqeOApl9dFcqsR27yVPZXJhuhWWE6QBEbzgVcUZckF
	HtJ8LiOnWKDBWOvaxNzlhrwWkVYhwMd4MjZ1IpVEGWKoDTS2Y0fhKDlL7MbGo1GqnYW2z/cpClC
	lJ0lxSXV3vmW7ShjsnA7p6q5RkJg==
X-Google-Smtp-Source: AGHT+IEk4eqKPSzGKY1+mBhTmBlhZ4wamfo5qiv4PteJPuafaGTKKSFX/5mQRuQ4kwCXVSYe9V4L6Il9Sj3Y43eFwRc=
X-Received: by 2002:a05:622a:2588:b0:476:8288:9563 with SMTP id
 d75a77b69052e-4771dd607c0mr194124491cf.10.1742876931987; Mon, 24 Mar 2025
 21:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324083051.3938815-1-edumazet@google.com> <20250324111817.GA14944@noisy.programming.kicks-ass.net>
In-Reply-To: <20250324111817.GA14944@noisy.programming.kicks-ass.net>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Mar 2025 05:28:41 +0100
X-Gm-Features: AQ5f1JpDNlWAkzmCY5RVAqO5XFqXmRAO1sjpsACH8OWOtorMBnMSQtaAvCYWiL0
Message-ID: <CANn89iJ1by2zbasXDi7+_Y0=9J8no0r5GcpeN4SEAG_Nxvkp+A@mail.gmail.com>
Subject: Re: [PATCH v2] x86/alternatives: remove false sharing in poke_int3_handler()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, bpf@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Greg Thelen <gthelen@google.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 12:18=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>

>
> This is unreadable due to the amount of pointless repetition.

Thanks, I am trimming the changelog in v3.

