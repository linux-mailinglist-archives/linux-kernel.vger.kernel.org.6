Return-Path: <linux-kernel+bounces-238278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759CB9247C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 21:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC62CB24268
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD4322E;
	Tue,  2 Jul 2024 19:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aex1PcL4"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB722BCFF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946837; cv=none; b=uYtWwA/JyJ/M1kI7WgpCXE6QfMu/A5+6GR1wBAbUD/peaOS78THEBCeWq8IyxkyHMaV40V/1yC3J6W02OYjF4w5mTxz8Xyc7XqhxabXTXrmGCUFhK/fIu1tnKDXt9DTg/c79ZA7uUs0gkhqqaudmeGcPINgCVjhu5W+KDv7MirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946837; c=relaxed/simple;
	bh=TRh3kCtvO58B3TS/ro9pEJNNo6FOlD9/z7qzRrzSlqs=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSTiHTSzW7uqMI8moB9goe5Phb6V7LTIvaNfC6eC+qKwzN2rpN+HHCmZDAIGszUCfUZ4pQgTJFxo9K1AgqRdcq06FBfY9Jxf2UKlbXeOWtVij5ZcRJ0IFR9B+j5v//vTMBS0Z6dsQw+P0Mw3SiptVqLDPF8lhKKzulvlFZiQ32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Aex1PcL4; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7021702f3f1so1552121a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719946835; x=1720551635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TRh3kCtvO58B3TS/ro9pEJNNo6FOlD9/z7qzRrzSlqs=;
        b=Aex1PcL4TQzx8xBTycaadMgX5n4tITaDJ7ONqUNBdF1vjeiOMgSC7gfpdYgMNs2lpz
         sN8BIfgFJPooNk7fLnAPOogWzWhcLP/V/GdwoECSQQ1PBIpuB69W9QQKCLX8UVGKuOV/
         hoy2aSRq+4RZcb1OEn93WMKX2ZPMXrFFYB+x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946835; x=1720551635;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRh3kCtvO58B3TS/ro9pEJNNo6FOlD9/z7qzRrzSlqs=;
        b=wvHcMRXlD+vYT2BYEif5Cdy86DC7mZKGYKFx3F8ojqFNJPusJmqOw4ZDeJqDYLqsGM
         w2T28kNSGObz2qRJitfmlfHHc1p4V9WheNe65dJdVC1j4fBXQmZVb409J6AEo3hv+M8o
         L3Bz2VkEYzryGi4zyXXxK7c9R3A4Mwn+w9hH2qcdfAF0Hp+YuamcY9xz51ZQubLfizV7
         k/K5cJ0fOvrH9uoWFNG3xSYhNQbdBkqa65XGERZumETOS/9xQInI4YT+2Lw80JmTi5iJ
         VSBDdNQXnW+8BjFHqSBkc4Sm7TSufjX6rwmZ5rk8A1OcYJf6QrmBKvigcwYXczThkmBW
         la1A==
X-Forwarded-Encrypted: i=1; AJvYcCUpkc8G4rNzliHDpFKkZ+vhPCa3OIm0V2dy+eBlfjbgJUw8uw6vc4B+YQhEbVYyoKFZwj5MyjgmpogmNYBkB4obp/iKItO6TDiF8xdH
X-Gm-Message-State: AOJu0YxkHMUFfq7K+lKLUBb+fflZp4pnKG343Jmyw0Id5+6yHj9CDosw
	fol05fyubv129DaTWx7yje9TMd/wfM8uH85+I99/zkNY9qFdaXjn8BP6tP+sakw3eYAPhgmeK3M
	u8G4ySD+e3mTgcXuWsdhgm9rTzMkVXSAHq2bD
X-Google-Smtp-Source: AGHT+IEuctwteLzkcWtPEA88NJi6Q3ar2tx3qa3jOR7L3cOw0C0DH0EuKI1yUKU29vx9JV4sFz9I67UQX3NV/JxAMfc=
X-Received: by 2002:a9d:6c56:0:b0:702:526:284e with SMTP id
 46e09a7af769-702076f2ed8mr10449874a34.33.1719946835587; Tue, 02 Jul 2024
 12:00:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Jul 2024 12:00:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624-usb_core_of_memleak-v1-1-af6821c1a584@gmail.com>
References: <20240624-usb_core_of_memleak-v1-1-af6821c1a584@gmail.com>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 2 Jul 2024 12:00:34 -0700
Message-ID: <CAE-0n51SfZiQ_XnPXYrG4Fyu=H8xDc0zpJ_Hxa+MrFq8V8PXTQ@mail.gmail.com>
Subject: Re: [PATCH] usb: core: add missing of_node_put() in usb_of_has_devices_or_graph
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Javier Carrasco (2024-06-24 14:10:06)
> The for_each_child_of_node() macro requires an explicit call to
> of_node_put() on early exits to decrement the child refcount and avoid a
> memory leak.
> The child node is not required outsie the loop, and the resource must be
> released before the function returns.
>
> Add the missing of_node_put().
>
> Cc: stable@vger.kernel.org
> Fixes: 82e82130a78b ("usb: core: Set connect_type of ports based on DT node")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

