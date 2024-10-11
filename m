Return-Path: <linux-kernel+bounces-361691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CEA99AB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6299B284CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED131D0150;
	Fri, 11 Oct 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P1Mu2dVS"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF91C9B87
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672556; cv=none; b=VGqSVAxPRR5x5R1mgmkcQA63I/ZM5HZPRROLzHjhYHOz4giHrcshQTWZ3X8eJG83Ip3Hjvsan90CMGb03twsHnXPFGQAAZw8mDJXVKliW7eYF+Yje9q86lhSR1koMsHGSO3O/RQgs/irDQ44OBPnGqPYAEkyHeWf/bdFQnxWtA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672556; c=relaxed/simple;
	bh=mGGtmXOkiL+NaXSLGTVrliW9Y4OXTHK6Zp3M2UoVbDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ge7tlqm8MwzkSNvaHWCdVzfS3tQLhSQO5qVeA9x9Z+kj1pENHpHaQ2EP0GfMt/8o/QaxGGKPmWML8KWPlydbiLVhi4QdwUG1JKgeSaeqb3a9F5cnDb/i3pKquIKJcSi2PNaKSuo8FNpbtSy3bMS3GFfKBLarGYNe0VSiFGmjveU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P1Mu2dVS; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so2784891a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728672553; x=1729277353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGGtmXOkiL+NaXSLGTVrliW9Y4OXTHK6Zp3M2UoVbDY=;
        b=P1Mu2dVSzaPZswsJ0+IxBNCK3oVF3cUVQx2CKUzD56o2Av/5cafAZn8WY4CUC1/5mS
         pNxHP/WrMhdfYTyao2pWG92avWxiWi85ZtXd986wgIxGCa0ht3IF6/2oA8c7vY54Xp5g
         XDUgvJGZ49YNCGyr8pc5NQHRw+1v6QCZbkUz0+VjPD1Vn3zjtGgZUbAuPnfuLX03NljW
         oyqj+6SfwO6rpbPdCxQU+2oc1Dg/WEuIszRGhYFI+pRyLi0zQwjVEP1iBj1zymvtWnWA
         5ZCbzhjO9tglWaU9bw3QKdBF1iVw8A06QWBw1R/iUFWpMr+vVW9MoGiZxGRu03nsAas3
         4McA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672553; x=1729277353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGGtmXOkiL+NaXSLGTVrliW9Y4OXTHK6Zp3M2UoVbDY=;
        b=RMk6YgbAezZ0CmVjmRRF3sKC7DH2Drrc9Z103VFsUGp1JNIwsvnWtLOvlUfqFMoeiE
         5LzMi4tu+gtWnBi6ohzj9/rZwxnRmj16rOCfqOSJ8EHQ/OemwfJULWjlM4TFSPz57U1m
         8oxn3Eg5KM4DcpGfAX1UScV4a0Zq3UL7Bfabd4ygSWbBtcim2aiuwZ/UlVuvJfH7wkWg
         mXD8zVwzIilwF9ETFXw15+M3C7lPmrdXOo+Q11V2EuxPh5f1QRRlP15ABMLSBcQCChw4
         uzusrYdzmBFR9RvItzusz/9hA81Tc2lSfx9Ue+Q635sucBU30rJR6JrXrIANwPWe3nnJ
         r+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZNzD0ef+v+JIPmOGzWwVDO1emGy8SKLTniIsALbrGFPEWWumkjtD/CGUAujB6NpmeKPfE52XptTXBVlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEL8HWUUwHjmHvpwPl4RLMg+S0vfYZDYnFD+0HOLVHsyBmKl5
	RpM/Ck2IqTJK3Yy79XnFCoCg9Lqj7pbru/le/c3jD9fLmqjhaMQsCmT/vEYYJJC74uy0Y98IxnU
	vkqAolMiVxzyU+00yz2ecIYYMqa48UpaZoecF
X-Google-Smtp-Source: AGHT+IFdOExi8Gh2dAs70FPXckILto1QCGfCelh7xShxCeFOgdGoVjbiGquJFr6yyliTvxCD6Id/DS/KMK4tTK7Of6Y=
X-Received: by 2002:a05:6402:42d4:b0:5c5:c4b9:e68f with SMTP id
 4fb4d7f45d1cf-5c948c8832bmr3152234a12.5.1728672553112; Fri, 11 Oct 2024
 11:49:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011184527.16393-1-jdamato@fastly.com> <20241011184527.16393-6-jdamato@fastly.com>
In-Reply-To: <20241011184527.16393-6-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 20:49:01 +0200
Message-ID: <CANn89iJvzWA7W-Sa1j0nGz2LCPbu1tdLs9uwL2xCT=EZ3rUtrg@mail.gmail.com>
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:46=E2=80=AFPM Joe Damato <jdamato@fastly.com> wro=
te:
>
> Add a persistent NAPI config area for NAPI configuration to the core.
> Drivers opt-in to setting the persistent config for a NAPI by passing an
> index when calling netif_napi_add_config.
>
> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> (after the NAPIs are deleted).
>
> Drivers which call netif_napi_add_config will have persistent per-NAPI
> settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
>
> Per-NAPI settings are saved in napi_disable and restored in napi_enable.
>
> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

