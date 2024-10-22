Return-Path: <linux-kernel+bounces-376768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2586D9AB5AE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2C01F23A24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9441C9B6D;
	Tue, 22 Oct 2024 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sakK2pBZ"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C8F13B58A
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729620111; cv=none; b=L5zNzB+JWFGBXpteGm+Y5dj4YXWlvq+bOIax2DBevpfMsQ5Rit85KgmWEFXWGlSmFC0+jKeobyVw0VVBOIByygIspd0znDmh58ZP/d06RSMrWRtAvDwun6Uk/7M1ASlhOVo3TFvQlnvUhzQDSS9CCjqv1kZOiDSGS5Zgcp03Fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729620111; c=relaxed/simple;
	bh=qj9s+TlyoF6/4XQ4apP3gcn/QrBCT2Bd9VpWWkqqhTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7PnuGvW4o4AYbp1W7wFQILKd+TY8sJe8UY16TBRW38aFWRUPLDDIXDNQtHR+PuVwKX0lN3O3SvGpQjsr9s74afcGkrbreneKg1CJFgDnDZTK9+qufrKg+6dN9Tsy9yvukVZx2kSaMBVxYyjAmcUtHqeqnfEYkIeBRLu3pn22Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sakK2pBZ; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83aad99d6bfso228049139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729620109; x=1730224909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6KwyxFHJObIfxtBe72RIvOFef4RBsdXTROVtbhwV4DE=;
        b=sakK2pBZUJtPNKMVrzfUKSBrM7GNEnNw1rEGjJ7uCUFl2Eb4lJghrH6dtsVRscm0ZY
         5cgXDOh+R5vhyFpGZXC4LmrHCpebEYG8bDyniqziHe6l3OxPZdkPUQKBA7vPP0M0izIm
         m53RKZe7jA7MhdUE/y34XGxbjZz7mQoaZgcn9HjjOHkg3ww19I6ezznDJG/51vRc8OtJ
         hBgCksbWjiK3uIbq6H6I82FZ8Km8hUsnqxovU6+TCqVOuyfGf0We8D+79IVp+5CqNhUp
         V/PoBhjzNIT7YDDXGClgz6cEUTeT6qKGhFki6j3xz3uTYL0MacAD8L4ICOcYmwEney/w
         v/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620109; x=1730224909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KwyxFHJObIfxtBe72RIvOFef4RBsdXTROVtbhwV4DE=;
        b=B1G3psynrJR5M8qGXsQuM81y4g3hhLNpmYgFAal6R+s8Fg8DDzkZBEqV7CTUqAvNeX
         W+bZhw6E0pdnLTDBn1QqbDFFoD+VIJpqOGUpPoaavmpzhpjTrzVM+FJcs698IlP38o6D
         Ju6cjS6SG5iY6dwnLWDMBpqKjg40Ygb15dOelKrByoPpS6+Sdt/mL3EZfn0HFVhZgXla
         sBthzLPVvPVs9rdnAgD1XYW7oL5Er6f3brTO6IQcWABOgesTiGEd3/7/2ZXd/kutF9Nz
         qfHidrLvOu7OIRIjC1qPofL+MU67wBTQB91BsxFbR0BT+aTzgnuJQNNwiI+iMDz17cCU
         vZng==
X-Forwarded-Encrypted: i=1; AJvYcCWVA/GcNc0SPxoftyCGmJDAH2RyX2RoH6MMaJLNf0rly7BOV46CJolJSLY3apFhBroY59LTJbbFErsp+sE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVsEik52L7YBN34S8BVcPAM5dptq3i8YqljR3IjQqF9dIYcE83
	YN5iiW7qhFi/GoUaNqH5ba1xBHAz5phQK7jNmAtZf1YTbgS/AxaMPdloARF8dvoGOBPUAlB6EY6
	C1Z0dF1ILZpVGq4p355eT5iJ+y/HpPKJWbAOc
X-Google-Smtp-Source: AGHT+IG05Vqilw7VV5OMEzSH5hQ98MAtYxfN8wwemNCj9NsIDc6fbdCakSTnhWuaA76hbHaURK6y5VlAtgr3DQN6miI=
X-Received: by 2002:a05:6e02:19ca:b0:3a2:f7b1:2f89 with SMTP id
 e9e14a558f8ab-3a4cd7eb5b3mr38603175ab.18.1729620109425; Tue, 22 Oct 2024
 11:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <GVAP278MB0662D8077733604B9B103187974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
In-Reply-To: <GVAP278MB0662D8077733604B9B103187974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
From: RD Babiera <rdbabiera@google.com>
Date: Tue, 22 Oct 2024 11:01:38 -0700
Message-ID: <CALzBnUHxA8MTHyuWhOOF8GOoohsSz9KN54Aw=CiiJiu9Jz_Bew@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpci: Add FAULT_ALERT handling
To: Yanik Fuchs <Yanik.fuchs@mbv.ch>
Cc: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>, 
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Yanik,

> +   /*
> +   * some chips asert fault alert, even if it is masked.
> +   * The FAULT_STATUS is read and
> +   */
> +   if (status & TCPC_ALERT_FAULT)
> +       regmap_read(tcpci->regmap, TCPC_FAULT_STATUS, &raw);
> +       regmap_write(tcpci->regmap, TCPC_FAULT_STATUS, raw);

Would it make sense to register TCPC_ALERT_FAULT to the alert mask as well?
If TCPC_ALERT_FAULT would be the only alert to trigger an IRQ, will tcpci_irq
still run if it is masked? i.e., can this patch only read/clear the
fault status because
it piggybacks off of another alert?

Best,
RD

