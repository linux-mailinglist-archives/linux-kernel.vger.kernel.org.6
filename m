Return-Path: <linux-kernel+bounces-259757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A1939CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8412F1C21F19
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2314C5B8;
	Tue, 23 Jul 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDUYPHVI"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA38814
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723312; cv=none; b=k5fd5SJGFE0PMRwNDrg/jBk9PuCKpJ7WTY/TLsrE+eNl1FOuW/XDeHuPLJ5yxaB0uc4shTC/P8LHO+N6RH/hW4rtyVK7TheyJyzi3+xb74sYLip3zGkqpl76Ab2fxdeaxYI2EN2zVuNTo/ywTpPHIyzn+HAFD0gs1/8ApqDfNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723312; c=relaxed/simple;
	bh=87LPnRxAwq0qVgYtmAP6rfez3yLfDuM9Myiv4L8t7Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0AdUjqkOfcaprDrU2Vf5HGbjBeRt0dwhXohFie/TMdMPrqMcsmfRpYT3OBMBiyZ2vH4zJBmTeNdQkjQd16rrT3RyV/4OfTyqCkuQWS+2tV5aQ7de45Su/UtT28UdaMopePwwXUQ1WGzDajCtUMRBGZ+zXfi2cmEoJeekaKvzX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDUYPHVI; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so8398a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721723309; x=1722328109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpSaIJz7Dz5ilWwBGo8KpfrsI22OPQJ5ujE4om0cTig=;
        b=sDUYPHVILqxryRRaznHtid/ImB4UDxVLsIiHjN8R/gpI4iR3LHVY+FcB5l9/n99A9w
         3darpHdHRdiGrxtb/+2X8n/XR4dEJi3z+1O/ncDwrrlnie+JfFaIYuxe/hHy9W0K3R4k
         RA0BLvpPj7P1PCNBCzsavtt65ZCBbWi6YOY5oQNfqeSlAdHNfvFqpJM8jN1BmhiXHOuC
         ZO5tCAoXq/LYHdypZQAjfX6zWq+uaTIjxyaOt64tASfXkfBggUW1xcTiMIrg86dYVjxY
         ZsqelotyDK1N4I5u6P7dOmzG9nuz1c8s9nL5hfLCdBv7In2tjCFoEulMGHJn+x8rB9AC
         FbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721723309; x=1722328109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpSaIJz7Dz5ilWwBGo8KpfrsI22OPQJ5ujE4om0cTig=;
        b=Zg1LJlQGqYBP+SdYChTR0c9aKyk24lBp16NUtANfibO2aSLW5Tp8/87s47MeKTL0Tl
         hK/TzMn2GFaRPdJRm+/VOaidObI1FRygWeCN/ouK735no9Zu6WOZUszMEsVkku90jJ2r
         wgvY44dblybrGOK4VeklhMHXZnoRQS4UjYfU8fjgvQCNleOwlbjKYBgLC5R+Pw2nErW/
         ZlhMTY2EBIIIrw/y9innqLX/cVRkn/Nr24s7AHAt8oeVyw1N0ozIUP10JBjvKeybLZMC
         oqzLyt0zdT0JswZHmI82J24YCU9jiMhl9hiLZS5Br2kOeu+1jhUT5OSW7WP8MQmDMOkR
         SkFg==
X-Forwarded-Encrypted: i=1; AJvYcCULcRsMzcfaKxJRQv+EHVBQCVv1HO7Z2VirKeWhkRs3l6GXWjc8TncDDaQXTCk3QVKLjjtwizcsLmMApAeYr11kP/QLWLEB1/vynthL
X-Gm-Message-State: AOJu0Yy8PbEm2uyWralhtG+hTiFP4m7XvPoj1boIQRx83TK2Bpj2W5MD
	4fAn2Gdg5lsp1FtMoyucKtvERdX3PyfdGEKTQ5cWQ/fmIDQbw/un/reL2umJNdIUkLb7EaqXaic
	mNkr4H2pHooMkrNApm3PDA/achCItR/TtT/34
X-Google-Smtp-Source: AGHT+IGUsJ23axFKbLw/h6tDqgKvi522rkbCed2vAtvFeqISi98yaE8W5qB6MxniPm++JgNUlpTnM+19V3FpqmmP1to=
X-Received: by 2002:a05:6402:5254:b0:57c:b712:47b5 with SMTP id
 4fb4d7f45d1cf-5a456a63b69mr461088a12.4.1721723308479; Tue, 23 Jul 2024
 01:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718085633.1285322-1-vinschen@redhat.com>
In-Reply-To: <20240718085633.1285322-1-vinschen@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Jul 2024 10:28:17 +0200
Message-ID: <CANn89iK60X=ugZysD3Njs2FUQth0-s3anEHUv50EKzqZvDm6jw@mail.gmail.com>
Subject: Re: [PATCH net v3] igb: cope with large MAX_SKB_FRAGS.
To: Corinna Vinschen <vinschen@redhat.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 10:56=E2=80=AFAM Corinna Vinschen <vinschen@redhat.=
com> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Sabrina reports that the igb driver does not cope well with large
> MAX_SKB_FRAG values: setting MAX_SKB_FRAG to 45 causes payload
> corruption on TX.
>
> An easy reproducer is to run ssh to connect to the machine.  With
> MAX_SKB_FRAGS=3D17 it works, with MAX_SKB_FRAGS=3D45 it fails.
>
> The root cause of the issue is that the driver does not take into
> account properly the (possibly large) shared info size when selecting
> the ring layout, and will try to fit two packets inside the same 4K
> page even when the 1st fraglist will trump over the 2nd head.
>
> Address the issue forcing the driver to fit a single packet per page,
> leaving there enough room to store the (currently) largest possible
> skb_shared_info.
>
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRA=
GS")
> Reported-by: Jan Tluka <jtluka@redhat.com>
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Reported-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Sabrina Dubroca <sd@queasysnail.net>
> Tested-by: Corinna Vinschen <vinschen@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

