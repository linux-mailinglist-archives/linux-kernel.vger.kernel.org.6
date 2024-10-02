Return-Path: <linux-kernel+bounces-347244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525998CFF3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B0F1F229B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D38195B1A;
	Wed,  2 Oct 2024 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QogGA6z5"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705B1946A4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727860838; cv=none; b=ZRQdns9arrjJk5R3ZsYeCzvWG3ta+S4TftoiTOgvVhx8iG7MVFcE+FtH/5MCCXhd7el9UqrzolnoE8Sd2t44STzDAfFlgcRGjHBv3ZVAQZIXUHkNDz/CmvQkxDRlnp5DCvg+91V44JQ7wKBBUnnnmgIRuaXTudU37XkcQ44Z3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727860838; c=relaxed/simple;
	bh=mzDHbmnmSbZgPh/ZeldgAOMha3PtMlQ6ANgxAOBY+Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHosBGi0OFmdCWMLNzuAautr4EtLFcR63LnB/ncB68vTzaOx7Ukx8XCX0CTt4OSScqSw+Ov7rkR8ktn6UoPyqqaRfoLplx10gWdA/p1dL7uVkNLEn04RmYr/TWgmS33mrpj24HbZNKDSCLVFGXKRsT+hF7Hl45cWY4MMYi678Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=QogGA6z5; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5398e58ceebso599963e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1727860835; x=1728465635; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZO0Y8/ubh1XnuZPCq0ksaN5wnj9mPknfJDM/0u+lyg=;
        b=QogGA6z5eZVmTANsamaQycj17E5dDAmzrgR5aS6Kh4VQ5qH5zJu85Gb1n+oG1R9AdY
         gUiF9TQ0oudqONW3Wsz3a5wzIuekzBQ1FFmLB+IIbB2Gy75b/0PlVcnOsKgzAB4uIACp
         /8t61Cbl4CgKgBh9+Y9IX45DcjEJRlDc+Ksik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727860835; x=1728465635;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZO0Y8/ubh1XnuZPCq0ksaN5wnj9mPknfJDM/0u+lyg=;
        b=IWPEkFfWKKzJoiH9SLafP2wjtilO2SO7+RTKkHPFJ5B/f5tZNSIHp+KqzXhKGqP1Xf
         2qC4qA0yvwVy1zUgqJNISs3B6aetUfdnWYV1KVQHSg7pYHWPX84AZimDZphAqMTa8JvY
         E28SzbAWvCXrUCnsTUhWzdl61yS2Dew1bmKw344eLHFGALeq8hByGY6JpUKBkCwxjvRh
         cljgoLHIq4eC6oBRirrUBcZxzoZAmbmrpO7Csc6OrRjSlwJbuPxzugIxsX4Q7PtXy79F
         pHBGq+G4O8QbBIHUyFaLZFdQ0jZdcXVYmh+nzaI5UWKbT1lKGs8uDnEHcQRxdXiJzl4Y
         rxcw==
X-Forwarded-Encrypted: i=1; AJvYcCXdOJhev57HyOpkyU2ne5367fGCFmctGCSHP/VlEGxGc3dIKs4DMcYKNmLCKNUb+J2yHzwqQm0t6WunumA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjynO3wAn4o0MG5zLAL1DD3UkAzAup0Aflr64+76yObOKv1OM2
	cLQLeN+SdYsWWL9MxIHeW1nfu5JjPkKNWYzuwpHaWK65QUNAA/BApYmYx/WnTRyJLWJDAq07Vy1
	ytE5Blw==
X-Google-Smtp-Source: AGHT+IGtXJvrufAFjd2v/2BhFG3gRzFXYZPIU0TWOYK8Da9d0sVChTE0gL9gdkfIYnsbyV2u2l+F+A==
X-Received: by 2002:a05:6512:12ca:b0:539:950b:139c with SMTP id 2adb3069b0e04-5399a24664bmr2042373e87.12.1727860835200;
        Wed, 02 Oct 2024 02:20:35 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043220csm1817735e87.156.2024.10.02.02.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:20:34 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,  Jens Axboe <axboe@kernel.dk>,
  Jonathan Corbet <corbet@lwn.net>,  Ulf Hansson <ulf.hansson@linaro.org>,
  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>,  Kees Cook <kees@kernel.org>,  Daniel
 Golle <daniel@makrotopia.org>,  INAGAKI Hiroshi
 <musashino.open@gmail.com>,  Christian Brauner <brauner@kernel.org>,  Al
 Viro <viro@zeniv.linux.org.uk>,  Li Lingfeng <lilingfeng3@huawei.com>,
  Ming Lei <ming.lei@redhat.com>,  Christian Heusel <christian@heusel.eu>,
  linux-block@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mmc@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-hardening@vger.kernel.org,  Miquel
 Raynal <miquel.raynal@bootlin.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  upstream@airoha.com
Subject: Re: [PATCH v4 0/5] block: partition table OF support
In-Reply-To: <ZvqfbNDfI2QWZEBg@smile.fi.intel.com> (Andy Shevchenko's message
	of "Mon, 30 Sep 2024 15:54:04 +0300")
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
	<ZvqfbNDfI2QWZEBg@smile.fi.intel.com>
Date: Wed, 02 Oct 2024 11:20:37 +0200
Message-ID: <87setej1y2.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andy Shevchenko <andy@kernel.org> writes:

> On Mon, Sep 30, 2024 at 01:30:07PM +0200, Christian Marangi wrote:
>> Hi,
>> this is an initial proposal to complete support for manually defining
>> partition table.
>> 
>> 
>> Some block device also implement boot1 and boot2 additional disk. Similar
>> to the cmdline parser, these disk can have OF support using the
>> "partitions-boot0" and "partitions-boot1" additional node.
>> 
>> It's also completed support for declaring partition as read-only as this
>> feature was introduced but never finished in the cmdline parser.
>
>
> I'm not sure I fully understood the problem you are trying to solve.
> I have a device at hand that uses eMMC (and was produced almost ten years ago).
> This device has a regular GPT on eMMC and no kernel needs to be patched for that.
> So, why is it a problem for the mentioned OEMs to use standard GPT approach?

For the user area (main block device), yes, a GPT can often be used, but
not always. For the boot partitions, the particular SOC/cpu/bootrom may
make it impossible to use a standard partition table, because the
bootrom expects to find a bootloader at offset 0 on the active boot
partition. In such a case, there's no way you can write a regular MBR or
GPT, but it is nevertheless nice to have a machine-readable definition
of which data goes where in the boot partitions. With these patches, one
can do

  partitions-boot0 {
    partition@0 {
      label = "bootloader";
      reg = <0 0x...>; // 2 MB
    }
    partition@... {
      label = "device-data";
      reg = <...> // 4 MB
    }
  }

and describe that layout.

Rasmus

