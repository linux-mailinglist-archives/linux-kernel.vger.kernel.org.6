Return-Path: <linux-kernel+bounces-208908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A44902A80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F5E282354
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516B54750;
	Mon, 10 Jun 2024 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5aPov1L"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B9D210E7;
	Mon, 10 Jun 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054386; cv=none; b=X4e+NYe65MyjRkSxxaUUROrznqmhypUbYQ1QGBZB7a9U9jHzttR9qAvPG4mjNKPgPOM1XRENjWr3fo0rMvdTS3m6+FzIt/5T0dRxf+OyW0ZTV+R2su/VQnSTfFxt8Rb3yWt9RjSHz3yBFmOrNzySWHWqb0Z7yB8UnYrSQzov7ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054386; c=relaxed/simple;
	bh=FtdRUttpEY2am6yfvvMS6/NQ9twjSVWtoC+FNYI2FAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLb1dIwGIV5zOLrqLdbvEj9zwauvwBKnlRxCziz90JOCfQOKqltpRZa/gcup8wbrj8nPuJJrNM+88wLO6oF0Dg8rMpeBVjWrZZSJ3mfmejuBXxUjh8xSoe3kdZT1YEAbeKbA7KBpPQPgU1EISXqftSSp1/t3ni9ji2cWs3UqKt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5aPov1L; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso351301a91.2;
        Mon, 10 Jun 2024 14:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718054384; x=1718659184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtdRUttpEY2am6yfvvMS6/NQ9twjSVWtoC+FNYI2FAg=;
        b=c5aPov1L2oONfQ4k+7s0J2Zl+1S+JLLNWEGNUlB+y77yuiwRtmcxyoZGgrWarHAZr6
         5ewUoA5PMabAKTqG1l9iLJ38iQysRJG7XBjOjqRpWYR+XBQ2Xv3obkN1c1F3UChwQW5W
         IO5M5uY5JdCuhXCG0TFrxIU5EIKLqbWUCwKThSvyfsKLWePC0VztU7NYv1/HhIvFA6pB
         TQCZG8DEv9MTnA0EEsvzW3BaKHCUub9zaVE6TT1BGFHn4nLDy0VB/kWi6toUhAzaAbpp
         uhw/8m7tjcf2bLJK8K9sutZlo7ngADvXmXagZWoB3/BsYlJ/60yWHGtsVAcTzmFFyKXT
         lY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718054384; x=1718659184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtdRUttpEY2am6yfvvMS6/NQ9twjSVWtoC+FNYI2FAg=;
        b=JKjF5ccrsZO2vONIN812i1A3A5pp+vPuYE+Az4/uGuf2omXu3MIYuSUFHmhStL6KVF
         OugCJhCXtXeCi5wwlO9z/Q5MglDfB/SuZau26az1ijgiTigbUJpUqEASvrHeFcoVPuDD
         ZMeEOHPgHM41FHj5uxKR1/zdfadlL5QZjlT2s9G3GNi3ZopMUCgNFOuPyE2pUpkmROnz
         9UxZKG+2o0dwCwJY5Onrcv5bPmEezuYiycffzm8eiL3qkHK4jwg5+G/5xpbeGx+zOxD0
         KTyU9C/4Ij4S0GofswoWQVvwAeKHoIieqSUaVF43dIYhhmiI7DQHKF1POVpCk5/Hh2tC
         VPyA==
X-Forwarded-Encrypted: i=1; AJvYcCUd8ojnEs6jT/eoSJTmrVdpp5H4NL1JulkYxEBhKEJhopOnEsdix6C1R5B68nC5oOzH8n1VQPFYWSppOAkZ7OI2QL0H4ulMbFRth0OWk9VLq8x6aleLi4ydnfqUG2prAQ7DHJ8CGWEJbAo3VIQ=
X-Gm-Message-State: AOJu0Yxf9TxYGGqGRdm+O296wOZWBAbyWVTjhwJIhWN0iycaETmQwiRa
	Ge+4W5AT/bgO1Z1ftEqQjRqY2qxZKVn99PSMhHbHuNE+wOfIo5zX9+/FnzQS1GVh5nb3sGTNt9j
	jhrm3V392Mt5/JWGmyI+svtsydduafP6w/fc=
X-Google-Smtp-Source: AGHT+IHjDLQOcWNekU89fNyKyTc1fKWYn5FPRFpRv1SWgiR8+EA/jBDtKU90YCClM6+6s3vYGWfX1IpW6yxkuiF9G54=
X-Received: by 2002:a17:90a:c7d2:b0:2c2:cf61:34fb with SMTP id
 98e67ed59e1d1-2c2cf6135b5mr6918872a91.44.1718054384125; Mon, 10 Jun 2024
 14:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e0f5932-c7bc-4878-862c-1186cbecd71d@gmail.com>
 <5a8a6b44-9f89-4e26-869c-e9361da4cb5c@lunn.ch> <f798777d-6a56-45d4-8136-6aa9e0e77abc@gmail.com>
In-Reply-To: <f798777d-6a56-45d4-8136-6aa9e0e77abc@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Jun 2024 23:19:32 +0200
Message-ID: <CANiq72nbs0cqzfC15q7KXykjHMjkd3reLpZL5Pjx942Y6+bdew@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm: rust: Enable Rust support for ARMv7
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Sven Van Asbroeck <thesven73@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 9:37=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> Miguel how is the support handled for the other architectures?

The arch maintainers are the ones taking the patches through their
trees and so on (with the initial exception of x86).

Of course, if you want to contribute to that, that is great. If an
entry is wanted/needed, then a possibility is a sub-entry to the
architecture.

Cheers,
Miguel

