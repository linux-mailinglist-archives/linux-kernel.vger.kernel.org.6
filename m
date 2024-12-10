Return-Path: <linux-kernel+bounces-440193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F0B9EB9FB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 20:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764FB188341D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6574F214231;
	Tue, 10 Dec 2024 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/zD+rQJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37F194080
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 19:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858265; cv=none; b=YF+qnlwEdHLegmvbgeB4Kq/nB6I/4eDFDud0XBtBvuEGlNJJgidaN1b306ZH4PxQ/FQa9iILtCLE+JD3dkKAUWiJI0Y4aisUYF1V152ct8UH7XIgaPzoxAicq122/QyNhoO+JajY8KMm/xbyFLum9nXRA4vCewtGnyZLUuxq+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858265; c=relaxed/simple;
	bh=eGU0mIINa6T8fhI5FtprhirLw8Zptc42GotzkU7/ioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkoQcC6Xw7C8SFEzWQ6cBs9CW1UycbMUWdUnF6JDvEGPuJG6bkFh5x207d3V0zya8wvNZ+Uv+Ml+elnz0NpOyex4sygesVehj8aQYpbpTMaDzPPgEI91vHEsz0QjgMUoU7Ut6bXxeUJac8VLNAFlrThi/f233F3o4JU5p1Xr2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N/zD+rQJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725ed193c9eso2257471b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733858264; x=1734463064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xk47WmIz9ki3Hb/hScrQj5pNAhQ/SieMlK2IVydARFk=;
        b=N/zD+rQJ1MoEeFYrHtn5sGRyt8nDlPwIB18fTUZAJOSLmBr5yd82d8+nHY2yLQqu9w
         cHwly2ChE1v40HVuxTkVDF+8+wQ9RJ27HUdvm887evT7QXy0IPuuGCsztitYttFcPRpm
         mvaWFWBJmOLT+4pqz/OzGSIWgk+WnHoOCvuWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858264; x=1734463064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xk47WmIz9ki3Hb/hScrQj5pNAhQ/SieMlK2IVydARFk=;
        b=ty8AcIHnPT+AweFi6Qj//e4/M3A+HA4JjRSw2knAVFr6NBmlqXHyGjqv0rmuBop72t
         HK0E0jsNb4mAGuks7bI0Uu/+TH9kQP+krMHPOkq0k48G1WgjE1L6iNU0DKRbGeooSF4C
         cPJvYI9ucFPir0bouOOWftiQRRXFPIA4tOKzWu2xJcpnB6vwi4KBvs+W+s9hY+54UtFE
         Z2RJzMU/oxLSe1zUyan+BP8MaoDcRW6vcLuIH4MspS43VbmfgtBjOEmwF7a8wGAqcBN9
         0vPmFV2aigtq2EntuW8fRtruhuU9UFJKgxp5GD0pfSDGEXAvno0Ypux8LuDEBbfsSjgq
         szOA==
X-Forwarded-Encrypted: i=1; AJvYcCXJXk8IZLPBDAJ5LYnKtgsLOH2XAaLl4a7oiJI3vmScAOurC9s8X9710lWVlpmK4Nksw4j/pw+VW9a3ca4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9dt6OIaw3dz1sOip3zMHgmRdp7JiU1euGYV+CerMQBpKEgRK
	H6wiHNZ8zu8p6xcGuEb3PlI6Eb0g1gaKOgYSkyM8nCIYc3IJVkc4O7tgx7LKFw==
X-Gm-Gg: ASbGncvjBDs78bykVDeu9Z3GRxK7vPXR3yTaqkn2BlYZQgMq8VunsIPlAvSMC6Txett
	J5LDVExwBl2QAMGg4CdMrffrxBRF5xY52w30NP9JtzreUd2P7i8btMkHLh5S5shSH1WsW2uOqKS
	X6BUnvnMRrhKR0zpDUT1Y5qiGb08FpHhPEAbsUKsJ7lJXuCgCUR/Aj8tzcA2pc0DOxooDucQHDv
	1jjpEOaC1h2bx/Gt6kdq6/WiAW3mN+rjSUn9LLEdmbCbs9lPXsm049fZAB7XfYhbG5XAGNMl2Oz
	nvm4rDhB9NDfqPH1
X-Google-Smtp-Source: AGHT+IFouz+xwSXmKJpuaar0NgPRKR2IqrtLtUtgVKbajLdmdXyU+pX/x3oI08eGDNaVgZLpKgwCWQ==
X-Received: by 2002:a05:6a00:2e9b:b0:725:9f02:489f with SMTP id d2e1a72fcca58-728ed4cf3b9mr166355b3a.26.1733858263696;
        Tue, 10 Dec 2024 11:17:43 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:cf2b:44dd:668c:5818])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-725c91c58fesm6871160b3a.51.2024.12.10.11.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 11:17:43 -0800 (PST)
Date: Tue, 10 Dec 2024 11:17:42 -0800
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Don't match device with NULL of_node/fwnode
Message-ID: <Z1iT1tK-kHyNIoNL@google.com>
References: <20241204000259.2699841-1-robh@kernel.org>
 <2024120450-jogging-duty-fad4@gregkh>
 <Z1eBotg2DiaXLWqn@google.com>
 <CAL_Jsq+5cQHqoJ9wAgt0moU94Bddgsw+Q3TEWDqQ+-rryJPS1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+5cQHqoJ9wAgt0moU94Bddgsw+Q3TEWDqQ+-rryJPS1Q@mail.gmail.com>

On Tue, Dec 10, 2024 at 06:33:05AM -0600, Rob Herring wrote:
> On Mon, Dec 9, 2024 at 5:47 PM Brian Norris <briannorris@chromium.org> wrote:
> > FWIW, last week, I also cooked this change locally (+ the ACPI change;
> > and a kunit test for added fun), before I noticed Rob submitted this
> > one. If you'd rather, I can submit my patch series. Or I can submit my
> > patch series on top of this. Whichever you'd prefer.
> 
> If you have a kunit test, you win. :)

Ha, OK:

https://lore.kernel.org/linux-kselftest/20241210191353.533801-1-briannorris@chromium.org/
Subject: [PATCH 0/4] drivers: base: Don't match device with NULL of_node/fwnode/etc + tests

(Side note: I just noticed my mail script managed to skip LKML, although
it got the acpi, kunit, and kselftest lists. I can resend if that's a
problem.)

Brian

