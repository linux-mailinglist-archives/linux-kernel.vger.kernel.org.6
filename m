Return-Path: <linux-kernel+bounces-383465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 030969B1C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B21C21047
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009D38DE5;
	Sun, 27 Oct 2024 04:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/nYKqSg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40D2B9B7
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730003912; cv=none; b=HGsGA2mOMxDK+tAY2mn0zVB9doWsNp59oQ64Pn9YEa6bobs1gzfsqXN4Z4LGetFVec69+P/uQtXxR3uQuEx0SHm5uQrqNb3JIrUXC1d8zMd54tiLR8OKzCnA0YmmySYNTlzEKS1hDU8iGI1wVCxeg3uj7KY56Hr9PXm2zPacOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730003912; c=relaxed/simple;
	bh=9a894voPSeKCWDpJXy575tccinogzHEiPfzfOZ7KaWk=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MuUxwTP5MJ43oIUbNCbBrY/m9vuOLZbimvh5n3f9/pDzpI6cHSTIsPMKTJ8YzJ0xQjI0bleqk8+MbNoTZq70cqmXHAj7LfuMTokQ0yx2sboem5feX0iCtjMNB7xbWZKB5yyz+zWciryRDsSi3vqwbo/8JlPO92/DQx4lb3Qp5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/nYKqSg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37d4ba20075so2287835f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730003909; x=1730608709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9a894voPSeKCWDpJXy575tccinogzHEiPfzfOZ7KaWk=;
        b=j/nYKqSgrHJ7komN/lKf2nLp04jiVuC1JtUzsTodyZpXotbJBwRSaeEyh38pbTt658
         1o7tY4+AuaXIAsb8b22wuxJSI43ivZVdzv6BSL5smM+IOU0XJclTy0nC8+q+hNX+IXFR
         LsWqD5W3JCx/XaUlrOTIO5zdq1G6SouKgCbUidxE7Ye/UQRgf3kKOWfgnvB40bvJbsHs
         0BQvAcfqreMrTCR0PJowU67iRdVpQackv7tcfOxu6BvLNu4XofkIVBRiFufH+X91r1Da
         +amfterwgWvl+FXUsaKhiJDApWD60olKLdltEMTVKUvlz9OQDWTm5SM0rzfma1uGfba/
         PDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730003909; x=1730608709;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a894voPSeKCWDpJXy575tccinogzHEiPfzfOZ7KaWk=;
        b=mX7fD1/3Ixu+0LItXdwBteBH/QGymqe/MVPwsGSUvdNHytElSaoYGX9ABfHYbOxESr
         aCA59eesDk3ClA0CTtI+RR9+n0X1TGQToff317bfJjNjQnciOTxvkGHPmtcCglC0kpUm
         hAySFnOwDYmLENg/ncXzsTEkv1DjdPoKJMxs7lWctlvbz/3/7iE+BnpCBJP3fcfa8MXY
         CP6RpKs9Bhl7YKFNBuK9pyqScWZrFAGhv/4OWWXRqKPSU4jos+4W/TFb/fwUdBDlGZ+I
         VlNBVx0aOIiGDWk3iRjXU+XDkhQGZUWMeIX9zIf4HgEo4L4hkw4L18SidWML0JcYA8Gv
         dTzg==
X-Forwarded-Encrypted: i=1; AJvYcCWdY4cyyD69qDtOT/bY+ObGwLSfTu5zKZg+xe2aC9MXVzWfHt0/OT2oYtsRdi3e86jKO0VH724Y289iZMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPqWVMTHLzZOzNVOFBuQW8BhUlIy5tzLYQI70pRTjSNJKyrgA
	VQDGYuzqH6Ro0SHPaXIqNmmyzbD0ixErSE6IWo+hejbLTAsJB5Um/Ppi+x23ySDgJ1+ca8/4GsM
	WH7pcpCzutMXHbrDaXdaJvPUYsphCsRudCH8ePg==
X-Google-Smtp-Source: AGHT+IGrmepASh+YocMFUfgAy92GhVR+klP9wWMNEuAWzRuq4yxkKFPU9cJ/lzmrPpvIIX5JE3SRzZGJH1Ndbg/FpAQ=
X-Received: by 2002:a5d:5743:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-38061005dbcmr3261878f8f.0.1730003907260; Sat, 26 Oct 2024
 21:38:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Oct 2024 05:38:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Fabien Parent <fabien.parent@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-15-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-15-dakr@kernel.org>
Date: Sun, 27 Oct 2024 05:38:26 +0100
Message-ID: <CAPFo5VLC3QT3r2CYw8K7Nf7p7xhWJ0+PPTHYN=8a8QQeGiYfOg@mail.gmail.com>
Subject: Re: [PATCH v3 14/16] rust: of: add `of::DeviceId` abstraction
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com, 
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, robh@kernel.org, daniel.almeida@collabora.com, 
	saravanak@google.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

On Tue Oct 22, 2024 at 2:31 PM PDT, Danilo Krummrich wrote:
> +/// An open firmware device id.
> +#[derive(Clone, Copy)]
> +pub struct DeviceId(bindings::of_device_id);
...
> +// SAFETY:
> +// * `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and does not add

DeviceId is missing the `#[repr(transparent)]`.

BR,
Fabien

