Return-Path: <linux-kernel+bounces-571864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD69A6C356
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 20:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C293B0CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A322FADE;
	Fri, 21 Mar 2025 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOvMhdo5"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209C1E5714
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 19:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742585345; cv=none; b=iJnmBz+ECg+Ypw7FC1V4nL1vWGVAWaY0pidDeUtrB+J59yTB2IknXH2QSclWJQ9AjPGzQXrrpOFVpRZpnghZ6Wl7qL/iucmuaPEgc4kze9pp+iPZ/D4rZ0KVzV79/25+GHkpbeJfWHamiFMLX1eLKVpQmOZTwDSTokkZY5aiJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742585345; c=relaxed/simple;
	bh=BuvsGhJHZ8Xw+48Ecwh+fuc4DRA4GXHKSEgROs4+XPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHWf/JVsEDxPzh6Dv8eW0rDNywuENiGwfHI8NjEtljJwl/csIqgXTQfjd7q44n91wmObNhsaczygpmCsLLFl2+ifhWxB5xSEpKzgL8FnBh0+DUzt30DM7mHwfkJXroFzluWvurqfTN9KNOaHp9DXHCynOXWcabshh9V3Yz/Q6dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOvMhdo5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac2c663a3daso469106666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742585342; x=1743190142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2hED09Hatc/530rZzT/g3h0VUVivrA2PSH7ts/rtDc=;
        b=lOvMhdo50fRX6nSvsQlhJQuPN52c3dL0fNH04653TLw3zjFSm0vlu7qnDA3+DgC81m
         xW4Rg0iLiZfVCal055ily3TsMgG7vle2tAgQwpkUHHJw7hW5iOndyCkq/e0zP/X0wX1W
         W0k7OcInwsaZeNCZTByjR7Y1w5rka/80yjSmLTxOpws+WPjHG+5TIm8vicmYJ2H/RNHG
         dKK29CPlhyEjVJRMV3nfv/lh/UKP6TBx7odSWgm/57NeLs8TsD7BNs/vsLxrJqvH63Yg
         G2cFfIC2dLBkVevHhBTqurpt2Z+pLozCVhcVIsMVW9yvdo2c9Tz0JOZq6l7MmZywD4FJ
         IrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742585342; x=1743190142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j2hED09Hatc/530rZzT/g3h0VUVivrA2PSH7ts/rtDc=;
        b=lfLUqq4C6eFpwD3sxGz3VunFJHVvDmOLZdKwKPR8zOllSxsFgG4UCivaTGK4/RWPHc
         KVtQyZ8hrijUTqWIREEZoSnQNUMY44/RP6VOmDK/iZ8dhlJxpvbMGNJMgiQUkzHNpH3h
         sIK7WC66qv+SK9b6MXgSySdtt/RAEToK3azlHHbndDajDxASUy+Df/u+Vqa2VeDVLapz
         jH0nmVrvj7xpNVi2Tjjt5sU/uqRXeGtk89o0x0ciKQ39XSzyflYuKP0u/1GGjMUVmd2C
         2dCo6sR7nErdeZv1+Scvs7pZyFnscvkgMc14AGDFTn6xm5tfHLPpPKOq5kzsT19cEwIl
         CZ1A==
X-Forwarded-Encrypted: i=1; AJvYcCXplrplY4PuQUvOx+gNQROYA29ALpYWV0TRvDZMQ2Ypygku9bnRIpO8fnl7yhnLU8hdAutmdq4WZkxfL4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YynhVVyok1MvMavV4jaTps3UBw+3ETve6hywPiCbvLWxZaKcnua
	yHYzAch1N07baXl2bs52uLakFLeX80hVpK1BGYKx4Viv81uZsPFnT2uyU9e2QVQv2P3dSMEoDMz
	NDr/iva0s7HFMvu+1zbK6+7oVXUFptbR8Dfo=
X-Gm-Gg: ASbGncvp80/fSuUzv4DBARrY/gTXdlPiv+Z2nUmzEErDZuALF+RmDoY2Gd3r/DtNDmJ
	6SuSmcU+QAW78r8ZWmKbX7cQeg5n/acSt52scx5qRgW1/45DmkLsQPu71tyGO/jcE+Qf0MyTmzx
	gVE9lJswJ2NE0dtpC1suQHAns=
X-Google-Smtp-Source: AGHT+IFr6DHIIXCK2jv2tQeCJB9flyjvB19jQyVNG+m61yysVbGI2vUqrhw0CPy/4k7NDizCoPraQg+p9VazXzLcBqg=
X-Received: by 2002:a17:907:c7cd:b0:ac3:da3:a1b1 with SMTP id
 a640c23a62f3a-ac3f2238346mr451667366b.26.1742585341652; Fri, 21 Mar 2025
 12:29:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320235910.334620-1-changyuanl@google.com>
In-Reply-To: <20250320235910.334620-1-changyuanl@google.com>
From: Bill Wendling <morbo@google.com>
Date: Fri, 21 Mar 2025 12:28:44 -0700
X-Gm-Features: AQ5f1Jpu1bzXyoskz236qYXLKL_6cPSKwyh10XNtASrfDEnHoVGM76uniVMGG08
Message-ID: <CAGG=3QUEY_Gmu-6K7rk6-y8AB7HVuV2V9sP5K3h379teAZXyHQ@mail.gmail.com>
Subject: Re: [PATCH] clang-format: add for_each macros from libfdt
To: Changyuan Lyu <changyuanl@google.com>
Cc: ojeda@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 4:59=E2=80=AFPM Changyuan Lyu <changyuanl@google.co=
m> wrote:
>
> Add two for_each macros from scripts/dtc/libfdt/libfdt.h.
>
> Signed-off-by: Changyuan Lyu <changyuanl@google.com>
> ---
>  .clang-format | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/.clang-format b/.clang-format
> index fe1aa1a30d40..4decda7474e1 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -210,6 +210,8 @@ ForEachMacros:
>    - 'evlist__for_each_entry_from'
>    - 'evlist__for_each_entry_reverse'
>    - 'evlist__for_each_entry_safe'
> +  - 'fdt_for_each_property_offset'
> +  - 'fdt_for_each_subnode'

Could you alphabetize these please?

>    - 'flow_action_for_each'
>    - 'for_each_acpi_consumer_dev'
>    - 'for_each_acpi_dev_match'
> --
> 2.49.0.395.g12beb8f557-goog
>

