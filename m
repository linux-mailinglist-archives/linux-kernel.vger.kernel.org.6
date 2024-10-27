Return-Path: <linux-kernel+bounces-383463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 641279B1C27
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 05:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133081F21B27
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 04:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B43D32C85;
	Sun, 27 Oct 2024 04:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5b/ci14"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DEA18EAD
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 04:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730003553; cv=none; b=KpwvtZzUu0BkocsTzlpWBtco3lFgUAm4kMMiFgFAkyzJMSWHjMFcmixp08y5X2nPyjwnTWcjBJP4gjk0U+tO9U1w/opCQnbDRULe7vIY20uSXIEjaryXuzUgI6Xo3XkFwj5WEPcClUxl32nAXnEm9SwjEyxD9F8XIfqJa128GNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730003553; c=relaxed/simple;
	bh=p4wi45L1qPyhxsEfHjmkoXWs6wdpqZ1bepuiqIVyodM=;
	h=Mime-Version:From:References:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKzwZ0Nejj0hf46bEu+1j6fzIQC62igm0ovKqT0iIO1YMWRnVzTppUuiTN5J1IHflh95xL1s/ap4GE3T2ydhxJ/nmwlStFDBDolFp9Co7epKT22EuSIKE+rpkggxAt3qNlTxJKrBQPrv/US+udLbvBOZOGYe3veozdgTEtrNkhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5b/ci14; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d58377339so2803937f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 21:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730003549; x=1730608349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z6F23C6zLzVFlSv5RbYbUcSU4ibwu1QkqOt0SVt3Sg=;
        b=k5b/ci14d0czQp9NbdziYOMb9k6GxQtHYFUNH8WllU9/vBJs7cioI4MPjLsE/L72A2
         CVv2xIHw1QFeSs1CxEfeVpbcZpBwe5Rlc3UxR3ROb6UTtsscs1egJ1ZkK45iELfKNO6s
         SBXnUG6rHL2HfpRDHC1htwE6xVyW3Mx6GcSRhUrv7ENZo5RJHgo8LEaMbW6DLMoNmh2A
         94LGmZLiaOsPzVuCjAD3R74/cRdB93VR/8FlJUn/dxPv3Hl3w9sMa49pkml7Bc2pP74m
         nEeBQMA65XvSVKOWeiovRXqGKqvZM2Vk4HFJ3ee5WcJlDhQCkfkRpImOMRQ6a9ZSvGWB
         aVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730003549; x=1730608349;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Z6F23C6zLzVFlSv5RbYbUcSU4ibwu1QkqOt0SVt3Sg=;
        b=YZFqlfmLVvsKGyUGlpE7S3DFrvMSEVvugV6T7HuFYOdtI5fo5nYDWqvyMq71DI6f96
         LrSA5Pkvm8s2ciOLhBcGt6anvD9SS+mU8kw506eEEHAo6bN5VPToBvy00qNlc7ywl05V
         R8X1oP28QLw/EBf2ghYxUgfE+sVngbCs46k7IVGWtGMlzwFgYetXKF1J49CH820kitMx
         vPWL0SdwVqBxaDWm/MLo87wF+oRl65ZIBNtU0sMhB6ybCBBRlsrmAPZquMJltt7MuHw4
         UUAwYxb6pc6PZz34xs4QgeIgMTAnMWny/1VnVhkKz1S12uk/UwTqyh9HouqEHHgctCxF
         vZRA==
X-Forwarded-Encrypted: i=1; AJvYcCVAgPuj4lsQj037JpbJHJZ9Ra83LFidgM6IhgfFOlFMEFFwvCB1+rgYy69ibfLonohtw/xUXcML8uVmWIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdXstq7smof6EDhy2E5i71JPLTCljZThC2JKcoOGqPVrGH4foM
	k5p5YF0NMU/OGh+lLxdDmz4E3WY1fOH+RI6swYi2//ZqO2W0GgmKPU7x0k8Qdj5Sf8CkIY3QCDv
	6BjGGLh1xf7tXffT1Wu5fr3DayiqVbO4AKYog4g==
X-Google-Smtp-Source: AGHT+IHs/6OOPc8kzlDIFRVtEy44CKpqgv8xhrev2iGPdoKmfKW3kRw5e2wUK/GvsQovDmVr7YNDSSHfpBkA1nB0bx4=
X-Received: by 2002:a05:6000:c83:b0:37d:4a16:81d7 with SMTP id
 ffacd0b85a97d-380611417eamr4157255f8f.8.1730003549537; Sat, 26 Oct 2024
 21:32:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 26 Oct 2024 21:32:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Fabien Parent <fabien.parent@linaro.org>
X-Mailer: aerc 0.18.2
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-16-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-16-dakr@kernel.org>
Date: Sat, 26 Oct 2024 21:32:28 -0700
Message-ID: <CAPFo5VL_SoB0jupdn6R_2RgxLbrS26UdBTg3qJF05T70Kzsibg@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] rust: platform: add basic platform device /
 driver abstractions
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
> +/// An adapter for the registration of platform drivers.
> +pub struct Adapter<T: Driver>(T);

...

> +/// The platform driver trait.
> +///
> +/// # Example
> +///
> +///```
> +/// # use kernel::{bindings, c_str, of, platform};
> +///
> +/// struct MyDriver;
> +///
> +/// kernel::of_device_table!(
> +///     OF_TABLE,
> +///     MODULE_OF_TABLE,
> +///     <MyDriver as platform::Driver>::IdInfo,
> +///     [
> +///         (of::DeviceId::new(c_str!("redhat,my-device")), ())
> +///     ]
> +/// );
> +///
> +/// impl platform::Driver for MyDriver {
> +///     type IdInfo = ();
> +///     const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> +///
> +///     fn probe(
> +///         _pdev: &mut platform::Device,
> +///         _id_info: Option<&Self::IdInfo>,
> +///     ) -> Result<Pin<KBox<Self>>> {
> +///         Err(ENODEV)
> +///     }
> +/// }
> +///```
...
> +/// Drivers must implement this trait in order to get a platform driver registered. Please refer to
> +/// the `Adapter` documentation for an example.

The `Adapter` doesn't have any examples, but there is one right
above this paragraph. Anyway I think the example is in the right place and
should not be moved over there.

I think this paragraph should be moved above the example and the last
sentence should be deleted.

Fabien

