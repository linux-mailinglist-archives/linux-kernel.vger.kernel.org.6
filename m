Return-Path: <linux-kernel+bounces-361995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7799AFC5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 02:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DDC286521
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 00:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73534BE46;
	Sat, 12 Oct 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qEW6n8uY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A79454
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728694178; cv=none; b=sepA7WNpcKWLP3S2MI2B4tJdmMEcT4uFo3ag52wt/Yey0EwrWhqfBrjhWRtfCCpZHu2q1Y4bCfUTmzDlNxxpFd+OXKvE5bq2Tonh/5H5AWe+APox7m9NjFTzCXhw8L+0YvO23SOs2dFzQee5xBidB/zNDcET8aWkR50UxN7CAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728694178; c=relaxed/simple;
	bh=v2JwS1UTnR/w9yH5prGw1z77Kz2sKJTsYb8NNgJgq4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSZK5UTLIwr8g+PogDhftOQGJWIUIKHKRjCdDhRmnqGeRACb7iRCHKN2KWn5/uW8ISAtU5wlEjLSemSY7br1XqpOn7RJrtDO+WGhCxRX+kYc2Onrrv18bh/IETzBd693wxMfLI7/fnwHaEVh26vRu3CBPdH/QTzUguSqjGqSWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qEW6n8uY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9968114422so365301266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728694176; x=1729298976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2JwS1UTnR/w9yH5prGw1z77Kz2sKJTsYb8NNgJgq4s=;
        b=qEW6n8uYfKLZTOQIn9t/t4zPve+R+CM0xrT77+fuMKuZ924MCnx6PC0L0fpuWMFu8M
         24BfaXRyrmDjG/GHqY4sxx4Al4QlNOqp2SclUAp2l1CTrWh/keTjSbjzZEaiyXrQ5a7k
         4zKwo6Av21f6KYhL20EM8LH/B5ILkZroqCz3AythlRmeqwIN7UYXG4ei7UATC3RG5OLR
         O++xxakK2qlYbZOqqOY+5bgMgcLLLDR9KBSw3VBpco90+OZnrKhBsN0xTM6Xi6EOYPjv
         8WdpuJApUY6+j3Vi1bsK34wlORV7Cd5UHd8UHwCbpOpfJayxXq06wlxJ7h6HoFdka+lT
         8AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728694176; x=1729298976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2JwS1UTnR/w9yH5prGw1z77Kz2sKJTsYb8NNgJgq4s=;
        b=ktkVkq1UtqAL3VLSJpsixmOfHCq0tbIW+M7VOJU7fd85A9CSScD+2/CDkMZkUVvzTU
         lwXnkKcCwlda370G0g8RAdvjneh9E8WNwRrHbBR0fZ8JB9gM/HHOClnJZOfWoDZ4lEOi
         yndYYgQ7E+/TwWUOU8mJP7ndFunTleow8do6bjNkK+bIYczWPh8jz3XkA08f4Ct0Cn1k
         uTLPRQIUEnsDVnmFyndfh9fpWHZm9VHW62VEqjAMR1BX8ElaMCSsGuFWUFV/Fa3W0JBS
         aa7uN1G22LrTU6MbqFZfzNz7kn+5F0Hc+SpZbQsYMhn9kEoeBJLMr5TLH64QIiCtR9Vt
         BxZw==
X-Forwarded-Encrypted: i=1; AJvYcCU/DObkrii7tMIbw8Rp/o/aBizrfQexAdmDF1Hk7+gVw0tQl2dHl7vNAYBqh5rDOIzLJ5qkFLKaRvHwgQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1G23jjBaFRY5DeZJWU5fzhY2ZFejPfwdNS0ZFsIZNOpq6euQ
	dczFiLnzW42WxfXRWMHpo5d/F8Y3TNoBA2L4n9u5DzL/02O4EsfdF3VljSyiH0Y7stZPmHAc2bB
	wO4PTopclxjTN84NWR68FvPvr+zpMhqxNkDM=
X-Google-Smtp-Source: AGHT+IGS8ZCj/bXavpD+pncaTo7L+3ClWpptP/uSRW/S6IMTfpj+XauibqknO437caqQwGLJ+1VE6nBvb9FyoCdaI1E=
X-Received: by 2002:a17:906:dc92:b0:a99:4f5f:c9aa with SMTP id
 a640c23a62f3a-a99b95bade3mr263119866b.50.1728694175635; Fri, 11 Oct 2024
 17:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011225236.27677-1-skhan@linuxfoundation.org>
In-Reply-To: <20241011225236.27677-1-skhan@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Fri, 11 Oct 2024 17:49:24 -0700
Message-ID: <CANDhNCo5q05xUgdXQaDfxUGbiKaV2mXmfttA-=oVrftBF0PERA@mail.gmail.com>
Subject: Re: [PATCH] selftests:timers: remove local CLOCKID defines
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:52=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> timers tests defines CLOCKIDs locally. Remove all local CLOCKIDs except
> CLOCK_HWSPECIFIC and use defines from time.h header file.
>
> CLOCK_HWSPECIFIC and CLOCK_SGI_CYCLE are the same and CLOCK_SGI_CYCLE
> is deprecated,
>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for doing this cleanup!

Acked-by: John Stultz <jstultz@google.com>

