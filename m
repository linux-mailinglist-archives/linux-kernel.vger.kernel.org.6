Return-Path: <linux-kernel+bounces-436050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC39E807A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 16:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A31316667C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8234F14A0A8;
	Sat,  7 Dec 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW57hqRv"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436B22C6C5;
	Sat,  7 Dec 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733585782; cv=none; b=k4+5+p4AZZ5IPLdkvg7pbklUB4zChRcZyaxvGRZaeQ2aCNmsRbRBBfD2ycR77F1fihkgMrn0QhOtXHKE3Ku4Tgs0s2wpEHS1VwjBnMK+JgkGJOfh1QB59bMHNEI81FgMtST5PT8T+mRzyJ936Yn/ueL/6MUMV5MzvbmaHW0dASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733585782; c=relaxed/simple;
	bh=zHshuIbQ0xcfAgQEwx29QMAXvcTcz+8gOhp7tdrMGD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBWYyr9Tm5YvPifc19EZOgtcb8J7BmgRiwR0PxbIqXuUgGQ4RmNvueN2DEsf0pxbkoYv6yRBhq2s7T28vSlFwjwphW0Xlu+pOjzK4ej3wgHiNcB50GWYnHTyK0z8a9nG2OubuuD90SWWOZ16XyQajIeKBsj/E2g3uoLIErJqb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW57hqRv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3e9f60bf4so365617a12.3;
        Sat, 07 Dec 2024 07:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733585779; x=1734190579; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zHshuIbQ0xcfAgQEwx29QMAXvcTcz+8gOhp7tdrMGD4=;
        b=lW57hqRvhheT7DjrZE08a4kPYTRm84Ojk7YC4AzV8L/ujXDAHnxBLh39KP1ih9XfAX
         JuRtTLfsFPGOBa+PyGUYBsm7sLg40DCoEMNaMy9kKunNo0ufM3o+bdVGSASnvxyFblhh
         5Uy3T830QeKc+Gxqcy86CluOePgoBpVC7MM8HCyojfmQpHZCBo+U0/i5S44BV/SwVK+k
         rMNnVpONyKZjt82uq1PbImHWoGqUBmcm0XadLR3g3636EsxtJAMOczz6iHY3otuZ389j
         sZhCkZLxUrZ8Oa/93RlVrOE7mAU6RsGuVQ0QWtRaOV3AGlQHZ2dmyT1ON1dMTkOVzple
         b5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733585779; x=1734190579;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHshuIbQ0xcfAgQEwx29QMAXvcTcz+8gOhp7tdrMGD4=;
        b=J1aq+8AJVRKSEwPewykSGaiIUpaRVqa6tYrRgY6VrYsMTnBsyxfuk/jkXu2u0WQICA
         zpZRTxb7gwTpGgF0W2GMaT3qF4mInpRwFQT+XOXk9WueXjcdOCkfl/LYKoJ1SM9phdYQ
         HYExKIemsx8xePkw/I6qynOnI51YH5Cde1I40BQCeplws8IfFV3s6FXBvQt2bGvyQRGa
         27AXza1laWQI50EA0R9Q9renSIVwiio9L9lKnolyCEdLW/SaCxqTWY0L2QxtXDGLTfpj
         r5ixx+GMwjbG9hrYzhUONYD6BUqI6pnshvlxKX4LRYK47DFFH8t7wM2778SgbqI5/cot
         JRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLtSOzUFukzQFEr2ToU73+XE75aHG+MSBy1VWwdLHHa09UGoetIDQ7ciWYGLq+6BKd4nfFDgCzYKqadYk5@vger.kernel.org, AJvYcCXyPW5oav8Uk7EySb7caOoOzBMkuWferdkdUVoutlckHZdVOnDuOTgSg15M9WDc4OtB42NPdfwn/EUY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gKj8OtqoTRXETlhh5ezrgVxYIw/BsLX7Rbqpq1TYH5oGAsLy
	m4AVK6er0fUEopWBZ93Qj1sx4twG3fWJ03Ybht2LENQmbMdFa/uGUfW9Pghna5465JpTQY5QcWl
	RJpDQzbvZyp4NjWB0L9jZ9cKPYbA=
X-Gm-Gg: ASbGncu+OyzpaMkPrUL/87GNJZrnGwnJnaBAKZwk8I3IMfYkWvalYa2kcyvjy4WHnts
	B9nfk5GpYF7zel52p7bjk3F3MLs7l/w3o64faLQ==
X-Google-Smtp-Source: AGHT+IHoE7hywdceZP0ecmajv5RJm+ghgmXaAnuTlzMBTgY9GRfcN1HHtpkho9YdPt49H//MD+lGW3RvLAllEHGkS/Q=
X-Received: by 2002:a17:906:4ca:b0:aa6:2d86:bd2c with SMTP id
 a640c23a62f3a-aa63a0ed36cmr473776266b.21.1733585778375; Sat, 07 Dec 2024
 07:36:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204111424.263055-1-bigunclemax@gmail.com>
 <CAJM55Z-YAMtRN=K5KxCH1+++Xw4uMM_c49z8tGzi3snU+-KrYA@mail.gmail.com> <Z1Hs5smgFV4C6c90@x1>
In-Reply-To: <Z1Hs5smgFV4C6c90@x1>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Sat, 7 Dec 2024 18:36:06 +0300
Message-ID: <CALHCpMg_CEUKGVXnkJbwcDEUNzq_N1Cac=Umjra=KL6vEpLcsg@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: dts: thead: Fix TH1520 emmc and shdci clock rate
To: Drew Fustini <drew@pdp7.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Guo Ren <guoren@kernel.org>, 
	Fu Wei <wefu@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Emil, Drew

> Did you look into the documentation

Yes, I looked into th1520 user manual but found only
mention of emmc sdio ref clk which is 792Mhz.

> That is a good point about checking the thead vendor kernel.

Drew, thanks for the suggestion to look at Revy's BSP.
I'll make a patch for the clk controller in v2.

Best wishes,
Maksim

