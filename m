Return-Path: <linux-kernel+bounces-555284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E02A5B1CF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FE23AE2D5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685833C0B;
	Tue, 11 Mar 2025 00:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN3pMG9Z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4CB360;
	Tue, 11 Mar 2025 00:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652003; cv=none; b=IffH7xF3pTF5OoqjVfE3DfpNafadsLtjVHzhJxohgYppajlLYgP4Pm/posupyITmTHPzjP9TTj7HBeE+tmKb5mDaoKCIhDEPWDrOCyCJKdbnoxqieHN2xZMiU8XT1MOkMrwNsS34hoQmTh7E7cAkk8khhdFecwddVS9XxkuT4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652003; c=relaxed/simple;
	bh=kzvAE9rkC0BaUIFVLg3gP7gcqs+gIUGEHk2OpCg+0f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9o58luS0yO5iWaSpQIX0Rf4NBMId5ieAy+fECsGJ3lz9673hHwwZEHFX0/a1+Jxj2RHcWDFCO7+00mYIsvl9KrIxV+vNLZJQlL9CXQOU7ABgMN1EcPnhxrGoR5fSaSDLfLBgIYbXwVPndaauika9u55/5MeYYpvFuR8qo7JdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZN3pMG9Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso7802924a12.3;
        Mon, 10 Mar 2025 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741652000; x=1742256800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXwnIJXW3efUwD1JuKOIjFDSE0Lnv/lNewJCUEgk+Vo=;
        b=ZN3pMG9ZYs2QQkkQnBawNYSWio+33cuWYNBjej85zFkiGwEX98NanBQYunMK5CAtxV
         f/T9+FitqoT4xrplDpPMkgtAoexvG5KBzn0cr9jMUtwUvGDFWCQecibYb4bqeN5ZJpmt
         1lFt+vvxQ2Kgi4pje7UZJ+R5pGvlZLR6BCCbJAO3A5mF2uDTmpqErzWUOZyzYBcpm0bJ
         hv7qvAvXF5i6JrpGKk5OkdV7Ux2uMw94NAbu2tJiT4qDZeZF8e4FgGQq90SsfT+E7A82
         O9HcEIFXFYxFNn+SbSMUT3vPume7y8Knd8+HbWKJYtlBq2tzmOk8bSD2D7dRK7MAcHvz
         UUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652000; x=1742256800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXwnIJXW3efUwD1JuKOIjFDSE0Lnv/lNewJCUEgk+Vo=;
        b=LcPu80eefQZDI+D9u+KV+BGy+r1WyUWOSzfg1fmu5MmGyReYV7Y01wCHQl2/CFufi7
         Q6BaBo+a3CTZWJUH1Z7y5qY0q7R9NSUQncAarym8zl2GeeYYava0Dke+fkf0kLDDVf+I
         3HFatv5nfzPFL04Ccg6CT0vBpE1FAH3DkO7sZa53mBJZj78WkQlfB4rNsrE0T+tRpYfV
         fkbwmkVCkRObNTw2IObLD4h69n0kIWACw4xEbPrfOWzZgIAUtpvnODkjHzT2Jk+izL7B
         vQffntT+HaMvjxo9JyAL5P76WFM5WxX9Vu/89S7htEVti3RmMBUaT1023Fkj/FNupbx0
         FJAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgDipVokuBYWGZELkhUT3VrTG5SKl4gZDJioHX1StoVz2sengxoMntoDyhT4EuHE56H6NqJmQDoJBe@vger.kernel.org, AJvYcCXfThCvCsPFH8rRJCfDAcfdkPe/LXGGBP24J10W9hnHdyYT1ppCspMByjKORuWBUPFcwmsrHFK1SJDWitU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQpl+pdtGub9pgviXzevi2302AurA2IDRjum7YiInkZFj8v+i
	Z/0CGqDfHdW43/bcKxcMrA9W+oHNAryKOG81S/0fcUQy9oDiYPSC
X-Gm-Gg: ASbGncuec/dkoTUVbud5wDnq6VDdAmxFVr2DlNZd5YUFju2chjlDDqoi5mNT2lGSfYY
	xMs9uvL2DDjH3i5VZTiKvIE1tdyd/gyD3A/gnEvoYKxaqO00N8mxbyqhCN57crDxv661/GKM+wG
	gg3hJEE7zNmLBF8H0mxnqp1m8qK084XIuA9kd0xYUYLtHHvaNKFGfw0HGr84yBQGhGSDtQ3B254
	FoAMkvTNRfozLINYZah/Cv/8sAiA0oNbbH8Mv7QDfAwvfuNdbjqzE7Npq4b7Cy6m/BQhGGUNdWr
	dYrBk5ZII9HWFsKo8Bip6aFu7oj/3EL1ggFkVoty+DPa7x3/030I3c/aUuxA8Bz/NR2scKEy
X-Google-Smtp-Source: AGHT+IFbZ+/+BB3T1PKNtpO4SqdvqZ/ZhrscBb34h5uigf+A2bGn64uE7LAut4lL+QsFjZON9rB3xg==
X-Received: by 2002:a05:6402:278a:b0:5e5:ebc7:f63 with SMTP id 4fb4d7f45d1cf-5e5ebc71081mr14273970a12.2.1741652000202;
        Mon, 10 Mar 2025 17:13:20 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a9303sm7639065a12.42.2025.03.10.17.13.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 17:13:19 -0700 (PDT)
Date: Tue, 11 Mar 2025 01:13:15 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] usb: xhci: Deduplicate some endpoint state flag
 lists
Message-ID: <20250311011315.4b3efbfe@foxbook>
In-Reply-To: <dabb1140-b26e-4f90-8e65-85e16d99aa49@linux.intel.com>
References: <20250310093605.2b3d0425@foxbook>
	<20250310093748.201e87cd@foxbook>
	<dabb1140-b26e-4f90-8e65-85e16d99aa49@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 11:51:30 +0200, Mathias Nyman wrote:
> Not sure this helps readability
> 
> It defines even more macros to abstract away something that is not
> complex enough.

It was less about readability, but keeping these lists in one place
so that they don't get out of sync and trigger the double-stop bug.

With this change, a new flag like EP_STALLED only needs to be added
in one place and it's picked up by both functions which need it.

OTOH, maybe such flags aren't being added very often...

> It also gives false impression that EP_HALTED would somehow be more
> part of cancelling a TD than EP_STALLED, when both of those are about
> returning a TD with an error due to transfer issues detected by host,
> not class driver cancelling URBs.

I think EP_HALTED is about cancellation (among other things), because
it indicates that Reset EP handler will run and finish cancellation of
the halted TD and also any other TDs unlinked by class driver.

EP_STALLED and EP_CLEARING_TT are less about the halted TD and more
about ensuring full reset of the pipe before new TDs are executed.


Michal

