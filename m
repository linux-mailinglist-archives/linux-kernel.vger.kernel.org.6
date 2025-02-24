Return-Path: <linux-kernel+bounces-528007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3EBA4126C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 01:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E468216DF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 00:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C294A33;
	Mon, 24 Feb 2025 00:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqgJGbZh"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BB6802;
	Mon, 24 Feb 2025 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740355374; cv=none; b=XQpXduGN6v/SE4t1w775emr7lTOraZq/UUxcdOKLCLIPqgVOZzJjodsQopJmvCy/OQajlW/pNj+YET6N+8mTu/HiQx2eRr35b+G0nyes5VrK7/O3fhHEsfginVI0z0J+C0m1rIkUOUsW7phiII5S8Ml0Yo6oueB7VYjEn8FEtc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740355374; c=relaxed/simple;
	bh=n4VRozAU49BBd38yFZYM8j/lF67NbQ43AdFqChoMvHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9V+6zheZgYQY/QK0yE2bC9Ri204KwmI4iPFVHB0Cx7PS3lP/1U7qp7Ob+82WPqTQvWqn3Msn71wN6AwvfyEXBQW7pY0wfmGpw+J5K4O5bi452jMPON6WWfCVL8g0BqXvYMqX+3td9nB5Jf8IbhKL+Q7MAxLmccrt7fG6cKNyCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqgJGbZh; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbdf897503so839539166b.0;
        Sun, 23 Feb 2025 16:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740355370; x=1740960170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ku/meeX1O+81D6vyphMnaxR005xNcolriu4IkuswsD4=;
        b=OqgJGbZhBDjc8xjBJ5ETElETCtHXPoACIUAvC8oD/itdBib+Y+0+SR6qpAob3ac5gq
         O9OMUa9BVJ32RUb0+C5VAZTBabYMak2VUVWazuco4ywIZRi9z9MGuCl5EG/dcPYDZsf1
         m07aj2cj1GAbH7RB4wG8f6qtCjOqFHhD81fmnKTwe17t8y3nXjSTq4by9qt9B/38ysYZ
         EtQXxZYfDmQk0DJASx1k/BPHTy0shBOspFkej5hJzLdNEk3WI6rsgSQyZ1mMDZBfaOl7
         HSjW7r46NFK3ZIoEtR6RIZjK49RmxoubAzBBuDG/fH0AaZOISxkX/8NPSP/ivjV/ZY06
         xS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740355370; x=1740960170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku/meeX1O+81D6vyphMnaxR005xNcolriu4IkuswsD4=;
        b=bbAsDws67uchrXc4u8f6KkPNj6ktwFcVY5dodx07GFMBH++zKD0FCNUgAp0QRpfGxh
         dE2GrFirDmodCSMSfhPbRiB9DoN79UDzcW3Y9LvdQOZFy2VCK3LV3D48JjMqX48c05uy
         oyIzlbEow2ye6kJXTPavcK+L3ZcGB+EBiEDm1CTJYePYRsAaV03zLlmFz67ttOgKdvYF
         hZfSGkcWy9lAE08ZWAvbzru2jU2BC0e4+RiC7dUF8IiE34hzDZCnDOk+SpnyUDtEagWn
         7m0DwS7+FvQNWM/NOTn1GppgZdaiL6X/oXXwTiINrL0DHZaddtMT9UaX4VUneSNcQq7D
         UJ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFsLpNLkgn88jyPeBFN3DYeySOzNYvNW1Wk5oKd3Pr3xxdujPNkUTaKyQsAtrbk7Ei8pv2j+Jp1RqW@vger.kernel.org, AJvYcCX4yxSRDtRI5mcm43zI/+TkcquV1Xkti/diBzLSsmMky/KfRLt3IPRAKrB5Vh8m3Up7BkWv9g/X6fJ9Fsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPpYnzq1vbfosDIAM9zKlRezAQjxjiMThvB6XV50euPDSC20Rs
	6OwUHfzZfN3smJxuJLffJ8d6/ErjAFoz7j7qcLzXU8IEof11nmc9
X-Gm-Gg: ASbGnctNxImSjIvoSeTApsu1beLDblbObfSloh6vk49Zm2NUupx3tLfXRWaNUsotplV
	2R71UUHun2pOeTQ8LTr4cXpIQ7csUyx9WBuZNcxM3w6aAscgP1TKAO6PbVp97BltVX4ry3Y0Ltp
	of+tGgqC0WsLDpfht/0nrruGBdFs8E14/LigGJLR996PtdQVW4ytx+2ccYhXhumNSRjn4qNQQBy
	lez9q/BQWz66BPJsi4FFt8XWxSHMwPlGwwyUswMqsHjaMuuq+K7jUvX2MXv+wuWcyqNZJb/k2jD
	AQGX1kYQQDeK7iZR0ReIIcekO2e0FSrWzSCRWwxcdeA=
X-Google-Smtp-Source: AGHT+IEezF00syEetyw2uOFvXfJIUVrM6aVdCH+YKN/RJ7ZbZW8Kq5R8IfOagPhvDM35M21nT8zv/g==
X-Received: by 2002:a17:907:8a92:b0:abb:d047:960a with SMTP id a640c23a62f3a-abbeded95d8mr1320737166b.22.1740355370410;
        Sun, 23 Feb 2025 16:02:50 -0800 (PST)
Received: from foxbook (adqm166.neoplus.adsl.tpnet.pl. [79.185.146.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbaf6ec730sm1244665566b.163.2025.02.23.16.02.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 23 Feb 2025 16:02:50 -0800 (PST)
Date: Mon, 24 Feb 2025 01:02:45 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: "Neronin, Niklas" <niklas.neronin@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] usb: xhci: Clean up the TD skipping loop
Message-ID: <20250224010245.75ba1d2f@foxbook>
In-Reply-To: <be026374-91d2-4b1d-9eb7-568b376f6e72@linux.intel.com>
References: <20250210083718.2dd337c3@foxbook>
	<20250210083940.626c02d9@foxbook>
	<be026374-91d2-4b1d-9eb7-568b376f6e72@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Feb 2025 14:37:58 +0200, Neronin, Niklas wrote:
> This debug message is now misleading, the TD way or may not be found
> on non-isochronous.
> 
> Before:
> 	if (ep_seg && ep->skip)
> 		xhci_dbg(xhci, "Found td. ...
> After:
> 	if (ep->skip && (ep_seg || !isoc))
> 		xhci_dbg(xhci, "Found td. ...

Hmm, you're right, the whole block will now execute in this
pathological edge case and we will clear the flag too.

It can be fixed quite easily, but I think I may actually drop this
patch altogether. It will make the next patch slightly more verbose
(that's why I included this one), but it will also make it possible
to backport any of those patches to 6.12-lts if a need arises.

I also realized that one more skipping pathology is a recent (6.11)
regression and perhaps it too could be fixed without major rework,
basically by going back to something similar to pre-6.11 behavior.

I should have v3 ready in a day or a few.

Regards,
Michal

