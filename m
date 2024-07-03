Return-Path: <linux-kernel+bounces-239861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEF092662E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B67282F50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6AB18308F;
	Wed,  3 Jul 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bs+wDda4"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5E5181CF8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024321; cv=none; b=RUtr5UK3tnLntXxZQLjT6D4BT2RvvuxwyM7ry6K3Eu4wILd2by+5FmxC5VQ1BZSDS3adxyCx90ECzyGhk0JWKhRiy1wbqJ00UUfTfkCrhxdscisa93Z1NUAh2tGkMXh1+YAk4FbXDxI8rIilJAhjP67te0uxK8YB9ps5mCmt4Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024321; c=relaxed/simple;
	bh=aX/dntK47yBZoBKXBogHtsXyVUj/EEsdEqcWuVR2MNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H9RaOecy94uXdyKZAyLcnlznH5bw7m25XICLWq7SGUtgxToLV7OVHASUpKDcAsB/de1mYk9xNX/4nWwck3T7IrD6cheWzZRm5Uo67Cst3KB299eX7rgfEjxYEvLvFhnGCSVvJzXdv5h4Dgj1RzixdZTTv+Uft7/AZlx11kgOU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bs+wDda4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a724b4f1218so626330366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720024318; x=1720629118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iyado1sFM+cGedSAqHu7B/wZSU2t+kg2eHyPGnCfXa8=;
        b=bs+wDda48syzyChkks6dx2nG/8wmx1+r30qz4JTQM6yEum559qqWXCpo32lGEL2KmU
         bRcA9Ds1Arxl7QZTpO58M43tshRVek2Mb6WOCrQ1x0CPXxIQ3dnAnAXaXmgP27pz906J
         kIeOsJ3DcXx9JrP54t7do7syEgvA+2ydh4QfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720024318; x=1720629118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iyado1sFM+cGedSAqHu7B/wZSU2t+kg2eHyPGnCfXa8=;
        b=BxAaeJ9+vFiS7N2GQbiAFxDbzyn7cwI0tpAzJmel2/3GlzT6bMYS0hK0T7/tMUSDGD
         2LyhchwbXsl+LFH3Zamk28mLMOC2s5OCtIv8G7Mt9c0XmuraGsHT5qFyoKs93BybNbwA
         Zmm/WJ64VSeAinJ9VH1SP+y/B6F3o2m/RlOvFfhkoJrapIp4CRD62e3KSysDNereXqUu
         B/o0ObwVv9LPT8LHykbNLWER1tax/VCLI+u3J2wkz7/q5E9Wtv4yMxZctajyrGFVS+1c
         lzNV1DWlJmP6ENBljjZV4Wz93kU3grHd3Rl5geDcdZIRJOfQ3l78dw+MvrlgGO2FrgAJ
         NcxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVabFJ6pJGcIcFnD2T+YPR1taESt7sPa/vyj+njdv3/jXSDoKfRUukfK++14GcpSP+EoxtDFxjH1FIYAZPPMXPuTcHa/9rsXy+ejQ6F
X-Gm-Message-State: AOJu0Yxyu+H47DgA96hPOb4xpiatNxEaANXEo2ERY3vQnwLKVR58jFqD
	RMUX3czSPTQJDfOKUOYACXl3J8Uoz+LapwZuq7iilOIMzdPZkjNZHNfTcIUnPnt0+ncPR7mwjmR
	YHK9LAg==
X-Google-Smtp-Source: AGHT+IGDeLAtbCD0vQ6Q1yrXbUiYvKXagWypd6C5c4GuM6pNjxNyy338RQaz+Nl0yJJ6GIVbDpAogA==
X-Received: by 2002:a17:907:9620:b0:a72:88e2:c30f with SMTP id a640c23a62f3a-a751447b26cmr944519466b.48.1720024317937;
        Wed, 03 Jul 2024 09:31:57 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf18493sm520452766b.7.2024.07.03.09.31.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 09:31:56 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a724b4f1218so626326466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 09:31:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHVWt5Lw8CqY/mLnYKDKggzIt82+A8ynqD/sxH0iIsOFde0yyzz4lmxqXeXLro82VosWNFh5p5fx7mahtypnXIRISXEDd6bg8WTaOq
X-Received: by 2002:a17:907:368a:b0:a75:3f38:e0a4 with SMTP id
 a640c23a62f3a-a753f38e1a0mr459327066b.47.1720024316186; Wed, 03 Jul 2024
 09:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625110029.606032-1-mjguzik@gmail.com> <20240625110029.606032-3-mjguzik@gmail.com>
 <CAAhV-H47NiQ2c+7NynVxduJK-yGkgoEnXuXGQvGFG59XOBAqeg@mail.gmail.com>
 <e8db013bf06d2170dc48a8252c7049c6d1ee277a.camel@xry111.site>
 <CAAhV-H7iKyQBvV+J9T1ekxh9OF8h=F9zp_QMyuhFBrFXGHHmTg@mail.gmail.com>
 <30907b42d5eee6d71f40b9fc3d32ae31406fe899.camel@xry111.site>
 <1b5d0840-766b-4c3b-8579-3c2c892c4d74@app.fastmail.com> <CAAhV-H4Z_BCWRJoCOh4Cei3eFCn_wvFWxA7AzWfNxYtNqUwBPA@mail.gmail.com>
 <8f2d356d-9cd6-4b06-8e20-941e187cab43@app.fastmail.com> <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
In-Reply-To: <20240703-bergwacht-sitzung-ef4f2e63cd70@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jul 2024 09:31:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
Message-ID: <CAHk-=wi0ejJ=PCZfCmMKvsFmzvVzAYYt1K9vtwke4=arfHiAdg@mail.gmail.com>
Subject: Re: [PATCH 2/2] vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)
To: Christian Brauner <brauner@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 01:46, Christian Brauner <brauner@kernel.org> wrote:
>
> We've now added AT_EMPTY_PATH support with NULL names because we want to
> allow that generically. But I clearly remember that this was requested
> to make statx() work with these sandboxes. So the kernel has done its
> part. Now it's for the sandbox to allow statx() with NULL paths and
> AT_EMPTY_PATH but certainly not for the kernel to start reenabling old
> system calls.

Those old system calls are still used.

Just enable them.

statx isn't the promised land. Existing applications matter. And there
is absolutely nothing wrong with plain old 'stat' (well, we call it
"newstat" in the kernel for historical reasons) on 64-bit
architectures.

Honestly, 'statx' is disgusting. I don't understand why anybody pushes
that thing that nobody actually uses or cares about.

                Linus

