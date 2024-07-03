Return-Path: <linux-kernel+bounces-238618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B391C924CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ADA1C2224E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD41FAA;
	Wed,  3 Jul 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep8+u2kW"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802F39B;
	Wed,  3 Jul 2024 00:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719967996; cv=none; b=btX/91yEzg57e/CS7Mla4z0czezFjxHxDDPIgy5qUc19ZPPGSMtfX0BztY12hRNLaUfgU+yEuLq5UIZQTq7gdTzcP92nK8DxtL1KiD120y/VUk8m4XtTtU1DFIlCZxAZCQZKCS5EloT9+VKFz3mJacse9RefMX6sxoQ4Ipee0To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719967996; c=relaxed/simple;
	bh=aBf6kYW43wmtYKnp4/vtMVB2VMSMGvp39uDJh4OR09A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q972NSyCrRYPk1UDdsGivc2xqfl9zTnO9+9pLrWUW6hSZ65qranlyQhEzrEm/Jm1Ud1t3kFvz6Rt9FkZe0fgcRLE01uCtpRSd6sfXJ0hrfwHPOwW/tV2Nxy66giOslI1bCVQ4krDPFNUm7Ip8ee/SBXBodXLOr6exooQ3XOTdyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep8+u2kW; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79d5e61704eso293003185a.3;
        Tue, 02 Jul 2024 17:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719967994; x=1720572794; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBf6kYW43wmtYKnp4/vtMVB2VMSMGvp39uDJh4OR09A=;
        b=ep8+u2kWzNLhzc5fmCC3Q/ItRmIuZ72k9aCFs3e/um1sOHk8NCrVzETvWaIXMCBoo9
         LAQvNYVz4s4m64osgn8q1DKvRnnvAtee+GEO3vH6uHtlR1qchNP/JAZXZ/XBw5wzqhpt
         plJ7nbsGuSUa99tG698bVkqcQbIAYp82P4ML+1hMdc9772yj6rHLLDxgU1EDBJERNkKF
         t07Cb3MiSR17aCTpSDMPkwM00s2ILVLVHZgaSDZc7UTglWkdKfVfnB/ngyWf1qwsf+M3
         WDwCUeIv2P7bMg5ac6zxJEb+pETUk2/z9CARrqZtwZQy3v7FIxdbjlljRLgFRZfdut67
         ykFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719967994; x=1720572794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBf6kYW43wmtYKnp4/vtMVB2VMSMGvp39uDJh4OR09A=;
        b=b+KEVQOhJPVXtB6FyQURVB/dC88GpkWhohivfgja0zpmpEBDbFSavwPc0gaNo6UxSm
         tQoWOlve3mupEtLyZadQVKFAzjX0gdbhJ3KgDDla5OHIJvUjYqpOpgLauSnmRrGP2ILu
         SDcGAeZGcN0qNEOU7ZVdc3zv6BKCNfJhpdHIROv6EhTW+Lj/fRHDMneg0UqvQXKQE03t
         j/nCNIllu//GX0XtxFyzFsk+zva6vsSFPJtjqapU37tpdGJlhEG3Wbp2/qLtLNyddZ/E
         Rqv1m5BfvGuD2k8VbMsYCdRO3gdoOMZn0UrcHpIoRVQkUl/BsrGbG96xi/LT/PTZ1ywC
         aAFg==
X-Forwarded-Encrypted: i=1; AJvYcCVNuylQIAaiF5YYYcnSAkLX81grac923Yh79T4qMMcoh5jbfGg2d0d/s67IZemdaly5HqCaC0Wj1BU1NJ+9LE0wawdxc4ecrkuwwV5dZiSUalamNQh2yqUbmGkKfDEYUi0xObj7hX1/Sg==
X-Gm-Message-State: AOJu0YyK++wu7XBJr4SY/68ptGnJ/pMXWyD9MWdOAJ07bo6MA3CmcsLL
	sQMqq50AiK2PumRmNX2j/DAtv176wyKnpYjk4emZLA33rzclpchgQzG6qqVXRBqwNiL1Fw5IVWP
	+3AVGdj1aAqbiqbVrgz57GqiRtW4=
X-Google-Smtp-Source: AGHT+IGKB0TLT+t0w5QSBMZabpd2h/895P0ReYUirZgWMt68DyeN1EUL3/SR4Kp8gQ6Dq2SCe4lpf6y5S8nghoDBQrk=
X-Received: by 2002:a05:620a:468c:b0:79e:e3b0:436d with SMTP id
 af79cd13be357-79ee3b04ad2mr6046185a.52.1719967993653; Tue, 02 Jul 2024
 17:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702164403.29067-1-afd@ti.com>
In-Reply-To: <20240702164403.29067-1-afd@ti.com>
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 2 Jul 2024 19:52:47 -0500
Message-ID: <CAOCHtYhX8if3c8=qOz+qx=ss+Yya9Ta5xFbW+NmG-tOQco2s-g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/3] Add generic Overlay for Grove Sunlight Sensor
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vaishnav M A <vaishnav@beagleboard.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Michael Walle <mwalle@kernel.org>, 
	Jason Kridner <jkridner@beagleboard.org>, Ayush Singh <ayush@beagleboard.org>, 
	Ayush Singh <ayushdevel1325@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:44=E2=80=AFAM Andrew Davis <afd@ti.com> wrote:
>
> Hello all,
>
> A new attempt at solving the long standing "add-on board" problem was
> recently posted[0]. The current out-of-tree solutions usually involve
> Device Tree Overlays. Recently, Overlays have started being accepted into
> the kernel repo, this makes now the perfect time to solve this issue.
> Here is my attempt at a generic solution.

Thanks Andrew for taking some time to look into this. I really like
the individual modules and how you can connect each overlay for
multiple combinations.

I will play with/commit this in our current 6.6.x branches.

Regards,

--=20
Robert Nelson
https://rcn-ee.com/

