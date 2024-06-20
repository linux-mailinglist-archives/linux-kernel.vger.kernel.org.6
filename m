Return-Path: <linux-kernel+bounces-222122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAD390FD23
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 08:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0935E1F22CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 06:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D192241746;
	Thu, 20 Jun 2024 06:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UsCA7o0L"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AE3FB2C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866579; cv=none; b=bp7HBaVJYGZN2pi5oge9JctTdCgjdKndGcPOKu+T1+Nv/GAAd3LAUTeVW3fln/4iDpBlJmkdfcQfo/LmC6pxXwnQLEDdDS8ZfvguTE2VSe+lZpdlDmSAurd9AnhVfHow1rxyKTQCvck1JstGY+8PGhlBwCAmKql68/OV1rrj2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866579; c=relaxed/simple;
	bh=GldMuWD8UF3ES7MDRD00WlxvH7IBFEdp78rLq2gjygQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKKdiWN7X6WY9mEmopdIINpMGJTLM1KOeLfBJVW74EI+Sm5e56dA/+5DO/pSwMS/+ZlTOgaWpB4aAZbL64QLIjMQ3iMCPx1OgP6waDp+N7SYquYjKDPR3Jcc9TxFhgAsnQzrk5jU0gBfY78RJbZMDbua0/qSa5DXIEuM18e0MFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UsCA7o0L; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a08092c4dso5429857b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718866576; x=1719471376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yab6t2QuHd3qRnOjOue/gVivXnSlhEWX5CWnQjI/lMo=;
        b=UsCA7o0Lecv0P7JN57SD7eNydnVfZzaNoiFp8qYiJGalV0Pn5F3Q5O+MwsIPIgR/ij
         Yt38zhmo/pmYAxzP2dkO2uWersIavKJgFzoxO7TWjhPNlar9U1B1YQpmxIKzn4U3xgZu
         LkeWk9fQGPcJ5DFM4PIddNQThN2SHn+QL5cR0K+IBcPC1uoFwSEA56KnzSYA8XNobJuL
         TDJ5YES5WiEuJ4n1eBHQD282F1MRCppeieBz1sUduC4NJ5ImSDcuPwM0LWOunQAcxjAW
         uHHMZ2J8AGEIRFmYyrHJo34Ecm6Fnb/11OUoyaq09g7IWnD9icJf1mPd9zXItTNWhYdQ
         9FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718866576; x=1719471376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yab6t2QuHd3qRnOjOue/gVivXnSlhEWX5CWnQjI/lMo=;
        b=FDoRRc2ICydlW6WqrwFSfXacAAaINQYuUxGeBPoTHGRzZ+z+2Bx35beHCMXKfPXQBk
         SEuPyY5OIwOJNVacUqMJWQZDVn/JxnuT9EjZItgX350sX5c81A84uElw3lP7ftZlaLTE
         gclqApVAikmM7jxYYc9XVN1pFXIUGVjO2C5J/LfzXrKiUSv7pZ9JwTX3DmiDAbMWLMcx
         wtva1561OwtUiAcAuGJ5fHgzeyxjk4e6KOy27Ei0d9SQw9t6sLWJ6l7HE/Vp4CerZcLr
         oyc4yudvYCzdHbaAHsKI3d7G4uPTzT5BqiGfXLpZbQVmtpOPBDzKNn4hx888sLTv9oFv
         zMeA==
X-Forwarded-Encrypted: i=1; AJvYcCVe5YIvHVdsO2HEgp8HKoN75e+2IRnQw9YiEqBw/ldxyilbaOTnUvhfKiYADtCmYRjKUbm7w1kr6g2se+OdYqqgHCHqmud/bBnIJ67c
X-Gm-Message-State: AOJu0Yxd0VT7ZNVeRzduD7i0A18DcR2C1ZEhMXxOToVZ2KjqWB1S7myv
	06HOsx3ZR0m+kpggXXJ5UTYRTQFyPh+ajGcTutMry4EB3HR8+gJJuHRksTXdydbwzNxj3tVRqQD
	OHR9eS9eKIMjfr7Yj2tHDWIVhstKRPeqkTzwdiQ==
X-Google-Smtp-Source: AGHT+IG0lreGB6+pEOuO/acZ0C3UFNmveVZT1X0qeHrhKCfnM3oPwFhmWsMpUEJyjAhqixw1BNMGSzYp4xtyVq+feSc=
X-Received: by 2002:a05:690c:d84:b0:630:de2f:79b3 with SMTP id
 00721157ae682-63a8e1db2aemr61384957b3.25.1718866576455; Wed, 19 Jun 2024
 23:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620033434.3778156-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20240620033434.3778156-1-quic_zhonhan@quicinc.com>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Thu, 20 Jun 2024 14:56:05 +0800
Message-ID: <CABgGipUjwgj=vVC31zMwJL_ro_L94ouGJHMm=E-wSjyervchTw@mail.gmail.com>
Subject: Re: [PATCH] riscv: signal: Remove unlikely() from WARN_ON() condition
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	conor.dooley@microchip.com, ancientmodern4@gmail.com, 
	ben.dooks@codethink.co.uk, bjorn@rivosinc.com, quic_bjorande@quicinc.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:35=E2=80=AFAM Zhongqiu Han <quic_zhonhan@quicinc=
.com> wrote:
>
> "WARN_ON(unlikely(x))" is excessive. WARN_ON() already uses unlikely()
> internally.
>
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

> ---
>  arch/riscv/kernel/signal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 5a2edd7f027e..dcd282419456 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -84,7 +84,7 @@ static long save_v_state(struct pt_regs *regs, void __u=
ser **sc_vec)
>         datap =3D state + 1;
>
>         /* datap is designed to be 16 byte aligned for better performance=
 */
> -       WARN_ON(unlikely(!IS_ALIGNED((unsigned long)datap, 16)));
> +       WARN_ON(!IS_ALIGNED((unsigned long)datap, 16));
>
>         get_cpu_vector_context();
>         riscv_v_vstate_save(&current->thread.vstate, regs);
> --
> 2.25.1
>

