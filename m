Return-Path: <linux-kernel+bounces-531689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926CA443B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D398188689D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9B21ABD9;
	Tue, 25 Feb 2025 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgk+0JNy"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241821ABB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495236; cv=none; b=dHlRJzieT+hvPY8hIfsvZGhQQ045Slm0AVfMgdYMInG6TksG+rCUfbkPcVIDpLv5PV46L0znD6d8B38SDHa0JC5tYF25bIDdofY5xx0c3rTuxbmF7PVJj43FnTMg/whd4BXsbQuvEGw7S/PMdMtNUlPkr0PQP6EkPOX1Ltx57l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495236; c=relaxed/simple;
	bh=/rkbwb7BWbpl6EvsZedD5EKq6cXDtvyu4pczaAeBfS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF5hDrbZmNYu+uCQ5WW31lV8GGjpRtFcNhDLJgQQjFOZ2h0+H9p83ZiGPehaNrk02qI/aQqKZORuEkCM1Y+1a79ZSgtw70vYN0J2OkEX9TzqOScQrtblRRxORJndKaUHXuNgGyTfCwqbQDtKSgBI9EGSbWfxe/8BFNS0gFXicHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgk+0JNy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so8251683a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740495233; x=1741100033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5C3026m8vJqLHregU/ELib4I5AMuVrmyvjpEMDfDPJI=;
        b=cgk+0JNyTeGz+vhG7I4PeJGQ095xAHkbapdPaaMPLShqivabNWxsskW37uRy1r9ON8
         fS4leKKkq6o8uPYLFbIdVr0e3Kx0q0hX3mGSfnqap4adwK8L5+q3lTL6vhW0v/NNFezF
         /WE1356lCVUNag0McCAIlM+SRFwK+0EM0kyLCY5O7MbhKutuNhcFjS1YfezH32scI0Sb
         qIw4Z13zYOYDON+xGux7CaSIMs98oxoOpadi4w1eH5TpeHsl/T/E4VayB6KfOddvmIDl
         O2k7vvGCRCKg3CtnuGyfPW/++Fttn/+ySZu+HmOEsi0T7rzCT4u4rv+tTD5BPIgJ+wbz
         6IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740495233; x=1741100033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5C3026m8vJqLHregU/ELib4I5AMuVrmyvjpEMDfDPJI=;
        b=DmnPz99cck1UN3zW3Rke1elG6gcoHxvw3MpMObJZGR0U3s4t0TVSlxdcXFBElaIHxs
         83d8GxYHxDCOu5EeoHOKQdaRuN4qbz3WWJ5UA6eduSWSRZ50akVwIRe/076SpD4co0b/
         ugJckNWPzx5Zr+iOyZSpxiBs956OpmwrEr7+zEZpFv0UyPCmYLlBTywXbbY/nc5U7FKh
         +/7nEdL1IAFuGXrqk98Uk8j0686Vot2iXDwZNTVBHAC+N/BLBgv5OzS06tSOXzHk5FXf
         UjAfIFEz147h1OMt88zTINw/I+8g2nuRKCyMO2ytGQ6ck8x3t8xKyOHDfGyHlH0A100T
         ypQw==
X-Forwarded-Encrypted: i=1; AJvYcCVp9BdWy6z+2pPI2qsJnhjtrtcToAYBHvgvpagYFlkNerqZGGxWXG6OxjrY3kH4WlFmiGrznQrDilB+qow=@vger.kernel.org
X-Gm-Message-State: AOJu0YycRv5SZQRE36LwTgn15yePkLcC3Uw9MNZNRmiJkomRHLohPMSk
	g5tTWMlu+PnLXlmaauRFfW/VpSuiJt40khH8jGbGD6c192sSfa/fPFi1xAexqco=
X-Gm-Gg: ASbGncvQhOjvx0pB+seAxPyY/CHuCUSwPSNNTB8dm9XovwRGTbSCRQWEpj+q2/+C9ci
	yBnvYJ3zJ4zbdsijJWh42E01VNCUPYl7ObGcE7FTx4SafpDhb4BuNHJ3ez+FHKswmtdOpxBJP9h
	grxBJ73vZXRB8ODPzkIY0+5N5TKs4Jf6E4jVm9AvUZTPgSU+FOpD5cRrhjDkXL6temtNTQaJ5+e
	Tj/tSOgAEfgjtmYzVbrNA0dZbKn3Aht3eplLIHSswdwWJxyYyaszEwTzA8PNxzKwBbJ6EtFlWaH
	aBh3SsL21IBi9UIOLzjSH//PPjhLQ60=
X-Google-Smtp-Source: AGHT+IF9Qg7g9R+HcAoXsNncQZZXosXuBSyKZekQD9yLdDMX6VPLdQatIx5tZiUiQOgii6TA9Dw+0Q==
X-Received: by 2002:a05:6402:50c7:b0:5dc:a44d:36bd with SMTP id 4fb4d7f45d1cf-5e0b70d5790mr15883093a12.8.1740495233068;
        Tue, 25 Feb 2025 06:53:53 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e461f3e7f8sm1338944a12.69.2025.02.25.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:53:52 -0800 (PST)
Date: Tue, 25 Feb 2025 17:53:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Phillip Potter <phil@philpotter.co.uk>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, paskripkin@gmail.com,
	Greg KH <gregkh@linuxfoundation.org>, linux-staging@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>, baijiaju1990@gmail.com,
	stable@vger.kernel.org
Subject: Re: [BUG] r8188eu: Potential deadlocks in rtw_wx_set_wap/essid
 functions
Message-ID: <40085616-3b80-4e4d-b610-605dba69aede@stanley.mountain>
References: <CAOPYjvaOBke7QVqAwbxOGyuVVb2hQGi3t-yiN7P=4sK-Mt-+Dg@mail.gmail.com>
 <Z73MMWEI7o59qzDL@equinox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73MMWEI7o59qzDL@equinox>

On Tue, Feb 25, 2025 at 01:57:05PM +0000, Phillip Potter wrote:
> > This issue exists in longterm kernels containing the r8188eu driver:
> > 
> > 5.4.y (until 5.4.290)
> > 5.10.y (until 5.10.234)
> > 5.15.y (until 5.15.178)
> > 6.1.y (until 6.1.129)

This work is interesting, but we're not going to patch old kernels to
fix static checker bugs.  If the driver were still present in current
kernels or if it were a privilege escalation bug that would be a
different story.

regards,
dan carpenter

