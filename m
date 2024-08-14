Return-Path: <linux-kernel+bounces-286070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B2C951628
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F110F1F23A45
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F9014036E;
	Wed, 14 Aug 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n5VMP++4"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A413D28A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622837; cv=none; b=oOCUzb+Fwr7HfYboIOhIRmRlBO+lewBfH7vaivCpdAhjULU/GcCIVO+lBLQWpG/Qg6EiA9V4CJtPC+ld2PG3gpeQw1ygmHcJrnimBzDFMmFyvxq6RA457rgU1VnbJ+6YIobpXzOlfOXohtj9mA3V9ovULihnwaD0FyAFx3xSZTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622837; c=relaxed/simple;
	bh=zl6oZ0yQ2AuljC/+g5tdcuw5JSm8FT8fOqYmulxxhYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MyLzfE0jpmFsC3jpTcKNHtdxwBDL3+GU5sPJaxGTl8FKtktZTXksugH5mfJdsnhB7ky2coz/1w0TjXHqsmxHTRqt4fpKm6qfCWALFxj8urwYzAMoVlXMIiIHDK6MQYTs7lUNOB8/HsJ5IWkDw1kCjaInPq5dN9T0+12QmAH8lV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=n5VMP++4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so74130341fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723622833; x=1724227633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZJa2A/wBP2dRUmaz/amMD5VJoMLHB0MhQTzcG7HnQo=;
        b=n5VMP++4UMaYIBc/laDUSYRXlDlBaHzdShPyB+CkWSVGZ25N6lT0g6y9TQOCziDvW+
         BSUQOSGOn7QTe2CN/1fuO/YabjmTxPaevMLcs/9f2fMA9mhVo7FVh51VM2Kd8/Pu5CC6
         KbHokZyPkJJ+ypHweZKXrBKZOPVlaqh/ttcmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622833; x=1724227633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZJa2A/wBP2dRUmaz/amMD5VJoMLHB0MhQTzcG7HnQo=;
        b=Nu3VRPp1MyobEE6RAb/7sz9Kl1YKWL157C7PZmYD2BYXgIbjU3QosjvoFNArsfnzDm
         mOOmPtt9KVpHof035VzLiacn/3f7otb87pahdmGcUity1aDOQgDjSh1z/RbDS1GPEJsG
         wpikBKen76aizD5JrBa7DLjsk6wsnIQt04iFIEkGkCaZNHxJgMihhynZnIYGltTtuH4+
         dJl1JovUOD7B0v/n/0t6V8LObijGk4YYOxlJG75KjiPn4ZO8v5tJs8Dsuzrnkf717yFm
         2sTfXTt5z8+ONMgHpdQE/uLQhF1csHSNTJsbkBLZjd2CICqeXeRHj4VGb2RzrmRz93se
         5r/w==
X-Forwarded-Encrypted: i=1; AJvYcCUej19ZbqAJTitTftLQBNS8WAcZmOTYOAKGw1j/IYkVnJd8q0CrdD9xIcttdSGo6dMwkhzO/bBMmOORFbUiuPya1SKPmBx0strNCtY+
X-Gm-Message-State: AOJu0Yx+KauaovJCXsKN5biPjMbfuTbv1NAZ7RDkEajfpQjpv+06F2vq
	RhNroOfx3DkGdVUQ3uEuo1Hy+vGLoVwdXOnIQwt0eJ2cde8Qrq9SL3OGF/LgbSVSsuMM8DdKyrM
	X/WEb
X-Google-Smtp-Source: AGHT+IFUUcd1JNudJMWGsdeYtJHhChAYujgEfviU9+X5SUYmfjiYbyYXRIDdCTQcdnxrjcncp14GxQ==
X-Received: by 2002:a2e:8ecc:0:b0:2f0:2e18:e7d0 with SMTP id 38308e7fff4ca-2f3aa1d4474mr11422861fa.28.1723622832463;
        Wed, 14 Aug 2024 01:07:12 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f29206895dsm13122821fa.132.2024.08.14.01.07.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 01:07:12 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f1798eaee6so59894711fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 01:07:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUS3a6lq+aMsf9pzuL5NIpSQJwDVXHY5u+ZbYwUPRmiT/vt5tyCmWMfdtgc5Hfa2H5EsLxhPBPzaDr6u17lHEYJILYhHRw/9fO3/QXJ
X-Received: by 2002:a2e:9898:0:b0:2f2:b2f7:c8a3 with SMTP id
 38308e7fff4ca-2f3aa1fe717mr11203131fa.44.1723622831290; Wed, 14 Aug 2024
 01:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813-cocci-flexarray-v6-0-de903fd8d988@chromium.org>
 <20240813-cocci-flexarray-v6-10-de903fd8d988@chromium.org> <20240814044138.GA8686@google.com>
In-Reply-To: <20240814044138.GA8686@google.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 14 Aug 2024 10:06:58 +0200
X-Gmail-Original-Message-ID: <CANiDSCt2qEtA8_PFtCLz9uSsY2TWSa5W2tOZVt=TrdE7A2Z8Tg@mail.gmail.com>
Message-ID: <CANiDSCt2qEtA8_PFtCLz9uSsY2TWSa5W2tOZVt=TrdE7A2Z8Tg@mail.gmail.com>
Subject: Re: [PATCH v6 10/10] media: venus: Convert one-element-arrays to flex-arrays
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 06:41, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/08/13 12:31), Ricardo Ribalda wrote:
> >
> > This structures are not used
> >
>
> Why not just delete them?

Byran preferred to keep them for documentation purposes
https://lore.kernel.org/linux-media/0640d530-404d-40cf-9737-0d7468dd0177@linaro.org/T/#u

I am fine with both options.


-- 
Ricardo Ribalda

