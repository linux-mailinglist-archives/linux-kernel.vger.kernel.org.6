Return-Path: <linux-kernel+bounces-562482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E844BA62976
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6118189D191
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DED1917D4;
	Sat, 15 Mar 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHUkSdVX"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DDA41
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029299; cv=none; b=btwLkHQoptrFE548+t+wLu8FNMWwvbmyUlDrMxAcGouStHHMpz+6vl9bZD8rkwKxjIb9q6dhDIG+CJLvXt4QIWXneHXHhXcRkqoQVaviVJA4J0G6OtPL7wJ+Kr4AOTaEtdzZbwZdxHpCOKsCGketPhSY8KZ1h4OUUDYwsaxnc0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029299; c=relaxed/simple;
	bh=cSFTTOjbYdVNYK0JfH1qkYCNQiMpi0iWfDMWirbkpOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GJJlI/elKSV8UVEWinTAGKz17k8818VzUaqu0cftFdP9fHrp1Ej/zGNBODpvbDlSpYkg4qESylGqU/X21S5yu99juZ4tY8VRn/3FT5NaGj92HXDMtgy6begzpbfHy0keQfKjbaxcUG+k9Ybp8I+l6PM+FMgrWC4vIeKlUiejBDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHUkSdVX; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bef9b04adso29835871fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742029296; x=1742634096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21wPShANmhNvm76IeYV1KCOiJZbvajbAk20cnHEunU0=;
        b=mHUkSdVXqDT+8i/D1alouTDZm6XDRidS9L3KQdkFpvPhlLGe/RQsAcJSxjLL8VoT0Z
         aRbgtpI9eMYdOH2XLwrPrlBTUFTljfgGB4VzIvgRxGBw2VLhlbdwvbdCshFz6pWhJc4J
         dgGW6SLnmPiJ05Rv+5VPE5KNkDc8kdIrCek4Nt4mpfJfzQObi8+v3C3nc30TjtwSu/NW
         ldYWqR9GEnuz0wUOaEUmq1ejZUNC5ZudEvJb7RStR1u0rBf5sbykkJa45ufi27bjZgx9
         stRa3Ly/sHSnnvIlpiQgNzSP1Wrx1EtCt5r/k2rWI5Cm8rpPLUq262GV37ieCFtAv4fE
         DAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742029296; x=1742634096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21wPShANmhNvm76IeYV1KCOiJZbvajbAk20cnHEunU0=;
        b=de3n1M0ZSVEb7N+uwifahd1oMU6bOZN1LB7S3ktn+215uv/9xsiwUt2JIDAiEEY/4A
         V/rt0ZpJxYo8Kk0P0/yHp85goyKTWB/x56J611xYIoOub6BSA0QxqyHhgi+6sD2rQvL5
         AnlxIjXYbMe/7qDBHjhwlwjbEe9Sq3Z+s25+uSUf0ro1y1DmVp3ZKHttNLbKJfM5o4dU
         1jPa6zahVakzJB67a2mj5bcHgfIBqeDm5SNk9uwTzPsSVRUUuQ9jwTMKL1P4sg9qjMOG
         4GyDJxHfQ+V49+vmPNxB+EjzGguKBsknd+eHXDuLvaMWkSRhuYn0wY+ZexEnD1yIntKe
         dF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqw2rCckO4nEuUYH0jw/ZTlgLCmC0EdXWedUN+FWY+htdnuqEablHWziXjYdjG0myBFJacJLIGYV5hw6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YynrkCIYwcCs8z226pCdWzNEN5eAjOJKpu9VBMkrkkEWqOxzyis
	twO5byFZqjAC7JydHaX0wBaRykG234wR6tbIQ3vtCSKVPWCOzym57Kd+RZJtjSxqQGOGkCX9eDA
	EfNFhdok0klg5dL2EWTWQl4XUAZhMJjMI
X-Gm-Gg: ASbGnctSMfKuVVWrE1bmCh+N6TDpMO9jm3OhRXV2IM23vKJt653/Tia3LAAtGE09M2a
	MyOk107jLOBnVBGB3xQzf3d7yqIHXykaVnZPTeI8+PmGRaEyxTxMPYdqEAHvtg0oWAeWM3kHOkX
	pVa9Pr25sb1aMWC8EGx29EHmgoQA==
X-Google-Smtp-Source: AGHT+IG96znldB36QyK1UWtg4W9G/PUGj2Qw75cBAsY3pZ5ouzxdgdDb0JMULNZ80R/6pLehCquUPU6gLH/0KNBrZFQ=
X-Received: by 2002:a2e:9805:0:b0:30b:d073:9e7d with SMTP id
 38308e7fff4ca-30c4a8fb0d2mr18963141fa.37.1742029295593; Sat, 15 Mar 2025
 02:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1741988314.git.jpoimboe@kernel.org> <ced9352a854e896e00f57ab2b062526d688a5b8a.1741988314.git.jpoimboe@kernel.org>
In-Reply-To: <ced9352a854e896e00f57ab2b062526d688a5b8a.1741988314.git.jpoimboe@kernel.org>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Sat, 15 Mar 2025 10:01:29 +0100
X-Gm-Features: AQ5f1Jp-1Rx-FUdAFj6pzXqjXfZpwD4Am4VnS0bzEDVtJgk0UT7LG3plYfir9zs
Message-ID: <CAFULd4ZK4F+BNPb=W8iYFXoCc=JzXyxWH5tqJ--HS7fD997HHQ@mail.gmail.com>
Subject: Re: [PATCH 15/20] x86/cpu/amd: Use named asm operands in asm_clear_divider()
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:42=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> Use named inline asm operands in preparation for using alternative_io().
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/x86/include/asm/processor.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proc=
essor.h
> index a1baf2fc5f9b..b458ff0e4c79 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -709,8 +709,8 @@ static inline u32 per_cpu_l2c_id(unsigned int cpu)
>   */
>  static __always_inline void amd_clear_divider(void)
>  {
> -       asm volatile(ALTERNATIVE("", "div %2\n\t", X86_BUG_DIV0)
> -                    :: "a" (0), "d" (0), "r" (1));
> +       asm volatile(ALTERNATIVE("", "div %[one]\n\t", X86_BUG_DIV0)
> +                    :: "a" (0), "d" (0), [one] "r" (1));

Please remove trailing "\n\t" here and elsewhere.

Thanks,
Uros.

