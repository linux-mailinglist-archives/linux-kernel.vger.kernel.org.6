Return-Path: <linux-kernel+bounces-343090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACBA9896A3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 19:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A97B21516
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E3D3B182;
	Sun, 29 Sep 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g72/VHdS"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0C23BBC5
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631553; cv=none; b=MO2ljaf3swtmu3CwMqS13CnW2+dowO6vzMnqasey3VHKG6lrvna/17/8hVvEf/pzJSr78lG5sFuAFr+eri83SZurSdvHUdbf1y/Gkjm6ZkCyFwvLgYx1PEjZ2W5+Eqm2LSYmwbBjne4uI7hfIj+0bz0p+5fO8XYgQsyOL02Abw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631553; c=relaxed/simple;
	bh=hKfyPijtoUQohFsXEwl75zvMJL77b6mI+Ko4n1R5I1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quPtb3uD1NsACAXel5VimPXKVKXOkFzjhXkn5UhVazfLd9EyN2xxYlnxZsE3fThNgZwi8h96myRKM60bMLElP8Czor4HkCVogSTHtUzcJ6PerHa9h3a3V0rKwWQ3lNOOcQCYN4OxaQ1keh6Ft9LqZ+Z9/t9A9B1ep5xmzCj79ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g72/VHdS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so29072325e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 10:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727631550; x=1728236350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/XnOjX8xImxWeS9NvKvH79lWEWTobvX+Cr7s5Gbbcs=;
        b=g72/VHdSMR3LtLzb8N1A2vcvwhy7z6rPt5iP4uJDWP79mk+RWZMLPRBwG/bYWRxHCb
         rFPTO14Qq+dpZBK6b/09EqeaBogxKIlA4cedegRl4IhYq8NsFKpdrHLkSSLoLCutRpnw
         VeNX+v4iah1HaPv7Ed/wHTDbLUHn6ytM9M9J6e7Iq1rgQeXqUzbLW2vev8N+N0BiK2Ft
         VFA8ZsW+Vvio7lBvbVdWPFQiiMtepwUNSfPV1/4tXeKLEtw+trSjfXWQVA0xLNb160PP
         8wWe6mgi/R2xG1x+qsCg3RP3u7WUjKiAEayx4Vh7JS9C/d2YUr5+kkBGRffnjWE/TQay
         3bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727631550; x=1728236350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/XnOjX8xImxWeS9NvKvH79lWEWTobvX+Cr7s5Gbbcs=;
        b=qhFmjOKjDjj5W/aiJTN0V3N1f1SSR0FePiWdnxoi14KgQBOj8zBr5uB0KVH/N3+Nkl
         56nisBfMrA+K3OgQ6yrJLmqwCQ7g5rbj1mTh/eGMTWtnOlb7OIbn5Q0Z47wz03q5CoxC
         K62qFrPTVAOmPcK2dW2zm/Ni3Qnd36ulsv0kZINxrosUa7b67nP7+BzvysFcm7RRQpBY
         4bzDMAO6NThK+DTZGUMtHm2iH/rg9EvSDGM1qal0Z7r8gGwaDwsaNlSA/cpndxfQ390P
         D5ymgxGSlioNb4g/1oGXXUgAx/ugp34wOltsKzA4nheY77MvqaO95JefMMFtKJsRDeQ1
         jO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT6FDsAPS2qVI98cBkzZFWsuUe0ORVhWZ0sODgb8Sm5oae9LN6AHcnyoY2CzfgyGlFCTkB1qJrbWBEEcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF4fTV5Tb+esaTRaVHHY5ElivKyKuvlEu4zHnl9bCZga1o//c2
	yxUpjpn2fYvLiw5s1jdDC9sy4BkXaThWSaYn6GpY+A0SBokZ7iOQNVjbaP+4wUuC2jsRZQrcGpL
	JCpUH5sTuZ5a/drMZpEN7XC8zCHE=
X-Google-Smtp-Source: AGHT+IETQ3WhnTElzy0KB217/nnthiDH8DH2DZQB5+6WOx532d5Flu0wVRZCxXYLsVOHq4L4lTUorxSlLEQ2OjFFNlE=
X-Received: by 2002:a5d:530b:0:b0:37c:ced1:dd06 with SMTP id
 ffacd0b85a97d-37cd5b12b35mr5865145f8f.41.1727631550348; Sun, 29 Sep 2024
 10:39:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927194856.096003183@infradead.org> <20240927194925.283644921@infradead.org>
In-Reply-To: <20240927194925.283644921@infradead.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:38:58 -0700
Message-ID: <CAADnVQ+qDAzjyRuN6sdpw8RjB4XQ1EyyMJ_uYXeDspbW58fC3A@mail.gmail.com>
Subject: Re: [PATCH 09/14] x86/ibt: Implement IBT+
To: Peter Zijlstra <peterz@infradead.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	alyssa.milburn@intel.com, scott.d.constable@intel.com, 
	Joao Moreira <joao@overdrivepizza.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	"H.J. Lu" <hjl.tools@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Nathan Chancellor <nathan@kernel.org>, ojeda@kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 12:50=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -555,6 +555,8 @@ static int emit_patch(u8 **pprog, void *
>
>  static int emit_call(u8 **pprog, void *func, void *ip)
>  {
> +       if (is_endbr(func))
> +               func +=3D ENDBR_INSN_SIZE;
>         return emit_patch(pprog, func, ip, 0xE8);
>  }
>
> @@ -562,11 +564,13 @@ static int emit_rsb_call(u8 **pprog, voi
>  {
>         OPTIMIZER_HIDE_VAR(func);
>         ip +=3D x86_call_depth_emit_accounting(pprog, func, ip);
> -       return emit_patch(pprog, func, ip, 0xE8);
> +       return emit_call(pprog, func, ip);
>  }
>
>  static int emit_jump(u8 **pprog, void *func, void *ip)
>  {
> +       if (is_endbr(func))
> +               func +=3D ENDBR_INSN_SIZE;
>         return emit_patch(pprog, func, ip, 0xE9);
>  }

Makes sense, but it feels like it's fixing the existing bug
that we somehow didn't notice earlier?

