Return-Path: <linux-kernel+bounces-305633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE4396317D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B602CB21A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2201AC437;
	Wed, 28 Aug 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="faAayr3W"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1F1A7ADD
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724875953; cv=none; b=J43cuiixCXxJGeY9f0paaSiVKG5Uy6TT3cochNwwEkmbA9/SNamvyIfbVh6GgsNpIX1+ImgnmDz9WRflcccEGly7YxFIV+CAExgvVMo9hza4O2IGKfJtvVsIAJcPoe8BUXp7NcDoCrizTq1HU/IsEfx7ftlsH9ckoV25cG3zWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724875953; c=relaxed/simple;
	bh=jGk3IiwUzRzmxArPvBMbNt8g1cl97UCtdj2Slzyuvzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfh/hwKo1wjN1sPPakCbVxwvmGyuq5my168Sk+eE6HPn6X1veA1jXRy/vP1MWdrZSIQiUoucSJ36q1Uav89bDMn0c8cmWINRbz0CDteYe4srK+gtYSiG053XXaE90tb00ZSOV+9QQ9eEYr9Dz34a5vqWi8YYV7wicaKabJ3pReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=faAayr3W; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-270298a3b6eso5091756fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724875950; x=1725480750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGk3IiwUzRzmxArPvBMbNt8g1cl97UCtdj2Slzyuvzw=;
        b=faAayr3WXQaUKVQRUfgjKlYP7nVUoJmM0Bd5sQgVb4kj5eIBrwReRPVEFnDn3XcH/3
         yWxJhiY7yRiN5tAQxpxFhoVj2nNIrN+i8gO+FCRsvaaUY9noOu37T5aRUfA6ZbN2WG1B
         J5kcuPBV9ro56NqJs/oQ0QfcWboIWtcFeZ9Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875950; x=1725480750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGk3IiwUzRzmxArPvBMbNt8g1cl97UCtdj2Slzyuvzw=;
        b=GgE7iqBg+uZ7kObFmXTbF99czFCLnqmUzVJdEYQCfKV0VUu11oAkIAsEU/BRpiQBlL
         kP1fC5qe56S2hiU8Z+VL4PHV2td4H0RTAgicXGtNEN4RRI3gZSPCDjfnaHk0MdSeJf1I
         QvuwY7rsdkzbEkvuHIbsGa1YIZKhnVYI1LoqtMB8GA6zM8yCmAcmrsfxYXy1uWbWGoLJ
         GmdcGlqaN3S7XHOQdr3/HXEg3FVhmkJYaZjRQyrzRrbcdXW/TDDpITG0RNzx+HJjnYzL
         vtgXlRMfpk2cfkpB5SfHq4LsWe+qbYQG9s+kEtlR9fB46ZOVCvpalAJDTdx7ljx5ZTTL
         HEPg==
X-Forwarded-Encrypted: i=1; AJvYcCVdP17Ii6nHAGlPFTKgxEXhTzuOSaNWDhATo1w6bP9ryzOEQTK6aLcS2oY9i4MR0iL+IOzyYLaCcPFIfBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBRPd74QbRsiD4Rd6PnDJjXtWtp1fbUoIRW/wcXNcpiFJfVoc2
	GJTB8K6Y0YSFfblyl0ZoJx0ViywuGO/2C/Il/VvM3Pvw8UOc1essy4cR6W2LxCs/l4iwV/BGrEp
	fZ2pp0r7c/eF6TRieQ2b8ZUH21hjPDRQNbkZTrr94tpgDJ1KRYw==
X-Google-Smtp-Source: AGHT+IHLDODMNbEnCfqL2GYgOlt4Y56s9ddBK58B8O0T1BhA5JoWbF1aKfGpz51ivkrxZvON/WgiSOTfrlSk2qIaH+o=
X-Received: by 2002:a05:6870:a10f:b0:25e:c013:a7fb with SMTP id
 586e51a60fabf-2779031b4cfmr801301fac.43.1724875949809; Wed, 28 Aug 2024
 13:12:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de> <20240516083017.GA1421138@black.fi.intel.com>
 <20240516100315.GC1421138@black.fi.intel.com> <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
 <ZnvWTo1M_z0Am1QC@wunner.de> <20240626085945.GA1532424@black.fi.intel.com>
 <ZqZmleIHv1q3WvsO@wunner.de> <20240729080441.GG1532424@black.fi.intel.com>
 <Zss_zqsJOZKes1Dp@wunner.de> <20240826054103.GO1532424@black.fi.intel.com>
In-Reply-To: <20240826054103.GO1532424@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Wed, 28 Aug 2024 16:12:18 -0400
Message-ID: <CA+Y6NJGFyGF-JT-kqkDi4v8CWRumho8cMGUuWvfa2TweA743Og@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

> > I would also like to know whether "usb4-port-number" is set on
> > the machines that Esther's quirk seeks to fix?
>
> This is only present in USB4 software connection manager systems so not
> on any of those as far as I can tell.

Can confirm. "usb4-port-number" is not found in the ACPI tables for
any of the devices I have observed this bug on.

