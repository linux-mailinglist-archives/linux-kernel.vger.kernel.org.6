Return-Path: <linux-kernel+bounces-563960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FB2A64B25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDB03B2A41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A58225A22;
	Mon, 17 Mar 2025 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFkbfuaE"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388E233717
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208698; cv=none; b=dKsOpy64/y1lv0/UGS4+YknX8i68cW9Ze4SRNG4acOBf2TdG3RhxXW9Ru5lvB+4jbPVHv4WbNhsE3P0cbGbPbxEXdu8DhJBy3yyjymWz4/vapQOd+qMRgYh0SpQcXR3LhBrZLYfu5lQIdGm4745od8155PA1FTRCTKUOxg1OnKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208698; c=relaxed/simple;
	bh=G9bGpVVumkh4EkeQ8f+423AnFKXvZJS9Sk4lm4BBydc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgUt2h65osm0NxDMkvAtQuhZSRlasEginEyyE8xrkm5nOzZNzR++zkCjqAfNSMP/RwRiNk8V7a27Nis1O0A/oMdwiaSRA+HISaLSyllSnlTcr+/FTggw0G2ZWykiwptKgqiFF9A9fl3w67VWVeiYEv2VOFy57BGe4gfe+y5+pF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JFkbfuaE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff37565154so34366487b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208695; x=1742813495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XfVnG4HkUsVDQ5d3JfJrfe7r2SoolZoIbYsONCWi4uo=;
        b=JFkbfuaEHPPFPnEVdlGF7mLpnEi2v0/MwVP90rSOewDXxHN1fIuV2oev9W8p8CcRFQ
         2pLeOf0EmooRC8O0aThuUdl9HNG4YtUCCJL3x4ORe85+gVJ6N//Ne4pv3zEznbPZBksR
         F/61d79m+O07U6asq8eQmhZ2OFlBaHtXzemdAhRiyOMvBGtT6G5SUST5g8CEhoAROEbg
         RGIxMjhXcRhibDQ4GkZpdZs1PTRctaDeqWf43knlnK+PDCn7LaqFZRsrjRpdx5yGpRUR
         8MLCsO3vxdVl2nXFU6P831tYrnmnODgpPcmTfBYjj2ce/pc0pt8nlo3kkpqXHL6niq4B
         8wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208695; x=1742813495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfVnG4HkUsVDQ5d3JfJrfe7r2SoolZoIbYsONCWi4uo=;
        b=kTlVX8CTRfih8Px6sxfUKsg5GtrAdq315FeIHGy8+qipvOYvAKeXPAcXmCMwyI4nQS
         FDUaUb1jaGSKxSvrwBcHkvJzY2DVkrtJhR9Dbwvavqj0Z//EnknfeKcn3JG1SkasmeT3
         4wqz5u2IasFQum93Vc1YCp57y8tNM7a3ZNVxJYqU5pfgVEGxLlcbow8LLixpdE9aBueF
         ZkHrLAktBnm8h7F/uHh8qZpFfPiprCvDZTW6wD9Z+PkVU1E2VRfsgEnD8SBj75dV/sGK
         gv/cY6e0i9A3lzwKBAg7TPP1EFSOQIuvCLVWAWK605Erm1BALvmkz9la0zfuAW1oFiPm
         s1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO8IjiEl3Vi+ie380/AOMLgoRqP+o1DUNKIcA4fqObKW8OWHc5JITeqHMpISWa2jOhTFgcOO/EH8Mca6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyICllCCrhCmBKje6HwNVAzguz0kH0qFV0ae498qKPeDUApnvi+
	7QlgQE97m7fXIauWibnU+fsGhrwI+cRCf2op0PsVbYopqVW6rAqYA9NclmUoFnH8V0S4o8t4CtP
	nxkM1+H2m4qAuDHIBfgdc4NvYlduGMjbOpmF3wg==
X-Gm-Gg: ASbGncvIJ178UNvjnJJBRdYvNd8jYbY1kxSOfHD3ljnDa90DxtPwPXi/xKxAferjQlG
	/eZzG674EjtUDr+uN6S9ijKPajnuzWt8yBBImDe4ZjllNDqLkZWR4Az8uTiRv1cL9UT+GK1uoBA
	xzMylRNzTOPPWPBGE/ib1KdMASmI4+lYZl+gzFpg==
X-Google-Smtp-Source: AGHT+IHG+hqqY7z4YWoNHFwken+n5F9fRUkOdKWXpn1zIzLsSXAtBJ1qYKxYTQkl9v5HsBxDmf6GRlQfnrNNQji4duU=
X-Received: by 2002:a05:690c:740a:b0:6fb:b2de:a2c3 with SMTP id
 00721157ae682-6ff45f615d8mr143741577b3.9.1742208695401; Mon, 17 Mar 2025
 03:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317070046.24386-1-jirislaby@kernel.org> <20250317070046.24386-18-jirislaby@kernel.org>
In-Reply-To: <20250317070046.24386-18-jirislaby@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:50:59 +0100
X-Gm-Features: AQ5f1JozYMb7s-WMdJg9CTQSW8y02swNli38bn-VGUEE_cdcqwI1tkZFu3cBTsg
Message-ID: <CAPDyKFrwNfd3F5EvXvTJHM4dd+mUuy6jQXxVpq4FtCzPN0X2Qg@mail.gmail.com>
Subject: Re: [PATCH v2 17/31] tty: mmc: sdio: use bool for cts and remove parentheses
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Mar 2025 at 08:01, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> 'cts' in sdio_uart_check_modem_status() is considered a 'bool', but
> typed as signed 'int'. Make it 'bool' so it is clear the code does not
> care about the masked value, but true/false.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 6b7471dba3bf..7423a601e1e5 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -471,7 +471,7 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
>                 port->icount.cts++;
>                 tty = tty_port_tty_get(&port->port);
>                 if (tty && C_CRTSCTS(tty)) {
> -                       int cts = (status & UART_MSR_CTS);
> +                       bool cts = status & UART_MSR_CTS;
>                         if (tty->hw_stopped) {
>                                 if (cts) {
>                                         tty->hw_stopped = false;
> --
> 2.49.0
>

